Return-Path: <linux-fsdevel+bounces-12206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A944D85CF29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2057E1F25533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11DA38DE8;
	Wed, 21 Feb 2024 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YfX3c0Tn";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VqUWuhgt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91888460;
	Wed, 21 Feb 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487646; cv=none; b=eCSI35Um2Ai8plr2ocmfXO7bRt6EBefW7oIp07ASGfbgJM3E6lDNh/BElqhxQVl6Fnem8kwhMHKddXu/f/xSTtCM10uO9TpepX4NA7qp4KuTQan6GILY3/Y8VVOdzZ+07K5zfESOJ+w3tfAkXKET3YSq2gmlqqLp0GFM74E54UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487646; c=relaxed/simple;
	bh=0r2eJcR8uv882dJ9kLZyiUPHOvlr5JnQiM8ZYXv2ZJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhWI2bnkAZzO2+wUpzgbuIJ4px01eF+AVGhJ/hrvg59v9J0SLPg6RZU9AKps4Q6+HFDe4Gcd6ZXL303nMaI2ApUY67YnRkIQedI1SCp7TuJMHu1zNBD4dReteTxlNO94yYYea5GilnbmNUum01FNkYKhDh8uolHB54aAy9c2CC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YfX3c0Tn; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VqUWuhgt; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708487643;
	bh=0r2eJcR8uv882dJ9kLZyiUPHOvlr5JnQiM8ZYXv2ZJc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=YfX3c0TntyHI8jdtoxPpk+ZYgyUGFb8Gh6wRlHJTXpgr/R9lpu0ABt/o7hC94caTT
	 5HwenwvpBlhjEsuqFV70peOrhbtZP9xPEUx1P032BvJjrTvSgd5oG+YIW3ewbWAs0W
	 dkVvOHRPErqJtOIxqEINQHuAhsMtsffho4ucQnXI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0668D1285D5F;
	Tue, 20 Feb 2024 22:54:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id vxWwJu1JQ3zD; Tue, 20 Feb 2024 22:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708487642;
	bh=0r2eJcR8uv882dJ9kLZyiUPHOvlr5JnQiM8ZYXv2ZJc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VqUWuhgtJPh4hzKc/KzZn+SA7lmOu65DUWsBKXmk9looUKGW8ku3QC7WXOHOmYwQ6
	 ziQ51aFNCyBdfVevey8YdvrW+iTNIVlJp3M+BaEsFfNNpZ/zz4okCKdoXnc13Jxm+1
	 /c8+jjbKMnDeKDe0Bz5SD440NezZJaqoR/v84hcI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B6DAA1281C36;
	Tue, 20 Feb 2024 22:54:01 -0500 (EST)
Message-ID: <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lsf-pc@lists.linux-foundation.org, Christian Brauner
 <christian@brauner.io>,  =?ISO-8859-1?Q?St=E9phane?= Graber
 <stgraber@stgraber.org>
Date: Tue, 20 Feb 2024 22:53:58 -0500
In-Reply-To: <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
References: 
	<tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
	 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
	 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-02-20 at 19:25 -0500, Kent Overstreet wrote:
> On Mon, Feb 19, 2024 at 09:26:25AM -0500, James Bottomley wrote:
> > I would have to say that changing kuid for a string doesn't really
> > buy us anything except a load of complexity for no very real gain. 
> > However, since the current kuid is u32 and exposed uid is u16 and
> > there is already a proposal to make use of this somewhat in the way
> > you envision,
> 
> Got a link to that proposal?

I think this is the latest presentation on it:

https://fosdem.org/2024/schedule/event/fosdem-2024-3217-converting-filesystems-to-support-idmapped-mounts/

> 
> > there might be a possibility to re-express kuid as an array
> > of u16s without much disruption.  Each adjacent pair could
> > represent the owner at the top and the userns assigned uid
> > underneath.  That would neatly solve the nesting problem the
> > current upper 16 bits proposal has.
> 
> At a high level, there's no real difference between a variable length
> integer, or a variable length array of integers, or a string.

Right, so the advantage is the kernel already does an integer
comparison all over the place.

> But there's real advantages to getting rid of the string <-> integer
> identifier mapping and plumbing strings all the way through:
> 
>  - creating a new sub-user can be done with nothing more than the new
>    username version of setuid(); IOW, we can start a new named
> subuser
>    for e.g. firefox without mucking with _any_ system state or tables
> 
>  - sharing filesystems between machines is always a pita because
>    usernames might be the same but uids never are - let's kill that
> off,
>    please
> 
> Doing anything as big as an array of integers is going to be a major
> compatibiltiy break anyways, so we might as well do it right.

I'm not really convinced it's right.  Strings are trickier to handle
and compare than integer arrays and all of the above can be done by
either.

> Either way we're going to need a mapping to 16 bit uids for
> compatibility; doing this right gives userspace an incentive to get
> _off_ that compatibility layer so we're not dealing with that
> impedence mismatch forever.

Fundamentally we have a load of integer to pretty name things we use in
the kernel (protocol, port, ...).  The point though is the kernel
doesn't need to know the pretty name, it deals with integers and user
space does the conversion.

> > However, neither proposal would get us out of the problem of mount
> > mapping because we'd have to keep the filesystem permission check
> > on the owning uid unless told otherwise.
> 
> Not sure I follow?

Mounting a filesystem inside a userns can cause huge security problems
if we map fs root to inner root without the admin blessing it.  Think
of binding /bin into the userns and then altering one of the root owned
binaries as inner root: if the permission check passes, the change
appears in system /bin.

> We're always going to need mount mapping, but if the mount mapping is
> just "usernames here get mapped to this subtree of the system
> username namespace", then that potentially simplifies things quite a
> bit - the mount mapping is no longer a _table_.

But what then is it?  If you allow the user arbitrarily to assign
subuids, you can't trust them for the mapping to the fs uid.  The
current newidmap/newgidmap are somewhat nasty but at least they're
controlled.

I did try a prototype where all we cared about was the root<->root
mapping, but a unix system has other uids that are privileged as well,
so it didn't solve the security problem.

> And it wouldn't have to be administrator assigned. Some administrator
> assignment might be required for the username <-> 16 bit uid mapping,
> but if those mappings are ephemeral (i.e. if we get filesystems
> persistently storing usernames, which is easy enough with xattrs)
> then that just becomes "reserve x range of the 16 bit uid space for
> ephemeral translations".

*if* the user names you're dealing with are all unprivileged.  When we
have a mix of privileged and unprivileged users owning the files, the
problems begin.

James


