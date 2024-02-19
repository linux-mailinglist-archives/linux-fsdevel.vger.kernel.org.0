Return-Path: <linux-fsdevel+bounces-12022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330F385A5DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BE81F21EE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67A376E5;
	Mon, 19 Feb 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="X6rgod5W";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="X6rgod5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054B37160;
	Mon, 19 Feb 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352791; cv=none; b=GsY2DiChj6L+4EumfxUKiRcHy3/a6m1qiwhjkUfJBHZEtIBwTZojRfx7jOJE0git7JZlJxzG7MhAJmuQzoiSyS5Wpd8s0XictVWm5Mx8dxbHviaz8xbV6kAa3aQWcMODSm88Bjy7aXph52hmmk0UwixNign1pKPcaWt45pItv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352791; c=relaxed/simple;
	bh=tDeLBVZBhJnHFKvYyiFdc/Oh6W2qYH8MubgFjeGN0t8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqNK7RsbXgKnqbsWngL02bLmZLe2zSGvYeHkTxxNQQ16zC2PfSQITmjgF9eGpJtKb9rmX119YuE/KUxMrlgpPoS+hxVO12Ke02xFikv1ptq1vpoZOOCo8/P4zL75sCCxmbRu/mKh/EnSo0/owk50erShfY4ik6e3cxdI5klBjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=X6rgod5W; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=X6rgod5W; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708352788;
	bh=tDeLBVZBhJnHFKvYyiFdc/Oh6W2qYH8MubgFjeGN0t8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=X6rgod5WNqiue37EBcG75bN+ZiZTpoNYon5iS1qMIA6pcgOykm/icAWOADJtAQDLx
	 z7jhf4a/X/mFCarEQ/7q8bfsK5Vc6/tt30BzUm0sTpjTWG+h3oYLvSM+FZDKtg6yjX
	 5hLko2nQBZalmgCPP0TPoBzs97/ef68sf56J3cck=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5A17A1286952;
	Mon, 19 Feb 2024 09:26:28 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id iFERsniFKniF; Mon, 19 Feb 2024 09:26:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708352788;
	bh=tDeLBVZBhJnHFKvYyiFdc/Oh6W2qYH8MubgFjeGN0t8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=X6rgod5WNqiue37EBcG75bN+ZiZTpoNYon5iS1qMIA6pcgOykm/icAWOADJtAQDLx
	 z7jhf4a/X/mFCarEQ/7q8bfsK5Vc6/tt30BzUm0sTpjTWG+h3oYLvSM+FZDKtg6yjX
	 5hLko2nQBZalmgCPP0TPoBzs97/ef68sf56J3cck=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 987511286941;
	Mon, 19 Feb 2024 09:26:27 -0500 (EST)
Message-ID: <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Cc: Christian Brauner <christian@brauner.io>, =?ISO-8859-1?Q?St=E9phane?=
	Graber <stgraber@stgraber.org>
Date: Mon, 19 Feb 2024 09:26:25 -0500
In-Reply-To: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
References: 
	<tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-02-17 at 15:56 -0500, Kent Overstreet wrote:
> AKA - integer identifiers considered harmful
> 
> Any time you've got a namespace that's just integers, if you ever end
> up needing to subdivide it you're going to have a bad time.
> 
> This comes up all over the place - for another example, consider
> ioctl numbering, where keeping them organized and collision free is a
> major headache.
> 
> For UIDs, we need to be able to subdivide the UID namespace for e.g.
> containers and mounting filesystems as an unprivileged user - but
> since we just have an integer identifier, this requires complicated
> remapping and updating and maintaining a global table.
> 
> Subdividing a UID to create new permissions domains should be a
> cheap, easy operation, and it's not.
> 
> The solution (originally from plan9, of course) is - UIDs shouldn't
> be numbers, they should be strings; and additionally, the strings
> should be paths.
> 
> Then, if 'alice' is a user, 'alice.foo' and 'alice.bar' would be
> subusers, created by alice without any privileged operations or
> mucking with outside system state, and 'alice' would be superuser
> w.r.t. 'alice.foo' and 'alice.bar'.
> 
> What's this get us?

I would have to say that changing kuid for a string doesn't really buy
us anything except a load of complexity for no very real gain. 
However, since the current kuid is u32 and exposed uid is u16 and there
is already a proposal to make use of this somewhat in the way you
envision, there might be a possibility to re-express kuid as an array
of u16s without much disruption.  Each adjacent pair could represent
the owner at the top and the userns assigned uid underneath.  That
would neatly solve the nesting problem the current upper 16 bits
proposal has.

However, neither proposal would get us out of the problem of mount
mapping because we'd have to keep the filesystem permission check on
the owning uid unless told otherwise.

> Much better, easier to use sandboxing - and maybe we can kill off a
> _whole_ lot of other stuff, too. 
> 
> Apparmour and selinux are fundamentally just about sandboxing
> programs so they can't own everything owned by the user they're run
> by.
> 
> But if we have an easy way to say "exec this program as a subuser of
> the current user..."
> 
> Then we can control what that program can access with just our
> existing UNIX permission and acls.
> 
> This would be a pretty radical change, and there's a number of things
> to explore - lots of brainstorming to do.
> 
>  - How can we do this without breaking absolutely everything?
> Obviously,
>    any syscalls that communicate in terms of UIDs and GIDs are a
>    problem; can we come up with a compat layer so that most stuff
> more
>    or less still works?
> 
>  - How can we do this a way that's the most orthogonal, that gets us
> the
>    most bang for our buck? How can we kill off as much security model
>    stupidity as possible? How can we make sandboxing _dead easy_ for
> new
>    applications?

So all of the above could be covered by a u16 kuid array with the last
element exposed to the user as the uid.  However, there are still
problems even with that approach: the unmapped uid/gid is something
some containers rely on and, as I said above, the mount mapping still
would have to be admin assigned.

James


