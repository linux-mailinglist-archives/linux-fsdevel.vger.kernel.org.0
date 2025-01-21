Return-Path: <linux-fsdevel+bounces-39753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352EA176BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 05:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1213A5A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 04:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDF91925A3;
	Tue, 21 Jan 2025 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BAaeJR0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC52CAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737435493; cv=none; b=c+4aSeOW8OY2xGCFNGjE7FfM6NnV+RJMbIlEbKyg0op15QTWzjEOoCK+msmr006nVwqCAEkiCrI83sZSVXCUeN1c52G41z5E5xJ7g0+8Y6Vcd8krDbUNUxfGunyaidXG5z7pgkMQWhe0HBUJtbWvfLcluCr18omuWkav471keNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737435493; c=relaxed/simple;
	bh=LLsyvVTq/lQpx7WSJxhcgqPuH473y5oVsLvlG4BUBsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nd/hI16H43T1P2bFLxesaU/zTiIgj37kHx7Db6aKS5MvlXh+2EYLscwzGmRuwyW2tH5v9p3ETe2dL9X8jwg01gIC4ZJKQVjOEdrJYJOBFQkpoHy6BeecpX0QRjpnnFq46ho9pFf3HSGPi2VnOyRz4qNC/b+lVhLY20Jm33QbpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BAaeJR0+; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737435492; x=1768971492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rLNRn7MKObT8VVRyzXM2BM+WCKoEMORz64p4Pnt0om0=;
  b=BAaeJR0+HlfNbayEvQIBC5fT0DleZcVyNxotVx39pzp5Jq7BKRxNquc6
   GYI/FfvDnP2gkH9/qYUijmwge0JJbBs1orMCr2Zg/fGqYqjSJonTJddY+
   D55flNPOmP9LgVL7Ev9Pjitvmw9IeP87++o326jUMJA7M7oPIfN3X0mt7
   0=;
X-IronPort-AV: E=Sophos;i="6.13,221,1732579200"; 
   d="scan'208";a="487401252"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 04:58:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:44798]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.137:2525] with esmtp (Farcaster)
 id c2dc9414-d590-4fe0-83f8-c52e885fe72d; Tue, 21 Jan 2025 04:58:04 +0000 (UTC)
X-Farcaster-Flow-ID: c2dc9414-d590-4fe0-83f8-c52e885fe72d
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 04:58:02 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.143.93.208) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 04:57:59 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v2 vfs 0/2] Fix the return type of several functions from long to int
Date: Tue, 21 Jan 2025 13:57:06 +0900
Message-ID: <20250121045730.3747-1-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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


