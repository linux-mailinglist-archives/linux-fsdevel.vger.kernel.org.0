Return-Path: <linux-fsdevel+bounces-68265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BFC57A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 683D235536A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431835292C;
	Thu, 13 Nov 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KlmdGogW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC3351FAB;
	Thu, 13 Nov 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040335; cv=none; b=DCkhCBMOCFp48xHg7HVlnug5Rj8oFJaaxf6uWe+1ln+cPgL6lhWmwpJOage7TOmdpm8lsUBkPCSRjonr1zxqVdXe51ubtequyHjnVK/1l3lP0549VeYTcxRf54HUrOawHirJ3SsHJzA3gxR8SHUbr1CO/kQ4Id1jnK/Hl26m3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040335; c=relaxed/simple;
	bh=5J8IDP0TFvQyAFa3cOY9jKzr3H/7EgsvkcDHzYDPIsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu6KwY5yi9elnJ4cYjoVm8QvUPN9tsDyMe64Nte43AF7ZWsYdWfQJzGuIwTtmhsM1xTMAO1dypOel8XHZyYOFuZvNzUagGuSRxZTzN6KgI0DH9epbBdY8GjfDABt/dvy6CtjuOHL+psHo5UMx8I0AwkHI5AgI7LlFU17gaXfxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KlmdGogW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28FCC113D0;
	Thu, 13 Nov 2025 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763040334;
	bh=5J8IDP0TFvQyAFa3cOY9jKzr3H/7EgsvkcDHzYDPIsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlmdGogWDOTd5cxFL0EnF6XCcEQQQEdzM4Y+n9OGDTffWHBFwrqL42ScQTNKyKONI
	 oPb0DsW7hQW24DLHlfJtiMVmOPomh/qvAyIlvnJtlwcT30iYRMTiWMLT3iK0cliMEs
	 QSJBY7L+YPQhPJ393KH25S+EyVZJoF17nXQs/mZ8=
Date: Thu, 13 Nov 2025 08:25:32 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: lexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] libfs: Fix NULL pointer access in
 simple_recursive_removal
Message-ID: <2025111343-landowner-bush-149b@gregkh>
References: <20251113052357.41868-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113052357.41868-1-r4o5m6e8o@163.com>

On Thu, Nov 13, 2025 at 01:23:57PM +0800, rom.wang wrote:
> From: Yufeng Wang <wangyufeng@kylinos.cn>
> 
> There is an issue in the kernel:
> if inode is NULL pointer. the function "inode_lock_nested"
> (or function "inode_lock" before)
> a crash will happen at code "&inode->i_rwsem".

How is inode NULL?  What is causing that?

> [292618.520532] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
> [...]
> [292618.560398] RIP: 0010:down_write+0x12/0x30
> [292618.565580] Code: 83 f8 01 74 08 48 c7 47 20 01 00 00 00 f3 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 ba 01 00 00 00 ff ff ff ff 48 89 f8 <f0> 48 0f c1 10 85 d2 74 05 e8 00 43 ff ff 65 48 8b 04 25 80 5c 01
> [292618.587219] RSP: 0018:ffffb898dc86fc20 EFLAGS: 00010246
> [292618.593666] RAX: 00000000000000a0 RBX: ffff94c84f363950 RCX: ffffff8000000000
> [292618.602255] RDX: ffffffff00000001 RSI: 0000000000000063 RDI: 00000000000000a0
> [292618.610844] RBP: ffffb898dc86fc78 R08: 0000000000000000 R09: 0000000000000000
> [292618.619434] R10: ffffb898dc86fca8 R11: 0000000000000000 R12: 0000000000000000
> [292618.628022] R13: ffff94c84f362a20 R14: ffff954d3f2fb4a0 R15: ffff954c3afa5010
> [292618.636612] FS:  0000555555989cc0(0000) GS:ffff956dbf900000(0000) knlGS:0000000000000000
> [292618.646271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [292618.653300] CR2: 00000000000000a0 CR3: 000000fc7f25a000 CR4: 00000000003406e0
> [292618.661888] Call Trace:
> [292618.665225]  simple_recursive_removal+0x4f/0x230
> [292618.670994]  ? debug_fill_super+0xe0/0xe0
> [292618.676079]  debugfs_remove+0x40/0x60
> [292618.680799]  kvm_vcpu_release+0x19/0x30 [kvm]

Is the kvm code doing something wrong here?  debugfs shouldn't be trying
to remove an inode that is already removed, so please fix the root
cause, do not paper over it.

thanks,

greg k-h

