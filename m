Return-Path: <linux-fsdevel+bounces-40043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FFEA1B7A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E1D3AB2DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07D4317E;
	Fri, 24 Jan 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hsW++UxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29613594D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728131; cv=none; b=duPrskF5BrG0KPBWCR4jVO1/7+SqImeLHOO6voPG0RFBHoLENgk/lNAlA7285umKWE3/83f9CdJRG0CZdmGlI+brPuazw8TrZpw3r3NixDjhDKjmwrLTFEZ2ioUIvsiV76Dn6vmpP1z9BEfyAGpBYlksg8Cnik2nOn/RL8Ioak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728131; c=relaxed/simple;
	bh=97MJ8WWFxVaC9jMfNKxXdHuK3OSkHDNx8EhDQX7AUi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS0xoYRnegwrAh7RUo+6oMXtySP/hbooiBu5PzGd46mnqvdx2/bFyLlepfhOOaGQcZUcMW5XuIxpF8TNRfMp2yDv/l/oqauABO0WU/Bpwa1J5TFC7MafEUJfGkKf0hH7AoMiF2xIx4+3BV8RuhIFJ+PMNVMdMOi6mI18hIF3uEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hsW++UxL; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Jan 2025 09:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737728121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lq+QTPSqU8loPhhXwi6+gC/RNqRQ4ydTXYqFQWqu6Y=;
	b=hsW++UxLxW0TE+E5Izw29VEuVJU5JI3G0mIR+u3GsCeQyK93KZM/5ZxEGT0NxQ2vgQ8NJi
	lRMQzn1vJJYPcjNXJtxK8dVFS6cg9n8nfOAgKJ02fb0GcF7WXtLAOrzAEpns/pupd+Vo8x
	WxEuyhi/MdUKIcq+rN+Y0TD3NZL9yLg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <iiebhi7ijlyo54zq4mtqnbw6253ysnhia5qpdek2hyyby3ls7e@pko7dnzi77fk>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <900A37C1-9A21-46DF-8416-B8ABF1D0667C@m.fudan.edu.cn>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 08:22:57PM +0800, Kun Hu wrote:
> 
> > 
> > Again: the standard mantra is "work wth upstream". If you forked syzbot
> > and you're working on fuzzing, syzbot is your upstream, not the kernel.
> > 
> > If you work with the syzbot people on getting your fuzz testing
> > improvements merged, the process of reporting the bugs fuzzing finds to
> > us kernel folks won't be on your plate anymore, and you get to focus on
> > the stuff you actually want to be doing. :)
> > 
> >> Link: https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md
> >> 
> >> It is often suggested that researchers collaborate with syzbot. What
> >> should such collaboration look like in terms of form and content? From
> >> a maintainer's perspective, how would you prefer to see researchers
> >> who report bugs work with syzbot? Since I’m new to this field, I’m not
> >> very familiar with the process and would greatly appreciate your
> >> guidance.
> > 
> > Talk to the syzbot folks, they're a friendly bunch :)
> > 
> > The main thing to keep in mind is that it's never _just_ about getting
> > your code merged, you need to spend some time learning the lay of the
> > land so you can understand where your work fits in, and what people need
> > and are interested in - you want to make sure that you're not
> > duplicating work, and you want your code to be as maintainable and
> > broadly useful to everone else as it can be.
> > 
> > Have you shared with them what your research interests are?
> 
> 
> Sorry for late. Thank you very much for your advice, we’ll try to work with the syzbot community. 
> 
> But an interesting interaction relationship is that for researchers
> from academia to prove the advanced technology of their fuzzer, they
> seem to need to use their personal finding of real-world bugs as an
> important experimental metric. I think that's why you get reports that
> are modeled after syzbot (the official description of syzkaller
> describes the process for independent reports). If the quality of the
> individual reports is low, it does affect the judgment of the
> maintainer, but also it is also a waste of everyone's time.

Ah, metrics and TPS reports. Symptoms of MBA culture, "we just want to
manage by watching the numbers and making sure they go up - deep
expertise in the thing we're managing? what's that?"

Push back on that mindset wherever you can and your life will be less
nonsensical and frustrating :)

Maybe see if you can find some other way of showing the value of your
work? Things like patches accepted into upstream syzbot, public
feedback from the syzbot maintainers, or just describing your work
yourself to your higher ups instead of relying on metrics - or see if
you can help them come up with some better metrics.

