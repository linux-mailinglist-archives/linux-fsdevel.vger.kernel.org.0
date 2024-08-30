Return-Path: <linux-fsdevel+bounces-28078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913E9666DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6072822DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6F1BA29A;
	Fri, 30 Aug 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0+MHW0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB241BA286
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035233; cv=none; b=YNm75Ro752Kz8RINIYq3S8O/lYeydrnswI6mQfRln3od/pWZjzXsfjk7J7+7AkHZAmzB9fk4Zok3ietIyQx8OJoI+FmTFZICPUhZkyyn3RcQBQ6UmsjqfKHz+UjOiEHeTEq/NktH+num89heZ3DtgCLgfHfDWFpZxR3+Eu7bfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035233; c=relaxed/simple;
	bh=pYlsT5PeP23mlQHldTpkUZWpNq4ZKYVheXtGZ3vUGqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E06CChIE1j5I/v5aPDK/qwVpDX3i+MBOTxuttuf19ajaFTWQaowSAgO8kcHO/Fk4TY9pzZE/g8AgTbIM8kXmGNUsw5BoNMWF+MHIksmVXt6Vcsv/EpSKvUJ5/cW6NTlIRnJUiGY/d/hnbZ8D+SjmIVQM5/vA3UhJzF1Oh8KDuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0+MHW0z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b6b9867f81so16622987b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725035231; x=1725640031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waGfQX9dp2W1Q9PhBV6CucdXUYM+K+uqStWvGjshFPc=;
        b=S0+MHW0zaNHxWSS/pLDBhRfTT3n09/jILxRpEcxkqdqC8JVV9VyiiAjvJ/nXd3JymF
         qSflbNdMNj4iIl+49GNr9Kb4XftXc85Ryw0QazgigaG8XDN4DnbbzWThEPJTSgvcao71
         On3c8TDGlR4HW/4DpLYtG3b/o561EGiYDqH7NXc916fNXkgMYnJKgztid1RjGrwJ+4o1
         wQq3iU0z1fiavlWF84ku+/rb26m2qD5WEs1Fir5HL/31CMM8XncGLxGrEYmpd7UmZ3GZ
         o2fcTIOqDPAl46j6LmFd3TnuBAX2UxuXvx5F0DOcugTIAkTyFPO1uM1NuvhFL8c/AY1g
         nONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035231; x=1725640031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waGfQX9dp2W1Q9PhBV6CucdXUYM+K+uqStWvGjshFPc=;
        b=ToeRRE7zKPqjuIczI4yxSARUZBx3Te2u7fsR9235TjgyTQiyhN/Q5hR4/clEh7HKA4
         t4nFIoEmSbDdTerTVh2iktEJ6skjDHWRAr/MP859q37oh88QigWwCmd2wXp1wP76/aFR
         zleB//0zWmQHHaJ8KaKcJRVvYa0eTs1flVCc3xqkWGDZh4qneZx7/TchP9dQIUukiLqo
         n5XHoLaNK9V96CdJ3gdX631zJusPHf4EjQ1HxTCFicEgbe8Wx6ZsLhuvGnXvKloAiScj
         dSNp1dRUp85HHkugX2ARLwPKVp5dIOiGGynAutqXbaOsnw6izOfGyVRMfJFz15KY59uo
         I7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUTEJqXTnmBVhe/P+MdVgF7Fcr71aB8aV5oiMSjDiI7peObdu5Gv/qFzf+cxeB+HgygV3gKWPJjpp4EAtUN@vger.kernel.org
X-Gm-Message-State: AOJu0YycplQy9xWc4lpfxvtFAnUlyh+Xfj6DRjNli4dxvjt5DR9W37lH
	rO4mYgQ5J6MV0fuwE6MNfLyeQ3cj7mo3Yk+1c+V7sKYeNQQ/7iF+
X-Google-Smtp-Source: AGHT+IHH9z0urmFdwH8OpFBf5a3mN+1frQFi/QhyQdRvwOyhhNqiZh09AbBDThUIUcvZLDkafnSjbQ==
X-Received: by 2002:a05:690c:6703:b0:6d3:b708:7b19 with SMTP id 00721157ae682-6d40e782513mr26693237b3.27.1725035230853;
        Fri, 30 Aug 2024 09:27:10 -0700 (PDT)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d5daf57bsm6689427b3.117.2024.08.30.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:27:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
Date: Fri, 30 Aug 2024 09:26:48 -0700
Message-ID: <20240830162649.3849586-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830162649.3849586-1-joannelkoong@gmail.com>
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or
stuck, for example if the server is in a deadlock. Currently, there's
no good way to detect if a server is stuck and needs to be killed
manually.

This commit adds an option for enforcing a timeout (in seconds) on
requests where if the timeout elapses without a reply from the server,
the connection will be automatically aborted.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c    | 26 +++++++++++++++++++++++++-
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  |  7 +++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..a4ec817074a2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -40,6 +40,16 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
 	return READ_ONCE(file->private_data);
 }
 
+static void fuse_request_timeout(struct timer_list *timer)
+{
+	struct fuse_req *req = container_of(timer, struct fuse_req, timer);
+	struct fuse_conn *fc = req->fm->fc;
+
+	req->timer.function = NULL;
+
+	fuse_abort_conn(fc);
+}
+
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 {
 	INIT_LIST_HEAD(&req->list);
@@ -48,6 +58,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
 	req->fm = fm;
+	if (fm->fc->req_timeout)
+		timer_setup(&req->timer, fuse_request_timeout, 0);
 }
 
 static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
@@ -283,6 +295,9 @@ void fuse_request_end(struct fuse_req *req)
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	if (req->timer.function)
+		timer_delete_sync(&req->timer);
+
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
 
@@ -393,6 +408,8 @@ static void request_wait_answer(struct fuse_req *req)
 		if (test_bit(FR_PENDING, &req->flags)) {
 			list_del(&req->list);
 			spin_unlock(&fiq->lock);
+			if (req->timer.function)
+				timer_delete_sync(&req->timer);
 			__fuse_put_request(req);
 			req->out.h.error = -EINTR;
 			return;
@@ -409,7 +426,8 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_iqueue *fiq = &fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 	spin_lock(&fiq->lock);
@@ -421,6 +439,8 @@ static void __fuse_request_send(struct fuse_req *req)
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
+		if (req->timer.function)
+			mod_timer(&req->timer, jiffies + fc->req_timeout);
 		queue_request_and_unlock(fiq, req);
 
 		request_wait_answer(req);
@@ -539,6 +559,8 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 		if (fc->num_background == fc->max_background)
 			fc->blocked = 1;
 		list_add_tail(&req->list, &fc->bg_queue);
+		if (req->timer.function)
+			mod_timer(&req->timer, jiffies + fc->req_timeout);
 		flush_bg_queue(fc);
 		queued = true;
 	}
@@ -594,6 +616,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
+		if (req->timer.function)
+			mod_timer(&req->timer, jiffies + fm->fc->req_timeout);
 		queue_request_and_unlock(fiq, req);
 	} else {
 		err = -ENODEV;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..97dacafa4289 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -435,6 +435,9 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	/** timer for request replies, if timeout option is enabled */
+	struct timer_list timer;
 };
 
 struct fuse_iqueue;
@@ -574,6 +577,8 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	/*  Request timeout (in seconds). 0 = no timeout (infinite wait) */
+	unsigned int req_timeout;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -633,6 +638,9 @@ struct fuse_conn {
 	/** Constrain ->max_pages to this value during feature negotiation */
 	unsigned int max_pages_limit;
 
+	/* Request timeout (in jiffies). 0 = no timeout (infinite wait) */
+	unsigned long req_timeout;
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..9e69006fc026 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -733,6 +733,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_REQUEST_TIMEOUT,
 	OPT_ERR
 };
 
@@ -747,6 +748,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("request_timeout",	OPT_REQUEST_TIMEOUT),
 	{}
 };
 
@@ -830,6 +832,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_REQUEST_TIMEOUT:
+		ctx->req_timeout = result.uint_32;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1724,6 +1730,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
+	fc->req_timeout = ctx->req_timeout * HZ;
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
-- 
2.43.5


