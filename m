Return-Path: <linux-fsdevel+bounces-27015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DF95DACB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 05:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC05A2842F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 03:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206E26AE4;
	Sat, 24 Aug 2024 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F8XDiF/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC418641
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469054; cv=none; b=M7ndpLs2P+j6f2mZPBh4m/brYYT8dYsOZzKV7rZFIALiqd7PVUctLm4giDw+lXQfPjzgoDl4MR/jyzL56ALcdKiVy6F/uSI+oFKe4m+fKqtEUuY6a8rBk3DNMqnGOumZ7fk6ThEo5R2A+HighwmeRZCnvhHsNGR7HSyCn66kYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469054; c=relaxed/simple;
	bh=g4X3Hb4vfdtWyWtPp5CWavlSwSPr8PtlG5+nqb5GJCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLcEOHlGa8nnKj6cFYE0SB+gKh/AC5tz6TVsXI2b8tDiv68+ec0iW+6cC4da6KdZyeT/Fpkgi86tjXjH4x2uwRD73uopjDM7S6Dup/8ZELhwUQKhkXGS49tFaEOI5I6bpNIfrtvLcM3cp2Bi9WbHY66H1kpsqs1qap7O3upzquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F8XDiF/6; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Aug 2024 23:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724469050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qsKf7xaMGjFVrdl2D6G/nv0LFUdX9aXChE7927Dm9XM=;
	b=F8XDiF/6rgSvMsBJrp4dU/GBW4H1GLfCvn2LwUPjD/2IdYjh0H2XGDfhnqbJmYzFtrChDx
	Zkev2OpCEBqHoe97IbFlIQ5eov034nFIBEB50vgspShPm4gAQFnVule/6rs3nBUUWaBmea
	MjhPntMGkKbnn7/Yu1cpUlgagK1o1Rw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
Message-ID: <bczhy3gwlps24w3jwhpztzuvno7uk7vjjk5ouponvar5qzs3ye@5fckvo2xa5cz>
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
 <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
 <wdxl2l4h2k3ady73fb4wiyzhmfoszeelmr2vs5h36xz3nl665s@n4qzgzsdekrg>
 <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 24, 2024 at 10:57:55AM GMT, Linus Torvalds wrote:
> On Sat, 24 Aug 2024 at 10:48, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Sure, which is why I'm not sending you anything here that isn't a fix
> > for a real issue.
> 
> Kent, bugs happen.

I _know_.

Look, filesystem development is as high stakes as it gets. Normal kernel
development, you fuck up - you crash the machine, you lose some work,
you reboot, people are annoyed but generally it's ok.

In filesystem land, you can corrupt data and not find out about it until
weeks later, or _worse_. I've got stories to give people literal
nightmares. Hell, that stuff has fueled my own nightmares for years. You
know how much grey my beard has now?

Which is why I have spent many years of my life building a codebase and
development process where I can work productively where I can not just
catch but recover from pretty much any fuckup imaginable.

Because peace of mind is priceless...

