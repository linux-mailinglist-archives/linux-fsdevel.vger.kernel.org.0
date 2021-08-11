Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9B3E987E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 21:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhHKTRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 15:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhHKTRd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2319261008;
        Wed, 11 Aug 2021 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628709429;
        bh=HYP5EtxajWkABNMFHRo45yMkJeoxaVDZxIAzfo20Yl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHq64V+fcbZHO4BnMB9448Da/s+hxcL9tiIdwZ8DH2YrLm/XprjNCo2fG7aZHgprw
         HDxN96m9CxBIHQ1tu3wY6Xq+bV2rVg/zHik0pQrHqPK9jbyleF3QktTRpRkAOljNUV
         B7uToFKKyH7LMmroHSjtx3CVjX13SAXcnaGA4ldaES5GurlL2zZoYCCrqVvYYkxOmV
         3r5jJxNzLLKZGsG6a9BDCIL2/2DDR/fvmnvlPThE6MCsVyscBcaPwtuy9oH9pknQfG
         DoqpwN42fIQZ2/cY1xmmyF4C4dCzSZ9h5mODYadiKbzuXyNjj0Z2OJzxNoC1bS0cde
         4rMxFhNWIuxXA==
Date:   Wed, 11 Aug 2021 12:17:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 11/30] iomap: add the new iomap_iter model
Message-ID: <20210811191708.GF3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-12-hch@lst.de>
 <20210811003118.GT3601466@magnolia>
 <20210811053856.GA1934@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811053856.GA1934@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 07:38:56AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 05:31:18PM -0700, Darrick J. Wong wrote:
> > > +static inline void iomap_iter_done(struct iomap_iter *iter)
> > 
> > I wonder why this is a separate function, since it only has debugging
> > warnings and tracepoints?
> 
> The reason for these two sub-helpers was to force me to structure the
> code so that Matthews original idea of replacing ->iomap_begin and
> ->iomap_end with a single next callback so that iomap_iter could
> be inlined into callers and the indirect calls could be elided is
> still possible.  This would only be useful for a few specific
> methods (probably dax and direct I/O) where we care so much, but it
> seemed like a nice idea conceptually so I would not want to break it.
> 
> OTOH we could just remove this function for now and do that once needed.

<shrug>

> > Modulo the question about iomap_iter_done, I guess this looks all right
> > to me.  As far as apply.c vs. core.c, I'm not wildly passionate about
> > either naming choice (I would have called it iter.c) but ... fmeh.
> 
> iter.c is also my preference, but in the end I don't care too much.

Ok.  My plan for this is to change this patch to add the new iter code
to apply.c, and change patch 24 to remove iomap_apply.  I'll add a patch
on the end to rename apply.c to iter.c, which will avoid breaking the
history.

I'll send the updated patches as replies to this series to avoid
spamming the list, since I also have a patchset of bugfixes to send out
and don't want to overwhelm everyone.

--D
