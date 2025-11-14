Return-Path: <linux-fsdevel+bounces-68473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EAC5CEF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA64EEB4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAA314D18;
	Fri, 14 Nov 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnL1wgvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC2314B62;
	Fri, 14 Nov 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120667; cv=none; b=C/gOeWZs+TOe+3sUurSzzRhlH8OZflXdVeB2a2/GdFQ736kKnzgB/XcrFUki3leVg/AF2PO33dpHhX817y8cMq+NBCEsDXlQiB1sDlsBGYWuwRmDnd9Ra2N2QxEs2lpEOW9X2F9m0BXOQ4XDlAYUgqP4xr3S0StEmkpWwh67Nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120667; c=relaxed/simple;
	bh=MSRYIsArI+iaYB41qEQdt9KxZ4hiwpUJOx5IuVhajJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfvMU8TiXbpkKJtOtvOcAskKP1vu/OjFL/ngStEzvZljCZrbGdFtK5B4xNK6wmShkBQi5266TG36oNzbpcot5f5SA7zafwbiqnx6kLLnXyblsF98htlzZe/+4Toi4QANPNO7HPJMqLzAB37oQb1VrS41oaJ2uqoF/Bg70oa0KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnL1wgvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D7C116D0;
	Fri, 14 Nov 2025 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763120667;
	bh=MSRYIsArI+iaYB41qEQdt9KxZ4hiwpUJOx5IuVhajJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnL1wgvs62GgB1z7bJb3UQJmKrjEyyGXBvt1UJBgL+/sZiocDK9bGUdXUh0SWaZwZ
	 F1ax5ROJ38iwdXX0GpdkehFfI1AwQp5DugutCOTzS7O8DhThiNyHFIWmDWO8FduZjW
	 GZTzxYb2MqlijVgevzE7c+gUwHY1fiXUSZl4buS4uP7jSaNu2prTwNx6v4am8NXQh6
	 5Bn3HYRSZ34fqIo+JtsuNbEPdTVay24LGb6pnmNMGrlP8m9o2qB3qIyFnzvGiFkhgN
	 JikCn173Le2EGhqcFDZXekwAxspDqOUxR6KXcu/n4rpMh2g85H4kbtg4c9asC/LF5W
	 GBncXD/SiI1BA==
Date: Fri, 14 Nov 2025 12:44:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251114-rechnen-variieren-aaeb36bb57a0@brauner>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
 <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
 <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>
 <20251112-kleckern-gebinde-d8dbe0d50e03@brauner>
 <0dfa7fc6-3a15-4adc-ad1d-81bb43f62919@themaw.net>
 <20251113-gechartert-klargemacht-542a0630c88b@brauner>
 <7e040a12-3070-4fad-8b1a-985e71426d41@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e040a12-3070-4fad-8b1a-985e71426d41@themaw.net>

On Fri, Nov 14, 2025 at 07:49:53AM +0800, Ian Kent wrote:
> On 13/11/25 21:19, Christian Brauner wrote:
> > On Thu, Nov 13, 2025 at 08:14:36AM +0800, Ian Kent wrote:
> > > On 12/11/25 19:01, Christian Brauner wrote:
> > > > On Tue, Nov 11, 2025 at 08:27:42PM +0800, Ian Kent wrote:
> > > > > On 11/11/25 18:55, Christian Brauner wrote:
> > > > > > On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
> > > > > > > On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
> > > > > > > 
> > > > > > > > > +	sbi->owner = current->nsproxy->mnt_ns;
> > > > > > > > ns_ref_get()
> > > > > > > > Can be called directly on the mount namespace.
> > > > > > > ... and would leak all mounts in the mount tree, unless I'm missing
> > > > > > > something subtle.
> > > > > > Right, I thought you actually wanted to pin it.
> > > > > > Anyway, you could take a passive reference but I think that's nonsense
> > > > > > as well. The following should do it:
> > > > > Right, I'll need to think about this for a little while, I did think
> > > > > 
> > > > > of using an id for the comparison but I diverged down the wrong path so
> > > > > 
> > > > > this is a very welcome suggestion. There's still the handling of where
> > > > > 
> > > > > the daemon goes away (crash or SIGKILL, yes people deliberately do this
> > > > > 
> > > > > at times, think simulated disaster recovery) which I've missed in this
> > > > Can you describe the problem in more detail and I'm happy to help you
> > > > out here. I don't yet understand what the issue is.
> > > I thought the patch description was ok but I'll certainly try.
> > I'm sorry, we're talking past each other: I was interested in your
> > SIGKILL problem when the daemon crashes. You seemed to say that you
> > needed additional changes for that case. So I'm trying to understand
> > what the fundamental additional problem is with a crashing daemon that
> > would require additional changes here.
> 
> Right, sorry.
> 
> It's pretty straight forward.
> 
> 
> If the daemon is shutdown (or killed summarily) and there are busy
> 
> mounts left mounted then when started again they are "re-connected to"
> 
> by the newly running daemon. So there's a need to update the mnt_ns_id in
> 
> the ioctl that is used to set the new pipefd.
> 
> 
> I can't provide a patch fragment because I didn't realise the id in
> ns_common

Before that you can grab it from the mount namespace directly from the
mntns->seq field.

