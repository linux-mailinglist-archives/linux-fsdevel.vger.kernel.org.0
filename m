Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6DC163B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBSDYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:24:46 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16425 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgBSDYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:24:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4caa370000>; Tue, 18 Feb 2020 19:23:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 19:24:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Feb 2020 19:24:46 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 03:24:45 +0000
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
 <20200219010209.GI24185@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ecd11199-4f0d-a59b-6172-feea0cb5fd29@nvidia.com>
Date:   Tue, 18 Feb 2020 19:24:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219010209.GI24185@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582082615; bh=ZlagFYC7xJwJLLO9AWUODeIShplyyORjVfFAOxTHQbA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UT3JHa9GumLgpABiUIYS6tLJDf3T0qe2BkLDiRHe+ga+cBFPusc4s18OsMU/jLBlX
         E0NSDh7Wn3KmDNpXg+BOI8lgzx9nuhlOISv7Q+A953Wjg9k/Zip3jhxQxFwxXrhrTe
         mlzaTkOvirZ1Dkj3aIXO2/ZqisJThErxhVI/lGBx6uo30YWSEpJjJbA16XPG9BlUce
         E3OEkzQk82BcTRY/VG+SWUggGD+iAn6jEAnm7mW6H40rjA32wi90YTYCvMNdy0ZikV
         ycz4GiE2GTViYC1vPo+1mK6ZrNv30Kr16tydwj5IHm3yOemZstl28tkGDlc3/UIRIS
         mLk08n5euWN9Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/20 5:02 PM, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 04:01:43PM -0800, John Hubbard wrote:
>> How about this instead? It uses the "for" loop fully and more naturally,
>> and is easier to read. And it does the same thing:
>>
>> static inline struct page *readahead_page(struct readahead_control *rac)
>> {
>> 	struct page *page;
>>
>> 	if (!rac->_nr_pages)
>> 		return NULL;
>>
>> 	page = xa_load(&rac->mapping->i_pages, rac->_start);
>> 	VM_BUG_ON_PAGE(!PageLocked(page), page);
>> 	rac->_batch_count = hpage_nr_pages(page);
>>
>> 	return page;
>> }
>>
>> static inline struct page *readahead_next(struct readahead_control *rac)
>> {
>> 	rac->_nr_pages -= rac->_batch_count;
>> 	rac->_start += rac->_batch_count;
>>
>> 	return readahead_page(rac);
>> }
>>
>> #define readahead_for_each(rac, page)			\
>> 	for (page = readahead_page(rac); page != NULL;	\
>> 	     page = readahead_page(rac))
> 
> I'm assuming you mean 'page = readahead_next(rac)' on that second line.
> 
> If you keep reading all the way to the penultimate patch, it won't work
> for iomap ... at least not in the same way.
> 

OK, so after an initial look at patch 18's ("iomap: Convert from readpages to
readahead") use of readahead_page() and readahead_next(), I'm not sure what 
I'm missing. Seems like it would work...?

thanks,
-- 
John Hubbard
NVIDIA

