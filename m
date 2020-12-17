Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356982DCE23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 10:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgLQJPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 04:15:52 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17656 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQJPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:15:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdb219f0004>; Thu, 17 Dec 2020 01:15:11 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 09:15:11 +0000
Subject: Re: [PATCH 18/25] btrfs: Use readahead_batch_length
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201216182335.27227-1-willy@infradead.org>
 <20201216182335.27227-19-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a5b979d7-1086-fe6c-6e82-f20ecb56d24c@nvidia.com>
Date:   Thu, 17 Dec 2020 01:15:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201216182335.27227-19-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608196511; bh=R8d+cbbN++Nu/JZ/Spif9ERgIOOHw66AVM7XM2f2jHA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=J69MPPJWk8j7pB65gpW8AA5TpJ/a788fkD4dUvEE72a6NPnSq4BlCvo70SCDdPXBl
         FEuy3YBxdv7OBPHkVdMjiWVHRCsuY8svj9NIs+/u6A+0IwyR2omdysyQ1/yWoDjLM5
         cSQtmxfpLEDYN/AKdaYy1KqUuGriJhXmJqiFdoU2Rd7vHVgJBduKeyRClj/8zOIGBe
         8y9PcBdazubCwir8jCdmxFYhflsG6IgwkvQYr23J/xB/T0tGWlpFcitEneNqCoOXK/
         2Cw2majMmD6ZT/ahUy9+7mn4hhqb74gg8w8JBLllaA7jDyHZOtZyGdbxNsZHFtJN3z
         +ThHTRn5nXDRA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/20 10:23 AM, Matthew Wilcox (Oracle) wrote:
> Implement readahead_batch_length() to determine the number of bytes in
> the current batch of readahead pages and use it in btrfs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/btrfs/extent_io.c    | 6 ++----
>   include/linux/pagemap.h | 9 +++++++++
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e3b72e63e42..42936a83a91b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4436,10 +4436,8 @@ void extent_readahead(struct readahead_control *rac)
>   	int nr;
>   
>   	while ((nr = readahead_page_batch(rac, pagepool))) {
> -		u64 contig_start = page_offset(pagepool[0]);
> -		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
> -
> -		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
> +		u64 contig_start = readahead_pos(rac);
> +		u64 contig_end = contig_start + readahead_batch_length(rac);

Something in this tiny change is breaking btrfs: it hangs my Fedora 33 test
system (which changed over to btrfs) on boot. I haven't quite figured out
what's really wrong, but git bisect lands here, *and* turning the whole
extent_readahead() function into a no-op (on top of the whole series)
allows everything to work once again.

Sorry for not actually solving the root cause, but I figured you'd be able
to jump straight to the answer, with the above information, so I'm sending
it out early.


thanks,
-- 
John Hubbard
NVIDIA
