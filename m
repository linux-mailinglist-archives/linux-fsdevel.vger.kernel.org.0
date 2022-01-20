Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174F14949CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359366AbiATIq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359357AbiATIqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:46:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D3C06173F;
        Thu, 20 Jan 2022 00:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fc144p+00WPTTP0zDhiznn2Saihska6K3bXQ86DJDN8=; b=zvTVKUKQd9PEBeP/epohTKoS+l
        or0ElzDA6K1hJ+W7u12fMmcQpP7gHqMjL3UzuuGFGloW2ww1X/tKQiBNw7gj+Fj7abYWevriIOS6H
        1GzCib8DXwF5Hr1I6wLxqUm6hPlDb58oR7iQ5ohv5nmbRvA7GXelUVCdaF4HjMlyS7E+/ZxcG9XH0
        09qYIkZ//VSEouo9f4Uy3qffJOfHEiW1mS8AfmNQpZTvyqZPB4iNotwURjoiG8xOk9mM4ndDLy1sp
        z3qtmtboIzdqQc863Ssh+x57Dn1FKDdh26S8CkLMnfMD5neyvmq3y7BR5cJwcJb9R0BU973hNaXU2
        r6+tKmWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAT5I-009tD3-5C; Thu, 20 Jan 2022 08:46:20 +0000
Date:   Thu, 20 Jan 2022 00:46:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
Message-ID: <YekhXENAEYJJNy7e@infradead.org>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
 <20220105181230.GC398655@magnolia>
 <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
 <20220105185626.GE398655@magnolia>
 <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
 <20220105224727.GG398655@magnolia>
 <CAPcyv4iZ88FPeZC1rt_bNdWHDZ5oh7ua31NuET2-oZ1UcMrH2Q@mail.gmail.com>
 <20220105235407.GN656707@magnolia>
 <CAPcyv4gUmpDnGkhd+WdhcJVMP07u+CT8NXRjzcOTp5KF-5Yo5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gUmpDnGkhd+WdhcJVMP07u+CT8NXRjzcOTp5KF-5Yo5g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 04:12:04PM -0800, Dan Williams wrote:
> We ended up with explicit callbacks after hch balked at a notifier
> call-chain, but I think we're back to that now. The partition mistake
> might be unfixable, but at least bdev_dax_pgoff() is dead. Notifier
> call chains have their own locking so, Ruan, this still does not need
> to touch dax_read_lock().

I think we have a few options here:

 (1) don't allow error notifications on partitions.  And error return from
     the holder registration with proper error handling in the file
     system would give us that
 (2) extent the holder mechanism to cover a range
 (3) bite the bullet and create a new stacked dax_device for each
     partition

I think (1) is the best option for now.  If people really do need
partitions we'll have to go for (3)
