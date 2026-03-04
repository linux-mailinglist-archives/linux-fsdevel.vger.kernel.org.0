Return-Path: <linux-fsdevel+bounces-79328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLxSJCj1p2mtmwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:02:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56931FD0FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25270302592A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F003932EC;
	Wed,  4 Mar 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="d2OXpG0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180732F3621;
	Wed,  4 Mar 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614908; cv=none; b=XvSyVc3CHidsYjIy2nEPNbhdjBLGqtlNKi55IbH7GC4WAX6KjJKt9oHFsFqd+gvyhQuEyDeboXvS/P3NhykBdyHtzbM6GlUi32Q9O1GA4WfF562UZDj+QrTx8Xm8/WnXDZkTXRh795o2cHatP5n/vOUgeNdvKv6QNJj31a0fTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614908; c=relaxed/simple;
	bh=ehGPFM+kWOBBQgLWCGajYsr8v24skGnCz836BkXkxkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALpckjr6CJajd7XwgKVEWt/8Fu+yLca33VaZHIog0GfkHI0tFg9+OCp8EQ9VmziCaewDx3IJa/TM/KLQawIDSdsRB6h6tUNSGjP/UoUVXVT+yLlEc4qeR+X6LsBxgBmoG3rApF9IEMEvtm27Vyhf57fg84uEIxSOBRFygFd8tUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=d2OXpG0t; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=g8WKjVXqbK6twrBgILur2L+B82ZgxqV/6TBWKxNGmgA=; b=d2OXpG0tHtQnUCnrJti7DloqYg
	ptypQc/9ysbmXEbO+6xv2NETM9t8mnx+uX9r7jorDuaOefKBOT9E/WdnRMW6dCvQlpbRl5OK3+1aA
	AN6pMhiCERTY7bMYus4xfKt2GNxRZvuu1lSZn0KK7SKpO6pp0HDdWhXmCjTmcoYP7vXpxPdQyGkkR
	aEjefdq8S6oPeAGrL4mNDwUacccNYuFGknsUVmnDbULWWx3EMfi82dTmRvhh+K+0D90Ij1FIfbrOF
	at0auD9zbdJ2Y/UoolqFara3IuJ+NNDgN8jVmsA0arq47csD0TljzQM20wY65lQX0eiIawa8VHEfA
	sp0gReNxOALX4lpj9nfjQdXe9nxZ3R6r6jD8Ll5QLgEPZTBFnC5zxjCwSN/JVFXVIEa8L2md0iUZL
	Nk3v8NGyz/BdGQny5mQte5+px74I5uG16XLOdCMHdz+kZh9Q9cv5vvksUCXxFQLoWSgUmzo1oQNhg
	Q5br78ANCBgceOiVZBT8p4LpD/3hleeVc1FgjFzBe6V8SXjav+39C7kVMmXecn0EAQJxEAb2Wp4O4
	kdXTmHSnU2LPLUY9LP/Ty6RG2QJhZyKktjlujIbymDhoIRgnGhca2UX6PIHYS8yBCm82n77CsA3Wx
	d3/wNZvfk/g+74eIrhfOC3FM8K7iJcBv19WQnsnu0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>
Subject:
 Re: [PATCH v3 2/4] 9p: Add mount option for negative dentry cache retention
Date: Wed, 04 Mar 2026 10:01:42 +0100
Message-ID: <13960739.uLZWGnKmhe@weasel>
In-Reply-To: <aafsd7ScsUFs7xhp@pilgrim>
References:
 <cover.1772178819.git.repk@triplefau.lt> <aadWf2Ox2YXdy0Yl@codewreck.org>
 <aafsd7ScsUFs7xhp@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: E56931FD0FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79328-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crudebyte.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wednesday, 4 March 2026 09:25:27 CET Remi Pommarel wrote:
> On Wed, Mar 04, 2026 at 06:45:35AM +0900, Dominique Martinet wrote:
> > Christian Schoenebeck wrote on Tue, Mar 03, 2026 at 03:53:47PM +0100:
> > > > +	fsparam_string	("source",		Opt_source),
> > > > +	fsparam_u32hex	("debug",		Opt_debug),
> > > > +	fsparam_uid	("dfltuid",		Opt_dfltuid),
> > > > +	fsparam_gid	("dfltgid",		Opt_dfltgid),
> > > > +	fsparam_u32	("afid",		Opt_afid),
> > > > +	fsparam_string	("uname",		Opt_uname),
> > > > +	fsparam_string	("aname",		Opt_remotename),
> > > > +	fsparam_flag	("nodevmap",		Opt_nodevmap),
> > > > +	fsparam_flag	("noxattr",		Opt_noxattr),
> > > > +	fsparam_flag	("directio",		Opt_directio),
> > > > +	fsparam_flag	("ignoreqv",		Opt_ignoreqv),
> > > > +	fsparam_string	("cache",		Opt_cache),
> > > > +	fsparam_string	("cachetag",		Opt_cachetag),
> > > > +	fsparam_string	("access",		Opt_access),
> > > > +	fsparam_flag	("posixacl",		Opt_posixacl),
> > > > +	fsparam_u32	("locktimeout",		Opt_locktimeout),
> > > > +	fsparam_flag	("ndentrycache",	Opt_ndentrycache),
> > > > +	fsparam_u32	("ndentrycache",	Opt_ndentrycachetmo),
> > > 
> > > That double entry is surprising. So this mount option is supposed to be
> > > used like ndentrycache=n for a specific timeout value (in ms) and just
> > > ndentrycache (without any assignment) for infinite timeout. That's a
> > > bit weird.
> Yes I have seen this used in several other fs (see init_itable mount
> option for ext4fs or compress one for btrfs). I do agree that is a bit
> weird but this allow the whole 32bit range for timeout.
> 
> > Could make it a s32 and say <0 means infinite? I think we have that
> > somewhere
> 
> I did that on previous version, but was afraid that ~20days timeout max
> value may be too restrictive?
> 
> I do agree that this is a bit odd though and if you both think s32 is
> better that is fine with me.

What about just making this mount option a string and doing the parsing on our
end? That would have the benefit of simply allowing arguments like "i00s",
"5d", "1y", and if you really wanted "inf".

I would find units for this much more useful in practice than allowing
infinite. Like discussed before, it is in general a bad idea to configure
negative dentries to persist for good due to the huge amount of bogus entries
that pile up.

> > > Documentation/filesystems/9p.rst should be updated as well BTW.
> > > 
> > > Nevertheless, like mentioned before, I really think the string "timeout"
> > > should be used, at least in a user visible mount option. Keep in mind
> > > that
> > > timeouts are a common issue to look at, so it is common to just grep for
> > > "timeout" in a code base or documentation. An abbrevation like "tmo" or
> > > leaving it out entirely is for me therefore IMHO inappropriate.
> > > 
> > > You found "ndentrycachetimeout" too horribly long, or was that again
> > > just
> > > motivated by the code indention below? I personally find those indention
> > > alignments completely irrelevant, not sure how Dominique sees that.
> > > Personally I avoid them, as they cost unnecessary time on git blame.
> > 
> > I rarely use blame at all and it's possible to ignore whitespaces for
> > blame, but I'd tend to agree here, I don't care if this stays aligned.
> > 
> > OTOH ndentrycachetimeout as a mount option is a mouthful,
> > negativetimeout or negtimeout sounds clear enough to me?
> > I can't think of anything else that'd be negative related
> > to timeouts, but perhaps it's the lack of sleep speaking
> 
> No strong opinion on the option name though so any name that suits you
> is alse fine by me.

Another suggestion: "ndtimeout"?

/Christian



