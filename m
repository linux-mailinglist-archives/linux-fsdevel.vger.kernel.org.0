Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1774645E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 05:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbhLAE1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 23:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbhLAE1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:27:01 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989EC061574;
        Tue, 30 Nov 2021 20:23:40 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b11so16650045pld.12;
        Tue, 30 Nov 2021 20:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Go51Y2BiE5h2mzVAYbH7sxo6TMFat2Nz0AxJAMmUrTs=;
        b=GfNSdCXFEu1Zs7qBS8zp1igfVvEB3iZwDTGSf4MVrT7q3I2KUlrs9QC/MI6MoLo9Ig
         5W3PCKaBvh3fKPFVBNaZySFyGQeMXnP8YIlTL9O6RZBu6E73X5f9rnUwusXgG+N7Rgaw
         PAw/uDJEqnF9lXIUuXt0fcx1oomj1eKysxW3Cp2Dmz0OoePyVgEiIDsh/4tclSUEUvdL
         9M2pK3+zuR8BqtElGywQZ9B63n0LgGVwThqZaFWmoI/dcOUAX+XZiIK7ivuxvlhcPuzG
         YMsG/v8jn+p7PkM7PeVgsqj/0z5J0afu5AtOMlJmBsD9aYEFOkUBagRzAlur8BsavaX3
         bwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Go51Y2BiE5h2mzVAYbH7sxo6TMFat2Nz0AxJAMmUrTs=;
        b=uv+3Y/WPuTAsL5WAdH017/b0QfUJGDrIHG7zFFLjt/M5ZKxrBBJtT759ANc/vQBsuG
         Lv48daLkVfcsc2u4Kar2i+Nh5IYMbXwxzo6jLKTu/5atTUCpZuUImiE8CjJwniSDY6J8
         G1gB1WryT2PWA4D3pK9CJ5T/yXbob8Ibwt2X4QQfDmL5PbZ43VExjRGksV0P9i0X2ov7
         yawetWfcpB5YQbTRtuNQ+6LSn9XrSNgjxh76mnvg8dsRDERnkYhCsfcEpeXZUnDpFOxD
         BrBBq/eDci+VF+JJj38C/xaZ5JoysyKH7+Jd9+9kYg69Z6ilEyjJWjpF1Q7dm+1u0Z/W
         eaCg==
X-Gm-Message-State: AOAM5313rc9+FnPZQq17ZXeowWwG0nlj4WS0/avgX2jDTrsyAqjks9Y1
        AJpwtK1Bym62N4KoBQTg6lisGSvGdNc=
X-Google-Smtp-Source: ABdhPJzH1HbgozM5Ptszs3tX2jwXuk50EKJlfSHC2R7KpCN9g0VrAzkOukL9ab7pjCfFewWIHr34nA==
X-Received: by 2002:a17:90a:e005:: with SMTP id u5mr4278585pjy.17.1638332619802;
        Tue, 30 Nov 2021 20:23:39 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id g18sm22002734pfb.103.2021.11.30.20.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 20:23:39 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>, criu@openvz.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next v3 01/10] io_uring: Implement eBPF iterator for registered buffers
Date:   Wed,  1 Dec 2021 09:53:24 +0530
Message-Id: <20211201042333.2035153-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201042333.2035153-1-memxor@gmail.com>
References: <20211201042333.2035153-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10970; h=from:subject; bh=fzO1nhPRAyw/l1yTDLhzFaDJvb5Q/r/wRyKrusivRBY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhpvYxmk+ulZG46nuBuoJPDtb2dwXZjy5T59Qop8iV VnTvQSOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYab2MQAKCRBM4MiGSL8RytHZD/ wK1MvZ6X1XV1s68nfwPtpDsebriDmbKQ3kJu/UWvgUXH3giewfYVB6vDgmt1KeGHnhpnfKKI3n1K3T 6XYRvxpWdYjLZgYCFUkT2bUZT3lYznqZGpF8ZCSrzF5+N0x6TTIbSd0LVjyRxmFaEZYFB4GC59IaHr 8s1e+2AEILyAWBTpL8Ms3kptzyGTUlDrlvhZ5dLAFo+0XASyCp7O+g/HwTFIrqQkxkqAC7o+Z2yOBT dQFKTni/qcjLLL/N0sJ7AoqJ4VoIx5iHGR2POn6DYf1xJwoIj9sABYIKaG5wSIpGiWKUndst6xujlR 3lTr7hR+eexoXV0/Bb9Y7M75WNQRzws0pA1AvKMl3xSA6cuZG7Pd2A9CruSoGAl47UI7vggm8c70Xj TjZZqt0lg5ec/Rt8vFGGaeP77bJga7NZC0LJ6rHaJWUIlyJ1CFahiMzHf2ffjpz7B+QzHyd0rRkP9P j202dMxrsnEkRwAMoBf4gsLjVHboYMmB5WqMimrX1QMA2QmdjjmR9mj5JK/7EJECMmI00eUHlZxLUC xJhQn3ZkIO+pvK3TUewpTwSAEAAMl8GZt5X/aUnP9jpSSND9hvS3Lve6pbUH34q/VdZ1zW6PBF6A2o 7CLvsnVRbsC6apadgGgAoBAWWQhIkHlNKVT5mVSvjyYNoBcwCHJnVbpYCdCQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change adds eBPF iterator for buffers registered in io_uring ctx.
It gives access to the ctx, the index of the registered buffer, and a
pointer to the io_uring_ubuf itself. This allows the iterator to save
info related to buffers added to an io_uring instance, that isn't easy
to export using the fdinfo interface (like exact struct page composing
the registered buffer).

The primary usecase this is enabling is checkpoint/restore support.

Note that we need to use mutex_trylock when the file is read from, in
seq_start functions, as the order of lock taken is opposite of what it
would be when io_uring operation reads the same file.  We take
seq_file->lock, then ctx->uring_lock, while io_uring would first take
ctx->uring_lock and then seq_file->lock for the same ctx.

This can lead to a deadlock scenario described below:

The sequence on CPU 0 is for normal read(2) on iterator.
For CPU 1, it is an io_uring instance trying to do same on iterator attached to
itself.

So CPU 0 does

sys_read
vfs_read
 bpf_seq_read
 mutex_lock(&seq_file->lock)    # A
  io_uring_buf_seq_start
  mutex_lock(&ctx->uring_lock)  # B

and CPU 1 does

io_uring_enter
mutex_lock(&ctx->uring_lock)    # B
 io_read
  bpf_seq_read
  mutex_lock(&seq_file->lock)   # A
  ...

Since the order of locks is opposite, it can deadlock. So we switch the
mutex_lock in io_uring_buf_seq_start to trylock, so it can return an
error for this case, then it will release seq_file->lock and CPU 1 will
make progress.

The trylock also protects the case where io_uring tries to read from
iterator attached to itself (same ctx), where the order of locks would
be:
 io_uring_enter
 mutex_lock(&ctx->uring_lock) <------------.
  io_read				    \
   seq_read				     \
    mutex_lock(&seq_file->lock)		     /
    mutex_lock(&ctx->uring_lock) # deadlock-`

In both these cases (recursive read and contended uring_lock), -EDEADLK
is returned to userspace.

In the future, this iterator will be extended to directly support
iteration of bvec Flexible Array Member, so that when there is no
corresponding VMA that maps to the registered buffer (e.g. if VMA is
destroyed after pinning pages), we are able to reconstruct the
registration on restore by dumping the page contents and then replaying
them into a temporary mapping used for registration later. All this is
out of scope for the current series however, but builds upon this
iterator.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 fs/io_uring.c                  | 203 +++++++++++++++++++++++++++++++++
 include/linux/bpf.h            |  12 ++
 include/uapi/linux/bpf.h       |   6 +
 tools/include/uapi/linux/bpf.h |   6 +
 4 files changed, 227 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b07196b4511c..02e628448ebd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -81,6 +81,7 @@
 #include <linux/tracehook.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/btf_ids.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -11125,3 +11126,205 @@ static int __init io_uring_init(void)
 	return 0;
 };
 __initcall(io_uring_init);
+
+#ifdef CONFIG_BPF_SYSCALL
+
+BTF_ID_LIST(btf_io_uring_ids)
+BTF_ID(struct, io_ring_ctx)
+BTF_ID(struct, io_mapped_ubuf)
+
+struct bpf_io_uring_seq_info {
+	struct io_ring_ctx *ctx;
+	u64 index;
+};
+
+static int bpf_io_uring_init_seq(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	struct bpf_io_uring_seq_info *info = priv_data;
+	struct io_ring_ctx *ctx = aux->io_uring.ctx;
+
+	info->ctx = ctx;
+	return 0;
+}
+
+static int bpf_io_uring_iter_attach(struct bpf_prog *prog,
+				    union bpf_iter_link_info *linfo,
+				    struct bpf_iter_aux_info *aux)
+{
+	struct io_ring_ctx *ctx;
+	struct fd f;
+	int ret;
+
+	f = fdget(linfo->io_uring.io_uring_fd);
+	if (unlikely(!f.file))
+		return -EBADF;
+
+	ret = -EOPNOTSUPP;
+	if (unlikely(f.file->f_op != &io_uring_fops))
+		goto out_fput;
+
+	ret = -ENXIO;
+	ctx = f.file->private_data;
+	if (unlikely(!percpu_ref_tryget(&ctx->refs)))
+		goto out_fput;
+
+	ret = 0;
+	aux->io_uring.ctx = ctx;
+	/* each io_uring file's inode is unique, since it uses
+	 * anon_inode_getfile_secure, which can be used to search
+	 * through files and map link fd back to the io_uring.
+	 */
+	aux->io_uring.inode = f.file->f_inode->i_ino;
+
+out_fput:
+	fdput(f);
+	return ret;
+}
+
+static void bpf_io_uring_iter_detach(struct bpf_iter_aux_info *aux)
+{
+	percpu_ref_put(&aux->io_uring.ctx->refs);
+}
+
+#ifdef CONFIG_PROC_FS
+static void bpf_io_uring_iter_show_fdinfo(const struct bpf_iter_aux_info *aux,
+					  struct seq_file *seq)
+{
+	seq_printf(seq, "io_uring_inode:\t%lu\n", aux->io_uring.inode);
+}
+#endif
+
+static int bpf_io_uring_iter_fill_link_info(const struct bpf_iter_aux_info *aux,
+					    struct bpf_link_info *info)
+{
+	info->iter.io_uring.inode = aux->io_uring.inode;
+	return 0;
+}
+
+/* io_uring iterator for registered buffers */
+
+struct bpf_iter__io_uring_buf {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct io_ring_ctx *, ctx);
+	__bpf_md_ptr(struct io_mapped_ubuf *, ubuf);
+	u64 index;
+};
+
+static void *__bpf_io_uring_buf_seq_get_next(struct bpf_io_uring_seq_info *info)
+{
+	if (info->index < info->ctx->nr_user_bufs)
+		return info->ctx->user_bufs[info->index++];
+	return NULL;
+}
+
+static void *bpf_io_uring_buf_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_io_uring_seq_info *info = seq->private;
+	struct io_mapped_ubuf *ubuf;
+
+	/* Indicate to userspace that the uring lock is contended */
+	if (!mutex_trylock(&info->ctx->uring_lock))
+		return ERR_PTR(-EDEADLK);
+
+	ubuf = __bpf_io_uring_buf_seq_get_next(info);
+	if (!ubuf)
+		return NULL;
+
+	if (*pos == 0)
+		++*pos;
+	return ubuf;
+}
+
+static void *bpf_io_uring_buf_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_io_uring_seq_info *info = seq->private;
+
+	++*pos;
+	return __bpf_io_uring_buf_seq_get_next(info);
+}
+
+DEFINE_BPF_ITER_FUNC(io_uring_buf, struct bpf_iter_meta *meta,
+		     struct io_ring_ctx *ctx, struct io_mapped_ubuf *ubuf,
+		     u64 index)
+
+static int __bpf_io_uring_buf_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_io_uring_seq_info *info = seq->private;
+	struct bpf_iter__io_uring_buf ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, in_stop);
+	if (!prog)
+		return 0;
+
+	ctx.meta = &meta;
+	ctx.ctx = info->ctx;
+	ctx.ubuf = v;
+	ctx.index = info->index ? info->index - !in_stop : 0;
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int bpf_io_uring_buf_seq_show(struct seq_file *seq, void *v)
+{
+	return __bpf_io_uring_buf_seq_show(seq, v, false);
+}
+
+static void bpf_io_uring_buf_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_io_uring_seq_info *info = seq->private;
+
+	/* If IS_ERR(v) is true, then ctx->uring_lock wasn't taken */
+	if (IS_ERR(v))
+		return;
+	if (!v)
+		__bpf_io_uring_buf_seq_show(seq, v, true);
+	else if (info->index) /* restart from index */
+		info->index--;
+	mutex_unlock(&info->ctx->uring_lock);
+}
+
+static const struct seq_operations bpf_io_uring_buf_seq_ops = {
+	.start = bpf_io_uring_buf_seq_start,
+	.next  = bpf_io_uring_buf_seq_next,
+	.stop  = bpf_io_uring_buf_seq_stop,
+	.show  = bpf_io_uring_buf_seq_show,
+};
+
+static const struct bpf_iter_seq_info bpf_io_uring_buf_seq_info = {
+	.seq_ops          = &bpf_io_uring_buf_seq_ops,
+	.init_seq_private = bpf_io_uring_init_seq,
+	.fini_seq_private = NULL,
+	.seq_priv_size    = sizeof(struct bpf_io_uring_seq_info),
+};
+
+static struct bpf_iter_reg io_uring_buf_reg_info = {
+	.target            = "io_uring_buf",
+	.feature	   = BPF_ITER_RESCHED,
+	.attach_target     = bpf_io_uring_iter_attach,
+	.detach_target     = bpf_io_uring_iter_detach,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	   = bpf_io_uring_iter_show_fdinfo,
+#endif
+	.fill_link_info    = bpf_io_uring_iter_fill_link_info,
+	.ctx_arg_info_size = 2,
+	.ctx_arg_info = {
+		{ offsetof(struct bpf_iter__io_uring_buf, ctx),
+		  PTR_TO_BTF_ID },
+		{ offsetof(struct bpf_iter__io_uring_buf, ubuf),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info	   = &bpf_io_uring_buf_seq_info,
+};
+
+static int __init io_uring_iter_init(void)
+{
+	io_uring_buf_reg_info.ctx_arg_info[0].btf_id = btf_io_uring_ids[0];
+	io_uring_buf_reg_info.ctx_arg_info[1].btf_id = btf_io_uring_ids[1];
+	return bpf_iter_reg_target(&io_uring_buf_reg_info);
+}
+late_initcall(io_uring_iter_init);
+
+#endif
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc7a0c36e7df..967842881024 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1509,8 +1509,20 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
 	extern int bpf_iter_ ## target(args);			\
 	int __init bpf_iter_ ## target(args) { return 0; }
 
+struct io_ring_ctx;
+
 struct bpf_iter_aux_info {
+	/* Map member must not alias any other members, due to the check in
+	 * bpf_trace.c:__get_seq_info, since in case of map the seq_ops for
+	 * iterator is different from others. The seq_ops is not from main
+	 * iter registration but from map_ops. Nullability of 'map' allows
+	 * to skip this check for non-map iterator cheaply.
+	 */
 	struct bpf_map *map;
+	struct {
+		struct io_ring_ctx *ctx;
+		ino_t inode;
+	} io_uring;
 };
 
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a69e4b04ffeb..1ad1ae85743c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -91,6 +91,9 @@ union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
 	} map;
+	struct {
+		__u32   io_uring_fd;
+	} io_uring;
 };
 
 /* BPF syscall commands, see bpf(2) man-page for more details. */
@@ -5720,6 +5723,9 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					__u64 inode;
+				} io_uring;
 			};
 		} iter;
 		struct  {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a69e4b04ffeb..1ad1ae85743c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -91,6 +91,9 @@ union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
 	} map;
+	struct {
+		__u32   io_uring_fd;
+	} io_uring;
 };
 
 /* BPF syscall commands, see bpf(2) man-page for more details. */
@@ -5720,6 +5723,9 @@ struct bpf_link_info {
 				struct {
 					__u32 map_id;
 				} map;
+				struct {
+					__u64 inode;
+				} io_uring;
 			};
 		} iter;
 		struct  {
-- 
2.34.1

