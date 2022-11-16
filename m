Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA762C87B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 19:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiKPS4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 13:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiKPS4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:56:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741463BA3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668624844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrMOrTfFoolcBWY273BC4KVOqyrI8gbytsgZlItRSSY=;
        b=e0HLJWQOrV59rnSGTS6YIVqETW+MetNgrpEQbikp3pa0MOp9YQkUcSBKEy34EwX53rBRFD
        0/8z3cE73sZ2kOYmBtxg+J08kdSPfrx1ndau6dZ1tPvBzgkqWSa2ycA4qZIE6IIlwIjnzj
        IYmDlr5WO9CbNLhnJleRx34142BoDRo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-_125UzpCOi62aaRc4-_EGA-1; Wed, 16 Nov 2022 13:54:02 -0500
X-MC-Unique: _125UzpCOi62aaRc4-_EGA-1
Received: by mail-wr1-f71.google.com with SMTP id n13-20020adf8b0d000000b0023658a75751so4065069wra.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 10:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrMOrTfFoolcBWY273BC4KVOqyrI8gbytsgZlItRSSY=;
        b=F/rbSGBIehP4ZzBUYpQn5Y3h5P92ThkB8eIpMOairmtiNWs8mauYloSSZkfSINBIAy
         tujMSm6WpuF5tFGdItlk14tr54AKTT8CXASnucjk+nhVH8gNyZCWAUMQIJysMum05MF1
         sMhi1RNJFurj5dSFHPXRvpx6c2nfBVpZO1aVVKPs68vyN+lJCySNzNlJWkQ+6F6w+sz8
         n9uSXPArJ0Ldmk7LwKD4f9FG5K6/2+HmIRhxgBmfuIbmfXsTH1AN4UvqlxMQVHtj3xJ1
         g7yDoKzfdXvbLA3aIWxlsPPpYQar96WJlo2itM2tfrsaRzFLRGtSXTuMvoo99a/qTNN8
         OS3g==
X-Gm-Message-State: ANoB5pljcCjOjrghacjd3Ec0rFvRgVGa5DzzNql8cEDXNeYqrwd5IDJt
        LQqdPoPx5G6Tvg9l0G0cMgS+A+7OHEtqN+yWqW+9VcsDR61QgpyX+d4NIP3p80pfWxzLCIgYLit
        jqA5UhrGdgZoItsbAuU0qREchpQ==
X-Received: by 2002:a05:600c:188a:b0:3cf:8e62:f769 with SMTP id x10-20020a05600c188a00b003cf8e62f769mr3135318wmp.52.1668624841275;
        Wed, 16 Nov 2022 10:54:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5DCp6F6fiXltcSvKkMYb+ZcNvwNu+I48re+Q7o+sjDMiBTT1rVi2cU7FL82kIKKDnPvsKEPw==
X-Received: by 2002:a05:600c:188a:b0:3cf:8e62:f769 with SMTP id x10-20020a05600c188a00b003cf8e62f769mr3135302wmp.52.1668624841029;
        Wed, 16 Nov 2022 10:54:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003cff309807esm3012333wmo.23.2022.11.16.10.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 10:54:00 -0800 (PST)
Message-ID: <caf52607-49cd-3073-ca4a-ddce9509e7c9@redhat.com>
Date:   Wed, 16 Nov 2022 19:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
In-Reply-To: <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.11.22 19:16, Linus Torvalds wrote:
> On Wed, Nov 16, 2022 at 2:30 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's make it clearer that functionality provided by FOLL_FORCE is
>> really only for ptrace access.
> 
> I'm not super-happy about this one.
> 
> I do understand the "let's rename the bit so that no new user shows up".
> 
> And it's true that the main traditional use is ptrace.
> 
> But from the patch itself it becomes obvious that no, it's not *just*
> ptrace. At least not yet.
> 
> It's used for get_arg_page(), which uses it to basically look up (and
> install) pages in the newly created VM.
> 
> Now, I'm not entirely sure why it even uses FOLL_FORCE, - I think it
> might be historical, because the target should always be the new stack
> vma.
> 
> Following the history of it is a big of a mess, because there's a
> number of renamings and re-organizations, but it seems to go back to
> 2007 and commit b6a2fea39318 ("mm: variable length argument support").
> 

Right.

> Before that commit, we kept our own array of "this is the set of pages
> that I will install in the new VM". That commit basically just inserts
> the pages directly into the VM instead, getting rid of the array size
> limitation.
> 
> So at a minimum, I think that FOLL_FORCE would need to be removed
> before any renaming to FOLL_PTRACE, because that's not some kind of
> small random case.
> 
> It *might* be as simple as just removing it, but maybe there's some
> reason for having it that I don't immediately see.

Right, I have the same feeling. It might just be a copy-and-paste legacy 
leftover.

> 
> There _are_ also small random cases too, like get_cmdline(). Maybe
> that counts as ptrace, but the execve() case most definitely does not.

I agree. I'd suggest moving forward without this (last) patch for now 
and figuring out how to further cleanup FOLL_FORCE usage on top.

@Andrew, if you intend to put this into mm-unstable, please drop the 
last patch for now.

-- 
Thanks,

David / dhildenb

