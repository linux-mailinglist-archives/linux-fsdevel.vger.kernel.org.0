Return-Path: <linux-fsdevel+bounces-34423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C49C52D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BE2281FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2B20EA2D;
	Tue, 12 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jItnXu85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25492038CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406216; cv=none; b=c1F6Gu7/vxIEwYH/ULcCselxFZzaI6DIuKJy7D57UlKhlX3Hltoi7bR8XnbXYXrLATeNWFZtrg12wyT0/jTq1L3ZlrSW/i6upH9MFbVvUqalX1KdIQuHxBdE1ztSlbAv7RLlfwjEEgsAnCmkz7y73H5zcfC16i0gdfcg/SsM2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406216; c=relaxed/simple;
	bh=3CqMRoAUQ/VZkOxVTn2tOWqNGD9JA7YdHG+Hw1NNfE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPQDXkeZlbA0ezjMBEburzCXxw8XbO5ptNOGaApYfPb5WUC8GTqlq6mCoG8T4X2QXvQX5FJT+Nnw56e1TWShlWQq/VxsUfoOMxOxANA8VLMOgfzQKn/yd9wrfBOOn+e/oGyWr6B6IZ8gxqjZJkIulzrqA1exaNyeyaCX0CeeacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jItnXu85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731406213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nn4qiEJZ+ap7x5uz1e04QMgEzTquaDZxiT0D5O7PuY4=;
	b=jItnXu85t+Fb+E5rAZriVfTMR0O34rrH3o2jFUHOX1I4CGqx4g172219F1gWNEfI3hiECK
	g59PAgDj9lPN0THn7OGC0vMVuCASmvTfAHO3boPnHWZTcu5MtvWtpURv+ofxLMbZhsKf+Q
	eP6qOzCH89hJCl4W7fEH7uSqlOWZnNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-rpmfYtNUMGiblz0xV3KOEQ-1; Tue, 12 Nov 2024 05:10:10 -0500
X-MC-Unique: rpmfYtNUMGiblz0xV3KOEQ-1
X-Mimecast-MFC-AGG-ID: rpmfYtNUMGiblz0xV3KOEQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso39589645e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 02:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731406208; x=1732011008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nn4qiEJZ+ap7x5uz1e04QMgEzTquaDZxiT0D5O7PuY4=;
        b=hQEfmIpg4YoV6s+Rn608PvXHb/Me4lSNRWpkCkqoORdRzqPgrQ+uDi020Hxn2uIwqV
         K6MCoQyjC5MnbbCq89PJGMadQ8iOq2oo283+nuxT0Ni98x+MzUxLr3YG8TeSqaYcIbN6
         GETJhZJp7oBTde/SmE8tACcXWxZT4Ha4GWniiXtorKvFatphPXCbetko8nNBg4wO+gdO
         dTALgkLp3oUlZkEH52NjGvrahNARvWHR1/q05yMRsqCjLz6p+xgftX0E+EA1JEnV+0yg
         Geq6/mM/9n3Iq1Us58yLOvADFtUJHwnxxUU6DOeNbJmsnd8xkIBJa3PwdTeESeO2jVdL
         Guvg==
X-Gm-Message-State: AOJu0YyN8NV5NPwfClte7ZZ3xU2RyW099H8Y+HnCJ3AnYqhT+i3Tl34B
	E3TVRx1JHVnTfEukA2mzBIX4cd8WYX11PoypK3ooKVpRXe71MI6lAP1k1uIWCrIcuE+nfzj0zN0
	8V8+xmGg8zrk9ovZMMBM3ybvAOQqPebkCeT2h7fa29giIuJCn+xzcfWbqxLiPQlUQgnNhITOLx6
	QZqSTrLnCqUe4Sekr3Lb1HY29YiAW7OItMyQS0J0A7K4iuilM=
X-Received: by 2002:a5d:5850:0:b0:381:cde6:4ced with SMTP id ffacd0b85a97d-381f1880662mr12419989f8f.45.1731406208117;
        Tue, 12 Nov 2024 02:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWiamj90WZFzxDicuPiKeuDO26e0ElLoop/KUBpyDmAXiQTDVLWZDGpnLfUjUzDZ6TLXCz4A==
X-Received: by 2002:a5d:5850:0:b0:381:cde6:4ced with SMTP id ffacd0b85a97d-381f1880662mr12419961f8f.45.1731406207659;
        Tue, 12 Nov 2024 02:10:07 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-245-233.pool.digikabel.hu. [193.226.245.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970729sm14929937f8f.15.2024.11.12.02.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:10:07 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] statmount: add flag to retrieve unescaped options
Date: Tue, 12 Nov 2024 11:10:04 +0100
Message-ID: <20241112101006.30715-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystem options can be retrieved with STATMOUNT_MNT_OPTS, which
returns a string of comma separated options, where some characters are
escaped using the \OOO notation.

Add a new flag, STATMOUNT_OPT_ARRAY, which instead returns the raw
option values separated with '\0' charaters.

Since escaped charaters are rare, this inteface is preferable for
non-libmount users which likley don't want to deal with option
de-escaping.

Example code:

	if (st->mask & STATMOUNT_OPT_ARRAY) {
		const char *opt = st->str + st->opt_array;

		for (unsigned int i = 0; i < st->opt_num; i++) {
			printf("opt_array[%i]: <%s>\n", i, opt);
			opt += strlen(opt) + 1;
		}
	}

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 42 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mount.h |  7 +++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9a4ab1bc8b94..a16f75011610 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5074,6 +5074,41 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
+{
+	struct vfsmount *mnt = s->mnt;
+	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
+	u32 count = 0;
+	char *p, *end, *next, *u = seq->buf + start;
+	int err;
+
+       if (!sb->s_op->show_options)
+               return 0;
+
+       err = sb->s_op->show_options(seq, mnt->mnt_root);
+       if (err)
+	       return err;
+
+       if (unlikely(seq_has_overflowed(seq)))
+	       return -EAGAIN;
+
+       end = seq->buf + seq->count;
+       *end = '\0';
+       for (p = u + 1; p < end; p = next + 1) {
+               next = strchrnul(p, ',');
+               *next = '\0';
+               u += string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
+	       count++;
+	       if (!count)
+		       return -EOVERFLOW;
+       }
+       seq->count = u - 1 - seq->buf;
+       s->sm.opt_num = count;
+
+       return 0;
+}
+
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
 	int ret = 0;
@@ -5099,6 +5134,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->mnt_opts = start;
 		ret = statmount_mnt_opts(s, seq);
 		break;
+	case STATMOUNT_OPT_ARRAY:
+		sm->opt_array = start;
+		ret = statmount_opt_array(s, seq);
+		break;
 	case STATMOUNT_FS_SUBTYPE:
 		sm->fs_subtype = start;
 		statmount_fs_subtype(s, seq);
@@ -5252,6 +5291,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_OPTS)
 		err = statmount_string(s, STATMOUNT_MNT_OPTS);
 
+	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
+		err = statmount_string(s, STATMOUNT_OPT_ARRAY);
+
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2b49e9131d77..c0fda4604187 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -154,7 +154,7 @@ struct mount_attr {
  */
 struct statmount {
 	__u32 size;		/* Total size, including strings */
-	__u32 mnt_opts;		/* [str] Mount options of the mount */
+	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
 	__u64 mask;		/* What results were written */
 	__u32 sb_dev_major;	/* Device ID */
 	__u32 sb_dev_minor;
@@ -175,7 +175,9 @@ struct statmount {
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
 	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
 	__u32 sb_source;	/* [str] Source string of the mount */
-	__u64 __spare2[48];
+	__u32 opt_num;		/* Number of fs options */
+	__u32 opt_array;	/* [str] Array of nul terminated fs options */
+	__u64 __spare2[47];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -211,6 +213,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
+#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
 
 /*
  * Special @mnt_id values that can be passed to listmount
-- 
2.47.0


