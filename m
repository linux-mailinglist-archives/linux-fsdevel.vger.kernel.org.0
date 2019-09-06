Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C853AB95A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405132AbfIFNgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38281 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391482AbfIFNgE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 821DD301D67F;
        Fri,  6 Sep 2019 13:36:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2CF1001947;
        Fri,  6 Sep 2019 13:35:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1F167220292; Fri,  6 Sep 2019 09:35:55 -0400 (EDT)
Date:   Fri, 6 Sep 2019 09:35:55 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 14/18] virtiofs: Add a fuse_iqueue operation to put()
 reference
Message-ID: <20190906133555.GC22083@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-15-vgoyal@redhat.com>
 <20190906120009.GV5900@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906120009.GV5900@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 06 Sep 2019 13:36:03 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 01:00:09PM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 05, 2019 at 03:48:55PM -0400, Vivek Goyal wrote:
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 85e2dcad68c1..04e2c000d63f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -479,6 +479,11 @@ struct fuse_iqueue_ops {
> >  	 */
> >  	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
> >  		__releases(fiq->waitq.lock);
> > +
> > +	/**
> > +	 * Put a reference on fiq_priv.
> 
> I'm a bit confused about fiq->priv's role in this.  The callback takes
> struct fuse_iqueue *fiq as the argument, not void *priv, so it could
> theoretically do more than just release priv.
> 
> I think one of the following would be clearer:
> 
>  /**
>   * Drop a reference to fiq->priv.
>   */
>  void (*put_priv)(void *priv);
> 
> Or:
> 
>  /**
>   * Clean up when fuse_iqueue is destroyed.
>   */
>  void (*release)(struct fuse_iqueue *fiq);
> 
> In the second case fuse_conn_put() shouldn't check fiq->priv.

Hi Stefan,

I like using ->release() method sounds better. Here is the updated patch.
This also changes the next patch, so will post that as well.

Thanks
Vivek

Subject: virtiofs: Add a fuse_iqueue operation to put() reference

Soon I will make virtio_fs object reference counted, where reference will
be taken by device as well as by fuse_conn (fuse_conn->fuse_iqueue->fiq_priv).

When fuse_connection is going away, it should put its reference on virtio_fs
object.

So add a fuse_iqueue method which can be used to call into virtio_fs to
put the reference on the object (fiq_priv).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h |    5 +++++
 fs/fuse/inode.c  |    4 ++++
 2 files changed, 9 insertions(+)

Index: rhvgoyal-linux-fuse/fs/fuse/fuse_i.h
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/fuse/fuse_i.h	2019-09-06 08:46:41.846086544 -0400
+++ rhvgoyal-linux-fuse/fs/fuse/fuse_i.h	2019-09-06 09:24:32.752245246 -0400
@@ -479,6 +479,11 @@ struct fuse_iqueue_ops {
 	 */
 	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
 		__releases(fiq->waitq.lock);
+
+	/**
+	 * Cleanup up when fuse_iqueue is destroyed
+	 */
+	void (*release)(struct fuse_iqueue *fiq);
 };
 
 /** /dev/fuse input queue operations */
Index: rhvgoyal-linux-fuse/fs/fuse/inode.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/fuse/inode.c	2019-09-06 08:46:41.847086544 -0400
+++ rhvgoyal-linux-fuse/fs/fuse/inode.c	2019-09-06 09:24:32.754245246 -0400
@@ -631,8 +631,12 @@ EXPORT_SYMBOL_GPL(fuse_conn_init);
 void fuse_conn_put(struct fuse_conn *fc)
 {
 	if (refcount_dec_and_test(&fc->count)) {
+		struct fuse_iqueue *fiq = &fc->iq;
+
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		if (fiq->ops->release)
+			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
 		put_user_ns(fc->user_ns);
 		fc->release(fc);


