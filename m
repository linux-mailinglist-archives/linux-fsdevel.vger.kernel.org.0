Return-Path: <linux-fsdevel+bounces-43770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC654A5D76A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040C51789F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B51F4189;
	Wed, 12 Mar 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agJ+SOKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD41F426C
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765145; cv=none; b=tEK7JUjgZT/YUuHUcA/1VbeI7REJ/VeCisl5KjedB6M1eLG2YDU1IoHNIx1Z45WVO+uVpXxSYc7qCnIADodYWm8gLaKPWt/xovpljxFb51CNmuYi1r3uE4W6Vuyu+ka+TFWJSmpehfC5jrF0lwXa5F7J9aXZynKVpAQoOE3H88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765145; c=relaxed/simple;
	bh=dUT/Horn/xB9U4WtvRAFzbCih72mRsBFChhi1sdcDc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GlExFoG9EWi93Ooc/AoAF0g0EQR+cqM/SVa699G+GQOyl6rLqzlwJ+2K3+hA9blevYvmXIP3Ef/K+PaMynIl0Me1yuAXYtosQQUjNIaqtFxuK8CsaWKdW6Yd8rHlBehNdc+E/MfuSXTCqpl88JdW5qoQm5Wj4eWQ5k3b2iX8NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agJ+SOKe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso2826557a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765142; x=1742369942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03YOnOl88xEJBw85xWx+NVwio9Mn2vHchSpG1oPmc0E=;
        b=agJ+SOKecwZCWtBvWWY4Qf/A31Eyl4HeGFxltQmv+rxjaGTD2s+5C5RE44VHPr8yNR
         /X1xps53gkS8axzeuOi5wNeSYxncwMhU3Gx1PN5eskSADT7xYCW06OrmGqFiby2AJ00P
         Ra0HlXJE5PLvIIcMHlbPB1YOwibrDdxhXsdkieo88zbxc0GjPnHIO+FiOW+ktGthM1yG
         SxkrJKzNLef0aLzkeaCJbELtxoXIu+rREMKxJzYxW/fkFwCYczX7INyW8GRg62+QWcYR
         5cObaGmoKa+pp+n0LNrwsPSYlTwzN90xYu6AJN2pp8j/I4/2dwHnJbeagbytF7V150vd
         /6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765142; x=1742369942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03YOnOl88xEJBw85xWx+NVwio9Mn2vHchSpG1oPmc0E=;
        b=V4nhk9ij8phRHwutGYJWSLLKmQEAtcbZrJU88GkR/fyqCnKa+G4v75b3fcuUBc2uI5
         PkJRMuFVJkZ7lAZDqusDuQxRTjNqBO2MgulkwGaiDbtVoAcWQ31SgoevAwt8mltTmICQ
         MhpVUswjF0GDkPzYi0C4u9s8jTvBFmfJY/871Hj87zK2scPlHN/t1RA2x5sk9SvjM7vT
         +oybLEVQF/dNBgOwgQRWLPurihY9wqdIFYLceHThX2fhR6G6Plb73nWBP5RE1c0/wu6s
         JuoLEBB3+wvVxUuYXF9/K/h8My2adK8RJzspHmgGWrNnNFk8ZC5vVh5A6MWHzzht9njq
         f7UA==
X-Forwarded-Encrypted: i=1; AJvYcCVIKCcPuDwrtzZWg6nxSUEiF9HiSAK8ZzZ3sZoevrloCmc6GYPuPf9IltogASXkd5m/8IYvy7gBEQqMB8o7@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgNyu8OX/B+RWtUEDeskl3dTeJ8brX1JnTsXi61mvUT77McOO
	A9lbIEe9BF9QhvG1wR81hewCCJcT1jO+/hZ3WqsuOgYTYOhGwkPa
X-Gm-Gg: ASbGnctSk8mVLVM4Tihwr5kMg/CK8YYq0GNvbqBnUPX+iK95JC49YR0qW9sy8UNgdRN
	ss761UXJ4a8gKf81yVB6UU9ExhX19N6dCwFYMb0w5ZKe9DOVYSaUmNalVCWUrSzEO5OCJQ1hP9L
	Mo1SbXQLM2Usww1M5u3+sDiYOIJDJ7i3YsEAVXBY3rJedeMGzJsRhgDV3MPB2I+L8WNrR7gIFSJ
	1DpuKR1xJ7I44el+aejx+O2LGVQxNhhvayU9zF5LvRIWyXZmZEgEnGX5RkDG1VUN955CBAXodH8
	LA4xe2HBJdR0ux79YCGVepjAn24b84Tn06HDeCMpUEu3Ma/cAct9j8YrW7LCmPW+nCwLNftJ+9s
	absST42AXmoHvCupidHGxMqwmyjdnaNu5MNl88DRwgA==
X-Google-Smtp-Source: AGHT+IEE3JbAnv91rmuTF9IPY3BS91QrQYDjUUWN6zCqGM1f82UcL5DCcGUwsefyz04t9LtyjTUApw==
X-Received: by 2002:a17:907:6ea1:b0:ac2:b414:ba2a with SMTP id a640c23a62f3a-ac2b9ea18eemr1048918166b.37.1741765141377;
        Wed, 12 Mar 2025 00:39:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/6] fsnotify: add pre-content hooks on mmap()
Date: Wed, 12 Mar 2025 08:38:47 +0100
Message-Id: <20250312073852.2123409-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312073852.2123409-1-amir73il@gmail.com>
References: <20250312073852.2123409-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-content hooks in page faults introduces potential deadlock of HSM
handler in userspace with filesystem freezing.

The requirement with pre-content event is that for every accessed file
range an event covering at least this range will be generated at least
once before the file data is accesses.

In preparation to disabling pre-content event hooks on page faults,
add pre-content hooks at mmap() variants for the entire mmaped range,
so HSM can fill content when user requests to map a portion of the file.

Note that exec() variant also calls vm_mmap_pgoff() internally to map
code sections, so pre-content hooks are also generated in this case.

Link: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 21 +++++++++++++++++++++
 mm/util.c                |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 6a33288bd6a1f..83d3ac97f8262 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -170,6 +170,21 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
+/*
+ * fsnotify_mmap_perm - permission hook before mmap of file range
+ */
+static inline int fsnotify_mmap_perm(struct file *file, int prot,
+				     const loff_t off, size_t len)
+{
+	/*
+	 * mmap() generates only pre-content events.
+	 */
+	if (!file || likely(!FMODE_FSNOTIFY_HSM(file->f_mode)))
+		return 0;
+
+	return fsnotify_pre_content(&file->f_path, &off, len);
+}
+
 /*
  * fsnotify_truncate_perm - permission hook before file truncate
  */
@@ -223,6 +238,12 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return 0;
 }
 
+static inline int fsnotify_mmap_perm(struct file *file, int prot,
+				     const loff_t off, size_t len)
+{
+	return 0;
+}
+
 static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
 {
 	return 0;
diff --git a/mm/util.c b/mm/util.c
index b6b9684a14388..8c965474d329f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -23,6 +23,7 @@
 #include <linux/processor.h>
 #include <linux/sizes.h>
 #include <linux/compat.h>
+#include <linux/fsnotify.h>
 
 #include <linux/uaccess.h>
 
@@ -569,6 +570,8 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	LIST_HEAD(uf);
 
 	ret = security_mmap_file(file, prot, flag);
+	if (!ret)
+		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
-- 
2.34.1


