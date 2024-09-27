Return-Path: <linux-fsdevel+bounces-30220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A4987EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AC3B2559D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314AD189502;
	Fri, 27 Sep 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEvF7YDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7E183CAB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420032; cv=none; b=T+f884q8N3eP+9xZBvu2OhAm8FdMb9WBMjxRuxup23nBBUaz7MaSIcaBFxZ2qy3yPd3oDKrFPcQ8xQakBw289QPvfDyn9JqAlZ6/9qDObsjvZOXg7zTgSHAMXmf3qluei/YDvX0Wwk6+z0PiM+AcNgvSiIBXp02ldPKRD9986V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420032; c=relaxed/simple;
	bh=BZTfloABqmq16Demr1vWhXwTH+Hgd5ctDn9L9ao7rYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/7KCnPxMqXmQ9CxwNQweK29PgRtaDs7Kjudh5yKXAlt11TKMvWuHjPLuYEd93a7KE5vwoOV2FMjNkQMom7PQsHuzkQ/8yngIbcHbECKbA/4VylKpjoLa2KNC8uCICta8bE0YHdFsDgHW8BA0M7xcIOUQrVaAiv6en0UYHwm9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEvF7YDi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2054e22ce3fso20905675ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727420030; x=1728024830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqILDHt9buTwqcHgMYkm2JW4TGLcznIkgNWApRFuxlw=;
        b=QEvF7YDirYI7A5ASv3VOb/AkpJew4a3qQ+vG+s2vM3aSMlv6Qvb8kyr/5oJYSzlQOs
         f6gR0DjgzKVZsYBoiI28A9Ga6A9brCJ0CeoQ47vAnhN+oSz498gGVGnQ4Lv4G4TZoowB
         K5LpI0ikJblK6TeW7gvoKSZkvGonUDCQBxhNCyOkvgxcg7Duf8cZ83JGFV/bNLjfYt8x
         kcJR8j8nGadgvq1+Eb4JuUGB3GYvk+8DWpSZ7PKTxn0NXDEKW9op+qmmZpFPoCIzc7R/
         Ng8Q6maFR6HwErNbQaPAVzL3cpXz2AOl3H0kEroNZF6yfv6o5awBAeQKjmIgn0V3wMt6
         6HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420030; x=1728024830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqILDHt9buTwqcHgMYkm2JW4TGLcznIkgNWApRFuxlw=;
        b=w3i2+mg+LskBEWASJUyTbMW5DOooLq2R6bU+NUUZn0fQeXHBCRVfCIbp5EBOqmnAZK
         7UlfSNH5KJQogE1C8nxfhSvv8YuWXD5K/TMY0Iz3IUJh7rLdWsP9TChuM+Cg9/2yM+Z4
         e8TE1IWQpq3UEQmBuv7ea1g7laWV8hHHNui/VvPatBVns/03f/ifUv5sI54TboZWOL5h
         IOt/0Z5EBxiHbXehDdV37RwS+AdEy+I5xF6JygPNmYAYz+kw9U5qnioMpcC9gKhcxwZQ
         zmvMkxjPEuse9S3JWKhMAFetaNRofzOF8B9Ef6wGjIz1Gxs1Lj7+hoAJYDH8pc7/B0G5
         wZbg==
X-Gm-Message-State: AOJu0Yxe1XBLejFvw+Irh8Ru0MV3c1HTLZWsZbMITsDeKCj/R9P+A6Bf
	GiiIiFoiV3iTPc5wQ6M1753KoLWlSWn6Y9HN1Pc38+lkznpQxqrIM/+jf5uFY3Y=
X-Google-Smtp-Source: AGHT+IEy53ZT2fVnyyGaTa25q8lgz1xb0P871UoHWPT2nx1qhdI7IDTkE02OCYfRkcXCXqeHrRr67w==
X-Received: by 2002:a17:902:f550:b0:207:60f4:a3c8 with SMTP id d9443c01a7336-20b37ba5c03mr40396215ad.38.1727420029526;
        Thu, 26 Sep 2024 23:53:49 -0700 (PDT)
Received: from localhost ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d4bdsm7706165ad.139.2024.09.26.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 23:53:49 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: chandan.babu@oracle.com,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hch@lst.de,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2] xfs: do not unshare any blocks beyond eof
Date: Fri, 27 Sep 2024 14:53:44 +0800
Message-Id: <20240927065344.2628691-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to unshare extents beyond EOF will trigger
the need zeroing case, which in turn triggers a warning.
Therefore, let's skip the unshare process if blocks are
beyond EOF.

This patch passed the xfstests using './check -g quick', without
causing any additional failure

Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
Inspired-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/xfs/xfs_iomap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 72c981e3dc92..81a0514b8652 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -976,6 +976,7 @@ xfs_buffered_write_iomap_begin(
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
 	u64			seq;
+	xfs_fileoff_t eof_fsb;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1016,6 +1017,13 @@ xfs_buffered_write_iomap_begin(
 	if (eof)
 		imap.br_startoff = end_fsb; /* fake hole until the end */
 
+	/* Don't try to unshare any blocks beyond EOF. */
+	eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+	if (flags & IOMAP_UNSHARE && end_fsb > eof_fsb) {
+		xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
+		end_fsb = eof_fsb;
+	}
+
 	/* We never need to allocate blocks for zeroing or unsharing a hole. */
 	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
 	    imap.br_startoff > offset_fsb) {
@@ -1030,7 +1038,6 @@ xfs_buffered_write_iomap_begin(
 	 */
 	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
 	    isnullstartblock(imap.br_startblock)) {
-		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
 
 		if (offset_fsb >= eof_fsb)
 			goto convert_delay;
-- 
2.39.2


