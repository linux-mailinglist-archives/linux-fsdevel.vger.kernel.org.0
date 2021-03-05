Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406432ECA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 14:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCEN5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 08:57:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:34108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhCEN5T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:57:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58F27AD21;
        Fri,  5 Mar 2021 13:57:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E46B6DA79B; Fri,  5 Mar 2021 14:55:21 +0100 (CET)
Date:   Fri, 5 Mar 2021 14:55:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210305135521.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eric Biggers <ebiggers@kernel.org>,
        Neal Gompa <ngompa13@gmail.com>, Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
 <20210226093653.GI7604@twin.jikos.cz>
 <YDkkUx7UXszXi6hV@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDkkUx7UXszXi6hV@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:39:47AM -0800, Eric Biggers wrote:
> On Fri, Feb 26, 2021 at 10:36:53AM +0100, David Sterba wrote:
> > On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> > > On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:

> Okay so you have 128K to compress, but not in a virtually contiguous buffer, so
> you need the algorithm to support streaming of 4K chunks.  And the LZ4
> implementation doesn't properly support that.  (Note that this is a property of
> the LZ4 *implementation*, not the LZ4 *format*.)
> 
> How about using vm_map_ram() to get a contiguous buffer, like what f2fs does?
> Then you wouldn't need streaming support.
> 
> There is some overhead in setting up page mappings, but it might actually turn
> out to be faster (also for the other algorithms, not just LZ4) since it avoids
> the overhead of streaming, such as the algorithm having to copy all the data
> into an internal buffer for matchfinding.

Yes the mapping allows to compress the buffer in one go but the overhead
is not small. I had it in one of the prototypes back then too but did
not finish it because it would mean to update the on-disk compression
container format.

vm_map_ram needs to be called twice per buffer (both compression and
decompressin), there are some additional data allocated, the virual
aliases have to be flushed each time and this could be costly as I'm
told (TLB shootdowns, IPI).

Also vm_map_ram is deadlock prone because it unconditionally allocates
with GFP_KERNEL, so the scoped NOFS protection has to be in place. And
F2FS does not do that, but that's fixable.
