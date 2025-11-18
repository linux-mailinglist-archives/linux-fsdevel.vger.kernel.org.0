Return-Path: <linux-fsdevel+bounces-68993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABCC6AD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3F8B4F6147
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7871346E77;
	Tue, 18 Nov 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e6sRph/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EC21D3F5;
	Tue, 18 Nov 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485499; cv=none; b=T3EtIMKLI11rxcMqNi1RIAYWcbVy2Dy+wRRu1PPhOm5Pzk3uSKLIN75EcFLNiM2VZnn+vF6dMm0TRyzPRBB/c9+voro6N+lrMYanJ57uZhPedPFs5WwbobYoU/ByLeM5K1eHAHN02Tvni0y1wbLbU/jyFQWXWR5QE/uKJf4VRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485499; c=relaxed/simple;
	bh=aDTdolw9uRnMvpaVtIerAipeYXB0Iu2QZH6NUmQFhRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfJcq/XAfnN5rbHy8F9cInVh47zBhKYjfGkP/zxJTDYGp5uc72XEdzCMnadHl3sRQQaoqrgm09/CgadMl0bViGDk9osBzcBAwgaXEtIJERoxVUm49IVIhrJ5SEm1fdcI3bUiyKui4v1FVsbVX8ZStQmWT8uZYLgMeVceMBFnetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e6sRph/5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fZqAhx8/a54enJ+3/zOWokC/2q3fL/g0V27h4TcVj3Q=; b=e6sRph/5fUW/v3uA07GsxZxUBO
	KnObkLujoy5cPTIOWEE3VCOCbXQ2ogbm27ZQjq6Kq48vlmO9jo193n0uPUK5aU6mx76CA1Cscqbd2
	IF+wNEGwLQG7338Kru6QdqOt/DIhvSqrMs+1kJEsuxj77Vxo975ZoBuRsgVHjTOZelu/m0hTurtgQ
	Lw4d0Iyuj1nut8V0OWnRa2+fqNjiMtGeDFo2QorG7FuLzuLZnPqGQeF0CHVaqAD+AE1LGITKyggk9
	5h6j9/egR+XB9XKa1oPx15+oW7AQiLQTkXZQR6c/meUiTR4gKVbB3exnKfTWtxUBO+J8ijDs6BcZM
	kmq/J41w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLP8M-0000000BOxD-2b8N;
	Tue, 18 Nov 2025 17:04:50 +0000
Date: Tue, 18 Nov 2025 17:04:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "rom.wang" <r4o5m6e8o@163.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] libfs: Fix NULL pointer access in
 simple_recursive_removal
Message-ID: <20251118170450.GG2441659@ZenIV>
References: <20251113052357.41868-1-r4o5m6e8o@163.com>
 <2025111343-landowner-bush-149b@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111343-landowner-bush-149b@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 13, 2025 at 08:25:32AM -0500, Greg KH wrote:
> On Thu, Nov 13, 2025 at 01:23:57PM +0800, rom.wang wrote:
> > From: Yufeng Wang <wangyufeng@kylinos.cn>
> > 
> > There is an issue in the kernel:
> > if inode is NULL pointer. the function "inode_lock_nested"
> > (or function "inode_lock" before)
> > a crash will happen at code "&inode->i_rwsem".
> 
> How is inode NULL?  What is causing that?
> 
> > [292618.520532] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
> > [...]
> > [292618.560398] RIP: 0010:down_write+0x12/0x30
> > [292618.565580] Code: 83 f8 01 74 08 48 c7 47 20 01 00 00 00 f3 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 ba 01 00 00 00 ff ff ff ff 48 89 f8 <f0> 48 0f c1 10 85 d2 74 05 e8 00 43 ff ff 65 48 8b 04 25 80 5c 01
> > [292618.587219] RSP: 0018:ffffb898dc86fc20 EFLAGS: 00010246
> > [292618.593666] RAX: 00000000000000a0 RBX: ffff94c84f363950 RCX: ffffff8000000000
> > [292618.602255] RDX: ffffffff00000001 RSI: 0000000000000063 RDI: 00000000000000a0
> > [292618.610844] RBP: ffffb898dc86fc78 R08: 0000000000000000 R09: 0000000000000000
> > [292618.619434] R10: ffffb898dc86fca8 R11: 0000000000000000 R12: 0000000000000000
> > [292618.628022] R13: ffff94c84f362a20 R14: ffff954d3f2fb4a0 R15: ffff954c3afa5010
> > [292618.636612] FS:  0000555555989cc0(0000) GS:ffff956dbf900000(0000) knlGS:0000000000000000
> > [292618.646271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [292618.653300] CR2: 00000000000000a0 CR3: 000000fc7f25a000 CR4: 00000000003406e0
> > [292618.661888] Call Trace:
> > [292618.665225]  simple_recursive_removal+0x4f/0x230
> > [292618.670994]  ? debug_fill_super+0xe0/0xe0
> > [292618.676079]  debugfs_remove+0x40/0x60
> > [292618.680799]  kvm_vcpu_release+0x19/0x30 [kvm]
> 
> Is the kvm code doing something wrong here?  debugfs shouldn't be trying
> to remove an inode that is already removed, so please fix the root
> cause, do not paper over it.

That's... interesting.  It's not just inode that is already removed,
it's very likely a dentry that has already beed freed (dentry with
refcount greater than 1 can not become negative).

