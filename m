Return-Path: <linux-fsdevel+bounces-13352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8486EF32
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DE1284165
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0991756E;
	Sat,  2 Mar 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD8QL9ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F715EB0;
	Sat,  2 Mar 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365355; cv=none; b=YY9+LSYBvEw0BMtOliP0hm6dbwSUuMKd0ju4W0kk4glIvJRjl3iMNO9UM0gUGmNWU7edBuRXX+aYeVjR/teEQLg7t2Mj/i87EWSUU9DnRvH64MbuzsOKYr2JZ6kJvhh9APdBQT2aHFk+AuN6dmfNATok4++0vaOYHnb1EaR7NQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365355; c=relaxed/simple;
	bh=LIpOUewW6H0QEPuqhwnEO0ogdkFsfUKAZVbggnMfLIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNGfyJRCy2n/TMnZY+SAvdl+Z4wzb0D2peGV9cz6D3Aqv1FlhVLiIEmrKiROaate7SxCWWlMs+0Fw8KgBNp756ZUXNVe8JXMDfNl4stXKbAfmCayy2jgyiRacEcC9TsJatMivKr+zeND1tgF21L4EZbXDa2hfX5syYG2eDmrazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD8QL9ug; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c835cfbff3so10486139f.2;
        Fri, 01 Mar 2024 23:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365352; x=1709970152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc6WGO5vTk7t7wqxhEwSHshxa9m7UoB9H431spDMix0=;
        b=kD8QL9ugqah003AJOzkxPUuA9R16erVsMI6GV09V4W53uCTtFXpGn2y+YZx/C692Q0
         aztE4YT9Hny264bjY+hYWvE66oSdy9S3z272Tb2SAW9JRA29cuN1WTMkBrVdGGBJCrFW
         dEZjB64N9SR11aRgDowJZ+5mHXwQVPyKCaD6DbLbBL0pGUZero2woOEeH5XYPs0QYGk7
         ZvHqbVI3eu6TB5n1rvNfTI5SzJqLTCLJYLV0221oBaGUOO0YYECOmHwMkj+9gYBjcd9r
         XsF3Gl+VLn5jw1g83Q/KoOk2uDlWrzruCXiqUTEJK+C1xdNaHCGc13hKwt39wYyu7qd8
         Geaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365352; x=1709970152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc6WGO5vTk7t7wqxhEwSHshxa9m7UoB9H431spDMix0=;
        b=aNyWq4gEioBNZ4cIWWPngvJVQsgecVqIa+5SnQr1HgIZ20f5PdUB/rTkMUpQqKNPll
         gWPWnspSgfP66I8bcaY+Hygk3vxvc9KxW/nFOGMi0dE5pYrVJxjVhziSY18Wf/R0Jzpe
         ySkSicOuXS4gLq2Tt2jLNBnrLRZ/KLAYMPq7Nnt99lLALdm2tUbYYTwz5+rQF7UNzKl7
         B7jCEpGqOWpEZSrVXCxeLCoYTj3pRoQMOp4GCVYaFCaw3vL4IQaq/Ya+cuCVs27MsU8Y
         M7SkVZdbiyY4QCJ9yMwCoKv8eoLL6UIrlCI/1MzgzHmiSe/JHGMHDWac7FCa6iF9gunB
         CnHg==
X-Forwarded-Encrypted: i=1; AJvYcCU3dcVghzu+BXhSZDqzB2V4xUfo5imKUvPIiS4+Rc6yEGb+ikXAdE7oQTbY7T4TDjXAdRaUGOD4JKW4l70qs4fcwlV3ROopBIQ7bSvf/4kJLqbnQNqxSPRUk9OVuOxYq/XnEIGKQbO7yg==
X-Gm-Message-State: AOJu0YzV9SRgaVrmS0mfisUUa04HI4xNIsipkr/V0i9JpPhoabTEuU4b
	rFwrpgD6anZQHLlx9o4VzfKXKr2gdXsNeB7CDGBidwmxQYmtR42zfHIig/lP
X-Google-Smtp-Source: AGHT+IFexBjPo1O7MXA8MlmaBL8/rMoklMaPJFqswlDPflcmkfUuodxfPLKXNe++1wFCaURWTwoB8A==
X-Received: by 2002:a05:6e02:218d:b0:365:259b:711e with SMTP id j13-20020a056e02218d00b00365259b711emr4972467ila.5.1709365352534;
        Fri, 01 Mar 2024 23:42:32 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:31 -0800 (PST)
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
Subject: [RFC 2/8] fs: Reserve inode flag FS_ATOMICWRITES_FL for atomic writes
Date: Sat,  2 Mar 2024 13:11:59 +0530
Message-ID: <4c687c1c5322b4eaf0bb173f0b5d58b38fdaa847.1709361537.git.ritesh.list@gmail.com>
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

This reserves FS_ATOMICWRITES_FL for flags and adds support in
fileattr to support atomic writes flag & xflag needed for ext4
and xfs.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ioctl.c               | 4 ++++
 include/linux/fileattr.h | 4 ++--
 include/uapi/linux/fs.h  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 76cf22ac97d7..e0f7fae4777e 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -481,6 +481,8 @@ void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
 		fa->flags |= FS_DAX_FL;
 	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
 		fa->flags |= FS_PROJINHERIT_FL;
+	if (fa->fsx_xflags & FS_XFLAG_ATOMICWRITES)
+		fa->flags |= FS_ATOMICWRITES_FL;
 }
 EXPORT_SYMBOL(fileattr_fill_xflags);
 
@@ -511,6 +513,8 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
 		fa->fsx_xflags |= FS_XFLAG_DAX;
 	if (fa->flags & FS_PROJINHERIT_FL)
 		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+	if (fa->flags & FS_ATOMICWRITES_FL)
+		fa->fsx_xflags |= FS_XFLAG_ATOMICWRITES;
 }
 EXPORT_SYMBOL(fileattr_fill_flags);
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0..ae9329afa46b 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -7,12 +7,12 @@
 #define FS_COMMON_FL \
 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
-	 FS_PROJINHERIT_FL)
+	 FS_PROJINHERIT_FL | FS_ATOMICWRITES_FL)
 
 #define FS_XFLAG_COMMON \
 	(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
 	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
-	 FS_XFLAG_PROJINHERIT)
+	 FS_XFLAG_PROJINHERIT | FS_XFLAG_ATOMICWRITES)
 
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b5b4e1db9576..17f52530f9c8 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -264,6 +264,7 @@ struct fsxattr {
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
+#define FS_ATOMICWRITES_FL		0x01000000 /* Inode supports atomic writes */
 #define FS_DAX_FL			0x02000000 /* Inode is DAX */
 #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
 #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
-- 
2.43.0


