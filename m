Return-Path: <linux-fsdevel+bounces-26998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B6395D848
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 23:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15204B20FC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 21:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B21B8EBE;
	Fri, 23 Aug 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C6iwZbgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5947D401;
	Fri, 23 Aug 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724446971; cv=none; b=HnMNWkp7wgY9JNVKD6hBue5Ermg2u2wbu3EPdxLty6O3XKIq8Nkw89ZKO/5QPrDkoVAF9vJGFHPbhVcnkfGOBG50/4YZdlCXe64xtndCa88gmpqwKwd0SWJ4eKwHLhVfdgQisGRXwyLGqtQGplC9rVn2F7EJQP6SM8y4aLsqcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724446971; c=relaxed/simple;
	bh=nH8oqdDj52PUh7dzoLgyetldfSEB/0EcGoulJoFRuGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot1L7cycu/iqeZM614tB4ASJniKeLMoyWN3c9xjAZnYmTy/YkNS210OnHYEaYCZ7xfXi0Dpm5Apib0ijoLKEM1K4eg71PyHW/xWT6sLP5Ma+GDko/kTl/O3w+Qxuqy0f6DkB0PM3d86bLJWy8q0Ree+sUGqxb826CwzKUj4J2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C6iwZbgi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id A297220B7165;
	Fri, 23 Aug 2024 14:02:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A297220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724446969;
	bh=94ktIl6VDdIJQkXpB2W9oUFrU1hm0z82X3RGB8CaEsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C6iwZbgi0mE2l4o05Ijn6mRc3v74OYS+oeKC4BL6cj/bLnm7gkyyLX2GjsN9AjyVV
	 Y0Ir9mghq8dR0IZtLlph/l2paSPKpFUn912xITmk99DcEJeffoGomADxzJ+fggBpM7
	 4PsiLVhcWHw5vozyhmmIG2lk36G8hlS/wAbMhO6A=
Message-ID: <727eebc5-e01e-4737-88b8-9890d90abc39@linux.microsoft.com>
Date: Fri, 23 Aug 2024 14:02:49 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/4] Squashfs: Ensure all readahead pages have been used
To: Christian Brauner <brauner@kernel.org>,
 Phillip Lougher <phillip@squashfs.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240820232622.19271-1-phillip@squashfs.org.uk>
 <20240821-erfinden-gegeben-be787ce7eb3b@brauner>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240821-erfinden-gegeben-be787ce7eb3b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2024 1:12 AM, Christian Brauner wrote:
> On Wed, 21 Aug 2024 00:26:22 +0100, Phillip Lougher wrote:
>> In the recent work to remove page->index, a sanity check
>> that ensured all the readhead pages were covered by the
>> Squashfs data block was removed [1].
>>
>> To avoid any regression, this commit adds the sanity check
>> back in an equivalent way.  Namely the page actor will now
>> return error if any pages are unused after completion.
>>
>> [...]
> 
> Applied to the vfs.folio branch of the vfs/vfs.git tree.
> Patches in the vfs.folio branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.folio
> 
> [5/5] Squashfs: Ensure all readahead pages have been used
>        https://git.kernel.org/vfs/vfs/c/5d85f9c952d8
> 

When I was testing the linux-next branch I got
"BUG: KASAN: slab-use-after-free in squashfs_readahead+0x19f1/0x1e50"
It seems this is due to the access of `actor` just after freeing it.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/squashfs/page_actor.h#n41

-Fan

