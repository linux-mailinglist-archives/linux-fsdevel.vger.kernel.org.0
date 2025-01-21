Return-Path: <linux-fsdevel+bounces-39756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C58A17860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 08:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650E516332F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B6619E968;
	Tue, 21 Jan 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lVcjkrV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90161BF24
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443369; cv=none; b=Pc5iXgSsrfxTCCNKl5E7clPf0WMxbt+z8x8LnFwTXI3vmEUl4tsM5Ou5Jw+zarPG3p0m0VVzMswTZizvVbQl8/RhYDIkwBqrcW5Ci0FvAkLAA86yuPmocbDOcnKJ+PDSHm6iCyJi1clvfA35oCkU0lE1nJmqOkosjfzO/jFqHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443369; c=relaxed/simple;
	bh=jyetnRudjKIlaxr7mhxBq6YZ0mYiZhPzRSUKPvAy0YM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5cAiWWLJXA3nZlH/06IUxSReH/W+j9bPMCTnEjKdJbPqWkiFnEU6U/JuBPYKT+oVlnPKTTIl/vIHj7iiw6OBpwUk1z/Amscpfq+I20ZqzLiLEEgawW/u0MwcMxnpR6lNjvS97dnLf0oheGT+AR5dkAW24Im+S/YcSdq2o3i8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lVcjkrV0; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737443368; x=1768979368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PWXrF2RebSMjIJa4Gtg4yI+CxD7p7KtbRt9sl+KEm1g=;
  b=lVcjkrV0a7ivG46PC1UsMf2mognzWiZzKyFwr9cu/8ugcO48Y+S8gl1N
   Fcg41+TWgkbELZhUck9TvxrGianJAaFaOtelypisXGnDykYslJw7rJHiM
   AskEBk2Y7Dil+v1TpJHOprB89Yejjk++0wp3dDTczEzMxj2xpPiU77yCy
   4=;
X-IronPort-AV: E=Sophos;i="6.13,221,1732579200"; 
   d="scan'208";a="264555744"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:09:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:56092]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.127:2525] with esmtp (Farcaster)
 id 25f069de-eb24-4cd9-ba08-f63519b6ee06; Tue, 21 Jan 2025 07:09:23 +0000 (UTC)
X-Farcaster-Flow-ID: 25f069de-eb24-4cd9-ba08-f63519b6ee06
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 07:09:23 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.143.93.208) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 07:09:20 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v3 vfs 0/2] Fix the return type of several functions from long to int
Date: Tue, 21 Jan 2025 16:08:21 +0900
Message-ID: <20250121070844.4413-1-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

These patches fix the return type of several functions from long to int to
match its actual behavior.

Changes:
  v3: 
    * Fix checkpatch CHECKs

  v2: https://lore.kernel.org/all/20250121045730.3747-1-yuichtsu@amazon.com/
    * Add SOB

  v1: https://lore.kernel.org/all/20250119090322.2598-1-yuichtsu@amazon.com/

Yuichiro Tsuji (2):
  open: Fix return type of several functions from long to int
  ioctl: Fix return type of several functions from long to int

 fs/internal.h            |  4 ++--
 fs/ioctl.c               | 10 +++++-----
 fs/open.c                | 20 ++++++++++----------
 include/linux/fs.h       |  8 ++++----
 include/linux/syscalls.h |  4 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.43.5


