Return-Path: <linux-fsdevel+bounces-69255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC4C75AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E877359200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02936654B;
	Thu, 20 Nov 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="MlnmexGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DDE2BF000
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659076; cv=none; b=eEsKqkJk8byEz53psOc0t08aJrDlEKrUIehmvA4Ms6NenVzwjJuFk+oZwaEmzjWM6FP8TQeZFfq2YXPJUqisOf3jlUIaHTgAY02T2hHXdlAOqxRqE6ycwC2Q+idiBWPldcweHk+hb3ypG6pAXL2YmW4Ev5Kk+lZwUJOtU3KelCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659076; c=relaxed/simple;
	bh=p3ApoAA1CanQQdozSlHOXOSokHr0N8H00lCqp1aC2iI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plBa2SZLMlGYhHEqtvGl8K1J4GvzGfeAUoKWkvmyUKHKNjH1+YP0rHhP/ri3WqSoVRsR69mjdh3qNqnUL0m8nEU+hsUuRBmKLKD+RZx7HAzWnqbPtBFwaGhakSi1IL7uN5O62CZ/y3xZd5TzeLqXhQV7I7nObCN4LHbfb4Dd+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=MlnmexGa; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29558061c68so15255695ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 09:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763659072; x=1764263872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxUmT50gh4iATr6XFekF1hQSSR5/JtG5gjuDPPL7SIo=;
        b=MlnmexGaMVr3imvxoJ4QGKECxdM+vAXKLmRiJQYIzLsJI671TUmLGe07p5Xu6rdLAz
         VBeJy/Hg8xz3XJgTc3/utqERb3/wcWZ0COG0LJ2kecUHYWOWt3t805xW5OLMi32bU33C
         vogr2jZfdEnJ0FTH/WEnYjSI2LU9+nwh0XLT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763659072; x=1764263872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxUmT50gh4iATr6XFekF1hQSSR5/JtG5gjuDPPL7SIo=;
        b=btoWx8dY27jY3LwTbgXdeSzhGlGoI6BJSt35CgeSrhEfVdokY3PVmlzWKGkkubLQ/j
         SwFfd7yIC3f+1rx7Xmajkc+Kas0lXzaDH6d1bFUYDBW7SaD7C0vh7Zdee7eofylKujkO
         5ORQPdPDlyGWNDv8LaK5jDWzcx5iRH9UetHu3ryITpTIkOd7HNJhQkkZvOS+2o2e54qm
         4qAk3PFmjSL/8FS5zeDxwtfOJui5fudvImA4hEAXprX4gSHTg7nGDGlX+YLqBIbLjPTy
         wJUkSgBvmGHn8SzhG/uGdUAvDzjBz/vpYcYyeboUbAlzWfi5mP6qRF/sWXPUOaXWquO9
         gj3A==
X-Forwarded-Encrypted: i=1; AJvYcCWaUM6CgUj21rgm+kIpXE2Ty33vMWRfrdctFBZ0e937fEWKiFtA/GGPhEHAtvRexnz2q9+U3Q6/+Zc9uyap@vger.kernel.org
X-Gm-Message-State: AOJu0Yzil3On+mXyhKiGqjREuIrXcGjCYEYy8sdhaMuSDkoV6wb2ITkQ
	kUqDy7m5bqHhkZzYQJIbcReMYaI4WJx/ihHbjt7gDlGnC7r28F0V77JlByCqBQiGQnA=
X-Gm-Gg: ASbGncswUcAxwrM0AnGrjpuy+3HtyZOiyWEe3cPtrzASSYRlElD7mjrFwtDdrY2EA37
	j4W8kKUPc/Q7tVVOPwZT3DPiFCSli0KdsjBlknXd6u/YnA1STU4wITxc9G/Bb2ZuwscgNUhr9yr
	u/FcwAZvbwWfttlktuEUKU1CnyBtjdhWX12wcAZjp1UxfjN2PVGg7dcKVYqtPymu5wY8234oN2+
	mgXQH37N5EBboS8wtWAUvZ8VU3VrZk8fhJeoWz0lyQzZ3+S2vNKpvpOmBn67xg88AA3tMlYTPBQ
	e11CaykJnLHPF8A//Q8rTum9402qrVZEkSdbCIr4Hv8D/6s2iMxYrxkNwWWUyehgcphONjlqP3Y
	hDjdXX8KjyY+ja/THRnTQbMx+iNdN0quQmlmQg3bsoFCamLGUIWMUMW7h1MpvgXPhWLCRVkyvL8
	wZqwOqYy0V2PZlZu9DUAku5sgDzTQ1QIUtiqWdTU4P4d/HzOPRaEf3/N0M
X-Google-Smtp-Source: AGHT+IHCvcH3jSOL7T+a7yDjy7MxfxbirT83K6TJhLThLkL3l4+krsnqHTMe0gk5zEdG6sGJ5ZT/Vg==
X-Received: by 2002:a17:902:f791:b0:298:3545:81e2 with SMTP id d9443c01a7336-29b5ebbf688mr43341815ad.22.1763659072115;
        Thu, 20 Nov 2025 09:17:52 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:1daf:dd82:99d2:95eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2700ddsm32223085ad.70.2025.11.20.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 09:17:51 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: fix uninit-value in hfsplus_cat_build_record
Date: Thu, 20 Nov 2025 22:47:40 +0530
Message-Id: <20251120171740.19537-1-ssranevjti@gmail.com>
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
Fixes: 1da177e4c3f4

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
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


