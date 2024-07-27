Return-Path: <linux-fsdevel+bounces-24355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F05B93DD56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 07:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61AFB22ECD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 05:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF2179A3;
	Sat, 27 Jul 2024 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiJlwAuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AC197
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722056726; cv=none; b=SmJX7mlcMtwrlX9+pLmN/BSUFyo2BQyqT6H3jQ3wYaytZ1KPE2/tFwoULtRYKD2r2uRSn/7+PGR4siezGqqtIdltSbFsANiXstVnEdDncNpFeji0CICJ84fybbWmiCaa8RhGQVFKleodevXfQVmxQU5lrZQO5Jts5j2zIVZF3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722056726; c=relaxed/simple;
	bh=/3XHeKGDH8aOhuocuqDn0RYUe1NoHZhy+PvegfT10AA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIzst/Q3Jigv/JNwZ6qD1sz9KzQNtjJvS3OrmJi63AW7Do56VXy6KToNZnz7yyK0GhjBZIZSnqNBy+9ol3xehHGQ419f6LiPjQisOFnb9rNTExTQy5BaWwvYAmfJbg97paUcZxftWqNmiUmJUBZEsit3QxYrEy8WMxx0XRjiiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiJlwAuR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd69e44596so9357485ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 22:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722056725; x=1722661525; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8fwF+sIEd+UF6XQ7f3lxitcOcqkgN3Wx/mkaFs+E/lA=;
        b=fiJlwAuRdoa4CnIgfU/aYodoTmL1eEHwJzEr//K6u5YWE+eTCNuyKaGQHmCeasPxBC
         /vURwKOL92sENXoSsEEgJPSw9u7nkX+GJ5XS8v+M09LOlVRKYDR7hrDoX28u4xqECtzr
         OxERit2jfXYxgwKRnB8ec72XKvcNOrfF6RKqVa/YvLLXI63M3nXU16Rm0JvUPk/FGMwS
         UpYqHxOTssaKBaz72vai33hqdXvPUQ7OTfJa0086Vu7K9H2+HxZrDwuScyDkBjwt0AVH
         WJ8eI1+6879MmszGuCZ7ay5g/1zYTzyO0oH63yd8+22E8i3XIy/u1kmzaPLWP+svyCCa
         sZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722056725; x=1722661525;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fwF+sIEd+UF6XQ7f3lxitcOcqkgN3Wx/mkaFs+E/lA=;
        b=D5sVkmSpPwk8ZFdv3uow1j252K2gPkJ/O/TcpSZ/kusqlqQDqEMckBz2T5ZFFyAqfn
         AAbl0HsB8O4jBxMqmNH8YC8SI9DIlleixz8i6XSf1cFyXUvFMU+GNXIzT4LEev36P8Sc
         8rXg6W/cUhYRkxKMaXmAd8nvRiYFiPFAvz+Ny/Dzf9lxJxCNCe1ALKL5bjkBgtDc1+Xv
         mzMse7B0arU3r1fLNeA2+SD8SF2zlGUvHrFLGO9tn/Z05pVosi64syrKKflMaUwZ5htz
         U259Jntswl2P7icx91HS3z9XDLDBqt1PPZR459lyaCCsiqzH5Bza6yOMfIOTVcLERi7D
         GqHg==
X-Gm-Message-State: AOJu0YzV3QDFnUgxYiZH0GA9yyuG7I2DwkkVepyPzyORSBn68E+v2NJ+
	fB86mf+nOm2uxsomPE1Gi4w48GDEX6HHzxRvNcKNWtr5cFQIItsofcPeG93qrqE=
X-Google-Smtp-Source: AGHT+IHzzJA3gjt23+LtJDbQYUn47voj2188cIn4w0mIhGxGJQTzhZ2fOwRyahcNJf8lZEMKF8xQxg==
X-Received: by 2002:a17:902:ec89:b0:1fb:d07c:64cd with SMTP id d9443c01a7336-1ff04b01a5amr31792775ad.21.1722056724623;
        Fri, 26 Jul 2024 22:05:24 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f73554sm41864265ad.242.2024.07.26.22.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 22:05:24 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: hfsplus: Initialize directory subfolders in hfsplus_mknod
Date: Sat, 27 Jul 2024 10:35:05 +0530
Message-Id: <20240727050505.68108-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
AuthorDate: Sat Jul 27 10:31:53 2024 +0530
Commit:     3f02808f3a98598adf145b3347b50926fd7d5c74
CommitDate: Sat Jul 27 10:31:53 2024 +0530
Content-Transfer-Encoding: 8bit

    hfsplus: Initialize directory subfolders in hfsplus_mknod
    
    Addresses uninitialized subfolders attribute being used in `hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.
    
    Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
    Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 fs/hfsplus/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..331c4118bc8e 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -485,6 +485,9 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	mutex_lock(&sbi->vh_mutex);
 	inode = hfsplus_new_inode(dir->i_sb, dir, mode);
+	if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
+		HFSPLUS_I(dir)->subfolders = 0;
+
 	if (!inode)
 		goto out;
 
-- 
2.39.2


