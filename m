Return-Path: <linux-fsdevel+bounces-78763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAHRI0/moWmUwwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:45:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE551BC235
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2E0309344C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F23A1A26;
	Fri, 27 Feb 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F6U9hWoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDB30EF96
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217929; cv=none; b=c13pDMczGc9+BCnpP7V0cz3abwrmn9MR7RQEjZDBEvX7lXV6LTXyEm9/yBqBVOXwHAY0Jh+sJgaEULoTA4K2BgmHTG3rRKJrBwg9AqM+Y9RP1k+HfmywiBEB9OtzFo7ZDatHZHGkzlBPaREYYPd25NmARNdps3BfeV5+YlCHYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217929; c=relaxed/simple;
	bh=OV59z+v8QXYIGkHgeQ0HgUC5XX0G029Y4uNdyFJsBic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9XqIuFg/JWWOODqzx1L0o6xZnI6lf0tAR0m+wIbYduyQoe3DDHncmdbAN9ol5fXbDfMgVpfQQUROwQNHG1/JIyuECzqMChONXzYzv5/ob8ghwfOSL85tS9KlITg819lt3nXWvrYJZczh6JUeytN6AzegPXFwXy4Dai83Z6g9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F6U9hWoD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xf/Xguk0i0ou334iTYbS1A9S5uLdl09+LA+LZNhDHek=; b=F6U9hWoDvVZ67toI1R9jIhZ8lD
	txK0qWYl6fjvhcwLoxzWjbE8iq4KmO8hZdkik7VQSR4WylINNAhn5Vhmt+w0wB52D6GeoZzFNGSiT
	CTJQUgB4/i8HB4mncSjT0yGs/uvljG3OdB9Y7XoBDZ5utrqYFZCHBL5yYKGVbjJuqJT/2K1+yLl7D
	6r6VJbWeJ7YTw4z/9uCwkFIg8RkchmjFQUb15rNslMhr7WIqiuuOy+B5OwyejfKJgXa5v9zEK98ZN
	mEdA+S4qp3dIM/2zb4esN++JiGNzeVyKWNtP0rt44sYw67FjdVBRiGSTRRpQdfJ4oEfuoN9hx+/e4
	i5jTRqRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vw2se-00000008qsT-1AVr;
	Fri, 27 Feb 2026 18:48:04 +0000
Date: Fri, 27 Feb 2026 18:48:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: hooanon05g@gmail.com
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
Message-ID: <20260227184804.GC3836593@ZenIV>
References: <14544.1772189098@jrotkm2>
 <20260227152211.GB3836593@ZenIV>
 <26309.1772206864@jrotkm2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26309.1772206864@jrotkm2>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-78763-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBE551BC235
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 12:41:04AM +0900, hooanon05g@gmail.com wrote:
> Al Viro:
> > This
> > struct filename *getname_uflags(const char __user *filename, int uflags)
> > {
> >         int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
> >
> > 	return getname_flags(filename, flags);
> > }
> > is where AT_EMPTY_PATH is handled; could you check the arguuments it's getting
> > in your reproducer and argument passed to getname_flags()?
> 
> getname_flags() is not a problem.
> For me, the problem looks that LOOKUP_EMPTY is NOT passed to
> path_lookupat().

Could you please show me a single place in path_lookupat() where we would
check for for LOOKUP_EMPTY?

The last point where LOOKUP_EMPTY (or AT_EMPTY_PATH) matters is (and had
always been) getname_flags(); pathname resolution proper doesn't care.

In theory some out-of-tree filesystem might have been playing silly
buggers with LOOKUP_EMPTY in its ->d_revalidate(); there's no good
reason for doing so, though, and none of the in-tree filesystems had
ever tried to pull that off.

Could you describe the reproducer in more details?

