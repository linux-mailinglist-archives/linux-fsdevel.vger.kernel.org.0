Return-Path: <linux-fsdevel+bounces-13247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75286DA95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3562F2872A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD82482C1;
	Fri,  1 Mar 2024 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nl9awbJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAC2AEEE
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266522; cv=none; b=EyIWcofu8ZJWhmPbl1hNYqaEbH9rq1lRr1CXDnQDAVt8r27fHx0iNFNuTyTPuuvmk4NfSUjjE4qlDB1n3UiQGxbfh8FL3j1EFqFEmbO7v4ohfkC2w56KmBAMxm5XturiBQdMFMRM6rL1sCqcDNv6SQqSGYZ3Mo6ORqGOoJK0qGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266522; c=relaxed/simple;
	bh=/Ptoe5g3HVG/EDYBspB63e1eM9B3TkTEFEQR4UAc+xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0IYtEiQceJNRWsORJ2WXZaRlz6OdjzIxzItGxtCsVKqIwRNQ/P1Ng94LWzmFAq+9+tyBT2BZ4TzPVjnYYSrqkfDq0afejNeSbrxyfa6mP5oKJKxMc5Ik98ECiEH3yTTusPuXgfCO2sl8FWTB35ygxS1nxBiz6MrlvSW0CQa80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nl9awbJN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 23:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709266517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuNCdL8h1oXsBd5EnDZ2OKOaYnUwm+9LyZcDVju6zDo=;
	b=Nl9awbJN3IdA66xNvskeb+FrlFbpVSK9oHxvsThqoqJyh8eCE5QSMbUtpgeZmPQNSONWXl
	6wkcOG2UuXT+6kLrhjTgp4WTaiyIaOWZFtcYsx9fu9slbsfCV1WnGyyjzbz0mnCdotDNCT
	tKqKUezXvHx4Py8VMymft48a1npc0L0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <akj7kckcup4iadleh4c6qsapqrcpolggiggitsmbsprqyy5qyn@iw7t2hveah6g>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
 <ZeFCFGc8Gncpstd8@casper.infradead.org>
 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
 <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
 <7ffaa92d86fff2e16aed99edd3c4a423f06fe033.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ffaa92d86fff2e16aed99edd3c4a423f06fe033.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 11:08:52AM +0700, James Bottomley wrote:
> On Thu, 2024-02-29 at 22:52 -0500, Kent Overstreet wrote:
> > On Fri, Mar 01, 2024 at 10:33:59AM +0700, James Bottomley wrote:
> > > On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
> > > > Or maybe you just want the syscall to return an error instead of
> > > > blocking for an unbounded amount of time if userspace asks for
> > > > something silly.
> > > 
> > > Warn on allocation above a certain size without MAY_FAIL would seem
> > > to cover all those cases.  If there is a case for requiring instant
> > > allocation, you always have GFP_ATOMIC, and, I suppose, we could
> > > even do a bounded reclaim allocation where it tries for a certain
> > > time then fails.
> > 
> > Then you're baking in this weird constant into all your algorithms
> > that doesn't scale as machine memory sizes and working set sizes
> > increase.
> > 
> > > > Honestly, relying on the OOM killer and saying that because that
> > > > now we don't have to write and test your error paths is a lazy
> > > > cop out.
> > > 
> > > OOM Killer is the most extreme outcome.  Usually reclaim (hugely
> > > simplified) dumps clean cache first and tries the shrinkers then
> > > tries to write out dirty cache.  Only after that hasn't found
> > > anything after a few iterations will the oom killer get activated
> > 
> > All your caches dumped and the machine grinds to a halt and then a
> > random process gets killed instead of simply _failing the
> > allocation_.
> 
> Ignoring the fact free invective below, I think what you're asking for
> is strict overcommit.  There's a tunable for that:
> 
> https://www.kernel.org/doc/Documentation/vm/overcommit-accounting
> 
> However, see the Gotchas section for why we can't turn it on globally,
> but it is available to you if you know what you're doing.

James, I already explained all this.

