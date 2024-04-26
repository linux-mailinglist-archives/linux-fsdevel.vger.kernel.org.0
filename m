Return-Path: <linux-fsdevel+bounces-17852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E58B2F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 05:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C891F213D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2B78C77;
	Fri, 26 Apr 2024 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awl04xo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4878C63;
	Fri, 26 Apr 2024 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102925; cv=none; b=V4d3SJs8D4UhBvKD/8aC33wG9y6jX/R+mH8LtRz9BRb8jpa5q/4qXxOKk3PIZzJUgRzBzWm1RL3/Exlm6MIqS2GNKu9rYlTg2r6osDiRjFkFELZtepFgWZlxHgrPc0IprXjDZz8KuUgnv9EgjvI7k3EcFkhZn4f8YdWcuy6onaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102925; c=relaxed/simple;
	bh=JcYjvFAPEQ+HEHhcQA96VfcqcAMcsCidJ+1ZNnn/zWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvgGvXXQX6dXiS0ED1WllEiaE4dXKq6myID6S1bt6rHuTOOs8HQUHZx7rps0x5Fa/7jVj0kgSr+P9W2kR5nzXImxwaS9PXUM7HTBGmxCodsUBdiGgrLCLKNORhJnlk4LlgAlJGKmSSjMWus3zGuCWzkOqxy/7pXq3F4UmCIhgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awl04xo9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f103b541aeso1520104b3a.3;
        Thu, 25 Apr 2024 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102923; x=1714707723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcbSCZ9Y2wGlgtCSSOeITnOlatGFVgCpJ0czBbahZfA=;
        b=awl04xo9ztlOPbsA+0HGOVQTxE2/MAF0o2mG7MZq4IpQR8W8mN45mSFC92lLUbSc+G
         p1Xwa+rtArSxLFXQ4ahCvp3AtuXrVAYQXlxi26zGTWIN3+0AEYCJ7/8bArI+HhhmzoTN
         O8E8rikyifF6/Kb6T3V+XBJILzLwQNqUBvD17SIl9emXrzOmw2c/CaJ9Kj21tztcIqPq
         pVRboZ/L2y2988afImAhXULopeEXNkG8oVKKbXc38I9vpMZwuzXFyWb+5s/ci8HMFAsM
         5w+UTTeVb3pMosCpJVODaNh2CB4D4aPG6qUvTi0I5l3sdZINsd109nP4ecH7yW9cF8L5
         YSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102923; x=1714707723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcbSCZ9Y2wGlgtCSSOeITnOlatGFVgCpJ0czBbahZfA=;
        b=SycvW+fuiFb1ID7Y7ZuaI6PRBUjS+Hboj/rKCq3a3pLCJJx97AonGEsVeU0zxJMspn
         qiEWNJerrQGOre7K8T0Dw41i+YtWpH8OHCjPmcbyCezaCc4n6BrmRkyF7nW9tb5gXIyV
         hwNIzdgLHCK7nfWvctAGGa5W7soCiegwjNNy7/E4zSu5I7alSsZYoKsWC/xbZNe5RQaX
         gkhd3Pp8BKwZWHzr0g+fWT5TBPerPFi63NcnsF8lTw8Z8hTfpOEOpwE7/JBc+9P88yKt
         pJmxuyYWGiwx30JRur5QHHdNAJ09C4yw976c+wyh3Tkd6TbQECixNHqe0MADOOJ90ouf
         rf6g==
X-Forwarded-Encrypted: i=1; AJvYcCUhiYOTysCOC33BOiJlwpeUGQxb6EtH/hCUB8DLn4Gg359a66z/okfaNcTT5r3z22fKJX6V9UgFr7tsC5kVhgL2c96cLIezG8dA5wlIINysHKsPlM7GqK/IWekMPRh/UIb+XT5RfIlWxEQg1Q==
X-Gm-Message-State: AOJu0YxgDJLZZyszkSaizH1OfZxIS9UJ+Fev1objm/oWNRHkjGOTDR+M
	OIBlaUJiJ85UhHCkHw6JLTEoS/KGkbuymcpegK1YiqpYMDhabbbD
X-Google-Smtp-Source: AGHT+IFKVoAcUnC/X1pW0IQ7BDM1mK7tLEYiPCxRztwnL1ODKEXICZa989yrQlNKJNIJTWxMmDDLGA==
X-Received: by 2002:a05:6a21:271c:b0:1a3:63fa:f760 with SMTP id rm28-20020a056a21271c00b001a363faf760mr1754152pzb.14.1714102923229;
        Thu, 25 Apr 2024 20:42:03 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b006e647716b6esm14409826pfn.149.2024.04.25.20.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:42:02 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	dave.kleikamp@oracle.com,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Fri, 26 Apr 2024 12:41:56 +0900
Message-Id: <20240426034156.52928-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZisfLI3Va6D5PjT6@casper.infradead.org>
References: <ZisfLI3Va6D5PjT6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matthew Wilcox wrote:
> This is not a good commit message.

> > +	if(agno >= MAXAG || agno < 0)
>
> Please follow normal kernel whitespace rules -- one space between 'if'
> and the open paren.

Has confirmed. This is a patch that re-edited the relevant part to
comply with the rules.

Thanks.

Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/jfs/jfs_imap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..1407feccbc2d 100644
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
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
 	pageno = blkno >> sbi->l2nbperpage;
-- 
2.34.1

