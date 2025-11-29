Return-Path: <linux-fsdevel+bounces-70206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D56BC93A0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E7FB4E07A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848826B75B;
	Sat, 29 Nov 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PTjftmI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63A17736;
	Sat, 29 Nov 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406457; cv=none; b=Ie0DHpbs1s2DRA5si7C+644p6Gia4b6yaL7+XMnujqBXqg/zvyy1kCekpqKBWG3V+nSdpCuKjh1J5ryP6sPdY7C3mDrD/UIfvKJho0wPXRkbUSrlFaU2MUIB6pNzC1yYdn/aKVy/MOOQq+9oszZac8v0XBPkXOUihdW20+LCLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406457; c=relaxed/simple;
	bh=gU8LEriuqzssFY5/WEbdMxBL5mZ5059OviC7lQrEuww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX7s/DKavaNZwr6eGal/du3BMZhM1cTeOqB7T3myQoZPkBp5g15K3iooBbowfp6z/2S6IRmwo3vsBir54/4TQK9HT0Aa5iJV4a81pyWJ9SBe7RrQPjGDPjyoP+tIWkpYbTu0aMIGHiS/EY177zPMmQyWhODXEANyfXzpfgwOBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PTjftmI8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N5Hf/oCoaC+bmr5nJVcUOjG4GACNlaY1TCA6/nmAPjE=; b=PTjftmI8M0fFYykNkkoVgNwvZe
	sRl0yPdorZlBO7dqb9b2+56JO6cvDqq+27j4S4lAbjt0IfK906dSV0JHKIF6oUAcZh7F+1I9OXyXN
	6yRPprKZfRAggthT4NsG5xgCJhC8j4GQ9Y0hCbf/btIVPJ7aUN2sWaFQ1aXkZrmx7iSZU4M6KA5i1
	VpjlZA9tKeXauh5uTQb1RaTc10dAEnvXoJRgc3j3+Qj591X0teehEUGcHrjh3OQWbF6S0017Ao1VM
	/Vau/quGQchFyHIe6X16LLSWuE5UEd5iDmwgbHYeivqdZVuX9//YAH6hMECm1fPh6ioRSJEV6mVbY
	teD+rj7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPGid-00000007Cs0-3WJq;
	Sat, 29 Nov 2025 08:54:15 +0000
Date: Sat, 29 Nov 2025 08:54:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jack@suse.com, brauner@kernel.org,
	hch@lst.de, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	yangerkun@huawei.com, wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <20251129085415.GJ3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
 <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
 <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
 <3d590a6d-07d1-433c-add1-8b7d53018854@huaweicloud.com>
 <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 28, 2025 at 05:35:37PM -0800, Linus Torvalds wrote:
> On Fri, 28 Nov 2025 at 17:01, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
> >
> > Thank you for your answer. In fact, this solution is similar to the one
> > provided by Al.
> 
> Hmm. I'm not seeing the replies from Al for some reason. Maybe he didn't cc me.

<checks>
Sorry, I thought you've been somewhere in that Cc, should've verified that.

> That said, somebody should  definitely double-check me - because I
> think arm also did the vdso trick at high addresses that i386 used to
> do, so there is the fake VDSO thing up there.
> 
> But if you get a page fault on that, it's not going to be fixed up, so
> even if user space can access it, there's no point in looking that
> fake vm area up for page faults.

gate_vma is not inserted anywhere - it's special-cased in coredump_next_vma(),
proc_get_vma() and get_gate_page(); none of that can lead to insertion.

AFAICS its uses in mlock_fixup(), __mmap_complete() and should_skip_vam()
are pure paranoia - "if we somehow ended up running into gate_vma, let's
make sure we don't screw it over" and had always been that way.

So VMA lookup would get NULL.

