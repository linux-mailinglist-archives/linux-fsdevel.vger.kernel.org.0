Return-Path: <linux-fsdevel+bounces-40057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A5A1BC3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CD73A6860
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE721A449;
	Fri, 24 Jan 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DlUAhiIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1203158DC6;
	Fri, 24 Jan 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743971; cv=none; b=TQe326u7kXb68IkpWacr8R3VbV9Pv/Lpgkssi7StUbt093SPlnQLXGqagt35pRjPZf0sj8m4gPBc9YDrZC94xUmG+qMm3jjGEmZOvRnjBRviNnHsLzUC2IXWgr/5uQZlEgG2nT9MOYdiuqbcoD6oxmO8E8p5PRXYIKKCs9/Vf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743971; c=relaxed/simple;
	bh=GqgGVR8a0mXRBVct86xKSU+bzk3BzGDdNvwKOsWmpfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHVeTJW8phbR6+BiE0odrd0VdOclB57OExdjilPiZpTitDRt15pVntrfHl+BSN7dyU/xnqZDmPdhzSw8njbIxJrywoS5R85rCKJg7uvL32W5/cbyNqZdXCjVaZHmMDcSYvaf9CmOe+fqtRrxwz9usSd/ceSh/jYRCEj9LXnoVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DlUAhiIt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Jan 2025 13:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737743951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4qiyxXwsKkWmTbyla8Gs9JOdR4hjK7/GP+7E99kTH68=;
	b=DlUAhiItTMmxCMxvWsIz2Ig001wvGduIbYnYClp2X0PbIP6t77ljv3GluAv+waTgzE+0dc
	d7qE6UiEsu7Bo2k8/0sS/fxdlpcNFGNJsbF+3ZiCjFhrRatsWWDttsl5PN3UYGZDnOLnph
	CAHZlQMfpxWLSs5OmbzFjFJqEvlWH3E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Kun Hu <huk23@m.fudan.edu.cn>, Dmitry Vyukov <dvyukov@google.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <xoeh3kmemjv5vdqfxxq3xrwtuckm5lru2wecwohwevras3ancr@fhbghayd42ox>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
 <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
 <5BCDEDB6-7A92-4401-A0A8-A12EF2F27ED0@m.fudan.edu.cn>
 <tkfjnls4rms7r7ajdwj3n4yxyexufrdunhgvzalegz6j35zbxm@fexthq26w7lr>
 <900A37C1-9A21-46DF-8416-B8ABF1D0667C@m.fudan.edu.cn>
 <20250124182817.GB3847740@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124182817.GB3847740@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 01:28:17PM -0500, Theodore Ts'o wrote:
> On Fri, Jan 24, 2025 at 08:22:57PM +0800, Kun Hu wrote:
> > 
> > But an interesting interaction relationship is that for researchers
> > from academia to prove the advanced technology of their fuzzer, they
> > seem to need to use their personal finding of real-world bugs as an
> > important experimental metric. I think that's why you get reports
> > that are modeled after syzbot (the official description of syzkaller
> > describes the process for independent reports). If the quality of
> > the individual reports is low, it does affect the judgment of the
> > maintainer, but also it is also a waste of everyone's time.
> 
> If you're going to do this, I would suggest that you make sure that
> you're actually finding new bugs.  More often than not, after wasting
> a huge amount of time of upstream developers because the researchers
> don't set up the syzbot dashboard and e-mail service to test to see if
> a patch fixes a bug (often which we can't reproduce on our own because
> it's highly environment sensitive), we discover that it's already been
> reported on the upstream syzbot.
> 
> Which makes the academic syzbot a *double* waste of time, and this
> trains upstream developers to simply ignore reports from these
> research forks of syzbot unless it comes with a reproducer, or maybe
> (this hasn't happened yet) if the researchers actually set up the web
> dashboard and e-mail responder.
> 
> I also blame the peer reviewers for the journals, for not asking the
> question, "why haven't you shown that the 'real world' bugs that your
> forked syzbot has found are ones that the original syzcaller hasn't
> found yet?"  And for not demanding of the academics, "if you want
> *real* impact, get your changes merged upstream with the upstream
> syzcaller, so that it will continue to find and fix vulnerabilities
> instead of ceasing the moment we accept your paper."

Yeah, I think these are good reasons why "number of bugs reported" is
just a poor metric.

Patches accepted upstream by syzbot would be much better, that indicates
that the actual practicioners in your field have found your work
valuable and checked that you aren't duplicating work that's already
been done.

