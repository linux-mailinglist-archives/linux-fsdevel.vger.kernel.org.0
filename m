Return-Path: <linux-fsdevel+bounces-22885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1091E232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDDC1C22D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE01167D9E;
	Mon,  1 Jul 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6DydJbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769DE16191A;
	Mon,  1 Jul 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843484; cv=none; b=Hk24Alm8aA/vD6mGfUa4Zv6VjWNd9EWNk3YClr2VNRkW1OL5MhBrZwrOlTJ8v6N7nSCHpaMu44p2DkfPKRJT7jr/M/0MjPQmS5qkJCd65/RI0W9/lXcQlcLMAOuuhYz/XPlGc+Hd+tF7GzVU6h+8er1njgauNP8MtzlG9K/7aoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843484; c=relaxed/simple;
	bh=KNdmg62H0LvKkwIT08kVZT9u8KwP64SOz7rDR0b4SFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjxMYc7B+OykxRJLlnhBT++GVZXdPGe3g/shBf22imCp2/p/UJwADzgxzceU1V7nYLfkaDx+upxg4Auwg8V4x/ZAZ9zH3S47O50qOF+8OpfGI2Owjh7gdAqeoSlw0oOH2yaxO25Nc2x4NXjcNltUmcycS/gSB04FHGpG9W9YSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6DydJbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D8FC116B1;
	Mon,  1 Jul 2024 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843484;
	bh=KNdmg62H0LvKkwIT08kVZT9u8KwP64SOz7rDR0b4SFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C6DydJbOJaYlZYklePBF3Mo12au5Yjdt2qvyRaArGosBk6V1aQWD1+mPpmyoTD7aa
	 H142OWpuDA0wW/Dq8pJx0lIsbaY5LJPRC2KMfrASntlF0W5Ey5houV2xjJu0dhsrvW
	 +sXSmJvCd3IHLyFJj4Nnlw391xuhO1uL0MIi/9tGYGtTxaBbkywvXcIDF/AHnQecgz
	 1A0BCNmhWgAA0p33tZC3bVduW66GyodzrYTgl+hk2HMiDkNf40k/Mo1bBHdfEpXa06
	 Z++U+RlDRgkcd7AFt4mL4ZcuHCV++rBaKxb6SQK7f+vXdTzzO6KCQF+ilHSTFxeHLp
	 s/o2L9gRqQkSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94168CE0AD3; Mon,  1 Jul 2024 07:18:03 -0700 (PDT)
Date: Mon, 1 Jul 2024 07:18:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Matthew Wilcox <willy@infradead.org>, kernel-janitors@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [v2 2/5] rosebush: Add new data structure
Message-ID: <c550c690-7555-4ccd-bf8a-8c54657aea3c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240625211803.2750563-3-willy@infradead.org>
 <52d370b2-d82a-4629-918a-128fc7bf7ff8@web.de>
 <ZoIHLiTvNm0IE0CD@casper.infradead.org>
 <8ced519f-47f2-4a74-be6d-4be5958009ba@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ced519f-47f2-4a74-be6d-4be5958009ba@web.de>

On Mon, Jul 01, 2024 at 07:21:18AM +0200, Markus Elfring wrote:
> >> Under which circumstances would you become interested to apply a statement
> >> like “guard(rcu)();”?
> >
> > Under no circumstances.
> 
> I imagine that further contributors would like to discuss collateral evolution
> also according to the support for applications of scope-based resource management.
> https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/rcupdate.h#L1093
> 
> See also the commit 80cd613a9ae091dbf52e27a409d58da988ffc8f3 ("rcu:
> Mollify sparse with RCU guard") from 2024-04-15.

Although the guard(rcu)() statement is very helpful in some circumstances
and is seeing increasing use, it is not free of downsides in a number
of situations.  For but one example, Matthew might expect that partially
overlapping critical sections will be needed, which would rule out use of
guards on one or the other of those two critical sections.

							Thanx, Paul

