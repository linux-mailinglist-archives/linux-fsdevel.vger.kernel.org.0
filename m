Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C63265B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 17:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBZQkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 11:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBZQkb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:40:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7922464F13;
        Fri, 26 Feb 2021 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614357589;
        bh=lEfZYpuP4K1vJFK/jjoqcBdS+eR6xUvZ/xZlU6zhtq0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bc07srVxXcvI8rWV5nMNBUvBERF8r7/QwecNmvSChB8zZM9TYJDYyK6ygYIt49Xto
         K1fw5efDEqIwWpOEXZAZQcLHFKWU4WJCjOk7F/iWw0rnrWNPFWKzXFq9L/UUAXAWWC
         mgIdJ3HItbpaY/ixV4ESkv+6PNj5m6crKN/7ABjybtysAJleREsXmlkgdg6lux3EQA
         HFo5bDUZm7bU++SE6dVX7WGg903Wdr/gHDLZ+JYs95HSPnxxyfwoZBclv2djYSJFw0
         2KGmeSNt6UppLGKE33DSkgebDJ64uHlwqWQTKZXwMEDyHYoZM1tchUqsvjGIZplznH
         g0/a0YXYsLIpg==
Date:   Fri, 26 Feb 2021 08:39:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <YDkkUx7UXszXi6hV@gmail.com>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
 <20210226093653.GI7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226093653.GI7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:36:53AM +0100, David Sterba wrote:
> On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> > On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:
> > > 
> > > LZ4 support has been asked for so many times that it has it's own FAQ
> > > entry:
> > > https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F
> > > 
> > > The decompression speed is not the only thing that should be evaluated,
> > > the way compression works in btrfs (in 4k blocks) does not allow good
> > > compression ratios and overall LZ4 does not do much better than LZO. So
> > > this is not worth the additional costs of compatibility. With ZSTD we
> > > got the high compression and recently there have been added real-time
> > > compression levels that we'll use in btrfs eventually.
> > 
> > When ZSTD support was being added to btrfs, it was claimed that btrfs compresses
> > up to 128KB at a time
> > (https://lore.kernel.org/r/5a7c09dd-3415-0c00-c0f2-a605a0656499@fb.com).
> > So which is it -- 4KB or 128KB?
> 
> Logical extent ranges are sliced to 128K that are submitted to the
> compression routine. Then, the whole range is fed by 4K (or more exactly
> by page sized chunks) to the compression. Depending on the capabilities
> of the compression algorithm, the 4K chunks are either independent or
> can reuse some internal state of the algorithm.
> 
> LZO and LZ4 use some kind of embedded dictionary in the same buffer, and
> references to that dictionary directly. Ie. assuming the whole input
> range to be contiguous. Which is something that's not trivial to achive
> in kernel because of pages that are not contiguous in general.
> 
> Thus, LZO and LZ4 compress 4K at a time, each chunk is independent. This
> results in worse compression ratio because of less data reuse
> possibilities. OTOH this allows decompression in place.
> 
> ZLIB and ZSTD can have a separate dictionary and don't need the input
> chunks to be contiguous. This brings some additional overhead like
> copying parts of the input to the dictionary and additional memory for
> themporary structures, but with higher compression ratios.
> 
> IIRC the biggest problem for LZ4 was the cost of setting up each 4K
> chunk, the work memory had to be zeroed. The size of the work memory is
> tunable but trading off compression ratio. Either way it was either too
> slow or too bad.

Okay so you have 128K to compress, but not in a virtually contiguous buffer, so
you need the algorithm to support streaming of 4K chunks.  And the LZ4
implementation doesn't properly support that.  (Note that this is a property of
the LZ4 *implementation*, not the LZ4 *format*.)

How about using vm_map_ram() to get a contiguous buffer, like what f2fs does?
Then you wouldn't need streaming support.

There is some overhead in setting up page mappings, but it might actually turn
out to be faster (also for the other algorithms, not just LZ4) since it avoids
the overhead of streaming, such as the algorithm having to copy all the data
into an internal buffer for matchfinding.

- Eric
