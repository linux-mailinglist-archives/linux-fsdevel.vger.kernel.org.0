Return-Path: <linux-fsdevel+bounces-24359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DD93DD79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 08:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089CF284980
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE91BDD0;
	Sat, 27 Jul 2024 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIlpbXn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FC1B86F9
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722060830; cv=none; b=HV03E2kM0agk0Oh4PwHZkYSJTUUHHk/Y3DzjfkxlCdmxmG/8eKr4U6ma5r4Z/hTMVC6hQzV1At0nY/OG/bN7HBblUrWlWBpx44gfgea9YKQrDn6s1PB0b9kC+qpwg40AKtr9AO9TcFo8r5++YC9QXxgZ46w8JJxxloRYhM7Q6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722060830; c=relaxed/simple;
	bh=30cMus3ICjoofxFiRIvDmfqr6dT15Jqh6QDYU4tPQ6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2TmzyQlRZiwKdjE3gsUfk7JrCr8MoffIGqdzCw8yntkLCe5us7ww02ga6hjhi5zA1HjO5xft33JJdzbdFYXrMI+CDhReQ/fwhVt6CNE63Bp5MfeIKuVJGlAiblFX1C0wk6I+nV+QQhNVlMux7q0DCgBaEJTiqJ0dNpwSRT3MEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIlpbXn5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc611a0f8cso10792555ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722060828; x=1722665628; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dIv6o2cjHwR7n5agPON2AEA6FDTvC7wsWd7s+OCH6vk=;
        b=GIlpbXn53h3Dwpvh7wUsFU3ClEBX3e/M0uRNEyadXXYh9sNg0xZ1kE78UpS1ee1P+k
         h1WFLjyI691URZA99jSg0jM0Qoz5+7QtMswIoIC7S4Hp2gmN6iVPY1/j2jCGcMqXVJLy
         4rXvaBm4Ig1ou1mm8D1tx+IWzDo4UKoRNB/3AJV6Gxfe3kZU0diY1Bd3Ctqh9YmUbjob
         Js+FIQTzYSaPMX/XzjN22SV+WQTtYdtdwNKQt+tPygZm8NhEAc62Bccip/y3qEVHg4cC
         gTmvBAYM6CwbpKC59XOBHZewGuWnqEyeDo/XlpDk4TK18JCZyHIJswN9rgISB9LLFl3A
         W3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722060828; x=1722665628;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIv6o2cjHwR7n5agPON2AEA6FDTvC7wsWd7s+OCH6vk=;
        b=srkNSL/yZOvnOvu8JCyCJgLPLWiM58e7g79/aF68o7uoOsf5+iHvIa5aLFJtxcrfST
         Dh/He2ArUgs9vaZdcIRMPndkgczfD0sVO4ckBkEFyl+uPw6CCKHi1jfWADsZAOkrya8S
         /oBNGRCMcDu2KpKX4osNadf3+6xRcvKjq899iAPdZ2qzHSS4szhzhf4uCN1gKN14cLvf
         K4JtG1iDAfSgloKJ1yH0wwcG6nTeQsv18D4OXrIfybqrXByKJ21Pp7MiSs2m36WCbrQv
         7QM7y19F0cHgLIFOowOaIodcaKPZsFM1U288VDW6neD92I4Z0Y5R1HDgbZp+oS1ACuMw
         z2MQ==
X-Gm-Message-State: AOJu0YzWxt6s1IAvt3kaA6rZDV+pbnQPyNdXp/6PRCQU8wUX/bIjF2QT
	UMlhB5d059VniZY3EpnmxDl4OWOUwPZJ0s+Bh9SUglcT4v0y7LctshDOtLWhEM8=
X-Google-Smtp-Source: AGHT+IFpOo1oQCAtnUf97PPu718sDjJVZonCcKi4Dr7Xm8pgwAGofwWKaluBn7BA4levU45OLmh5OQ==
X-Received: by 2002:a17:902:d4cd:b0:1fb:68a2:a948 with SMTP id d9443c01a7336-1ff04809ab3mr14672205ad.15.1722060827690;
        Fri, 26 Jul 2024 23:13:47 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee15a9sm43068755ad.151.2024.07.26.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 23:13:47 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v2] hfsplus: Initialize directory subfolders in hfsplus_mknod
Date: Sat, 27 Jul 2024 11:43:04 +0530
Message-Id: <20240727061303.115044-1-simeddon@gmail.com>
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

Addresses uninitialized subfolders attribute being used in 
`hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.

Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
Removed changes that was accidentally added while debugging
and reformatted the message.

 fs/hfsplus/dir.c | 3 +++
 1 file changed, 3 insertions(+)
644
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


