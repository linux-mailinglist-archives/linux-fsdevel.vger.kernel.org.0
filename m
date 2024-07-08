Return-Path: <linux-fsdevel+bounces-23325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644F92A9BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5834280F1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB914C5BD;
	Mon,  8 Jul 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgtzeWwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FC146D74;
	Mon,  8 Jul 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466411; cv=none; b=VkGo8/bKfB+23bnEvvKJxvJbqvoE6c/bMiTEvR6t9OZSgTvKl74S/b0QWQCpkecxPieFS8Crn/lDa42Thi5lnLjukc7/t1XTHe3uGBNxBmyD4GvwHvdM45CpMxPGluPSJ1G5LDQd7CTFX1xUMRA2+mGZBjEMRgRDoZ7Oi1Lt2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466411; c=relaxed/simple;
	bh=B268dDDzQZIhdw1CTJ2oimcmD3Bs/VwN5N4g8BjlYKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imFIl7WdvyAyDqnVMOmR8U2PGv6o3qoYiqDy+Nk2XKXY2NoBvu6ryAKVu7EZz27UE2N0/xAPnBDdJtmoxZNkbIzYmZgKBXdC75WSPZACKBQ+WRFSvXRmt1P0QKHAxq0LWksJ2i8tWnDVucHzgAoHAG6TP1j3/2CQIWjMHGdDhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgtzeWwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE32C116B1;
	Mon,  8 Jul 2024 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466411;
	bh=B268dDDzQZIhdw1CTJ2oimcmD3Bs/VwN5N4g8BjlYKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgtzeWwFlAEfcA7xOMy/TyGthlI4u9JcGbzCxQoPMG3eOaRJcgxCLspQWAJpqpHPR
	 Sx+VhNX1lIZ6J9qkGcb4H1vYc5xXwsPrNkJkauX6JyxBJSsTNFRhTUwdejrZe4vgYy
	 j7mciwM02Lj51vstub9WLAZ+HCP0IDpvHTtM6mM0+EuCFzqaEriZNeYPNUtD49DYov
	 TZ5f7JG2Tn/IqEoJWxrpKmAzgaBwyJW3PlcNz5tIfdl6jT6al59oF5VAXWY6KPDK+0
	 Y3PUktXukdzxDpg56de4pYjqhdM8rjZEykeULYoB9Q7zfxHBK5gWc3lBRNVt/4nHgb
	 edK7U/IkncwSg==
Date: Mon, 8 Jul 2024 12:20:10 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
Message-ID: <202407081219.D7D5914@keescook>
References: <00000000000037162f0618b6fefb@google.com>
 <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
 <172021445223.2844396.7059951310501602233.b4-ty@kernel.org>
 <20240706-wucher-gegossen-ed347171f1f0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706-wucher-gegossen-ed347171f1f0@brauner>

On Sat, Jul 06, 2024 at 09:20:30AM +0200, Christian Brauner wrote:
> On Fri, Jul 05, 2024 at 02:20:54PM GMT, Kees Cook wrote:
> > On Tue, 21 May 2024 13:21:46 +0800, Edward Adam Davis wrote:
> > > [syzbot reported]
> > > BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
> > >  sized_strscpy+0xc4/0x160
> > >  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
> > >  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
> > >  vfs_listxattr fs/xattr.c:493 [inline]
> > >  listxattr+0x1f3/0x6b0 fs/xattr.c:840
> > >  path_listxattr fs/xattr.c:864 [inline]
> > >  __do_sys_listxattr fs/xattr.c:876 [inline]
> > >  __se_sys_listxattr fs/xattr.c:873 [inline]
> > >  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
> > >  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > [...]
> > 
> > I've taken some security-related hfsplus stuff before, so:
> 
> It's in #vfs.fixes to go out with the next vfs fixes pr.

Ah, thanks! I've dropped it from my tree now.

-- 
Kees Cook

