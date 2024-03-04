Return-Path: <linux-fsdevel+bounces-13419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78FF86F860
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 03:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABAE28125C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD1815A4;
	Mon,  4 Mar 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cUcPAWph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF3A31
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517947; cv=none; b=OgPx4QvxVA37mqSYtffGLCY2Xt6oZmQUooUJgsppLVrOCfOgdoIHr4Kw3ILzuzlCc353Ei/LXkNZKkASKplBZ3K/U6NYj+h8+oE4fgRc/cCJe0Aau9VyxBK0BH6sij42cjdXaJznbmWGSeJz+1WVl/WKQQ1n/wF6KBT0flzb3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517947; c=relaxed/simple;
	bh=QDEiyj1Gw7lJuMO5DcTNxMBdImFaxzH7eHO+CzuYE8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPNypWtzCEga+VfRD4nB6IOtynrilHmNhi4oSHiG2/hoVu8E46EDhPYhYIQ7AJ0GGBV8T0md1AL8O84kTojKspjd23atVh982Tw8v3UIQ/Y3ZiSnnHmQAosKse/6bTlwOxhrzIUDMHNhLcK56Be6GO/lyowiglcJegRuZJA9WjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cUcPAWph; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 3 Mar 2024 21:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709517942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vph5zV8BojZG/Eey/x8beKInPqbVGdlUS9KjbKDpABk=;
	b=cUcPAWphB5N53yW7UErEl3bPxraTqPezC66q2j9xRvH2HQKk4Vjx0txjJuH8h/GN9JIt4K
	rmcc8s2fJGLeGpeo5FbhLh76WLgpA6aypWChe9NKjllEkzFArS3hfhXnH31WTV90jm5HQ7
	fLsNzMOhZ2+Ibi6UT7EFbigTS2MXjTk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>, 
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <muyyaqiewmvv3dzxzyaxl4lvtsgsn7552rpyqechxbn6qfaaj7@53gm6einncwx>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <ZeUXORziOwkuB-tP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeUXORziOwkuB-tP@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 04, 2024 at 12:35:05AM +0000, Matthew Wilcox wrote:
> On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > I have in mind a more explicit statement of how much waiting is
> > acceptable.
> > 
> > GFP_NOFAIL - wait indefinitely
> > GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> > GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
> >             don't wait indefinitely.  May abort more quickly if fatal
> >             signal is pending.
> > GFP_NO_RETRY - only try things once.  This may sleep, but will give up
> >             fairly quickly.  Either deadlock is a significant
> >             possibility, or alternate strategy is fairly cheap.
> > GFP_ATOMIC - don't sleep - same as current.
> 
> I don't think these should be GFP flags.  Rather, these should be
> context flags (and indeed, they're mutually exclusive, so this is a
> small integer to represent where we are on the spectrum).  That is
> we want code to do

Why?

Context flags are for /context/, i.e. the scope where you take a lock
that's GFP_FS unsafe. These really are callsite specific - "how bad is
it if we have to deal with an allocation failure here?"

