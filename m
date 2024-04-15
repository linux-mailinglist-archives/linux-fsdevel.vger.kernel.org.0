Return-Path: <linux-fsdevel+bounces-16909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FD8A4AC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D521F25E98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295C3A1DB;
	Mon, 15 Apr 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B7Q+iTC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E38FA5;
	Mon, 15 Apr 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170879; cv=none; b=i90zXNlS7RHsZeBqPKonIUa0zvtXXfe2E7N709qcKna+Spg2JTh86LpqY7Q9B3k+MsYxDzZxb95wfwbj77TGHC6nOGwAK1ydWXBBtVOaqDCJqAGFvgpMJVIT1IXo1J+pnfZ9sNiCqXQgfnWjQyVCeW4jBS/tseIaLilQpupOWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170879; c=relaxed/simple;
	bh=V4JD/K62Bn9Ujl7NQcNkcXzV/bT8ABt7vcbYkyDBR/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5udkU9uOxXRUeAaNaN0sIZt4hhJsIsp+zdl/Yxhdkw6b7FEidejPzWuZ0zktGiqOnIEr4TtTZwraJcyUI9srbwKH0Oof96OdVaBiCYubi8nQPxmhJDaSmJzroKfjF4jq5tf3XXOq0Sbs7pR4FidQhdLYWj/B5NHBAOZQNmMx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B7Q+iTC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF99C113CC;
	Mon, 15 Apr 2024 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713170879;
	bh=V4JD/K62Bn9Ujl7NQcNkcXzV/bT8ABt7vcbYkyDBR/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7Q+iTC88pZwHIypCPfw98m1VQRgmI7HbvnjK1W51yz/xvfbFWp4lZBwYjls8BdFx
	 nq6wbzJwMF3tcBA3qxSzrq2kGn6DnUzth059UdG+6sx0jk7P+R267X5AOAoKc0DfJV
	 HLoxC/fXTSZ20V0EJxiwHX3uaqZAe2SUQWB37+Lc=
Date: Mon, 15 Apr 2024 10:47:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: debugfs revoke broken?
Message-ID: <2024041557-stereo-wafer-1551@gregkh>
References: <nxucitm2agdzdodrkm5rjyuwnnf6keivjiqlp5rn6poxkpkye6@yor2lprsxh7x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nxucitm2agdzdodrkm5rjyuwnnf6keivjiqlp5rn6poxkpkye6@yor2lprsxh7x>

On Sun, Apr 14, 2024 at 06:32:07PM -0400, Kent Overstreet wrote:
> I recently started seeing test failures like the following; from the
> "shutdown complete" line we're well after the point where we called
> debugfs_remove_recursive() - yet from the backtrace we were still able
> to call into debugfs.
> 
> And I see from the history the remove path has been getting tweaked,
> so...
> 
> 00091 ========= TEST   generic/001
> 00091 
> 00092 Setting up swapspace version 1, size = 2 GiB (2147479552 bytes)
> 00092 no label, UUID=73a80295-2b03-4512-aae1-785187926ce3
> 00092 Adding 2097148k swap on /dev/vde.  Priority:-2 extents:1 across:2097148k 
> 00092 configuration error - unknown item 'NONEXISTENT' (notify administrator)
> 00092 configuration error - unknown item 'PREVENT_NO_AUTH' (notify administrator)
> 00094 configuration error - unknown item 'NONEXISTENT' (notify administrator)
> 00094 configuration error - unknown item 'PREVENT_NO_AUTH' (notify administrator)
> 00094 configuration error - unknown item 'NONEXISTENT' (notify administrator)
> 00094 configuration error - unknown item 'PREVENT_NO_AUTH' (notify administrator)
> 00101 building 001... done
> 00101 bcachefs (vdb): mounting version 1.7: mi_btree_bitmap
> 00101 bcachefs (vdb): initializing new filesystem
> 00101 bcachefs (vdb): going read-write
> 00101 bcachefs (vdb): marking superblocks
> 00101 bcachefs (vdb): initializing freespace
> 00101 bcachefs (vdb): done initializing freespace
> 00101 bcachefs (vdb): reading snapshots table
> 00101 bcachefs (vdb): reading snapshots done
> 00101 bcachefs (vdb): done starting filesystem
> 00102 FSTYP         -- bcachefs
> 00102 PLATFORM      -- Linux/aarch64 Debian-1103-bullseye-arm64-base-kvm 6.9.0-rc2-ktest-g2719f811ae24 #18142 SMP Sun Apr 14 16:26:05 NZST 2024
> 00102 MKFS_OPTIONS  -- --encrypted --no_passphrase /dev/vdc
> 00102 MOUNT_OPTIONS -- /dev/vdc /mnt/scratch
> 00102 
> 00102 bcachefs (vdc): mounting version 1.7: mi_btree_bitmap
> 00102 bcachefs (vdc): initializing new filesystem
> 00102 bcachefs (vdc): going read-write
> 00102 bcachefs (vdc): marking superblocks
> 00102 bcachefs (vdc): initializing freespace
> 00102 bcachefs (vdc): done initializing freespace
> 00102 bcachefs (vdc): reading snapshots table
> 00102 bcachefs (vdc): reading snapshots done
> 00102 bcachefs (vdc): done starting filesystem
> 00102 bcachefs (vdc): shutting down
> 00102 bcachefs (vdc): going read-only
> 00102 bcachefs (vdc): finished waiting for writes to stop
> 00102 bcachefs (vdc): flushing journal and stopping allocators, journal seq 3
> 00102 bcachefs (vdc): flushing journal and stopping allocators complete, journal seq 5
> 00102 bcachefs (vdc): shutdown complete, journal seq 6
> 00102 bcachefs (vdc): marking filesystem clean
> 00102 bcachefs (vdc): shutdown complete
> 00102 bcachefs (vdb): shutting down
> 00102 bcachefs (vdb): going read-only
> 00102 bcachefs (vdb): finished waiting for writes to stop
> 00102 bcachefs (vdb): flushing journal and stopping allocators, journal seq 6
> 00102 bcachefs (vdb): flushing journal and stopping allocators complete, journal seq 7
> 00102 bcachefs (vdb): shutdown complete, journal seq 8
> 00102 bcachefs (vdb): marking filesystem clean
> 00102 bcachefs (vdb): shutdown complete
> 00102 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> 00102 Mem abort info:
> 00102   ESR = 0x0000000096000004
> 00102   EC = 0x25: DABT (current EL), IL = 32 bits
> 00102   SET = 0, FnV = 0
> 00102   EA = 0, S1PTW = 0
> 00102   FSC = 0x04: level 0 translation fault
> 00102 Data abort info:
> 00102   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> 00102   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> 00102   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> 00102 user pgtable: 4k pages, 48-bit VAs, pgdp=000000011585c000
> 00102 [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
> 00102 Internal error: Oops: 0000000096000004 [#1] SMP
> 00102 Modules linked in:
> 00102 CPU: 7 PID: 1805 Comm: cat Not tainted 6.9.0-rc2-ktest-g2719f811ae24 #18142
> 00102 Hardware name: linux,dummy-virt (DT)
> 00102 pstate: 00001005 (nzcv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> 00102 pc : bch2_journal_seq_pins_to_text+0x100/0x208
> 00102 lr : bch2_journal_seq_pins_to_text+0xf0/0x208
> 00102 sp : ffff0000d6dd3c80
> 00102 x29: ffff0000d6dd3c80 x28: ffff0000ca361f00 x27: 0000000000000000
> 00102 x26: 0000000000000000 x25: ffff0000da0002c0 x24: ffff0000da0002f0
> 00102 x23: ffff0000d50668c0 x22: ffff800080998950 x21: ffff0000da0002c0
> 00102 x20: ffff0000c46165c0 x19: 0000000000000000 x18: 00000000fffffffe
> 00102 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> 00102 x14: ffffffffffffffff x13: ffff0000c0ada1df x12: ffff0000c0ada1d9
> 00102 x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800080400ec8
> 00102 x8 : 0000000000000000 x7 : 20746e756f63203a x6 : 0000000000000000
> 00102 x5 : 0000000000000020 x4 : 000000000000000d x3 : ffff0000c0ada1d0
> 00102 x2 : 0000000000000010 x1 : ffff0000c0ada1d0 x0 : 0000000000000012
> 00102 Call trace:
> 00102  bch2_journal_seq_pins_to_text+0x100/0x208
> 00102  bch2_journal_pins_read+0x48/0xd0
> 00102  full_proxy_read+0x64/0xb8
> 00102  vfs_read+0xd0/0x2d0
> 00102  ksys_read+0x5c/0xe0
> 00102  __arm64_sys_read+0x20/0x30
> 00102  invoke_syscall.constprop.0+0x50/0xe0
> 00102  do_el0_svc+0x44/0xc8
> 00102  el0_svc+0x18/0x58
> 00102  el0t_64_sync_handler+0xb8/0xc0
> 00102  el0t_64_sync+0x14c/0x150

So this file was open when debugfs_remove() was called?

Any chance you can bisect?  We just fixed some issues here in
952c3fce297f ("debugfs: fix wait/cancellation handling during remove")
that I thought should have handled this.  If you revert that commit,
does things work again?  And/or what about commit 8c88a474357e
("debugfs: add API to allow debugfs operations cancellation")?  Maybe we
need to go back to not having completions at all in the debugfs remove
path and just live with waiting for the files to be removed before
continuing (which should at the least, resolve the issue you see here,
while slowing things down a bit.)

thanks,

greg k-h

