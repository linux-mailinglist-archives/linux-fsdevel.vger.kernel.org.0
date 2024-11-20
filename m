Return-Path: <linux-fsdevel+bounces-35369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E19D446D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D06B23D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 23:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903C413BAF1;
	Wed, 20 Nov 2024 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKrwqy09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF913C3D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144912; cv=none; b=FI4k6MyvuuukJS4SL1MYq5BUvDvudjGENLZICXdyTy/gvbhkB2rzRhcDEFL+s9CMGGjApZWVuN8MuYs7hUti45zqKGfb4TaJILrSmC2I1W/ECe5x4BjDcrforKICVPr2nRFbp25nTQfdCSe+XTT8GctqV4KSooKVIBv9KJ4YCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144912; c=relaxed/simple;
	bh=JQcskyZBxz3FQjjtWi+ZSeY1Sy4GxLjQbSR/Y5saeHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/l5GzCQUAmEhEPUolPCnZsgnK93r37Y2fwLMxbDWNTFElKu5uO149r1M4zLX8eFmwZJWI/9sfA1Cexzsa3I5gOtuXXBlfeiMH2KxoNt5bsMuBT12tCZsODJ9Yzp3vKmPY4pgLwgwkISorA0omYc8Zm1D/uSTuxoI4A3Wu7tDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKrwqy09; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 18:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732144908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQcskyZBxz3FQjjtWi+ZSeY1Sy4GxLjQbSR/Y5saeHQ=;
	b=HKrwqy09rx+v3St23VlrK6XlssnrZJ4sNXBHbXhKUzVhYaBvnvTAmeXFQY9KeRZ+PII+QN
	HwPjeSSjpI8GuJ1gLIBH89oKKoVhUMw/npHWT80DDmWfRxoykto0sOpdAXNqtwVKmiZsQa
	5tA3yCWmWNB79qvI+pkZza0c4Oh92NM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <3hzjgsbq4fjmo4fd3d7gmn6p4uhqw2plqwx3lgzymtlf7vbgzf@ql7ly575idde>
References: <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
X-Migadu-Flow: FLOW_OUT

Lastly, the thing that motivated me to make an issue out of this was
several recent complaints, by my funders, that it's gotten increasingly
difficult to get work done on the lists lately without showing up at
conferences and shmoozing with the right people. I've noticed that as
well.

That's something we do need to address, and I see a common thread
between that and dismissive/authoritarian behaviour, and I think those
of us at the highest level (i.e. CoC board members) should be mindful of
how we set the tone for everyone else.

Yes, we're all Busy Important People (TM), but doing our jobs well
requires us to engage well with people.

I think that should be prioritized at least as much as "language". It's
not just about what words we use to communicate, it's about whether
we're able to communicate effectively or at all.

Couple's therapists say they can tell in a few minutes if a relationship
is worth salvaging or if it's beyond repair - and it comes down to if
they come in displaying anger or dismissiventess. Anger can be worked
through, dismissiveness means they no longer care.

I find the same is true with engineers. When people are pissed off about
something, that anger is often pointing to some important issue
underneath that, and getting to the bottom of it is going to hava a big
payoff. But when teams stop being able to work together - when people
start getting silod, afraid to stick their head up - that's really bad.

Vannevar Bush said that all he did was get people to talk to each other.

