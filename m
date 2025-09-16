Return-Path: <linux-fsdevel+bounces-61819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FFB5A0BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC37586A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF42DC77E;
	Tue, 16 Sep 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqP8rS4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BF275B0F;
	Tue, 16 Sep 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048286; cv=none; b=Ew+hi3hAIZX9o1rvTOEKs7wTC+3KZm/e9pP/CqWOH1QZkqnSpSkJgXank3pwLb3mNW5wXDDLchxIhmKM+5hnnpKxosgwcwufoZsuUEyUNjqtdwb/EUPOxwRECgOYenR2qgvvNN3+5yX6iTjSf0Djla2QqxQbu+MnPLDA2gHrBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048286; c=relaxed/simple;
	bh=ZzH/GAvYqKmV6By6U8xGb7aWR+qRSf/Tqk13YrnBzV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCWGyvmhm1aByL8YtHyxsf3h0Oswqj5a2J6Fxk3eeckKb7ovgnNhNb/8ra9cd2IGRrXl81VExu/Vf7hmaaZRQHwALg8vbqBoOJOgMKjWmEof0Y6LX1ZmmAJU5JFbN70ejrhvZOwywf3/fbzLZpSE7V+gjI3V1FjbUy/3PtKlims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqP8rS4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F7C4CEEB;
	Tue, 16 Sep 2025 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758048286;
	bh=ZzH/GAvYqKmV6By6U8xGb7aWR+qRSf/Tqk13YrnBzV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqP8rS4ixxBvX5q737icWXhhNkcbmE+0dzL4Bz72os3H2J7BTRLCdepUkdu/lOkvv
	 faxnlBz1h+23DALmtOGoq9f7swIb4eWdeD0YgU8hX5iaUVCjSb0fE97ZzL0FiC9tz8
	 11aqlj14HGI6AAANej5ay9Ft1My+1tJuHklHxgxT6IgPT7ZrKyTSgwjpSbfpLAiE1f
	 bpVmUnpvLL3iQruwqrgFzLWUj/s4evyD7SOTbzujR2w6vGO9fqOFRHvH4n/vR7aBKi
	 01JV3B9+/0va+o7YBnT25qfuvF2bcUwqkeCirDptJYozPF/UziNmUMpZMtnOOSI5Ys
	 iM5gGqiTai20Q==
Date: Tue, 16 Sep 2025 11:44:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 2/6] kbuild: Disable asm goto on clang < 17
Message-ID: <20250916184440.GA1245207@ax162>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916163252.100835216@linutronix.de>

Hi Thomas,

First of all, sorry you got bit by this issue.

On Tue, Sep 16, 2025 at 06:33:11PM +0200, Thomas Gleixner wrote:
> clang < 17 fails to use scope local labels with asm goto:
> 
>      {
>      	__label__ local_lbl;
> 	...
> 	unsafe_get_user(uval, uaddr, local_lbl);
> 	...
> 	return 0;
> 	local_lbl:
> 		return -EFAULT;
>      }
> 
> when two such scopes exist in the same function:
> 
>   error: cannot jump from this asm goto statement to one of its possible targets

For the record, this is not specific to local labels, unique function
labels could trigger this error as well, as demonstrated by Nick's test
case:

https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1636342477

> That prevents using local labels for a cleanup based user access mechanism.

Indeed. This has only popped up a couple of times in the past couple of
years and each time it has been easy enough to work around by shuffling
the use of asm goto but as cleanup gets used in more places, this is
likely to cause problems.

> As there is no way to provide a simple test case for the 'depends on' test
> in Kconfig, mark ASM goto broken on clang versions < 17 to get this road
> block out of the way.

That being said, the commit title and message always references asm goto
in the general sense but this change only affects asm goto with outputs.
Is it sufficient to resolve the issues you were seeing? As far as I
understand it, the general issue can affect asm goto with or without
outputs but I assume x86 won't have any issues because the label is not
used in __get_user_asm when asm goto with outputs is not supported?

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nathan Chancellor <nathan@kernel.org>
> ---
> V2: New patch
> ---
>  init/Kconfig |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -96,9 +96,14 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
>  	default y if GCC_VERSION >= 120000 && GCC_VERSION < 120400
>  	default y if GCC_VERSION >= 130000 && GCC_VERSION < 130300
>  
> +config CLANG_ASM_GOTO_OUTPUT_BROKEN
> +	bool
> +	depends on CC_IS_CLANG
> +	default y if CLANG_VERSION < 170000

Assuming this change sticks, please consider including links to the
original bug report and the fix in LLVM:

  https://github.com/ClangBuiltLinux/linux/issues/1886
  https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14

> +
>  config CC_HAS_ASM_GOTO_OUTPUT
>  	def_bool y
> -	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
> +	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN && !CLANG_ASM_GOTO_OUTPUT_BROKEN
>  	depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
>  
>  config CC_HAS_ASM_GOTO_TIED_OUTPUT
> 

