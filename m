Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B14321A52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 17:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfEQPIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 11:08:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40044 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfEQPIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 11:08:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id r136so5391941oie.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGIfXnKXpW5eMKxUMdzRkt44XId1MoiNVnAxGfKvpiQ=;
        b=NxNZPHkQ9m7afnPn+MzAQqWjc4b6NDowhfobUzGnErro91DDQhcbPCtV4yyPmQs5K/
         qHoNY3q3kg21Z1aKKfhVtA51efXEJSWMC+nqJfOqd/6Cxza+N0PESVDd5pxT7+8WWxJ8
         dZbrryqg4W1sKStoCFp33Wpzb60H7wUxxexYHFYmftwZiHvQx7ag+Qv71q7GSKVtf3Yv
         0YURKil61RhPfxk/xokqMuqcpKadv25cmmeCfUPGZVYy8ZS45CyPZ/lVBP6QJrWv4/nC
         v1/j1QVq4xm8msZpqCNnpxMl6+GJA9oIEyJXlJST7m7WnJ1/eAUMStAIB5yhR6N2QBgq
         J6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGIfXnKXpW5eMKxUMdzRkt44XId1MoiNVnAxGfKvpiQ=;
        b=dwo8+NPcgQDNDFaEkEKT/svYKxjHwa+n1nIc8Ee/s5b6JG2zNoXDcxclOjKAg/x4Iu
         zmFbIRHfRQ8a3XQR8Qs9e8l2A3xMSTlRFrHifsR+d/SLpn2Qcl1+TZjbtj0UzYlLBHVL
         DYhWdV/2cusKxFYxenkQwz5+alWASx/vL0A9mzVpIGUUSU4OGnCXcd/wRwZlxjaJRHyq
         Z/FchboD7npOPY50I2wgD/taUi0IG8mN0H9+UzWcAFlB8eab4JKsnH6c5UbfYROQyS60
         +7JMRurM96U8eFPwXJc84w8y+dmB3gzEk4r4thID5VF/Fa9MmTCg67dQvUIQSIfphJyi
         jGSw==
X-Gm-Message-State: APjAAAV4gHTHULBP8rLx5fF6JJTt9JZeL9oBUSCQO4ciZ/yI46qIUgfB
        2rKLnhSQDXz4Q9ZXhUutDx87/QsDNp+zfeU2QxI3BQ==
X-Google-Smtp-Source: APXvYqyTjO/s0rMdx1VgVCXo7bqh4zMktZXJwLahomPBvDpO+I4RjmmwQ75n8Xpfpye+mAWhmlTX6Dis4MloPOV9WcA=
X-Received: by 2002:aca:b641:: with SMTP id g62mr12196057oif.149.1558105718742;
 Fri, 17 May 2019 08:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
In-Reply-To: <20190517084739.GB20550@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 May 2019 08:08:27 -0700
Message-ID: <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
To:     Jan Kara <jack@suse.cz>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Smits <jeff.smits@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 1:47 AM Jan Kara <jack@suse.cz> wrote:
>
> Let's add Kees to CC for usercopy expertise...
>
> On Thu 16-05-19 17:33:38, Dan Williams wrote:
> > Jeff discovered that performance improves from ~375K iops to ~519K iops
> > on a simple psync-write fio workload when moving the location of 'struct
> > page' from the default PMEM location to DRAM. This result is surprising
> > because the expectation is that 'struct page' for dax is only needed for
> > third party references to dax mappings. For example, a dax-mapped buffer
> > passed to another system call for direct-I/O requires 'struct page' for
> > sending the request down the driver stack and pinning the page. There is
> > no usage of 'struct page' for first party access to a file via
> > read(2)/write(2) and friends.
> >
> > However, this "no page needed" expectation is violated by
> > CONFIG_HARDENED_USERCOPY and the check_copy_size() performed in
> > copy_from_iter_full_nocache() and copy_to_iter_mcsafe(). The
> > check_heap_object() helper routine assumes the buffer is backed by a
> > page-allocator DRAM page and applies some checks.  Those checks are
> > invalid, dax pages are not from the heap, and redundant,
> > dax_iomap_actor() has already validated that the I/O is within bounds.
>
> So this last paragraph is not obvious to me as check_copy_size() does a lot
> of various checks in CONFIG_HARDENED_USERCOPY case. I agree that some of
> those checks don't make sense for PMEM pages but I'd rather handle that by
> refining check_copy_size() and check_object_size() functions to detect and
> appropriately handle pmem pages rather that generally skip all the checks
> in pmem_copy_from/to_iter(). And yes, every check in such hot path is going
> to cost performance but that's what user asked for with
> CONFIG_HARDENED_USERCOPY... Kees?

As far as I can see it's mostly check_heap_object() that is the
problem, so I'm open to finding a way to just bypass that sub-routine.
However, as far as I can see none of the other block / filesystem user
copy implementations submit to the hardened checks, like
bio_copy_from_iter(), and iov_iter_copy_from_user_atomic() . So,
either those need to grow additional checks, or the hardened copy
implementation is targeting single object copy use cases, not
necessarily block-I/O. Yes, Kees, please advise.
