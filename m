Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB6AB9C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393491AbfIFNul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfIFNul (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35BA0883822;
        Fri,  6 Sep 2019 13:50:40 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22D335D9CA;
        Fri,  6 Sep 2019 13:50:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A94B6220292; Fri,  6 Sep 2019 09:50:32 -0400 (EDT)
Date:   Fri, 6 Sep 2019 09:50:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 15/18] virtiofs: Make virtio_fs object refcounted
Message-ID: <20190906135032.GD22083@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-16-vgoyal@redhat.com>
 <20190906120309.GW5900@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906120309.GW5900@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 13:50:40 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 01:03:09PM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 05, 2019 at 03:48:56PM -0400, Vivek Goyal wrote:
> > This object is used both by fuse_connection as well virt device. So make
> > this object reference counted and that makes it easy to define life cycle
> > of the object.
> > 
> > Now deivce can be removed while filesystem is still mounted. This will
> > cleanup all the virtqueues but virtio_fs object will still be around and
> > will be cleaned when filesystem is unmounted and sb/fc drops its reference.
> > 
> > Removing a device also stops all virt queues and any new reuqest gets
> > error -ENOTCONN. All existing in flight requests are drained before
> > ->remove returns.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 52 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 43 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 01bbf2c0e144..29ec2f5bbbe2 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -37,6 +37,7 @@ struct virtio_fs_vq {
> >  
> >  /* A virtio-fs device instance */
> >  struct virtio_fs {
> > +	struct kref refcount;
> >  	struct list_head list;    /* on virtio_fs_instances */
> >  	char *tag;
> >  	struct virtio_fs_vq *vqs;
> > @@ -63,6 +64,27 @@ static inline struct fuse_pqueue *vq_to_fpq(struct virtqueue *vq)
> >  	return &vq_to_fsvq(vq)->fud->pq;
> >  }
> >  
> > +static void release_virtiofs_obj(struct kref *ref)
> > +{
> > +	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
> > +
> > +	kfree(vfs->vqs);
> > +	kfree(vfs);
> > +}
> > +
> > +static void virtiofs_put(struct virtio_fs *fs)
> 
> Why do the two function names above contain "virtiofs" instead
> of "virtio_fs"?  I'm not sure if this is intentional and is supposed to
> mean something, but it's confusing.
> 
> > +{
> > +	mutex_lock(&virtio_fs_mutex);
> > +	kref_put(&fs->refcount, release_virtiofs_obj);
> > +	mutex_unlock(&virtio_fs_mutex);
> > +}
> > +
> > +static void virtio_fs_put(struct fuse_iqueue *fiq)
> 
> Minor issue: this function name is confusingly similar to
> virtiofs_put().  Please rename to virtio_fs_fiq_put().

Fixed with ->release semantics. Replaced "virtiofs" with "virtio_fs".


Subject: virtiofs: Make virtio_fs object refcounted

This object is used both by fuse_connection as well virt device. So make
this object reference counted and that makes it easy to define life cycle
of the object. 

Now deivce can be removed while filesystem is still mounted. This will
cleanup all the virtqueues but virtio_fs object will still be around and
will be cleaned when filesystem is unmounted and sb/fc drops its reference.

Removing a device also stops all virt queues and any new reuqest gets
error -ENOTCONN. All existing in flight requests are drained before
->remove returns.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c |   52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

Index: rhvgoyal-linux-fuse/fs/fuse/virtio_fs.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/fuse/virtio_fs.c	2019-09-06 09:24:21.177245246 -0400
+++ rhvgoyal-linux-fuse/fs/fuse/virtio_fs.c	2019-09-06 09:40:53.309245246 -0400
@@ -37,6 +37,7 @@ struct virtio_fs_vq {
 
 /* A virtio-fs device instance */
 struct virtio_fs {
+	struct kref refcount;
 	struct list_head list;    /* on virtio_fs_instances */
 	char *tag;
 	struct virtio_fs_vq *vqs;
@@ -63,6 +64,27 @@ static inline struct fuse_pqueue *vq_to_
 	return &vq_to_fsvq(vq)->fud->pq;
 }
 
+static void release_virtio_fs_obj(struct kref *ref)
+{
+	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
+
+	kfree(vfs->vqs);
+	kfree(vfs);
+}
+
+static void virtio_fs_put(struct virtio_fs *fs)
+{
+	mutex_lock(&virtio_fs_mutex);
+	kref_put(&fs->refcount, release_virtio_fs_obj);
+	mutex_unlock(&virtio_fs_mutex);
+}
+
+static void virtio_fs_fiq_release(struct fuse_iqueue *fiq)
+{
+	struct virtio_fs *vfs = fiq->priv;
+	virtio_fs_put(vfs);
+}
+
 static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
 {
 	WARN_ON(fsvq->in_flight < 0);
@@ -156,8 +178,10 @@ static struct virtio_fs *virtio_fs_find_
 	mutex_lock(&virtio_fs_mutex);
 
 	list_for_each_entry(fs, &virtio_fs_instances, list) {
-		if (strcmp(fs->tag, tag) == 0)
+		if (strcmp(fs->tag, tag) == 0) {
+			kref_get(&fs->refcount);
 			goto found;
+		}
 	}
 
 	fs = NULL; /* not found */
@@ -519,6 +543,7 @@ static int virtio_fs_probe(struct virtio
 	fs = kzalloc(sizeof(*fs), GFP_KERNEL);
 	if (!fs)
 		return -ENOMEM;
+	kref_init(&fs->refcount);
 	vdev->priv = fs;
 
 	ret = virtio_fs_read_tag(vdev, fs);
@@ -570,18 +595,18 @@ static void virtio_fs_remove(struct virt
 {
 	struct virtio_fs *fs = vdev->priv;
 
+	mutex_lock(&virtio_fs_mutex);
+	list_del_init(&fs->list);
+	mutex_unlock(&virtio_fs_mutex);
+
 	virtio_fs_stop_all_queues(fs);
 	virtio_fs_drain_all_queues(fs);
 	vdev->config->reset(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
 
-	mutex_lock(&virtio_fs_mutex);
-	list_del(&fs->list);
-	mutex_unlock(&virtio_fs_mutex);
-
 	vdev->priv = NULL;
-	kfree(fs->vqs);
-	kfree(fs);
+	/* Put device reference on virtio_fs object */
+	virtio_fs_put(fs);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -932,6 +957,7 @@ const static struct fuse_iqueue_ops virt
 	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
 	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
 	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
+	.release			= virtio_fs_fiq_release,
 };
 
 static int virtio_fs_fill_super(struct super_block *sb)
@@ -1026,7 +1052,9 @@ static void virtio_kill_sb(struct super_
 	fuse_kill_sb_anon(sb);
 
 	/* fuse_kill_sb_anon() must have sent destroy. Stop all queues
-	 * and drain one more time and free fuse devices.
+	 * and drain one more time and free fuse devices. Freeing fuse
+	 * devices will drop their reference on fuse_conn and that in
+	 * turn will drop its reference on virtio_fs object.
 	 */
 	virtio_fs_stop_all_queues(vfs);
 	virtio_fs_drain_all_queues(vfs);
@@ -1060,6 +1088,10 @@ static int virtio_fs_get_tree(struct fs_
 	struct fuse_conn *fc;
 	int err;
 
+	/* This gets a reference on virtio_fs object. This ptr gets installed
+	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
+	 * to drop the reference to this object.
+	 */
 	fs = virtio_fs_find_instance(fsc->source);
 	if (!fs) {
 		pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
@@ -1067,8 +1099,10 @@ static int virtio_fs_get_tree(struct fs_
 	}
 
 	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
-	if (!fc)
+	if (!fc) {
+		virtio_fs_put(fs);
 		return -ENOMEM;
+	}
 
 	fuse_conn_init(fc, get_user_ns(current_user_ns()), &virtio_fs_fiq_ops,
 		       fs);
