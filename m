Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A099B37937E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhEJQQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 12:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231388AbhEJQQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 12:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620663328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86rcIshw9cDmoW+VtXKAITdjVKRMuJkwFzrDaNXTYfk=;
        b=fnKY7/ZZOFgY76HTZGSbCoqh0kr8AgmNVSZkvM53SP2drPrBphmUvoEGO43GwYj8RudF7W
        1LppZqRE+rsgdY6ufpyjQ0BsPof7aDYtVZBXH0Rk1+RzpFXOEw1km7Uv9KUOyK5x4i8pDn
        2w8rP5QyOKubqcmG64cE1ga1ferETUw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-TRfbnkwQN76FBvKTz0Wp5A-1; Mon, 10 May 2021 12:15:27 -0400
X-MC-Unique: TRfbnkwQN76FBvKTz0Wp5A-1
Received: by mail-ot1-f69.google.com with SMTP id h28-20020a056830035cb02902a5ea00385cso11443418ote.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 09:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=86rcIshw9cDmoW+VtXKAITdjVKRMuJkwFzrDaNXTYfk=;
        b=L/aS4UCxC3pVIvgx4GeumTq2aqBF5I78lrJf2xh71H6BP502NUJ1HakSLltjNFVD45
         pcpyGvOP6GMuPT6gcvYk/GWDoUOBy5ZqQaW1M2a6KlOo/sf7ce2qzlGI+FYd/O5STLXD
         K5d6Lc7WxLHTPUkIAIWBnFlexlBBMOWrOnPE9SGBDlXQgPlBTytL7b62asOypt2gQe8o
         ooAzUfDbNEQ+fhJfEKL+d0oScJ+zcAmvLetYEymtfoqOlURsWAzTPaZR8AX7MPrkkPWO
         VRNDrO9xkBb5TM5x0lLmchduic5CpHiewRtnV6gdDvZ2kdtW3PKNiS2yO2wfCkQrqIfJ
         84dg==
X-Gm-Message-State: AOAM533rfUFBnDvRGRsxLnXPFnlB775MonR7ICqZXve5PXcT/wFkp4+3
        q/pAFURBnPWSa3Sy9t+K33rh6BCvtuslGRyjn6kymJn9YuTpYQS8c5yNtBCV2BYR0DvIaLMYrwx
        UcfaFrdvaVO2JDtL8CG6PZ4H7hw==
X-Received: by 2002:a4a:b102:: with SMTP id a2mr19581170ooo.30.1620663323249;
        Mon, 10 May 2021 09:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXn4dxJwD2+F37cdWtrOVB82OjneuN53qJUKHPKYoEcezSuJ9WvB4HOVkybYV991ZFC2n5gg==
X-Received: by 2002:a4a:b102:: with SMTP id a2mr19581149ooo.30.1620663322958;
        Mon, 10 May 2021 09:15:22 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id s6sm1245478otk.71.2021.05.10.09.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 09:15:22 -0700 (PDT)
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20210507221527.699516-1-ckuehl@redhat.com>
 <20210510152506.GC150402@horse>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <ddbc96c7-655c-e563-e26e-6550a0cdd7c1@redhat.com>
Date:   Mon, 10 May 2021 11:15:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510152506.GC150402@horse>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/21 10:25 AM, Vivek Goyal wrote:
> On Fri, May 07, 2021 at 03:15:27PM -0700, Connor Kuehl wrote:
>> Distribute requests across the multiqueue complex automatically based
>> on the IRQ affinity.
> 
> Hi Connor,
> 
> Thanks for the patch. I will look into it and also test it.
> 
> How did you test it? Did you modify vitiofsd to support multiqueue. Did
> you also run some performance numbers. Does it provide better/worse
> performance as compared to single queue.

Thanks, Vivek! I need to NACK this version of the patch for inclusion
though since I think the way I did per-CPU state will not work for
multiple virtio-fs mounts because it will be overwritten with each new
mount, but for testing purposes this should be OK with just one mount.

I need to do more benchmarking on this.

I had to hack multiqueue support into virtiofsd, which runs against the
warning in the virtiofsd source code that instructs people to *not*
enable multiqueue due to thread-safety concerns. I didn't audit
virtiofsd for correctness, so I also worry this has the potential of
affecting benchmarks if there are races.

For testing, QEMU needs to be invoked with `num-request-queues` like
this:

	-device vhost-user-fs-pci,chardev=char0,tag=myfs,num-request-queues=2 

And obviously you can choose any value >= 1 for num-request-queues.

and I also made a quick-and-dirty hack to let me pass in the number of
total queues to virtiofsd on the command line:

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 58e32fc963..cf8f132efd 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2565,9 +2565,9 @@ out1:
     return NULL;
 }
 
-int fuse_session_mount(struct fuse_session *se)
+int fuse_session_mount(struct fuse_session *se, unsigned int num_queues)
 {
-    return virtio_session_mount(se);
+    return virtio_session_mount(se, num_queues);
 }
 
 int fuse_session_fd(struct fuse_session *se)
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index 3bf786b034..50bf86113d 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1842,7 +1842,7 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
  *
  * @return 0 on success, -1 on failure.
  **/
-int fuse_session_mount(struct fuse_session *se);
+int fuse_session_mount(struct fuse_session *se, unsigned int num_queues);
 
 /**
  * Enter a single threaded, blocking event loop.
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 3e13997406..8622c3dce6 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -747,20 +747,6 @@ static void fv_queue_set_started(VuDev *dev, int qidx, bool started)
              started);
     assert(qidx >= 0);
 
-    /*
-     * Ignore additional request queues for now.  passthrough_ll.c must be
-     * audited for thread-safety issues first.  It was written with a
-     * well-behaved client in mind and may not protect against all types of
-     * races yet.
-     */
-    if (qidx > 1) {
-        fuse_log(FUSE_LOG_ERR,
-                 "%s: multiple request queues not yet implemented, please only "
-                 "configure 1 request queue\n",
-                 __func__);
-        exit(EXIT_FAILURE);
-    }
-
     if (started) {
         /* Fire up a thread to watch this queue */
         if (qidx >= vud->nqueues) {
@@ -997,7 +983,7 @@ static int fv_create_listen_socket(struct fuse_session *se)
     return 0;
 }
 
-int virtio_session_mount(struct fuse_session *se)
+int virtio_session_mount(struct fuse_session *se, unsigned int num_queues)
 {
     int ret;
 
@@ -1048,8 +1034,8 @@ int virtio_session_mount(struct fuse_session *se)
     se->vu_socketfd = data_sock;
     se->virtio_dev->se = se;
     pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
-    if (!vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
-                 fv_set_watch, fv_remove_watch, &fv_iface)) {
+    if (!vu_init(&se->virtio_dev->dev, num_queues, se->vu_socketfd,
+		 fv_panic, NULL, fv_set_watch, fv_remove_watch, &fv_iface)) {
         fuse_log(FUSE_LOG_ERR, "%s: vu_init failed\n", __func__);
         return -1;
     }
diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
index 111684032c..a0e78b9b84 100644
--- a/tools/virtiofsd/fuse_virtio.h
+++ b/tools/virtiofsd/fuse_virtio.h
@@ -18,7 +18,7 @@
 
 struct fuse_session;
 
-int virtio_session_mount(struct fuse_session *se);
+int virtio_session_mount(struct fuse_session *se, unsigned int num_queues);
 void virtio_session_close(struct fuse_session *se);
 int virtio_loop(struct fuse_session *se);
 
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 1553d2ef45..9fd4e34980 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -161,6 +161,7 @@ struct lo_data {
     int allow_direct_io;
     int announce_submounts;
     bool use_statx;
+    int num_vqs;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
@@ -204,6 +205,7 @@ static const struct fuse_opt lo_opts[] = {
     { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
     { "killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 1 },
     { "no_killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 0 },
+    { "num_queues=%d", offsetof(struct lo_data, num_vqs), 2 },
     FUSE_OPT_END
 };
 static bool use_syslog = false;
@@ -3848,6 +3850,12 @@ int main(int argc, char *argv[])
         exit(1);
     }
 
+    if (lo.num_vqs < 2) {
+        fuse_log(FUSE_LOG_ERR, "num_queues must be at least 2 (got %d)\n",
+                 lo.num_vqs);
+        exit(1);
+    }
+
     lo.use_statx = true;
 
     se = fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
@@ -3859,7 +3867,7 @@ int main(int argc, char *argv[])
         goto err_out2;
     }
 
-    if (fuse_session_mount(se) != 0) {
+    if (fuse_session_mount(se, lo.num_vqs) != 0) {
         goto err_out3;
     }
 

