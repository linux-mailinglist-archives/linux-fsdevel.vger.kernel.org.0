Return-Path: <linux-fsdevel+bounces-21478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206AA9046E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E181C224D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486115445D;
	Tue, 11 Jun 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rrBTIbJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C6155326;
	Tue, 11 Jun 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145006; cv=none; b=i/1oLirAjIIDwwzuKGaYl28776CFJsUgFdgnBYg+mfKA8G5CrGNnxfztsKsfCpejZrcLcGZxGR/tzo+Ha6hRH5Z6mwEV3Ehmd+XSDDzoQ5vVITyv0SPv/NCTocX0NPX9K7oGgDuyAc9YtrlDtsUOczMtb5DMO2wjI35j4aGcUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145006; c=relaxed/simple;
	bh=9RXJ8a97DEsdxRhMEVTCKuqQFatSuESJfhweaOU60zc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ho2Opl+aYs2Jbspd817dxS1t0Pfrqo4PfDaWEvlyu74oD4bfqIDuBUYz79N4zQs+ODG5tBy6dowfzQaQGYqVuYUkuvKgkIxoiLpRQ6hFOKGMZWmKH9YOtMeb598+2VMAUy2b+yRJANTkrhcZa+B/P62aUh4qjGpWJQ9aZMKAAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rrBTIbJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3051BC2BD10;
	Tue, 11 Jun 2024 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718145005;
	bh=9RXJ8a97DEsdxRhMEVTCKuqQFatSuESJfhweaOU60zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rrBTIbJmVn6LABt41IeGe1RUdI5zTMXwNH0wPzMLe00Vo2dyQqKEqw6EnLSZoc+SE
	 jI83hMTGeEmb6WxoVZjEkauQDro0orlF4+kVPLZow+ZEnGZXX2SZ7V8Ca2DjnyeL6+
	 1fN/gsFFBSVJ+UnjfEWAtL0rtL70BnrFKvLLvdfs=
Date: Tue, 11 Jun 2024 15:30:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
 mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
 david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com,
 ivan@cloudflare.com, pasha.tatashin@soleen.com, yosryahmed@google.com,
 hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz,
 Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, weixugc@google.com, David Rientjes
 <rientjes@google.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
Message-Id: <20240611153003.9f1b701e0ed28b129325128a@linux-foundation.org>
In-Reply-To: <20240605222751.1406125-1-souravpanda@google.com>
References: <20240605222751.1406125-1-souravpanda@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 22:27:51 +0000 Sourav Panda <souravpanda@google.com> wrote:

> Today, we do not have any observability of per-page metadata
> and how much it takes away from the machine capacity. Thus,
> we want to describe the amount of memory that is going towards
> per-page metadata, which can vary depending on build
> configuration, machine architecture, and system use.
> 
> This patch adds 2 fields to /proc/vmstat that can used as shown
> below:
> 
> Accounting per-page metadata allocated by boot-allocator:
> 	/proc/vmstat:nr_memmap_boot * PAGE_SIZE
> 
> Accounting per-page metadata allocated by buddy-allocator:
> 	/proc/vmstat:nr_memmap * PAGE_SIZE
> 
> Accounting total Perpage metadata allocated on the machine:
> 	(/proc/vmstat:nr_memmap_boot +
> 	 /proc/vmstat:nr_memmap) * PAGE_SIZE

Under what circumstances do these change?  Only hotplug?

It's nasty, but would it be sufficient to simply emit these numbers
into dmesg when they change?


