Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202774C041
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 03:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGIBIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 21:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIBIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 21:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B571BC;
        Sat,  8 Jul 2023 18:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EB260B6A;
        Sun,  9 Jul 2023 01:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E62EC433C7;
        Sun,  9 Jul 2023 01:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688864932;
        bh=k5nxP9jbAM1IeZ9Pjabku0MSbBxiNxaBsjdLI65+RGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aDLhQEW2U/Ce5YKFULJhO1iXzIZEfMh0qIsf91fXpGlDLKAGl3S4x1zHAzXaZBqJH
         nDmSl0JnGqMiPVvyfXbiGQ7aK4uWDFVOT66Xf9WlGRZ+ubThBc9LOVAk+jKmRgDST6
         vyy7ru4yQOv31Bb5r0zp+BxYYD2eUa+mISzsqUDQ=
Date:   Sat, 8 Jul 2023 18:08:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/8] mm: make PTE_MARKER_SWAPIN_ERROR more general
Message-Id: <20230708180850.bc938ab49fbfb38b83c367c8@linux-foundation.org>
In-Reply-To: <20230707215540.2324998-2-axelrasmussen@google.com>
References: <20230707215540.2324998-1-axelrasmussen@google.com>
        <20230707215540.2324998-2-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  7 Jul 2023 14:55:33 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> Future patches will re-use PTE_MARKER_SWAPIN_ERROR to implement
> UFFDIO_POISON, so make some various preparations for that:
> 
> First, rename it to just PTE_MARKER_POISONED. The "SWAPIN" can be
> confusing since we're going to re-use it for something not really
> related to swap. This can be particularly confusing for things like
> hugetlbfs, which doesn't support swap whatsoever. Also rename some
> various helper functions.
> 
> Next, fix pte marker copying for hugetlbfs. Previously, it would WARN on
> seeing a PTE_MARKER_SWAPIN_ERROR, since hugetlbfs doesn't support swap.
> But, since we're going to re-use it, we want it to go ahead and copy it
> just like non-hugetlbfs memory does today. Since the code to do this is
> more complicated now, pull it out into a helper which can be re-used in
> both places. While we're at it, also make it slightly more explicit in
> its handling of e.g. uffd wp markers.
> 
> For non-hugetlbfs page faults, instead of returning VM_FAULT_SIGBUS for
> an error entry, return VM_FAULT_HWPOISON. For most cases this change
> doesn't matter, e.g. a userspace program would receive a SIGBUS either
> way. But for UFFDIO_POISON, this change will let KVM guests get an MCE
> out of the box, instead of giving a SIGBUS to the hypervisor and
> requiring it to somehow inject an MCE.
> 
> Finally, for hugetlbfs faults, handle PTE_MARKER_POISONED, and return
> VM_FAULT_HWPOISON_LARGE in such cases. Note that this can't happen today
> because the lack of swap support means we'll never end up with such a
> PTE anyway, but this behavior will be needed once such entries *can*
> show up via UFFDIO_POISON.
> 
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -523,6 +523,25 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>  	return atomic_read(&mm->tlb_flush_pending) > 1;
>  }
>  
> +/*
> + * Computes the pte marker to copy from the given source entry into dst_vma.
> + * If no marker should be copied, returns 0.
> + * The caller should insert a new pte created with make_pte_marker().
> + */
> +static inline pte_marker copy_pte_marker(
> +		swp_entry_t entry, struct vm_area_struct *dst_vma)
> +{
> +	pte_marker srcm = pte_marker_get(entry);
> +	/* Always copy error entries. */
> +	pte_marker dstm = srcm & PTE_MARKER_POISONED;
> +
> +	/* Only copy PTE markers if UFFD register matches. */
> +	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
> +		dstm |= PTE_MARKER_UFFD_WP;
> +
> +	return dstm;
> +}

Breaks the build with CONFIG_MMU=n (arm allnoconfig).  pte_marker isn't
defined.

I'll slap #ifdef CONFIG_MMU around this function, but probably somethng more
fine-grained could be used, like CONFIG_PTE_MARKER_UFFD_WP.  Please
consider.

btw, both copy_pte_marker() and pte_install_uffd_wp_if_needed() look
far too large to justify inlining.  Please review the desirability of
this.


