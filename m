Return-Path: <linux-fsdevel+bounces-44487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A0A69BA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 22:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318961889568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FC215F76;
	Wed, 19 Mar 2025 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYFnirrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B382202971;
	Wed, 19 Mar 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421493; cv=none; b=foOeQs5DupG16LKqzZgAxWOd/k7a4Z3OFH9j+M8Hj6ps86l4RpFyPqOHHnqb68HHWXxNiBmeNrUukC76XQT1SQ9R55mGLAdKgbIFbR3OzI9Om3ir7bAdOJnNS3Y0HkAziOsmhuLzFcfoIlsS6l6dIsuYk9sfbWAQy88/oVVsug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421493; c=relaxed/simple;
	bh=reirojTkhDeC1tGXLTsL2pCK+rjM7W+CwP4CEu4J0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiBLodl8TSqE427ylujrkB8II61XoKmCnkATBP6mJZw/gvYy37rXDUJrWiExSioZA74fmb0wn5hgoxjGVm10UdS5h+CLsT9OTSUFgD9P8SrRxBTuePZlUQoCYe66GDKNFJoaP2jJyTEvEdjLPLCdnNUlIVVlfmCpqMjYzrK4M68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYFnirrH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912c09be7dso44362f8f.1;
        Wed, 19 Mar 2025 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421490; x=1743026290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVCj1Is338n0KWDW9Dj2PotsFH7wGpEm6aG91ZXaz0Y=;
        b=lYFnirrHpmUKwgFgozVDV+zhEBMdc3aaVz3N9FJbb7dd81iW//bz3p8MsTn/m6c1p5
         6bImjm0JxoXl4Ar5LU5wX54QMRApQOzxv+YgRE+YjUjQ2U86DzUtx31fvS+jlBU9AE9H
         HXpkf4JH+TZSIqUMxdxjGWIrAc6rDMX/Goez0mGroAII7DBGSe4qXpBv70oDjsbGkFP0
         t1jcxVZKUwIRmW+vcmn8zwMRSHPJGDg62WsnbJ2qiT82ufueGgNmykyMkiIElnQ/PL4/
         iLGcTvwgeU0gtRLf+ZCJPqhg5tlcfwkpZRSVyvCzzYJr44lUoCs5IQ86mY1rTdnWELBE
         TzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421490; x=1743026290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVCj1Is338n0KWDW9Dj2PotsFH7wGpEm6aG91ZXaz0Y=;
        b=anfdNeOS7JSnitno01yMkoZCdNoxF0QW/fnCjFkxkshF4ey/6aKrbcunGHesxf6vq0
         +6kaf+RG26/HNndyahjzVOgnth62S3LHUJl2VIj8womcBcZf7OLjvKmaXtRsY1hkRw/X
         ftDfKEKscRSWyK7PiOeAchCrmyfHn6NBNdK16+VvXqotMnkB+yatN8BIp/HNjoDwBPew
         15mTux4pvKsVV2gPf02RqoGBagUJBoOnh1CwxF6g8/Ilx2FZGswmHDd4HDOaJ8LsH/HX
         vLFfVHNNspg4DDGsV5Htk4151oTzxCHEkYvjG3vemkIA5x/7NQH5TPEd1NdEpoRSx3Qh
         nV3A==
X-Forwarded-Encrypted: i=1; AJvYcCU+X+ioOQf7WL9TBWXC6b0OkbdQ3QrcrqiGCofgP2b3Z4m5h9MaiGB3ui3pzZfJsRkgdq4uSphHC7bloT5j@vger.kernel.org, AJvYcCVUs3Cr/o8pCqqCgd/oqCPEwjW61DHvsA90PUSrBC9v6PMtwLu8sYNicYDEk6dLeX+0cyB/qyrQxt06wDez@vger.kernel.org
X-Gm-Message-State: AOJu0YzHejZDu++AEa/FVGpxYotjpSfe2YhfI32CMruCnk1QrQFefFma
	ZnBQWT3ussUJQe2L1Kfer6S+c03qqTbrM2kc/akzO2irfLpB5437
X-Gm-Gg: ASbGnctvHSHIHYlkZNTXaz1ESZvqGWzANXir/Qn6my+ttLfVnfB6rq/yZa3dKa0kUk5
	o/GXAqcbU+cjhwCAC1ET4upJA/gcDUW0+1/2I4SFGPv6qHCVuJbyFq+w/cVtTwmoxkD/qrXlmSY
	rX1WQhqyemM6qDSmDRojmoD327/LcOB9Jo3DfH0JKx1NGRT3/ZCroA/f33GTF7VD5dZW/mwtuJl
	6iNela/DUhsQOWkuqXaDbQWIso9OYu58oRF2FrVUTczJNUlcad3GRCEkPZf3A3HeDA/gufb2Ef9
	QSrw7S2daTRYi4Z9o8POL8d8RpGnsQwYkn3zAncEeda5z0cd0rydT0dzoTX2chc=
X-Google-Smtp-Source: AGHT+IFHrCBcbSCe1m+3NYf2Pw/VO1JOx9ZTNUXHRl4WP234S/88h4HbEMqy3rJ9iykViJDmz45y/w==
X-Received: by 2002:a05:6000:2802:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-399795a9a30mr743685f8f.21.1742421489616;
        Wed, 19 Mar 2025 14:58:09 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881187sm21659976f8f.41.2025.03.19.14.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:58:08 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: reduce work in fdget_pos()
Date: Wed, 19 Mar 2025 22:58:01 +0100
Message-ID: <20250319215801.1870660-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. predict the file was found
2. explicitly compare the ref to "one", ignoring the dead zone

The latter arguably improves the behavior to begin with. Suppose the
count turned bad -- the previously used ref routine is going to check
for it and return 0, indicating the count does not necessitate taking
->f_pos_lock. But there very well may be several users.

i.e. not paying for special-casing the dead zone improves semantics.

While here spell out each condition in a dedicated if statement. This
has no effect on generated code.

Sizes are as follows (in bytes; gcc 13, x86-64):
stock:		321
likely(): 	298
likely()+ref:	280

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- split up conditions in file_needs_f_pos_lock
- fix sizes in the commit message, i read the offset of the last
  instruction

 fs/file.c                | 11 ++++++++---
 include/linux/file_ref.h | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index ddefb5c80398..0e919bed6058 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1192,8 +1192,13 @@ struct fd fdget_raw(unsigned int fd)
  */
 static inline bool file_needs_f_pos_lock(struct file *file)
 {
-	return (file->f_mode & FMODE_ATOMIC_POS) &&
-		(file_count(file) > 1 || file->f_op->iterate_shared);
+	if (!(file->f_mode & FMODE_ATOMIC_POS))
+		return false;
+	if (__file_ref_read_raw(&file->f_ref) != FILE_REF_ONEREF)
+		return true;
+	if (file->f_op->iterate_shared)
+		return true;
+	return false;
 }
 
 bool file_seek_cur_needs_f_lock(struct file *file)
@@ -1211,7 +1216,7 @@ struct fd fdget_pos(unsigned int fd)
 	struct fd f = fdget(fd);
 	struct file *file = fd_file(f);
 
-	if (file && file_needs_f_pos_lock(file)) {
+	if (likely(file) && file_needs_f_pos_lock(file)) {
 		f.word |= FDPUT_POS_UNLOCK;
 		mutex_lock(&file->f_pos_lock);
 	}
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 6ef92d765a66..7db62fbc0500 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -208,4 +208,18 @@ static inline unsigned long file_ref_read(file_ref_t *ref)
 	return c >= FILE_REF_RELEASED ? 0 : c + 1;
 }
 
+/*
+ * __file_ref_read_raw - Return the value stored in ref->refcnt
+ * @ref: Pointer to the reference count
+ *
+ * Return: The raw value found in the counter
+ *
+ * A hack for file_needs_f_pos_lock(), you probably want to use
+ * file_ref_read() instead.
+ */
+static inline unsigned long __file_ref_read_raw(file_ref_t *ref)
+{
+	return atomic_long_read(&ref->refcnt);
+}
+
 #endif
-- 
2.43.0


