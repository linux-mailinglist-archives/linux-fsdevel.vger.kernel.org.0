Return-Path: <linux-fsdevel+bounces-42028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1375EA3AED3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 02:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E667A4D7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 01:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616381724;
	Wed, 19 Feb 2025 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L8exmLHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272522097;
	Wed, 19 Feb 2025 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928209; cv=none; b=dBaFSfU5XcnyjhCbw4hFSd9VwVk5Rxv+49Kdahs7gyPQ1Vq376UdfzQ7lUXDBm9p89k74yH//RVCmaLMMrwEDz4tNzyN8WS054QPri3TQi1jzmHLX+MNurzWs34luIeS6WhzAM4xNpQktNXyIrJodJhx/bi7BTjig85fp8Q8eV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928209; c=relaxed/simple;
	bh=fwOmitL1Usk4JDJgeMpXF7Ztd9uPEE6ejz8pYVJyOeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMgdyBuCSx3UMIXd6uyX0NnWq257/2Z7NTrQl+ycOF/MLUPiZyHuH5RvEpGvPJLDliVkOR/vR0WTapGY400Ys8FHt4T+TggzVLkpq/W5OWcl8YyhdG7aHj7+4s6uzMmuVukmi01l4zn0HrfZLW+L7XoQj5Pju6M6YW55QK9XKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L8exmLHQ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739928197; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RKKB/bnDibpzm10Y361PXYXPsCzqwGtf81SgiyAceQo=;
	b=L8exmLHQvUmMFLdQ84gayTLbs27i/g4vT7AtnMH12LyLor0vQHh+TCtfF7SJdR2kHE16oyuuwSckDq3Sl/PGK8+ulcagL91mgWb4Gc3csHWtRLGtOczVZbZmouqJfXhz8eoyifcJYzwvq3VpgwhFGqBvI74n3sl/KPzSkrLK5Yw=
Received: from 30.221.145.137(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WPnAzoo_1739928196 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 09:23:16 +0800
Message-ID: <b2248d8c-1f80-4806-80fb-cbc40ad713e6@linux.alibaba.com>
Date: Wed, 19 Feb 2025 09:23:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
 <cedbmhuivcr2imkzuqebrrihdkfsmgqmplqqn7s2fusk3v4ezq@7jbz26dds76d>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <cedbmhuivcr2imkzuqebrrihdkfsmgqmplqqn7s2fusk3v4ezq@7jbz26dds76d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 8:32 PM, Kirill A. Shutemov wrote:
> On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
>> ... otherwise this is a behavior change for the previous callers of
>> invalidate_complete_folio2(), e.g. the page invalidation routine.
> 
> Hm. Shouldn't the check be moved to caller of the helper in mm/filemap.c?
> 
> Otherwise we would drop pages without writing them back. And lose user's
> data.
> 

IMHO this check is not needed as the following folio_launder() called
inside folio_unmap_invalidate() will write back the dirty page.

Hi Jens,

What do you think about it?

-- 
Thanks,
Jingbo

