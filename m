Return-Path: <linux-fsdevel+bounces-13356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE986EF3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7068DB2514C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CC1B971;
	Sat,  2 Mar 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbMtpa69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0311B263;
	Sat,  2 Mar 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365370; cv=none; b=sbxbR9kLf+qmrDozH0yXvmDvxu3KlX9SAdOm9PKz8WiJ11cR8YkAdfnh1K6AOEbbKe88EIbOq8pwobIO8Jq/Z297O56wwjWIx/GqSjUvp1ltSv0QaQiXc0zuLS6bweBklGMlljcw9yBY1+u4ZQfkp5UmD4MU15uZxsvCQYWdvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365370; c=relaxed/simple;
	bh=UEhxsrf39s3LpCg+dRj/c9p+DSGoMMdYusEHuKqzBcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejN+oBd11xPyrT9imu8W5TT/EOtaYQL8YJbOiHxg9eFnRxnec7GqT/guNKX5oViyqXwrgV9SdqKmBlVdKRinoCEKMn1SmI9SFNUGfiEUJYECOUiZQlrDkPNqLCgjAOcWsN9Oc3dY0bwNvd+AaKsMO+Sml7C4RWAykz7s95f7vHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbMtpa69; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21f70f72fb5so1934679fac.1;
        Fri, 01 Mar 2024 23:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365368; x=1709970168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPDq+e7qZZNUe2lBOgjexuQEg62+2SvW8S4Hg2hx7P8=;
        b=lbMtpa69SB34xQc7612j38A4KBcghi3XwxfJuYqEoBio6bKBzhX8/7X186gvXVsmj0
         oxdkpNr/6i9/I0qRdBso528lWFWv3V77X5BwnE6ZJwuFJcPuzk/ShQkDjqTAlg5H+/xo
         GgASx3zz+DYzztxJZuf4237ms96FPYSL33ZMlyu+hN5KwkgweeT2bl12F5COJM7/D8qD
         uu0zKCc0bqjuVHo78w72bKrurLgFWT8br5Ih/oIfAryM1vJ0tJdxrP4HIpMj2AJKT/+c
         DSjb+robR+Opc9AwbPJC0lVYsR+OqaMaSLGg+wZ8qvZCLsxOtHpHa7laf6amk11VuThS
         mCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365368; x=1709970168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPDq+e7qZZNUe2lBOgjexuQEg62+2SvW8S4Hg2hx7P8=;
        b=mha9MbGDZe/9RMCqsa2hOruBEZKz78UBTO2fIhXv65uXN9L7IO68UVGq0Mi7ZS9bf0
         NwycfR/RvkI3Q43SX1YXXrxrBMPkjKe3AYRBto0t0eBQJYBMfOBU/jGunBcC9FkQUEHe
         lEZ9Yx/VC2cOnp2UQ6bhSrNiGUjXIOF0wl7CwA2m20Sb+Ej2hVCsSfNMFFHrb3oIJNIR
         /EA3uYcmPJOvn54Dc3wX7KhuquPKx7LVMxpGiO9ZdpDjitt8iBtAn/WO7lfYIuar4Ywr
         4IvZQSC3uHjJbeY82MruK9dvo2p5ZFmSaKRLmsn7d/bNsHk/KC/CX0GMrM2EySk2uYSz
         wMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUcWqLW1imGthmURhTzjLpVP/lcTSGvy+y4d29JijkP9XNO6wWNEfJdXtBkWzqa402R6EWtSovdQf7GUw2ZoplvAp+8G0xUB1GpD+q55vfgeQi1g52ErgVgGL2eUHj0fmPrEsEKQBMxkQ==
X-Gm-Message-State: AOJu0Yz0AvGlNoJ02Irh15q1w4pXWUh1tvWpZs7ue7mLW2HsICpjbSAX
	APup1yNOlymPvHRARCSD1odgswx0wnQeDbxAuynoM/k0PIzyFi9c+qFB089P
X-Google-Smtp-Source: AGHT+IE/m6H6F0kQKihprUz16XWVJsMaLAmr+GMFaQJzjx0uRY+iUh55PiV4LGG2omEAlU5HzeKCqA==
X-Received: by 2002:a05:6870:e305:b0:21e:e583:25e1 with SMTP id z5-20020a056870e30500b0021ee58325e1mr4359058oad.32.1709365367792;
        Fri, 01 Mar 2024 23:42:47 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:47 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 6/8] ext4: Add an inode flag for atomic writes
Date: Sat,  2 Mar 2024 13:12:03 +0530
Message-ID: <33e9dc5cd81f85d86e3b2eb95df4f7831e4f96a6.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds an inode atomic writes flag to ext4
(EXT4_ATOMICWRITES_FL which uses FS_ATOMICWRITES_FL flag).
Also add support for setting of this flag via ioctl.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  |  6 ++++++
 fs/ext4/ioctl.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1d2bce26e616..aa7fff2d6f96 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -495,8 +495,12 @@ struct flex_groups {
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
 
+#define EXT4_ATOMICWRITES_FL		FS_ATOMICWRITES_FL /* Inode supports atomic writes */
 #define EXT4_DAX_FL			0x02000000 /* Inode is DAX */
 
+/* 0x04000000 unused for now */
+/* 0x08000000 unused for now */
+
 #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded directory */
@@ -519,6 +523,7 @@ struct flex_groups {
 					 0x00400000 /* EXT4_EOFBLOCKS_FL */ | \
 					 EXT4_DAX_FL | \
 					 EXT4_PROJINHERIT_FL | \
+					 EXT4_ATOMICWRITES_FL | \
 					 EXT4_CASEFOLD_FL)
 
 /* User visible flags */
@@ -593,6 +598,7 @@ enum {
 	EXT4_INODE_VERITY	= 20,	/* Verity protected inode */
 	EXT4_INODE_EA_INODE	= 21,	/* Inode used for large EA */
 /* 22 was formerly EXT4_INODE_EOFBLOCKS */
+	EXT4_INODE_ATOMIC_WRITE	= 24,	/* file does ATOMIC WRITE */
 	EXT4_INODE_DAX		= 25,	/* Inode is DAX */
 	EXT4_INODE_INLINE_DATA	= 28,	/* Data in inode. */
 	EXT4_INODE_PROJINHERIT	= 29,	/* Create with parents projid */
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7160a71044c8..03d0b501cbc8 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -632,6 +632,17 @@ static int ext4_ioctl_setflags(struct inode *inode,
 		}
 	}
 
+	if (flags & EXT4_ATOMICWRITES_FL) {
+		if (!ext4_can_atomic_write_fsawu(sb))
+			return -EOPNOTSUPP;
+
+		/* TODO: Do we need locks to check i_reserved_data_blocks */
+		if (!S_ISREG(inode->i_mode) || ext4_has_inline_data(inode) ||
+				READ_ONCE(ei->i_disksize) ||
+				EXT4_I(inode)->i_reserved_data_blocks)
+			return -EOPNOTSUPP;
+	}
+
 	/*
 	 * Wait for all pending directio and then flush all the dirty pages
 	 * for this file.  The flush marks all the pages readonly, so any
-- 
2.43.0


