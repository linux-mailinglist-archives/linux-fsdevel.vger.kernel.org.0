Return-Path: <linux-fsdevel+bounces-52198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF9AE0256
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7EE16AF8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01066221D8B;
	Thu, 19 Jun 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZqy5T3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE9217F36
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327554; cv=none; b=s6hbw1G69cYxJ+nhhhfYryDXvyLHAahee6R+a2YfGCCQOz6UHJTe66CIgMLm1GRd1SrsnOe8d3hGTsy4MXcrjLiyuQFg8S4QgvsgYbgGMawhPQY0d8nfXMowupztjigiG+lExGrSTBNO4dtwxe9yvA8S5FFYFZ3c1LD/iNvoVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327554; c=relaxed/simple;
	bh=lpmH75q1o138ulv5wEjswPLaoaboV6H1jnKhOZ2xWkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzcUj/PI2fDLJBJHlwFt313xxfN3A1kgyyebfO4irQxEFqqkPy1NliiSEdyXBjDu6DpEihgQnHxM6pS6b+OnMEXwvzkAxvjXX2Wp5ebBAzT1BK62krLuZRq6svcvCU0kJWi5uzOUjDaZCcg+yN8MlECNWZqi3927IT3/zX94eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZqy5T3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0ADC4CEEA;
	Thu, 19 Jun 2025 10:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327552;
	bh=lpmH75q1o138ulv5wEjswPLaoaboV6H1jnKhOZ2xWkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZqy5T3MQvwX5qtFD7TxSvtyIyzH25oFmuVdP0yCyZUU71UlaHPOGOwPR5Lpld+b+
	 wwAVX7x2wvJKjiqTMyaEr1IBrQYczcUjiXxSj+6SNiyOQtMbT4OWeG183z7lPxGVFN
	 xyAiIF38+Q8kf22YCXK/tqe8IaWSyzr4nLhVdN6AMH4Pl1T75+VIqvNbkYPQB/rKHB
	 0sydt92BataomeNXxK1PrlzTQ1SDtSOL0fuSNTpszJMupAYWIl8ItISmukdoYE5cJf
	 4LVlnlhV9IARlUFc8hV+8jcIxO24hytkJxYxjZMZsXEKM4UwJmW1YqoSQzqLomsB5V
	 0yfy220BqiL9Q==
Date: Thu, 19 Jun 2025 12:05:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: On possible data race in pollwake() / poll_schedule_timeout()
Message-ID: <20250619-modeerscheinung-sumpf-f4d779fe7e42@brauner>
References: <d44bea2f-b9c4-4c68-92d3-fc33361e9d2b@yandex.ru>
 <bwx72orsztfjx6aoftzzkl7wle3hi4syvusuwc7x36nw6t235e@bjwrosehblty>
 <d2bd4e09-40d8-4b53-abf7-c20b4f81e095@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2bd4e09-40d8-4b53-abf7-c20b4f81e095@yandex.ru>

On Wed, Jun 18, 2025 at 08:08:22PM +0300, Dmitry Antipov wrote:
> On 6/18/25 6:20 PM, Jan Kara wrote:
> 
> > So KCSAN is really trigger-happy about issues like this. There's no
> > practical issue here because it is hard to imagine how the compiler could
> > compile the above code using some intermediate values stored into
> > 'triggered' or multiple fetches from 'triggered'. But for the cleanliness
> > of code and silencing of KCSAN your changes make sense.
> 
> Thanks. Surely I've read Documentation/memory-barriers.txt more than
> once, but, just for this particual case: is _ONCE() pair from the above
> expected to work in the same way as:

It's fine for this case.

