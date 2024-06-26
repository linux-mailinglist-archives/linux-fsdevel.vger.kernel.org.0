Return-Path: <linux-fsdevel+bounces-22546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DE91994E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B0B1F235E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3B194158;
	Wed, 26 Jun 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ADa+0mQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3261193061;
	Wed, 26 Jun 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434303; cv=none; b=tdNNpcPB6phgzYW5MayV/1RxFuuMhyMNtzBmN1SzyGqY4pnMWIWn+Iu3HI7X9cNfU9kZjhoPX1eP1waiQeLIMmVE/v5qEPQGLDmX6VTjVxCm83Z27/+BN4wUIHnIIxk71/IfLfn/iveP8EkDvThWBB4DmcMcqQY99JP110JVaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434303; c=relaxed/simple;
	bh=zirWFRyfszQ9k+2aZ/xG+erePQi+7EQ/qwhkvH5heKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oznOvXnCAzmOedXK8dBevC1n4wPuq4gaIqUwv+Pbj8I0A4HtHcItMh8D1mvPG68PgG5Z5/gWmcFZskM/ec9K36NSSjAtdQOpt7MD0DE9Qe+9Mj+yDMI5Wg5EgoM3AE7npEsiCJV7taJfnAz5ajaPYB3lOziheUz1WTKrz/UwCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ADa+0mQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE7AC116B1;
	Wed, 26 Jun 2024 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719434302;
	bh=zirWFRyfszQ9k+2aZ/xG+erePQi+7EQ/qwhkvH5heKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ADa+0mQLVJ0yyIY/R7xVja3PS+vFt3Sav+0zX/bIHrEX+5Ty1nTdP/+yEUBFrQHSS
	 sKJlw265qY9oxyWnTpvywb0MNy6y0XYLOs7IGNGeLJh5RWeh/VV6vnLRSlbua0BlT1
	 WVx+Svb6GHz81ofYfAjGhzUVj+pW0LWZGPwfbEwg=
Date: Wed, 26 Jun 2024 13:38:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gavin Shan <gshan@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, hughd@google.com,
 torvalds@linux-foundation.org, zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
Message-Id: <20240626133821.b2bba4fd46278fe1e4903052@linux-foundation.org>
In-Reply-To: <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
	<20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
	<33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
	<20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
	<f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
	<4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 10:37:00 +1000 Gavin Shan <gshan@redhat.com> wrote:

> 
> I rechecked the history, it's a bit hard to have precise fix tag for PATCH[4].
> Please let me know if you have a better one for PATCH[4].
> 
> #4
>    Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>    Cc: stable@kernel.org # v4.10+
>    Fixes: 552446a41661 ("shmem: Convert shmem_add_to_page_cache to XArray")
>    Cc: stable@kernel.org # v4.20+
> #3
>    Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>    Cc: stable@kernel.org # v5.18+
> #2
>    Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>    Cc: stable@kernel.org # v5.18+
> #1
>    Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>    Cc: stable@kernel.org # v5.18+
> 
> I probably need to move PATCH[3] before PATCH[2] since PATCH[1] and PATCH[2]
> point to same commit.

OK, thanks.

I assume you'll be sending a new revision of the series.  And Ryan had
comments.  Please incorporate the above into the updated changelogs as
best you can.


