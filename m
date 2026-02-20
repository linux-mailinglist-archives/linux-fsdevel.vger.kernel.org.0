Return-Path: <linux-fsdevel+bounces-77835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BCvElT1mGkaOgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:59:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D416B77C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73F7303A100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF131062C;
	Fri, 20 Feb 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HACYJnpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE3303A01
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631951; cv=none; b=Upi6XnKuaEdF1tzr/VS6onFSwBGF/6RSJXOg5VtBK9i8Wcuph03fmXf7ZVWPkXKHbS6eMZeSi+QyyzTMGPjvvjenisaHte2J9GiDK1PcHhxgJyyUx97aULnGCjaSoJl8tIT0sUUogNEIt/Cc0AQIM11vLXfZauWVrhC5Cr0tdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631951; c=relaxed/simple;
	bh=DQG+oGVv9nsBvAHuQ0UfRamnc3dmE27H+yyOYO1JUbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4BqaXK1UQMI/g9enXjurlmeX/Al3m9G5AAE7T3tptpVyTE9YdrEDEuc5pJLgFQTgLX79F3yjUbdy/NBNnSlkTkIZgQSTQyNXhcT27vq5kTTwCMzWAwDTZ/Y/4I00asS12eWD8hVEYA/2idHawNc3WHpc8YbQ8Dbikp9NnTi0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HACYJnpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63E1C116C6;
	Fri, 20 Feb 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631950;
	bh=DQG+oGVv9nsBvAHuQ0UfRamnc3dmE27H+yyOYO1JUbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HACYJnpWqlSR2HF27ILfBSDBIXqWo61HwM0zL/Fi6/tdZY5pxvE0Orrw7xfvzR3g1
	 SS3z7FMwdsqJOABdzPVNV+p8OWAikyOCskGltQyjpuH3BOkRXYCQPTjwBHAGEzmX9+
	 wXZcwqmy4V3n2YRKeH1c+UZNQ0cEoWm6+2OXp1oOmPVOLcByHRd+0LEfMRkccv4Iok
	 tKsvwxQTZy/qPZuCTTE+dbbl9clO6XmVAxw7acwi3eHTZxbvu1Ttk3S+wYL/SXEzeX
	 hRohOW4fu1qRHcMcbNaSOLTVMrsFUkAk7f2U5/4/zZyDNAWkwOKAtwhAc3nZY2SJBM
	 GHgwo1WvaBm7Q==
Date: Fri, 20 Feb 2026 15:59:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <john@groves.net>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	"f-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260220235910.GA11076@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <aYQNcagFg6-Yz1Fw@groves.net>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
 <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
 <20260206055247.GF7693@frogsfrogsfrogs>
 <aYZOVWXGxagpCYw5@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYZOVWXGxagpCYw5@groves.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,bsbernd.com,igalia.com,birthelmer.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77835-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jagalactic.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A64D416B77C
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 02:48:43PM -0600, John Groves wrote:
> On 26/02/05 09:52PM, Darrick J. Wong wrote:
> > On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> > > On Thu, Feb 5, 2026 at 4:33 AM John Groves <john@jagalactic.com> wrote:
> > > >
> > > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > > >
> > > > [ ... ]
> > > >
> > > > > >  - famfs: export distributed memory
> > > > >
> > > > > This has been, uh, hanging out for an extraordinarily long time.
> > > >
> > > > Um, *yeah*. Although a significant part of that time was on me, because
> > > > getting it ported into fuse was kinda hard, my users and I are hoping we
> > > > can get this upstreamed fairly soon now. I'm hoping that after the 6.19
> > > > merge window dust settles we can negotiate any needed changes etc. and
> > > > shoot for the 7.0 merge window.
> > 
> > I think we've all missed getting merged for 7.0 since 6.19 will be
> > released in 3 days. :/
> > 
> > (Granted most of the maintainers I know are /much/ less conservative
> > than I was about the schedule)
> 
> Doh - right you are...
> 
> > 
> > > I think that the work on famfs is setting an example, and I very much
> > > hope it will be a good example, of how improving existing infrastructure
> > > (FUSE) is a better contribution than adding another fs to the pile.
> > 
> > Yeah.  Joanne and I spent a couple of days this week coprogramming a
> > prototype of a way for famfs to create BPF programs to handle
> > INTERLEAVED_EXTENT files.  We might be ready to show that off in a
> > couple of weeks, and that might be a way to clear up the
> > GET_FMAP/IOMAP_BEGIN logjam at last.
> 
> I'd love to learn more about this; happy to do a call if that's a
> good way to get me briefed.
> 
> I [generally but not specifically] understand how this could avoid
> GET_FMAP, but not GET_DAXDEV. 

fuse-iomap requires fuse servers to open block devices and register them
with the fuse_conn as a backing file.  The kernel returns a magic cookie
that can then be passed back to the kernel in iomap_begin.  This is
(AFAICT) similar to what fuse does w.r.t. passthrough files.

IIRC, GET_DAXDEV is an ondemand fuse request, which is quite different
from the fuse-iomap model where bdevs have to be registered before you
can use them.

> But I'm not sure it could (or should) avoid dax_iomap_rw() and
> dax_iomap_fault(). The thing is that those call my begin() function
> to resolve an offset in a file to an offset on a daxdev, and then
> dax completes the fault or memcpy. In that dance, famfs never knows
> the kernel address of the memory at all (also true of xfs in fs-dax
> mode, unless that's changed fairly recently). I think that's a pretty
> decent interface all in all.

Right.  dax_iomap_{rw,fault} call the ->iomap_begin they're given, which
can be fuse_iomap_begin, which will either (a) look in the iext cache,
(b) see if the fuse server supplied a bpf program, or (c) upcall the
fuse server.

I also took another look at my broken fuse-iomap-dax patch and realized
that in addition to corrupting data somewhere, there's also a gigantic
XXX around dax_writeback_mapping_range because it takes a bdev instead
of asking the filesystem for mappings, which means that it's broken for
any fsdax file who stores data on more than one device.

> Also: dunno whether y'all have looked at the dax patches in the famfs
> series, but the solution to working with Alistair's folio-ification 
> and cleanup of the dax layer (which set me back months) was to create 
> drivers/dax/fsdev.c, which, when bound to a daxdev in place of 
> drivers/dax/device.c, configures folios & pages compatibly with 
> fs-dax. So I kinda think I need the dax_iomap* interface.

Oh that's good news!

--D

> As usual, if I'm overlooking something let me know...
> 
> Regards,
> John
> 
> 

