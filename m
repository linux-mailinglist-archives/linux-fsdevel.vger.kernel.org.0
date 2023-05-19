Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA097097D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjESM6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjESM6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE54F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3063891d61aso3089407f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501047; x=1687093047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NtouwrutgEwNDuf2MOZ2GRPT1+Ogpzjs3DqxXesgZU=;
        b=aJKBiaGwTLXEItqnnu2syNMyD2AxGVDrwajgvvz7lyqvE4veb8wLjW3OawbmGPMQPI
         cWDoBzKBSPwHvaN/m0kUZhVEdRZYCLff+0PHV4jARq/Y0+oYRiPsspplqc9Yj/ikTNrt
         eAhVdPhG31L8Ix3yA/mjTyIZCWZnHQgwZxOrNUGfgSh2x2NpayBW3KgcdKgGbc7oHZ7Z
         x0iFnR1n+ewTqEl1rV7FPQwa0w+pBiXrysqF+ITJfkax+NvTFqIjISlVNWGAlsxgMRxk
         bu2eAcmbljuoQfr5jqSM2Wpr5TIts1uzVeYp2eD9Z6wlvxtK7WYpcIRBN16+6WUE8h9P
         +wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501047; x=1687093047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NtouwrutgEwNDuf2MOZ2GRPT1+Ogpzjs3DqxXesgZU=;
        b=PNq5EVoViz0yJf/sakF2kgI9W0vZ5SrxYe1jXp1P6ZNJgsYEkD6jx26absWwt5p/me
         2VwGcQ3jGLDJs6JAuCnzZJhYVgKeOMlRz8lClMz5XVB3rXd98OXyPqDTEDFo7iMoV9LV
         h4K29d995KGfoTTdDgPGY+Ar0qAc1TBwTNNomiJUBDY4ujkGLXcpf74qgyPR/3+YDswz
         vj5jN071ocJPIcNnppoC8F6KkM90h89s/MpQ3zTBm5obAZBVcgbPCdKPlroMCMjOv9Hr
         vmJUxTPMTFQ3Cjiggs1keb8em3rU1PErunBy0EeYUMZClkOGqNW4PuRJoicozyZ5Jdyz
         /pAg==
X-Gm-Message-State: AC+VfDycR9KPEKMZMcA5IjM3R+jo21+yXxYgk2aSFC+p8cDDgdQOSwYG
        xR7JT/EQphatj5hLMHSW2Nk=
X-Google-Smtp-Source: ACHHUZ66aynbt1uDkwlc6cjqEcUoiSOjjKdDcYYvgwxVTlONRhnbumBlCPmyjPbVDA/VGrqlbPS2GA==
X-Received: by 2002:adf:e945:0:b0:309:3a83:cf43 with SMTP id m5-20020adfe945000000b003093a83cf43mr1551415wrn.27.1684501046569;
        Fri, 19 May 2023 05:57:26 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 10/10] fuse: setup a passthrough fd without a permanent backing id
Date:   Fri, 19 May 2023 15:57:05 +0300
Message-Id: <20230519125705.598234-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
References: <20230519125705.598234-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WIP

Add an ioctl to associate a FUSE server open fd with a request.
A later response to this request get use the FOPEN_PASSTHROUGH flag
to request passthrough to the associated backing file.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

After implementing refcounted backing files, I started to think how
to limit the server from mapping too many files.

I wanted to limit the backing files mappings to the number of open fuse
files to simplify backing files accounting (i.e. open files are
effectively accounted to clients).

It occured to me that creatig a 1-to-1 mapping between fuse files and
backing file ids is quite futile if there is no need to manage 1-to-many
backing file mappings.

If only 1-to-1 mapping is desired, the proposed ioctl associates a
backing file with a pending request.  The backing file will be kept
open for as long the request lives, or until its refcount is handed
over to the client, which can then use it to setup passthough to the
backing file without the intermediate idr array.

I have not implemented the full hand over yet, because I wanted to
hear your feedback first.

Thanks,
Amir.


 fs/fuse/dev.c             | 45 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          | 16 +++++++++-----
 fs/fuse/passthrough.c     | 12 ++++++++++-
 include/uapi/linux/fuse.h |  8 +++++++
 4 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cb00234e7843..01fb9c5411d2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -61,6 +61,8 @@ static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
 
 static void fuse_request_free(struct fuse_req *req)
 {
+	if (test_bit(FR_PASSTHROUGH, &req->flags))
+		fuse_passthrough_put(req->fpt);
 	kmem_cache_free(fuse_req_cachep, req);
 }
 
@@ -2251,6 +2253,43 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
+// Associate an passthrough fd to a fuse request
+static int fuse_handle_ioc_passthrough_setup(struct fuse_dev *fud,
+				struct fuse_passthrough_setup_in __user *arg)
+{
+	struct fuse_pqueue *fpq = &fud->pq;
+	struct fuse_req *req;
+	struct fuse_passthrough_setup_in fpts;
+	struct fuse_passthrough *fpt;
+	int err;
+
+	if (copy_from_user(&fpts, arg, sizeof(fpts)))
+		return -EFAULT;
+
+	if (fpts.padding)
+		return -EINVAL;
+
+	err = fuse_passthrough_open(fud->fc, fpts.fd, &fpt);
+	if (err)
+		return err;
+
+	spin_lock(&fpq->lock);
+	req = NULL;
+	if (fpq->connected)
+		req = request_find(fpq, fpts.unique);
+	if (req) {
+		__set_bit(FR_PASSTHROUGH, &req->flags);
+		req->fpt = fpt;
+	}
+	spin_unlock(&fpq->lock);
+	if (!req) {
+		fuse_passthrough_put(fpt);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2291,7 +2330,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (!f.file)
 			return -EINVAL;
 
-		res = fuse_passthrough_open(fud->fc, fd);
+		res = fuse_passthrough_open(fud->fc, fd, NULL);
 		fdput(f);
 		break;
 	case FUSE_DEV_IOC_PASSTHROUGH_CLOSE:
@@ -2300,6 +2339,10 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 
 		res = fuse_passthrough_close(fud->fc, id);
 		break;
+	case FUSE_DEV_IOC_PASSTHROUGH_SETUP:
+		res = fuse_handle_ioc_passthrough_setup(fud,
+			   (struct fuse_passthrough_setup_in __user *)arg);
+		break;
 	default:
 		res = -ENOTTY;
 		break;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 238a43349298..085d7607ba6e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -332,6 +332,7 @@ struct fuse_io_priv {
  * FR_FINISHED:		request is finished
  * FR_PRIVATE:		request is on private list
  * FR_ASYNC:		request is asynchronous
+ * FR_PASSTHROUGH:	request is associated with passthrough file
  */
 enum fuse_req_flag {
 	FR_ISREPLY,
@@ -346,6 +347,7 @@ enum fuse_req_flag {
 	FR_FINISHED,
 	FR_PRIVATE,
 	FR_ASYNC,
+	FR_PASSTHROUGH,
 };
 
 /**
@@ -385,10 +387,13 @@ struct fuse_req {
 	/** Used to wake up the task waiting for completion of request*/
 	wait_queue_head_t waitq;
 
-#if IS_ENABLED(CONFIG_VIRTIO_FS)
-	/** virtio-fs's physically contiguous buffer for in and out args */
-	void *argbuf;
-#endif
+	union {
+		/** virtio-fs's physically contiguous buffer for in/out args */
+		void *argbuf;
+
+		/** passthrough file associated with request */
+		struct fuse_passthrough *fpt;
+	};
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
@@ -1347,7 +1352,8 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
 /* passthrough.c */
-int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd);
+int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd,
+			  struct fuse_passthrough **pfpt);
 int fuse_passthrough_close(struct fuse_conn *fc, int passthrough_fh);
 int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 			   struct fuse_open_out *openarg);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 2b745b6b2364..85a1d72b1666 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -216,8 +216,12 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 /*
  * Returns passthrough_fh id that can be passed with FOPEN_PASSTHROUGH
  * open response and needs to be released with fuse_passthrough_close().
+ *
+ * When @pfpt is non-NULL, an anonynous passthrough handle is returned
+ * via *pfpt on success and the return value is 0.
  */
-int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd)
+int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd,
+			  struct fuse_passthrough **pfpt)
 {
 	struct file *passthrough_filp;
 	struct inode *passthrough_inode;
@@ -252,6 +256,12 @@ int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd)
 	passthrough->cred = prepare_creds();
 	refcount_set(&passthrough->count, 1);
 
+	if (pfpt) {
+		/* Return an anonynous passthrough handle */
+		*pfpt = passthrough;
+		return 0;
+	}
+
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
 	res = idr_alloc_cyclic(&fc->passthrough_files_map, passthrough, 1, 0,
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 3da1f59007cf..028a65fe3fa2 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -993,11 +993,19 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_passthrough_setup_in {
+	uint64_t	unique;
+	uint32_t        fd;
+	uint32_t        padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_PASSTHROUGH_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, uint32_t)
 #define FUSE_DEV_IOC_PASSTHROUGH_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_PASSTHROUGH_SETUP	_IOW(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_passthrough_setup_in)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1

