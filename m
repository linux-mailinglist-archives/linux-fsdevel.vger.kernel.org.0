Return-Path: <linux-fsdevel+bounces-39408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738CA13BDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9A31688CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06E11F37CE;
	Thu, 16 Jan 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ui8qGFHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068F22AE75
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036758; cv=none; b=JRN3egPc7dc//IpeKlM5jRjB13j3BdqZ+xEHr6N4pQ5iCkP1df1a4/otfBkyCQjA4+UOjZhcxPjWB303urvMdq2svlS2yEAk0X4hdzFS5MCUFbCmcyf9luQ8hD4DeW2YCcB4QITT8akVAuFdrzSIgrJxM6ofMaQnROhtbrbeBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036758; c=relaxed/simple;
	bh=0ONbSeoE+BpUa0s0FI650q+qUrDiWuTHnxyzFZHlziY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4t4VR/E9dbxATkLD/ZwnGeeZGhDbysVsTms6XN3ivLLBdnnOLIc/DBMrGIbOl0YBxyKHDqZ/y80enak3JssYt+6Owd7mdyYs+IIIxBrmxiJ1DW2E5uYNk6y4vFB8zKE0yc8qA4tERrwO/1/d8/BUa8VSZixOYUsvp+tghVDqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ui8qGFHO; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Jan 2025 09:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737036750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdEt21iqpCEueOr848ZdfJUJ+Y81zDiKtjKI3ZOPQio=;
	b=ui8qGFHOfQmB9okpWRurzzn48VtRT9IeIXOpCkpRJXpt0BlILX+TSqrMOBNGhAwh073Slg
	BS04DyY64Y3GhV20rVOtahWiww3lkcH0PzaJ5EYpCHyB1ZN4yguthYMG3rSeHKrsBgly/f
	4HGFKXH294RBxomwR7949d9CsigFfHk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <tkfjnls4rms7r7ajdwj3n4yxyexufrdunhgvzalegz6j35zbxm@fexthq26w7lr>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
 <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
 <5BCDEDB6-7A92-4401-A0A8-A12EF2F27ED0@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BCDEDB6-7A92-4401-A0A8-A12EF2F27ED0@m.fudan.edu.cn>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 16, 2025 at 05:37:24PM +0800, Kun Hu wrote:
> 
> > 
> > Makes sense. Sorry if I came off a bit strong, there's been a couple
> > syzbot copycats and I find I keep repeating myself :)
> > 
> > So, it sounds like you're getting nudged to work upstream, i.e. people
> > funding you want you to be a bit better engineers so the work you're
> > doing is taken up (academics tend to be lousy engineers, and vice
> > versa, heh).
> > 
> > But if you're working on fuzzing, upstream is syzbot, not the kernel -
> > if there's a community you should be working with, that's the one.
> > 
> > An individual bug report like this is pretty low value to me. I see a
> > ton of dups, and dups coming from yet another system is downright
> > painful.
> > 
> > The real value is all the infrastructure /around/ running tests and
> > finding bugs: ingesting all that data into dashboards so I can look for
> > patterns, and additional tooling (like the ktest/syzbot integration, as
> > well as other things) for getting the most out of every bug report
> > possible.
> > 
> > If you're working on fuzzing, you don't want to be taking all that on
> > solo. That's the power of working with a community :) And more than
> > that, we do _very_ much need more community minded people getting
> > involved with testing in general, not just fuzzing.
> > 
> 
> 
> Hi Kent,
> 
> Thank you for your insights.
> 
> I have a couple of questions I would like to ask for your advice on:
> 
> From a testing perspective, we have modified syzkaller and discovered
> some issues. It’s true that researchers working on fuzzing often lack
> a deep understanding of the kernel, making it difficult to precisely
> determine the scope of reported problems. Meanwhile, syzbot provides a
> description of the reporting process (please refer to the link below)
> and encourages researchers to report bugs to maintainers. However,
> there seems to be a significant gap here—researchers may end up
> reporting bugs to the wrong maintainers or submitting reports that
> lack value. This seems like a serious issue. Could the kernel
> community consider establishing a standardized process to reduce
> wasted time on all sides and prevent researchers from inflating bug
> counts just to validate their papers?

Again: the standard mantra is "work wth upstream". If you forked syzbot
and you're working on fuzzing, syzbot is your upstream, not the kernel.

If you work with the syzbot people on getting your fuzz testing
improvements merged, the process of reporting the bugs fuzzing finds to
us kernel folks won't be on your plate anymore, and you get to focus on
the stuff you actually want to be doing. :)

> Link: https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md
> 
> It is often suggested that researchers collaborate with syzbot. What
> should such collaboration look like in terms of form and content? From
> a maintainer's perspective, how would you prefer to see researchers
> who report bugs work with syzbot? Since I’m new to this field, I’m not
> very familiar with the process and would greatly appreciate your
> guidance.

Talk to the syzbot folks, they're a friendly bunch :)

The main thing to keep in mind is that it's never _just_ about getting
your code merged, you need to spend some time learning the lay of the
land so you can understand where your work fits in, and what people need
and are interested in - you want to make sure that you're not
duplicating work, and you want your code to be as maintainable and
broadly useful to everone else as it can be.

Have you shared with them what your research interests are?

