Return-Path: <linux-fsdevel+bounces-79618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BM0DrrhqmkJYAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:16:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E92226EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D7E308A875
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED03D39C64A;
	Fri,  6 Mar 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fxZZ+mR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0+9sAXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CA384231;
	Fri,  6 Mar 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806419; cv=none; b=AZKNF4D53EyH/kV3DNVgQaADsEn7fSifR3ZWtUmVLLGyC7cttYolGLDg1YVLzIfHQZVZ2RGpgzadfvRcpcEZQllb4FBV3HLiBpJtNRy4+L1LTneKl07stu4aMyS4NkyBTDUkzDETodosGmEB8DSTY3XYc0I9rmHwnvQmVowK2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806419; c=relaxed/simple;
	bh=+/EWe3bgTQkUZhEU4SZyj/X7e11mhiDwwdBzt5mlP1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtJ4hD0zm3EZ88/8hdhRibAj5xy9jlv/843Bpsee+rReBvYjISKnykjVN2TMiREnQ1t8HmS2QrrLj0bbDAUoIJ5OymhM9h1uWuKdBSyIwp2hrZFxfYtgLm2IxwUWCqpxhnkRCEQbCx1qS5GD/Zul50H3FC/Cbpi/7HNuln24c4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fxZZ+mR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0+9sAXX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 21F821D000E1;
	Fri,  6 Mar 2026 09:13:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 09:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772806415; x=
	1772892815; bh=lzYG0S3OLle72IwqTl9xNJv1EjXZoWsv+cwzJ5nwMNA=; b=f
	xZZ+mR7+LcRMOzk3UUz4+WotycEzT2UaGotDtZ+4efi4P0Ch0jKMCZZiKTXHQ1ty
	ZJQ3yYTbCdKYXKPFZlglxSGgpFTt4BkqSvqBqj1GF0Q5LVyJ251Xb9C4aHQdfAkd
	X45YrBxPHWlEtWIpxwCCeIL0TwUbs0IfrsaoDrUXhmkbHwPFgsm9bQoeUpOvJ8lR
	mbwLct1CRvzt9KHsBGx0XeGA/v0pQhTVQHIezeVNip3BnCl3lguREW0cizMCtpFH
	jWDyZNa8aJQ2xxfO+gh2+I3mZ7BiM1VO6hNLYzzCR6sWex5YFPALHA+PLvVTfsqQ
	lrzgVyBuI4wFerLWYkTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772806415; x=1772892815; bh=lzYG0S3OLle72IwqTl9xNJv1EjXZoWsv+cw
	zJ5nwMNA=; b=X0+9sAXXNjHfZDB+rgGnt7J2/aV+YF9oV0ESEZx5jmuFOUjElzr
	3yBaQQh4kLaeYUu4d5O+i5Eoy6TUBpVmBC82y08x/uwK0y//pMQmlY9MuO1Hnctz
	pxhOInFFjdHZczYmOi16eLjj21KqJrdTGDa8lrCOSA8hczwqv/xZNbCCFyG6eion
	JJaKs4Jsy8jMWFcNCuwF/hn91/TD3jOEUEvHtpjpUltpKTE31oMfzdl0PBOm4mgF
	kS62N5T5CdSLa4U1zN7XhvubX4X8iYPY/KZjYlGBPPduaIOQ/Jg0ZlnIX82YE9Pv
	sID+8ZEembboc7yKsDluwIy5bpLSgTcXtdQ==
X-ME-Sender: <xms:D-GqaWHfztgWLh-jRq4w5-PUcHUngB3g5d3RbTrS9467kUUsXVhOyg>
    <xme:D-GqaV2AuBcFezrBP5GCt3p92K07y0rPm5J-jH1ay6RcVJAz4ds-fH2_sUdVX3fYl
    ArET3csXHzd5zZ6sTljYiEm_TaoV0dWIBRVh1sbOiOXKkrdICGjJ8E>
X-ME-Received: <xmr:D-GqaW9Rmk4_BYqCMxip8pVnCryJvBZn5EuMaOwUluqx9tQNlsA-N7rIt8bdpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopegtrghrghgvshestghlohhuughflhgrrhgvrdgtohhm
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopeifihhllhhirghmrdhkuhgthhgrrhhskhhisehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhestghlohhuughflhgrrhgvrdgtohhm
X-ME-Proxy: <xmx:D-GqaQGymEIUStWCZAtCeFts3hFHvuiN3ine-c1kLrMebgFqzCOaJQ>
    <xmx:D-GqaUju21E8t6wABq5p4HMdThzOFpsQshKW4Ia74-TTiBt-PXm_3w>
    <xmx:D-Gqad-iUcnozrL2qmz__kO5ombPYH9WtfEK_oeY2SSfx4QSmutJag>
    <xmx:D-Gqaca4V3aHYvlkp6NSWwlt3J0OaMs2h4bZnPuL9Xwb91NN22l_3Q>
    <xmx:D-GqaZlo3CyXRuhG-JwoQ4OR0qw8ozbFlbzQgATj41gGl74dV9pqL0z9>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 09:13:33 -0500 (EST)
Date: Fri, 6 Mar 2026 14:13:26 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris J Arges <carges@cloudflare.com>, akpm@linux-foundation.org, 
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aarVMrFptdXhHsX1@thinkstation>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanYdvdJVG6f5WL2@casper.infradead.org>
X-Rspamd-Queue-Id: B14E92226EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-79618-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shutemov.name:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 07:24:38PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 05, 2026 at 12:34:33PM -0600, Chris J Arges wrote:
> > We have been hitting VM_BUG_ON_FOLIO(!folio_contains(folio, index)) in
> > production environments. These machines are using XFS with large folio
> > support enabled and are under high memory pressure.
> > 
> > >From reading the code it seems plausible that folio splits due to memory
> > reclaim are racing with filemap_fault() serving mmap page faults.
> > 
> > The existing code checks for truncation (folio->mapping != mapping) and
> > retries, but there does not appear to be equivalent handling for the
> > split case. The result is:
> > 
> >   kernel BUG at mm/filemap.c:3519!
> >   VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio)
> 
> This didn't occur to me as a possibility because filemap_get_entry()
> is _supposed_ to take care of it.  But if this patch fixes it, then
> we need to understand why it works.
> 
> folio_split() needs to be sure that it's the only one holding a reference
> to the folio.  To that end, it calculates the expected refcount of the
> folio, and freezes it (sets the refcount to 0 if the refcount is the
> expected value).  Once filemap_get_entry() has incremented the refcount,
> freezing will fail.
> 
> But of course, we can race.  filemap_get_entry() can load a folio first,
> the entire folio_split can happen, then it calls folio_try_get() and
> succeeds, but it no longer covers the index we were looking for.  That's
> what the xas_reload() is trying to prevent -- if the index is for a
> folio which has changed, then the xas_reload() should come back with a
> different folio and we goto repeat.
> 
> So how did we get through this with a reference to the wrong folio?

What would xas_reload() return if we raced with split and index pointed
to a tail page before the split?

Wouldn't it return the folio that was a head and check will pass?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

