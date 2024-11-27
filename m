Return-Path: <linux-fsdevel+bounces-35980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B929DA7CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA91B2D295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7C1FBE83;
	Wed, 27 Nov 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFnhym5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7581FBCB0;
	Wed, 27 Nov 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709641; cv=none; b=Pp6bubssUZGrVVn9wfYUPm/cG69DSoyG5Sn51ljSrx26a3A0rnYBvC08g9J644PbcIZ+KhUYy1JVyK1uzLFpuK7jZilMcHjFdNKp7jAJlOVr38jLSSQHn/CNPSTzbYytRxW8mLdIeYnokKl9VNkVEkhsbHZyQHOoZnuesUl5wSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709641; c=relaxed/simple;
	bh=2DHdoQYnTHtWREWnk1w95RvPty46V+EkizkwpK9ekUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLy590/12tPzrHHiYHETc265zBFgjp21vkUKu48EDf9wGBmHbYMv1XXdwZxk7gvsup+9SmZrfLhHSW68UE/Vc4d3fQWQF58DjYPXbzalBV5UhGAG0aGaQbEJ8z2YG2rlR+sohXnkmkiHFb2ihgrMiVXrgo/VlGgEv3RNU23I2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFnhym5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E7C4CED2;
	Wed, 27 Nov 2024 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709641;
	bh=2DHdoQYnTHtWREWnk1w95RvPty46V+EkizkwpK9ekUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFnhym5lNdSkoAed4+/PcUsiJFiDFn/RPMdkQQ+JlqbdKBTeGpB0vYf226Bq7/Czi
	 lwH1URHBGLy0c1kj3K7lFxQQSlbbk56C5bf/XGdcFk44CsY3yy9QLmtcG2jSmvVwEI
	 Zzbq7zOSYVh2dvs5RCnsUTrNe/DGZXIlqG1Fnstuip8oxlXZ2bjKTsLzWosvSey2gQ
	 3282G3ymIDrTFVch+j3JqpRVTRMjAJKNFCSq2b19XTfrtpN+ekKiHP/4z43ubXSv6+
	 XTJtW6COfKAyJSyGPkrpjcN6cfn1Yd9XVVQj+fv62hB7o0mcnaDmRwgcC6JPWMrIE2
	 LYSEl5l7fq6PQ==
Date: Wed, 27 Nov 2024 13:13:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Bharata B Rao <bharata@amd.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nikunj@amd.com, willy@infradead.org, vbabka@suse.cz, 
	david@redhat.com, akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, joshdon@google.com, clm@meta.com
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
Message-ID: <20241127-heizperiode-betuchte-edc44ec45f37@brauner>
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <20241127120235.ejpvpks3fosbzbkr@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127120235.ejpvpks3fosbzbkr@quack3>

On Wed, Nov 27, 2024 at 01:02:35PM +0100, Jan Kara wrote:
> On Wed 27-11-24 07:19:59, Mateusz Guzik wrote:
> > On Wed, Nov 27, 2024 at 7:13 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > On Wed, Nov 27, 2024 at 6:48 AM Bharata B Rao <bharata@amd.com> wrote:
> > > >
> > > > Recently we discussed the scalability issues while running large
> > > > instances of FIO with buffered IO option on NVME block devices here:
> > > >
> > > > https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
> > > >
> > > > One of the suggestions Chris Mason gave (during private discussions) was
> > > > to enable large folios in block buffered IO path as that could
> > > > improve the scalability problems and improve the lock contention
> > > > scenarios.
> > > >
> > >
> > > I have no basis to comment on the idea.
> > >
> > > However, it is pretty apparent whatever the situation it is being
> > > heavily disfigured by lock contention in blkdev_llseek:
> > >
> > > > perf-lock contention output
> > > > ---------------------------
> > > > The lock contention data doesn't look all that conclusive but for 30% rwmixwrite
> > > > mix it looks like this:
> > > >
> > > > perf-lock contention default
> > > >  contended   total wait     max wait     avg wait         type   caller
> > > >
> > > > 1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_wake.isra.0+0x42
> > > >                         0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
> > > >                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
> > > >                         0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
> > > >                         0xffffffff8f39e88f  up_write+0x4f
> > > >                         0xffffffff8f9d598e  blkdev_llseek+0x4e
> > > >                         0xffffffff8f703322  ksys_lseek+0x72
> > > >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
> > > >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
> > > >    2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev_llseek+0x31
> > > >                         0xffffffff903f15bc  rwsem_down_write_slowpath+0x36c
> > > >                         0xffffffff903f18fb  down_write+0x5b
> > > >                         0xffffffff8f9d5971  blkdev_llseek+0x31
> > > >                         0xffffffff8f703322  ksys_lseek+0x72
> > > >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
> > > >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
> > > >                         0xffffffff903dce5e  do_syscall_64+0x7e
> > > >                         0xffffffff9040012b  entry_SYSCALL_64_after_hwframe+0x76
> > >
> > > Admittedly I'm not familiar with this code, but at a quick glance the
> > > lock can be just straight up removed here?
> > >
> > >   534 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
> > >   535 {
> > >   536 │       struct inode *bd_inode = bdev_file_inode(file);
> > >   537 │       loff_t retval;
> > >   538 │
> > >   539 │       inode_lock(bd_inode);
> > >   540 │       retval = fixed_size_llseek(file, offset, whence,
> > > i_size_read(bd_inode));
> > >   541 │       inode_unlock(bd_inode);
> > >   542 │       return retval;
> > >   543 }
> > >
> > > At best it stabilizes the size for the duration of the call. Sounds
> > > like it helps nothing since if the size can change, the file offset
> > > will still be altered as if there was no locking?
> > >
> > > Suppose this cannot be avoided to grab the size for whatever reason.
> > >
> > > While the above fio invocation did not work for me, I ran some crapper
> > > which I had in my shell history and according to strace:
> > > [pid 271829] lseek(7, 0, SEEK_SET)      = 0
> > > [pid 271829] lseek(7, 0, SEEK_SET)      = 0
> > > [pid 271830] lseek(7, 0, SEEK_SET)      = 0
> > >
> > > ... the lseeks just rewind to the beginning, *definitely* not needing
> > > to know the size. One would have to check but this is most likely the
> > > case in your test as well.
> > >
> > > And for that there is 0 need to grab the size, and consequently the inode lock.
> > 
> > That is to say bare minimum this needs to be benchmarked before/after
> > with the lock removed from the picture, like so:
> 
> Yeah, I've noticed this in the locking profiles as well and I agree
> bd_inode locking seems unnecessary here. Even some filesystems (e.g. ext4)
> get away without using inode lock in their llseek handler...

nod. This should be removed.

