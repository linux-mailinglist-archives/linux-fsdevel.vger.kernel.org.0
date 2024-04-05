Return-Path: <linux-fsdevel+bounces-16168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2F899AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F4B1F2223F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D216ABFB;
	Fri,  5 Apr 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bINCfElL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F86142E73;
	Fri,  5 Apr 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312778; cv=none; b=cKNtQ2gu4jcA/mHhae21izyoC2Aw5ET3vR0eW8Ff6uoTDywHd3bf8ln3GyJ9h4JNYLLDqyo+yS3BeY/cCX5/f8KFRRcqTiz9/NGeb3KS48XwOJiWbkIbTX+4CcYC65FfwjusWcRxNaDAhEwOzf1o1UJpudw99z7vlhupB5LkVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312778; c=relaxed/simple;
	bh=qxvSkouKOtVZUfYflXrpgvGiCmviOJRnuWLFOMraY9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF8b4CQyg/L+GnNXfJuyc5/WftlZiVkWIdxoqGaL/8hyUDRi7kxdxgaXYsQ4caHQG5UnlPoWktDm+FXflum3b4FFN4HB0yov+UVRjiewJ7CKyYPplnWa86LZywgGgrYjeWX4dJ7UtPQVd5p1eLFWTQn7QRtxyPtlk5AT4SAuVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bINCfElL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1883C433C7;
	Fri,  5 Apr 2024 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712312778;
	bh=qxvSkouKOtVZUfYflXrpgvGiCmviOJRnuWLFOMraY9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bINCfElL0YOkSGUGgBWQU1PYTboFoNjPpGUmdkBGEcNqNV3v3DE8rR8UUBoVjXUKZ
	 SF3gqSACH3hIVgkBpt7V3YnZNoH5beyWwUNr8Nq5rkP6D9jVf7JyAXA06DbOKRiFaP
	 U7gqB7jS2VVMEbxMNgQUy66/yy6C+qwiHnB+GvSbRkRIQJhQdtWwzmtHEThe3JaVM2
	 EG6ZC1RLGavidNg6oLm80JqkS+AwnsNa4KT1En63HEr/HvHvWj+wWEiPysX4pQaFVc
	 rG0fQXqGdn/eUccA8z41XKZgsx8EWC5GxnIb3Tcp/UWA0H6whhyugJB3UprYeVElyk
	 dZMOI3E9EM+0w==
Date: Fri, 5 Apr 2024 12:26:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, 
	syzbot <syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com>, Edward Adam Davis <eadavis@qq.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	amir73il@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [linux-next:master] [fs]  1b43c46297: kernel_BUG_at_mm/usercopy.c
Message-ID: <20240405-basisarbeit-kohlenkeller-676735d80a89@brauner>
References: <202404031550.f3de0571-lkp@intel.com>
 <000000000000f075b9061520cbbe@google.com>
 <tencent_A7845DD769577306D813742365E976E3A205@qq.com>
 <20240403-mundgerecht-klopapier-e921ceb787ca@brauner>
 <20240403110316.qtmypq2rtpueloga@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403110316.qtmypq2rtpueloga@quack3>

On Wed, Apr 03, 2024 at 01:03:16PM +0200, Jan Kara wrote:
> On Wed 03-04-24 10:46:19, Christian Brauner wrote:
> > On Wed, Apr 03, 2024 at 02:54:14PM +0800, Edward Adam Davis wrote:
> > > [Syzbot reported]
> > > BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> > > BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> > > Write of size 48 at addr ffff88802b8cbc88 by task syz-executor333/5090
> > > 
> > > CPU: 0 PID: 5090 Comm: syz-executor333 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > >  print_address_description mm/kasan/report.c:377 [inline]
> > >  print_report+0x169/0x550 mm/kasan/report.c:488
> > >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> > >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> > >  instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> > >  _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> > >  copy_from_user include/linux/uaccess.h:183 [inline]
> > >  handle_to_path fs/fhandle.c:203 [inline]
> > >  do_handle_open+0x204/0x660 fs/fhandle.c:226
> > >  do_syscall_64+0xfb/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> > > [Fix] 
> > > When copying data to f_handle, the length of the copied data should not include
> > > the length of "struct file_handle".
> > > 
> > > Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  fs/fhandle.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index 53ed54711cd2..8a7f86c2139a 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
> > >  	*handle = f_handle;
> > >  	if (copy_from_user(&handle->f_handle,
> > >  			   &ufh->f_handle,
> > > -			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
> > > +			   f_handle.handle_bytes)) {
> > 
> > Groan, of course. What a silly mistake. Thanks for the fix.
> > I'll fold this into:
> > Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> > because this hasn't hit mainline yet and it doesn't make sense to keep
> > that bug around.
> > 
> > Sorry, that'll mean we drop your patch but I'll give you credit in the
> > commit log of the original patch.
> 
> Indeed, I should have caught this during review. Sorry for that and thanks
> for fixing this up quickly.

Fwiw, it wasn't meant that way. I meant it's a silly mistake in the
sense that it is so easy to miss because the patch looks so benign. The
fact is that we will have to live with missing things like this once in
a while and that is why we have testing bots as well. :)

