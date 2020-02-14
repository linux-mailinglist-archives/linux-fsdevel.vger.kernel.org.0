Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F345315D108
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 05:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgBNEdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 23:33:25 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4698 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgBNEdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:33:25 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4622f70001>; Thu, 13 Feb 2020 20:32:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Feb 2020 20:33:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Feb 2020 20:33:24 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 04:33:23 +0000
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
 <e0f459af-bb5d-58b9-78be-5adf687477c0@nvidia.com>
 <20200214042137.GX7778@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ab9d0e43-3fb4-cb14-4974-ad4a8ab57a83@nvidia.com>
Date:   Thu, 13 Feb 2020 20:33:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214042137.GX7778@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581654775; bh=5Ey5GwVWyIBJt/+/393UO7Nx1GdweRJOgsCbjE7KjIY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NkFTEsbm+clHOSZCX0RL5RspOQeT9W3sLbBgRbLhccmBpDH8wbMqpmqavt71lE50T
         W0r4zoHadn/onXtCLtu33Jw1Lnyb1YLti6uKH/Lqwf3oKwHkMffvnhuXXDp4172iVb
         4JyT1BsemqkZI0x+rarEzerLgE4K30Jj4Akyi8ysj6gTn3vHY411VUJmo07oEAtkVb
         F3culDDOf6MNtFaLukiw3rjiqUenq4Bmkyg4nv/QsS2hRa5xNWUMGZeZaUGVNkKf9z
         beXaG1Dega77Ip/IbGAbpMTTVOuKI2MlLNC56slZlFuJWg4VS8NUVScDIxpxkukqfs
         g+TKG5YT2eP6A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/20 8:21 PM, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 07:19:53PM -0800, John Hubbard wrote:
>> On 2/10/20 5:03 PM, Matthew Wilcox wrote:
>>> @@ -161,7 +161,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
>>>  	unsigned long end_index;	/* The last page we want to read */
>>>  	LIST_HEAD(page_pool);
>>>  	int page_idx;
>>
>>
>> What about page_idx, too? It should also have the same data type as nr_pages, as long as
>> we're trying to be consistent on this point.
>>
>> Just want to ensure we're ready to handle those 2^33+ page readaheads... :)
> 
> Nah, this is just a type used internally to the function.  Getting the
> API right for the callers is the important part.
> 

Agreed that the real point of this is to match up the API, but why not finish the job
by going all the way through? It's certainly not something we need to lose sleep over,
but it does seem like you don't want to have code like this:

        for (page_idx = 0; page_idx < nr_to_read; page_idx++) {

...with the ability, technically, to overflow page_idx due to it being an int,
while nr_to_read is an unsigned long. (And the new sanitizers and checkers are
apt to complain about it, btw.)

(Apologies if there is some kernel coding idiom that I still haven't learned, about this 
sort of thing.)

thanks,
-- 
John Hubbard
NVIDIA
