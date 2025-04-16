Return-Path: <linux-fsdevel+bounces-46545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA5FA8B4D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912E97AE6DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADBD236450;
	Wed, 16 Apr 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoq5sMrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA5235348
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794457; cv=none; b=gmQfgdRxoGJZWfNtRUGmNAh42JR8G5scWlVCOWZGyt4WCQJOhYL3HgRbi0rW7iagwqPX7kX7KnJnIp11Gt9xVsXrYT8OVCdS9Ke/87LXpVdNeza1iERDW2g5K0ztroLjGNG0dN7T2mvQnUzV4EorARVt+5Am6lshuPrMDBuMXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794457; c=relaxed/simple;
	bh=O8saET11Io05DU48ZrUWdRP2xg6FrMvurVUa72qmLCk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kGpubhnV3JPoaARXdK5+VaX1tZeZ9vc8eDoOk7xFHJUe8qqM28VlllPnp2lppBgiwpfU19aKKI9xX2T3OUddjp1Qx11CRoiZY3pc8gUylb2LVk4vqijYm+ZUJ9sGwcUJLUOo2PXlIHxw/OK2IwWrM88kS9X5YSvDaqPodNsxqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qoq5sMrD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744794454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n7ThyeD3b/UAFCMzwbN5rltDLlLSb3K+x6WEcOUEiV0=;
	b=Qoq5sMrDJdiyWg3PaX7R5kwR12f1y4/j47TJcOtA3ypye2C5oI8DrMFtYSHFGq22ZIdwdu
	ifT9cLTP4ZysiFrLsUQZNJeBTDDUW2AhQYXMHj7q6gfPYPpO2OqblnPeorrdO0VL7hDqi+
	rAVDdksTgMzkdk/ySzDZp/VuWpu3XMg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-L6BEbI1vNZ-tgq6PbwSiCw-1; Wed, 16 Apr 2025 05:07:32 -0400
X-MC-Unique: L6BEbI1vNZ-tgq6PbwSiCw-1
X-Mimecast-MFC-AGG-ID: L6BEbI1vNZ-tgq6PbwSiCw_1744794451
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac287f28514so528379866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 02:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794451; x=1745399251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7ThyeD3b/UAFCMzwbN5rltDLlLSb3K+x6WEcOUEiV0=;
        b=qGiX4gKRxa2ZTfWqYIze0ts2QGUW4XDgTaFGfPHrWLeqWc8Caoy2fp2g+Ch8V+0BcB
         L49snQ1uPf7smNkZtx2mi5SUOr2TwmTS72b180gwl4WncdB6yxS5BZ8T3+Ef5SnE/YWs
         1pcUVhVh/TaGaFpgc7XLTGUf+0w1dUpOeOV8Uk/pPPPrMD/siRh3cWmV2cePDNArOlGk
         BOv61M6K8JyzmZQU0EYU/eBTVZsNZ4J+HOqaDJr49QYI04Y2AwTp308BTKFX27cVKkbU
         NY7URjYU4TAaKCOMlWVvmdKmTmYUeElOrbrmjRCw8QoBfqlfzlPtcmxZrzliqlVuGfST
         moFQ==
X-Gm-Message-State: AOJu0Yx8acrNSOcHqySftniLbx6dF+zIYTuT0tBhV/sGgLtg1njEbpRE
	M6oxiChsloQ8xc1nFA//+Q5BovV9+S3KNmxOIieUiY3ZqjHKJCdBqsUdrHypT9n3thPBF1XZuWh
	AemgyzV0OBWYE6J4hmmpGbANFDhkDnmKd+x2dpjK46J4NIhvIXAvH/8xvknDBFmZcxsDXLQSYUk
	CNAWSqJJDRARN0lcGWDyXiwP5rpJFkstniBWxrPGofvOvRGAo=
X-Gm-Gg: ASbGncv3d7sEf5pq9fP0kIkzeIn4xuC2lLsI5GO/WUSwMiL81583JWtadTTTzEk+XBW
	MRZuxd6YkKH4rn2yqfqkQtz/CYHSwj2LdRz9+zJGsN1PMkCN/Y8sX+FXx38Q9UqpvwK8MARFxcD
	/UIn+353cDtFhx2+jz2oOrEaRpyhjblCzJ4tE0MOcMhymiMAuFY47mO+teHAw/GM+36n0VJQEwp
	ftSLoOnn/4368AKNZKe09ST80xb4QUy6wwR3N72d1kJULdeB0Cj/zdaqHvwvzE/OWa4cr6K5/s5
	w4IQk6+2t1nHUFoyHCHWecDWUj3kj1i+jupdNMmdNIlinC/2IQ3BMh+zOATQ5yc=
X-Received: by 2002:a17:906:4f84:b0:aca:c9b5:31a8 with SMTP id a640c23a62f3a-acb42bfd648mr80172366b.45.1744794450866;
        Wed, 16 Apr 2025 02:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL7RWfR0Jmn3vdUV1x5tjQ7UY4CwgQnA/3ppDAuag7LwaQhvR30im1cIwP+ZagX4rVl5lweQ==
X-Received: by 2002:a17:906:4f84:b0:aca:c9b5:31a8 with SMTP id a640c23a62f3a-acb42bfd648mr80170766b.45.1744794450412;
        Wed, 16 Apr 2025 02:07:30 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (91-82-182-24.pool.digikabel.hu. [91.82.182.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cd61a92sm87056166b.5.2025.04.16.02.07.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:07:29 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] fuse: don't allow signals to interrupt getdents copying
Date: Wed, 16 Apr 2025 11:07:27 +0200
Message-ID: <20250416090728.923460-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When getting the directory contents, the entries are fist fetched to a
kernel buffer, then they are copied to userspace with dir_emit().  This
second phase is non-blocking as long as the userspace buffer is not paged
out, making it interruptible makes zero sense.

Overload d_type as flags, since it only uses 4 bits from 32.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/readdir.c  |  4 ++--
 fs/readdir.c       | 15 ++++++++++++---
 include/linux/fs.h |  3 +++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 17ce9636a2b1..edcd6f18a8a8 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -120,7 +120,7 @@ static bool fuse_emit(struct file *file, struct dir_context *ctx,
 		fuse_add_dirent_to_cache(file, dirent, ctx->pos);
 
 	return dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
-			dirent->type);
+			dirent->type | FILLDIR_FLAG_NOINTR);
 }
 
 static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
@@ -419,7 +419,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 		if (ff->readdir.pos == ctx->pos) {
 			res = FOUND_SOME;
 			if (!dir_emit(ctx, dirent->name, dirent->namelen,
-				      dirent->ino, dirent->type))
+				      dirent->ino, dirent->type | FILLDIR_FLAG_NOINTR))
 				return FOUND_ALL;
 			ctx->pos = dirent->off;
 		}
diff --git a/fs/readdir.c b/fs/readdir.c
index 0038efda417b..00ceae3fc2e3 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -266,6 +266,9 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 	int prev_reclen;
+	unsigned int flags = d_type;
+
+	d_type &= S_DT_MASK;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -279,7 +282,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 		return false;
 	}
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
@@ -351,6 +354,9 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 	int prev_reclen;
+	unsigned int flags = d_type;
+
+	d_type &= S_DT_MASK;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -359,7 +365,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	if (reclen > buf->count)
 		return false;
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
@@ -513,6 +519,9 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
 	int prev_reclen;
+	unsigned int flags = d_type;
+
+	d_type &= S_DT_MASK;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -526,7 +535,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 		return false;
 	}
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..0f2a1a572e3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2073,6 +2073,9 @@ struct dir_context {
 	loff_t pos;
 };
 
+/* If OR-ed with d_type, pending signals are not checked */
+#define FILLDIR_FLAG_NOINTR	0x1000
+
 /*
  * These flags let !MMU mmap() govern direct device mapping vs immediate
  * copying more easily for MAP_PRIVATE, especially for ROM filesystems.
-- 
2.49.0


