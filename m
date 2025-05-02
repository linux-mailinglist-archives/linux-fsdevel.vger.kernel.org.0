Return-Path: <linux-fsdevel+bounces-47931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF6AA7515
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BA717EBA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340EC13D2B2;
	Fri,  2 May 2025 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEO2ODhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBE18E3F
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196515; cv=none; b=X/qp85kyJ6YvbLFAOkzczRcfw2578XgH2dEHk7u/AHCZH1Ixby/Jd4wNd1ky2CYg/jmJfEXPVWSyQsIIHyjUPgtrygfn9dfRAmsbbT8T/Eo28hkM1LrmOVZy4SXpzs5uQRbmr3XSqpH+GRY5c3g+7HQKqD8dbI9o8pEkCKifzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196515; c=relaxed/simple;
	bh=AMyf3hdlohi2x2Km7HL2Ta2wsROtvchKQeJeaBgulk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTLP/aq+eKxl5w00lS0HyM8DjswtoCbDPhNjUqGpbCeOlumUbqFZ6ViDpOdYgnrtwDNz56a3MgPwsMzDr5Zj8zWMBMsnoY0ZwiqqMDHL25Q0QcEq13pwGv50irQ9vSXXYW8ZQvSQuYnZ5Nct8diAnmO4cX04T0Y2gPiKQhVbBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEO2ODhP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746196512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vUEcgZtCLeeqg0l4XTH5FFbd5+c5hm9UJNGNv5VwHHY=;
	b=fEO2ODhPX0uM6viVMhHnF3RYUMd25Ud2FZKNdPFOe4tQfh/AbaxDhIJlotRYHB5xnGuzg9
	o/XpaQexGUHmfY7E9MmXMlUx3c6Bl9w4fjQdNTKyZzlWeemJ1u9pOP7/Y4WktdmphEyNLO
	1OeqVLhG2KCNzi0KHtJCMzEbhXDjuLg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-h3vnJuZlP9C4nwzBugGtZA-1; Fri,
 02 May 2025 10:35:08 -0400
X-MC-Unique: h3vnJuZlP9C4nwzBugGtZA-1
X-Mimecast-MFC-AGG-ID: h3vnJuZlP9C4nwzBugGtZA_1746196506
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324F219560B0;
	Fri,  2 May 2025 14:35:05 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A6D0195608D;
	Fri,  2 May 2025 14:35:01 +0000 (UTC)
Date: Fri, 2 May 2025 10:38:13 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, chandanbabu@kernel.org, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yi1.lai@intel.com
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <aBTY1XQw14eAs9KI@bfoster>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <Z/9aNcsuz0VlvgYz@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/9aNcsuz0VlvgYz@ly-workstation>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 16, 2025 at 03:20:21PM +0800, Lai, Yi wrote:
> Hi Zhang Yi,
> 
> Greetings!
> 
> I used Syzkaller and found that there is WARNING in xfs_bmapi_convert_one_delalloc in linux v6.15-rc2.
> 
> After bisection and the first bad commit is:
> "
> 5ce5674187c3 xfs: convert delayed extents to unwritten when zeroing post eof blocks
> "
> 

I took a look at this and it seems like the issue is a race between a
failed writeback and zero range via write extension. The sequence is
generally some file is written to with delalloc across the EOF folio. An
fsync occurs on said file. The underlying fs is (I'm assuming
deliberately) corrupted such that physical block allocation fails, so
the writeback block map fails and drops the ilock.

An extending buffered write comes in and discovers the post-EOF delalloc
range needs to be zeroed and then unlocks to fall into delalloc
conversion. However, the writeback side was blocked waiting on the ilock
in xfs_discard_folio(), which now punches out the blocks in the same
range and thus causes the warning down in the conversion code on the
buffered write / delalloc convert side where it finds a hole (and warns
because it doesn't like that this is not the COW fork remap case).

There's probably a few ways to address this. The most immediate that
comes to mind for me is probably to just drop the warning, document how
this can happen, and probably also tweak the error logic for the data
fork case so the operation proceeds for remaining blocks beyond the
folio that failed writeback. Another option could be to similarly return
EAGAIN and trigger a retry in the iomap_begin() path. Can't say I'm in
love with either one of those tbh, nor the whole convert blocks on zero
range thing in the first place, but it's also a rare error case and
perhaps not worth too much complexity.

That said, I've also wondered in the past if a higher level
iomap_map_blocks() call that effectively implements a more generic
->map_blocks() would be a more appropriate way to do this. Other
thoughts?

Brian

> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250413_025108_xfs_bmapi_convert_one_delalloc
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250413_025108_xfs_bmapi_convert_one_delalloc/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250413_025108_xfs_bmapi_convert_one_delalloc/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250413_025108_xfs_bmapi_convert_one_delalloc/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250413_025108_xfs_bmapi_convert_one_delalloc/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250413_025108_xfs_bmapi_convert_one_delalloc/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250413_025108_xfs_bmapi_convert_one_delalloc/bzImage_0af2f6be1b4281385b618cb86ad946eded089ac8
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250413_025108_xfs_bmapi_convert_one_delalloc/0af2f6be1b4281385b618cb86ad946eded089ac8_dmesg.log
> 
> "
> [   21.631771] ------------[ cut here ]------------
> [   21.632173] WARNING: CPU: 1 PID: 760 at fs/xfs/libxfs/xfs_bmap.c:4401 xfs_bmapi_convert_one_delalloc+0x520/0xca0
> [   21.633001] Modules linked in:
> [   21.633292] CPU: 1 UID: 0 PID: 760 Comm: repro Tainted: G        W           6.15.0-rc2-v6.15-rc2 #1 PREEMPT(voluntary) 
> [   21.634151] Tainted: [W]=WARN
> [   21.634401] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   21.635476] RIP: 0010:xfs_bmapi_convert_one_delalloc+0x520/0xca0
> [   21.635970] Code: fc ff ff e8 32 76 eb fe 44 89 fe bf 02 00 00 00 41 bc f5 ff ff ff e8 cf 70 eb fe 41 83 ff 02 0f 84 03 ff ff ff e8 10 76 eb fe <0f> 0b e9 f7 fe ff ff e8 04 76 eb fe 48 c7 c0 c0 ca ff 89 48 ba 00
> [   21.637426] RSP: 0018:ff1100001cc37228 EFLAGS: 00010293
> [   21.637855] RAX: 0000000000000000 RBX: ff1100001cc373e8 RCX: ffffffff829c44b1
> [   21.638430] RDX: ff110000108b2bc0 RSI: ffffffff829c44c0 RDI: 0000000000000005
> [   21.639001] RBP: ff1100001cc37410 R08: ff1100001cc37318 R09: fffffbfff0fdc374
> [   21.639614] R10: 0000000000000000 R11: ff110000108b3a18 R12: 00000000fffffff5
> [   21.640180] R13: ff1100001d471680 R14: ff1100000ec74000 R15: 0000000000000000
> [   21.640751] FS:  00007f4c1b99a640(0000) GS:ff110000e3a84000(0000) knlGS:0000000000000000
> [   21.641394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.641862] CR2: 00007f4c14cfd000 CR3: 000000000d4f4006 CR4: 0000000000771ef0
> [   21.642439] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   21.643007] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   21.643620] PKRU: 55555554
> [   21.643848] Call Trace:
> [   21.644060]  <TASK>
> [   21.644256]  ? __pfx_xfs_bmapi_convert_one_delalloc+0x10/0x10
> [   21.644738]  ? __up_read+0x21e/0x810
> [   21.645063]  ? unmap_mapping_range+0x118/0x2c0
> [   21.645436]  ? lock_release+0x14f/0x2c0
> [   21.645761]  ? __pfx_unmap_mapping_range+0x10/0x10
> [   21.646164]  xfs_bmapi_convert_delalloc+0xb0/0x100
> [   21.646568]  xfs_buffered_write_iomap_begin+0x153d/0x1890
> [   21.647022]  ? __pfx_xfs_buffered_write_iomap_begin+0x10/0x10
> [   21.647535]  ? filemap_range_has_writeback+0x318/0x460
> [   21.647977]  ? filemap_range_has_writeback+0xf1/0x460
> [   21.648395]  ? __pfx_xfs_buffered_write_iomap_begin+0x10/0x10
> [   21.648870]  iomap_iter+0x58b/0xd30
> [   21.649178]  iomap_zero_range+0x547/0x740
> [   21.649526]  ? __pfx_iomap_zero_range+0x10/0x10
> [   21.649926]  ? __this_cpu_preempt_check+0x21/0x30
> [   21.650317]  ? lock_is_held_type+0xef/0x150
> [   21.650673]  xfs_zero_range+0xaf/0x100
> [   21.650990]  xfs_file_write_checks+0x639/0xa00
> [   21.651385]  xfs_file_buffered_write+0x183/0x9a0
> [   21.651806]  ? __pfx_xfs_file_buffered_write+0x10/0x10
> [   21.652225]  ? __lock_acquire+0x410/0x2260
> [   21.652580]  ? __lruvec_stat_mod_folio+0x1aa/0x3e0
> [   21.652985]  xfs_file_write_iter+0x52a/0xc00
> [   21.653350]  do_iter_readv_writev+0x6b1/0x9c0
> [   21.653723]  ? __pfx_do_iter_readv_writev+0x10/0x10
> [   21.654127]  ? __this_cpu_preempt_check+0x21/0x30
> [   21.654526]  ? lock_is_held_type+0xef/0x150
> [   21.654879]  vfs_writev+0x311/0xd70
> [   21.655204]  ? __lock_acquire+0x410/0x2260
> [   21.655574]  ? __pfx_vfs_writev+0x10/0x10
> [   21.655922]  ? __fget_files+0x1fa/0x3b0
> [   21.656251]  ? __this_cpu_preempt_check+0x21/0x30
> [   21.656643]  ? lock_release+0x14f/0x2c0
> [   21.656973]  ? __fget_files+0x204/0x3b0
> [   21.657306]  do_pwritev+0x1c9/0x280
> [   21.657612]  ? do_pwritev+0x1c9/0x280
> [   21.657927]  ? __pfx_do_pwritev+0x10/0x10
> [   21.658269]  ? __audit_syscall_entry+0x39c/0x500
> [   21.658661]  __x64_sys_pwritev+0xa3/0x100
> [   21.659000]  ? syscall_trace_enter+0x14d/0x280
> [   21.659387]  x64_sys_call+0x1bbc/0x2150
> [   21.659741]  do_syscall_64+0x6d/0x150
> [   21.660055]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   21.660473] RIP: 0033:0x7f4c1b63ee5d
> [   21.660774] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   21.662222] RSP: 002b:00007f4c1b999df8 EFLAGS: 00000202 ORIG_RAX: 0000000000000128
> [   21.662830] RAX: ffffffffffffffda RBX: 00007f4c1b99a640 RCX: 00007f4c1b63ee5d
> [   21.663432] RDX: 0000000000000001 RSI: 0000000020000300 RDI: 0000000000000004
> [   21.664001] RBP: 00007f4c1b999e20 R08: 0000000000000000 R09: 0000000000000000
> [   21.664569] R10: 0000000002fffffd R11: 0000000000000202 R12: 00007f4c1b99a640
> [   21.665137] R13: 000000000000006e R14: 00007f4c1b69f560 R15: 0000000000000000
> [   21.665726]  </TASK>
> "
> 
> Hope this cound be insightful to you.
> 
> Regards,
> Yi Lai
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install 
> 
> On Thu, Apr 25, 2024 at 09:13:30PM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Current clone operation could be non-atomic if the destination of a file
> > is beyond EOF, user could get a file with corrupted (zeroed) data on
> > crash.
> > 
> > The problem is about preallocations. If you write some data into a file:
> > 
> > 	[A...B)
> > 
> > and XFS decides to preallocate some post-eof blocks, then it can create
> > a delayed allocation reservation:
> > 
> > 	[A.........D)
> > 
> > The writeback path tries to convert delayed extents to real ones by
> > allocating blocks. If there aren't enough contiguous free space, we can
> > end up with two extents, the first real and the second still delalloc:
> > 
> > 	[A....C)[C.D)
> > 
> > After that, both the in-memory and the on-disk file sizes are still B.
> > If we clone into the range [E...F) from another file:
> > 
> > 	[A....C)[C.D)      [E...F)
> > 
> > then xfs_reflink_zero_posteof() calls iomap_zero_range() to zero out the
> > range [B, E) beyond EOF and flush it. Since [C, D) is still a delalloc
> > extent, its pagecache will be zeroed and both the in-memory and on-disk
> > size will be updated to D after flushing but before cloning. This is
> > wrong, because the user can see the size change and read the zeroes
> > while the clone operation is ongoing.
> > 
> > We need to keep the in-memory and on-disk size before the clone
> > operation starts, so instead of writing zeroes through the page cache
> > for delayed ranges beyond EOF, we convert these ranges to unwritten and
> > invalidate any cached data over that range beyond EOF.
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ---
> > Changes since v4:
> > 
> > Move the delalloc converting hunk before searching the COW fork. Because
> > if the file has been reflinked and copied on write,
> > xfs_bmap_extsize_align() aligned the range of COW delalloc extent, after
> > the writeback, there might be some unwritten extents left over in the
> > COW fork that overlaps the delalloc extent we found in data fork.
> > 
> >   data fork  ...wwww|dddddddddd...
> >   cow fork          |uuuuuuuuuu...
> >                     ^
> >                   i_size
> > 
> > In my v4, we search the COW fork before checking the delalloc extent,
> > goto found_cow tag and return unconverted delalloc srcmap in the above
> > case, so the delayed extent in the data fork will have no chance to
> > convert to unwritten, it will lead to delalloc extent residue and break
> > generic/522 after merging patch 6.
> > 
> >  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 236ee78aa75b..2857ef1b0272 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1022,6 +1022,24 @@ xfs_buffered_write_iomap_begin(
> >  		goto out_unlock;
> >  	}
> >  
> > +	/*
> > +	 * For zeroing, trim a delalloc extent that extends beyond the EOF
> > +	 * block.  If it starts beyond the EOF block, convert it to an
> > +	 * unwritten extent.
> > +	 */
> > +	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
> > +	    isnullstartblock(imap.br_startblock)) {
> > +		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > +
> > +		if (offset_fsb >= eof_fsb)
> > +			goto convert_delay;
> > +		if (end_fsb > eof_fsb) {
> > +			end_fsb = eof_fsb;
> > +			xfs_trim_extent(&imap, offset_fsb,
> > +					end_fsb - offset_fsb);
> > +		}
> > +	}
> > +
> >  	/*
> >  	 * Search the COW fork extent list even if we did not find a data fork
> >  	 * extent.  This serves two purposes: first this implements the
> > @@ -1167,6 +1185,17 @@ xfs_buffered_write_iomap_begin(
> >  	xfs_iunlock(ip, lockmode);
> >  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
> >  
> > +convert_delay:
> > +	xfs_iunlock(ip, lockmode);
> > +	truncate_pagecache(inode, offset);
> > +	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
> > +					   iomap, NULL);
> > +	if (error)
> > +		return error;
> > +
> > +	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
> > +	return 0;
> > +
> >  found_cow:
> >  	seq = xfs_iomap_inode_sequence(ip, 0);
> >  	if (imap.br_startoff <= offset_fsb) {
> > -- 
> > 2.39.2
> > 
> 


