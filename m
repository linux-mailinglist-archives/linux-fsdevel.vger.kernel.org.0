Return-Path: <linux-fsdevel+bounces-44877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A6A6DF73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1522188A60E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D392E2638BF;
	Mon, 24 Mar 2025 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUooPKZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF4261577;
	Mon, 24 Mar 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833146; cv=none; b=iQaTvm2RN09MQAHrVkrn0sglsDbQt5yMHu5mszZA2YxAaEiqlFrDGECTbycqNxKZBnA5rSEU+awfu/yRcdmOutaxNGJCNiRiQ/aHeZfzEwhI3f5/O9x3/4klOUo00zU+jKrxA8wAcINsxNcRydPy1FHTUA06e9VPxHlp5KJ/rpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833146; c=relaxed/simple;
	bh=7ocTwtJHSxgTAKQDZy8c0kf/SmLiv3uVNj5AZmyLi2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdhKWAmysg9knSlYcuh51S3CC35Y6EL0ny8mrgzp2hHNO9xO5Jvjy4ggPJnM8Ey5aV9ssE++mkyxkivW/GDK0AC4ghq0hgPd0xVsZigFzmje6FAnv1LVQhOsJWsSwifsmuEslbFrGzPkW/BMTdqSwjfgIhbJpbou2KXBNL6/Jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUooPKZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D04C4CEE9;
	Mon, 24 Mar 2025 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742833144;
	bh=7ocTwtJHSxgTAKQDZy8c0kf/SmLiv3uVNj5AZmyLi2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUooPKZvSqG2lE2mau828JPJBCXqBGBWdLNKx4DZ3c1ltWrxxCstK+OxOev+p3o+9
	 MQewyp5MDtnVRyYOE7295XtueeBrJTywvs/ixDbOl16CoI0WZ8IxQlj2OkDhp+Xp9n
	 UB8kTHHytRTZhFw5ztOj+1CzBI8KXmmqDboLfaJk=
Date: Mon, 24 Mar 2025 09:17:05 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <2025032402-jam-immovable-2d57@gregkh>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>

On Mon, Mar 24, 2025 at 07:14:07PM +0300, Cengiz Can wrote:
> On 20-03-25 20:30:15, Salvatore Bonaccorso wrote:
> > Hi
> > 
> 
> Hello Salvatore,
> 
> > On Sat, Oct 19, 2024 at 10:13:03PM +0300, Vasiliy Kovalev wrote:
> > > Syzbot reported an issue in hfs subsystem:
> > > 
> > > BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
> > > BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> > > BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> > > Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
> > > 
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:377 [inline]
> > >  print_report+0x169/0x550 mm/kasan/report.c:488
> > >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> > >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> > >  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
> > >  memcpy_from_page include/linux/highmem.h:423 [inline]
> > >  hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> > >  hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> > >  hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
> > >  hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
> > >  hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
> > >  vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
> > >  do_mkdirat+0x264/0x3a0 fs/namei.c:4280
> > >  __do_sys_mkdir fs/namei.c:4300 [inline]
> > >  __se_sys_mkdir fs/namei.c:4298 [inline]
> > >  __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7fbdd6057a99
> > > 
> > > Add a check for key length in hfs_bnode_read_key to prevent
> > > out-of-bounds memory access. If the key length is invalid, the
> > > key buffer is cleared, improving stability and reliability.
> > > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> > > ---
> > >  fs/hfs/bnode.c     | 6 ++++++
> > >  fs/hfsplus/bnode.c | 6 ++++++
> > >  2 files changed, 12 insertions(+)
> > > 
> > > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > > index 6add6ebfef8967..cb823a8a6ba960 100644
> > > --- a/fs/hfs/bnode.c
> > > +++ b/fs/hfs/bnode.c
> > > @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
> > >  	else
> > >  		key_len = tree->max_key_len + 1;
> > >  
> > > +	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> > > +		memset(key, 0, sizeof(hfs_btree_key));
> > > +		pr_err("hfs: Invalid key length: %d\n", key_len);
> > > +		return;
> > > +	}
> > > +
> > >  	hfs_bnode_read(node, key, off, key_len);
> > >  }
> 
> Simpler the better. 
> 
> Our fix was released back in February. (There are other issues in our attempt I
> admit).
> 
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=2e8d8dffa2e0b5291522548309ec70428be7cf5a
> 
> If someone can pick this submission, I will be happy to replace our version.

any specific reason why you didn't submit this upstream?  Or did that
happen and it somehow not get picked up?

And why assign a CVE for an issue that is in the mainline kernel, last I
checked, Canonical was NOT allowed to do that.

Please work to revoke that CVE and ask for one properly.

thanks,

greg k-h

