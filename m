Return-Path: <linux-fsdevel+bounces-63469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7816BBDC92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887AA18986DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1D272E72;
	Mon,  6 Oct 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPLvp5HE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E94272E6D;
	Mon,  6 Oct 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747675; cv=none; b=sX58/7S+vmtzfzPlZCNC56pLnrwiCS+KohEy9PSQVIEC1cSty6jPgIsBox0Vmh+x5hkgZ0fuHvEVX7TCyaa5+Wmx5rR5K19QEDYOti4uCxdlKIScikxaIYeErY1s8F5i5e3coaRZIlEQIntXkjVBxlzrDRMxuB0vhmavb6vssoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747675; c=relaxed/simple;
	bh=zYprqry9t4ZevNtP8tEWITF5icbe5Cfg3GMohDrfass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7DcxyuZXhjWWOJJbiDKrTa6nj2P/aVUfHDFByXBhvV/MxiBnEGaC5jdz3Rpb0Xl1FXVdhPoyBLyTVM+w8Azd6CcBObOwKOzcUKsCvZspdx4XnUDVCskA5CSK7819o/JFOOZEE1ZZcSy58WWx5iHYnWYqo5TpB2ZIAsHlmRkNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPLvp5HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A475C4CEFF;
	Mon,  6 Oct 2025 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759747675;
	bh=zYprqry9t4ZevNtP8tEWITF5icbe5Cfg3GMohDrfass=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPLvp5HEFax2cyv0F35o7qNcFd+V3uCO/GgsKz62gZdlgUFE/F/WiLCf22is7pW7g
	 88hQIm6ZXviepsQ+l3vftDMtMwloggKpUSVlPc+q/sz3RJsxRwzvCNyPo8E4U0jMTV
	 Cu3Bz7kD5S7I1KfQIIIQwHkFHysx5c/N+ywPYCYVHdi065jf9lyH4Yls/y0m1Zmb8+
	 Hg5ulviYrgWzJcs7Hj9PclKfTOobNM3EbsHlnSFx3Rv/b0y1ey0EfuqHvpetUrZYT8
	 Y7qPq+tjTDy+KOAI9umWSWK29pbW6gtUX307GD0bsZgGFxSg+JonW7wlsLQxjuMdta
	 kRMecoOh8XSjg==
Date: Mon, 6 Oct 2025 12:47:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: syzbot <syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] [mm?] WARNING in path_noexec (2)
Message-ID: <20251006-wachsen-zusendung-6cc31055eb75@brauner>
References: <68dc3ade.a70a0220.10c4b.015b.GAE@google.com>
 <202509301457.30490A014C@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202509301457.30490A014C@keescook>

On Tue, Sep 30, 2025 at 03:04:22PM -0700, Kees Cook wrote:
> On Tue, Sep 30, 2025 at 01:17:34PM -0700, syzbot wrote:
> > Reported-by: syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 6000 at fs/exec.c:119 path_noexec+0x1af/0x200 fs/exec.c:118
> 
> Christian, this is:
> 
> bool path_noexec(const struct path *path)
> {
>         /* If it's an anonymous inode make sure that we catch any shenanigans. */
>         VFS_WARN_ON_ONCE(IS_ANON_FILE(d_inode(path->dentry)) &&
>                          !(path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC));
>         return (path->mnt->mnt_flags & MNT_NOEXEC) ||
>                (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);
> }
> 
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e5fd6f980000
> 
> I think is from the created fd_dma_buf. I expect this would fix it:
> 
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 2bcf9ceca997..6e2ab1a4560d 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -189,6 +189,8 @@ static int dma_buf_fs_init_context(struct fs_context *fc)
>  {
>  	struct pseudo_fs_context *ctx;
>  
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;

Yeah, that seems like a good thing to do.
I'm quite happy that the VFS_WARN_ON_ONCE() in there is catching all
this!

Do you want to send a real patch I can pick up?

>  	ctx = init_pseudo(fc, DMA_BUF_MAGIC);
>  	if (!ctx)
>  		return -ENOMEM;
> 
> 
> Which reminds me, this still isn't landed either for secretmem:
> https://lore.kernel.org/all/20250707171735.GE1880847@ZenIV/

It should be in mainline as:
commit 98f99394a104cc80296da34a62d4e1ad04127013 ("secretmem: use SB_I_NOEXEC")

