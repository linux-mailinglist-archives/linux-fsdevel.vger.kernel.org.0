Return-Path: <linux-fsdevel+bounces-30777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CE98E383
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24EAB23C12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA8216A00;
	Wed,  2 Oct 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a8EAvpgz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5loLpHo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190CB130A47;
	Wed,  2 Oct 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897643; cv=none; b=Qo/o6hN92hZ2e3gWD5EoCv2/xSTbjjy6k5oigHSjmdCfrcXgIfa2cN6RcmY3EUjl02v+Kq3TEA+/UGFEtbvN3ls3HIZpSmE1NAF3CKaXQe2XM7M0GKZTPjcuk8Jaw/vepbdehxtguSs1CohjPbA8tERObwG1J4fM2q/V6cnQ+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897643; c=relaxed/simple;
	bh=Jyw9PArjwDuRHPVFMulEYiehjNmM50HB/9qcMkjnWVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BrMXsNj+qDnhhHG1wtfpgMzlz72SemaL1P2AZzswAk9IBLZhOf6OiY3rxhezZG+I0LKDw8TgvLhZa3/Y3yk398SdAIzPpn80NOD8fOuI6TmgKhj1q5hDv2J25a4c/3ckxdhp+CWBJLrA5N8/lv7zmmA09EELVv6F9od7TxHNktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a8EAvpgz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5loLpHo6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727897639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtvYQ0wp1n9mLzgBjKl0MvaObys0We+viPzRs64Jd9I=;
	b=a8EAvpgzFsLCW/AlrRonjZXEMvQOpA87FmbSh5AI8gQcIXGUH6WxsZdbzWa+KKZ9ghfG3C
	rjJ7daCVG39y2XEcTD54l0kTZuloeHUjNr8P1oT8gck1m7dccB/gf8MTOAt/E0sfZUoetM
	3bPau8RswJzdj4TwGtEgrVMksf083ebi1PkFa/6/VgUi4ea+6MTJyTO+LcVXuCcUnq/Fsl
	W3agP3XE5Eo7nH0gv7NdXO8kjZCjEDoWEvrPxu39jswpYmUguRNMFkdRQPdycSJ4V7t7NG
	tZRhGyhYXu8+NfX7nBudvUI5TF/aLXJ2IBsI4eIng/sh3z7DLUhUaDt33xbT9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727897639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtvYQ0wp1n9mLzgBjKl0MvaObys0We+viPzRs64Jd9I=;
	b=5loLpHo6nw1uC3b/hFZ50bSgpoJqRSwTF45XEQYWDIka6DCc9oXrcFkzTwKDsmhykprcQ4
	k7a5a4sFT/H5BhDw==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v9 07/12] timekeeping: add percpu counter for tracking
 floor swap events
In-Reply-To: <20241002-mgtime-v9-7-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
 <20241002-mgtime-v9-7-77e2baad57ac@kernel.org>
Date: Wed, 02 Oct 2024 21:33:59 +0200
Message-ID: <87ed4ywb88.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 02 2024 at 14:49, Jeff Layton wrote:
> ---
>  fs/inode.c                         |  5 +++--

Grmbl. I explicitely asked to split this into timekeeping and fs
patches, no?

That allows me to pick the timekeeping patches up myself and give
Christian a stable tag to pull them from. That lets me deal with the
conflicts with other timekeeping stuff which is coming up instead of
having cross tree conflicts.

> +unsigned long timekeeping_get_mg_floor_swaps(void)
> +{
> +	int i;
> +	unsigned long sum = 0;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

And please use 'cpu'

> +
> +	for_each_possible_cpu(i)
> +		sum += per_cpu(timekeeping_mg_floor_swaps, i);

This needs data_race(per_cpu.....) to tell KCSAN that this is
intentionally racy.

Your previous fs specific patch has the same issue.

> +	return sum < 0 ? 0 : sum;

Right, a sum of unsigned longs really needs to be checked for being negative.

>  #ifdef CONFIG_DEBUG_FS
> +DECLARE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
> +static inline void timekeeping_inc_mg_floor_swaps(void)

Did you lose your newline key?. Can we please not glue this together for
readability sake?

Thanks,

        tglx

