Return-Path: <linux-fsdevel+bounces-24426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB793F42E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA561F226D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005D145B25;
	Mon, 29 Jul 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mKmAhjZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B612266A7;
	Mon, 29 Jul 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252808; cv=none; b=UPIzYs9JCpxjeGUKjWjCE5GK4e+zeDzT9+hBGo5nRBN9TLcvBN6kr3eXxOigleEozM7fcsSEpMupYCxcumpyRoMHpSTn0FmBoXlRxD1SDrcqIePbeylKyKNxkvYT1qYdiHYldJQRU3F/jPrsIFc1GA9+sI/6l+eIemWbjzq8rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252808; c=relaxed/simple;
	bh=acN/ezs8iAPLyp3BzBJmwqAy15+20pYOD5fBlU3G2g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+YTk2RJharMLcVGD3CssYFJK5w9kkuc6qQcr0FqEIALqGWHaDToCK1218hmZHABlnU0lOu8S60nD7Sajwhg5h6RmHLAFI/sCvfAWgzGxeWJZCb5RMQes4AvvhP3JhanL3otI8oqPEGfs/2FFO0pT/PFEuWnLO6zczMSSyt+v88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mKmAhjZN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wW9pxkDzQg+yBW1oIEL/KaRBqPYRvqr8l7NCyzI1vz8=; b=mKmAhjZND32uINvoMlw8aAwV45
	JM8gYQ5yvZxJN9wwL5vOmaP9p9S4woOwnZ0QHbHYGf806WmsaApv6dRXJmvZmK443XlFau4HOK7ty
	PS1EOh+d95auyIjLW3cnUBc2m95ln+UEU39BI7kAt9oAgI8LjL4HzS341sX85VNHppwtBuwtTxWE0
	Ulrebm3qogVzFVpthb9yxcTPLXeTs8KauIprCix8nuCPkm3DJlNpNDU65BaNzE8zXehNuISKUkpUy
	4LOdrFf8xxRKGrTz914qlqIxvyGdrpytWDdz3IW1aet706cA2r7tYL6tXWhsvmN5J1VABBJOwP5gD
	9btd+zpg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55110)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYOcq-00045I-1a;
	Mon, 29 Jul 2024 12:33:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYOcp-0004HW-NT; Mon, 29 Jul 2024 12:33:11 +0100
Date: Mon, 29 Jul 2024 12:33:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 1/3] mm: turn USE_SPLIT_PTE_PTLOCKS /
 USE_SPLIT_PTE_PTLOCKS into Kconfig options
Message-ID: <Zqd998jx8NJK+BNX@shell.armlinux.org.uk>
References: <20240726150728.3159964-1-david@redhat.com>
 <20240726150728.3159964-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726150728.3159964-2-david@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jul 26, 2024 at 05:07:26PM +0200, David Hildenbrand wrote:
> Let's clean that up a bit and prepare for depending on
> CONFIG_SPLIT_PMD_PTLOCKS in other Kconfig options.
> 
> More cleanups would be reasonable (like the arch-specific "depends on"
> for CONFIG_SPLIT_PTE_PTLOCKS), but we'll leave that for another day.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

