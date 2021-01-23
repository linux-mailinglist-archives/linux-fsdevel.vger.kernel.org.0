Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19F53017ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 19:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbhAWS5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jan 2021 13:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhAWS5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:57:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4A2722B2D;
        Sat, 23 Jan 2021 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611428226;
        bh=9Q3GXeX+KNLHCvJIBjtv1vkdbDcLPgj/6Wpf7WOtNxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezV0mUnnPVRVN2yT/4RNuoU4fp0D1IlkjyQn7zL1it5I8uNEzw8ChZ0tAzhpKG+rs
         WfzncF8fPCONPbxEKmxDOz1hTs6boG086FMSYmOnOCS5U+dnMffnkT9Day5eRP202M
         jt2Zj2x1KBg4s/GyL2Jl9ZWoalsraj3estJ2r9+sdK4Zr0usw9+5ER+Pzm3+i/fZ1t
         qHwhCGkLvDsGxXKJdcJnWQDOcxlr6bg8ocSNYB8t1G/yYfQ4/lLj4PwALIz1rj+VcJ
         JaZS9MSYcTWzBjz7hB9+nH8Zhq9fSUMtIC451meFo1KcBlAeJG7GueqgEwkRCx8AEW
         Thb6rOqG2nn2A==
Date:   Sat, 23 Jan 2021 10:57:06 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <david@fromorbit.com>
Subject: Re: reduce sub-block DIO serialisation v4
Message-ID: <20210123185706.GG1282159@magnolia>
References: <20210122162043.616755-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122162043.616755-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:20:32PM +0100, Christoph Hellwig wrote:
> This takes the approach from Dave, but adds a new flag instead of abusing
> the nowait one, and keeps a simpler calling convention for iomap_dio_rw.

Hm.  I realized while putting together for-next branches that I really
would have preferred the three iomap patches at the start so that I
could push those parts through the iomap tree.  The changes required to
resequence the series is minor and the iomap changes (AFAICT) are inert
if the calling fs doesn't set IOMAP_DIO_OVERWRITE_ONLY, so I think it's
low risk to push the iomap changes into iomap-for-next as a 5.12 thing.

The rest of the xfs patches in this series would form the basis of a
second week pull request (or not) since I think I ought to evaluate the
effects on performance for a little longer.

That said, if you /don't/ want me to pull any of this for 5.12, holler
and I'll pull back. :)

--D

> Changes since v3:
>  - further comment improvements
>  - micro-optimize an alignment check
> 
> Changes since v2:
>  - add another sanity check in __iomap_dio_rw
>  - rename IOMAP_DIO_UNALIGNED to IOMAP_DIO_OVERWRITE_ONLY
>  - use more consistent parameter naming
>  - improve a few comments
>  - cleanup an if statement
> 
> Changes since v1:
>  - rename the new flags
>  - add an EOF check for subblock I/O
>  - minor cleanups
