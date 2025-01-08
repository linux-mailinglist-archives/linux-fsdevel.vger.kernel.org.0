Return-Path: <linux-fsdevel+bounces-38634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40DA05325
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 07:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0F18876CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADF1A726B;
	Wed,  8 Jan 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yV3mq70N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAA1A3A8A;
	Wed,  8 Jan 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317606; cv=none; b=sdw7c5w1jk3Grv7tChmWpKc1XbWenygH+ChWQvUG37nb8DCUUNEf9MUuquaM2kdWnjFAiJC0+IEBGeGQzVtifuE7DjyS9zKNuEd0b8w6JFpPXGJQmXY051fgbb8w0rwBi1iwh82U4TQR9W1DGYh4TREGB+/FALB7oMhbDM07eyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317606; c=relaxed/simple;
	bh=ictVswVJ4mGv9GZMqt9hcwWRjSa3QIhF5THgyv+dfIc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NIa//bYP1dG+uyVwnJVPWbkFAlHxsV77AGeqEOX6jCUGHw6DR6Sa/GPX/xSTYXn0dKumkh7HLLIzNzsU1cUN7yGkRD0Bynbzg6dp7Kz4pw0wdax4MVOWZzVaibEiyCjt2Dpfkv+b3rougNNQf0edwLxrguU2yujS8xgSzgrgd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yV3mq70N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75956C4CED0;
	Wed,  8 Jan 2025 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736317605;
	bh=ictVswVJ4mGv9GZMqt9hcwWRjSa3QIhF5THgyv+dfIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yV3mq70NowsKzsNN4Ez+jnFDFJRIlhbNscdaUiVTLxZRecRmCbvgybiz9uRsrgg0n
	 PjP3lsjSFoN3ZHe8QI2pdayWSJuwfonJJuwBr3DLAHViSi3MWsPfptWuWaWljJtEVC
	 tmLb8vkj5Dj4ezW3MMOW7Coe5YQtHTHUai0uWSDo=
Date: Tue, 7 Jan 2025 22:26:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH v5 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-Id: <20250107222643.80d5509219d6b66c15b1b8af@linux-foundation.org>
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 14:42:16 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> Device and FS DAX pages have always maintained their own page
> reference counts without following the normal rules for page reference
> counting. In particular pages are considered free when the refcount
> hits one rather than zero and refcounts are not added when mapping the
> page.
> 
> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> mechanism for allowing GUP to hold references on the page (see
> get_dev_pagemap). However there doesn't seem to be any reason why FS
> DAX pages need their own reference counting scheme.
> 
> By treating the refcounts on these pages the same way as normal pages
> we can remove a lot of special checks. In particular pXd_trans_huge()
> becomes the same as pXd_leaf(), although I haven't made that change
> here. It also frees up a valuable SW define PTE bit on architectures
> that have devmap PTE bits defined.
> 
> It also almost certainly allows further clean-up of the devmap managed
> functions, but I have left that as a future improvment. It also
> enables support for compound ZONE_DEVICE pages which is one of my
> primary motivators for doing this work.
> 

https://lkml.kernel.org/r/wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld
made me expect merge/build/runtime issues, however this series merges
and builds OK on mm-unstable.  Did something change?  What's the story
here?

Oh well, it built so I'll ship it!

