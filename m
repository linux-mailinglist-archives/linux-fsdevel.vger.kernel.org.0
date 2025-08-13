Return-Path: <linux-fsdevel+bounces-57785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E45B2540A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A57D8883DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA231286D45;
	Wed, 13 Aug 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aXOl58PK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A32F99B6;
	Wed, 13 Aug 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114111; cv=none; b=g2sf+irYoov9HPdLu14h3mYFRPZdiRpnuzReIYM5lp9Xm7/s9+SqyTh7hDyhJ0R60RqCCKO0dm0ys3ZhNmn6/51kZuQDhnSKOH1cQlCosDR6G1sWTb+KDvjBhSl1G09GOGnbJ9LaFs1r13GaoLFY7/heOHgJ22sgBg722SdjAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114111; c=relaxed/simple;
	bh=qmwFwYVx9a9mOH/ygGkrp40YlHbmPY54wIWpg6RQYXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BACVQXqR9Rdr7CunxbSz/X187L44IWrjIh2fCpnSBkGS+bFb1zulhSpVGd/GUxwGAfyktnCmT5OP7a1wSnHDYnq3fgGbCrYjnrug22Iw/ebXeDJZtkB8g5BAb/4ab4HUZ2NVGf24bUC2u5Rji8FBekJp/Gd4OUM/aixOTFhe7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aXOl58PK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q2DJiIdRH85a3SnMMNPhRxU1a6Qb8UVE6IdhEPXqXW4=; b=aXOl58PKRoLIYcpryVx+s7m3ac
	LsARIRkp9tNud+gEzN4iL5zPRAIq9bu/xtqqNS9Vm+cXiCW3RSZe1XWNiHH2xY4gNR0BcYwAcka85
	gKyWPuLvIRxBjtU7FiZjIxE2+kCn+NiJS5gPoTeocjsUSX9gYt0tEfZuXe7RSKNJ72VzWurad+5Hc
	/IVFR9ls2m/DifhrPODQL+5SFdHwAllEV8jaFJ5bIqTNwrjsH8k0xajefTl32ySLy+frkxKcmLt0q
	Yyqqv23FnkzQgtRNjD+av2kKXPmR65JVTxHnm/P1ho58RHh0KhSVk1ms4ox91bLNPc5TDJxLpUcDt
	OTkRjGjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umHM1-0000000Cmp5-0Pu1;
	Wed, 13 Aug 2025 19:41:45 +0000
Date: Wed, 13 Aug 2025 20:41:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@google.com>, Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <20250813194145.GK222315@ZenIV>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV>
 <aJzi506tGJb8CzA3@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJzi506tGJb8CzA3@tycho.pizza>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 13, 2025 at 01:09:27PM -0600, Tycho Andersen wrote:
> On Wed, Aug 13, 2025 at 07:56:01PM +0100, Al Viro wrote:
> > @@ -3347,18 +3360,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
> >  
> >  	namespace_lock();
> >  
> > -	err = -EINVAL;
> > -	/* To and From must be mounted */
> > -	if (!is_mounted(&from->mnt))
> > -		goto out;
> > -	if (!is_mounted(&to->mnt))
> > -		goto out;
> > -
> > -	err = -EPERM;
> > -	/* We should be allowed to modify mount namespaces of both mounts */
> > -	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> > +	err = may_change_propagation(from);
> > +	if (err)
> >  		goto out;
> > -	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> > +	err = may_change_propagation(from);
> 
> Just driving by, but I guess you mean "to" here.

D'oh...  Yes, of course.  Fun question: would our selftests have caught
that?
[checks]
move_mount_set_group_test.c doesn't have anything in that area, nothing in
LTP or xfstests either, AFAICS...  And I don't see anything in
https://github.com/checkpoint-restore/criu
either - there are uses of MOVE_MOUNT_SET_GROUP, but they are well-buried
and I don't see anything in their tests that would even try to poke into
that thing...

Before we go and try to cobble something up, does anybody know of a place
where regression tests for MOVE_MOUNT_SET_GROUP could be picked from?

