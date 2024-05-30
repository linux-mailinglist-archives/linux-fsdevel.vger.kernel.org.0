Return-Path: <linux-fsdevel+bounces-20523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E441C8D4CC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215C21C21973
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E617C225;
	Thu, 30 May 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VauoZJ7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25E17C204;
	Thu, 30 May 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075763; cv=none; b=P7fiVRkPc/skYfDosZHsjctqnccFMXuZJxMoE9TiW3tnIDEmPHKz5szNFpAKFbf2MizBlY+lam16iwR985Q0C1VjklIavbWTOlFMXziQphRrvOT9AFqgVvdWPbIhxYyD7Gxr6TNMpBPhECo3P1O9GpqYAzRDapRPx8Uf/Cn4WTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075763; c=relaxed/simple;
	bh=zMMp1cir+0YHe4gw1xEIqjsYAXeoxkN2vahiR5UsUhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZEqqpzT1Rt6Jr85Fi22vZ10hPIVWqS3Cy05KVWh3E+NzjZ9pmFAEXKBOI9J3iXKj0Sy9kdrJijDx3xMYzfK49yhZAS6X+vzkILXArmAF7OH+obIEVB6Re7CQrfnhojupEM+HZVpiLoCrvePR2jju+Wq2Gkf++cn+0owNPk6SKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VauoZJ7I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f47f07aceaso7663215ad.0;
        Thu, 30 May 2024 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717075762; x=1717680562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGr470UzYPkb1JrCxKxwFe0Io6yxwP6cL+xsfiNCuy8=;
        b=VauoZJ7Iu+SyLI9fIl18MuWSnPX5GbxItSxCoXQyKniqCVOgI7mmzxgEMGggUvpryk
         pKMMWPCVRE9pd18PxjqTNwOmoKJC6lFGoqo2ErXwlkiDafVVfUk4/TsHG7Nys1gQPVSU
         b85FdDk+rVscC3FsvYz2j5OCqxH72JBdhQg8aTCmF92dGs5VEPYekK4LqOpKtaIuF5br
         zfO6Z3gbYNaLcPHrOTnEzSE2k+oGTgOSgiFG5Sv7qyRTLlKx/kBp8/OW3m5Zi8/mu/le
         ZzEDqynDT6KbTdcJBKqsC6hfphe0O/dla2lOWCiQK0n5xfILVgwRxoTFAtqkuO1Efjif
         wh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075762; x=1717680562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGr470UzYPkb1JrCxKxwFe0Io6yxwP6cL+xsfiNCuy8=;
        b=tyHONS0LxQJM506bI3+MYMiNxSlwJT96n83k56Dd8L+YFgYlqBDYIQmYXT0aRRV0jS
         Zk+5E8RYMigV0ump8Dr/FzODd16pse3GwDHuxLSxCcQxmBvbhN1qiP+pIVQQwPoLqCHN
         o6b2/osUARqexrztfexmXmPpfllLgMNWGgVM9bpV/6G4qozpnOzXcP5FCeZVtUgJgSAy
         pngaVw6fDBZjKkN3cpC33coGmaPMESyDBiF0Y72Fj9bFvYZ6MujAzZWOQz14PRLDIS1V
         CvOv5x3ypMYuui5btjxLWP+PZkT64nqzf2BNSCpJdKkMDIS4BG73aLiwb5C4fk+FmYsn
         xhqA==
X-Forwarded-Encrypted: i=1; AJvYcCV+HV1I9nBv26uy2A0W63SU/7B99n88by6RFD2hrXe8KFvhDzj82S3dBVrUTrCCntjV426xeuOJ7qQ0foW8AWpdBPnZxoxHpHTZw1ieLVEqaPz7uJR8AQRoqH2SbiLgB0zKz7We6Py5MNYMEQ==
X-Gm-Message-State: AOJu0YyIhqQJfy83KbTpJ1Kx/voT+CCLtTul2Ur6eqtiS0nG5GdPKkc3
	Bf6oFCfTFZHmHbepGCf78mRr9okITdrlxwLAGrbvR/fAqzxjuEyW34jPi5SI
X-Google-Smtp-Source: AGHT+IEixQWbhvzSd/hZ6dk/nquxqg9JFFgGeXvGpsSGxOeqTYTvD5Vjy9hGuOLgVfoYdl5Rz7bOHA==
X-Received: by 2002:a17:903:32c2:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1f619934e5amr21391285ad.54.1717075761592;
        Thu, 30 May 2024 06:29:21 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f627aedb2asm5825305ad.84.2024.05.30.06.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:29:21 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: dave.kleikamp@oracle.com,
	shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	willy@infradead.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Thu, 30 May 2024 22:28:09 +0900
Message-Id: <20240530132809.4388-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426034156.52928-1-aha310510@gmail.com>
References: <20240426034156.52928-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>
> Matthew Wilcox wrote:
> > This is not a good commit message.
>
> > > +   if(agno >= MAXAG || agno < 0)
> >
> > Please follow normal kernel whitespace rules -- one space between 'if'
> > and the open paren.
>
> Has confirmed. This is a patch that re-edited the relevant part to
> comply with the rules.
>
> Thanks.
>

I have just discovered that the patch I sent last time has been left 
unattended. It appears that the vulnerability continues to occur in 
version 6.10.0-rc1. I would appreciate it if you could review the patch
and let me know what might be wrong with it.

Regards

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

