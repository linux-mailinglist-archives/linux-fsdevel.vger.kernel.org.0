Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F74C459A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 14:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiBYNNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 08:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiBYNNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:13:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98B4E181E68
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 05:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645794761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5m/jO7lh5udnKQzVaUijMT/vcP8DIr3AnFBCv6X8sA=;
        b=A+whudTHBepKndncnELDJctBP6oue4vB3ufQvbGVHmaOmN0NNDVYUiY70U9rMqGdsgRxP3
        Ehk1454R3uy3G6MRabXy6klxw8OQP0fYbFDUlY1TnHXriHha4Kgyu9/jPlNfaeTupNCJuS
        PreZpfbiNMAyA3fZUXDuGSyiffPuIO0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-8YhFWXRaN_Gi4Exot0wdcQ-1; Fri, 25 Feb 2022 08:12:40 -0500
X-MC-Unique: 8YhFWXRaN_Gi4Exot0wdcQ-1
Received: by mail-wm1-f70.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so1553719wme.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 05:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Q5m/jO7lh5udnKQzVaUijMT/vcP8DIr3AnFBCv6X8sA=;
        b=bPuFzh2SsKa5Xnt2Ex6ws29I8xuui9J0HSMGzKimWDwzgZaEwssUriK7aB6D445n80
         BnsAcjKh45wqE6tdoqMKO9hidWGD6d4RNOmNUfaCSwUlCC5ULjpLuiiEaAOYY0eBENpw
         ocTS672dY2SCzwlwFcqkoDIvoHN72poLz68OMXn911wK89NlG4i9yc07KpQNh19AlzYl
         Jqh+p72xdsiII79HNzUzwgNmub5JjJlzLr1x6XUeM7bTgHeYPnH40Q7vUACtXGPoPLDo
         DoTWeMxLwezGaGRvfypwVJmiwnpTl63pUlDBNIQ6gUS2LweXyfUfQ2pYY0YDBaZiOtac
         vo8Q==
X-Gm-Message-State: AOAM532s/6VtOnG+37EcjYTKxzpP8t7mIW3XkQP6XJRsoHr9hXKB9Cjy
        OnRyTTDyWksNzonNaTr4apEvDPouJ8tW8kHkTaTY3LDPWum3KN2Ux7/TTwT1bIun3W2BdvukZeL
        mV6Tv1qQopjQ+lEBx2Vg7oBn79Q==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr2621766wmo.162.1645794759007;
        Fri, 25 Feb 2022 05:12:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI4b9vBHcOeQt/ZmS1/e52HNSF01bwScuFUG5ZV9CohndqVjI+TJ4cckBrt1RE2I3tNlK5oQ==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr2621744wmo.162.1645794758739;
        Fri, 25 Feb 2022 05:12:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:1900:f2f7:d2ad:80d9:218f? (p200300cbc7061900f2f7d2ad80d9218f.dip0.t-ipconnect.de. [2003:cb:c706:1900:f2f7:d2ad:80d9:218f])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c3b0500b00380da3ac789sm2535021wms.1.2022.02.25.05.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:12:38 -0800 (PST)
Message-ID: <ad29be74-d296-a9fb-41d7-00d2ba15ea5c@redhat.com>
Date:   Fri, 25 Feb 2022 14:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25.02.22 09:50, John Hubbard wrote:
> Hi,
> 
> Summary:
> 
> This puts some prerequisites in place, including a CONFIG parameter,
> making it possible to start converting and testing the Direct IO part of
> each filesystem, from get_user_pages_fast(), to pin_user_pages_fast().
> 
> It will take "a few" kernel releases to get the whole thing done.
> 
> Details:
> 
> As part of fixing the "get_user_pages() + file-backed memory" problem
> [1], and to support various COW-related fixes as well [2], we need to
> convert the Direct IO code from get_user_pages_fast(), to
> pin_user_pages_fast(). Because pin_user_pages*() calls require a
> corresponding call to unpin_user_page(), the conversion is more
> elaborate than just substitution.
> 
> Further complicating the conversion, the block/bio layers get their
> Direct IO pages via iov_iter_get_pages() and iov_iter_get_pages_alloc(),
> each of which has a large number of callers. All of those callers need
> to be audited and changed so that they call unpin_user_page(), rather
> than put_page().

vmsplice is another candidate that uses iov_iter_get_pages() and should
be converted to FOLL_PIN. For that particular user, we have to also pass
FOLL_LONGTERM -- vmsplice as it stands can block memory hotunplug / CMA
/ ... for all eternity.

-- 
Thanks,

David / dhildenb

