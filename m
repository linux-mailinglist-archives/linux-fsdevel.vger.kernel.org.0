Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC62E3D463C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhGXHY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhGXHY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 03:24:57 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1683C061575;
        Sat, 24 Jul 2021 01:05:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r6so5285145ioj.8;
        Sat, 24 Jul 2021 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SULVsagS4dB16WkbeqR+XAZ1fs3eU5Cq64+TOTbFWY=;
        b=hCsvguMMppyHLeUqzy7b/2A0qHFFJVBIADGsDmSCI8yECsuZ2jO3mPcqJZx0aeRnJC
         R63o6SfNDxboorkvGgwv0Bl3oESZyIursuPhDgTYp4JYtm41hOFDdvttr/HLEaEiVS8r
         LVbajxGI2vBRj+hRzdTOUYlqSqTkO5iPnGBQTARhcYacMY7XZQCIAUMTTmKyB8sKevUY
         fbFAQu/TOena2uYMzK0Ud3wTzLZkemjmOnV8fLZqEcgU2KOu4DHRHHs95tZXUBw6a+bT
         x0B1bz59erq+fUFGyq2k3hlXy3BvI5pmjoNWyj6IDAU2eNE01O+cgq+VYx/8olyZyZR0
         QhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SULVsagS4dB16WkbeqR+XAZ1fs3eU5Cq64+TOTbFWY=;
        b=XS5OoJz8c30KVHWLCTC8fYwNFS3nJ25Uu7xzg/mt6LtreYjygptp3F9GFUPWCOab8P
         xE2iP5dcyXaMmyiPiaL/J+kVx7m8o0HNiwzxdn1DWsfeODN0STbcVcYhshjKHQzOjQCi
         zjo9N2tD10gWbEQMCzd/Fs2eCkXYKTgEaTb8+0sOSWxP6Sh3QC8LBPqdyA1Awtx7vtMX
         3bFIN37sgu7m/6UR8YycqdSwTETebH5FAxj62PMsJdgLBdbDeUhX0MFCaNdSPD4dUH0u
         9EyMWHkUv5n2CyBMoXqJzhmeEaB7ftobDln4luQOg/ahMn3o32OePum1/C/X1sEcCEvi
         J+Eg==
X-Gm-Message-State: AOAM533fw/+DmS/4+vVv6vTY+FWh6E4i+dxNkpUYOsjyh548br7RPHBx
        dmGKN/0sekA0y0tOLTdUNZlbNcLydC2hDAMHYfk=
X-Google-Smtp-Source: ABdhPJxujkiDiDqSey8xGa8tGJOhl/wcoSF3auaSX6xq2RVAuE/Dqs2TFuW2iEIVRWFbyuCBwT/HU3fK4Z6wdjYmxSY=
X-Received: by 2002:a6b:c90f:: with SMTP id z15mr6718749iof.183.1627113929048;
 Sat, 24 Jul 2021 01:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210723205840.299280-1-agruenba@redhat.com> <20210723205840.299280-2-agruenba@redhat.com>
 <YPtyRgyGqJX4Ya/R@zeniv-ca.linux.org.uk>
In-Reply-To: <YPtyRgyGqJX4Ya/R@zeniv-ca.linux.org.uk>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Sat, 24 Jul 2021 10:05:17 +0200
Message-ID: <CAHpGcMJThSqjowuEGCzjNFN8y5tq8kxmxfSivwtuTEMK_xd-cQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Sa., 24. Juli 2021 um 03:53 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> On Fri, Jul 23, 2021 at 10:58:34PM +0200, Andreas Gruenbacher wrote:
> > Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> > Other than fault_in_pages_writeable(), this function is non-destructive.
> >
> > We'll use fault_in_iov_iter in gfs2 once we've determined that the iterator
> > passed to .read_iter or .write_iter isn't in memory.
>
> Hmm...  I suspect that this is going to be much heavier for read access
> than the existing variant.  Do we ever want it for anything other than
> writes?

I don't know if it actually is slower when pages need to be faulted
in, but I'm fine turning it into a write-only function.

Thanks,
Andreas
