Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8719058FC26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiHKM2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHKM2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:28:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917708E984
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 05:28:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a89so22750283edf.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3MRcVxkQskaoR9Gu8vTdfe3SAmvath2jQNxcSxuvW1Y=;
        b=NHGbxl9pUrdbk/qb8xkMm4zoxhQhX6Rs444HQVekSH5HLue8co3CqoPnGbERLio2dM
         LGx24QotE4kcbcEEhmgdmUCglkMRj9LUgkSP/KpiNA700mP6h94Dn1d/wFOg8IXrTV5Q
         7t8086tWE8qBuYhtW+ve33VVpMjT6RO9u3JV6fo+OXTJ5nEqqLqt5Xfar1N/31vDl+kb
         /Qc9CeYpCrRSPvgdT5jKrAYi+Bis7pm8rvEJBRuOqCqT9rTRlL5ZiL661wC2BrmdE5CH
         +f94perJ/2Z6mBI0Mqi+Tsy+mMxy6HBFjWyJQNFav6rilu1dhdspBsJwb60836MPgNiY
         wunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3MRcVxkQskaoR9Gu8vTdfe3SAmvath2jQNxcSxuvW1Y=;
        b=7+D1h1uq8em4vUIC087P7xEyY60JZM5xulhEOmT/ENVYbfGvPagGQ2av4HDX20D4Tv
         V0V1L7ovx7WWZN6GW4y6HYjze3dtbkPOm0JzDgkFQT6lQOHdRGX4/AMKP/WHGG4zS3+3
         6z3W7S+qgEx79blNGyX7alcA0tKjVq66aRN4eo5OEChBi8MOe0sYrO9mS0zQd3a9XFSg
         CnC8QKHYNxCmuUwfMt6LATmbhwmlf1TnMtoNNjSSIm2e5HApi7LP1hOK5Zmf2x/f4zBl
         auLs82+LWkX3IAmD/JUcWTt2UzI8Y5ORhadVHCuVrQns2vJz8HlKU3eiWscklqYuib/u
         m31g==
X-Gm-Message-State: ACgBeo0JEYmSydGVxM8bqe8E/36+V+5LhyJpClP5UIxyyHWWpyO+M3oG
        s/dv5rnkz+POsLNVhvLGnDcjlQ==
X-Google-Smtp-Source: AA6agR6+Oii1v3EbiMDbdYw7/ayqCsy6sGwTAVm4xglPzXzpkb8k3QGndmL9Qe4QpGf4syQIGgATXw==
X-Received: by 2002:a05:6402:3583:b0:43d:6943:44a with SMTP id y3-20020a056402358300b0043d6943044amr30188049edc.409.1660220881001;
        Thu, 11 Aug 2022 05:28:01 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906381400b007307d099ed7sm3440458ejc.121.2022.08.11.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 05:27:59 -0700 (PDT)
Date:   Thu, 11 Aug 2022 12:27:56 +0000
From:   Quentin Perret <qperret@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Michael Roth <michael.roth@amd.com>,
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v7 03/14] mm: Introduce memfile_notifier
Message-ID: <YvT1zOQtTQl2t300@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
 <13394075-fca0-6f2b-92a2-f1291fcec9a3@redhat.com>
 <20220810092232.GC862421@chaop.bj.intel.com>
 <00f1aa03-bc82-ffce-569b-e2d5c459992c@redhat.com>
 <YvPC87FMgF7uac7z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvPC87FMgF7uac7z@google.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC Fuad

On Wednesday 10 Aug 2022 at 14:38:43 (+0000), Sean Christopherson wrote:
> > I understand Sean's suggestion about abstracting, but if the new name
> > makes it harder to grasp and there isn't really an alternative to memfd
> > in sight, I'm not so sure I enjoy the tried abstraction here.
> 
> ARM's pKVM implementation is potentially (hopefully) going to switch to this API
> (as a consumer) sooner than later.  If they anticipate being able to use memfd,
> then there's unlikely to be a second backing type any time soon.
> 
> Quentin, Will?

Yep, Fuad is currently trying to port the pKVM mm stuff on top of this
series to see how well it fits, so stay tuned. I think there is still
some room for discussion around page conversions (private->shared etc),
and we'll need a clearer idea of what the code might look like to have a
constructive discussion, but so far it does seem like using a memfd (the
new private one or perhaps just memfd_secret, to be discussed) + memfd
notifiers is a promising option.
