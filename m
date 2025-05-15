Return-Path: <linux-fsdevel+bounces-49150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1CAB89BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3726B4E6E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F231FDE00;
	Thu, 15 May 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJSB+/tF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B112CD8B;
	Thu, 15 May 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320370; cv=none; b=UbzteHn3DAvC74baxmweDynuda6cOoeFsCd0rOflxoD/avUXOn7S/JerTKbSaq/S162BhlBcnoUgYpFQ1eGE9rzLYWdJbdgUW4f7ZZD2I+ecWIIirdmz3KzhCURr+pc91T8qRvi2OOa8Do/f0PEs6NWpwBXkBQJl1rxnaZttNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320370; c=relaxed/simple;
	bh=qy5Lsv+8bg5XtirxFaxWUek6uWiiKPkj1UI/BETJAG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFFNpZP9J7g3rpntscQuW8PEdISqZV+L7FbekBwS0n7x60McENEw8AlJDGhvacAL0M0iXNT+la/p0RC12c+ZKDgAvl4mjNv9Z7f4ROKQhocn548FUo1GTPZa4HarUgdxsbofI5mQo4NA/cTEL09aK1sSnPsWZ0igryFRQjW//aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJSB+/tF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so1087492b3a.1;
        Thu, 15 May 2025 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320364; x=1747925164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzSbbiFQm2kwqOByIvSZFOSSFh0n0db4UJIuluy1TUs=;
        b=kJSB+/tFif8LEhfN10LoOzsUBpZZzlTr3RcXeYV1/wPyGHx4Pa9CVIODKJSzVRweGU
         +DNnmfu0QJ/6VM02Le1z5j1FPn8iV9KCQ/XRh0LJuDnjD7sy6DyVVvTTCVZ5frQGrbeI
         t0PT30SgRV7YYwRFwIXIrTMO6nkctDvds/KKHwXy73ifnMo+g6TL/Zn7VP4yHQYK7h1k
         I+RpVeN4wDOg7m+TtA0tecQvHG2oFIClBvhOO1bQ5JguBj4z2JmzDhszxbNNsvFE2lTu
         YDfBCU5IrtlSJ6z4hbQod74ONleh6NdQ9NTDPOZE7haJjVVPRlsxdUKiSi6wQfEiiL+m
         UTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320364; x=1747925164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzSbbiFQm2kwqOByIvSZFOSSFh0n0db4UJIuluy1TUs=;
        b=kBXRppm2aXiEGGbzdS/pnRUGFl7+2ghWumKhEl+g1czUlsuKGJF8mQXg1TdhSvRN+N
         tVi3Y1VY+cwXllUy72T/locc0AurbRIHmPvEQOAJl3DVwFVE6k81qWgcA6WIrU5cRO92
         19X5f5hSZV3wOy2G6cvjakn5yWK6yIAqTiPISsyY9odvUu6RR86Y/fg+308DsWQg7Ntm
         9zuMKaTM8ucvzZ3CSomNmywmHEQdLshzeGKDV6dnetwgf0cEV2zsXWNhGmBSdTgqQkXM
         DuRr9GWY/TG4cgv3I2RR8G3G6JAyF4JGgTaVPYefhdwWo/jmGqYAX8HEzrJBkFApfbBP
         W/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVygtHdkLz9jHd3a+H6vpduhETSq9G9CfsN4T0hL2KfiAH6wMfuzFKdnnIqPDYVYowUC2qi57xkSpgty7eD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NprH80i4OB0Abg6ecq+IpyK38XWvgtS7kKeznfKJeIGEsVWp
	ax0Iq+8gQwLSrHzn7prVHkUXhB9Ko0xNx2wZbTPMk0unbBjQEHy3JmgGKg==
X-Gm-Gg: ASbGnctFrQovR4BISXcbZ/WpUVlP+pY7ig5D07xX7xeBeZbJRCv3fJLFzaC58F5L8kj
	mY9TfO40GWkypmNwkk0Y5AyTcLU8yp/mPR07FTrevMql8D/XRbi1/MOjCWWL9EfZv/gg4311qlk
	JsTWHk961uYnXuWCAVvwRjwMk+QCncsighEqZMjvpiLo9OPl9I5F3xRQMSpvDunyXfCyaVA0Dxn
	6Ghb6hDokW+gif7OC+3bpZHtGtPblDw8QYo6hacSkoxlQV1BVHOg7n+31Ka1rP6VmaSb2GSorBd
	bRZybAfuM7dRsCB3yOPUfK5dQ1pKoy5c4/tF+tAsuA9zlfN4Zg3+HY5gEbh/f2xSvKA=
X-Google-Smtp-Source: AGHT+IGJN8OYzfhXTM+harcFNKz8r5fqt5sb4R9gmQ9vQFkPN7PVjZPelRBMQljEa/y9aEVaxK0Qag==
X-Received: by 2002:a05:6a21:700f:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-215ff0933a2mr10204127637.5.1747320363677;
        Thu, 15 May 2025 07:46:03 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm3451a12.17.2025.05.15.07.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:46:03 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 3/7] ext4: Make ext4_meta_trans_blocks() non-static for later use
Date: Thu, 15 May 2025 20:15:35 +0530
Message-ID: <23ce80d4286f792831ce99d13558182ee228fedb.1747289779.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747289779.git.ritesh.list@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's make ext4_meta_trans_blocks() non-static for use in later
functions during ->end_io conversion for atomic writes.
We will need this function to estimate journal credits for a special
case. Instead of adding another wrapper around it, let's make this
non-static.

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/inode.c | 6 +-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c0240f6f6491..e2b36a3c1b0f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3039,6 +3039,8 @@ extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
+extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
+				  int pextents);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b10e5cd5bb5c..2f99b087a5d8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -142,9 +142,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
-				  int pextents);
-
 /*
  * Test whether an inode is a fast symlink.
  * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
@@ -5777,8 +5774,7 @@ static int ext4_index_trans_blocks(struct inode *inode, int lblocks,
  *
  * Also account for superblock, inode, quota and xattr blocks
  */
-static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
-				  int pextents)
+int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 {
 	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
 	int gdpblocks;
-- 
2.49.0


