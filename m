Return-Path: <linux-fsdevel+bounces-76651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGeLLq5thmlaNAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 23:39:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD99103EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA62306632C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598030E856;
	Fri,  6 Feb 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liqzkMWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8C3043D7;
	Fri,  6 Feb 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417504; cv=none; b=eEmaRQHO2xHsRvgwMdTrYEK8nEwnsR5F4iMlRyKwriUddVHvy72Mht9h+zqrHr5HXRzydEQ4mZc5ipEordR04fC24MIs+ps8qHSLZcFdolMY5miMqwli/xWubjLlqzxghxby/InTF7qcgyZViL9QIMZdDZR9M2OndpnHM6Vt9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417504; c=relaxed/simple;
	bh=Bbw6VXoNApPGgxUT2nfFc0/wHQooiDOMNJ4U0eo4hJE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bRpvFatAPZnRCCoxYj+GLdwR701ccZ4R0/Cs3qAYlcgzpvlQzM+oCaym0iaGJY7X6fzuh9bjUoGZZNsl6sHIEklyDGHtsMSasQ4eCRHpUXB1DQ+1iKSAbCkHOCtCynjtFpKwvcBYFkIjnmbSsB62qejnPeHsTi8dY0dzmAv05Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liqzkMWI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id ACE2FEC00B1;
	Fri,  6 Feb 2026 17:38:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 17:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770417502; x=1770503902; bh=TOe6tBoZ94gvWUM5HNpF1Y5kR38DOrSzRwj
	4lmrYzFE=; b=liqzkMWI2o6lmVZkic1bmZQBYB1Wm9kJTC2pdTtDXU8OhW6DvCp
	y5lYzgpyixYHhrvcoVp7F2+u9G7MmMmIeAmOsG9uucStcMNVBcbqx3GkfwHDvjC2
	jTl4jg+wnpPvRirEqnHrR9eeZ1qWP2ppJSoPR8dW7smPdGpmxJcuLAjNXaEeqHI4
	W3sETnr7Nv4NmEu6FE1dTr+l+XX0lrVOoNoiTmWRWOTx6J6Pa8OcjE91SlAbBjmO
	U9/eg5FRzIl0fLXeHH19XTbHdjSKKfYDpVfLDUpeOKXkY0tzXDUD2Xt65X7BjKep
	n0qCEH4y8mNhJ1VTPi+ysOPPFkOqFxxSI5A==
X-ME-Sender: <xms:Xm2GaZJtEaTWxoE5dQxXaeVlgM8lw6Lymae5BggK1gsWuC68pFAA-Q>
    <xme:Xm2GaeEscSZ_n_ffVKVWF8y8OunTm6vuCsYf9D4Hdeoy6OFaM9boK4pNiRbyY2bRX
    AWtYczPYIcew-EHRIw502zCE54QnFiGhAW8FuUv-dO6_SgO-yF88XI>
X-ME-Received: <xmr:Xm2GadSJJ-Cd3BhLLl1oDQJpG8tnvlnAxAH9jbiUq_FoMHK5mp04P-bfvy_3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgv
    rhhshhhiphdrtghomhdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Xm2Gaadoi9VU5l4Rt4ViIHjceh6k1fWZs92-LS1Z4ECSNDEdbdl_Cw>
    <xmx:Xm2GacrzGMEsEnoKqMjqQAGQeq8QhiWMm0ph9wLX_3YxMfbSipLHoA>
    <xmx:Xm2Gab-4zHCp0mcKkpK08x7KccbukYJNJfDTbkX8T_XDyfIcz6WLFA>
    <xmx:Xm2GaYcSsE3piS4lvU9UptTvQrOk4X1jv3t0c5PQAAQprDsksXqI3g>
    <xmx:Xm2GaU_lcluMy6f64WLj3G8hzLByEop2ylf5m0D7h0DlCS71Xlmzor_J>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 17:38:20 -0500 (EST)
Date: Sat, 7 Feb 2026 09:38:48 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: "Darrick J. Wong" <djwong@kernel.org>
cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
    "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Documenting the correct pushback on AI inspired
 (and other) fixes in older drivers
In-Reply-To: <20260206051847.GC7693@frogsfrogsfrogs>
Message-ID: <2f1cd352-44d8-d014-240c-8b264c1ba95c@linux-m68k.org>
References: <32e620691c0ecf76f469a21bffaba396f207ccb9.camel@HansenPartnership.com> <5938441c-aaa9-c405-a78a-a66f387a5370@linux-m68k.org> <20260206051847.GC7693@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76651-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,linux-m68k.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DD99103EBA
X-Rspamd-Action: no action


On Thu, 5 Feb 2026, Darrick J. Wong wrote:

> On Fri, Feb 06, 2026 at 09:57:45AM +1100, Finn Thain wrote:
> > 
> > On Thu, 5 Feb 2026, James Bottomley wrote:
> > 
> > > To set the stage, we in SCSI have seen an uptick in patches to older 
> > > drivers mostly fixing missing free (data leak) and data race 
> > > problems. I'm not even sure they're all AI found, but we don't 
> > > really need to know that.
> > 
> > If I may predict the next scene, by extrapolating only a little, we 
> > are approaching the point where it will be feasible to request that an 
> > AI simply generate a new driver, based on chip datasheets plus all of 
> > the open source drivers available for training, rather than patch the 
> > bugs in an existing driver.
> > 
> > At that point, what use is a maintainer? I think we can still add 
> > value if
> 
> Being a magic sources of datasheets obtained through murky means, 
> obviously.  What /was/ grandpa doing when he came home with a bunch of 
> weird machinery at 3am in 1957??  :P
> 

I'm told he was building a steam-powered flying saucer. I don't know 
whether he was more interested in the question, how did we get here or to 
where might we go.

