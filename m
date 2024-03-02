Return-Path: <linux-fsdevel+bounces-13359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C986EF47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8741C20DF9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8C225A6;
	Sat,  2 Mar 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm123pWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3B24A0E;
	Sat,  2 Mar 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365382; cv=none; b=Sl1EU2gNlYpVyZ4vv98ffrFr1xrbhqkp5SP5sDjIAWZX8lMvtDZ9drRgslnKL1dV02rBjWDpQmmB9hKAPjmwkUopHopRm2fvxRNQYQsnC5cJAhRUtBvqbqZTabdXcgC2shDuDKuRKdLvUL11tXzuLoIzvz3Zjr1Q5+zvOg8N/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365382; c=relaxed/simple;
	bh=4GgXxZs/mglWIRYd9/bl71jA6REtfHyAlcztG0gdRX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CudLb6oUBEuYQ+8IoXDgfdMs4qGYUgKR+IixDJQyEZ4d9HIgaIl/fRzIp3D+pngXwQkdxW2JA/Gk/CxLZ9eZus+SxM5v+Q0Eup/qAVgqKxlTK9oSn30kpcw1Mr+EybkW73tWvtiM0JocFCUnlCtYyRO6WBOdHqR1wBB/LcILUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm123pWv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5d7f1f15bso863636b3a.2;
        Fri, 01 Mar 2024 23:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365379; x=1709970179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iROnnUQAIrn8DnCE9YGkqkSmP3qnk0ncEloJYBFiPVY=;
        b=fm123pWvIxbYCJCah26aQGuboZ93+hVunMqnSIXQ4lr3fLAEi6Yn+uKS64CA80Z/dO
         PoBV0+p088i8HXpKkKMWoA04fTRYDMivD8n+U7VeMCJj0vTIBg4540Nxz3tBjf7amHlQ
         bOeOudMdAbGR92DdyVf+KhRXetd2yULG5rIRYfovLLemSgYrxxoiL1XpDQMaXZbUa9pT
         Mh8Iq1MMkYU9tSsPVzjw5o5lLzVIWmDVhMWY1OVxk39FGnwA4+NwwkYk6fDcEnUjqovW
         88ZBbGJmP+YDBcSSWqxA2Vl3eVUYniLJAMt552l93nAuwBVot/C5GTxEpjquvBc+41jn
         6LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365379; x=1709970179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iROnnUQAIrn8DnCE9YGkqkSmP3qnk0ncEloJYBFiPVY=;
        b=V8XgKrkDOpE7qP8xwGrQortvzhIj/QMeCBP3cq2HI0WXm+2URaeeSR+D2h2QXHOwPd
         ngP65cpSWfTKpLn8F11gVWdTbVKEKjNXQFghYLIO3J7mOrmMAvIS9ZxXby1gYWn2e+w4
         CmjKk9yoApZLI0mDbKnuPcygOiOUpAQR6e3no8MKnj7EaHyT4P0MfO6Rk2N9fWOAEgKj
         hC3MR5bAgJTU5ZxmpercpbherJFyYD4v7doGJbePwIjhGsajPjjrWjHWJilm/tx/DCuK
         U07kcmWFrWXVPKyWujvQ4CBUVTIxiB2EVDSgzO7WAbPEsWVdNdjMP1tMzH1En4WOiIi0
         eOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl1Ncu8T9rDMt7mqpgGvUf9DjWSi1tI1g+wSSEiNfaNZiyhVSdGRAWG2NoD/WcD9UkdWU3PnhbxVXPf/Q2sZ8m3Mvbpee2tCzJEkhpM56U5oOTL2yscaswgFZawX2OvivcZRJvtjH+vw==
X-Gm-Message-State: AOJu0YzS74zH2fqTuR5WGeM2i7p+bAisXjOjENEowzQoL6vj09+pXCir
	znGXN59lK89zyUadzIM276PMCjxmoK0ADuif4Gygl0rP0cBZLPlaa9dBQ1K4
X-Google-Smtp-Source: AGHT+IFPpIE1yMNr/ZCVoN5pvHpYmcwWC5rH1/HSKdLic7af17QTNikWfEa+xeGlN1Lyzwgs/tWXjA==
X-Received: by 2002:a05:6a00:852:b0:6e5:736e:cc8 with SMTP id q18-20020a056a00085200b006e5736e0cc8mr4513372pfk.33.1709365379431;
        Fri, 01 Mar 2024 23:42:59 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:58 -0800 (PST)
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
Subject: [RFC 9/9] e2fsprogs/chattr: Supports atomic writes attribute
Date: Sat,  2 Mar 2024 13:12:06 +0530
Message-ID: <646de2f0f9ba8fb8a486dc388ae0748999d1ed2d.1709356319.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709356594.git.ritesh.list@gmail.com>
References: <cover.1709356594.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds 'W' which is atomic write attribute to chattr.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/e2p/pf.c         |  1 +
 lib/ext2fs/ext2_fs.h |  2 +-
 misc/chattr.1.in     | 18 ++++++++++++++----
 misc/chattr.c        |  3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
index 81e3bb26..9b311477 100644
--- a/lib/e2p/pf.c
+++ b/lib/e2p/pf.c
@@ -45,6 +45,7 @@ static struct flags_name flags_array[] = {
 	{ EXT4_EXTENTS_FL, "e", "Extents" },
 	{ FS_NOCOW_FL, "C", "No_COW" },
 	{ FS_DAX_FL, "x", "DAX" },
+	{ FS_ATOMICWRITES_FL, "W", "ATOMIC_WRITES" },
 	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
 	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
 	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 0fc9c09a..f9dcf71f 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -346,7 +346,7 @@ struct ext2_dx_tail {
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
-#define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a snapshot */
+#define FS_ATOMICWRITES_FL		0x01000000  /* Inode can do atomic writes */
 #define FS_DAX_FL			0x02000000 /* Inode is DAX */
 #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being deleted */
 #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot shrink has completed */
diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 50c54e7d..22757123 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -26,7 +26,7 @@ changes the file attributes on a Linux file system.
 The format of a symbolic
 .I mode
 is
-.BR +-= [ aAcCdDeFijmPsStTux ].
+.BR +-= [ aAcCdDeFijmPsStTuxW ].
 .PP
 The operator
 .RB ' + '
@@ -38,7 +38,7 @@ causes them to be removed; and
 causes them to be the only attributes that the files have.
 .PP
 The letters
-.RB ' aAcCdDeFijmPsStTux '
+.RB ' aAcCdDeFijmPsStTuxW '
 select the new attributes for the files:
 append only
 .RB ( a ),
@@ -74,8 +74,10 @@ top of directory hierarchy
 .RB ( T ),
 undeletable
 .RB ( u ),
-and direct access for files
-.RB ( x ).
+direct access for files
+.RB ( x ),
+and atomic writes for files.
+.RB ( W ).
 .PP
 The following attributes are read-only, and may be listed by
 .BR lsattr (1)
@@ -263,6 +265,14 @@ directory.  If an existing directory has contained some files and
 subdirectories, modifying the attribute on the parent directory doesn't
 change the attributes on these files and subdirectories.
 .TP
+.B W
+The 'W' attribute can only be set on a regular file. A file which has this
+attribute set can do untorn writes i.e. if an atomic write is requested by
+user with proper alignment and atomic flags set (such as RWF_ATOMIC), then
+a subsequent read to that block(s) will either read entire new data or entire
+old data (in case of a power failure). The block(s) written can never contain
+mix of both.
+.TP
 .B V
 A file with the 'V' attribute set has fs-verity enabled.  It cannot be
 written to, and the file system will automatically verify all data read
diff --git a/misc/chattr.c b/misc/chattr.c
index c7382a37..24db790e 100644
--- a/misc/chattr.c
+++ b/misc/chattr.c
@@ -86,7 +86,7 @@ static unsigned long sf;
 static void usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-RVf] [-+=aAcCdDeijPsStTuFx] [-p project] [-v version] files...\n"),
+		_("Usage: %s [-RVf] [-+=aAcCdDeijPsStTuFxW] [-p project] [-v version] files...\n"),
 		program_name);
 	exit(1);
 }
@@ -114,6 +114,7 @@ static const struct flags_char flags_array[] = {
 	{ EXT2_TOPDIR_FL, 'T' },
 	{ FS_NOCOW_FL, 'C' },
 	{ FS_DAX_FL, 'x' },
+	{ FS_ATOMICWRITES_FL, 'W' },
 	{ EXT4_CASEFOLD_FL, 'F' },
 	{ 0, 0 }
 };
--
2.39.2


