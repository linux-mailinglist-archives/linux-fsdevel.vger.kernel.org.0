Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81217681CBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjA3V2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 16:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjA3V17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F8E458AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675114037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUjUOCosc+n9O/YY6buBifhq9wPTzqRNFK3SmiShyMc=;
        b=J788HGw7DtcMnlvLWtNItVXhhZWXBcW6+H3qKx9trFrDPSRlDhbpulXYyvU2F6StXo/408
        hxarGYturKQrdi/b9ELoeOWq7EjlR4vydP/hA4wscCNv1PhkNHt4Bno/Tq6cp+U7GUPk5X
        aw48/5kn7mQ3gVFC+NHN1i7cWMrN62k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-NJtVLNolPkyRRYXGvuNRaw-1; Mon, 30 Jan 2023 16:27:16 -0500
X-MC-Unique: NJtVLNolPkyRRYXGvuNRaw-1
Received: by mail-qv1-f69.google.com with SMTP id jo26-20020a056214501a00b0053aa15f61d4so3357861qvb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUjUOCosc+n9O/YY6buBifhq9wPTzqRNFK3SmiShyMc=;
        b=DjcOFDceyuKDFGOSceNpSY9aJVDTuQPOxTOrPeUuw3M82s0QMmp0OsovgPcprMaG0g
         qE1HwQHD5YSHeNaLiKAaK6pjGWeRceqd+UvjY1Rko3ykb8aa0dsPochclSi5af09FbcT
         HH5MzEEZb6JK7LUmGsSIcmIRWN6nlQ+pz0tEsvzSuusPR3GDkqbgS0AeIe2+9khzho/A
         aPqFGEZsqnKJB66KWvf535nLTPFubDY8oK0EwclE8dHKxNKTfq+bLH6osk8+q81LPK0k
         PQEjvC2hu/vGArTFeLcNppiM4r58iWTp+mIuJNQYHT+k5im6NmTgiZxp2C7Xh069yPvy
         yPhw==
X-Gm-Message-State: AO0yUKWIl/XWOXMCNa6U45N6wVEAb4hpmWwtSJFMsiykf7VPlIJ1VZN/
        r9OzdlUvG7hILOUZzpMuAaWz5UeyM7sFQ0q8HhKI6kkCt47WUZgWSqn9x8cKxUSQI/zI/9Cxfzc
        eALYYWlEZ5yODBsi8q8R//HPcjA==
X-Received: by 2002:a0c:ebc8:0:b0:537:6e4c:ac60 with SMTP id k8-20020a0cebc8000000b005376e4cac60mr8802584qvq.2.1675114035603;
        Mon, 30 Jan 2023 13:27:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9TUlrBdCpVee0Syc/iu5fDy/5lnof3SbV+U+NkYNoyBgzcAg3OjwV20+VqTlOzMOIBNbiuPg==
X-Received: by 2002:a0c:ebc8:0:b0:537:6e4c:ac60 with SMTP id k8-20020a0cebc8000000b005376e4cac60mr8802538qvq.2.1675114035240;
        Mon, 30 Jan 2023 13:27:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a01f400b0071d2cd07560sm3984325qkn.124.2023.01.30.13.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:27:14 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:27:12 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
Message-ID: <Y9g2MAwycCJ3N2tf@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-2-usama.anjum@collabora.com>
 <Y9MHM+RVzvigcTTk@x1n>
 <1968dff9-f48a-3290-a15b-a8b739f31ed2@collabora.com>
 <Y9PtHUONh2ImQyKF@x1n>
 <d8c30ea7-05a1-d53b-1391-472ff5b2a7fd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8c30ea7-05a1-d53b-1391-472ff5b2a7fd@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 01:38:16PM +0500, Muhammad Usama Anjum wrote:
> On 1/27/23 8:32 PM, Peter Xu wrote:
> > On Fri, Jan 27, 2023 at 11:47:14AM +0500, Muhammad Usama Anjum wrote:
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 4000e9f017e0..8c03b133d483 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> >>>>  
> >>>>  	if (likely(!unshare)) {
> >>>>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> >>>> +			if (userfaultfd_wp_async(vma)) {
> >>>> +				/*
> >>>> +				 * Nothing needed (cache flush, TLB invalidations,
> >>>> +				 * etc.) because we're only removing the uffd-wp bit,
> >>>> +				 * which is completely invisible to the user. This
> >>>> +				 * falls through to possible CoW.
> >>>
> >>> Here it says it falls through to CoW, but..
> >>>
> >>>> +				 */
> >>>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> >>>> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
> >>>> +					   pte_clear_uffd_wp(*vmf->pte));
> >>>> +				return 0;
> >>>
> >>> ... it's not doing so.  The original lines should do:
> >>>
> >>> https://lore.kernel.org/all/Y8qq0dKIJBshua+X@x1n/
> > 
> > [1]
> > 
> >>>
> >>> Side note: you cannot modify pgtable after releasing the pgtable lock.
> >>> It's racy.
> >> If I don't unlock and return after removing the UFFD_WP flag in case of
> >> async wp, the target just gets stuck. Maybe the pte lock is not unlocked in
> >> some path.
> >>
> >> If I unlock and don't return, the crash happens.
> >>
> >> So I'd put unlock and return from here. Please comment on the below patch
> >> and what do you think should be done. I've missed something.
> > 
> > Have you tried to just use exactly what I suggested in [1]?  I'll paste
> > again:
> > 
> > ---8<---
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 4000e9f017e0..09aab434654c 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3351,8 +3351,20 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > 
> >         if (likely(!unshare)) {
> >                 if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> > -                       pte_unmap_unlock(vmf->pte, vmf->ptl);
> > -                       return handle_userfault(vmf, VM_UFFD_WP);
> > +                       if (userfaultfd_uffd_wp_async(vma)) {
> > +                               /*
> > +                                * Nothing needed (cache flush, TLB
> > +                                * invalidations, etc.) because we're only
> > +                                * removing the uffd-wp bit, which is
> > +                                * completely invisible to the user.
> > +                                * This falls through to possible CoW.
> > +                                */
> > +                               set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
> > +                                          pte_clear_uffd_wp(*vmf->pte));
> > +                       } else {
> > +                               pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +                               return handle_userfault(vmf, VM_UFFD_WP);
> > +                       }
> >                 }
> > ---8<---
> > 
> > Note that there's no "return", neither the unlock.  The lock is used in the
> > follow up write fault resolution and it's released later.
> I've tried out the exact patch above. This doesn't work. The pages keep
> their WP flag even after being resolved in do_wp_page() while is written on
> the page.
> 
> So I'd added pte_unmap_unlock() and return 0 from here. This makes the
> patch to work. Maybe you can try this on your end to see what I'm seeing here?

Oh maybe it's because it didn't update orig_pte.  If you want, you can try
again with doing so by changing:

  set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
             pte_clear_uffd_wp(*vmf->pte));

into:

  pte_t pte = pte_clear_uffd_wp(*vmf->pte);
  set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
  /* Update this to be prepared for following up CoW handling */
  vmf->orig_pte = pte;

> 
> > 
> > Meanwhile please fully digest how pgtable lock is used in this path before
> > moving forward on any of such changes.
> > 
> >>
> >>>
> >>>> +			}
> >>>>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
> >>>>  			return handle_userfault(vmf, VM_UFFD_WP);
> >>>>  		}
> >>>> @@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
> >>>>  
> >>>>  	if (vma_is_anonymous(vmf->vma)) {
> >>>>  		if (likely(!unshare) &&
> >>>> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
> >>>> -			return handle_userfault(vmf, VM_UFFD_WP);
> >>>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
> >>>> +			if (userfaultfd_wp_async(vmf->vma)) {
> >>>> +				/*
> >>>> +				 * Nothing needed (cache flush, TLB invalidations,
> >>>> +				 * etc.) because we're only removing the uffd-wp bit,
> >>>> +				 * which is completely invisible to the user. This
> >>>> +				 * falls through to possible CoW.
> >>>> +				 */
> >>>> +				set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
> >>>> +					   pmd_clear_uffd_wp(*vmf->pmd));
> >>>
> >>> This is for THP, not hugetlb.
> >>>
> >>> Clearing uffd-wp bit here for the whole pmd is wrong to me, because we
> >>> track writes in small page sizes only.  We should just split.
> >> By detecting if the fault is async wp, just splitting the PMD doesn't work.
> >> The below given snippit is working right now. But definately, the fault of
> >> the whole PMD is being resolved which if we can bypass by correctly
> >> splitting would be highly desirable. Can you please take a look on UFFD
> >> side and suggest the changes? It would be much appreciated. I'm attaching
> >> WIP v9 patches for you to apply on next(next-20230105) and pagemap_ioctl
> >> selftest can be ran to test things after making changes.
> > 
> > Can you elaborate why thp split didn't work?  Or if you want, I can look
> > into this and provide the patch to enable uffd async mode.
> Sorry, I was doing the wrong way. Splitting the page does work. What do you
> think about the following:
> 
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3351,6 +3351,17 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> 
>  	if (likely(!unshare)) {
>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> +			if (userfaultfd_wp_async(vma)) {
> +				/*
> +				 * Nothing needed (cache flush, TLB invalidations,
> +				 * etc.) because we're only removing the uffd-wp bit,
> +				 * which is completely invisible to the user.
> +				 */
> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
> +					   pte_clear_uffd_wp(*vmf->pte));
> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> +				return 0;

Please give it a shot with above to see whether we can avoid the "return 0"
here.

> +			}
>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>  			return handle_userfault(vmf, VM_UFFD_WP);
>  		}
> @@ -4812,8 +4823,13 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault
> *vmf)
> 
>  	if (vma_is_anonymous(vmf->vma)) {
>  		if (likely(!unshare) &&
> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
> +			if (userfaultfd_wp_async(vmf->vma)) {
> +				__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
> +				return 0;

Same here, I hope it'll work for you if you just goto __split_huge_pmd()
right below and return with VM_FAULT_FALLBACK.  It avoids one more round of
fault just like the pte case above.

> +			}
>  			return handle_userfault(vmf, VM_UFFD_WP);
> +		}
>  		return do_huge_pmd_wp_page(vmf);
>  	}

-- 
Peter Xu

