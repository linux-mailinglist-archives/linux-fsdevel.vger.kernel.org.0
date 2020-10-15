Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EAB28EF82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbgJOJnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbgJOJnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:43:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C5C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 02:43:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d24so2434939ljg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5gLMYh6tiv5jrOp8DDHnBYYv5xjV9PK4XVv2LHi9HE=;
        b=M0zz6chPROoVSVOCZC0aLZ1gj+BhaQ6Ov/AvatoQ8JrkYfLr7MRn3CRZr7L7jCjGDa
         D9O2uYXHGdoUZ7kuPGnWxvcjpopWkDVwdzvdyYgsKIWZ9IZf7uc9Yk9sHq++vsnqYxg1
         ZBOdKMBU1QWUS3C3TR4JihECrrELTBnV6+410JYbWQcc4d6S1mL91OZHJObaTYvNAEPz
         c9fRxv+/tGJB92OH8BYZsbxTRJ+SECrPMAFyPASNxYE5ZPHPjBQ3/Ir+jCgyjta62fWn
         g5cVAoIaQBBVN1pO+i8D6B7U7VPMF6Rv3lzl1cu89UUG9aok3BCL4vBDR3fpyD3Sd/aJ
         vVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5gLMYh6tiv5jrOp8DDHnBYYv5xjV9PK4XVv2LHi9HE=;
        b=jt90gdl9AKwtzCAoJ6G2flJkzwv52KiHCd7cPpXsSMmdXAx1J5WMr3OOk2KmSy/3A+
         teQpj3Kh6LSmE7K11xFc/OcEV6BIkNQZwvOOyLbOd6pr4NdV35xcVynG0ozyMAk8TF6e
         iXup6tPA1mE+hgjerdENmWx9MCSrC9OFp52P6pGggaYZ//UenZ86u46Miao+vwxzYBCl
         P9hg29wBmKgCrZ/SQxdrxvsre7ojxCF5eQxtpm7dc+FkNyjjGpIpbFjye/VBdlJI08dj
         VpTl+Bc1YDF95Cw4EWKsXXwbF9SWUp0bk7jye3sJTgJVZ9nYcPO4zVFppXHDoNsimB/g
         mOOg==
X-Gm-Message-State: AOAM533B7Bvf21+3fiqLs3iwX4ulTss85wOAvZqwD49JFsu/nanisyuh
        dDuKK50KzH6zFTk5d77+Vp2vpw==
X-Google-Smtp-Source: ABdhPJz4F33dFkInG4mtppG2zYRso/KoI52LxAW4cL/ghmUDvzUcQIRmZrmsVFfkmGSsPJnj+N0chw==
X-Received: by 2002:a2e:9148:: with SMTP id q8mr990058ljg.182.1602755019168;
        Thu, 15 Oct 2020 02:43:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p14sm857738lfc.40.2020.10.15.02.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 02:43:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 12A851023C1; Thu, 15 Oct 2020 12:43:44 +0300 (+03)
Date:   Thu, 15 Oct 2020 12:43:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
Message-ID: <20201015094344.pmvg2jxrb2bsoanr@box>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com>
 <20201014130555.kdbxyavqoyfnpos3@box>
 <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:53:35AM -0700, Linus Torvalds wrote:
> In particular, what I _think_ we could do is:
> 
>  - lock the page tables
> 
>  - check that the page isn't locked
> 
>  - increment the page mapcount (atomic and ordered)
> 
>  - check that the page still isn't locked
> 
>  - insert pte
> 
> without taking the page lock. And the reason that's safe is that *if*
> we're racing with something that is about the remove the page mapping,
> then *that* code will
> 
>  (a) hold the page lock
> 
>  (b) before it removes the mapping, it has to remove it from any
> existing mappings, which involves checking the mapcount and going off
> and getting the page table locks to remove any ptes.
> 
> but my patch did *not* do that, because you have to re-organize things a bit.

Okay, I see what you propose.

But I don't think it addresses race with try_to_unmap():

	CPU0				CPU1
filemap_map_pages()
  take ptl
  PageLocked() == false
 				lock_page()
				try_to_unmap()
				  rwc->done()
				    page_mapcount_is_zero() == true
				  rwc->done() == true, skip full rmap walk
				  never take ptl taken by CPU0
				try_to_unmap() == true
				...
				unlock_page()
  increment mapcount
  PageLocked() == false
  insert PTE

Are we willing to give up rwc->done() optimization?
Or do I miss some other serialization point?

-- 
 Kirill A. Shutemov
