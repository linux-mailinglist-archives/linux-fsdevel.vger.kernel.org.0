Return-Path: <linux-fsdevel+bounces-45315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD52A75ED2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 08:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706EB167A1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5018CBE1;
	Mon, 31 Mar 2025 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey+hvM+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50D524B0;
	Mon, 31 Mar 2025 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743402490; cv=none; b=blwF2zt9DDDExE8Tg495Fra722+hPo1icGA4QQBCa9LRWo4kE3id8GwoQl0kEQ9Ze6uXfP9ea5xJ0X6LRp9BYsps8CbchCnEmu1iFH5bbtRElYpGSr8vPrWE0VPKC2qyLQ0HMeIXbvLdz4EcUDGwPHw6EtbQLr500k61WlfsA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743402490; c=relaxed/simple;
	bh=+eItXhKnWJeHMWExJ/x2UBbaDvLbu4bfKiG/3z5gTGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7eoa7KTzdUwFRPuSEYYD2Hc4ecP6uAPkjHthOj0h0W+K4Bp2Jf7QbLR6VeKnEoHH6lcl9aU249scQSkkPLoQ05CJMaE7nkPlLO2px30iUoMYlt0vo4LS/cBDGskHfUZh2sPzh6/f0c9IGpy2ByADl09AGMh14log1x3ojEI9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey+hvM+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E452C4CEE3;
	Mon, 31 Mar 2025 06:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743402488;
	bh=+eItXhKnWJeHMWExJ/x2UBbaDvLbu4bfKiG/3z5gTGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ey+hvM+96L67Lbzr+/QMpIpNdVZOFirXL65HdnhdS6IGzs+ZgEZaBoWQawI61GDI6
	 9Gpob2on3gvNEkpfNcOvxMLWXjxzRakxTMad9/BrwsBofc4gihwp9gwGdF4bC4AxiO
	 9zkwfj3e2EDL8U4KWcNVl9dszGvmrqDNPrDHk6nC2K9oTAh/l+dghQP3QKVl0osbl7
	 op8udcr5twUWJfRGB5EoBvipIDc8zuVn2vc9NmvL41qHjMsCntTa7orM4Ye2PT1WF9
	 JB0kDrnsznX0v/CDVuuLD0I2FOSvT9w4uJOP3HkraisQMW03dUjvIXj9ln3LqwRomR
	 EJZpnqFIq+FGw==
Date: Sun, 30 Mar 2025 23:28:07 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, hannes@cmpxchg.org, oliver.sang@intel.com,
	dave@stgolabs.net, david@redhat.com, axboe@kernel.dk, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH 1/3] mm/migrate: add might_sleep() on __migrate_folio()
Message-ID: <Z-o196uWOVaZnf4w@bombadil.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-2-mcgrof@kernel.org>
 <Z-kzMlwJXG7V9lip@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-kzMlwJXG7V9lip@casper.infradead.org>

On Sun, Mar 30, 2025 at 01:04:02PM +0100, Matthew Wilcox wrote:
> On Sat, Mar 29, 2025 at 11:47:30PM -0700, Luis Chamberlain wrote:
> > However tracing shows that folio_mc_copy() *isn't* being called
> > as often as we'd expect from buffer_migrate_folio_norefs() path
> > as we're likely bailing early now thanks to the check added by commit
> > 060913999d7a ("mm: migrate: support poisoned recover from migrate
> > folio").
> 
> Umm.  You're saying that most folios we try to migrate have extra refs?
> That seems unexpected; does it indicate a bug in 060913999d7a?

I've debugged this further, the migration does succeed and I don't see
any failures due to the new refcheck added by 060913999d7a. I've added
stats in a out of tree patch [0] in case folks find this useful, I could
submit this. But the point is that even if you use dd against a large
block device you won't always end up trying to migrate large folios
*right away* even if you trigger folio migration through compaction,
specially if you use a large bs on dd like bs=1M. Using a size matching
more close to the logical block size will trigger large folio migration
much faster.

Example of the stats:

# cat /sys/kernel/debug/mm/migrate/bh/stats

[buffer_migrate_folio]
                    calls       9874
                  success       9854
                    fails       20

[buffer_migrate_folio_norefs]
                    calls       3694
                  success       1651
                    fails       2043
          no-head-success       532
            no-head-fails       0
                  invalid       2040
                    valid       1119
            valid-success       1119
              valid-fails       0

Success ratios:
buffer_migrate_folio: 99% success (9854/9874)
buffer_migrate_folio_norefs: 44% success (1651/3694)

> > +++ b/mm/migrate.c
> > @@ -751,6 +751,8 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
> >  {
> >  	int rc, expected_count = folio_expected_refs(mapping, src);
> >  
> > +	might_sleep();
> 
> We deliberately don't sleep when the folio is only a single page.
> So this needs to be:
> 
> 	might_sleep_if(folio_test_large(folio));

That does reduce the scope of our test coverage but, sure.

[0] https://lore.kernel.org/all/20250331061306.4073352-1-mcgrof@kernel.org/

  Luis

