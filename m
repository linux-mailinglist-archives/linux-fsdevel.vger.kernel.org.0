Return-Path: <linux-fsdevel+bounces-73059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94AD0AD4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A02E3017F85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5435E547;
	Fri,  9 Jan 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="USQGtr/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B83311C38;
	Fri,  9 Jan 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971803; cv=none; b=mpDVyTt2C1RPvCsPg6Jfz/yyafFS4P/FIvLiajk51KmnvT7zKjxl229eAszRoXcRlU8LFXAweobrJF5xQRA43sUx2qFCO+xgQ6OHqfDLPWyM/i4Ndz6NnQfSf6YSI7KhjyHNhSDBSOuDVO6DQUYGji2C2O+dkxz7iVEnZy0o40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971803; c=relaxed/simple;
	bh=o1dXXBm8qpLkj8BzzsoAPqutt2Tbn7Imx8nP/KszwQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Es4PxbfFx3wS8t6Pixzrti7BElThKMX1tzneAEvlspo63cPCTy6axaTwELVf0UGFKooffkZm9kWDFJu4je1DtcmXOQXKFUJy5X1y7FrpK2pyyD+MLKu5Y0NXFxKdNEN20VzGng43L77M7zrpNWSdSG6URu2RQ37AgC2sHjfHnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=USQGtr/+; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767971802; x=1799507802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1dXXBm8qpLkj8BzzsoAPqutt2Tbn7Imx8nP/KszwQg=;
  b=USQGtr/+A6Bs6Ps1tQ7pClNDAUb9fpSsXSsCTvghwfGnfJ1iTdeAgWfR
   Y5SjQp3oyoOLGm8Tbav2a+MpqMgYEfQJWTEc93Gh81dHjKJrRJ7aDeDWh
   Lrs5aNVOnyqTba6n4FT13O3fy/Qyhdop9FtKP1uvdN1qmjXJX5gEZI7S+
   /h8ozuQlBTMH/a/fl3mKIZ/Hq2NEsP2rRFjI0gSBkiHx4yhUx7jAH3g4c
   C2LbxRlRWhu1Cm5Iut5gvI8PwNs1dHepYppM02Dd231vmgi2KozgMv/qA
   uSG6sR3YBLFK2K3iWG6RUpFCgmD1u1gu1++L7h7hCcXJVPULzs4sWahmf
   w==;
X-CSE-ConnectionGUID: KorsGw2RSe6TJdkBfKoyfg==
X-CSE-MsgGUID: 7wBuOER+S3Kr8ad2I8QMIQ==
X-IronPort-AV: E=Sophos;i="6.21,214,1763424000"; 
   d="scan'208";a="10428278"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 15:16:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:15363]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.55:2525] with esmtp (Farcaster)
 id 69ebce9e-d48b-4e07-8252-ea1b4b4a505b; Fri, 9 Jan 2026 15:16:39 +0000 (UTC)
X-Farcaster-Flow-ID: 69ebce9e-d48b-4e07-8252-ea1b4b4a505b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 9 Jan 2026 15:16:39 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 9 Jan 2026 15:16:37 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <jack@suse.cz>
CC: <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<ytohnuki@amazon.com>
Subject: Re: [PATCH v1] fs: improve dump_inode() to safely access inode fields.
Date: Fri, 9 Jan 2026 15:16:30 +0000
Message-ID: <20260109151630.65679-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <d73zx7srt4todun77vlhx4k4o5sv4q4vu2nk3iecz4eu7cih4i@6fillvgbgpgq>
References: <d73zx7srt4todun77vlhx4k4o5sv4q4vu2nk3iecz4eu7cih4i@6fillvgbgpgq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> I'd merge this variant with the variant below because NULL inode->i_sb is
> invalid as well and I think it's better to print that sb is invalid
> explicitely instead of just not printing sb info. Otherwise feel free to
> add:

> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you for reviewing!
Sure, I'll resend v2 with this fix.
Thanks again for the feedback.



Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




