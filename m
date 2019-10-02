Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9DC44D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 02:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJBAP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 20:15:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46321 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfJBAPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:15:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3so13575485edw.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 17:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hssg091wPGh70kq4IclYwYoqi2SbHSQw2ojdCBcYtjg=;
        b=sUG/hAV5gUvFOwJrYb5i/jzGN7avy4aABIK7HzAPTA9gnZJ0cEoGYJvsrlBSW/ARid
         I2VlGDwOkTMyNM70TYVZl17Cy828CvMV5sAzqbSQKz0JBYqwbMsbM+A2CGEHOqEQulfz
         Mq/9Qpne5q2QxVNlgQZfYRU19PtJoWVyZRwuXGiueBgUzITHAZyzydtJUIt3Zj1HvisH
         ailYrTPwfulOB+Zz3qzk6VRZ6ksp2kXJ55zeKrHlBSn1DKAlJhEGoat0FrGEF5FZ0LuK
         S/6kkbBoZK8PR6oRM0F2upxD3IHo767gmVyHv9Y8iFbE1ZqTocI/H5fSSjWB3v3TgnRw
         +Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hssg091wPGh70kq4IclYwYoqi2SbHSQw2ojdCBcYtjg=;
        b=dTqeh7mDBIzWkUTpdBHMUXV4Lq2LPp0B8bsyYNd3UbCEcnYibt1S6jpA7jO+JMqY+7
         8+1scM1wYiFe3Th28hhLkq6Pzwwvyg78uW1Zo+oYp39Xrj/248VyMi1/UDW5MgkuSBCb
         G0UNRr0so3q/wFFV3ad6U9msL42qGscUF4ysXTklRZp0/qwANFAL9j67NxUKrZdKhY+l
         TKoVejTYOIRQsVOj1AchwjQ9+fv7wYVLmtdejA2/b9VnDEFAOh1W2ZLUj4iJpS4VExda
         5HHn3GrmK6xmxPAM8Wom2OqsoAJ41GaCcTpP+eg6czWRtnHGks8r3mmH/IYfp8UWcSDA
         4fFg==
X-Gm-Message-State: APjAAAVyXvf/5aJAmWnpsKBcTr2xTcz75KOzrBpQQ1vLdKHl/0JVKL01
        XISr2OYhornzKp7Tn+9NbegsNQ==
X-Google-Smtp-Source: APXvYqxm4E66L7PYZqx0zX9Tu97iAJmOn2ArTlYXkYefnaJW8prrXFNXTMtkeRwPQy/yKCMC5QkNAQ==
X-Received: by 2002:a17:906:5a96:: with SMTP id l22mr716817ejq.310.1569975321992;
        Tue, 01 Oct 2019 17:15:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b53sm3489554ede.96.2019.10.01.17.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 17:15:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 27B1E10202F; Wed,  2 Oct 2019 03:15:21 +0300 (+03)
Date:   Wed, 2 Oct 2019 03:15:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
Message-ID: <20191002001521.agi22gnscsitznqd@box.shutemov.name>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
 <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
 <20191001113216.3qbrkqmb2b2xtwkd@box>
 <5dc7b5c1-6d7d-90ee-9423-6eda9ecb005c@oracle.com>
 <20191001142018.wpordswdkadac6kt@box>
 <85868A27-CA43-4AF5-B8A0-2D037C2207FD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85868A27-CA43-4AF5-B8A0-2D037C2207FD@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:08:30AM -0600, William Kucharski wrote:
> 
> 
> > On Oct 1, 2019, at 8:20 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Tue, Oct 01, 2019 at 06:18:28AM -0600, William Kucharski wrote:
> >> 
> >> 
> >> On 10/1/19 5:32 AM, Kirill A. Shutemov wrote:
> >>> On Tue, Oct 01, 2019 at 05:21:26AM -0600, William Kucharski wrote:
> >>>> 
> >>>> 
> >>>>> On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >>>>> 
> >>>>> On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
> >>>>>> 
> >>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>> index cbe7d0619439..670a1780bd2f 100644
> >>>>>> --- a/mm/huge_memory.c
> >>>>>> +++ b/mm/huge_memory.c
> >>>>>> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
> >>>>>> 
> >>>>>> 	if (addr)
> >>>>>> 		goto out;
> >>>>>> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> >>>>>> -		goto out;
> >>>>>> 
> >>>>>> 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
> >>>>>> 	if (addr)
> >>>>> 
> >>>>> I think you reducing ASLR without any real indication that THP is relevant
> >>>>> for the VMA. We need to know if any huge page allocation will be
> >>>>> *attempted* for the VMA or the file.
> >>>> 
> >>>> Without a properly aligned address the code will never even attempt allocating
> >>>> a THP.
> >>>> 
> >>>> I don't think rounding an address to one that would be properly aligned to map
> >>>> to a THP if possible is all that detrimental to ASLR and without the ability to
> >>>> pick an aligned address it's rather unlikely anyone would ever map anything to
> >>>> a THP unless they explicitly designate an address with MAP_FIXED.
> >>>> 
> >>>> If you do object to the slight reduction of the ASLR address space, what
> >>>> alternative would you prefer to see?
> >>> 
> >>> We need to know by the time if THP is allowed for this
> >>> file/VMA/process/whatever. Meaning that we do not give up ASLR entropy for
> >>> nothing.
> >>> 
> >>> For instance, if THP is disabled globally, there is no reason to align the
> >>> VMA to the THP requirements.
> >> 
> >> I understand, but this code is in thp_get_unmapped_area(), which is only called
> >> if THP is configured and the VMA can support it.
> >> 
> >> I don't see it in Matthew's patchset, so I'm not sure if it was inadvertently
> >> missed in his merge or if he has other ideas for how it would eventually be
> >> called, but in my last patch revision the code calling it in do_mmap()
> >> looked like this:
> >> 
> >> #ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> >>        /*
> >>         * If THP is enabled, it's a read-only executable that is
> >>         * MAP_PRIVATE mapped, the length is larger than a PMD page
> >>         * and either it's not a MAP_FIXED mapping or the passed address is
> >>         * properly aligned for a PMD page, attempt to get an appropriate
> >>         * address at which to map a PMD-sized THP page, otherwise call the
> >>         * normal routine.
> >>         */
> >>        if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
> >>                (!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
> >>                (!(flags & MAP_FIXED)) && len >= HPAGE_PMD_SIZE) {
> > 
> > len and MAP_FIXED is already handled by thp_get_unmapped_area().
> > 
> > 	if (prot & (PROT_READ|PROT_WRITE|PROT_READ) == (PROT_READ|PROT_EXEC) &&
> > 		(flags & MAP_PRIVATE)) {
> 
> It is, but I wanted to avoid even calling it if conditions weren't right.
> 
> Checking twice is non-optimal but I didn't want to alter the existing use of
> the routine for anon THP.

It's not used by anon THP. It used for DAX.

> > 
> > 
> >>                addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
> >> 
> >>                if (addr && (!(addr & ~HPAGE_PMD_MASK))) {
> > 
> > This check is broken.
> > 
> > For instance, if pgoff is one, (addr & ~HPAGE_PMD_MASK) has to be equal to
> > PAGE_SIZE to have chance to get a huge page in the mapping.
> > 
> 
> If the address isn't PMD-aligned, we will never be able to map it with a THP
> anyway.

The opposite is true. I tried to explain it few times, but let's try
again.

If the address here is PMD-aligned, it will get a mismatch with page cache
alignment.

Consider the case with 2 huge pages in page cache, starting at the
beginning of the file.

The key to understanding: huge pages always aligned naturally in page
cache. Page cache lives longer than any mapping of the file.

If user calls mmap(.pgoff = 1) and it returns PMD-aligned address, we will
never have a huge page in the mapping. At the PMD-aligned address you will
get the second 4k of the first huge page and you will have to map it with
PTE. At the second PMD-aligned address of the mapping, the situation will
repeat for the second huge page, again misaligned, PTE-mapped second
subpage.

The solution here is to return address aligned to PMD_SIZE + PAGE_SIZE, if
user asked for mmap(.pgoff = 1). The user will not get first huge page
mapped with PMD, because mapping truncates it from the beginning per user
request. But the second (and any following huge page) will land on the
right alignment and can be mapped with PMD.

Does it make sense?

> >>                        /*
> >>                         * If we got a suitable THP mapping address, shut off
> >>                         * VM_MAYWRITE for the region, since it's never what
> >>                         * we would want.
> >>                         */
> >>                        vm_maywrite = 0;
> > 
> > Wouldn't it break uprobe, for instance?
> 
> I'm not sure; does uprobe allow COW to insert the probe even for mappings
> explicitly marked read-only?

Yes. See FOLL_FORCE usage.

-- 
 Kirill A. Shutemov
