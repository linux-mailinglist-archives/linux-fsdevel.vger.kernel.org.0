Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6BD30AE75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhBARwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 12:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232531AbhBARv7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:51:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AC7764DD9;
        Mon,  1 Feb 2021 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612201878;
        bh=neP8rf9Z7xpjegOXqfB5qwKnJSrQE0Nhm7F5KwaVuOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHlwIlkycPl3F4kzmB9u26QQLhHWEnBoTuHqdvm9hhpr+GH7wZjidC1QfsIqJfNm8
         p7YGl7flSTVmMPPey92mICXUsQrWnLNGj4+qVQEw5eV9ER1Ts0oPmBuKId5BDcAE3I
         dn3q0HROtqMk4hyYmNbvPeOrKMJNQ+s4xflViDl86GygVSU8MmP3/0MZAf14KPO2yW
         NwD83bMHmzoJ1IKZmTcty9omORnKx7cq/YOskjiT8ZiADHwNYHO6CLgMGB4kR2ic50
         UNYyY30DU4610I4k/eVMxlNYswjMIK68Z8f/PVT1reV86KKI24bjdsb6FFkbR3KikV
         poMmWY2+pWG1A==
Date:   Mon, 1 Feb 2021 09:51:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <david@fromorbit.com>
Subject: Re: reduce sub-block DIO serialisation v4
Message-ID: <20210201175117.GA7190@magnolia>
References: <20210122162043.616755-1-hch@lst.de>
 <20210123185706.GG1282159@magnolia>
 <20210201165825.GB9858@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201165825.GB9858@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:58:25PM +0100, Christoph Hellwig wrote:
> On Sat, Jan 23, 2021 at 10:57:06AM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 22, 2021 at 05:20:32PM +0100, Christoph Hellwig wrote:
> > > This takes the approach from Dave, but adds a new flag instead of abusing
> > > the nowait one, and keeps a simpler calling convention for iomap_dio_rw.
> > 
> > Hm.  I realized while putting together for-next branches that I really
> > would have preferred the three iomap patches at the start so that I
> > could push those parts through the iomap tree.  The changes required to
> > resequence the series is minor and the iomap changes (AFAICT) are inert
> > if the calling fs doesn't set IOMAP_DIO_OVERWRITE_ONLY, so I think it's
> > low risk to push the iomap changes into iomap-for-next as a 5.12 thing.
> > 
> > The rest of the xfs patches in this series would form the basis of a
> > second week pull request (or not) since I think I ought to evaluate the
> > effects on performance for a little longer.
> 
> So that is the reason why they aren't in for-next yet?  Or do you want
> the remaining patches resent on top of the iomap branch?

Assuming they haven't changed, I'll just push the (slightly reordered)
series out to for-next tomorrow.  Sorry, I got totally sidetracked last
week with the quota retry series nearly tripling in size with all the
requested changes... :(

--D
