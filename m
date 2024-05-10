Return-Path: <linux-fsdevel+bounces-19290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4258C2DA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C841F2338B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96842176FC9;
	Fri, 10 May 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="beYW8OFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80B7710A;
	Fri, 10 May 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715384118; cv=none; b=IgAUp20B4Z75YuxKLlkAL+ikdA1vfZoc2QK3htiQzmwen4H4oAi5SwQjX2yoSezu7xhzCdlblEBkUb1JWXkBtfaaYlMuTdc7BznVpdl4NSyzR8JknZ+Sr2sXdGi5kPtnWRCAqWkoEHl37Cs9zioEv3ipnY2MjhSRSMYKzk8dd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715384118; c=relaxed/simple;
	bh=o+9fe329P7ljRzO43YkDEDHDfsYP5X21I5HJqZq/Cik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTcdxLhvmTcw07IANy0H39i6NkuDD14P3+sw4FmU/peeE2SupOjDIJTc8Oczrz1VCWpSuT/eVfwvTDwOJ4zqn8uj5auhewjx8W51ASS6ooevOriMZjcGL/CSBGnp/1UIkxd9NQP38XXhSkfF/dX6Pa3qvOTakdAk1imSuCRRk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=beYW8OFK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1bK5po7ozuM/Kuo0oGkyZOlLv+PYx/iiGbhInJnVwdA=; b=beYW8OFK/Evctd/o1bZL3U9Nm8
	eTSCiYPQqxLCU1h/G8tCvycJePPmvBYGglYEDiNevh5sKgLKieS129opY6Ck8TF9CDSCDMSEJPel0
	bVAtiaFcE0Xv2YksM9VKIEZ2NEPLFTYzF94iXWMJQOKY2zW9hYG7SNXbCkeWRRB9aDSYRfnFtRfPF
	M2ZnlEJ6OJBvh+7QK1n9JfCQWg8J4hGeU5ggnA5OhHq5+MyjCOKlg7BSYeae+ZkuOKD0UWj+RbVxR
	T4M784Cs74UPa92oqIn+T3p08orz2S1xDEmWqBsl8LdLhF6SX+AyFp8RA49VdyVPktQ/UB/eA/VR6
	o+JWQMMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Zlf-00000004Asp-3pUw;
	Fri, 10 May 2024 23:35:12 +0000
Date: Sat, 11 May 2024 00:35:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Running BOF
Message-ID: <Zj6vL2FgUh3tbmBu@casper.infradead.org>
References: <ZiAATJkOF-FulDyS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAATJkOF-FulDyS@casper.infradead.org>

On Wed, Apr 17, 2024 at 06:01:00PM +0100, Matthew Wilcox wrote:
> As in previous years, I'll be heading out for a run each morning and I'd
> be delighted to have company.  Assuming our normal start time (breakfast
> at 8am, sessions at 9am), I'll aim for a 6:30am start so we can go
> for an hour, have half an hour to shower etc, then get to breakfast.
> We'll meet just outside the Hilton main lobby on Temple Street.

Our start time has been pushed back by half an hour this year (breakfast
at 8:30, sessions at 9:30), so let's start the run half an hour later.
And the street name needs a little disambiguation; there are North,
South, East and West Temple Streets ;-)

So, we will meet at West Temple Street & Pierpont Ave at 7am.  I have
a certain amount of route scouting done, and we can negotiate where we
go each day.  I'll be wearing a red t-shirt and black shorts.

> I don't know Salt Lake City at all.  I'll be arriving a few days in
> advance, so I'll scout various routes then.  It seems inevitable that
> we'll head up Ensign Peak one day (6 mile round trip from the Hilton
> with 348m of elevation) and probably do something involving City Creek /
> Bonneville Boulevard another day.  If anyone does know the various trails,
> I'd be delighted to listen to your advice.

Ensign Peak was muddy when I went up on Wednesday and not very fun.
It's also more of a hike than a run.  Now, it had been raining/snowing
on Tuesday, so it may have dried out by the time we want to go up.

