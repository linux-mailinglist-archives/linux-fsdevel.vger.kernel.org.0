Return-Path: <linux-fsdevel+bounces-70178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD0C92CDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B58D94E2187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE933290B;
	Fri, 28 Nov 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EL8Chp9j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663B23EA94;
	Fri, 28 Nov 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351308; cv=none; b=goZLQk6F+Q90dqSquThxGQC/+mRy+V712zvMz9qgsObrZjzeoaOB13pUKtdSA2bbUlI/61m/gqIOJ9toH/50IUcGketUv29Hta4/9Ar123qi3zeXDi8dlK1kjBWCYt1ToQBZ4Syu0z3Yr+ldiFGckhKYKiiNpWYwQh3i09M4cA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351308; c=relaxed/simple;
	bh=qOdNMX0gZXn+LEkT91HW6xWrxtuex8638u2ALi+Eg7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESCEFa1B115eDo74D6o6FNmiCGycMiv22cI/MLPWbHTWprsHaomQ1WKmNsD32g7ewy5lj9doiShJq8+bLBKP5TFS0XUrFPGHCFwDNq2vTLDDbWzlsxo0o2r2MFAnqHCodw9zThJm6Sww99uxpzhIBcpQn7i/iiz0rgiwO5dc7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EL8Chp9j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JwkxrOhf4MPsWdJ3TbYzFMXzZqwZrMM4caiEbRwaHlc=; b=EL8Chp9jEKRF7gKMPiwqVJMmUi
	3sja2/y4vjeQ1ppshT3Y0Phtzb/uA0GK4rORcGycRI4NBjBEMRXoaSoIXCeS+SWJl032Ib++WYptL
	x0IYBkql8K00oiwm7UzwVXX3X/i2/sBjeGk2+j6vi8lnTIx0FlJNpxYizecjmRn1iFfwg8hxM0ip9
	8p7k3NEwKfnQhmyhfYKrR+8rCrEUAn7CXRvAZO06nEmmL33gMsfTc5WHBJiUssojzWZUGL0x8BPYQ
	PhHgGkwqAaFhx/nnT54HgjdB7Zlsb5WvULLZ1VMGrYqeBfrUAuATDr+HUyD+sBc684L0Kt7gQdKgF
	aIHx+16g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34828)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vP2Me-0000000076f-1n11;
	Fri, 28 Nov 2025 17:34:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vP2MZ-000000003nu-1jFT;
	Fri, 28 Nov 2025 17:34:31 +0000
Date: Fri, 28 Nov 2025 17:34:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, akpm@linux-foundation.org,
	arnd@arndb.de, brauner@kernel.org, david.laight@runbox.com,
	hch@lst.de, jack@suse.com, kuninori.morimoto.gx@renesas.com,
	liaohua4@huawei.com, lilinjie8@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, marc.zyngier@arm.com, nico@fluxnic.net,
	pangliyuan1@huawei.com, pfalcato@suse.de, punitagrawal@gmail.com,
	rjw@rjwysocki.net, rppt@kernel.org, tony@atomide.com,
	vbabka@suse.cz, viro@zeniv.linux.org.uk, wangkefeng.wang@huawei.com,
	will@kernel.org, wozizhi@huaweicloud.com
Subject: Re: [RFC PATCH v2 1/2] ARM/mm/fault: always goto bad_area when
 handling with page faults of kernel address
Message-ID: <aSndJ1EYUnMGsUYX@shell.armlinux.org.uk>
References: <20251127145127.qUXs_UAE@linutronix.de>
 <20251128022756.9973-1-xieyuanbin1@huawei.com>
 <20251128120359.Xc09qn1W@linutronix.de>
 <aSnVXrnuY9QKjTKg@shell.armlinux.org.uk>
 <20251128172242.cCNBVf7H@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128172242.cCNBVf7H@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 28, 2025 at 06:22:42PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-28 17:01:18 [+0000], Russell King (Oracle) wrote:
> > > I hope Russell will add them once he gets to it. They got reviewed, I
> > > added them to the patch system.
> > 
> > I'm not sure which patches you're talking about, but discussion is
> > still ongoing, so it would be greatly premature to merge anything.
> 
> This thread
> 	https://lore.kernel.org/all/20251110145555.2555055-1-bigeasy@linutronix.de/
> 
> and the patches are 9459/1 to 9463/1 in your patch system. They address
> other issues, not this one.

Oh, the branch predictor issue. Yea, I'm not keen on changing that
because I'm not sure if it's correct (the knowledge for this has
long since evaporated.) There have been multiple attempts at fixing
this in the past, and I've previously pointed out problems with
them when I _did_ have the knowledge. Have you looked back in the
archives to see whether any of that feedback I've given in the past
is relevant?

> > https://lore.kernel.org/r/aSmUnZZATTn3JD7m@willie-the-truck
> > 
> > There are now many threads each with their own discussion, which
> > makes it more difficult to work out which is the implementation that
> > should be merged. Clearly, not everyone knows about the other
> > discussion threads.
> 
> So Will suggested to let change the handler and handle this case. The
> other patch is avoiding handling addr > TASK_SIZE.
> Any preferences from your side?

... and now we have a new proposal from Linus. I'm not intending to
do anything on this new problem until the discussion calms down and
we stop getting new solutions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

