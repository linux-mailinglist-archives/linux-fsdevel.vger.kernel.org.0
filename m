Return-Path: <linux-fsdevel+bounces-21857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F190BFEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A86283D05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 23:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B3199EB5;
	Mon, 17 Jun 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0zjVGZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF2288BD;
	Mon, 17 Jun 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668366; cv=none; b=Rs6FGAr+GHTjf5FLWjVDzIHx6YYAvTTKZiVX7cX3PN3RcM5rqVnlALvexUaOUsf8JmyxG9GxD6jyuOoVHh30dsy2jiLVgpb52Ar+MAPP83o4Sao/mI/BZrJl8XsPRe2bP1oOAGB/UY91sHQSDoTmMa1uVcnQNUL4sPFM2mksiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668366; c=relaxed/simple;
	bh=XH/Ys2ciAiUbbnpeQ5FnDRYSQBsdh18eRcWNFa4H9Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnK2IH7K+NZGZaJRjMh3HhyF3ckamo+2oz0xU8t097e31dPLJ4qYF+eYXJo01io3c9/jQNKpSbClNptT13jqAqqAIg7XRvGMku0tq9YCgkKmvG32wrmJiPwuUq0VA4xu8RHiCTb7FSDqIRkQ7GTu8rH0rikgl9iw3GhU1dNAgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0zjVGZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F338EC2BD10;
	Mon, 17 Jun 2024 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718668366;
	bh=XH/Ys2ciAiUbbnpeQ5FnDRYSQBsdh18eRcWNFa4H9Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0zjVGZ3WfZt2lkKyK++fGQ5Uci1WGTl67tFp0SWYSLCa6sXwZ2zRFVTO4GCzk6U6
	 hcHRAcC5M3wPfTlEM96vQUS4BmIaa+/RErHWrO3NqkfS4BLTMs4j6ooBfMKlErkNHB
	 oY207cL8pnPACBMpeNmg55s5wJsZSYMprq604GVSt4nLmpiGNec7S/u6jTPmpm/z9O
	 Jbzk3pKdp4twSWcC9LCW8hzLwpUgFz0+oKDYUYmf7B+qd8g2eS5AS7redsj9MRbZTQ
	 o4bM1mPZv9x4hclE0DjrTbc4jXYWoYRGgNDb05ytD29VpUMSpVkHAyDebL+bKDGPV5
	 RW8OEFINGZOeg==
Date: Mon, 17 Jun 2024 16:52:45 -0700
From: Kees Cook <kees@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
	bigeasy@linutronix.de, brauner@kernel.org, ebiederm@xmission.com,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
	apais@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
Message-ID: <202406171649.8F31EAFE@keescook>
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
 <20240617234133.1167523-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617234133.1167523-2-romank@linux.microsoft.com>

On Mon, Jun 17, 2024 at 04:41:30PM -0700, Roman Kisel wrote:
> Missing, failed, or corrupted core dumps might impede crash
> investigations. To improve reliability of that process and consequently
> the programs themselves, one needs to trace the path from producing
> a core dumpfile to analyzing it. That path starts from the core dump file
> written to the disk by the kernel or to the standard input of a user
> mode helper program to which the kernel streams the coredump contents.
> There are cases where the kernel will interrupt writing the core out or
> produce a truncated/not-well-formed core dump.

Hm, I'm all for better diagnostics, but they need to be helpful and not
be a risk to the system. All the added "pr_*()" calls need to use the
_ratelimited variant to avoid a user inducing massive spam to the system
logs. And please standardize the reporting to include information about
the task that is dumping. Otherwise the logging isn't useful for anyone
reading it. Something that includes pid and task->comm at the very
least. :)

For example, see report_mem_rw_reject() in
https://lore.kernel.org/lkml/20240613133937.2352724-2-adrian.ratiu@collabora.com/

-Kees

-- 
Kees Cook

