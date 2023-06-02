Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3907208B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjFBR7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjFBR7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C8A1B8
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685728746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSARUz2O3TmQ5YM6iQ0ZZCNg+rFHS4+v0lFyDbqBuwM=;
        b=izhe/kkKFr6HL5sRTaVdLJIzjk/mXiqZjmA+Nh5zLSiyWDjv9O4kiw2QUjYfJg18Lij1gk
        aXt81hnLrIjBraHyD9teXHvlwlltEywGWv4QvdziGijuDM8R44XJPR5tVUF8asACIOuC5n
        dLpw2f2ZeS3Y+QM1V7LjnJs3tyzkmTY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-iC9YNCbPOHmqVfqx5B_tCw-1; Fri, 02 Jun 2023 13:59:02 -0400
X-MC-Unique: iC9YNCbPOHmqVfqx5B_tCw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b175cf0d1so29647185a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 10:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685728742; x=1688320742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSARUz2O3TmQ5YM6iQ0ZZCNg+rFHS4+v0lFyDbqBuwM=;
        b=FVkZ1Mx/A1nRRUnZ7dawNhasXlNZMkoldMKJi+yCkR2wKDGAoD8Xm1zaXsHfxbFVE6
         ZAthaeN4VylTTMmzz1QMMRj69b+uZ1ffH937YLRcfXHceU0bfwoyg+hHh17kKf3xZn1K
         zR+blF59GlC1D39gU7S/C7+GOBMlUhIBnjC9qGWOPyZ/iGDPe0uJZoZnhGu10c8dVzk2
         iZXTJlsVTe7ZUdKW2C8LIp+f8d15wTb/XV431iaZiu5m+hlqpVfUiXdLX4peAuYbr3V9
         RKBAlZNh4CmYfC92ed8aEL1VYvm50IoBQeVP8n5P95zPXKN9M3c/8tDPtFpWZuj3+2u9
         Do8Q==
X-Gm-Message-State: AC+VfDys2HpX3CHZH4TymUPP7TjSObF91TAMqpgJAiLDYnBJ1wnYF9LF
        e6erHS4MHUSKjl3eUV4lcPGKdtzg/MJZ0+arc31t5qxJIRe0vkAsDmZgVbCvlkdUSSo6M93S3Tw
        8eEyMjJMXiBw7OFhG5aQaph45nA==
X-Received: by 2002:a05:620a:43a4:b0:75b:23a1:69f0 with SMTP id a36-20020a05620a43a400b0075b23a169f0mr11249966qkp.7.1685728742219;
        Fri, 02 Jun 2023 10:59:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4m8Bhw4wjEoJhLfsA5Ru0yUPJznYbpOxt4yZuMQxYyzBraywPvQDy3Ozu06ddbe9B1KF2HHw==
X-Received: by 2002:a05:620a:43a4:b0:75b:23a1:69f0 with SMTP id a36-20020a05620a43a400b0075b23a169f0mr11249931qkp.7.1685728741857;
        Fri, 02 Jun 2023 10:59:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a118a00b0074ca7c33b79sm910734qkk.23.2023.06.02.10.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 10:59:01 -0700 (PDT)
Date:   Fri, 2 Jun 2023 13:58:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v16 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZHot4rwXGOzeqJ86@x1n>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
 <20230525085517.281529-3-usama.anjum@collabora.com>
 <ZHfAOAKj1ZQJ+zSy@x1n>
 <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com>
 <ZHj7jmJ5fKla1Rax@x1n>
 <3589803d-5594-71de-d078-ad4499f233b6@collabora.com>
 <ZHodIFQesrCA53To@x1n>
 <be70e76a-3875-6e1b-a5aa-b89d2368b904@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be70e76a-3875-6e1b-a5aa-b89d2368b904@collabora.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:42:45PM +0500, Muhammad Usama Anjum wrote:
> Thank you for reviewing and helping out.
> 
> On 6/2/23 9:47 PM, Peter Xu wrote:
> [...]
> >>>> static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> >>>> 					 unsigned long addr, pte_t *ptep,
> >>>> 					 pte_t ptent)
> >>>> {
> >>>> 	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
> >>>> 		return;
> >>>>
> >>>> 	if (is_hugetlb_entry_migration(ptent))
> >>>> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >>>> 				pte_swp_mkuffd_wp(ptent));
> >>>> 	else if (!huge_pte_none(ptent))
> >>>> 		ptep_modify_prot_commit(vma, addr, ptep, ptent,
> >>>> 					huge_pte_mkuffd_wp(ptent));
> >>>> 	else
> >>>> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >>>> 				make_pte_marker(PTE_MARKER_UFFD_WP));
> >>>> }
> >>>
> >>> the is_pte_marker() check can be extended to double check
> >>> pte_marker_uffd_wp() bit, but shouldn't matter a lot since besides the
> >>> uffd-wp bit currently we only support swapin error which should sigbus when
> >>> accessed, so no point in tracking anyway.
> >> Yeah, we are good with what we have as even if more bits are supported in
> >> pte markers, this function is only reached when UNPOPULATED + ASYNC WP are
> >> enabled. So no other bit would be set on the marker.
> > 
> > I think we don't know?  swapin error bit can be set there afaiu, if someone
> > swapoff -a and found a swap device broken for some swapped out ptes.
> Oops, so I remove returning on pte marker detection. Instead the last else
> is already setting marker wp-ed.

What I meant is your current code is fine, please don't remove the check.

Removing is_pte_marker() means you could potentially overwrite one swap
error entry with a marker only having uffd-wp bit set.  It can corrupt the
guest because swapin error is not recoverable and higher priority than wp.

> 
> > 
> > But again I think that's fine for now.
> > 
> >>
> >>>
> >>>>
> >>>> As we always set UNPOPULATED, so markers are always set on none ptes
> >>>> initially. Is it possible that a none pte becomes present, then swapped and
> >>>> finally none again? So I'll do the following addition for make_uffd_wp_pte():
> >>>>
> >>>> --- a/fs/proc/task_mmu.c
> >>>> +++ b/fs/proc/task_mmu.c
> >>>> @@ -1800,6 +1800,9 @@ static inline void make_uffd_wp_pte(struct
> >>>> vm_area_struct *vma,
> >>>>  	} else if (is_swap_pte(ptent)) {
> >>>>  		ptent = pte_swp_mkuffd_wp(ptent);
> >>>>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> >>>> +	} else {
> >>>> +		set_pte_at(vma->vm_mm, addr, pte,
> >>>> +			   make_pte_marker(PTE_MARKER_UFFD_WP));
> >>>>  	}
> >>>>  }
> >>>
> >>> Makes sense, you can leverage userfaultfd_wp_use_markers() here, and you
> >>> should probably keep the protocol (only set the marker when WP_UNPOPULATED
> >>> for anon).
> >> This function is only reachable when UNPOPULATED + Async WP are set. So we
> >> don't need to use userfaultfd_wp_use_markers().
> > 
> > I don't remember where you explicitly checked that to make sure it'll
> > always be the case, but if you do it'll still be nice if you can add a
> > comment right above here explaining.
> I was only testing for WP and WP Async in pagemap_scan_test_walk() as WP
> async can only be enabled if unpopulated is enabled which in turn enables
> the markers. I'll add userfaultfd_wp_use_markers() to pagemap_scan_test_walk().

OK.

> 
> > 
> > Or, maybe you can still use userfaultfd_wp_use_markers() here, then you can
> > just WARN_ON_ONCE() on it, which looks even better?
> > 
> > [...]
> > 
> >>> Hmm, is it a bug for pagemap?  pagemapread.buffer should be linear to the
> >>> address range to be scanned to me.  If it skips some unstable pmd without
> >>> filling in anything it seems everything later will be shifted with
> >>> PMD_SIZE..  I had a feeling that it should set walk->action==ACTION_AGAIN
> >>> before return.
> >> I don't think this is a bug if this is how it was implemented in the first
> >> place. In this task_mmu.c file, we can find several examples of the same
> >> pattern that error isn't returned if pmd_trans_unstable() succeeds.
> > 
> > I don't see why multiple same usages mean it's correct.. maybe they're all
> > buggy?
> > 
> > I can post a patch for this to collect opinions to see if I missed
> > something. I'd suggest you figure out what's the right thing to do for the
> > new interface and make it right from the start, no matter how it was
> > implemented elsewhere.
> Alright. At first sight, it seems I should return -EAGAIN here. But there
> maybe a case where there are 3 THPs. I've cleared WP over the first THP and
> put data in the user buffer. If I return -EAGAIN, the data in the user
> buffer would be not used by the user correctly as negative value has been
> returned. So the best way here would be to skip this second VMA and don't
> abort the operation. Thus we'll not be giving any information about the
> second THP as it was in transition.
> 
> I'll think about it again before sending next version.

Here when reaching unstable==true I think it means a rare race happened,
that a thp was _just_ installed.  You can try to read the comment over
pmd_trans_unstable() and pmd_none_or_trans_huge_or_clear_bad() to
understand what it wants to avoid.

Basically afaiu that's the ultimate guard if one wants to walk the pte
pgtable (that fact can change again if Hugh's series will land, but that's
another story).

As said, a patch will be posted (will have you copied) soon just for that,
so people can also comment and may help you / us know which is the right
way, probably not in a few hours (need to go very soon..), but shouldn't be
too long.  I just need to double check more users out of task_mmu.c when
we're at it.

-- 
Peter Xu

