Return-Path: <linux-fsdevel+bounces-58254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2EB2B88C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 07:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8D3628030
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5FE30F813;
	Tue, 19 Aug 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XMNHGDun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3519F121;
	Tue, 19 Aug 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755580813; cv=none; b=VTqHXZlLyczwBnwAocWTq4WfI2zgqvkuTWqc+zIm8Sd0COq0iLvYN+gshWN4VyhU3/SBD8rB8Dke+0H85RHfvu/ys1fpsKuUyxb76f4urefumIL9Sz0h/4Ohb3OuH28GbKzLlIn/ZPa4zNqD5rdCulF5pYZmX1LUYalQV48uIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755580813; c=relaxed/simple;
	bh=sxJcUwVN/CsHyd67+5zfW7soLBfQ8ItPLkDXT2omVZ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g3kfUXgzdD8TdKD3lO88jVuvEuzadDQMkvVPhRvYUhSmhWc/2Kr/QmlV5pqOHai/730K/OMiommm9Pztg7LU9dfMEDywB+l/RAT0dc2F5VrcEAYX3tANfCbYlMEleNyzlFNtmVtEjoZ3lkFIBZ7BdHyg4/BXO/E98oA0AC//g9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XMNHGDun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD00C4CEF4;
	Tue, 19 Aug 2025 05:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755580810;
	bh=sxJcUwVN/CsHyd67+5zfW7soLBfQ8ItPLkDXT2omVZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XMNHGDunAL2ROl6ZH05LV6ePww0er0HEGB6KXTCa1LSzaqIHkg2w+DYblTi6A4w64
	 nM19hkZyotNbVnUHaU4uIMKNwmgobuGOn/yFD+MCyZoQyBbVOSqYrT1Eac5WGaESfX
	 E/VAseYRw6+B61BDDRGmni0hh5vQKFQa5OLvan1Y=
Date: Mon, 18 Aug 2025 22:20:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
 shakeel.butt@linux.dev, wqu@suse.com, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 4/4] memcg: remove warning from folio_lruvec
Message-Id: <20250818222009.7f03b557e6e1b58cb0a100ef@linux-foundation.org>
In-Reply-To: <aKPkWv77HMOQwyVi@casper.infradead.org>
References: <cover.1755562487.git.boris@bur.io>
	<0cf22669a203b8671b6774408bfa4864ba3dbf60.1755562487.git.boris@bur.io>
	<aKPkWv77HMOQwyVi@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 03:41:30 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Aug 18, 2025 at 05:36:56PM -0700, Boris Burkov wrote:
> > Commit a4055888629bc ("mm/memcg: warning on !memcg after readahead page
> > charged") added the warning in folio_lruvec (older name was
> > mem_cgroup_page_lruvec) for !memcg when charging of readahead pages were
> > added to the kernel. Basically lru pages on a memcg enabled system were
> > always expected to be charged to a memcg.
> > 
> > However a recent functionality to allow metadata of btrfs, which is in
> > page cache, to be uncharged is added to the kernel. We can either change
> > the condition to only check anon pages or file pages which does not have
> > AS_UNCHARGED in their mapping. Instead of such complicated check, let's
> > just remove the warning as it is not really helpful anymore.
> 
> This has to go before patch 3 (and I'd put it before patch 1) in order
> to preserve bisectability..

Thanks, I'll move it to [2/4]

?  That requires changing the tenses in the
> commit message, but that's perfectly acceptable.

I'm not spottig this.  a4055888629bc was added in 2020 and the btrfs
change is in a preceding series.  I'll describe that by name, so

: Commit a4055888629bc ("mm/memcg: warning on !memcg after readahead page
: charged") added the warning in folio_lruvec (older name was
: mem_cgroup_page_lruvec) for !memcg when charging of readahead pages were
: added to the kernel.  Basically lru pages on a memcg enabled system were
: always expected to be charged to a memcg.
: 
: However a recent functionality to allow metadata of btrfs, which is in
: page cache, to be uncharged was added to the kernel
: ("btrfs-set-as_uncharged-on-the-btree_inode.patch").  We can either change
: the condition to only check anon pages or file pages which does not have
: AS_UNCHARGED in their mapping.  Instead of such complicated check, let's
: just remove the warning as it is not really helpful anymore.


