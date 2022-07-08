Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A056F56B078
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 04:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiGHCKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 22:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGHCKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1256127B13
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 19:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657246233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dU9A2avEK606Jj03n4kL2Q5OK9t21ZDX8JhQ48AEgE4=;
        b=i0gYeQh96LxpCJ+JQdJXfYyw1jMkHFOj+WPMEmS1z4wOraktAgO0h+w8z+ECW2WImImsq1
        BfPuWBLbA3qZZw9OEPyhanyoZ7WMchibgIs9/NLW2Xkp7ya5lKrdqVua9sizEB3WucPIlP
        y1BgvMYTBhUct+y9YwoD7nqi5JHh6RE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-EN7EGCKuMyqsEQ_uLEE_Fg-1; Thu, 07 Jul 2022 22:10:32 -0400
X-MC-Unique: EN7EGCKuMyqsEQ_uLEE_Fg-1
Received: by mail-pl1-f197.google.com with SMTP id c16-20020a170902b69000b0016a71a49c0cso9513380pls.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 19:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dU9A2avEK606Jj03n4kL2Q5OK9t21ZDX8JhQ48AEgE4=;
        b=0DqhgGnLlGGcvWCAShK2P2yUEGuKt8ePoL46Mbru2hp0i4gZZ/N6Wo0rc8b5nDyuC1
         mFSuvqFrnGHsoMbIAPKmLlYRjnmPB5XUEW4C5CiFkvsCfOtca1l9d+MtMwIumyK8XN1i
         0LbalK7DA2Y7Q/Slwv2oJDIb6wcvuHvk0pQGU91gtMlAsT3bQo3qiydhQe4a7WYLI1d3
         KE6Yw/NyT4lCzEkkLf1kpQYOB9bJFYAYWE2O61BcqwDBVfBQ2oi47bHwNV7S0FhzmDof
         y0rYrhv2HC4OA47vbYajHnFvRHfd3RLSoE/tFJw+OrxsmFAOmWFXPLbnnV7ZR6kyDBSh
         h8Wg==
X-Gm-Message-State: AJIora/f2lSmv/e8WygMAJlGYWYwzXO8oE1kJZ7byJJ32A+lt5Uq48PD
        HFUK8Ix2Bqk7Ru2o9/J90kOaWlL1ojrcqbvkanCRwgoyos720Fm/Hg73r7pt9W93XwZHmA1x5/s
        NHt5iNd8EVKo5+D5moBJOEgUimaFKXDpz4cnCl69ItEmek6AbOzcCD8LtNd6RJ1yMTzB9ZnoLK7
        s=
X-Received: by 2002:a17:902:ea0a:b0:168:d8ce:4a63 with SMTP id s10-20020a170902ea0a00b00168d8ce4a63mr1010433plg.57.1657246231083;
        Thu, 07 Jul 2022 19:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRrqHMf04Yy/AxvDAOr3pzYJdnpIz5SNscixvcqcWBgR5bFz6YnY1eOtijvJP6uy/Y1BeCvQ==
X-Received: by 2002:a17:902:ea0a:b0:168:d8ce:4a63 with SMTP id s10-20020a170902ea0a00b00168d8ce4a63mr1010398plg.57.1657246230689;
        Thu, 07 Jul 2022 19:10:30 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0051c1b445094sm27909386pfj.7.2022.07.07.19.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 19:10:30 -0700 (PDT)
Subject: Re: [RFC] Convert ceph_page_mkwrite to use a folio
To:     Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YsbzAoGAAZtlxsrd@casper.infradead.org>
 <763ba47fb850282b62c36eca6084c446a0952336.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <10ae8106-d86c-053d-f8d8-b9a0eca77b01@redhat.com>
Date:   Fri, 8 Jul 2022 10:10:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <763ba47fb850282b62c36eca6084c446a0952336.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/8/22 1:48 AM, Jeff Layton wrote:
> On Thu, 2022-07-07 at 15:51 +0100, Matthew Wilcox wrote:
>> There are some latent bugs that I fix here (eg, you can't call
>> thp_size() on a tail page), but the real question is how Ceph in
>> particular (and FS in general) want to handle mkwrite in a world
>> of multi-page folios.
>>
>> If we have a multi-page folio which is occupying an entire PMD, then
>> no question, we have to mark all 2MB (or whatever) as dirty.  But
>> if it's being mapped with PTEs, either because it's mapped misaligned,
>> or it's smaller than a PMD, then we have a choice.  We can either
>> work in 4kB chunks, marking each one dirty (and storing the sub-folio
>> dirty state in the fs private data) like a write might.  Or we can
>> just say "Hey, the whole folio is dirty now" and not try to track
>> dirtiness on a per-page granularity.
>>
>> The latter course seems to have been taken, modulo the bugs, but I
>> don't know if any thought was taken or whether it was done by rote.
>>
> Done by rote, I'm pretty sure.
>
> If each individual page retains its own dirty bit, what does
> folio_test_dirty return when its pages are only partially dirty? I guess
> the folio is still dirty even if some of its pages are clean?
>
> Ceph can do a vectored write if a folio has disjoint dirty regions that
> we need to flush. Hashing out an API to handle that with the netfs layer
> is going to be "interesting" though.

Yeah, sounds reasonable to me.


>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 6dee88815491..fb346b929f65 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -1503,8 +1503,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>>   	struct ceph_inode_info *ci = ceph_inode(inode);
>>   	struct ceph_file_info *fi = vma->vm_file->private_data;
>>   	struct ceph_cap_flush *prealloc_cf;
>> -	struct page *page = vmf->page;
>> -	loff_t off = page_offset(page);
>> +	struct folio *folio = page_folio(vmf->page);
>> +	loff_t pos = folio_pos(folio);
>>   	loff_t size = i_size_read(inode);
>>   	size_t len;
>>   	int want, got, err;
>> @@ -1521,50 +1521,50 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>>   	sb_start_pagefault(inode->i_sb);
>>   	ceph_block_sigs(&oldset);
>>   
>> -	if (off + thp_size(page) <= size)
>> -		len = thp_size(page);
>> +	if (pos + folio_size(folio) <= size)
>> +		len = folio_size(folio);
>>   	else
>> -		len = offset_in_thp(page, size);
>> +		len = offset_in_folio(folio, size);
>>   
>>   	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
>> -	     inode, ceph_vinop(inode), off, len, size);
>> +	     inode, ceph_vinop(inode), pos, len, size);
>>   	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>>   		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
>>   	else
>>   		want = CEPH_CAP_FILE_BUFFER;
>>   
>>   	got = 0;
>> -	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, &got);
>> +	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, pos + len, &got);
>>   	if (err < 0)
>>   		goto out_free;
>>   
>>   	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
>> -	     inode, off, len, ceph_cap_string(got));
>> +	     inode, pos, len, ceph_cap_string(got));
>>   
>> -	/* Update time before taking page lock */
>> +	/* Update time before taking folio lock */
>>   	file_update_time(vma->vm_file);
>>   	inode_inc_iversion_raw(inode);
>>   
>>   	do {
>>   		struct ceph_snap_context *snapc;
>>   
>> -		lock_page(page);
>> +		folio_lock(folio);
>>   
>> -		if (page_mkwrite_check_truncate(page, inode) < 0) {
>> -			unlock_page(page);
>> +		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
>> +			folio_unlock(folio);
>>   			ret = VM_FAULT_NOPAGE;
>>   			break;
>>   		}
>>   
>> -		snapc = ceph_find_incompatible(page);
>> +		snapc = ceph_find_incompatible(&folio->page);
>>   		if (!snapc) {
>> -			/* success.  we'll keep the page locked. */
>> -			set_page_dirty(page);
>> +			/* success.  we'll keep the folio locked. */
>> +			folio_mark_dirty(folio);
>>   			ret = VM_FAULT_LOCKED;
>>   			break;
>>   		}
>>   
>> -		unlock_page(page);
>> +		folio_unlock(folio);
>>   
>>   		if (IS_ERR(snapc)) {
>>   			ret = VM_FAULT_SIGBUS;
>> @@ -1588,7 +1588,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>>   	}
>>   
>>   	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
>> -	     inode, off, len, ceph_cap_string(got), ret);
>> +	     inode, pos, len, ceph_cap_string(got), ret);
>>   	ceph_put_cap_refs_async(ci, got);
>>   out_free:
>>   	ceph_restore_sigs(&oldset);

