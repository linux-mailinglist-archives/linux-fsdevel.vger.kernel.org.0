Return-Path: <linux-fsdevel+bounces-45989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80BA80E17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851358847F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764A1FCFF3;
	Tue,  8 Apr 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDEPcFNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A251D61B9;
	Tue,  8 Apr 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122430; cv=none; b=V74VQz5+R+YKuORpR8Z2tm4OsSKS+23cBAnU6XStMAlvrXAxN+5BU8O+UkJMC5GhgtwpivI5LeCW98eT0PoJD9x3991pO4O+EaXptIyPOxTJ8zksYSQ8xOJe/jixOedmBCw7j9Njkex/FpkMJpPFaw34rmLLQ9TKTm7WU6H3r2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122430; c=relaxed/simple;
	bh=cVpTdGnP0KIUTbNGzea/9qqOn5Y4PbaMHe7VyHIYg/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCJxyxitAfkAIyWW6bvMMlDd0Yb/npntwKHO7W3CamDT/s74L84DxJCxL0ckJexyxquSSsTM+Tb9hWqBoKNXDwQMjvtUrMiFHB6mUeUhNKE79wZnH+KzA0D2viTiuoZljV7y+hLymFauCyvJxeMpK3e1vHST4Q5BcDlgUYoYmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDEPcFNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A39C4CEE7;
	Tue,  8 Apr 2025 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744122430;
	bh=cVpTdGnP0KIUTbNGzea/9qqOn5Y4PbaMHe7VyHIYg/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDEPcFNCGxu0UwBMWVA5T0l0zhGFI5QwaNvwXop+VOWCS3TwUZoUt5SelfFO3Ax3h
	 TESuvm1/iF/THATzLhtGzGqJzHL5EpHc1uNwW82Bb1dQCGkWmi6bFzVdbLGxatkDha
	 mEmoGvSLi7jMDS9PrNBvObkMGg/6vVlI+zCKBYHpTqa9pr3wTmGPlex6TE3oIXNQUU
	 xB52jUSYiI5hU/d2JvNRoSLZ+c2bInUjfJ6KHQKR7h+dgpUc91KesNlUydCFQgwrbE
	 gfbbAJTw10wmY30lz3XKKy2XY5bXnOQ0DsgLZGssLJwyoCJwIUVGaSRqzCwiIjpDgl
	 sCdjcLzuugh9A==
Date: Tue, 8 Apr 2025 07:27:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Weird loop device behavior in 6.15-rc1?
Message-ID: <20250408142709.GH6266@frogsfrogsfrogs>
References: <20250407233007.GG6266@frogsfrogsfrogs>
 <Z_TF0vYWljwlWxoY@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_TF0vYWljwlWxoY@infradead.org>

On Mon, Apr 07, 2025 at 11:44:34PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 07, 2025 at 04:30:07PM -0700, Darrick J. Wong wrote:
> > Hey Christoph,
> > 
> > I have a ... weird test setup where loop devices have directio enabled
> > unconditionally on a system with 4k-lba disks, and now that I pulled
> > down 6.15-rc1, I see failures in xfs/259:
> 
> Hmm, this works just fine for with a 4k LBA size NVMe setup on -rc1
> with latest xfsprogs and xfstests for-next.

Yeah, fstests works fine with loop in buffered mode. :)

I /think/ the (separate) problem is that prior to 6.15, the logican and
physical blocksizes of the loop device would be set to 512b in
direct-io=on mode.  Now it's set to either the STATX_DIOALIGN size or
the underlying bdev's logical block size, which means 4k.  mkfs.xfs runs
BLKSSZGET, compares that to the -b size= argument, and rejects when
blocksize < loop device logical block size.

I don't know if the loop device should behave more like 512e drives,
where we advertise a (potentially slow) 512b LBA and a 4k physical block
size?  Or just stick with the way things are right now because 512e mode
sucks.  The first means I don't have to patch fstests here, the second
means I'd have to adjust _create_loop to take a desired blocksize and
try to set up the loopdev with that block size, even if it means
dropping dio mode.

> > Then trying to format an XFS filesystem fails:
> 
> That on the other hand I can reproduce locally.
> 
> > I think there's a bug in the loop driver where changing
> > LO_FLAGS_DIRECT_IO doesn't actually try to change the O_DIRECT state of
> > the underlying lo->lo_backing_file->f_flags.  So I can try to set a 2k
> > block size on the loop dev, which turns off LO_FLAGS_DIRECT_IO but the
> > fd is still open O_DIRECT so the writes fail.  But this isn't a
> > regression in -rc1, so maybe this is the expected behavior?
> 
> This does look old, but also I would not call it expected.
> 
> > On 6.15-rc1, you actually /can/ change the sector size:
> 
> > But the backing file still has O_DIRECT on, so formatting fails:
> 
> Looks like the fact that fixing the silent failure to change the sector
> size exposed the not clear O_DIRECT bug..
> 
> I'll cook up a patch to clear O_DIRECT.

Thanks!

> > Thoughts?
> > 
> > --D
> > 
> > (/me notes that xfs/801 is failing across the board, and I don't know
> > what changed about THPs in tmpfs but clearly something's corrupting
> > memory.)
> 
> That one always failed for me because it uses a sysfs-dump tool that
> simply doesn't seem to exist.

Ooops.  I meant to take that out before committing and left it in.
Maybe I should just paste a stupid version into xfs/801:

$ sysfs-dump /sys/block/sda/queue/
/sys/block/sda/queue//add_random = 0
/sys/block/sda/queue//chunk_sectors : 0
/sys/block/sda/queue//dax : 0
/sys/block/sda/queue//discard_granularity : 512
/sys/block/sda/queue//discard_max_bytes = 0
/sys/block/sda/queue//discard_max_hw_bytes : 0
/sys/block/sda/queue//discard_zeroes_data : 0
/sys/block/sda/queue//dma_alignment : 511
<etc>

Full version below.

--D

#!/bin/sh

# Dump a sysfs directory as a key: value stream.

WANT_NEWLINE=

print_help() {
        echo "Usage: $0 [-n] files..."
        exit 1
}

dump() {
        test -f "$1" || return
        SEP='?'
        test -r "$1" && SEP=':'
        stat -c '%A' "$1" | grep -q 'w' && SEP='='
        if [ -n "${WANT_NEWLINE}" ]; then
                echo "$1 ${SEP}"
                cat "$1" 2> /dev/null
        else
                echo "$1 ${SEP} $(cat "$1" 2> /dev/null)"
        fi
}

for i in "$@"; do
        if [ "$i" = "--help" ]; then
                print_help
        fi
        if [ "$i" = "-n" ]; then
                WANT_NEWLINE=1
        fi
        if [ -d "$i" ]; then
                for x in "$i/"*; do
                        dump "$x"
                done
        else
                dump "$i"
        fi
done

exit 0


