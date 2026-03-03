Return-Path: <linux-fsdevel+bounces-79285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JY7FrFWp2lsgwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 22:46:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8D1F7B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 22:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 704CB311959B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151642981B;
	Tue,  3 Mar 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="M5Wn63vg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046D386553;
	Tue,  3 Mar 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574364; cv=none; b=HYnORNhEfBw11aWl0sYUEO/h3zSGrrXfnVT3DzqxrQgzWsVzWnbaKOp28rvR1bVYOgpcrgGrq30ZaEIvod1vXX2iGKGWQkejp67+C16jm0JCxCYhajl2LRsAYfMOCjg1HYPvNmEkHGEflxLbBtju5n/TH7Q5xKh6yca3MGPl0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574364; c=relaxed/simple;
	bh=2iw47QQeX2aJszd3ud9fgZ8tNYeBXLW8wdU+qKT58To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbvrniz88h7du+hPJhyGTQyTEbg213qjUlTi81pFhGHQMZ3SjKDvlzVhEGmWoK3iixQKeMDQFa4je4KZ1tPpJ3n60pIksZNS/FyfogKj9FFcSatwvjH0PShnqAip57W79xFKrZSgYTngaiLIdxob1w0pBSq66vM9EM1d/xtxrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=M5Wn63vg; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5DCC114C2D6;
	Tue,  3 Mar 2026 22:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1772574354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqw6Gp00vmN2wCIBCC42+OGM7Hju1LQMDUDP+ozWPI0=;
	b=M5Wn63vgCxSEzdfkuMx6yE/ABrwQwxw4sgfTzR8MUr9wcUK+eVXoVC6xeiqOxzXDgvQZ1Y
	pvtPXK57E998DT3S8iMev2xs5Xia5mMgSyvI/y3EH8jJZTAZ+MpzyuDZsBskzJptFyXTm9
	CvEfyprd9ya0xkljLJgUZKfytnGsGRXQKiCCyienD+XsKRtK0XE+bcR0jIPFovxHVcuEux
	lnvh75k1zOFa4Wv/jKq/Ksfsrhp+SehNW0rvWOb6WWDD6C0Baojwt21ebCfcxc+SOTNjuo
	qJNGSHoiVi7ZuT+WAd0x71/SS1ETmNOdcB+gIo4N0bvrqyDY/LDkjxcTeS+a6w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4affcf27;
	Tue, 3 Mar 2026 21:45:50 +0000 (UTC)
Date: Wed, 4 Mar 2026 06:45:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache
 retention
Message-ID: <aadWf2Ox2YXdy0Yl@codewreck.org>
References: <cover.1772178819.git.repk@triplefau.lt>
 <7c2a5ba3e229b4e820f0fcd565ca38ab3ca5493f.1772178819.git.repk@triplefau.lt>
 <4490625.ejJDZkT8p0@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4490625.ejJDZkT8p0@weasel>
X-Rspamd-Queue-Id: D3D8D1F7B67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	TAGGED_FROM(0.00)[bounces-79285-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,codewreck.org:dkim,codewreck.org:mid]
X-Rspamd-Action: no action

Christian Schoenebeck wrote on Tue, Mar 03, 2026 at 03:53:47PM +0100:
> > +	fsparam_string	("source",		Opt_source),
> > +	fsparam_u32hex	("debug",		Opt_debug),
> > +	fsparam_uid	("dfltuid",		Opt_dfltuid),
> > +	fsparam_gid	("dfltgid",		Opt_dfltgid),
> > +	fsparam_u32	("afid",		Opt_afid),
> > +	fsparam_string	("uname",		Opt_uname),
> > +	fsparam_string	("aname",		Opt_remotename),
> > +	fsparam_flag	("nodevmap",		Opt_nodevmap),
> > +	fsparam_flag	("noxattr",		Opt_noxattr),
> > +	fsparam_flag	("directio",		Opt_directio),
> > +	fsparam_flag	("ignoreqv",		Opt_ignoreqv),
> > +	fsparam_string	("cache",		Opt_cache),
> > +	fsparam_string	("cachetag",		Opt_cachetag),
> > +	fsparam_string	("access",		Opt_access),
> > +	fsparam_flag	("posixacl",		Opt_posixacl),
> > +	fsparam_u32	("locktimeout",		Opt_locktimeout),
> > +	fsparam_flag	("ndentrycache",	Opt_ndentrycache),
> > +	fsparam_u32	("ndentrycache",	Opt_ndentrycachetmo),
> 
> That double entry is surprising. So this mount option is supposed to be used
> like ndentrycache=n for a specific timeout value (in ms) and just ndentrycache
> (without any assignment) for infinite timeout. That's a bit weird.

Could make it a s32 and say <0 means infinite? I think we have that
somewhere

> Documentation/filesystems/9p.rst should be updated as well BTW.
> 
> Nevertheless, like mentioned before, I really think the string "timeout"
> should be used, at least in a user visible mount option. Keep in mind that
> timeouts are a common issue to look at, so it is common to just grep for
> "timeout" in a code base or documentation. An abbrevation like "tmo" or
> leaving it out entirely is for me therefore IMHO inappropriate.
> 
> You found "ndentrycachetimeout" too horribly long, or was that again just
> motivated by the code indention below? I personally find those indention
> alignments completely irrelevant, not sure how Dominique sees that.
> Personally I avoid them, as they cost unnecessary time on git blame.

I rarely use blame at all and it's possible to ignore whitespaces for
blame, but I'd tend to agree here, I don't care if this stays aligned.

OTOH ndentrycachetimeout as a mount option is a mouthful,
negativetimeout or negtimeout sounds clear enough to me?
I can't think of anything else that'd be negative related
to timeouts, but perhaps it's the lack of sleep speaking

-- 
Dominique Martinet | Asmadeus

