Return-Path: <linux-fsdevel+bounces-13406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B55986F77F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 23:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA55B20C13
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 22:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D322B7AE4F;
	Sun,  3 Mar 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="flirE8/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5156CDB6
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709506467; cv=none; b=HsqQuS0na0/L4t0WLZVfpSLb1wuE8xx43B6QVTKXO4ERy0jSUmKhQWFd2OTrZxt+/aCCumPt9yD3xEM+ZlP+AuirqEwuklfKv+dp1Wte1y5lgFVUJowpKkxaAj8/i+PmOmTvrSSUZxQuIHAN8fbTK+HE88fOBfwPLMEEEFDl854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709506467; c=relaxed/simple;
	bh=IiWBHUMHdcj9ACM4tDoMpAFEKpInEnTwz15sgcBimzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N562+KEXZY5WqCybaSEzZCXU77TtT2Q0amg0FPAMK7c4Toy2NJY3ZSnHqm4Chg6eByoJmHcZATTbiXz+R1D8tQJFwtx2v6Y4QOuzLQdmhuNunU944JZl0rPLXr/0AMgyjQyp2YgUwJe7dhBFrMfuNl3oJF6WdlyHdUE4BY8PAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=flirE8/8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 3 Mar 2024 17:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709506462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tBtO++uCH/Gk7Nt1NmLc0KgAdMtxlsr8/WSB+ik87hg=;
	b=flirE8/8ycsMSeDWZs3JrSx1+rFXSr/TsOtDszGEJZTXZuBj7BjBYBie20SQab7M5bxpR+
	rmQye+LKENym+ZbSwRAVnxNhniL2PgN7cNKrGfMWi9pYdy91cl2G5uAVGOPXJ1J6kJR6Z/
	oOQnqXP4cwmX5UFS8IxPL2JbpsGEAGg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, 
	Matthew Wilcox <willy@infradead.org>, Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <aownm3xt34rju5tvhsrkbcurls2vlyzueamreiqd3uuompyioj@x3wkk7w6iroy>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170950594802.24797.17587526251920021411@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> I have in mind a more explicit statement of how much waiting is
> acceptable.
> 
> GFP_NOFAIL - wait indefinitely
> GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
>             don't wait indefinitely.  May abort more quickly if fatal
>             signal is pending.
> GFP_NO_RETRY - only try things once.  This may sleep, but will give up
>             fairly quickly.  Either deadlock is a significant
>             possibility, or alternate strategy is fairly cheap.
> GFP_ATOMIC - don't sleep - same as current.
> 
> I don't see how "GFP_KERNEL" fits into that spectrum.  The definition of
> "this will try really hard, but might fail and we can't really tell you
> what circumstances it might fail in" isn't fun to work with.

Well, lots of things "aren't fun to work with", but error handling is
just a part of life.

Your "GFP_KILLABLE" has the exact same problem of "this thing will be
rarely hit and difficult to test" - if anything moreso.

We just need to make sure error paths are getting tested - we need more
practical fault injection, that's all.

