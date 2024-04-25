Return-Path: <linux-fsdevel+bounces-17798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD78B2431
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264771F2375E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD1214A0A0;
	Thu, 25 Apr 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hunnuxlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1D149DF3;
	Thu, 25 Apr 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055884; cv=none; b=fmVjtbwusWKwEAGaVcxptsy5JL/ATWXU3kxweqPUUU9HgNz+o8E8S8TDUoA12zWS95INmkAOc95FmUEuSY8SLxnRfLamcB3tRvz1v3waE8H7f1VzKvxDTGBhHI0Fm5virP6/wwVl+2/0Wfb52iO7dlFOHoie+6FbBEe7Z4LguQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055884; c=relaxed/simple;
	bh=OL40rAZ1hGMCshd+cUzaLeUfTWYSnigk7wZhc+AGif8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iV20oHXC+eV8h6EG+/WlN6jW2yAjQ2osJ6ut6SqTi51GpqAO0VikyTvCoHyW8jY263ftVgLhUSsXm/SU1rIN3tCZi1yDQxBodTUWRigm1TEsKUz7USXLBe0nEV+A6R7XYrS9p/MuTgvXdQq7lUPhyCr19F0/Gx8+7qEmoGGwaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hunnuxlT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed01c63657so1046461b3a.2;
        Thu, 25 Apr 2024 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714055882; x=1714660682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7nLnIenSPwfvHd9kS+H3ppvNb141ZWllN+yQVfG3SM=;
        b=hunnuxlTCfGDT1EvrXlFbLo+5jZHUkF6HGm6A/BYMJaYMGLgKRyBdU4l99KYWTM0oT
         e6vrwz1mHQbPudWemhVZVD6veVD9cdR3B7wdvm6UCk6bDgLsw3Qk6I+Rk+sSvV3IwAbY
         GVp8ME7XmHtsmQK9IJY/tK6yWfO/siOojbhgrYNAbYDyVKO/3SZo4Yl/g9Sa0TjyD41d
         LTn75mDyF+U2gJQpobnuzf2Ib0vqhmk7BGbqzJLElnRVC0UD286b7z+NXBYrXXgmoOS9
         s9f3oevCi0fyAgEteeY7TwsGS4wMN0u4k9rQhqkdZIII4oAgTNhuTPX26pw+RNDabNW9
         I6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714055882; x=1714660682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7nLnIenSPwfvHd9kS+H3ppvNb141ZWllN+yQVfG3SM=;
        b=UbImF48FHJpBEEzkkASiG5ZWbFlTLxq5UDxCHTQ9SRWUgag4gjMOyP+uEFD57+WFIN
         QmKDb1rmvq2826hMvE2xF+AkZ9i6sBqiVCGTPBmphHZXaBX8LqNxwfrHVrh1V0N0YVI7
         W6GEvRnJe6aduv82QIYURHOD3/MsqZdLn91bufNQKAmhXIVM6ZrT8WJ8QqH1NersiMQq
         +t03VgQ44J55IP9a71goDKQygah3mmS31ARM4vj3ou0+yF7nEu4aDblRgudHTkUIiCgP
         41aYQ9tgrBVNkdNOyxtfiJgNMjksTxc5ISKUsssPHE4B+sQfIrCOAYWHCVUGNl3ezKtj
         KkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAAinPUKCmU8XNeh/TIiMOnVY/m3STCGJLWwdgDRx3FE/kxbvJULCr//QNG5gONvGjbKVIUwKa8b+iTHExMLQJsvxFxoP3Ubg8gNm0rIaFoJitEcf76njMM2bVauFv93as6exjCRTjJz1kdg==
X-Gm-Message-State: AOJu0Yz5NOQtkgwC83wp3594Z3meJ7vyWRYhvRpcm1eJgHweBDJ7awGl
	41iTj+CfxUXAYnnUQU2QhOUVXBwZJM3SlnR8U7wHpEfTZn7ha+1K
X-Google-Smtp-Source: AGHT+IFJrsgHVd9BpJsfGb1HU8aF98DYgHF1MpanbypdG+1PkijnDJtVKcN2smBsOqec05MtXeVqeA==
X-Received: by 2002:a05:6a00:114b:b0:6ed:de70:5ef8 with SMTP id b11-20020a056a00114b00b006edde705ef8mr7415458pfm.6.1714055882075;
        Thu, 25 Apr 2024 07:38:02 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id go20-20020a056a003b1400b006e6233563cesm13188023pfb.218.2024.04.25.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:38:01 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 23:37:55 +0900
Message-Id: <20240425143755.47655-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
References: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matthew Wilcox wrote:
> It should be checked earlier than this.  There's this code in
> dbMount().  Why isn't this catching it?

Send final patch. With the patch that modified the location of 
release_metapage(), out-of-bounds vulnerabilities can now be 
sufficiently prevented.

Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
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

