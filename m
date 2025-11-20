Return-Path: <linux-fsdevel+bounces-69261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A431C75F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94CB24E06BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F322222D0;
	Thu, 20 Nov 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="b3GWxKoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE91F8BD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664386; cv=none; b=c+zFS02vLwwu6AdAMkLSO3mCTOHby4/qEEmRwtkUARyP4xE1pIeY3fi/HVRwN++phxPFA09zDJSPCmkGO+dwUdqhi4mAQGO5QyrpDpNolj9xZ2ZIT3a3n5W3Vjz05Xjv1Zu3lo4qU5jfmJXiD6DogHxtrTb7A+wSWbfH6TcQQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664386; c=relaxed/simple;
	bh=WIwRUSH7l4qlGCKFZPYl8/u8vLgqjJN71XMPndirieA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B1kBG0jZ4RcaXYO+0SvrWkwvZyDDGlROjY42BOQ7fOKzxaWVSSteGTnf1RzmYOm8eWkaBEtEgSeArtR+ALUXOuFHmjAtunQzTVaeFz8A8waoMBlLO4+gFFgjygbikwjZ3PqsIqkNxVgkQh2dFq+QCz5+nitC6QdAn39f8oKiWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=b3GWxKoI; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7ba49f92362so822408b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763664384; x=1764269184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DECYox+CapSATqMptNWT/nLrZzGas6t+p+j6f8U0w64=;
        b=b3GWxKoIDaPv+u4eHM2QtDJj3tF5KP4yE3l2CW5mXquqjh/9BNOEqCkRHAAMywvFfD
         YsI+20wlfvszBRyV1KYrkDYZ/8jQwC+fWeZQdYSAfQMMWrOD5ZFj3XWUDbmCYfXK0S+7
         l+UAZX4sj8ShNkh7ZgNppKZtntNoN8cXRdet0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763664384; x=1764269184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DECYox+CapSATqMptNWT/nLrZzGas6t+p+j6f8U0w64=;
        b=Wp5vu3T3fchlp3v1xufQ3j6UpWQ64gbBuqCJZMxGuU8cD6+rKMsMls+QDCECuytdOy
         twmiatxkdI/ArmB2qhvWA1edtyzfTIB+koJeUM9X5KuUVabhsRXMnEmqbglpQF67Son+
         TxPJNX7Q+m/7FOsr7Sy/CW+HxvHMCSFGREthWRfbIcJS84qxfqnp3piNBXAFZlIwEyx1
         m+Zwj6LC0lTueAGRbKKiTWzNDermKM+4JFZFn+n8fWynCxAvb/88QJHRjq668rGDgmO0
         wu+1no5KDzXrUErfYcfnyxmMIM8gyIxc0CepSqvJlHY+Vt7teb/FVC3cNZBao5dShfrq
         +JHQ==
X-Gm-Message-State: AOJu0YyIYI3a3GugeQzxj8wC57SkBQNEW0kGLK3gyEqJDM9JIPvP1atS
	kwBn68jepQ+ngaBnoasg0/5OPWWOQ8oflPq3Ruw5qeAwHoOENT48nRMifBYxt5BmNohxzkqFCSw
	JOte6Nee/HIYb
X-Gm-Gg: ASbGncvjTNXQRCLl7HpD2wYzDld94MF6Qts5EWBSdpy1o0PnMN5e7ejgspj+gDiDxem
	il5YieAb0zOixpcqSW2CIWILHr6/xW0Qm5aBKJuKXbnHroorwWe+r2u4Zve6VoW0EDsBE7uAtU9
	vi+bp9OmdWXvfDA/FCRyHGpbBkRkIZ7zH6VLUjbFteFBv2BhNbXdRPEi4bb1ePnBfiY5xJj7Cuf
	OfaO5GwbEW3ab3dcB75G2OCBY5BWgTMTkgbxzHfbhZMtWiiygW+gV3NEWRJMYsj5SBtswXOc3I8
	jiqbStmTwewEv7IxQPno2UBv5LeRQ32xS6ZY151dhKAkCBHZWSxex8IWu0eV4H8HDBg7juuF7N0
	URyd+DOzwHUq2ANJ4cGXbHiskoE5U+VO1Imj8LiIVkb16cT+q1tc76JxMz06C6IwUYwfjBTmiz5
	6ob8Q2s+A5HPZscSQoSzo0d0eyfKOlK5/VuQLK4xVwQAg7cMxAa2VeLvM=
X-Google-Smtp-Source: AGHT+IHYPJDcnzHOf+yWRwdg9QPX8Vu/d+tWBeV5wmp+wzw4tQt7hYjMbzzdxhsRpJSxJlxFF8PFgA==
X-Received: by 2002:a05:6a00:23d5:b0:7a2:7f45:5898 with SMTP id d2e1a72fcca58-7c41d71b660mr3815269b3a.3.1763664383889;
        Thu, 20 Nov 2025 10:46:23 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:5f:c291:79a8:a36:eba6:e322])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f095c237sm3562119b3a.45.2025.11.20.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 10:46:23 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	willy@infradead.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
Subject: [PATCH v2] hfsplus: fix uninit-value in hfsplus_cat_build_record
Date: Fri, 21 Nov 2025 00:16:10 +0530
Message-Id: <20251120184610.28563-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

The root cause is in hfsplus_cat_build_record(), which builds catalog
entries using the union hfsplus_cat_entry. This union contains three
members with significantly different sizes:

  struct hfsplus_cat_folder folder;    (88 bytes)
  struct hfsplus_cat_file file;        (248 bytes)
  struct hfsplus_cat_thread thread;    (520 bytes)

The function was only zeroing the specific member being used (folder or
file), not the entire union. This left significant uninitialized data:

  For folders: 520 - 88  = 432 bytes uninitialized
  For files:   520 - 248 = 272 bytes uninitialized

This uninitialized data was then written to disk via hfs_brec_insert(),
read back through the loop device, and eventually copied to userspace
via filemap_read(), resulting in a leak of kernel stack memory.
Fix this by zeroing the entire union before initializing the specific
member. This ensures no uninitialized bytes remain.

Reported-by: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
Changes in v2:
- Corrected format of Fixes tag 
- Removed extra blank line before Signed-off-by
 fs/hfsplus/catalog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..4d42e7139f3b 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -111,7 +111,8 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		struct hfsplus_cat_folder *folder;
 
 		folder = &entry->folder;
-		memset(folder, 0, sizeof(*folder));
+		/* Zero the entire union to avoid leaking uninitialized data */
+		memset(entry, 0, sizeof(*entry));
 		folder->type = cpu_to_be16(HFSPLUS_FOLDER);
 		if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
 			folder->flags |= cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT);
@@ -130,7 +131,8 @@ static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		struct hfsplus_cat_file *file;
 
 		file = &entry->file;
-		memset(file, 0, sizeof(*file));
+		/* Zero the entire union to avoid leaking uninitialized data */
+		memset(entry, 0, sizeof(*entry));
 		file->type = cpu_to_be16(HFSPLUS_FILE);
 		file->flags = cpu_to_be16(HFSPLUS_FILE_THREAD_EXISTS);
 		file->id = cpu_to_be32(cnid);
-- 
2.34.1


