Return-Path: <linux-fsdevel+bounces-41098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4CAA2AE72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B4216BFAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00495238B6A;
	Thu,  6 Feb 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM0RkbMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5249238B58;
	Thu,  6 Feb 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861403; cv=none; b=ddSHYYkyjLyEXfkrc/pz4ExP52tR+o6MybN4QSoU1tBDfRXvrkj5OxYOBcput+GDTsmZN/+AZtIWEY/lPFgAIeHbibWX4imrmbidp0WfJlu+cbRMpNn6MzY6BUDpC+6vQ8MEoxYL6B9LwMsHuvMTz2GperujDPs7KwNyFmWVU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861403; c=relaxed/simple;
	bh=bQF1Qllw7p60GDXziC7i8fKLH9aZRpLGJMIP+ErR6yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/Zv89Z/cCg9hPlIR5wuwezeywwr2l7SuqrBr7ghKnLi+zxL9GAigOE60dD1Wi7CKAy9bCLehE1Pk89tQdcfUVbXpljhgW1SROHbjxBTotNJfmiW8wyY9uwRH/iJF4AbG4iV2j55a5fLan1OSrsyEG/TDlOUYu+Q7jkh4qk8O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM0RkbMZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso2363120a12.3;
        Thu, 06 Feb 2025 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861400; x=1739466200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4zjhM/KFR3gg0RX3lCo3xjj1xuu5Iz0K4kCWIWSTpw=;
        b=QM0RkbMZJUe+WeaAfAMaG2n1f7H+EOaXLJ2cfQvb622rKOTDPTx7QMNnkwNazfpVCG
         sZip3iJmlOLuJ1OBKD4lbwxi0QXAfEEUjQdfT5uRG3oCM0BqJXU15x8y2d7ete3ujp2n
         3tEbt8rfFWY//Rd1xVCWNDiE8TaPEyT7a14Qt4aEBIDzRLWL6kbNBUNySLixGsvrpceP
         nmBEWFQmw70Sxdo5uuEqdUW/tyfMLv3vx72dkqzMCCZUDLUteal5JA6aj4Ea2pkiA7wY
         8lqKYmOoVh4I1xHUezMMwRGo14C/MgJZiVg6Ft6hpv1YEMCZ0Yotx1NktrehFh+JBygT
         Ek9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861400; x=1739466200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4zjhM/KFR3gg0RX3lCo3xjj1xuu5Iz0K4kCWIWSTpw=;
        b=OA6kcTI1/rUW32krNYYfD4d0nars1+HILsotT1qyRZGZyWRT8cnjHbylDNKFn/HRFt
         9vX/I1tbOgh70ko9eJhQVoZ8rWh9aDmqDkejgH8zExMgiorIz/c8xRIQi9KoOCFiUd2+
         W3fAO2MaGxOUjVNVM3TsFISty8CbDtZ7Qp2CPZaEZNTNDXbzI/EBJxurfqZP5H57EW7y
         +3Bc+ltV49KjdZK86D2SYrM/nMGjNtJvJaq6kraplvL8fe5ENmli0Ami1+jb0w00eiCU
         d1svxx90g8zVaJHmgcucvI11bZKnXEbaem44oLJiYjbbBBlOoZnxCfabq+kpKKc3FOLd
         Mqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUdyTdG2edlhov/5EjUtnR7mgAZfnsjNg6Cgo1EH632co28PyOQoCYiCYtxIlyDRx6zl2YzXjo654N/VWR5@vger.kernel.org, AJvYcCVstIBTNKlo5T1rVa4OQ7v4UBZxF+WfZmHz5T5ADuLVAi0GveM6AqFnCesg9n4KX3CuevXdjHTuVOmFCHat@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZrxcZn/4dzrHaqvLy6vtX13rq9EUBiZsnZmzLgfhxIg0ScQR
	G33Yg1wg7dY636aGNnroVjBoQFP4c6PPMtUs3Hdj99lS46lfcA+L
X-Gm-Gg: ASbGncv0tIaeDKvi8fpaf6cjDskb7Mos0TB1434QE62rmKYgGMEdgWz7b7ED6aCkazx
	KXxOwl1IUv3g6xb6zjJTcKjwrWaHj99DqHVweV9+xdjJ1qr384tOJgRyavqfEcmEP1Sj8GWdMpI
	oF9xIBwzylaWb60vNdl/7lXropF+m5BsSNsSO2RYBnU8KKV1sb75Vb3gdDy2RForXwPrlqgwjOQ
	C5Q2ZODsnno6CEzYEHnH907SsJValM/0xXNoQScfji3zPaJFxscDR/kbK9De5MVdHumVuW3XMOE
	F90C+cfJY1bWwuYYQCxfwnSjG4QtH7Y=
X-Google-Smtp-Source: AGHT+IGbvxLwXNBl9Ka8I9fCHAlJL4zatDGqmWfq02i48npXjBV9l+p8CZB3440HE7NuLUoOZQu9xA==
X-Received: by 2002:a05:6402:26cf:b0:5de:3c29:e82e with SMTP id 4fb4d7f45d1cf-5de45070668mr185000a12.18.1738861399705;
        Thu, 06 Feb 2025 09:03:19 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b73995sm1158110a12.7.2025.02.06.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:03:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/3] CONFIG_VFS_DEBUG at last
Date: Thu,  6 Feb 2025 18:03:04 +0100
Message-ID: <20250206170307.451403-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a super basic version just to get the mechanism going and
adds sample usage.

The macro set is incomplete (e.g., lack of locking macros) and
dump_inode routine fails to dump any state yet, to be implemented(tm).

I think despite the primitive state this is complete enough to start
sprinkling warns as necessary.

v2:
- correct may_open
- fixed up condition reporting:
before:
VFS_WARN_ON_INODE(__builtin_choose_expr((sizeof(int) ==
sizeof(*(8 ? ((void *)((long)(__builtin_strlen(link)) * 0l)) : (int
*)8))), __builtin_strlen(link), __fortify_strlen(link)) != linklen)
failed for inode ff32f7c350c8aec8
after:
VFS_WARN_ON_INODE(strlen(link) != linklen) failed for inode ff2b81ddca13f338

Mateusz Guzik (3):
  vfs: add initial support for CONFIG_VFS_DEBUG
  vfs: catch invalid modes in may_open()
  vfs: use the new debug macros in inode_set_cached_link()

 fs/namei.c               |  2 ++
 include/linux/fs.h       | 16 +++----------
 include/linux/vfsdebug.h | 49 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 4 files changed, 63 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/vfsdebug.h

-- 
2.43.0


