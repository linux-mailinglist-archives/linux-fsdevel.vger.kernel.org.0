Return-Path: <linux-fsdevel+bounces-17850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C48B2EBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 04:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F461F22D71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDB6FBE;
	Fri, 26 Apr 2024 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6M8gcwv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC542566A;
	Fri, 26 Apr 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098863; cv=none; b=moX+qQsHpA+b5/4ThQ5xI/9D/4LMkOInTARQuolDS9FS7Ghkf4BcsJv3QsoxzO6mK6m6efwCtkmscRQ1wGwmrUqdjnZHKw4VpIkfA2anlmX/FJoA+TW4zF0rWedhDzmfep2uZrFoZRywySIEuc6sIii03ba8Ih27QlDnQgxkIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098863; c=relaxed/simple;
	bh=0vv92Ns19PxfWg9BxOVlA494tYFNUDyEnAyECkYvzxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFvH4iGYz0aI4rOyh8gMgX8uZTDFMgjgPYTKWtdbr/r0dvdShAR3nii4NvQvUwlmIQQfNiUhqtW8orfD1d07OjoCC26KPgUVQFScpmyq5JZYigpCbKABLxsMw9HTP2fZj30o5X9mNK1bbBPOmgAWdOKPnSLA337/02z1+JwQ9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6M8gcwv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1218592a12.1;
        Thu, 25 Apr 2024 19:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714098862; x=1714703662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMvRw8rpnZSVTHGGTWg1guTXdjfOyoODdnuOBPpc0sI=;
        b=g6M8gcwvdugSfBlDYS1D1a7g1A2M9fEXHb5/+mPex1InvSatmJgHmdecXG1Yrmdkpd
         vzL+Jquj5XaM2dbZ3nd70ZEZQp20iyTfq8YFTApL0YaHx9hdV5sferePf2a8WHV94mDg
         yPs9QgneGEJG8SD23v1bHpRP+hCIo6RBIxPuU6QC/TXhOCI7oerAoVgE+bRUvdjQGEGC
         pAI0NkajJgyhddGi5PN6rRUdraauZhk4PmmgkEufGWKx9jSm0I5COpWaLPihD1XsVAux
         XDzMwNijKUkiKk6MBMbIVuJZ3AnjKGT4eD/rCu5qUDwwxpX2YKvUTNJ45L/+Mq1OS3LN
         UaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714098862; x=1714703662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMvRw8rpnZSVTHGGTWg1guTXdjfOyoODdnuOBPpc0sI=;
        b=WEUly1ubn1oHTWx0FVI3iSxksgf9YvKM9fyovPVqSX8Yg1K35Xv1DG8rmAS3Wm8xAI
         tpmj1m4Uq+sHm7mPUfZaWG2f5PNb+hc6spJUgyctxFXgepAOAjEPi1GMX01+iR5IAZK7
         7SvFYxyEQaqn23mR0e0KNctCFySenDfiPz6EQfAiLY05qTy3McxaIqdbYFOZ9PFIXGWh
         by6+UdmtZ257vVHz2V4RFDqGyAb3x0BV+Yw4Eqh/2MpHm1Lf7/4fRHziiGUG1pTcSUe2
         6r17GxpJmexv2OqaE8YNOJnbSAQw8A5xuDxbZJpoLSgHWbc8yScRdfPuVKIcPjGDVFv9
         goVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVNk7j/tUS0Kz3lROElcL3/+ykQqk6GFq6C41tudQ/UZ4omQKEnv32Cc+hdNprnKRDQXYo4huzInSoydStxp0Zm5sh760wgDUdI7j44o0TaukXSFJRzS7Pr+59NOV1Zjhfybwu6GcpTqCD/Q==
X-Gm-Message-State: AOJu0Yxy4Tny2FOHLzYRGfQOePTIeJYa6fRy/LChsupsEOLiL8uHo7ND
	0ifgTFIg1gbqMghXuBxrkgTpJcnMiySP4xR00QKNpwydk5yQI07MbS5wGzkb5As=
X-Google-Smtp-Source: AGHT+IGqis1dPYz/mMAiaZa+AZkFNkopgQvO8kWxUn+sBXnlx2RuRBtlkOEJyGLW61VNQZueAGxzug==
X-Received: by 2002:a05:6a20:2588:b0:1a7:ad53:d3a3 with SMTP id k8-20020a056a20258800b001a7ad53d3a3mr1865481pzd.35.1714098861903;
        Thu, 25 Apr 2024 19:34:21 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001eac9aa55edsm1801386plh.250.2024.04.25.19.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 19:34:21 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: dave.kleikamp@oracle.com,
	brauner@kernel.org,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Fri, 26 Apr 2024 11:34:12 +0900
Message-Id: <20240426023412.52281-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZiqNMLWFIvf43Mr-@casper.infradead.org>
References: <ZiqNMLWFIvf43Mr-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I forgot to add Dave to the cc, so I'm sending it again.

Send final patch. With the patch that modified the location of
release_metapage(), out-of-bounds vulnerabilities can now be
sufficiently prevented.

Thanks.

Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/jfs/jfs_imap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..cad1798dc892 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -290,7 +290,7 @@ int diSync(struct inode *ipimap)
 int diRead(struct inode *ip)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
-	int iagno, ino, extno, rc;
+	int iagno, ino, extno, rc, agno;
 	struct inode *ipimap;
 	struct dinode *dp;
 	struct iag *iagp;
@@ -339,8 +339,11 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
+	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
 
 	release_metapage(mp);
+	if(agno >= MAXAG || agno < 0)
+		return -EIO;
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
 	pageno = blkno >> sbi->l2nbperpage;
-- 
2.34.1

