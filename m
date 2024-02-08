Return-Path: <linux-fsdevel+bounces-10834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3A84EA3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE7F1F250A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AC4F1F2;
	Thu,  8 Feb 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iTzlcjDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C4381D3;
	Thu,  8 Feb 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427274; cv=none; b=oZLB2JNf6HtpyEXurCDWm5wL0UMy71O3oVIdrqBPv/OUG5dOjgdH7uBeLntmZkDaapGBZcpZRHzy44yghna3Gr/CP5ws9F3ESevHQCNFRE1VTrdoIiABkmaSgn1pLiBPvxKXfY3i2KZdBuGabPmmffQoIpL3/NNQ8tqcmtbWjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427274; c=relaxed/simple;
	bh=TE6VqizE4efLqCBitG06M/VRnFw1efWMckznBQfEJ1k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PXrf5Nz4FP0ig29bAgPdvVwVkPvPgk35WtyCE1mVIMSPKewRNUFvLyIVd9qbwMK25LTj+GS8bKVyGSZwU4KV2ZNd8P1AXQKN8sWvK/Xhktqtmzs7YFzmTl/2OnhQyuSHEYE7ZHh/fVL2G4uH16HfArVCsi4idSeURs+0OAGNfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iTzlcjDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB6C433C7;
	Thu,  8 Feb 2024 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707427273;
	bh=TE6VqizE4efLqCBitG06M/VRnFw1efWMckznBQfEJ1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iTzlcjDxZeqzpLgM2c0UDW8zutFRN4NZqOJxe/vrUtVOb0QDld35QCt+eWiNlHKal
	 rin8MDPU0+SovgV8/BHHKMuKlFuhrSakoXhhtMP/YjSVL/NpHL9xNGmg0I9kHVZovM
	 TVqUTU26ZDU8HiClwub6vU1ocBypCHs/iQdkq2dg=
Date: Thu, 8 Feb 2024 13:21:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Matthew
 Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-s390@vger.kernel.org, Alasdair Kergon
 <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
 <mpatocka@redhat.com>
Subject: Re: [PATCH v4 01/12] nvdimm/pmem: Fix leak on dax_add_host()
 failure
Message-Id: <20240208132112.b5e82e1720e80da195ef0927@linux-foundation.org>
In-Reply-To: <20240208184913.484340-2-mathieu.desnoyers@efficios.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
	<20240208184913.484340-2-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 13:49:02 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
> before setting pmem->dax_dev, which therefore issues the two following
> calls on NULL pointers:
> 
> out_cleanup_dax:
>         kill_dax(pmem->dax_dev);
>         put_dax(pmem->dax_dev);

Seems inappropriate that this fix is within this patch series?

otoh I assume dax_add_host() has never failed so it doesn't matter much.


The series seems useful but is at v4 without much sign of review
activity.  I think I'll take silence as assent and shall slam it all
into -next and see who shouts at me.


