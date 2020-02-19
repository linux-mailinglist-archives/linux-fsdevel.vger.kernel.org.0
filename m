Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1DA163919
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 02:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBSBNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 20:13:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9710 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgBSBNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:13:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c8b5e0000>; Tue, 18 Feb 2020 17:11:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 17:13:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 17:13:09 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 01:13:09 +0000
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
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <61bcaa87-91b2-857b-350a-86dab81a1f13@nvidia.com>
Date:   Tue, 18 Feb 2020 17:13:08 -0800
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
        t=1582074718; bh=169bBczyyFHIG/Q8UwlECaKiABa8QJEvrDhzzb+cU00=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=U8FaG0b00obFZSv859L8oWEaaOcwQeUfDVqSWQFkBUZBOwH8vbuoD4N7mPb4ZFtWF
         66/vGL4h4APgHKYjB8OgTdyZD1sLYo/MuGcyMep47kybExxzp1I/HCoaNBtiZxm2fS
         z+CWh0MSAuooR6vk29dw1BMTJOJvxutR9mbmjwbxN3WnaOY/L50yURHxsLJObLpMQU
         Ye+mwSNNOhmkQv3gZWRZzP6kLA76Kaff/6vAmGV/UaA/UAx4frrOHDuI7u/Oh55/eT
         2fQWmlP0+bY+bGivsDqexntMqk58H3NzVgP/QqVhoTlnPJM3AeBJTvYVT4g9z/6mYr
         7MuMCGqKPcA/Q==
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


Yep. :)


> 
> If you keep reading all the way to the penultimate patch, it won't work
> for iomap ... at least not in the same way.
> 

OK, getting there...


thanks,
-- 
John Hubbard
NVIDIA
