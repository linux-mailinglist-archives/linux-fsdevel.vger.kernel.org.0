Return-Path: <linux-fsdevel+bounces-36567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E79E5F43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14092284BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F022F39F;
	Thu,  5 Dec 2024 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTIjc9GU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342ED22F390;
	Thu,  5 Dec 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429164; cv=none; b=bRK4GoJsyZN6McXsZiDNbS1cX0bpUS0IyBkHWi7YduGx+OIooZrXctQpgTbaac+qyexkf9KbiMfWdNrt8JE3qtVK9IzFsn4xli+w9NPGVuLYufk7GzHRobtwg8dVmwTdpNkANKbvt5RHGKOkjmI/z/XTFkGT35XNAqGOlLK4DbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429164; c=relaxed/simple;
	bh=yZYdrzxkLR9k1VV/w47d55MwBq0CYQw9m2HuQcprO8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4k/KPbHBWzAteBjuLZ6G4C5yrP2aVqzgCgYjMVk4RWCoVVzvzOJc4Dgt926Ha5UAFJlvBr9ZDs7bLVUCCG6xFBuK0+2uQx7mCfezNuiOVrb/QfXjTX8nK6gKx/uB4DWH4+e6OdETj1CbXz5E/UngZgSB3O8xTqF2gbXo9dx6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTIjc9GU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CB4C4CED1;
	Thu,  5 Dec 2024 20:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733429163;
	bh=yZYdrzxkLR9k1VV/w47d55MwBq0CYQw9m2HuQcprO8I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PTIjc9GUvElGqqvD16FN1etzDruYwwH8kXY+X5hCAD2sTtqOoq4inxuCXg8VqGsQG
	 mbWzQdInO3S1mbGslVD7W+GkC0E2IqZbxldDqcQtqkwD71Djsyq2dj0R4VL+OQp6YE
	 zMuzX5ygZQ782S4+euxTLd01CKjgCq6p2v1z3l8YZB04OIv0Y+3175MYLzxvpwcMD+
	 ogr38Rd2gdK0sRXW2fFTsYHNPWp+jmG+iA1ApPqNwhYyf+pizZN1AF0poYBHr1A+Qx
	 bzMxXEW3KUInnZpOetIT9A8L6f97lNO2rKJMA2MltMRsvCQpijg5TNOI4yZyMWuPzR
	 JXSbvyepbxX9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1F2C0CE0774; Thu,  5 Dec 2024 12:06:03 -0800 (PST)
Date: Thu, 5 Dec 2024 12:06:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <26105438-9c1e-455d-8d9e-3ec81f60101b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
 <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
 <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>

On Thu, Dec 05, 2024 at 11:26:35AM -0800, Linus Torvalds wrote:
> On Thu, 5 Dec 2024 at 10:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > To my understanding this is the idiomatic way of spelling out the
> > > non-existent in Linux smp_consume_load, for the resize_in_progress
> > > flag.
> >
> > In Linus, "smp_consume_load()" is named rcu_dereference().
> 
> Linux.

One of those days...  ;-)

> But yes and no.
> 
> It's worth making it really really clear that "rcu_dereference()" is
> *not* just a different name for some "smp_consume_load()" operation.
> 
> Why? Because a true smp_consume_load() would work with any random kind
> of flags etc. And rcu_dereference() works only because it's a pointer,
> and there's an inherent data dependency to what the result points to.
> 
> Paul obviously knows this, but let's make it very clear in this
> discussion, because if somebody decided "I want a smp_consume_load(),
> and I'll use rcu_dereference() to do that", the end result would
> simply not work for arbitrary data, like a flags field or something,
> where comparing it against a value will only result in a control
> dependency, not an actual data dependency.

Fair points!

And Linus (and Linux, for that matter) equally obviously already knows
this, but please note also that an smp_load_consume() would still order
only later dereferences of the thing returned from smp_load_consume(),
which means that it pretty much needs to be a pointer.  (Yes, in theory,
it could be an array index, but in practice compilers know way too much
about integer arithmetic for this to be advisable.)

							Thanx, Paul

