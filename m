Return-Path: <linux-fsdevel+bounces-74306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED2D393AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B94E3004603
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D64285CA8;
	Sun, 18 Jan 2026 09:51:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB01B142D
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729872; cv=none; b=Xm2lQ1Xro1gxdh9i/IBV/r+hw4/owRAKzwWK85LT+u9aGh7/eltvN5llo1T446IqLcNqIomgyZmzSoKEn6MYdx87LFV9crwXWPtDBWpTmWxcCHvPc26UHOOPGDpl66UPQaF6mFrVzxkWqGOIAgoshkcsGxt/yDlj85eUxah2mRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729872; c=relaxed/simple;
	bh=L/6KQihQANacl58vwtA9Y+sUswN+ka/wML027AO+aAg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W69fr8I1V5Z9LEHrQGaLKkicIGXotG2NFOEELJQWCN+GtxaGCEaaoytwlXGfFyNQcGc9dodg2/w3rg53zec+Rm2hHCFR08+pY4gjjp0c8tBTFc7rdcx6iaKvdfCv4zCPtjjR4xEvNbDGeWKJFwQHQePGsLjXI5pBP065Xvj2aL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60I9oShH012454;
	Sun, 18 Jan 2026 18:50:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60I9oRYx012450
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 18 Jan 2026 18:50:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6d2ed161-b302-4475-b32c-2feca1f84026@I-love.SAKURA.ne.jp>
Date: Sun, 18 Jan 2026 18:50:25 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH (REPOST)] hpfs: make check=none mount option excludable
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Mikulas Patocka <mikulas@twibright.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>,
        Viacheslav Sablin <sjava1902@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        Deepanshu Kartikey <kartikey406@gmail.com>
References: <51bdd056-61dd-4b57-8780-324b2f8bc99f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <51bdd056-61dd-4b57-8780-324b2f8bc99f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

Mikulas, are you there?

A patch was posted to https://lkml.kernel.org/r/20260117054014.1252933-1-kartikey406@gmail.com
for a bug report which Mikulas would not accept as a valid bug because of "check=none".

If Mikulas keeps silence, maybe we should out-out hpfs from fuzz testing...

On 2026/01/13 19:08, Tetsuo Handa wrote:
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
> 
> Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
> Link: https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com
> Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Mikulas wants fuzz testing systems not to specify "check=none" option. But it is
> too difficult to enforce that. It is possible that an unexpected input hides
> "hpfs: You really don't want any checks? You are crazy..." message due to changing
> loglevel, and after that the kernel may hit this problem (i.e. we will be needlessly
> bothered by stupid inputs).
> 
> Honestly speaking, the code that runs in the kernel space needs to be as careful as
> possible, for any memory access error in the kernel space can result in serious result.
> We are fixing various input validations for all (but HPFS) filesystems. It is strange
> that HPFS is exempted from this rule. I expect that "check=none" behavior (if someone
> wants such behavior) should be emulated in the user space using FUSE filesystem.
> 
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


