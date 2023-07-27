Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D442765721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjG0POI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjG0POG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4119A0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690470800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+K3NKuN7pFRTB77+mmM/h9zHjbt4jm2xK8401VCvp4=;
        b=HgJtRI2+tbxJAiNkJwQhOcRDiz0x4W0GQgV7hmt59thasR/lulskb3yxdhDnvQpZdxefla
        CboZPHdZl6V7lUF+sihfklJgxcgjwkvR+uIDJ2ILfRubE2M4PjdWzyBQmJnldXmML0mS81
        RhQ+YHWRr08xGyNspMrHD5vwoD30XbM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-831I1tQmO3e1bm5j0cMvVg-1; Thu, 27 Jul 2023 11:13:19 -0400
X-MC-Unique: 831I1tQmO3e1bm5j0cMvVg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765ad67e690so21728785a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 08:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690470798; x=1691075598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+K3NKuN7pFRTB77+mmM/h9zHjbt4jm2xK8401VCvp4=;
        b=P+0W4IKGgrVZTjCctGapegLN1gbC+yk/cxFkji2Qxi183B+RKNdGtcjn6PHTJb5aPc
         V3Ssatj9lkZyL18pNPXCkVv874aYErGGTAtNZ2nk+EiJiX99GqL775HavsPzXFKh4HSB
         ICQN2vMUbIAEdYDlFzx+T2ZrYUT9qAnSPSqqDO+2lFqVfKOKQhsqql4q1h8iuWTjLR8B
         19PRyUI2eH6ytOROhIgTmbYQLBbf8TK8iVRtRjz6fvFbKAd/l9Q5CrN8XZb2NEcvaCp1
         hBYgCYp4aH3hJbFtCxYte2Mp0KPRVEeKD1KGcKu5ukPh5qwsXtbKX5DFviXeQjcGWECR
         7r9Q==
X-Gm-Message-State: ABy/qLaPmPLXxiYrQnLiqt1dR86WOH1pnukLJc5hwRJ7N+fSbFftEf80
        EyiX+evLoxAhwlZgsT0hpkL9FpqGdgF2mgIoGyOImb9FS/znGs6Qimp+GKqTabxuG3x9jL1iZWP
        P53TPJkerl5ozBtWKg0E8wz0X0P3hEmlLnw==
X-Received: by 2002:a05:620a:4487:b0:767:ffb:58aa with SMTP id x7-20020a05620a448700b007670ffb58aamr6484608qkp.3.1690470798571;
        Thu, 27 Jul 2023 08:13:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFs5DibxNTW9sdysef7XXwwep3NBUN5dOmYIBHnZfzSv0a7hEoloL19Tdn4QXu4FXCbYLufKA==
X-Received: by 2002:a05:620a:4487:b0:767:ffb:58aa with SMTP id x7-20020a05620a448700b007670ffb58aamr6484594qkp.3.1690470798241;
        Thu, 27 Jul 2023 08:13:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id v13-20020ae9e30d000000b00767f14f5856sm458979qkf.117.2023.07.27.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:13:17 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:13:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
Message-ID: <ZMKJjDaqZ7FW0jfe@x1n>
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n>
 <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:28:49PM +0200, David Hildenbrand wrote:
> > > > Therefore, when obtaining pages through the follow_trans_huge_pmd
> > > > interface, add the FOLL_FORCE flag to count the pages corresponding to
> > > > PROTNONE to solve the above problem.
> > > > 
> > > 
> > > We really want to avoid the usage of FOLL_FORCE, and ideally limit it
> > > to ptrace only.
> > 
> > Fundamentally when removing FOLL_NUMA we did already assumed !FORCE is
> > FOLL_NUMA.  It means to me after the removal it's not possible to say in a
> > gup walker that "it's not FORCEd, but I don't want to trigger NUMA but just
> > get the page".
> > 
> > Is that what we want?  Shall we document that in FOLL_FORCE if we intended
> > to enforce numa balancing as long as !FORCE?
> 
> That was the idea, yes. I could have sworn we had that at least in some
> patch description.
> 
> Back then, I played with special-casing on gup_can_follow_protnone() on
> FOLL_GET | FOLL_PIN. But it's all just best guesses.
> 
> Can always be added if deemed necessary and worth it.
> 
> Here, it's simply an abuse of that GUP function that I wasn't aware of --
> otherwise I'd have removed that before hand.
> 
> > 
> > > 
> > > > Signed-off-by: liubo <liubo254@huawei.com>
> > > > Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
> > > > ---
> > > >   fs/proc/task_mmu.c | 6 ++++--
> > > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index c1e6531cb02a..ed08f9b869e2 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -571,8 +571,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> > > >          bool migration = false;
> > > > 
> > > >          if (pmd_present(*pmd)) {
> > > > -               /* FOLL_DUMP will return -EFAULT on huge zero page */
> > > > -               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> > > > +               /* FOLL_DUMP will return -EFAULT on huge zero page
> > > > +                * FOLL_FORCE follow a PROT_NONE mapped page
> > > > +                */
> > > > +               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP | FOLL_FORCE);
> > > >          } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> > > >                  swp_entry_t entry = pmd_to_swp_entry(*pmd);
> > > 
> > > Might do as an easy fix. But we really should get rid of that
> > > absolutely disgusting usage of follow_trans_huge_pmd().
> > > 
> > > We don't need 99% of what follow_trans_huge_pmd() does here.
> > > 
> > > Would the following also fix your issue?
> > > 
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 507cd4e59d07..fc744964816e 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -587,8 +587,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> > >          bool migration = false;
> > > 
> > >          if (pmd_present(*pmd)) {
> > > -               /* FOLL_DUMP will return -EFAULT on huge zero page */
> > > -               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> > > +               page = vm_normal_page_pmd(vma, addr, *pmd);
> > >          } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> > >                  swp_entry_t entry = pmd_to_swp_entry(*pmd);
> > > 
> > > It also skips the shared zeropage and pmd_devmap(),
> > > 
> > > Otherwise, a simple pmd_page(*pmd) + is_huge_zero_pmd(*pmd) check will do, but I
> > > suspect vm_normal_page_pmd() might be what we actually want to have here.
> > > 
> > > Because smaps_pte_entry() properly checks for vm_normal_page().
> > 
> > There're indeed some very trivial detail in vm_normal_page_pmd() that's
> > different, but maybe not so relevant.  E.g.,
> > 
> > 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> > 		return -ENOMEM;
> 
> Note that we're not even passing FOLL_GET | FOLL_PIN. Because we're not
> actually doing GUP. So the refcount is not that relevant.
> 
> > 
> > 	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
> > 		return -EREMOTEIO;
> > 
> > I'm not sure whether the p2pdma page would matter in any form here.  E.g.,
> > whether it can be mapped privately.
> 
> Good point, but I don't think that people messing with GUP even imagined
> that we would call that function from a !GUP place.
> 
> This was wrong from the very start. If we're not in GUP, we shouldn't call
> GUP functions.

My understanding is !GET && !PIN is also called gup.. otherwise we don't
need GET and it can just be always implied.

The other proof is try_grab_page() doesn't fail hard on !GET && !PIN.  So I
don't know whether that's "wrong" to be used..

Back to the topic: I'd say either of the patches look good to solve the
problem.  If p2pdma pages are mapped as PFNMAP/MIXEDMAP (?), I guess
vm_normal_page_pmd() proposed here will also work on it, so nothing I see
wrong on 2nd one yet.

It looks nicer indeed to not have FOLL_FORCE here, but it also makes me
just wonder whether we should document NUMA behavior for FOLL_* somewhere,
because we have an implication right now on !FOLL_FORCE over NUMA, which is
not obvious to me..

And to look more over that aspect, see follow_page(): previously we can
follow a page for protnone (as it never applies FOLL_NUMA) but now it won't
(it never applies FOLL_FORCE, either, so it seems "accidentally" implies
FOLL_NUMA now).  Not sure whether it's intended, though..

-- 
Peter Xu

