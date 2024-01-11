Return-Path: <linux-fsdevel+bounces-7757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2B482A527
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA73B224B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 00:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EF15AC9;
	Thu, 11 Jan 2024 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TPVwtBA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0715AC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Jan 2024 19:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704931490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2IQAAkxnLuUMxv9NSh6qvw4HFuvQ0QulM8iosjGYXXE=;
	b=TPVwtBA0nNR2Dlq5cBC3uagm3udcuT1hk8dDtZXNC8HJxUYCKEXfCRCte0HOK8Sant73Md
	bpQmLn62djM356rAQfc8yXRyh9Ct+EvdIVSTiUVCQoRqy/JY3dI1SHGfI5bMzKGc3phKX5
	WMQU/j2liBSQUyVHU3OGj8Wbn741nH8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401101525.112E8234@keescook>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 10, 2024 at 03:48:43PM -0800, Kees Cook wrote:
> On Wed, Jan 10, 2024 at 02:36:30PM -0500, Kent Overstreet wrote:
> > [...]
> >       bcachefs: %pg is banished
> 
> Hi!
> 
> Not a PR blocker, but this patch re-introduces users of strlcpy() which
> has been otherwise removed this cycle. I'll send a patch to replace
> these new uses, but process-wise, I'd like check on how bcachefs patches
> are reviewed.

I'm happy to fix it. Perhaps the declaration could get a depracated
warning, though?

> Normally I'd go find the original email that posted the patch and reply
> there, but I couldn't find a development list where this patch was
> posted. Where is this happening? (Being posted somewhere is supposed
> to be a prerequisite for living in -next. E.g. quoting from the -next
> inclusion boiler-plate: "* posted to the relevant mailing list,") It
> looks like it was authored 5 days ago, which is cutting it awfully close
> to the merge window opening:
> 
> 	AuthorDate: Fri Jan 5 11:58:50 2024 -0500

I'm confident in my testing; if it was a patch that needed more soak
time it would have waited.

> Actually, it looks like you rebased onto v6.7-rc7? This is normally
> strongly discouraged. The common merge base is -rc2.

Is there something special about rc2?

I reorder patches fairly often just in the normal course of backporting
fixes, and if I have to rebase everything for a backport I'll often
rebase onto a newer kernel so that the people who are running my tree
are testing something more stable - it does come up.

> It also seems it didn't get a run through scripts/checkpatch.pl, which
> shows 4 warnings, 2 or which point out the strlcpy deprecation:
> 
> WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
> #123: FILE: fs/bcachefs/super.c:1389:
> +               strlcpy(c->name, name.buf, sizeof(c->name));
> 
> WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
> #124: FILE: fs/bcachefs/super.c:1390:
> +       strlcpy(ca->name, name.buf, sizeof(ca->name));
> 
> Please make sure you're running checkpatch.pl -- it'll make integration,
> technical debt reduction, and coding style adjustments much easier. :)

Well, we do have rather a lot of linters these days.

That's actually something I've been meaning to raise - perhaps we could
start thinking about some pluggable way of running linters so that
they're all run as part of a normal kernel build (and something that
would be easy to drop new linters in to; I'd like to write some bcachefs
specific ones).

The current model of "I have to remember to run these 5 things, and then
I'm going to get email nags for 3 more that I can't run" is not terribly
scalable :)

