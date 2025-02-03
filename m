Return-Path: <linux-fsdevel+bounces-40587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF6A2581B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 12:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601B41669BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D65202F88;
	Mon,  3 Feb 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLtpFFM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753D202C45;
	Mon,  3 Feb 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582028; cv=none; b=WFoiMGsyt9Oe/nIyfmP8esBE7M36KaILhY12cf9pteZwBdJVfRp4LKyWIypFvXFjt5VdPrtvBCe/cwjLOZhzBfSuRwA3N1ykZmJX+y0OLYoqk6yAFeKJfVx43138KRiAxvrQuzqn+jzc4nj59T/Mn4PW7eQ1oZWC//i6IXArVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582028; c=relaxed/simple;
	bh=5i9//Kn8WeZxlIxGevzqFSFkR7fJb+ICsICOaG5d6PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5rQUCZSGGr1CgMNgdZgf6usGjqmKgtTRxl+QPpGTLv0wX6Fk4gj8jZatpRFijj7zs6RzYnCEVR8InHelucZfBmj6kwd/1gmHpXdiEtiuM1daOULzlR1+5kcOOhW3Ds7E8tlRlsSOYGY+4mTADMB4AneoK175796R7Sv5G8IL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLtpFFM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E69C4CED2;
	Mon,  3 Feb 2025 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738582028;
	bh=5i9//Kn8WeZxlIxGevzqFSFkR7fJb+ICsICOaG5d6PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLtpFFM0LHY6mSpHB25bqxSaB1j5KS3EOW3qVIrTZ7QR7qGTKVjVhjf+uaw2YPgU0
	 lvsRRsDLRmgJVuxP/Hmyh5DHi0tPsJuLCGem5VMIxjA0K/aV+dM/wX5TWAu7/LQ7zv
	 86/UAHh12/w/zBk6t8Kku5ZL73UVPJXF2T43hdlQ=
Date: Mon, 3 Feb 2025 12:27:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: dakr@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] debugfs: add fsd's methods initialization
Message-ID: <2025020354-diabolic-freezable-095d@gregkh>
References: <2025020345-breath-comma-4097@gregkh>
 <tencent_B0364B121B102524BA72BB5E33CB9E531B08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B0364B121B102524BA72BB5E33CB9E531B08@qq.com>

On Mon, Feb 03, 2025 at 07:05:32PM +0800, Edward Adam Davis wrote:
> On Mon, 3 Feb 2025 09:14:51 +0100, Greg KH wrote:
> > On Mon, Feb 03, 2025 at 11:27:56AM +0800, Edward Adam Davis wrote:
> > > syzbot reported a uninit-value in full_proxy_unlocked_ioctl. [1]
> > >
> > > The newly created fsd does not initialize methods, and increases the
> > > initialization of methods for fsd.
> > >
> > > [1]
> > > BUG: KMSAN: uninit-value in full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
> > >  full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:906 [inline]
> > >  __se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
> > >  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
> > >  x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Fixes: 41a0ecc0997c ("debugfs: get rid of dynamically allocation proxy_ops")
> > > Reported-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=8928e473a91452caca2f
> > > Tested-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  fs/debugfs/file.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Is this still an issue on 6.14-rc1, specifically after commit
> > 57b314752ec0 ("debugfs: Fix the missing initializations in
> > __debugfs_file_get()")?
> No.

Great, I'll forget about it then :)

thanks!

greg k-h

