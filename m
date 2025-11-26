Return-Path: <linux-fsdevel+bounces-69909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC368C8B859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4AB3A7B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957633E34E;
	Wed, 26 Nov 2025 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UmvLjZfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CF3126BC;
	Wed, 26 Nov 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183924; cv=none; b=K6IUpXfCbNqMvzzoRIw2Mhcp3qBRlVNm98R34d8HzyTcIMHa55Oi7GwuwtQDA6spcyXPSPLb2LW5Yby5NwZCm8XntR9LvvnAOBqPWw7iEgHENADp/WCAxJS/54l3AKAi73pGqzvZ0mNbO4uCvaN070FF5mj0UFXs7SGQizWnZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183924; c=relaxed/simple;
	bh=L6xn+VASU+9L8dbX2pIq17WKcsaaLaXKFhKGBFDaKhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmdyk/kqZqfqrVvFWeeWQw2WSJYckqzZji/PhurZeTU35RcSSogJHosTi+8BUmtVcWhtNbFLHXJZwRAgUWsFJxfkURKtYwxOHgXmvN9CRjKFK5rQp85BJFqrXvfgcOoIgsv7XQVfaSHKhiCpPFjPrQfhplwTLj/VndeAP8SUUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UmvLjZfb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y9ZKtsDO/Q8FwygSdDLskDJAHJNeZ7wl50axvyfs4JI=; b=UmvLjZfbuwcJ75/6fQd2XfzGKj
	W2Qw+i6LUELILqmzUEsGna/JXsOY0Zr47ZEyRPopEkhGADSRoV1ySRu8YSbjkmYNUkTDZrJdoGIro
	n96oCbDuxDv8MMkBLkXHCMQT2YZk4OAPhYBmUfzjxaFx0YA9ntd/SRy7aaFgmR4/xICi8BsqXoB3O
	IeGl3S0XSTh6dmKGo0yMZtEIxjTbcxV+lkMZ3eSjoeEWWCJiN5i/o3yD028EkAmLdzFDXDR9QW+EA
	1CRX17ba79gV84fkmMT8j0Gpo7c0ygTma4hhPHlBV99CXV4/FvB+LSqLqPgrKFLTjpOqFb3KBqB7s
	n3QI8n1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58250)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOKpB-000000004QG-3kdq;
	Wed, 26 Nov 2025 19:05:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOKp7-000000001wA-2sGZ;
	Wed, 26 Nov 2025 19:05:05 +0000
Date: Wed, 26 Nov 2025 19:05:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, brauner@kernel.org, jack@suse.cz,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
 <20251126184820.GB3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126184820.GB3538@ZenIV>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 06:48:20PM +0000, Al Viro wrote:
> It's been years since I looked at 32bit arm exception handling, so I'd need
> quite a bit of (re)RTF{S,M} before I'm comfortable with poking in
> arch/arm/mm/fault.c; better let ARM folks deal with that.  But arch/* is
> where it should be dealt with; as for papering over that in fs/*:

Don't expect that to happen. I've not looked at it for over a decade,
I do very little 32-bit ARM stuff anymore. Others have modified the
fault handling, the VM has changed, I basically no longer have the
knowledge. Effectively, 32-bit ARM is unmaintained now, although it
still has many users.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

