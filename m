Return-Path: <linux-fsdevel+bounces-25844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F49510E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2AA284109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182E394;
	Wed, 14 Aug 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FJcvbynx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C34195
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594198; cv=none; b=Woacrc7QK216xd/5rChHLHoFSFEK/HcE7sUvOiSbkDlA3yQ042nZsWkVEXQlRcnb9j+n1as0AVyMZf0zZgQW3PGkevlY7Zq84NGg6S+5utzyqpXTD02ZBtVG6btpGbQBBxnJvupucMCIGAdYFvj6fVpBaulO82VsMKNKBc3bSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594198; c=relaxed/simple;
	bh=hu7DYmU9WHbUjkV9ylow0zs19UG23DtuepLS5cQpbyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXCuGdSIJwUjxr+tzkcrpreo3SUYESlOCZ/s+/c1LcJzKqZM7DbLUr5LZ5z6+3rFcbK6LQcmhAG/7y0PrM7YXijhBO+ShEtcZSKe59p/5ubWbcT8197sgMKhTwlocUd4XHOSG091JQ7Fjn1RTN1jeAkNvuezVcGI7479uxsr6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FJcvbynx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd65aaac27so2527705ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723594196; x=1724198996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgzpHVGh9LshAXKNeE4JoWneQZwrlmny9tGF8rjKSOk=;
        b=FJcvbynxhXtu5lXXTFnmvRIEVrvzYGPG7GF8qdY7pVEOfaIFl0hUm1RmK7d0FwBuNt
         aKjbpSI26OuszzlA+cAPwb7v024qpbkJhuIHUEqja6yqi54Gu0FDbSey4vvqZneHku05
         etA89XTHCryfalI92B/sEk3gJG4FgoUuubAAelqQP1VDGjy1hFx28z96DpKqSnyMuzPV
         SpLWL2G23i0X2Dfz5bLEPBFsCGH41acmN63F1jrTnIntbWtrjU4fKColKK/cZLQ8pr33
         G6mdQPKUX34ny9Zp3pORSHmyyVhasmFqd0FF9aSUllE3WNem87orY6VxO0uOh6ZEekOd
         m85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723594196; x=1724198996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgzpHVGh9LshAXKNeE4JoWneQZwrlmny9tGF8rjKSOk=;
        b=IGSlQXAHagEBOuwwg+o9A92NfKGGkgyCZ3Yyk/AdK6wZgAoRV1Ehv/2/e8rRsuW2Gl
         X841DRHRKGPq3W0qHeomGW/EiZYuIicRvEycAGE+VBLMwEUv5dBJt/PcTXpwg1uMc7YA
         +HkN/7bQIDZ2Op5RT7faf/X4TzXn/ZZcUDBvj1/oLp8ThEIL3xEMNDwwBBzlIuDl94x7
         N+j+PMSyUfgghqMFiMzKziqAs71B+BJOs4rlxBBC9DdrryI6FDkwc13ll7RK+xZle652
         RL39OJBFdSTVX64YFVvHZgc1jhOd0DEfPjqT8P6XZhf5SV3aCHnSOAH5uZgBtVFrcyZX
         ncrw==
X-Gm-Message-State: AOJu0YwVnZ3KWPcQ8BdF1JU/d4NxXy7I8kPbhY7THwUH8w/jfoyvHOiC
	smJI4Oaq7G4KWYFF2pWTX6vIrX1n0s+AdXzXnoeGIB0ZQiRzbOO84AjM79742cnLUg/dPlO2LM2
	a
X-Google-Smtp-Source: AGHT+IGkVB3ZCuG9kteZDZe6z6dW6ARLnktVPxfzTFsfubqwwKzQ+qKiaQqjQV6lsfbIezcblUd40g==
X-Received: by 2002:a17:902:d486:b0:1fd:6033:f94e with SMTP id d9443c01a7336-201d9a28c56mr4789465ad.27.1723594195597;
        Tue, 13 Aug 2024 17:09:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1314absm19025315ad.15.2024.08.13.17.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 17:09:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se1aK-00GBiU-1a;
	Wed, 14 Aug 2024 10:09:52 +1000
Date: Wed, 14 Aug 2024 10:09:52 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Message-ID: <Zrv10AMSDwkPHl1U@dread.disaster.area>
References: <20240807180706.30713-1-jack@suse.cz>
 <ZrQA2/fkHdSReAcv@dread.disaster.area>
 <20240808143222.4m56qw5jujorqrfv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808143222.4m56qw5jujorqrfv@quack3>

On Thu, Aug 08, 2024 at 04:32:22PM +0200, Jan Kara wrote:
> On Thu 08-08-24 09:18:51, Dave Chinner wrote:
> > On Wed, Aug 07, 2024 at 08:29:45PM +0200, Jan Kara wrote:
> > > Hello,
> > > 
> > > this patch series implements generic handling of filesystem shutdown. The idea
> > > is very simple: Have a superblock flag, which when set, will make VFS refuse
> > > modifications to the filesystem. The patch series consists of several parts.
> > > Patches 1-6 cleanup handling of SB_I_ flags which is currently messy (different
> > > flags seem to have different locks protecting them although they are modified
> > > by plain stores). Patches 7-12 gradually convert code to be able to handle
> > > errors from sb_start_write() / sb_start_pagefault(). Patch 13 then shows how
> > > filesystems can use this generic flag. Additionally, we could remove some
> > > shutdown checks from within ext4 code and rely on checks in VFS but I didn't
> > > want to complicate the series with ext4 specific things.
> > 
> > Overall this looks good. Two things that I noticed that we should
> > nail down before anything else:
> > 
> > 1. The original definition of a 'shutdown filesystem' (i.e. from the
> > XFS origins) is that a shutdown filesystem must *never* do -physical
> > IO- after the shutdown is initiated. This is a protection mechanism
> > for the underlying storage to prevent potential propagation of
> > problems in the storage media once a serious issue has been
> > detected. (e.g. suspect physical media can be made worse by
> > continually trying to read it.) It also allows the block device to
> > go away and we won't try to access issue new IO to it once the
> > ->shutdown call has been complete.
> > 
> > IOWs, XFS implements a "no new IO after shutdown" architecture, and
> > this is also largely what ext4 implements as well.
> 
> Thanks for sharing this. I wasn't aware that "no new IO after shutdown" is
> the goal. I knew this is required for modifications but I wasn't sure how
> strict this was for writes.
> 
> > However, this isn't what this generic shutdown infrastructure
> > implements. It only prevents new user modifications from being
> > started - it is effectively a "instant RO" mechanism rather than an
> > "instant no more IO" architecture.
> > 
> > Hence we have an impedence mismatch between existing shutdown
> > implementations that currently return -EIO on shutdown for all
> > operations (both read and write) and this generic implementation
> > which returns -EROFS only for write operations.
> > 
> > Hence the proposed generic shutdown model doesn't really solve the
> > inconsistent shutdown behaviour problem across filesystems - it just
> > adds a new inconsistency between existing filesystem shutdown
> > implementations and the generic infrastructure.
> 
> OK, understood. I also agree it would be good to keep this no-IO semantics
> when implementing the generic solution. I'm just pondering how to achieve
> that in a maintainable way. For the write path what I've done looks like
> the least painful way. For the read path the simplest is probably to still
> return whatever is in cache and just do the check + error return somewhere
> down in the call stack just before calling into filesystem. It is easy
> enough to stop things like ->read_folio, ->readahead, or ->lookup. But how
> about things like ->evict_inode or ->release?

If the filesystem is shut down, inode eviction or releasing a FD
should not be doing any IO at all - they should just be releasing
in-memory resources and freeing the objects being released. e.g. we
don't process unlinked inodes when the filesystem is shut down; they
remain as unlinked on disk and recovery gets to clean up the mess.
i.e.  we process all inodes as if they were clean, linked inodes and
just tear down the in-memory structures attached to the inode.

i.e. shutdown isn't concerned about keeping anything consistent
either in memory or on disk - it's concerned only about releasing
in-memory resources such that the filesystem can be unmounted
without doing any IO at all.  e.g. ext4_evict_inode() needs to treat
all unlinked inodes as if they are bad when the filesystem is shut
down. XFS does this (see the shutdown check in
xfs_inode_needs_inactive()) and every filesystem that does unlinked
inode processing in inode eviction will need similar modifications.

Yes, this means a "shutdown means no IO" model cannot be exclusively
implemented at the VFS - it will need things like filesystems with
customised inode eviction callouts to handle these cases themselves.

> They can trigger IO but
> allowing inode reclaim on shutdown fs is desirable I'd say. Similarly for
> things like ->remount_fs or ->put_super. So avoiding IO from operations
> like these would rely on fs implementation anyway.

remounts need to follow the fundamental rule of shutdowns: you can't
change the state of a shutdown filesystem -at all- because any
operation on a shutdown filesystem should be immediately failed. The
only thing you can reliably do once a filesystem is shut down is
unmount it.  IOWs, the VFS should return -EIO when a remount is
requested on a shutdown filesystem, and the filesystem code then
doesn't have to care.

As for ->put_super(), this should act as if the filesystem is clean
when the filesystem is shut down as everything that is dirty in
memory will never get cleaned. IOWs, once shutdown has been set,
dirty state should be completely ignored by everything and so object
release/eviction should tear everything down regardless of it's
state.

Supporting a "no-IO shutdown" model properly will require filesystem
specific changes to handle, but that's really implementation details
more than anything else. What we need to do first is define
and document exactly what shutdown means and how the VFS and
filesystems need to operate when that bit is set. Then we have a
clear framework from which we can consistently answer "what should
filesystem X do in this situation" issues that arise...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

