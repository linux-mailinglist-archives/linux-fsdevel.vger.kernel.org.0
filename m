Return-Path: <linux-fsdevel+bounces-72147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF67CE5294
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Dec 2025 17:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA162300A87D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Dec 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE921767A;
	Sun, 28 Dec 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZenBnDJV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FC207A20
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Dec 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937860; cv=none; b=WMmOelsSHojWS/y0+eyghQq/aHSxjHGijKXZyg7eVm13pYHXgNi0iQh31mMQ8QVpaGKpWu1d8PEVQHrGnJYlkamU3kQyGuYlIsHpwwTZ7oTeBzmPVDYDmofeLrvX7QPbb5UdsimuaPnMhMvIMDfHa6MrbTJofa2GBpagcR5kHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937860; c=relaxed/simple;
	bh=0g5FqN/rkOiZFe9WwucAUU+cUZwTdOzUAsQjlujWoHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JYoNkLiFaOWkz7TK4tYQIRlyEIf6uw2omM+LCQohMQspB0DmaKYyvfk09OZfZb/fUmmovKrnMMTXaN7KRdd7zYhq8toxt0mhk9Yjgnkl5+DVPWDDZPzGX35t7LaJ17+8wBizkRCPjKczAt2CWFMYaMQg7jUZOM0E1Vte1vUVM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZenBnDJV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34abc7da414so6998825a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Dec 2025 08:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766937859; x=1767542659; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MX67VFPBKvZMeuzSJbgA+xToCTH8S/+0RCQrFqbWcNY=;
        b=ZenBnDJVRwqU/3SOKi49GxnH4hLPBQJPFQFNzmMtMWM5eYHlyXK0TODRT2NM3po1Le
         zqORoC07t5b3rxnRYy2clcUGWVm7BcNKpi/hM+L2Qw7Pmxmxt/z5pa5gvj9Xev0kUi8O
         jPyNhtk+rVOuvi/+JpFofVrZhsuHfKjkJ5YxZmQwZ4MKyQd1xsTGtoaN71d3BViF5K3c
         GSpJEbL7Opv2/A4nGjbo14Fs289nIpU/D2nRR8z5/cN8pz2yCXNK5GZJ0//mVtPXmBUI
         caE8PbsLnReNFd7yCOzrvguqv29DwKDGmJ1K97wKWP4/B0YFt4R+SxK6/j5wmy+kgmcB
         jQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937859; x=1767542659;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX67VFPBKvZMeuzSJbgA+xToCTH8S/+0RCQrFqbWcNY=;
        b=d4KjkyPCH6Orok4wcaEpcUEaLOIb5oQ99Vrli5myEKqxWVfsI+h8KikFJ+P+O+RhGB
         eUPdytUXJAYpa9ddBt3yoOLxV2Tv9IdLmqEa9W2jB2H9pAZHAmC+FtnHb98H1N+n4kaw
         uL+KQMkP3yFZWZOHS1D+lAU/mve8U3gH3ADEUB3Yg11qiTqJnCYGU0B0TnQdBcBEmqYd
         d1iPNtXYnFTswGwrMFJv3rKQmkADlsGmmYQe/aafbecn53p1unto3d66Jw3s7IRYXSlB
         HLGMAEz8tBCxSENYT2qX3Pzc3A5zqHKN9GeqsmlJQuB6WTyRhDOR2YUQhl5lYJKNj+o/
         9RZw==
X-Gm-Message-State: AOJu0YyHTMmX/3e4QbCN590z+4eRxl7+DtcjTPt66LwUPwLXkCI2odL2
	nMOsdj9sL0B9SGDAu5WwPfu8S02YXM6T4gTbCSblgQsZfy4w7oMICK0A
X-Gm-Gg: AY/fxX4K5ubFGapVPoWqwlaGWK0fKMW9idjpAO27rPxWHvFvQymdiyDqA0s+d/bEFj4
	u4DVgbFMDDFcflFYUD8Jt1WVK4hIch/MDvx3PctUKpadWR+CGVddlbZ9Em9TnUuuaTWwGD+GyLo
	snwxec4IgqJViAbbY4UBPM6RMTBdenpdpWlE9Li4uPVHIMwPCMxLfMI4+hzvugF6YJRsS2R6RNP
	SemdG1S1jf6+rD60EyLAanIq1+0OmhOlLhe+hNDOoQYWrKL/pC85Eb6zchn88ZTXGfqKghFaC4Y
	T4MgthuY0XO9ooN7+IyO8zC/y/1bxLkn/w+08Yv2F7tdjcDL0pODTfRhYVG1tfhCH9U7qNQdr8q
	Ziy0L69Cp8G1rZYkFHdlyf5OJLy5IGvTP6DxXx6YRsoyYMHEQndyf0E+18UNxym76VcobfEBbw5
	SphNKkYeXbs5L0vTaFgk0=
X-Google-Smtp-Source: AGHT+IHM+TWbM5664Wh25HgkAhOwA9g/o8G5+DcxzmekpUzA4x7/rDMZHaMAkbWnj+3GASKlt92+MA==
X-Received: by 2002:a17:90b:35ca:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-34e921353a5mr23123485a91.13.1766937858523;
        Sun, 28 Dec 2025 08:04:18 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769c114bsm14929709a91.0.2025.12.28.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 08:04:18 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Mon, 29 Dec 2025 01:04:07 +0900
Subject: [PATCH] inode: move @isnew kdoc from inode_insert5 to
 ilookup5_nowait
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-fix-kdoc-ilookup5_nowait-v1-1-60413f2723cf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqEMAwAryL53oANiuJVRBZtowalkdYXiHffs
 p8DM/NA5CAcockeCHxKFPUJzCcDO/d+YhSXGCin0hDVOMqNi1OLsqoux1Z+vV697DiYytmiqIa
 RLKR8C5zc/7rt3vcHio9rtGoAAAA=
X-Change-ID: 20251228-fix-kdoc-ilookup5_nowait-b17dc447bf2c
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

The commit reworking I_NEW handling accidentally documented the @isnew
parameter in the kernel-doc for inode_insert5(), which does not take the
parameter. Meanwhile, ilookup5_nowait() gained the @isnew parameter but
lacked the corresponding kernel-doc.

Move the description to the correct function to ensure the kernel-doc
accuracy.

Fixes: a27628f43634 ("fs: rework I_NEW handling to operate without fences")
Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a455a2d09caff70615032213e3dfc..68056473d65ed4beba5241f4b1bac79b29cd84e9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1278,7 +1278,6 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
  * @test:	callback used for comparisons between inodes
  * @set:	callback used to initialize a new struct inode
  * @data:	opaque data pointer to pass to @test and @set
- * @isnew:	pointer to a bool which will indicate whether I_NEW is set
  *
  * Search for the inode specified by @hashval and @data in the inode cache,
  * and if present return it with an increased reference count. This is a
@@ -1593,6 +1592,7 @@ EXPORT_SYMBOL(igrab);
  * @hashval:	hash value (usually inode number) to search for
  * @test:	callback used for comparisons between inodes
  * @data:	opaque data pointer to pass to @test
+ * @isnew:	pointer to a bool which will indicate whether I_NEW is set
  *
  * Search for the inode specified by @hashval and @data in the inode cache.
  * If the inode is in the cache, the inode is returned with an incremented

---
base-commit: d26143bb38e2546fe6f8c9860c13a88146ce5dd6
change-id: 20251228-fix-kdoc-ilookup5_nowait-b17dc447bf2c

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


