Return-Path: <linux-fsdevel+bounces-23252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B707392916E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1C2839DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3B1CAA1;
	Sat,  6 Jul 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cngTXBPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538491A29A;
	Sat,  6 Jul 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720250437; cv=none; b=CX0aL/h9bJX4pFbt5CJUMVWLvWph9c/Wj3hxaz+9QlDFUvwERhihkvP991jHeEppcUagdV9MroDZsboACs/6ZTeEt9XOgrKGBCAKTdwjah4y+7YZu/KQBiaha1IShB1ljfIOF+hf6vro4q2tNnsBpl87IPfoHwHRztAgBxtkOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720250437; c=relaxed/simple;
	bh=AyJhZ1OsPAz+jn+FoH2nRyJkqPAWbBa3+PqqzoYn8KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy6Lbjc5PXaGIp1wvOpbiurvdq2MWEu5wJHq+8drF3fFYZAzM7Rk16dOYaJdC1/ZE+hgNYIlM+tgomT32GMbUPKu/uYhXMWnL/i8i7evnL166JUDH+ygBRl3RzqZEg8BKwo8LuXA6LB/C80bbDJ/v+CEUNnFrKdAKWB6FN9mvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cngTXBPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD1C2BD10;
	Sat,  6 Jul 2024 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720250436;
	bh=AyJhZ1OsPAz+jn+FoH2nRyJkqPAWbBa3+PqqzoYn8KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cngTXBPdwOw4rF/NW4GwbigxCsNzQy7dzw5A4tsw9tO+aviw7AhEUquWwqIe4ItMg
	 QEEKnNPhVzwZBUo/1yYzg4tp8dLkw000BcwWRqisVvhc8iOwWgoI8s/HkYWEaktXYU
	 dGks6zZS+3HJccX63xqM+0iUdbv9qLbvVIjtSZ7J3JGaqTGISNouuw9h68VYLcZW9q
	 zzKwek5daUqeBuVlUihrZ9x1kJgSBP/NXgwQLFko2PsvKc0g+Ejz0FNqYRK9pALRnE
	 X1TSvhZlOPXGqQaQhCduCh9JejlBEOLtAXQ3lu0E9OYJy4CH7F8z+fJJXp3AfQSV0E
	 CTTVRHojFBDuQ==
Date: Sat, 6 Jul 2024 09:20:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com, 
	Edward Adam Davis <eadavis@qq.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
Message-ID: <20240706-wucher-gegossen-ed347171f1f0@brauner>
References: <00000000000037162f0618b6fefb@google.com>
 <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
 <172021445223.2844396.7059951310501602233.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172021445223.2844396.7059951310501602233.b4-ty@kernel.org>

On Fri, Jul 05, 2024 at 02:20:54PM GMT, Kees Cook wrote:
> On Tue, 21 May 2024 13:21:46 +0800, Edward Adam Davis wrote:
> > [syzbot reported]
> > BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
> >  sized_strscpy+0xc4/0x160
> >  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
> >  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
> >  vfs_listxattr fs/xattr.c:493 [inline]
> >  listxattr+0x1f3/0x6b0 fs/xattr.c:840
> >  path_listxattr fs/xattr.c:864 [inline]
> >  __do_sys_listxattr fs/xattr.c:876 [inline]
> >  __se_sys_listxattr fs/xattr.c:873 [inline]
> >  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
> >  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > [...]
> 
> I've taken some security-related hfsplus stuff before, so:

It's in #vfs.fixes to go out with the next vfs fixes pr.

