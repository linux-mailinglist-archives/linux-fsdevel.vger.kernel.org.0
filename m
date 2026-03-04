Return-Path: <linux-fsdevel+bounces-79330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDbJD5v4p2mtmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:17:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FDF1FD6E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93F3230391D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8BD396B6B;
	Wed,  4 Mar 2026 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="2tOyFfCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B63947B4;
	Wed,  4 Mar 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615809; cv=none; b=V4gptPp8u/f5BX4AZ6Wy4A8gNarKmP/sic7HLEuNfs4p/kKR73OqgGW3SOAwxd1lToHl8RlV3aT1JlKhv1pSwda2evTjTUKGrHfwBs9GPamrazcUIWSL3+moxylUVXfdawQ7WYO4sFViyD1T7YwjmsPmJBxQUveOSvLgzHcIYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615809; c=relaxed/simple;
	bh=1EEZ83v1+EMxfMa02F0rhibjxszWr11ekEuAPr/ufx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY8JtBuH9t6F7U+Qn6/JNd74D5CfQRhXxI0k2hurC1OAB6O8rp1K/Qy5+IpaBVrwK9FClKeH7sqItypqQ1IjR1Pc2RbueL9jDr3BFkiR0aMFbk7QzDPxgBalhJQ2PirnmRWMoJyLetCLGJj5zetBs+zth1UMiho00hZTutStSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=2tOyFfCq; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id DA18D14C2D6;
	Wed,  4 Mar 2026 10:16:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1772615805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9CDL3UZbKTV8AQXBRIcsYDFtz3IA/Nn7yvrFkE8WFto=;
	b=2tOyFfCqEk90tdjDcVrTGHPjhRUnN/W7+D6ZuTgu6nd5SqhUswxOxLKaScq5sLkyIhHe+a
	8XsovoR12gdMLNgylik1V9vkn/B1N8bQbFnYV8qlWxLqcg3V7sLvZrnd7/Sd/pe2jE6fmb
	uvkeRGJlt5pQGJuDUHyfxsAxbe5G28tXFn324rQlqhcr7YGs1Qm2Tba/uYs/A5md2THezw
	aaibLoorLpB+jhuW+7o4GynXDvbQDOD30IHfxGz6xTfZC8jh8cq0BC38udWZ1OA5qAQDhp
	a1cDno1Hf4pj/fX3LC3J7+o01g4ljmc3VXZ5W7K+1QLlw3Wqi0l4cbEivxKxRQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2bac8eca;
	Wed, 4 Mar 2026 09:16:41 +0000 (UTC)
Date: Wed, 4 Mar 2026 18:16:26 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Remi Pommarel <repk@triplefau.lt>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache
 retention
Message-ID: <aaf4athb6nUyxB83@codewreck.org>
References: <cover.1772178819.git.repk@triplefau.lt>
 <aadWf2Ox2YXdy0Yl@codewreck.org>
 <aafsd7ScsUFs7xhp@pilgrim>
 <13960739.uLZWGnKmhe@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13960739.uLZWGnKmhe@weasel>
X-Rspamd-Queue-Id: D3FDF1FD6E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	TAGGED_FROM(0.00)[bounces-79330-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,codewreck.org:dkim,codewreck.org:mid]
X-Rspamd-Action: no action

Christian Schoenebeck wrote on Wed, Mar 04, 2026 at 10:01:42AM +0100:
> > I did that on previous version, but was afraid that ~20days timeout max
> > value may be too restrictive?
> > 
> > I do agree that this is a bit odd though and if you both think s32 is
> > better that is fine with me.
> 
> What about just making this mount option a string and doing the parsing on our
> end? That would have the benefit of simply allowing arguments like "i00s",
> "5d", "1y", and if you really wanted "inf".
> 
> I would find units for this much more useful in practice than allowing
> infinite. Like discussed before, it is in general a bad idea to configure
> negative dentries to persist for good due to the huge amount of bogus entries
> that pile up.

I don't mind either way -- I think 20 days for such a timeout is enough,
but I agree being able to set something like '60s' or '100ms' would
certainly be convenient.

I'm actually surprised there's no such parsing helper in the kernel?!
The only related code I could find was parse_ns_duration /
parse_seconds_duration in tools/tracing/rtla/src/utils.c but that's for
tools, and there doesn't seem to be anything we could use..

Well, it's not that bad, so I'm not fussy here.


> > > OTOH ndentrycachetimeout as a mount option is a mouthful,
> > > negativetimeout or negtimeout sounds clear enough to me?
> > > I can't think of anything else that'd be negative related
> > > to timeouts, but perhaps it's the lack of sleep speaking
> > 
> > No strong opinion on the option name though so any name that suits you
> > is alse fine by me.
> 
> Another suggestion: "ndtimeout"?

I'd slightly favor negtimeout over ndtimeout but am fine with either
here.
('nd' sounds like something network-y to me, network discovery or ndo,
but that's not a hard no)


Thanks,
-- 
Dominique Martinet | Asmadeus

