Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410ED3876D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348630AbhERKqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:46:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348114AbhERKqt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F7C6AFBD;
        Tue, 18 May 2021 10:45:24 +0000 (UTC)
Subject: Re: [PATCH v10 22/33] mm/filemap: Add __folio_lock_or_retry
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-23-willy@infradead.org>
 <76184de4-4ab9-0f04-ab37-8637f4b22566@suse.cz>
Message-ID: <ccd527b4-de71-82a6-d86a-2d3abc75d2b9@suse.cz>
Date:   Tue, 18 May 2021 12:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <76184de4-4ab9-0f04-ab37-8637f4b22566@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/21 12:38 PM, Vlastimil Babka wrote:
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -1623,20 +1623,18 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>>  
>>  /*
>>   * Return values:
>> - * 1 - page is locked; mmap_lock is still held.
>> - * 0 - page is not locked.
>> + * 1 - folio is locked; mmap_lock is still held.
>> + * 0 - folio is not locked.
>>   *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
>>   *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
>>   *     which case mmap_lock is still held.
>>   *
>>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1
>> - * with the page locked and the mmap_lock unperturbed.
>> + * with the folio locked and the mmap_lock unperturbed.
>>   */
>> -int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>> +int __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>>  			 unsigned int flags)
>>  {
>> -	struct folio *folio = page_folio(page);
>> -
>>  	if (fault_flag_allow_retry_first(flags)) {
>>  		/*
>>  		 * CAUTION! In this case, mmap_lock is not released
> 
> A bit later in this branch, 'page' is accessed, but it no longer exists. And
> thus as expected, it doesn't compile. Assuming it's fixed later, but
> bisectability etc...

Also, the switch from 'page' to &folio->page in there should probably have been
done already in "[PATCH v10 20/33] mm/filemap: Add folio_lock_killable", not in
this patch?
