Return-Path: <linux-fsdevel+bounces-13245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A9B86DA87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1291F23CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E594481A3;
	Fri,  1 Mar 2024 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h0IsG7bp";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h0IsG7bp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8F383A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266145; cv=none; b=EPyOvt4exGFKHhhq8B0smFsz/S/zkPkJ6wUPNs6QFottzFWX+yGThC9NLJWRO4ytNKZfVSzORYjBwJZpCxd+nwrugiiOIU8gc0zUgcCt9dV7B5frnHKJb/23QI1mlk9j73m1q/hfiRx1SUEo38HbW5Hrl2apC01lyemlMPKXawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266145; c=relaxed/simple;
	bh=UiSIGEjDf8fPdoAXZQGSYA5JYBxVYFogxKj1XMWMGII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BoHt2DlURt1awA0YyMRJI8+CNoU8tnorOeMuCAtYiQfwvNLXQzM7EFZtO/wUG7/y/GrPwFlwVwesm164qr8T5ydDKyfeNt/tGE434juEAD8aP0JKgyEgUXligqM6+NWtI78rDw8rOrmz/QXvVKrhTw5ZOxmeHjFAmhpL1lisxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=h0IsG7bp; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=h0IsG7bp; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709266141;
	bh=UiSIGEjDf8fPdoAXZQGSYA5JYBxVYFogxKj1XMWMGII=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=h0IsG7bpKboxbU53X+KAZcj8gRlhvLRld4JdOzErIEK+RMGP8zjd+6wlsuln+A8ce
	 n8BThgfC30J4MFU+24u2Li9FE+xUXy4zbAUZ3EpleZCdyVzCauJj2rJ+2m9T2mH1BM
	 tKFOVU/SFABP418wBISpILo1Is7sMcviSqQ+MQ8c=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CCCD71281179;
	Thu, 29 Feb 2024 23:09:01 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id OgkuCyA5PUbV; Thu, 29 Feb 2024 23:09:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709266141;
	bh=UiSIGEjDf8fPdoAXZQGSYA5JYBxVYFogxKj1XMWMGII=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=h0IsG7bpKboxbU53X+KAZcj8gRlhvLRld4JdOzErIEK+RMGP8zjd+6wlsuln+A8ce
	 n8BThgfC30J4MFU+24u2Li9FE+xUXy4zbAUZ3EpleZCdyVzCauJj2rJ+2m9T2mH1BM
	 tKFOVU/SFABP418wBISpILo1Is7sMcviSqQ+MQ8c=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 51566128608B;
	Thu, 29 Feb 2024 23:08:58 -0500 (EST)
Message-ID: <7ffaa92d86fff2e16aed99edd3c4a423f06fe033.camel@HansenPartnership.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>, Amir
 Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org,  linux-mm@kvack.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Date: Fri, 01 Mar 2024 11:08:52 +0700
In-Reply-To: <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
	 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
	 <Zd-LljY351NCrrCP@casper.infradead.org>
	 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
	 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
	 <ZeFCFGc8Gncpstd8@casper.infradead.org>
	 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
	 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
	 <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-02-29 at 22:52 -0500, Kent Overstreet wrote:
> On Fri, Mar 01, 2024 at 10:33:59AM +0700, James Bottomley wrote:
> > On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
> > > Or maybe you just want the syscall to return an error instead of
> > > blocking for an unbounded amount of time if userspace asks for
> > > something silly.
> > 
> > Warn on allocation above a certain size without MAY_FAIL would seem
> > to cover all those cases.  If there is a case for requiring instant
> > allocation, you always have GFP_ATOMIC, and, I suppose, we could
> > even do a bounded reclaim allocation where it tries for a certain
> > time then fails.
> 
> Then you're baking in this weird constant into all your algorithms
> that doesn't scale as machine memory sizes and working set sizes
> increase.
> 
> > > Honestly, relying on the OOM killer and saying that because that
> > > now we don't have to write and test your error paths is a lazy
> > > cop out.
> > 
> > OOM Killer is the most extreme outcome.  Usually reclaim (hugely
> > simplified) dumps clean cache first and tries the shrinkers then
> > tries to write out dirty cache.  Only after that hasn't found
> > anything after a few iterations will the oom killer get activated
> 
> All your caches dumped and the machine grinds to a halt and then a
> random process gets killed instead of simply _failing the
> allocation_.

Ignoring the fact free invective below, I think what you're asking for
is strict overcommit.  There's a tunable for that:

https://www.kernel.org/doc/Documentation/vm/overcommit-accounting

However, see the Gotchas section for why we can't turn it on globally,
but it is available to you if you know what you're doing.

James


