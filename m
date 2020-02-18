Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB69B1636A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 00:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBRXAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 18:00:15 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5883 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRXAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:00:14 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c6c6f0000>; Tue, 18 Feb 2020 14:59:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 15:00:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Feb 2020 15:00:13 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 23:00:13 +0000
Subject: Re: [PATCH v6 04/16] mm: Tweak readahead loop slightly
From:   John Hubbard <jhubbard@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-6-willy@infradead.org>
 <7691abe7-d0e9-e091-b158-764fb624c2d7@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <cf7c9f73-ea15-24a5-2b97-388164a581ef@nvidia.com>
Date:   Tue, 18 Feb 2020 15:00:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7691abe7-d0e9-e091-b158-764fb624c2d7@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582066800; bh=IB7kCRmqWHOCgH5gvEJMi5Ucod9FJFELOexbDWiq5WM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W3IJqlJox7bQX9XTPoXwA3Jm6LhlHKJW+mAhVNPdcUggDXvirw1BsO/uwsxWZ+7uS
         HOOter52f4A4hAaPodlY7f0GW7DAaw2gYdUynWMuU/ILsZ4VQHwSB4sSV1XGIKIA1A
         II9rNVEbC3tSkSbIrmRnLlFSPi3rJAn0dkG/YfARpEmDHSprmsPvxbe3KwU65uSj8y
         C3+FXfpxW4WIejSQ4+P4rtEccN3mioAXj3gOw9uQ19e5wS/+Cgx/Bb4Am7uQzPhoVD
         I7pTDe0JMynA0Ndr5M6yG+B/RUQjl0P9V/TbFUVySKOwDQKwJXGqsxl0tiggBN1WNv
         28HLo+ojFyGyw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/20 2:57 PM, John Hubbard wrote:
> On 2/17/20 10:45 AM, Matthew Wilcox wrote:
>> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>
>> Eliminate the page_offset variable which was just confusing;
>> record the start of each consecutive run of pages in the
> 
> 

Darn it, I incorrectly reviewed the N/16 patch, instead of the N/19, for 
this one. I thought I had deleted all those! Let me try again with the
correct patch, sorry!!

thanks,
-- 
John Hubbard
NVIDIA

> OK...presumably for the benefit of a following patch, since it is not 
> actually consumed in this patch.
> 
>> readahead_control, and move the 'kick off a fresh batch' code to
>> the end of the function for easier use in the next patch.
> 
> 
> That last bit was actually done in the previous patch, rather than this
> one, right?
> 
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>  mm/readahead.c | 31 +++++++++++++++++++------------
>>  1 file changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/readahead.c b/mm/readahead.c
>> index 15329309231f..74791b96013f 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -154,7 +154,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
>>  		unsigned long lookahead_size)
>>  {
>>  	struct inode *inode = mapping->host;
>> -	struct page *page;
>>  	unsigned long end_index;	/* The last page we want to read */
>>  	LIST_HEAD(page_pool);
>>  	int page_idx;
>> @@ -163,6 +162,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>>  	struct readahead_control rac = {
>>  		.mapping = mapping,
>>  		.file = filp,
>> +		._start = offset,
>>  		._nr_pages = 0,
>>  	};
>>  
>> @@ -175,32 +175,39 @@ void __do_page_cache_readahead(struct address_space *mapping,
>>  	 * Preallocate as many pages as we will need.
>>  	 */
>>  	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
>> -		pgoff_t page_offset = offset + page_idx;
> 
> 
> You know...this ends up incrementing offset each time through the
> loop, so yes, the behavior is the same as when using "offset + page_idx".
> However, now it's a little harder to see that.
> 
> IMHO the page_offset variable is not actually a bad thing, here. I'd rather
> keep it, all other things being equal (and I don't see any other benefits
> here: line count is the same, for example).
> 
> What do you think?
> 
> 
> thanks,
> 
