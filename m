Return-Path: <linux-fsdevel+bounces-22427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91091705B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC99B1F220EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BFD17A90F;
	Tue, 25 Jun 2024 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u1TlpRqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D8132127;
	Tue, 25 Jun 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340642; cv=none; b=dNuRZsORdQniKXNKIriH2W0m3hgK/M70cZrMXzxSNxsB68xTgdwPbF62+pVi5ili/6ZD83r9ges4mt+Pd/DUb9SlPebCI24Q2UlSmMakoKBCoV1IqGC+5HPEQj4i4ZdRCfYT6RqlNwCXNuqjcJAaE4OZSMmeLURVyybIETc23TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340642; c=relaxed/simple;
	bh=1h4rROOxpCnlElzRIWvA2/kJeM+WjouN22bwU9nLz1s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cqiPFxt19xmxAzU9rTylwg1k5VAprOanm4EREQfacoEY+1EgaI60KGxAYiupLZTYCGoB6PMOVoZdd/n068P9phKvFCCYA6MN9f4z6rH518qPvjLzmH0a3Liyy5fjihUre/A5iM3i9igRn1VCxEYSAu5o2MEAXKSNHLeZCG1KnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u1TlpRqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DB0C32781;
	Tue, 25 Jun 2024 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719340641;
	bh=1h4rROOxpCnlElzRIWvA2/kJeM+WjouN22bwU9nLz1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1TlpRqL78dZgPhrTAw5P+r9y6/4V6xBYVNNv9k0Rl1NGpihej4QO7wtZqt4BklL0
	 z0ynv2MCb7D0DLfXz5/AHoAT8M+QWZMDrO0lELqXTB6R8WDaH4+h7ouYjw+vArgkge
	 pah1TG1ondChQkaJY88ARyFz1udcI0vIfXT9Nd/4=
Date: Tue, 25 Jun 2024 11:37:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, david@redhat.com, djwong@kernel.org,
 willy@infradead.org, hughd@google.com, torvalds@linux-foundation.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
Message-Id: <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
In-Reply-To: <20240625090646.1194644-1-gshan@redhat.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 19:06:42 +1000 Gavin Shan <gshan@redhat.com> wrote:

> Currently, xarray can't support arbitrary page cache size. More details
> can be found from the WARN_ON() statement in xas_split_alloc(). In our
> test whose code is attached below, we hit the WARN_ON() on ARM64 system
> where the base page size is 64KB and huge page size is 512MB. The issue
> was reported long time ago and some discussions on it can be found here
> [1].
> 
> [1] https://www.spinics.net/lists/linux-xfs/msg75404.html 
> 
> In order to fix the issue, we need to adjust MAX_PAGECACHE_ORDER to one
> supported by xarray and avoid PMD-sized page cache if needed. The code
> changes are suggested by David Hildenbrand.
> 
> PATCH[1] adjusts MAX_PAGECACHE_ORDER to that supported by xarray
> PATCH[2-3] avoids PMD-sized page cache in the synchronous readahead path
> PATCH[4] avoids PMD-sized page cache for shmem files if needed

Questions on the timing of these.

1&2 are cc:stable whereas 3&4 are not.

I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
problem with this approach is that we're putting a basically untested
combination into -stable: 1&2 might have bugs which were accidentally
fixed in 3&4.  A way to avoid this is to add cc:stable to all four
patches.

What are your thoughts on this matter?

