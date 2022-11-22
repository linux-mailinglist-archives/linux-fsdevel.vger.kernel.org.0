Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF696332EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiKVCQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKVCQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:16:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED59E3D37
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36fc0644f51so130684027b3.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2q3Pe5xMPw4X/9LVfd4DivdDutjiK3KnsX8KQ2N8hg=;
        b=aTBA/4JqNfwuIeF/z6qbwtHTisSmHirpljRg/jqvop/zWE55jxwONCGDNplDOvHIUW
         EdpMWtBWdM/Q73DKy22ZiPzuWMZIje8JjbI6oo1SzHSUA74BDWub9IHwW0c1jTUAMbyG
         qOkCaE9aSL9MCjO6dYMB9PFb0aSX8Hfbqe2UBhcL5iq8ZkRxKNPjQ5ioSBSVeFYk0Qqm
         Z6DISHRrhTLBKncu7nRqFeA8S3zpz179cTjAmXPcklE8oU9QjNuSHkGrM1Ep/EIROqyT
         +Xu7VQDk/YnBsHGQZGJERKD3mSGCPFH4bds3NFKtzGnpePnm86694b/7JnzRw2PKb2tW
         dKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2q3Pe5xMPw4X/9LVfd4DivdDutjiK3KnsX8KQ2N8hg=;
        b=kysDvy38En3XimVrZPXdHP4DW/capMnl4fZ/0p7oUp7CWN/Qc7AQ/anMQWDC6XRYBn
         Zmfg0zoCdadZdNfZ0GwKjpnmgFxV8czE/BQ0ezBCoN+hLPjTLnBbFufHMf42voDhqREA
         +RjlBiijNVSSCXOl2ddKjngE8RzSDaKH9fRkyrvgxy9yQt43CgmCwJIo5OpGnEJyKtJg
         G/ls68bcMPllW19eZ7HdqotmX7mF0LDqHmJ8arHQIbtRxpLpRbTycN3OPB7KUDJ5m4yc
         kCzKYl5qApyKaBBGvsqI+CW3xNlK7PCNb+5TbLoeB1XZVppd2TUUlMCCztK6Dnzh5BWI
         ZJHQ==
X-Gm-Message-State: ANoB5pm9+I220oaYmRv49Ggj0sYl/6J79JZ5zLsoV8MLRHoydktodzct
        l/reMhrvJ3YlSCrpM1ov/cdebfotJnY=
X-Google-Smtp-Source: AA0mqf56By5tkbMPbE3+8HlVejJa2CcHXpyOQFp8e5Hw5P5xL8vmWpfR7zoKgiNxYfs8ibJqKjx+X/YrEyo=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a81:47c2:0:b0:388:7d2:587b with SMTP id
 u185-20020a8147c2000000b0038807d2587bmr3633337ywa.416.1669083365933; Mon, 21
 Nov 2022 18:16:05 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:20 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-6-drosen@google.com>
Subject: [RFC PATCH v2 05/21] fuse-bpf: Add ioctl interface for /dev/fuse
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces an alternative method of responding to fuse requests.
Lookups supplying a backing fd or bpf will need to call through the
ioctl to ensure there can be no attempts to fool priveledged processes
into inadvertantly performing other actions.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/dev.c             | 56 ++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h          |  1 +
 include/uapi/linux/fuse.h |  1 +
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 79d2fb6adc83..fbc519c37e66 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1013,18 +1013,19 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 
 /* Copy the fuse-bpf lookup args and verify them */
 #ifdef CONFIG_FUSE_BPF
-static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+static int fuse_copy_lookup(struct fuse_copy_state *cs, unsigned via_ioctl, void *val, unsigned size)
 {
 	struct fuse_bpf_entry_out *fbeo = (struct fuse_bpf_entry_out *)val;
 	struct fuse_bpf_entry *feb = container_of(fbeo, struct fuse_bpf_entry, out[0]);
 	int num_entries = size / sizeof(*fbeo);
 	int err;
 
-	if (size && size % sizeof(*fbeo) != 0)
+	if (size && (size % sizeof(*fbeo) != 0 || !via_ioctl))
 		return -EINVAL;
 
 	if (num_entries > FUSE_BPF_MAX_ENTRIES)
 		return -EINVAL;
+
 	err = fuse_copy_one(cs, val, size);
 	if (err)
 		return err;
@@ -1033,7 +1034,7 @@ static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size
 	return err;
 }
 #else
-static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+static int fuse_copy_lookup(struct fuse_copy_state *cs, unsigned via_ioctl, void *val, unsigned size)
 {
 	return fuse_copy_one(cs, val, size);
 }
@@ -1042,7 +1043,7 @@ static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing, unsigned is_lookup)
+			  int zeroing, unsigned is_lookup, unsigned via_ioct)
 {
 	int err = 0;
 	unsigned i;
@@ -1052,7 +1053,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 		if (i == numargs - 1 && argpages)
 			err = fuse_copy_pages(cs, arg->size, zeroing);
 		else if (i == numargs - 1 && is_lookup)
-			err = fuse_copy_lookup(cs, arg->value, arg->size);
+			err = fuse_copy_lookup(cs, via_ioct, arg->value, arg->size);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1330,7 +1331,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
-				     (struct fuse_arg *) args->in_args, 0, 0);
+				     (struct fuse_arg *) args->in_args, 0, 0, 0);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
@@ -1869,7 +1870,8 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		lastarg->size -= diffsize;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-			      args->out_args, args->page_zeroing, args->is_lookup);
+			      args->out_args, args->page_zeroing, args->is_lookup,
+			      args->via_ioctl);
 }
 
 /*
@@ -1879,7 +1881,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
  * it from the list and copy the rest of the buffer to the request.
  * The request is finished by calling fuse_request_end().
  */
-static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
+static ssize_t fuse_dev_do_write(struct fuse_dev *fud, bool from_ioctl,
 				 struct fuse_copy_state *cs, size_t nbytes)
 {
 	int err;
@@ -1951,6 +1953,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (!req->args->page_replace)
 		cs->move_pages = 0;
 
+	req->args->via_ioctl = from_ioctl;
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
 	else
@@ -1989,7 +1992,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 
 	fuse_copy_init(&cs, 0, from);
 
-	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
+	return fuse_dev_do_write(fud, false, &cs, iov_iter_count(from));
 }
 
 static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
@@ -2070,7 +2073,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (flags & SPLICE_F_MOVE)
 		cs.move_pages = 1;
 
-	ret = fuse_dev_do_write(fud, &cs, len);
+	ret = fuse_dev_do_write(fud, false, &cs, len);
 
 	pipe_lock(pipe);
 out_free:
@@ -2283,6 +2286,33 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
+// Provides an alternate means to respond to a fuse request
+static int fuse_handle_ioc_response(struct fuse_dev *dev, void *buff, uint32_t size)
+{
+	struct fuse_copy_state cs;
+	struct iovec *iov = NULL;
+	struct iov_iter iter;
+	int res;
+
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+	iov = (struct iovec *) __get_free_page(GFP_KERNEL);
+	if (!iov)
+		return -ENOMEM;
+
+	iov->iov_base = buff;
+	iov->iov_len = size;
+
+	iov_iter_init(&iter, READ, iov, 1, size);
+	fuse_copy_init(&cs, 0, &iter);
+
+
+	res = fuse_dev_do_write(dev, true, &cs, size);
+	free_page((unsigned long) iov);
+
+	return res;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2316,6 +2346,12 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 	default:
+		if (_IOC_TYPE(cmd) == FUSE_DEV_IOC_MAGIC
+				&& _IOC_NR(cmd) == _IOC_NR(FUSE_DEV_IOC_BPF_RESPONSE(0))
+				&& _IOC_DIR(cmd) == _IOC_WRITE) {
+			res = fuse_handle_ioc_response(fuse_get_dev(file), (void *) arg, _IOC_SIZE(cmd));
+			break;
+		}
 		res = -ENOTTY;
 		break;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d67325af5e72..3452530aba94 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -314,6 +314,7 @@ struct fuse_args {
 	bool page_replace:1;
 	bool may_block:1;
 	bool is_lookup:1;
+	bool via_ioctl:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 0e19076729d9..e49e5a8e044c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -972,6 +972,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_BPF_RESPONSE(N) _IOW(FUSE_DEV_IOC_MAGIC, 125, char[N])
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.38.1.584.g0f3c55d4c2-goog

