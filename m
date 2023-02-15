Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ABF698729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 22:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBOVNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 16:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOVNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12E9EDD
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 13:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676495543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sdUXKXxrfW+mAzuTBhSKEe6d+lBQL+20Mwbq3MLzH8=;
        b=h6So6iBTmvqkZLqSgaE2bERDe0SmIVaiUr7CQx9woMmzAjmXNFuqwudzevV5+QShmxAUEh
        Yf0Sh/F6vBJesIExE1kCB3Rbh5RLDyDT0240UEksu71D9IEqM2ldgBT04+f1Atwr5HWUAz
        hx7SlsM56xTrauAnUEysSpIwXFCj6+g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-frjCRHJgN-q6g5dtZLhk0Q-1; Wed, 15 Feb 2023 16:12:21 -0500
X-MC-Unique: frjCRHJgN-q6g5dtZLhk0Q-1
Received: by mail-io1-f72.google.com with SMTP id z22-20020a5ec916000000b007407d6e01e5so1858708iol.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 13:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sdUXKXxrfW+mAzuTBhSKEe6d+lBQL+20Mwbq3MLzH8=;
        b=5Aqe1DO5/Yy+bnW7CDRANKvTz9a6TOZeYg7dHWnX3DfINn1rUVIATZ0Tvs7yjFlrEa
         bT+2awbDJhfYW9tDxWRsqygE4LSAk0q6Jpnxl/bYLGTI9mFqeAGUOvF2SXq80tN0x4jz
         XX31cq/b+ZcPwkR4wAY+KfDdPFTP62r7G5zXsjMm8TZOxwSddF36sLSH6bRFy40lu9Wr
         W7kuieDDauHS6tCswW7cvMAuuXWyJ1Nn3dRw/1MgusH2oNg8Orhxpk4oBa9A3bV2Yifa
         5EbVfB6catWqLcRKN1rsn30Xwl0SvTOG+sC812FaMtEBo4FlbpBaZiE2mRXrMHT+Yy3e
         gw/g==
X-Gm-Message-State: AO0yUKVjjjXLltZcHPdOzr/DTHx+aVVfD4IheDoyPxvYyG5Wxo5SmOgm
        0tPnwlUR5JaAzlHHoIBVTesO8EA+6BMYAbH4uNRPWLQxweJ+pww1wgUOeSU6Fvxf6qfQgj735B5
        4jID0lNSicsL8VwCSFJQ+00DBbA==
X-Received: by 2002:a05:6e02:180a:b0:314:1579:be2c with SMTP id a10-20020a056e02180a00b003141579be2cmr3158031ilv.0.1676495540765;
        Wed, 15 Feb 2023 13:12:20 -0800 (PST)
X-Google-Smtp-Source: AK7set9YvaTULu4TJGwUvbRrKZO6FUCyDczd5c1ykfW4fd3xdBJS63A1AOfZuvkOfpTEmmxuCSkuUA==
X-Received: by 2002:a05:6e02:180a:b0:314:1579:be2c with SMTP id a10-20020a056e02180a00b003141579be2cmr3157998ilv.0.1676495540462;
        Wed, 15 Feb 2023 13:12:20 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f3-20020a02b783000000b003b1d7fbf810sm1542836jam.148.2023.02.15.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:12:19 -0800 (PST)
Date:   Wed, 15 Feb 2023 16:12:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y+1KsQSYPYO/egvt@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <Y+QfDN4Y5Q10x8GQ@x1n>
 <8b2959fb-2a74-0a1f-8833-0b18eab142dc@collabora.com>
 <Y+qur8iIUQTLyE8f@x1n>
 <39217d9a-ed7e-f1ff-59b9-4cbffa464999@collabora.com>
 <Y+v2HJ8+3i/KzDBu@x1n>
 <884f5aa6-5d12-eecc-ed71-7d653828ca20@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <884f5aa6-5d12-eecc-ed71-7d653828ca20@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:03:09PM +0500, Muhammad Usama Anjum wrote:
> On 2/15/23 1:59 AM, Peter Xu wrote:
> [..]
> >>>> static inline bool is_pte_written(pte_t pte)
> >>>> {
> >>>> 	if ((pte_present(pte) && pte_uffd_wp(pte)) ||
> >>>> 	    (pte_swp_uffd_wp_any(pte)))
> >>>> 		return false;
> >>>> 	return (pte_present(pte) || is_swap_pte(pte));
> >>>> }
> >>>
> >>> Could you explain why you don't want to return dirty for !present?  A page
> >>> can be written then swapped out.  Don't you want to know that happened
> >>> (from dirty tracking POV)?
> >>>
> >>> The code looks weird to me too..  We only have three types of ptes: (1)
> >>> present, (2) swap, (3) none.
> >>>
> >>> Then, "(pte_present() || is_swap_pte())" is the same as !pte_none().  Is
> >>> that what you're really looking for?
> >> Yes, this is what I've been trying to do. I'll use !pte_none() to make it
> >> simpler.
> > 
> > Ah I think I see what you wanted to do now.. But I'm afraid it won't work
> > for all cases.
> > 
> > So IIUC the problem is anon pte can be empty, but since uffd-wp bit doesn't
> > persist on anon (but none) ptes, then we got it lost and we cannot identify
> > it from pages being written.  Your solution will solve problem for
> > anonymous, but I think it'll break file memories.
> > 
> > Example:
> > 
> > Consider one shmem page that got mapped, write protected (using UFFDIO_WP
> > ioctl), written again (removing uffd-wp bit automatically), then zapped.
> > The pte will be pte_none() but it's actually written, afaiu.
> > 
> > Maybe it's time we should introduce UFFD_FEATURE_WP_ZEROPAGE, so we'll need
> > to install pte markers for anonymous too (then it will work similarly like
> > shmem/hugetlbfs, that we'll report writting to zero pages), then you'll
> > need to have the new UFFD_FEATURE_WP_ASYNC depend on it.  With that I think
> > you can keep using the old check and it should start to work.
> > 
> > Please let me know if my understanding is correct above.
> Thank you for identifying it. Your understanding seems on point. I'll have
> research things up about PTE Markers. I'm looking at your patches about it
> [1]. Can you refer me to "mm alignment sessions" discussion in form of
> presentation or if any transcript is available?

No worry now, after a second thought I think zero page is better than pte
markers, and I've got a patch that works for it here by injecting zero
pages for anonymous:

https://lore.kernel.org/all/20230215210257.224243-1-peterx@redhat.com/

I think we'd also better to enforce your new WP_ASYNC feature bit to depend
on this one, so fail the UFFDIO_API if WP_ASYNC && !WP_ZEROPAGE.

Could you please try by rebasing your work upon this one?  Hope it'll work
for you already.  Note again that you'll need to go back to the old
is_pte|pmd_written() to make things work always, I think.

[...]

> I truly understand how you feel about export_prev_to_out(). It is really
> difficult to understand. Even I had to made a hard try to come up with the
> current code to avoid consuming a lot of kernel's memory while giving user
> the compact output. I can surely map both of these with a dirty looking
> macro. But I'm unable to find a decent macro to replace these. I think I'll
> put a comment some where to explain whats going-on.

So maybe I still missed something? I'll read the new version when it comes.

Thanks,

-- 
Peter Xu

