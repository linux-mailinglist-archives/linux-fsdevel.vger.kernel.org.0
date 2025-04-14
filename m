Return-Path: <linux-fsdevel+bounces-46389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8EA885DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F018189A48C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDE28E60F;
	Mon, 14 Apr 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OR9014Bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF271A29A;
	Mon, 14 Apr 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640524; cv=none; b=rZetWrBe+ESSmalFqe1/Z6pHPHneQUTdDn9ywUjAH5tcpj0NuBlgFi+0PVrsuBfiAZrhwfGk0Jm+IOV2WzUwqJHJvXvLvBgAbO/MDEfFPSN8/lmRPXP71cuLiJcfTwFsntFKm9W4ZUsC3nVhVR0tXdtwa8P0PmKRj5fPUhwZtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640524; c=relaxed/simple;
	bh=Ox3Mxcva8shnhmPL5QTttNU+HxVkiYIiUfVChVyst+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0iOPrhe3ugdYLav9/3Lb4cvHbMgHiNLrUyFbCvijzM++OLfGLyIjGsjn2HDbHcW/+6TtneJAuv95Qb7tsxOMaN017Qx83rRpD4UiCXqLqxvRESBhXe27VmfOocUMeX9+BUO4UG4/tlt4nb2jPJz9K2WVjwCVdeDJ5P2saqEPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OR9014Bq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/2Ay/NCZeMYV79X2lYUpJCsDxCV73NsQVVoLTfLSenQ=; b=OR9014BqF5pCdtfSGu9a6lXIso
	eTm5mI/mT9yVwG/MwqOQovvTBI6ZsVwxgZWlioHX8iFm4oY695uADNck9D0mvqoExTX5hqiaefSHX
	yls7HIGtgrKIwxLLHuqxlPSw80cAgpbpOaSNr3mw6r+lF39ATHERgKj9zKd4d/6jkaxVrknfkyTUd
	MmUf4aMwhpx0d2ncyiSpCiJDY7tqWNBvdXTX4ap0vTbAaXuEhxsljtUR3VmZ3pHIgzq53x3DIw90d
	s/JJyKv/v+vR/S64w7A2wnsopvvsgAzvuKPIybcqlPvaCWkzXd//7754f70ZkT4QEJG3NBISqPqcp
	VEAC/RUg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4KhA-00000008Exf-1Umc;
	Mon, 14 Apr 2025 14:21:56 +0000
Date: Mon, 14 Apr 2025 15:21:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>,
	Viro <viro@zeniv.linux.org.uk>, Bacik <josef@toxicpanda.com>,
	Stone <leocstone@gmail.com>, Sandeen <sandeen@redhat.com>,
	Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Message-ID: <Z_0aBN-20w20-UiD@casper.infradead.org>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-behielt-erholen-e0cd10a4f7af@brauner>

On Mon, Apr 14, 2025 at 04:18:27PM +0200, Christian Brauner wrote:
> On Mon, Apr 14, 2025 at 09:45:25PM +0800, now4yreal wrote:
> > Dear Linux Security Maintainers,
> > I would like to report a OOB-read vulnerability in the HFS+ file
> > system, which I discovered using our in-house developed kernel fuzzer,
> > Symsyz.
> 
> Bug reports from non-official syzbot instances are generally not
> accepted.
> 
> hfs and hfsplus are orphaned filesystems since at least 2014. Bug
> reports for such filesystems won't receive much attention from the core
> maintainers.
> 
> I'm very very close to putting them on the chopping block as they're
> slowly turning into pointless burdens.

I've tried asking some people who are long term Apple & Linux people,
but haven't been able to find anyone interested in becoming maintainer.
Let's drop both hfs & hfsplus.  Ten years of being unmaintained is
long enough.

