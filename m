Return-Path: <linux-fsdevel+bounces-39601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32399A160F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFA11886773
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E3199230;
	Sun, 19 Jan 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L5fRt3N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC57FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737277427; cv=none; b=WR1hh98DUofSLhVeLYKxl9p1fe9Z+3/F2ixLumbInYicNNZ2ry3MMBuumV4oeXTHPScyemgdywY+76SpN16TOQ7nr/0ruRohKZsrYyyEHA6qOfIpRJqKItYEVyalM64Ijucq6j2jb1fHMReohQrbTWKf8eQS0KZ032p2DUUQHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737277427; c=relaxed/simple;
	bh=LLsyvVTq/lQpx7WSJxhcgqPuH473y5oVsLvlG4BUBsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ubQgZGVkwjQrjwsXUPbHZD5e9oqownxN6PGQOMhF+Ax2zGoMrKvFJHyGpERlOoGP3aiOKLOgyB8iD0op9N3Ks+U0PN5atCpaQYnVNeD8HTcSFwt6GFVNShniN8DjBjBK8nHNrStP2QsakazB1B3CVaao1L8do16TJvj6FeQA6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L5fRt3N3; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737277427; x=1768813427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rLNRn7MKObT8VVRyzXM2BM+WCKoEMORz64p4Pnt0om0=;
  b=L5fRt3N3yN8367bMM23EVqbFY2lXaebPmw8uENWRxKjMTVyzV1ZEr7SY
   LoS/vL5Cx1glhK2MiL014Qt/CLgXEaxR/IOUE2yl+1YdqmznIaYwUoAGe
   1JxY8VZ3cs56mQHolK/I/vtDivIcLqHel3A8eV5q2wKxPQ0DhaDygkK3H
   4=;
X-IronPort-AV: E=Sophos;i="6.13,216,1732579200"; 
   d="scan'208";a="264151599"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 09:03:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:61800]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.205:2525] with esmtp (Farcaster)
 id e0f1e871-d852-487b-8b96-5104b82e7db7; Sun, 19 Jan 2025 09:03:43 +0000 (UTC)
X-Farcaster-Flow-ID: e0f1e871-d852-487b-8b96-5104b82e7db7
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 19 Jan 2025 09:03:43 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.8) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 19 Jan 2025 09:03:40 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v1 vfs 0/2] Fix the return type of several functions from long to int
Date: Sun, 19 Jan 2025 18:02:47 +0900
Message-ID: <20250119090322.2598-1-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

These patches fix the return type of several functions from long to int to
match its actual behavior.

Yuichiro Tsuji (2):
  open: Fix return type of several functions from long to int
  ioctl: Fix return type of several functions from long to int

 fs/internal.h            |  4 ++--
 fs/ioctl.c               |  6 +++---
 fs/open.c                | 18 +++++++++---------
 include/linux/fs.h       |  6 +++---
 include/linux/syscalls.h |  4 ++--
 5 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.43.5


