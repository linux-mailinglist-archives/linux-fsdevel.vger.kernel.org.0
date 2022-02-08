Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D884AE0AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384787AbiBHSWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiBHSWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CAFC061578;
        Tue,  8 Feb 2022 10:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1355B81CAA;
        Tue,  8 Feb 2022 18:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A23C004E1;
        Tue,  8 Feb 2022 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644344548;
        bh=pbwoMFvbx4OzTTkyGFIGfJ12xlO6+bE4SbLdm1gW5I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNuiUrZiyZwnx2Zetr26GwhCvtD03/IVpLo3FpvdvheOmgnRQ5SYpGaYm+Tt7uSCB
         DNMr3SgUwAL7VlAzw2uF3oEX3Wq5S10qEgoTyDTnGB+be+NTkuRT5/OLFBEIvq2DvT
         fSEpMjSFRMvpJRMracavaaMy5fOna6tJw+zCiKVkNqwsV+eoYkh7G6+ClTVrFzkadr
         PFkVf1dyiiRN4XTIRu9GSzf5v2WddgxQ4JepSha8CpVS8dm0saZc9wIZnG4sYTbUuA
         9XieRr9l5HYMJp/kMD/0xmCjHB96Q35e5J6cbaJxVLDo+YXYIhKqEEooynG8+zxmzx
         ua2MSdS8fgBxw==
Date:   Tue, 8 Feb 2022 20:22:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 02/12] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <YgK0zZjq+KNoeNYM@kernel.org>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-3-chao.p.peng@linux.intel.com>
 <25166513-3074-f3b9-12cc-420ba74f153e@suse.cz>
 <07aae6e7-4042-1c5c-a482-6ad3a34a3b07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07aae6e7-4042-1c5c-a482-6ad3a34a3b07@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:49:35AM +0100, David Hildenbrand wrote:
> On 07.02.22 19:51, Vlastimil Babka wrote:
> > On 1/18/22 14:21, Chao Peng wrote:
> >> Introduce a new memfd_create() flag indicating the content of the
> >> created memfd is inaccessible from userspace. It does this by force
> >> setting F_SEAL_INACCESSIBLE seal when the file is created. It also set
> >> F_SEAL_SEAL to prevent future sealing, which means, it can not coexist
> >> with MFD_ALLOW_SEALING.
> >>
> >> The pages backed by such memfd will be used as guest private memory in
> >> confidential computing environments such as Intel TDX/AMD SEV. Since
> >> page migration/swapping is not yet supported for such usages so these
> >> pages are currently marked as UNMOVABLE and UNEVICTABLE which makes
> >> them behave like long-term pinned pages.
> > 
> > Shouldn't the amount of such memory allocations be restricted? E.g. similar
> > to secretmem_mmap() doing mlock_future_check().

Heh, for me it was easy, I had the VMA :)
 
> I've raised this already in the past and Kirill wanted to look into it [1].
> 
> We'll most certainly need a way to limit/control the amount of
> unswappable + unmovable ("worse than mlock" memory) a user/process can
> consume via this mechanism.

I think the accounting can be handled in notify_fallocate() and
notify_invalidate_page().

> [1] https://lkml.kernel.org/r/20211122135933.arjxpl7wyskkwvwv@box.shutemov.name
>
> -- 
> Thanks,
> 
> David / dhildenb

-- 
Sincerely yours,
Mike.
