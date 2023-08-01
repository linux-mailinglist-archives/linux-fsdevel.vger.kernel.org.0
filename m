Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5276B96C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjHAQIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjHAQIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67395DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690906045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWOPkGc2VQ+gyDNVe+LM0eiFFyEn/D0a9ZnSdC5vf9I=;
        b=LujBYkGp7N0remQ0v3PNI7Bs6S40YgFAts4o3lkeHrnPveT5KIG8wO2nvXEszMEviib0GN
        6OUErY/JQv6GHQb/NTnA5HRl6P0WKuj8SrMa6wwddxCkcG2P3VMgnqEedDsJJnBzT6Q2o+
        ChY3Pdn0NWFfBiYybZOLlsYgLJj2Ht0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-nGJEbwPQPOmbnWGN5gYKlA-1; Tue, 01 Aug 2023 12:07:24 -0400
X-MC-Unique: nGJEbwPQPOmbnWGN5gYKlA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cb9958d60so38541985a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906044; x=1691510844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWOPkGc2VQ+gyDNVe+LM0eiFFyEn/D0a9ZnSdC5vf9I=;
        b=IxXrnVVtpwwkA6ySlgQ5DS6gZ05QkErzCFH4jZyX2WPIN6UKEDlred9pRYwuZZaho0
         IzSeFdQmRMpw56zWERxi2aodXDScXngGazxsGIlMTah0cmcIn993mfPUjNCvSiepu9rF
         tGmjSjzqWNi9oud5W0qm9t2DhdRi0sC4Jc2iKvI683T7dU5XKhZfmQWl71I4EdFVMuz2
         SX1EjP+uZrYWuof6u8uco+vnFWfh40MA0Dsss0FAAT1jDOw2/EgpGuVhWZkGmhGKHudk
         L6wAKqEB8QLjy1k1JLfHFb10o1xhDsWvMQ90kWaZo4TguMcDjAhzYj2DHrrfM6NM91Gr
         SmGA==
X-Gm-Message-State: ABy/qLb67NxTgKfPbBA4FFLMCUBjzfGGPljMHhnhqr6+xT7FBaiznKVo
        nj+XZhx9UUEVjpgTVikqVMDH2+Yd0MY+ACgjiHu8qtgWgT/r8zo+o29tbk59JB78s/n/3ZLWh41
        mqRwtbnWJvmOGNepd3//tSGJCOxIBs3FCfg==
X-Received: by 2002:a05:620a:461f:b0:767:170d:887a with SMTP id br31-20020a05620a461f00b00767170d887amr11729619qkb.2.1690906043919;
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqB7mU+Qbt0x6u8wDG4VYEiiNsMIxzWprLKmcc5Zc3mCLE/Anc8W8CylOrTkOpU586dh/Caw==
X-Received: by 2002:a05:620a:461f:b0:767:170d:887a with SMTP id br31-20020a05620a461f00b00767170d887amr11729595qkb.2.1690906043654;
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z5-20020a05620a100500b00767cf5d3faasm4237042qkj.86.2023.08.01.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:07:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/8] mm/huge_memory: remove stale NUMA hinting comment
 from follow_trans_huge_pmd()
Message-ID: <ZMktuATuYhHdAW6M@x1n>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-7-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:42PM +0200, David Hildenbrand wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2cd3e5502180..0b709d2c46c6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1467,7 +1467,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
>  		return ERR_PTR(-EFAULT);
>  
> -	/* Full NUMA hinting faults to serialise migration in fault paths */
>  	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
>  		return NULL;

Perhaps squashing into patch 1?  Thanks,

-- 
Peter Xu

