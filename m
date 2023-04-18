Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D026E56AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDRBmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDRBlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C872A0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l124-20020a252582000000b00b8f5572bcdaso12291272ybl.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782071; x=1684374071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w19M7mxJAre5VfcOLhOZhg9JC6HtCZspBwvR3oTaBtM=;
        b=O/uzOqnDmS58QEJVz0T7PNXTX0Mtqd93rP+7E7na6jJ7QBcC3+3JWqA624W+JCI64R
         g5UeaSIEQ2e9zoM9bLjzbRQ4TX4IcKtelfNTRYpmePqs0g/0s18ad9gEBxKqugTmTnXJ
         LzySXi8ehZLsjwTOWb1Bm2cDRdGh9W+hMegnr4ssDEOtKk1HcW9S90nfvbwuqyU9afp8
         r/LRBntSZet4HdYZYg9L+SpnqePNzq+J51zllKN3K7oc10u2cosiIPhI7KlqZt97mhR3
         m9YfjttiB71iUr6bziRAvbTY79chCtR9d3tTTN8GEdsXPPkdN4l+BdlYow6MfQfY3GLw
         IdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782071; x=1684374071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w19M7mxJAre5VfcOLhOZhg9JC6HtCZspBwvR3oTaBtM=;
        b=aJf5bel3u7mYOevBIT6FB72jnRCzqw8GljY2430uqVGxwXGaiOJFOw5OW/oJDT/tYI
         7kIvgELr/jo5LFxZBuo75qme3VemwVDkDTKJ/4OEi3SbNa1/3TjZf45BM/X2jTMCMu/2
         1NmXfqoXMIPE2BXjZsqYKz6kb8wxrV24wqosiLxQfGINzYeO7zW04fKZZdU2wf+JoaHf
         cAPsnPg4nZiQbGbWuesSfuuz1g1vixk1zDMLxdBpsfYxe7QEyy7JzaWu/DIkTAHGgTnQ
         3EWr2C0c6s5/MhhzP5P0uJ0r1bOk0ObHKjJ3rnBAK5WP4qFLDc3OSj6O51bkbPzCu6Lt
         Lv6g==
X-Gm-Message-State: AAQBX9c+52icABWZhcbjAWMPgMEI4dr2Qh4rrYxFhCz0VdrKO0rjDKPn
        cy3Y4LVfadqSs8Q2SO62KDgW9InEV8w=
X-Google-Smtp-Source: AKy350YsucDg8BHeY6V0IoVOR0pulMc5pZV3Sps9tjCFUe04Pre+til+90iCxm0xGbwDMnHRM3ERPECUwNE=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:cbd5:0:b0:b95:630:197b with SMTP id
 b204-20020a25cbd5000000b00b950630197bmr691791ybg.10.1681782071432; Mon, 17
 Apr 2023 18:41:11 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:09 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-10-drosen@google.com>
Subject: [RFC PATCH v3 09/37] fuse-bpf: Add ioctl interface for /dev/fuse
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index a3029824c24f..ad7d9d1e6da5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1016,18 +1016,19 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 
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
@@ -1036,7 +1037,7 @@ static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size
 	return err;
 }
 #else
-static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+static int fuse_copy_lookup(struct fuse_copy_state *cs, unsigned via_ioctl, void *val, unsigned size)
 {
 	return fuse_copy_one(cs, val, size);
 }
@@ -1045,7 +1046,7 @@ static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing, unsigned is_lookup)
+			  int zeroing, unsigned is_lookup, unsigned via_ioct)
 {
 	int err = 0;
 	unsigned i;
@@ -1055,7 +1056,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 		if (i == numargs - 1 && argpages)
 			err = fuse_copy_pages(cs, arg->size, zeroing);
 		else if (i == numargs - 1 && is_lookup)
-			err = fuse_copy_lookup(cs, arg->value, arg->size);
+			err = fuse_copy_lookup(cs, via_ioct, arg->value, arg->size);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1333,7 +1334,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
-				     (struct fuse_arg *) args->in_args, 0, 0);
+				     (struct fuse_arg *) args->in_args, 0, 0, 0);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
@@ -1872,7 +1873,8 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		lastarg->size -= diffsize;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-			      args->out_args, args->page_zeroing, args->is_lookup);
+			      args->out_args, args->page_zeroing, args->is_lookup,
+			      args->via_ioctl);
 }
 
 /*
@@ -1882,7 +1884,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
  * it from the list and copy the rest of the buffer to the request.
  * The request is finished by calling fuse_request_end().
  */
-static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
+static ssize_t fuse_dev_do_write(struct fuse_dev *fud, bool from_ioctl,
 				 struct fuse_copy_state *cs, size_t nbytes)
 {
 	int err;
@@ -1954,6 +1956,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (!req->args->page_replace)
 		cs->move_pages = 0;
 
+	req->args->via_ioctl = from_ioctl;
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
 	else
@@ -1992,7 +1995,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 
 	fuse_copy_init(&cs, 0, from);
 
-	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
+	return fuse_dev_do_write(fud, false, &cs, iov_iter_count(from));
 }
 
 static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
@@ -2073,7 +2076,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (flags & SPLICE_F_MOVE)
 		cs.move_pages = 1;
 
-	ret = fuse_dev_do_write(fud, &cs, len);
+	ret = fuse_dev_do_write(fud, false, &cs, len);
 
 	pipe_lock(pipe);
 out_free:
@@ -2286,6 +2289,33 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
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
@@ -2318,6 +2348,12 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
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
index c24878f4a89f..39a9fdf2a752 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -316,6 +316,7 @@ struct fuse_args {
 	bool may_block:1;
 	bool is_ext:1;
 	bool is_lookup:1;
+	bool via_ioctl:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 04d96f34e9a1..3ad725a3e968 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1012,6 +1012,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_BPF_RESPONSE(N) _IOW(FUSE_DEV_IOC_MAGIC, 125, char[N])
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.40.0.634.g4ca3ef3211-goog

