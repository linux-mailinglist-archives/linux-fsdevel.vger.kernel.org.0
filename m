Return-Path: <linux-fsdevel+bounces-76922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGZWJNfli2kcdAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:13:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9003120B7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A1F304706B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6922FDC57;
	Wed, 11 Feb 2026 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kM0AoIh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE91632;
	Wed, 11 Feb 2026 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776009; cv=none; b=Z8JGNE1ZYhEyD4A0T0gv1YxOAKC7TQot1Hmxw5wDuhbnZEbhthWrX/lUk3ipkE3s7ZW244bYklADi+zXMBSe+zcUnCqTESl4IODozqqOjDPJM0ODU+2uJ0/2E1oDXgyB/0mEkYBy+vkwEWzVXywXtlU0fkWSy+6dofPMRROF+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776009; c=relaxed/simple;
	bh=yXx4VCbLiHuPaGrCEAU8CteczPm6mdcA1lCmrgLNfPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEvtXqTXmAmINxjsMNtiC1pofxsp2lliW6TS3eZz3TADh8aOvgUSt8xQSZepL6hkEoNeIxRmGRGQJwLzcaMVuRReWIXoAbxOxfU7eZ7o/LttTx0mWSc5n+a5FyLHpWNIB09OouOO2huF89FK0ETO2kavR5nRaRV1cYcPZ2zHmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kM0AoIh3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BCI/XuxdC+8VK/bC2TL5MDk4fq6gWrkySuFHqo8v/kI=; b=kM0AoIh3/MJfTCJ00RGYvMf618
	wpTh+kRGhs7uUENK8fpJClag/GSqq0SYcVXXUF4dT8+Hh8j8C2mppeEGoGPpaFA7YzGNdjr32Ncz1
	PkYQ4hvRVXUZ2Rlt1LgG5Q1Lr9Pkj9jQdr/FCNoL7mip3SKvGuFrvzaxkvGbE6vCaxnpi7RExwMi/
	OTEBw7yJ42mutpdxFxps8anMRwiqzS4dNkPDsILeBgBp8n9J3Cqv0NZsjCupoPqcDvmHRnvxb4IRE
	28B6fA8X9KTfFWIq/hhi8SuQyuXUlcAhrT05EZlfULOI8Zwlx+1GHSf50np2KPg7FuIrwmu0GYqh4
	LR5J+8LQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpzlT-0000000HI4t-2U8k;
	Wed, 11 Feb 2026 02:15:39 +0000
Date: Wed, 11 Feb 2026 02:15:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <kees@kernel.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
Message-ID: <20260211021539.GK3183987@ZenIV>
References: <20260211004811.work.981-kees@kernel.org>
 <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
 <202602101736.80F1783@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602101736.80F1783@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76922-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: D9003120B7A
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:41:43PM -0800, Kees Cook wrote:

> > I think this path, where we always do maximally-sized allocations, is
> > the normal case where we're handling paths coming from userspace...
> 
> Actually, is there any reason we can't use strnlen_user() in
> do_getname(), and then just use strndup_user() in the long case?

Yes.  Not having to deal with the "oh, lookie - it became empty this
time around" case.


> > >         if (len <= EMBEDDED_NAME_MAX) {
> > >                 p = (char *)result->iname;
> > > -               memcpy(p, filename, len);
> > >         } else {
> > > -               p = kmemdup(filename, len, GFP_KERNEL);
> > > +               p = kmem_buckets_alloc(names_buckets, len, GFP_KERNEL);
> > 
> > ... while this is kind of the exceptional case, where paths are coming
> > from kernelspace.

mount -t ext2 fucking_long_pathname_resolving_to_dev_sda1 /mnt

Watch the show.  "Fucking long" here being "longer than 150 bytes or so".

