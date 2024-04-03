Return-Path: <linux-fsdevel+bounces-16004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF88969A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A1BB2A916
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6C71737;
	Wed,  3 Apr 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0Po71sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF096FE38;
	Wed,  3 Apr 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134262; cv=none; b=dT+/MeTJR1s5HO0w+eksDX3i/Aewmpyj2CmMrwjfhbaGm5G1c49s+xRXZ/4piabaQU77m+0yxYvV2DCRTQZTo9LKjIceQLMjKJbBilqnt6kCZpimcJRM5cixCUex7Ap3FyUgUxKy+jbgnAn7V0NsJQMciChmcgKiitdH6VGOt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134262; c=relaxed/simple;
	bh=R9D1+elmOmrZeynx4Rov9K9jGhBvCyfaXLdimDufyJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkvV0l5ULgdEWGLJc+AumAz4wSl8bKUimR7fG+1q47a0fQYI8pJMRoBUITD8W7l+P5tD2VCf77hmueYEON4HQmtxNdCiQ+cc3CHLDFc8OJyK6rFqctTAMNght5WoLx/ef3GBRD6VibPywaVkixktAkHPBFBhp0OeJaokQquRiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0Po71sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0434C43399;
	Wed,  3 Apr 2024 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712134262;
	bh=R9D1+elmOmrZeynx4Rov9K9jGhBvCyfaXLdimDufyJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0Po71spXlZPgaNBqPSdKQy6XlDjR98o191JsfZhlyj7lm0qm4cFpUs6qITUDPpd5
	 433H036omrV8RPf0d++00swNJu7LztP/r8MBz2dwY7NiW3qsE7QmbqPWLTtP37sqm2
	 NSo419J1WHhnsEwofUgUTRTssmVYlGl4BuELzCQXzdZkCV4DmrLeS9wB2SFg31BgbM
	 pgz1Ty9KAi5fWBouX5MeNnSUQzKOufuy9Y1wxQRoU+nwQKod7MUF4in7Xrud7Wj1B1
	 SxjO3PY/FLG2gscBhS5qhyLN26ZMi1SAlKixgbDylGyEpPfA3A3bTzBTa19osQtKEO
	 PcHTyIIfYrdFA==
Date: Wed, 3 Apr 2024 10:50:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com, amir73il@gmail.com, chuck.lever@oracle.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH next] fs: fix oob in do_handle_open
Message-ID: <20240403-radau-trubel-97587e8799c4@brauner>
References: <000000000000f075b9061520cbbe@google.com>
 <tencent_A7845DD769577306D813742365E976E3A205@qq.com>
 <72d7604e38ee9a37bcb33a6a537758e4412488ee.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72d7604e38ee9a37bcb33a6a537758e4412488ee.camel@kernel.org>

On Wed, Apr 03, 2024 at 04:48:17AM -0400, Jeff Layton wrote:
> On Wed, 2024-04-03 at 14:54 +0800, Edward Adam Davis wrote:
> > [Syzbot reported]
> > BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> > BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> > Write of size 48 at addr ffff88802b8cbc88 by task syz-executor333/5090
> > 
> > CPU: 0 PID: 5090 Comm: syz-executor333 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >  instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> >  _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> >  copy_from_user include/linux/uaccess.h:183 [inline]
> >  handle_to_path fs/fhandle.c:203 [inline]
> >  do_handle_open+0x204/0x660 fs/fhandle.c:226
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> > [Fix] 
> > When copying data to f_handle, the length of the copied data should not include
> > the length of "struct file_handle".
> > 
> > Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/fhandle.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 53ed54711cd2..8a7f86c2139a 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
> >  	*handle = f_handle;
> >  	if (copy_from_user(&handle->f_handle,
> >  			   &ufh->f_handle,
> > -			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
> > +			   f_handle.handle_bytes)) {
> >  		retval = -EFAULT;
> >  		goto out_handle;
> >  	}
> 
> cc'ing Gustavo, since it looks like his patch in -next is what broke
> this.

I'ved folded the fix into Gustavo's patch. Please see
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.misc&id=02426828cde24cd5b6cf5f30467cea085118f657

