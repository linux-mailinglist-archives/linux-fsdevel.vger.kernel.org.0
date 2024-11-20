Return-Path: <linux-fsdevel+bounces-35324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E305F9D3D86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48CE284463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004681A9B48;
	Wed, 20 Nov 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwFchEBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509B19CC1C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112862; cv=none; b=ai2yUlfkSxlVIctcKAhZhvn+w8v9iihlCMX8Ot+8/o2ZUVktTHv1GuC7vdG6TgLIIYXi8LAMV6jbjcw6sLnvZc7YNgY1G9i8+4NvFYWULtlJ1booSOxciPm7+JyLlbr4AfGPjMKA8hhEVbCrKSXKNJfZv5U/VfHinStuV32YWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112862; c=relaxed/simple;
	bh=0mDxcVJ8ko3bBdWzIc8N2n9wEykIAELnMxkfgnwfFkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQ0DNPaiwSJ4smhirWYk4u6NSjsRPFMASPpvLkmDPXNCyJrVPtM+C/oRRfwm+L+CIhGqhtG883lSwtGi0OPmXuaWDXmLZLtaAZ4LBAlhYiCCwkqfn1AfoaZnLjQsZdoBk3gWGrV/fMw3xLQ+2mOEB2xHb12ufbBH9D4HruBAKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwFchEBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732112858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ajMBH/hFUfrWiQrpS4eF+RjxTkssIkGzfQ6Pgvwu2I=;
	b=JwFchEBy++dS3S3KOZ6urksox5vjpdgidabcCIbwWr+CaCpRTiUvy1LGkOkJKEPA4iu+kS
	7MSWfYHqAXiKFZRswq31ivnMVErEp3wTNWXGfmsiPY8kfjREkhQhtNHDMWsq60EUkHmfOh
	PRDlJKyMbZhQyT53pfdGQlrvAkZokTQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-rNmHcVdbPRWMqqo65nYOLg-1; Wed, 20 Nov 2024 09:27:36 -0500
X-MC-Unique: rNmHcVdbPRWMqqo65nYOLg-1
X-Mimecast-MFC-AGG-ID: rNmHcVdbPRWMqqo65nYOLg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so40337355e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 06:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732112854; x=1732717654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ajMBH/hFUfrWiQrpS4eF+RjxTkssIkGzfQ6Pgvwu2I=;
        b=LnYL3Rta7GlxOJ/zLS5r3GQdg1nKdePtQyDXt0cMI8TQpWNkr+jK9MbkN/uSAqweac
         FNNEv/DLmorcNd1a6HG19DCjvTCYpP7PnlhMninjPlFhcxoyglxvUgPnpla8HWpYfGA6
         Ac89+CLNGrAdtzWp6q0mgvSlaOhk7Kwm4/83HGi5prZOXLBGoL6Mgn1XvrxUE8feYRUZ
         SD0fCm9u3uNHNpAIgWuxIbJz8ENm0i028kV6cXj6HYgQNtZA9vSA+vqnhfCDOk2kfNlA
         1SBjRef5ykMWVwJzu3i+SpYud6NK+5fjcAnQJpohSqdTh2VPDqOnyQnev//ed8e17/1X
         gWxg==
X-Gm-Message-State: AOJu0YyYN2nKuu4tzInZJdDg3cqEOOYU7OOg6N7bMh9h/fLfTGY0IHC5
	exdbHA2NELYCQ+6CEVxVn5C0ts70nmypI4xdLEOuQyZn9Np2qXRSEYtDsJqB9xGS1WexgTdOpI3
	NPB9ZPluuxYUNc/+JDu81OY8IuGhbwxTMFp0wzaeCWeE0AdM2d70ljIssQJcaxv82nRAho35rmD
	rri2IY7VRQB2sweM+GUQB0pvsNYoy/hRsC1dx2YmWXj3xfhS4=
X-Received: by 2002:a05:600c:4f08:b0:432:e5fb:2adf with SMTP id 5b1f17b1804b1-43348986a9amr27133025e9.4.1732112854608;
        Wed, 20 Nov 2024 06:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW+dgFT3CpL9rrYhM4U97210NU9RqKrYw8hqoO2XIIqIsXgyaBN6lOR1qkNGtDA50u8C8JRg==
X-Received: by 2002:a05:600c:4f08:b0:432:e5fb:2adf with SMTP id 5b1f17b1804b1-43348986a9amr27132815e9.4.1732112854236;
        Wed, 20 Nov 2024 06:27:34 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-2-181.pool.digikabel.hu. [84.236.2.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825494fae3sm2193705f8f.110.2024.11.20.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:27:33 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] statmount: clean up unescaped option handling
Date: Wed, 20 Nov 2024 15:27:23 +0100
Message-ID: <20241120142732.55210-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move common code from opt_array/opt_sec_array to helper.  This helper
does more than just unescape options, so rename to
statmount_opt_process().

Handle corner case of just a single character in options.

Rename some local variables to better describe their function.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index eb34a5160f64..23e81c2a1e3f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5057,21 +5057,32 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
-static inline int statmount_opt_unescape(struct seq_file *seq, char *buf_start)
+static inline int statmount_opt_process(struct seq_file *seq, size_t start)
 {
-	char *buf_end, *opt_start, *opt_end;
+	char *buf_end, *opt_end, *src, *dst;
 	int count = 0;
 
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
+
 	buf_end = seq->buf + seq->count;
+	dst = seq->buf + start;
+	src = dst + 1;	/* skip initial comma */
+
+	if (src >= buf_end) {
+		seq->count = start;
+		return 0;
+	}
+
 	*buf_end = '\0';
-	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
-		opt_end = strchrnul(opt_start, ',');
+	for (; src < buf_end; src = opt_end + 1) {
+		opt_end = strchrnul(src, ',');
 		*opt_end = '\0';
-		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
+		dst += string_unescape(src, dst, 0, UNESCAPE_OCTAL) + 1;
 		if (WARN_ON_ONCE(++count == INT_MAX))
 			return -EOVERFLOW;
 	}
-	seq->count = buf_start - 1 - seq->buf;
+	seq->count = dst - 1 - seq->buf;
 	return count;
 }
 
@@ -5080,24 +5091,16 @@ static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
 	size_t start = seq->count;
-	char *buf_start;
 	int err;
 
 	if (!sb->s_op->show_options)
 		return 0;
 
-	buf_start = seq->buf + start;
 	err = sb->s_op->show_options(seq, mnt->mnt_root);
 	if (err)
 		return err;
 
-	if (unlikely(seq_has_overflowed(seq)))
-		return -EAGAIN;
-
-	if (seq->count == start)
-		return 0;
-
-	err = statmount_opt_unescape(seq, buf_start);
+	err = statmount_opt_process(seq, start);
 	if (err < 0)
 		return err;
 
@@ -5110,22 +5113,13 @@ static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
 	size_t start = seq->count;
-	char *buf_start;
 	int err;
 
-	buf_start = seq->buf + start;
-
 	err = security_sb_show_options(seq, sb);
 	if (err)
 		return err;
 
-	if (unlikely(seq_has_overflowed(seq)))
-		return -EAGAIN;
-
-	if (seq->count == start)
-		return 0;
-
-	err = statmount_opt_unescape(seq, buf_start);
+	err = statmount_opt_process(seq, start);
 	if (err < 0)
 		return err;
 
-- 
2.47.0


