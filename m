Return-Path: <linux-fsdevel+bounces-17791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D98B239A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D048D1C20D93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B8149E14;
	Thu, 25 Apr 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5qEmBqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFA6171C2;
	Thu, 25 Apr 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054246; cv=none; b=HCBDa/mPiuB9ZJjQu8UUGvfkVKpAWL6zKYlkKenok2JvEvaZ2lMhfbL7tkDRwy2ofRtZXguSHb3pQ7p6cHBVT87Iyr2V3grA9QRnTL5VmxtfbFHEkjTofZNvSEpH2ruZ2l1gMeq2T/MviPLZSVAcxS2e5fII7EYGwnF881UuJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054246; c=relaxed/simple;
	bh=I9RuxejvwT5lszFHr8dtEp25xDltyZrOPajVFNie+N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqQ2GPaYImcwO1/TwEIuH2I/CsJ4qGsD7+OqeCgzFxJS2GPljXgwzblLG0mf0IfZYNr68oSVhvvUDKDonsy4jVBNpTh7pEosERL3emnwrysCgJvUV3qKTQ2Jarkqlak0Eec4ej1nONoY4KlNPIxV2KiO7dOrJPWgMDGAywRdlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5qEmBqq; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5db134badso37872639f.2;
        Thu, 25 Apr 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714054244; x=1714659044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omf2YA5ZrMAZoe/viDc+5pR/0l+e+gj7ozLHZXJSd+A=;
        b=L5qEmBqqSLa68A90cAWh+mjckXz6MlRWkQKeNWiF9Kw0m1Vr02kHSRE12aAbZAQDXu
         C1+5WG8mVA8RdSwKQABxTB4P8wwX+VRprLw2aOlUwm67v/7br8U7kx5jMjV9YjJhgFPi
         qZnTkXpIZmKz8MWVD1c/N4yZllOAOuYYb2GRfXqXDTE63f+hGzB6RSGkXyBiAN0K4+t/
         qDUCa/NxuijKifqgT3zPrsZfSy3JZjSybIRmelzua0lgS5XzcsHHBROBReKJ3fC7kB58
         iKEkNgbOZe+xgGszZu71FF4Gl2xjSmv+4bZmdRrUGLQWDxPTJw3AfElGq8DXuSPnj7Nx
         kFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054244; x=1714659044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omf2YA5ZrMAZoe/viDc+5pR/0l+e+gj7ozLHZXJSd+A=;
        b=xFTDec9LDCxDW+uInfssNx3Dlshho6ezTBxQBpHUuNJXdbrfkQF0oeL+1SpUjo/zJM
         aqzbclIm0DprPo4SFfTQ5TB1STdJZnQRr+n4nBDnQCq5qi3vsWuQ3ak/tDL5YtQmjKkl
         gl2qW3RluIKSsMNwIIQNzDd/XGu1++Z2zSTNVKadOPVRb/PyCeOwPxik9rx9h3sRE2wA
         NyVHtvhf14/g6VmNwBXF0/GcnFtq6/dlswiz57iyA0XkB7wsyy8CeF8MwezZ332r8NM8
         4nG8oVLIQJgNFzoj7wfi6/Lc4oh7bJhpvV1ZBzhnqF9bZ6/PlP9VoGVi8tFFy+Z6zp1x
         qxhw==
X-Forwarded-Encrypted: i=1; AJvYcCXD6SamtUsFIIpDFtKqiNQZhJuU4AxeLwwLjWWRvOd9DwiRwi+S7nxPFp9+MHASyw5Y557ECrlMj0tKZ3aIxkD3VU0G1bnwgRPIof02naazfiynO08MtMLHfxwmmQykf46Q8EXMv6FznawG7A==
X-Gm-Message-State: AOJu0Ywyju/NkCvV+KqdBM+x92GKLgSdw0F94kaa/BlQ69Je7z+iCl4v
	+kKuK91oMm6nFiRxlbOje2Dh8yd7OhRdPTVuJp4Xt6mhiHy5Nmub
X-Google-Smtp-Source: AGHT+IEDaTjEy8k8m8tzbhSWJ6HsiVjaRVSd0iaXtgpvcsNwjfY56ICL0yTaVf6IzBy/8laib3r9Eg==
X-Received: by 2002:a05:6e02:1e0a:b0:36c:c6c:dc27 with SMTP id g10-20020a056e021e0a00b0036c0c6cdc27mr6923795ila.10.1714054243955;
        Thu, 25 Apr 2024 07:10:43 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a637d05000000b005f3d2a9a91bsm11616066pgc.89.2024.04.25.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:10:43 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 23:10:38 +0900
Message-Id: <20240425141038.47054-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZipSO4ITxuy2faKx@casper.infradead.org>
References: <ZipSO4ITxuy2faKx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matthew Wilcox wrote:
> If that's the problem then the correct place to detect & reject this is
> during mount, not at inode free time.

I fixed the patch as you said. If you patch in this way, the 
file system will not be affected by the vulnerability at all 
due to the code structure.

Thanks.

---
 fs/jfs/jfs_imap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..ba0aa2f145cc 100644
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
@@ -339,6 +339,9 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
+	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
+	if(agno >= MAXAG || agno < 0)
+		return -EIO;
 
 	release_metapage(mp);
 
-- 
2.34.1

