Return-Path: <linux-fsdevel+bounces-36967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD049EB76D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055F7281F4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E78232799;
	Tue, 10 Dec 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/KhdJXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B21BC09F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850526; cv=none; b=lMPanzrk/OccmJSbYW1AWe4WbBViPDKus9ub4Iub6rEfG4s8DfGedH2rVZVJWFnUQVWz0dEzaCW0kQAbo0p3RDqquRM6M7XYqTV4AvbQpysWj+qF7pCvhpltktDEdLWYxUlUFjotRfB2yj3mFblbUkxmFpVmNCc+cQSzole+vAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850526; c=relaxed/simple;
	bh=GkXoH6dQEH1NUJbqea5/m8yiK2EoozGl7h63oxGlDso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB/E1aFo8ydOXNh36w0EnEMXfp4gKEW7+FZJL5vzJ9CySAz6Ogkz3KaHm/Z6a/mUZMzpA29+et9EQF2CBCXLAiTN3S14sNaZLO+UgLGBFcnRhBq5bVVstpygbRkcwhg4DkLNqR3pTpbnzJnNPgNZu1GRLymZZkjukJji5URFm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/KhdJXZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lUNeDrIkZ16ia/d1l9+iha77f//BYe+L839p9KggZFk=; b=U/KhdJXZiujhTpWJqUtNDGT7y3
	MrU+ljMjZHGq2TRCICLyIDgFrQQpYqpH02vureTphvvrYdU95h6FunIBzNNqcyaPIcq8QAEj6NJOO
	K4sMxXepUpbx60xoImP+NszWP/A9wYDHfyCKjbmnjiYYHhY+gnSqlgqugPTgV8DnnuNbJePDrN/yT
	SzPvpSbuRJ35YtXYEwvaaxDiCDNPDQCsCrL4xhHDWq/6nZ7o3v759edMUZPWjFnKliVi6DT6V9qKP
	EZ1nFvT1H9gB9cQwMC4bwsGwGeWs5wTvSGnV3RgrSamAIGsD04QR8jNqLh9gZ2UUb0RanttE77dNm
	063VTcjA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tL3iy-0000000AYCT-34Up;
	Tue, 10 Dec 2024 17:08:40 +0000
Date: Tue, 10 Dec 2024 17:08:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <Z1h1mAIZlvbQIVNB@casper.infradead.org>
References: <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
 <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
 <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
 <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
 <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>

On Tue, Dec 10, 2024 at 11:54:18AM -0500, Kent Overstreet wrote:
> I get the impression you might be flailing a bit, it seems you're not
> exactly sure what's going on, and either Willy or Josef previously
> alluded to a lack of assertions - so I'm going to echo that.

This comes across very patronising.  You don't know Joanne and I
suggest you refrain from making assumptions.

> Haven't looked at the relevant patches yet, but if you'd like me to look
> and offer suggestions I'd be happy to.

You should probably read more carefully and think a little harder about
what you're writing.  I made some suggestions about what could be done
to narrow down the bug to a specific path; Josef looked at the patch and
found something that looked wrong.  I confirmed it looked wrong.  Josef
sent a patch; Joanne fixed a problem with that patch.

This does not entitle you to say that Joanne is flailing.

