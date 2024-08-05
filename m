Return-Path: <linux-fsdevel+bounces-25007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A2947A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC30B1C21088
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF9155CA3;
	Mon,  5 Aug 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdY54jwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE31547E0;
	Mon,  5 Aug 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858286; cv=none; b=UR1t8rluGwRvFKUwlNUXZ2o4Ar+Kiwq0kXKhe5c8ZetDv9mzeZGmFDOyNZuBxn+bca4ZG/kpV9e/3O6A7E+Ozhffow55AS7BHFea5iB8lMUPSLrZIJLSmRBfg2HDeoH7+rJ57Ut1aMs8cjC1yXrShZTTxrwwkDqXEnWvLeHV/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858286; c=relaxed/simple;
	bh=psjqkvSz6om6QMnXQwEc9G30bmFNifSE/T8EH9Ag1xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E065YY16oFkoJCkH27QVWCi8ABBXWOEFVq6OmbhrS2/2+cxvGcmPPflTvudEnqFvy8NzVxIBt8pf1YBEhYgDkXfuhk7nIRoklu68+eraJ/miLzyH130+CuQDRSzowJZKVktBMIEHYFaFuLTFFDzNrrdlKlvfSI+q2RAzVd7bHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdY54jwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F45C32782;
	Mon,  5 Aug 2024 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722858285;
	bh=psjqkvSz6om6QMnXQwEc9G30bmFNifSE/T8EH9Ag1xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdY54jwiesJ8buhej7fdZ6PHEznwgxSSQ9wTdYn9AxsFZAU1kyFnHxR9OiUodo+iO
	 Fisc9Ies/PCFTFMHV/93WUBdiP02DXmZyI6OuwkAQxHiVQiSc/zhduwJrCbGo/MOaN
	 9/F07jIPxEEnPNHd+97SjCxQUcqbBydwq7k3B7X8XC0bKbhqK7E9AxOHyXD4NQZ45Z
	 E+/7YzQBIcQ7waV9VgDLCJfN27gupKHJKzvP3OTy8f2zN45biSmyZMKv0kMRf8i6ru
	 43rEAWKJC7kbkmAnb8R9gVPNi1vy21+q3dWvSG3Bj7sOa4V9x6wJkKfmdegkvFa4XI
	 XNzNVb16V8Qlg==
Date: Mon, 5 Aug 2024 13:44:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle
 contention better
Message-ID: <20240805-unser-viren-4f1860143b6e@brauner>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
 <20240802-openfast-v1-3-a1cff2a33063@kernel.org>
 <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
 <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com>
 <7ff040d4a0fb1634d3dc9282da014165a347dbb2.camel@kernel.org>
 <CAGudoHFn5Fu2JMJSnqrtEERQhbYmFLB7xR58iXeGJ9_n7oxw8Q@mail.gmail.com>
 <808181ffe87d83f8cb36ebb4afbf6cd90778c763.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <808181ffe87d83f8cb36ebb4afbf6cd90778c763.camel@kernel.org>

> Audit not my favorite area of the kernel to work in either. I don't see
> a good way to make it rcu-friendly, but I haven't looked too hard yet
> either. It would be nice to be able to do some of the auditing under
> rcu or spinlock.

For audit your main option is to dodge the problem and check whether
audit is active and only drop out of rcu if it is. That sidesteps the
problem. I'm somewhat certain that a lot of systems don't really have
audit active.

From a brief look at audit it would be quite involved to make it work
just under rcu. Not just because it does various allocation but it also
reads fscaps from disk and so on. That's not going to work unless we add
a vfs based fscaps cache similar to what we do for acls. I find that
very unlikely. 

