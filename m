Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EC6BBDAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 20:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjCOTzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjCOTyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723F0193D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678910039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woVT10ZvTBDEkwPsfEHU2WbSYTau3o/cURF+myIHKzc=;
        b=KxiJKpNj8LIXwLq0PR4B47GmZnabSEbTXU0sFBGhqRa+TZce/U2H9wuD4Q+LDn44KwRMmx
        igs6L7msAlh+bZoptvftet2Hi7rjENz/A0aCezvA3VIXqYSu2NiEoM/hNbw3fx4hgV1Fgp
        LhY1M07FPDT7/WH42RzLCgldys9nLLc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-bRHxXvmgN_eblCt---eGqw-1; Wed, 15 Mar 2023 15:53:50 -0400
X-MC-Unique: bRHxXvmgN_eblCt---eGqw-1
Received: by mail-qk1-f199.google.com with SMTP id pc36-20020a05620a842400b00742c715894bso11824803qkn.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 12:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678910030; x=1681502030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woVT10ZvTBDEkwPsfEHU2WbSYTau3o/cURF+myIHKzc=;
        b=5qSy2Af0tLghE3zgK5YUEn7UO73JaDoLKNI+XIvbR8oo4wIDGTXcihUJb0IAOnCWZh
         ZlkDsFhAXQTA3pt3QtJpxdEXYGyozkBIKqD9cyt6P6L+WcvFMnokWe1Byvy/MWy2n5UF
         u1hO+FX4PZm4wtfmCgI9djpLEY4VL23KLA8fMjkhtfI7bNbJ3SK01jQg8F6dnqHQq9cp
         yK07szDH+gWSMjTECiCj7eIHaS4YQfsF6afLCkaWJBrShclEAb3VRUNt19mKCfjA1Mfd
         +3w2zGq1iwkCvjed6jhtTbjWejQKHnTjF59TweIwxMqxrQouhh8hDS0AlWm9z2x1Cvja
         2lnw==
X-Gm-Message-State: AO0yUKVzjY8jVVRa2dkzTGI1o/6XlCFhzgB/25CQ/TH1iuHScOan1jUa
        lSSXbOiDwazBPhIrFbgmAEvOS8JTusCZO/WSG72OneCYxG0kx3SEoLxNVL+C/ub7g2nOfFrC3or
        yLpxBjo8O7ZbdywQch/dyotzMqg==
X-Received: by 2002:a05:622a:64f:b0:3bf:a564:573b with SMTP id a15-20020a05622a064f00b003bfa564573bmr8006368qtb.0.1678910030291;
        Wed, 15 Mar 2023 12:53:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set+YTOsYq99xGXjreXVl31GgX6FpNk3Wo+WVqNbF2kHRbcCNbb1E4jkD9EHxOg3lsUoFTmcIMw==
X-Received: by 2002:a05:622a:64f:b0:3bf:a564:573b with SMTP id a15-20020a05622a064f00b003bfa564573bmr8006333qtb.0.1678910029944;
        Wed, 15 Mar 2023 12:53:49 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id p22-20020a374216000000b0074374e2b630sm4309024qka.119.2023.03.15.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:53:49 -0700 (PDT)
Date:   Wed, 15 Mar 2023 15:53:47 -0400
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
Subject: Re: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZBIiSwmbOsuaImIf@x1n>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com>
 <ZBHqjBjj6nn1xeTM@x1n>
 <3d2d1ba4-bfab-6b3d-f0d6-ae0920ebdcb0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2d1ba4-bfab-6b3d-f0d6-ae0920ebdcb0@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:54:40PM +0500, Muhammad Usama Anjum wrote:
> On 3/15/23 8:55 PM, Peter Xu wrote:
> > On Thu, Mar 09, 2023 at 06:57:15PM +0500, Muhammad Usama Anjum wrote:
> >> +	for (addr = start; !ret && addr < end; pte++, addr += PAGE_SIZE) {
> >> +		pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> >> +
> >> +		is_writ = !is_pte_uffd_wp(*pte);
> >> +		is_file = vma->vm_file;
> >> +		is_pres = pte_present(*pte);
> >> +		is_swap = is_swap_pte(*pte);
> >> +
> >> +		pte_unmap_unlock(pte, ptl);
> >> +
> >> +		ret = pagemap_scan_output(is_writ, is_file, is_pres, is_swap,
> >> +					  p, addr, 1);
> >> +		if (ret)
> >> +			break;
> >> +
> >> +		if (PM_SCAN_OP_IS_WP(p) && is_writ &&
> >> +		    uffd_wp_range(walk->mm, vma, addr, PAGE_SIZE, true) < 0)
> >> +			ret = -EINVAL;
> >> +	}
> > 
> > This is not real atomic..
> > 
> > Taking the spinlock for eacy pte is not only overkill but wrong in
> > atomicity because the pte can change right after spinlock unlocked.
> Let me explain. It seems like wrong, but it isn't. In my rigorous testing,
> it didn't show any side-effect.  Here we are finding out if a page is
> written. If page is written, only then we clear it. Lets look at the
> different possibilities here:
> - If a page isn't written, we'll not clear it.
> - If a page is written and there isn't any race, we'll clear written-to
> flag by write protecting it.
> - If a page is written but before clearing it, data is written again to the
> page. The page would remain written and we'll clear it.
> - If a page is written but before clearing it, it gets write protected,
> we'll still write protected it. There is double right protection here, but
> no side-effect.
> 
> Lets turn this into a truth table for easier understanding. Here first
> coulmn and thrid column represents this above code. 2nd column represents
> any other thread interacting with the page.
> 
> If page is written/dirty	some other task interacts	wp_page
> no				does nothing			no
> no				writes to page			no
> no				wp the page			no
> yes				does nothing			yes
> yes				write to page			yes
> yes				wp the page			yes
> 
> As you can see there isn't any side-effect happening. We aren't over doing
> the wp or under-doing the write-protect.
> 
> Even if we were doing something wrong here and I bring the lock over all of
> this, the pages get become written or wp just after unlocking. It is
> expected. This current implementation doesn't seem to be breaking this.
> 
> Is my understanding wrong somewhere here? Can you point out?

Yes you're right.  With is_writ check it looks all fine.

> 
> Previous to this current locking design were either buggy or slower when
> multiple threads were working on same pages. Current implementation removes
> the limitations:
> - The memcpy inside pagemap_scan_output is happening with pte unlocked.

Why this has anything to worry?  Isn't that memcpy only applies to a
page_region struct?

> - We are only wp a page if we have noted this page to be dirty
> - No mm write lock is required. Only read lock works fine just like
> userfaultfd_writeprotect() takes only read lock.

I didn't even notice you used to use write lock.  Yes I think read lock is
suffice here.

> 
> There is only one con here that we are locking and unlocking the pte lock
> again and again.
> 
> Please have a look at my explanation and let me know what do you think.

I think this is fine as long as the semantics is correct, which I believe
is the case.  The spinlock can be optimized, but it can be done on top if
needs more involved changes.

> 
> > 
> > Unfortunately you also cannot reuse uffd_wp_range() because that's not
> > atomic either, my fault here.  Probably I was thinking mostly from
> > soft-dirty pov on batching the collect+reset.
> > 
> > You need to take the spin lock, collect whatever bits, set/clear whatever
> > bits, only until then release the spin lock.
> > 
> > "Not atomic" means you can have some page got dirtied but you could miss
> > it.  Depending on how strict you want, I think it'll break apps like CRIU
> > if strict atomicity needed for migrating a process.  If we want to have a
> > new interface anyway, IMHO we'd better do that in the strict way.
> In my rigorous multi-threaded testing where a lots of threads are working
> on same set of pages, we aren't losing even a single update. I can share
> the test if you want.

Good to have tests covering that.  I'd say you can add the test into
selftests along with the series when you repost if it's convenient.  It can
be part of an existing test or it can be a new one under mm/.

Thanks,

-- 
Peter Xu

