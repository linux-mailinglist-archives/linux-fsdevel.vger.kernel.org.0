Return-Path: <linux-fsdevel+bounces-64157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD10BDAFD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25CC5354B01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521029B200;
	Tue, 14 Oct 2025 19:03:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from leontynka.twibright.com (leontynka.twibright.com [109.81.181.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A520235072;
	Tue, 14 Oct 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.81.181.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468595; cv=none; b=ND5e8mJ7i0HtNQyarOVXV7kCqmjEq0u87Nu90y2wtZZz/gA0+w7rxvtUP47NRRRUYjzT9IkezUkZXk/em546MrtIwzTYVAxjKYUQKxcwpKbxvkQW4Pwukmk9dfULqtB2w3Z4/SeimQP2gepWuWrDF6L5Rp1SrB0YwJ5SbsKxe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468595; c=relaxed/simple;
	bh=PSh1yxYuQfaN8kfvio1jUgHSDJ2nwVo4I8fMu2elrRg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fr6zteLb2r/QaMTYbwppd6XIIqBz45bDw32ib7d689J6TR3Tzjt6A8OtH2K7TZydgdrQpqQ85S/C+3DO871KKgFmZmRh9mS26N0IrqjdPJZOuuGSNKVWcgTcZF5tTY9pCookxZnhppgWqLQylAp5K9baYiPTWMc8eTzFNYvt9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=twibright.com; spf=pass smtp.mailfrom=twibright.com; arc=none smtp.client-ip=109.81.181.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=twibright.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twibright.com
Received: from mikulas (helo=localhost)
	by leontynka.twibright.com with local-esmtp (Exim 4.96)
	(envelope-from <mikulas@twibright.com>)
	id 1v8jiO-00EeLE-2C;
	Tue, 14 Oct 2025 20:25:40 +0200
Date: Tue, 14 Oct 2025 20:25:40 +0200 (CEST)
From: Mikulas Patocka <mikulas@twibright.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc: linux-kernel@vger.kernel.org, 
    Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
    Antoni Pokusinski <apokusinski01@gmail.com>, 
    linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] hpfs: make check=none mount option excludable
In-Reply-To: <d74eef30-fed4-46a8-801e-c86e8ed2632f@I-love.SAKURA.ne.jp>
Message-ID: <889ee229-8f2f-2bd4-c870-fbd11a3c4098@twibright.com>
References: <68794b99.a70a0220.693ce.0052.GAE@google.com> <8a2fc775-e4f7-406d-b6dd-8b1f3cd851a3@I-love.SAKURA.ne.jp> <d74eef30-fed4-46a8-801e-c86e8ed2632f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 14 Oct 2025, Tetsuo Handa wrote:

> syzbot is reporting use-after-free read problem when a crafted HPFS image
> was mounted with "check=none" option.
> 
> The "check=none" option is intended for only users who want maximum speed
> and use the filesystem only on trusted input. But fuzzers are for using
> the filesystem on untrusted input.
> 
> Mikulas Patocka (the HPFS maintainer) thinks that there is no need to add
> some middle ground where "check=none" would check some structures and won't
> check others. Therefore, to make sure that fuzzers and careful users do not
> by error specify "check=none" at runtime, make "check=none" being
> excludable at build time.

Hi

Would it be possible to change syzbot to not use the "check=none" option?

Mikulas

> Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
> Link: https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com
> Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hpfs/Kconfig | 11 +++++++++++
>  fs/hpfs/super.c |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
> index ac1e9318e65a..d3dfbe76be8a 100644
> --- a/fs/hpfs/Kconfig
> +++ b/fs/hpfs/Kconfig
> @@ -15,3 +15,14 @@ config HPFS_FS
>  
>  	  To compile this file system support as a module, choose M here: the
>  	  module will be called hpfs.  If unsure, say N.
> +
> +config HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
> +	bool "Allow no-error-check mode for maximum speed"
> +	depends on HPFS_FS
> +	default n
> +	help
> +	  This option enables check=none mount option. If check=none is
> +	  specified, users can expect maximum speed at the cost of minimum
> +	  robustness. Sane users should not specify check=none option, for e.g.
> +	  use-after-free bug will happen when the filesystem is corrupted or
> +	  crafted.
> diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
> index 8ab85e7ac91e..656b1ae01812 100644
> --- a/fs/hpfs/super.c
> +++ b/fs/hpfs/super.c
> @@ -285,7 +285,9 @@ static const struct constant_table hpfs_param_case[] = {
>  };
>  
>  static const struct constant_table hpfs_param_check[] = {
> +#ifdef CONFIG_HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
>  	{"none",	0},
> +#endif
>  	{"normal",	1},
>  	{"strict",	2},
>  	{}
> -- 
> 2.47.3
> 
> 
> 

