Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEF604CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJSQJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiJSQJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:09:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F274DFC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 09:09:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n7so17723507plp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypkvL3yaAxMPxurJS0uFGqCkiFZ+RyzOnuF9leoHMPg=;
        b=h+1KlUYCjsRVvRZom/eZaqVVZPwLNuYTzVtc/yfchg/FVn3f5I4RUVC9fB77Ol9VGf
         HgCK8mY6Nv+Xq72Fx81Po6YrtpzWxQ53rseaDQp3xO+NUuzg/Q/QlKyJ26MY8whFSFB9
         Yz/rDhSdBT3TPLIrEG1lXL4xKfi0GT6oeGR8n8SqA7rIg+ZhIQiSL6k7+pVB5ukZ64kF
         kVFFiLi2o9zlE+Zz99wb/PPKOZvfE8v4DtNHoGGtu9prsA4BZL7zqk0frRY/JGZwwNq7
         g2L2w4CVrM6EQ0r7EXNj734PT3xgw2/P2uRLexg59HxYszjKm2su2n+onT/oKpMmOXgw
         qJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypkvL3yaAxMPxurJS0uFGqCkiFZ+RyzOnuF9leoHMPg=;
        b=hFMDEaFhWA2IEdJ09WUv38+smrpy9CnsNYPa7U6XNFXXwgJjqCSWCSaLkuaH/I52R3
         VjqUsvziioWpW2oVbHOn3wHdU8D4VwoVxw72YCU1K69d2DJ1y5BWgDbodFsUsp74z4gj
         B3p3ho/3jQeRV+6CK0KkOXwDqMEP63FElFuKn9Hfmd29ayjpwiq2R92s0jnX2GsS/YYx
         5ViAS0g9Eb+z/E/1A7bPllfGyQz0iGsAcjlM75FkFFRKu4dGULOX5e+UY9ry99K0MTi5
         BvgaVTtGnFT57LTB9+pMdOOzrOzvW8tQndp+EtVMz8kg7bYVi54GLZR2oXMeFmFIrcje
         mM/w==
X-Gm-Message-State: ACrzQf3r2uXwhEcF/N5rDkGPjvZH/Ike2nLVxdbHk3eX75OjWMAzkjre
        6RG8JFZC/9bFeIiKT3hXDI6hHamMyKUBUQ==
X-Google-Smtp-Source: AMsMyM5J8mv9XBDJfNSTMwrJGznqodpAH+vWLTNt9JpHQACwNEqu56e3wBHUQ6hekV2SylbV5oa2BA==
X-Received: by 2002:a17:903:248b:b0:17d:ea45:d76a with SMTP id p11-20020a170903248b00b0017dea45d76amr9440949plw.97.1666195779474;
        Wed, 19 Oct 2022 09:09:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d13-20020aa797ad000000b00553d573222fsm11558997pfq.199.2022.10.19.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:09:38 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:09:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 5/8] KVM: Register/unregister the guest private memory
 regions
Message-ID: <Y1AhP0dlRSgTCObX@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-6-chao.p.peng@linux.intel.com>
 <CA+EHjTxukqBfaN6D+rPOiX83zkGknHEQ16J0k6GQSdL_-e9C6g@mail.gmail.com>
 <20221012023516.GA3218049@chaop.bj.intel.com>
 <CA+EHjTyGyGL+ox81=jdtoHERtHPV=P7wJub=3j7chdijyq-AgA@mail.gmail.com>
 <Y03UiYYioV+FQIpx@google.com>
 <20221019132308.GA3496045@chaop.bj.intel.com>
 <CA+EHjTytCEup0m-nhnVHsuQ1xjaCxXNHO_Oxe+QbpwqaewpfKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTytCEup0m-nhnVHsuQ1xjaCxXNHO_Oxe+QbpwqaewpfKQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022, Fuad Tabba wrote:
> > > > This sounds good. Thank you.
> > >
> > > I like the idea of a separate Kconfig, e.g. CONFIG_KVM_GENERIC_PRIVATE_MEM or
> > > something.  I highly doubt there will be any non-x86 users for multiple years,
> > > if ever, but it would allow testing the private memory stuff on ARM (and any other
> > > non-x86 arch) without needing full pKVM support and with only minor KVM
> > > modifications, e.g. the x86 support[*] to test UPM without TDX is shaping up to be
> > > trivial.
> >
> > CONFIG_KVM_GENERIC_PRIVATE_MEM looks good to me.
> 
> That sounds good to me, and just keeping the xarray isn't really an
> issue for pKVM.

The xarray won't exist for pKVM if the #ifdefs in this patch are changed from
CONFIG_HAVE_KVM_PRIVATE_MEM => CONFIG_KVM_GENERIC_PRIVATE_MEM.

> We could end up using it instead of some of the other
> structures we use for tracking.

I don't think pKVM should hijack the xarray for other purposes.  At best, it will
be confusing, at worst we'll end up with a mess if ARM ever supports the "generic"
implementation.  
