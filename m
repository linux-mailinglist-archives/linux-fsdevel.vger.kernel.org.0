Return-Path: <linux-fsdevel+bounces-40056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F29A1BC0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2100516C83D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523121A450;
	Fri, 24 Jan 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Zymyuc7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5819A288
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743330; cv=none; b=SpfkvZ8yQsRXOZIE5WAqW2c3XvbqBon5fKbpzhyW53cx+5X4lksbqLWu60YdKwUzWiH5O36cUQCvqWhkJKbt6o7HzLpsVbaislXYvR467Eayefl1HfR8WlMF7U6tfxCi14S46FMhePJ3MmWpOkb7u51fXvhIIUnwMcxTRwu38Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743330; c=relaxed/simple;
	bh=NegJ/1TfbX7aVBPZSTyEMEIXIZQTbhOsVpc6eRBlXFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl2zHZ81WFxl+AQ29F9B8+kY9gw9dxM9ycdESAmpGtgUeP0VmsE2Udo3PR3wWnGcUtPnaST6PzAWOZACDKpRw0ViWcyKJjbp1s+x0N4a4Y8jJ4e9iXSd71LevF4681JrGg0+gpt8dVE+lkR3rKa4+vLGPk8qrYJNGxKV10pGj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Zymyuc7l; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-161.bstnma.fios.verizon.net [173.48.111.161])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50OISITs003428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 13:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737743301; bh=PsSWnbdwaUY7PiWMxWMnA/Fu4dFrB4Pm66ETkG4yzns=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Zymyuc7lVrdA4ETQ4f9rlS/KsX8V81+Zxo2Hle0IA54csUVqzLeYQDZKmcN3ag3WG
	 SLOl895ehBWl8EWOHNlBygalhZrZMlBVHDQuK2rFiGi0yvDIPvpOmPWtS4SVYT+9Vm
	 LYft1AOCUJ4rVTsiFq+53wkWvzP992Zm3gfM0WEEcdGRLxGI0e197JisETLuH+kJea
	 yTC9QTIDuk4kLCYkcIsrCATxxqMnjQ3F0ZPcB2Dm18baedBrVPOkBhw/Rxjfg0TQ+n
	 b/0Qlr5+hyNSTuXEnWzjIaF45eM1dpHiQojIgkK0x5nXtHGEJf0WOkbHS9TvcVcC+O
	 RScCgMsD0caTw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DF4C815C0109; Fri, 24 Jan 2025 13:28:17 -0500 (EST)
Date: Fri, 24 Jan 2025 13:28:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250124182817.GB3847740@mit.edu>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
 <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
 <5BCDEDB6-7A92-4401-A0A8-A12EF2F27ED0@m.fudan.edu.cn>
 <tkfjnls4rms7r7ajdwj3n4yxyexufrdunhgvzalegz6j35zbxm@fexthq26w7lr>
 <900A37C1-9A21-46DF-8416-B8ABF1D0667C@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900A37C1-9A21-46DF-8416-B8ABF1D0667C@m.fudan.edu.cn>

On Fri, Jan 24, 2025 at 08:22:57PM +0800, Kun Hu wrote:
> 
> But an interesting interaction relationship is that for researchers
> from academia to prove the advanced technology of their fuzzer, they
> seem to need to use their personal finding of real-world bugs as an
> important experimental metric. I think that's why you get reports
> that are modeled after syzbot (the official description of syzkaller
> describes the process for independent reports). If the quality of
> the individual reports is low, it does affect the judgment of the
> maintainer, but also it is also a waste of everyone's time.

If you're going to do this, I would suggest that you make sure that
you're actually finding new bugs.  More often than not, after wasting
a huge amount of time of upstream developers because the researchers
don't set up the syzbot dashboard and e-mail service to test to see if
a patch fixes a bug (often which we can't reproduce on our own because
it's highly environment sensitive), we discover that it's already been
reported on the upstream syzbot.

Which makes the academic syzbot a *double* waste of time, and this
trains upstream developers to simply ignore reports from these
research forks of syzbot unless it comes with a reproducer, or maybe
(this hasn't happened yet) if the researchers actually set up the web
dashboard and e-mail responder.

I also blame the peer reviewers for the journals, for not asking the
question, "why haven't you shown that the 'real world' bugs that your
forked syzbot has found are ones that the original syzcaller hasn't
found yet?"  And for not demanding of the academics, "if you want
*real* impact, get your changes merged upstream with the upstream
syzcaller, so that it will continue to find and fix vulnerabilities
instead of ceasing the moment we accept your paper."

Cheers,

						- Ted

