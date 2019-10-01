Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6363C36F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfJAOUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 10:20:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34121 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbfJAOUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:20:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id p10so12105598edq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jW7eXDdGpzoPqCGQ/N/Pe4qVEBLi12b1nAQpyDAd19Q=;
        b=saWObvKZ+2SD8KboWxSXVO4qJxtT2dlC90wePqcBMjuIQ16RhK1fhrPTLJrwlldyQf
         ELqbo5Zcx/a0uGVlJDOC7M9+6tIvOz1d5MOefIkpGNakWSPKTla9TB8saKYRQnnpsA0k
         OTl9mp1bToCTT2Za3zOjdzA+aS61WXFprYGqtObLzk3dRe7tS/P7H88cYkXApEwLVksm
         5ADB2qQWBR1fp7sgE35A6Fo9GOvEuxEmzQx8wUyUj+RyAxAww7KG3kXgmWywMS3YDcpy
         qIZTVPd/WYVKU2OIHHdS284uCNknaakxIFU/AFUYPUueVMfJqrn/zhKTp+9AiBmtPGca
         jBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jW7eXDdGpzoPqCGQ/N/Pe4qVEBLi12b1nAQpyDAd19Q=;
        b=UMJOtur7nJyBqSeiI474Vw71pgoATJy4PIuSf7tj2v2MTMq9FlJsFz0KBzpj+HimwM
         L6ZKYncKeDfTTEend3NkrqGYPynnAzaJW1wex6AITA33roxcdQMnWgE/Yu7ENAdR1Twx
         fy6Vv9hQ6mmuiSMyMWLdK59x7QwshRXX4scxmTGeeRvJVei6n1rJMeoFVDZDBsFs4zEA
         UVbld6j8izKIQLkzwBPC9ta/4pzXcKur15mSKRKBfxRb0FHN9h6yDxGK0zRNmvIcJPMu
         By+7xOfDkoLVZrShHkzhNRicTgMjwJQRhYSou9H+Qy62AlqMW3aYRN8yO6XmkVVf4per
         ga4A==
X-Gm-Message-State: APjAAAUDgFCSUmmR4ccbOHVhVzjIxH5rQ4wuapw/CdbBEniiZXWTyypj
        bCQevDYRe72WpgCwuN7eVdkpcw==
X-Google-Smtp-Source: APXvYqxMumpbaDDZhfyPxjux2WynqitCyDnI8AW4aNzJk7qqt9bGOvfbWjUKvhnOcREwF/sAhreYKA==
X-Received: by 2002:aa7:dc55:: with SMTP id g21mr25526019edu.210.1569939618577;
        Tue, 01 Oct 2019 07:20:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o26sm3143696edi.23.2019.10.01.07.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:20:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 51D61102FB8; Tue,  1 Oct 2019 17:20:18 +0300 (+03)
Date:   Tue, 1 Oct 2019 17:20:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
Message-ID: <20191001142018.wpordswdkadac6kt@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
 <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
 <20191001113216.3qbrkqmb2b2xtwkd@box>
 <5dc7b5c1-6d7d-90ee-9423-6eda9ecb005c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc7b5c1-6d7d-90ee-9423-6eda9ecb005c@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:18:28AM -0600, William Kucharski wrote:
> 
> 
> On 10/1/19 5:32 AM, Kirill A. Shutemov wrote:
> > On Tue, Oct 01, 2019 at 05:21:26AM -0600, William Kucharski wrote:
> > > 
> > > 
> > > > On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > 
> > > > On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
> > > > > 
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > index cbe7d0619439..670a1780bd2f 100644
> > > > > --- a/mm/huge_memory.c
> > > > > +++ b/mm/huge_memory.c
> > > > > @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
> > > > > 
> > > > > 	if (addr)
> > > > > 		goto out;
> > > > > -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> > > > > -		goto out;
> > > > > 
> > > > > 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
> > > > > 	if (addr)
> > > > 
> > > > I think you reducing ASLR without any real indication that THP is relevant
> > > > for the VMA. We need to know if any huge page allocation will be
> > > > *attempted* for the VMA or the file.
> > > 
> > > Without a properly aligned address the code will never even attempt allocating
> > > a THP.
> > > 
> > > I don't think rounding an address to one that would be properly aligned to map
> > > to a THP if possible is all that detrimental to ASLR and without the ability to
> > > pick an aligned address it's rather unlikely anyone would ever map anything to
> > > a THP unless they explicitly designate an address with MAP_FIXED.
> > > 
> > > If you do object to the slight reduction of the ASLR address space, what
> > > alternative would you prefer to see?
> > 
> > We need to know by the time if THP is allowed for this
> > file/VMA/process/whatever. Meaning that we do not give up ASLR entropy for
> > nothing.
> > 
> > For instance, if THP is disabled globally, there is no reason to align the
> > VMA to the THP requirements.
> 
> I understand, but this code is in thp_get_unmapped_area(), which is only called
> if THP is configured and the VMA can support it.
> 
> I don't see it in Matthew's patchset, so I'm not sure if it was inadvertently
> missed in his merge or if he has other ideas for how it would eventually be
> called, but in my last patch revision the code calling it in do_mmap()
> looked like this:
> 
> #ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>         /*
>          * If THP is enabled, it's a read-only executable that is
>          * MAP_PRIVATE mapped, the length is larger than a PMD page
>          * and either it's not a MAP_FIXED mapping or the passed address is
>          * properly aligned for a PMD page, attempt to get an appropriate
>          * address at which to map a PMD-sized THP page, otherwise call the
>          * normal routine.
>          */
>         if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
>                 (!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
>                 (!(flags & MAP_FIXED)) && len >= HPAGE_PMD_SIZE) {

len and MAP_FIXED is already handled by thp_get_unmapped_area().

	if (prot & (PROT_READ|PROT_WRITE|PROT_READ) == (PROT_READ|PROT_EXEC) &&
		(flags & MAP_PRIVATE)) {


>                 addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
> 
>                 if (addr && (!(addr & ~HPAGE_PMD_MASK))) {

This check is broken.

For instance, if pgoff is one, (addr & ~HPAGE_PMD_MASK) has to be equal to
PAGE_SIZE to have chance to get a huge page in the mapping.

>                         /*
>                          * If we got a suitable THP mapping address, shut off
>                          * VM_MAYWRITE for the region, since it's never what
>                          * we would want.
>                          */
>                         vm_maywrite = 0;

Wouldn't it break uprobe, for instance?

>                 } else
>                         addr = get_unmapped_area(file, addr, len, pgoff, flags);
>         } else {
> #endif
> 
> So I think that meets your expectations regarding ASLR.
> 
>    -- Bill

-- 
 Kirill A. Shutemov
