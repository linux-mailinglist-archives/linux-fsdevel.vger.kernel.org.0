Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983784FCEA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 07:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347628AbiDLFQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiDLFQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:16:37 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199DB13F43
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:14:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so19657126fac.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7AXHvKyDS+8sXsKK4DrpbEGpG8JmWPbR7ulEunl5/Pc=;
        b=MIKtm3AFEh6CUVVNwUV8SeElPxDQU+nDCsyp+WcUsmZ4pYGMDS8fAcdOR85R0GnShf
         Y4SvxZp6GJGIWSDO3Qz0y+u4ZcAKbd5h4QgxfwJ80V2XMN4GDeNiF7fIlHS12g+G1n/h
         Kv7zR3bRSH86ipJifMek23BAEcPpsO3GQOK2qAQPq7d5D/TFRqQckEDpcn4OYWx7WoM9
         lUklPUH6KUc5SlQqi1stBQ4I3bHiGY7ZT6LaR8lgLF5UeZqRnpzjDs527tWEzRy8OZZn
         nmt6hJ/Qq1aIeTJZ8BRsG/eRuI5lX0MY/pv7AqCy9vDclBFJLYkpepT8CENCuRctsE08
         JerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=7AXHvKyDS+8sXsKK4DrpbEGpG8JmWPbR7ulEunl5/Pc=;
        b=DkjvbYF/CoHduv7nNNaEz2dKV6paRlMODIL5fozdO+De7Xs/AMo8oJD09cO1E40n4Z
         pmdFWPMJO9WIl6ONtIqoNaSSGKvZeq3fo5JgYYp4IDI697FM0xvUeli4e1DvPk1jBke8
         SbDmc1wAzfdH8CNJTprq5evd0Z5CxqbBuwnD7mXg/sDljnw3G0THvPwrNNMiiocqYbP5
         MWhH0XjZNAQ/cKQXWwsbOVteQQC544wEdT6cSGfEiSN2yI1mNMsx09n3nYSuj1b81g4I
         U1HYqVIq4rvQ4vU9xsGzFTBoNdvA3kMyBqPOQEhOf7jBDjmztrM9ILZ+P+JfGSg1k0r6
         72oQ==
X-Gm-Message-State: AOAM532X33IEdcz00ior68X7B8f4LGXnbSOxUv5V9mhEn0kKZaL9uo9Q
        MlD57dkZyDoteQkYycDxGcI+qg==
X-Google-Smtp-Source: ABdhPJzGUlHADzn2yFu7M3obTMzPSe7EDZTZ3EDogaZbWHy2xdUqchu+tTmHlhlBd5Pwc/mriWkvvQ==
X-Received: by 2002:a05:6870:5390:b0:de:f680:db03 with SMTP id h16-20020a056870539000b000def680db03mr1269177oan.237.1649740456270;
        Mon, 11 Apr 2022 22:14:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e9-20020a056820060900b003216277bfdasm12481870oow.19.2022.04.11.22.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 22:14:15 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:14:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
In-Reply-To: <20220411153433.6sqqqd6vzhyfjee6@box.shutemov.name>
Message-ID: <2c39702b-2a71-cda2-685-93908763912@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com> <20220310140911.50924-5-chao.p.peng@linux.intel.com> <Yk8L0CwKpTrv3Rg3@google.com> <20220408130254.GB57095@chaop.bj.intel.com> <20220411153433.6sqqqd6vzhyfjee6@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Apr 2022, Kirill A. Shutemov wrote:
> On Fri, Apr 08, 2022 at 09:02:54PM +0800, Chao Peng wrote:
> > > I think the correct approach is to not do the locking automatically for SHM_F_INACCESSIBLE,
> > > and instead require userspace to do shmctl(.., SHM_LOCK, ...) if userspace knows the
> > > consumers don't support migrate/swap.  That'd require wrapping migrate_page() and then
> > > wiring up notifier hooks for migrate/swap, but IMO that's a good thing to get sorted
> > > out sooner than later.  KVM isn't planning on support migrate/swap for TDX or SNP,
> > > but supporting at least migrate for a software-only implementation a la pKVM should
> > > be relatively straightforward.  On the notifiee side, KVM can terminate the VM if it
> > > gets an unexpected migrate/swap, e.g. so that TDX/SEV VMs don't die later with
> > > exceptions and/or data corruption (pre-SNP SEV guests) in the guest.
> > 
> > SHM_LOCK sounds like a good match.
> 
> Emm, no. shmctl(2) and SHM_LOCK are SysV IPC thing. I don't see how they
> fit here.

I am still struggling to formulate a constructive response on
MFD_INACCESSIBLE in general: but before doing so, let me jump in here
to say that I'm firmly on the side of SHM_LOCK being the right model -
but admittedly not through userspace calling shmctl(2).

Please refer to our last year's posting "[PATCH 10/16] tmpfs: fcntl(fd,
F_MEM_LOCK) to memlock a tmpfs file" for the example of how Shakeel did
it then (though only a small part of that would be needed for this case):
https://lore.kernel.org/linux-mm/54e03798-d836-ae64-f41-4a1d46bc115b@google.com/

And until such time as swapping is enabled, this memlock accounting would
be necessarily entailed by "MFD_INACCESSIBLE", or however that turns out
to be implemented: not something that we could trust userspace to call
separately.

Hugh
