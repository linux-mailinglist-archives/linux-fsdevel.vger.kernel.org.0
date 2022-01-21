Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD8495830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 03:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378490AbiAUCWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 21:22:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36896 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348465AbiAUCWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:22:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A97D60AF7;
        Fri, 21 Jan 2022 02:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1A6C340E0;
        Fri, 21 Jan 2022 02:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642731722;
        bh=Ib+VTbQ6ifDdK93Yrsa7iKnj1Orhw5IdSp6Qa3JMJnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWQID3dOoEeuy/VyEJaIPm8nXOCwL1j8Uyqea1A4WJZSjpeCvnAhqI5nhA2hNwhdX
         EKGl8xibiNh7CFEtwRqEk7oE7SqIVG79JVcULOvzMavGBwnh0CMHlSE4/FYVNNsv9g
         lQ9Jono3igXtvjZeou7BfVW597dRTyUTKIWUwXRHwRQic5kgpMLlGNZ1H899LMFR0q
         78Fwuv2NRT+SlfeGeaTdYbRYt99giFZzWIrVKaXq1c1w7iBESemP2mYURrjWZOjFS9
         s2ocsZKkPjjbZGCEP49TtcdoHsfYPs8jiqw9YrA06lAZoqeCu13+m5Lqf/G8jret3l
         +ISlNdqZspUKQ==
Date:   Thu, 20 Jan 2022 18:22:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>, Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
Message-ID: <20220121022200.GG13563@magnolia>
References: <20220105181230.GC398655@magnolia>
 <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
 <20220105185626.GE398655@magnolia>
 <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
 <20220105224727.GG398655@magnolia>
 <CAPcyv4iZ88FPeZC1rt_bNdWHDZ5oh7ua31NuET2-oZ1UcMrH2Q@mail.gmail.com>
 <20220105235407.GN656707@magnolia>
 <CAPcyv4gUmpDnGkhd+WdhcJVMP07u+CT8NXRjzcOTp5KF-5Yo5g@mail.gmail.com>
 <YekhXENAEYJJNy7e@infradead.org>
 <76f5ed28-2df9-890e-0674-3ef2f18e2c2f@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76f5ed28-2df9-890e-0674-3ef2f18e2c2f@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 09:26:52AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/1/20 16:46, Christoph Hellwig 写道:
> > On Wed, Jan 05, 2022 at 04:12:04PM -0800, Dan Williams wrote:
> > > We ended up with explicit callbacks after hch balked at a notifier
> > > call-chain, but I think we're back to that now. The partition mistake
> > > might be unfixable, but at least bdev_dax_pgoff() is dead. Notifier
> > > call chains have their own locking so, Ruan, this still does not need
> > > to touch dax_read_lock().
> > 
> > I think we have a few options here:
> > 
> >   (1) don't allow error notifications on partitions.  And error return from
> >       the holder registration with proper error handling in the file
> >       system would give us that

Hm, so that means XFS can only support dax+pmem when there aren't
partitions in use?  Ew.

> >   (2) extent the holder mechanism to cover a rangeo

I don't think I was around for the part where "hch balked at a notifier
call chain" -- what were the objections there, specifically?  I would
hope that pmem problems would be infrequent enough that the locking
contention (or rcu expiration) wouldn't be an issue...?

> >   (3) bite the bullet and create a new stacked dax_device for each
> >       partition
> > 
> > I think (1) is the best option for now.  If people really do need
> > partitions we'll have to go for (3)
> 
> Yes, I agree.  I'm doing it the first way right now.
> 
> I think that since we can use namespace to divide a big NVDIMM into multiple
> pmems, partition on a pmem seems not so meaningful.

I'll try to find out what will happen if pmem suddenly stops supporting
partitions...

--D

> 
> --
> Thanks,
> Ruan.
> 
> 
