Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687B45ED0FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 01:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiI0XXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiI0XXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:23:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266C1DF30
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 16:23:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 3so10742143pga.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4MnMVs6E8JaSDSsn99y8Cflsak9Vn4oCEKVAnOpimrc=;
        b=KTBy7fQLQX03opurQqZ2U9ctULmybQ5FJUoo4PZb+gpAETjrkid149E9fk/0W8/73E
         ZrwvTRfgroj/9bgiZZ8XJyKrd78XrYX2iQYAUldEdxqL5OZpVAi1zS9yu8prYMHVa77l
         4zjeo6ZBuAJWWGf1zHyMcSzUGInYNji/wPL8fWTGb5gG2xdIaqbbpro066Nv0icVdUH8
         qi08NfiTgaHr/ClJbZ6TR3Yy/OpgSs603ryzzPCdNeTU5ylFZxeFY2UaHzVWoEaEC5jr
         gHQ/fgp9BIfxbbHrCGK8KR3V4hCHTuvinL4qrNVOIDHv67EUocIGa2CUS0dDgpDBgy9Q
         85BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4MnMVs6E8JaSDSsn99y8Cflsak9Vn4oCEKVAnOpimrc=;
        b=e1lYVi36FCq2wnAgPdjYQ82XyOAMbHNo5gEvs7qdLZuTdJL58CURpbQh5AX1h6GPmi
         grR+JP8+hizi/JqlcUeKIr9JieoDEncBt77x1s1e3AmXb5n745rQXxGyIrjiSoTpWI3Y
         Dh0HiAW4vjuoptuCFOycJWdaNnYIDc+FvU7Q2t6XmXQ0f6pK1KOsfZLXCDhTRdbIUUU4
         1f2YnUmevL51h296mE9Sof/qAzlGXGMIwyPILf5hpjGdp1ul5blbQPXcJ8c1GJvJAzmG
         TL6ChNyFJikKWnwsargsFKCFXc9gXnPWwP8AYDAHeELqn4SNT/cs3dw/c2/eRXMaWQPA
         gItQ==
X-Gm-Message-State: ACrzQf2C5spHtuMI6Yr2MVpPq3HqD1Ki9xIcaz6V0sFJZL0k5X38zPJy
        QqOjwbRFSJDe3jG9/aL8Q6I7/Q==
X-Google-Smtp-Source: AMsMyM5cCdZ/UJFMHAs5b3PS1i/34zTcpqdwe1Srr8AE4gzK5DkIpIp9pBozWLBz/E9ieWU+3YHPog==
X-Received: by 2002:a05:6a00:124f:b0:542:6c43:5be8 with SMTP id u15-20020a056a00124f00b005426c435be8mr31885111pfi.5.1664321009101;
        Tue, 27 Sep 2022 16:23:29 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a318100b002007b60e288sm58733pjb.23.2022.09.27.16.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:23:28 -0700 (PDT)
Date:   Tue, 27 Sep 2022 23:23:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <YzOF7MT15nfBX0Ma@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <20220923005808.vfltoecttoatgw5o@box.shutemov.name>
 <f703e615-3b75-96a2-fb48-2fefd8a2069b@redhat.com>
 <20220926144854.dyiacztlpx4fkjs5@box.shutemov.name>
 <0a99aa24-599c-cc60-b23b-b77887af3702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a99aa24-599c-cc60-b23b-b77887af3702@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022, David Hildenbrand wrote:
> On 26.09.22 16:48, Kirill A. Shutemov wrote:
> > On Mon, Sep 26, 2022 at 12:35:34PM +0200, David Hildenbrand wrote:
> > > When using DAX, what happens with the shared <->private conversion? Which
> > > "type" is supposed to use dax, which not?
> > > 
> > > In other word, I'm missing too many details on the bigger picture of how
> > > this would work at all to see why it makes sense right now to prepare for
> > > that.
> > 
> > IIUC, KVM doesn't really care about pages or folios. They need PFN to
> > populate SEPT. Returning page/folio would make KVM do additional steps to
> > extract PFN and one more place to have a bug.
> 
> Fair enough. Smells KVM specific, though.

TL;DR: I'm good with either approach, though providing a "struct page" might avoid
       refactoring the API in the nearish future.

Playing devil's advocate for a second, the counter argument is that KVM is the
only user for the foreseeable future.

That said, it might make sense to return a "struct page" from the core API and
force KVM to do page_to_pfn().  KVM already does that for HVA-based memory, so
it's not exactly new code.

More importantly, KVM may actually need/want the "struct page" in the not-too-distant
future to support mapping non-refcounted "struct page" memory into the guest.  The
ChromeOS folks have a use case involving virtio-gpu blobs where KVM can get handed a
"struct page" that _isn't_ refcounted[*].  Once the lack of mmu_notifier integration
is fixed, the remaining issue is that KVM doesn't currently have a way to determine
whether or not it holds a reference to the page.  Instead, KVM assumes that if the
page is "normal", it's refcounted, e.g. see kvm_release_pfn_clean().

KVM's current workaround for this is to refuse to map these pages into the guest,
i.e. KVM simply forces its assumption that normal pages are refcounted to be true.
To remove that workaround, the likely solution will be to pass around a tuple of
page+pfn, where "page" is non-NULL if the pfn is a refcounted "struct page".

At that point, getting handed a "struct page" from the core API would be a good
thing as KVM wouldn't need to probe the PFN to determine whether or not it's a
refcounted page.

Note, I still want the order to be provided by the API so that KVM doesn't need
to run through a bunch of helpers to try and figure out the allowed mapping size.

[*] https://lore.kernel.org/all/CAD=HUj736L5oxkzeL2JoPV8g1S6Rugy_TquW=PRt73YmFzP6Jw@mail.gmail.com

