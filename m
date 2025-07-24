Return-Path: <linux-fsdevel+bounces-55987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDDB114E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62EE1CC53AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36182472A6;
	Thu, 24 Jul 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW17cz/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FF2E370F;
	Thu, 24 Jul 2025 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400986; cv=none; b=juiPegc0kezCkC2oK7ZiUzfURK4K3c1xbI5D+Pmn+9oquDeSq47mq8mBa/WOWB6UEHAgRZnl7GPOzH7kgv9nLxbQJQ2kH/lxQOi/vW3nGJRxCxbKm+CoY6LqSqTxMj4YUl27+0Ju0acI/eyIYgeHVk8bNkan74lnYMuv1KHP+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400986; c=relaxed/simple;
	bh=yMwOVWXuZtxnuZSKywwnjOh8HTftfAM04cVJJa9ebcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBagZPc2nSt4LFwTOaV6Xj3s5+1DOa3ZQ2PDiDSRqX/twkxtc5uIl+ixT6GfKorevB4OxzJyV03ScJpwzdTjV4UpbYdPluf8aFlGHUP0fTOK9yiahAi4GAEd5J22Upa422IBHwWQwJ+2knMdn1OaikjfhHDbIc7D6I5trJZTAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW17cz/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6103CC4CEED;
	Thu, 24 Jul 2025 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753400983;
	bh=yMwOVWXuZtxnuZSKywwnjOh8HTftfAM04cVJJa9ebcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TW17cz/EEZaZJmmAANQIcH721CVqiYs4LQJri53qVRx99HG1jZN0YeCm+1tRjrZ//
	 Js/j4lVsCcFwwUP0dpNXXlxianCp7nwBPxuD13aaNZcrqJrHOkNKo88vzUd0slfVr4
	 OBXRpHcT8p4UmBYpoWowl95Q3YE2D0bTrkeJ2BuBy8SM8wPSFkeQxJ1D8JcAFVYk7+
	 WSbj5pSUAsPPICBiMuAfcU/14xU79isfbnly6OiAMYgg7uBvBnidj5xY6FrzxAIgzh
	 z7fpjzt+CBzhIMAvNsmNP1tzvobW45LNqeGvkHyXv9OcMANdijzSMQAi4aw7aq8Uzz
	 dIDSeiovGZNSA==
Date: Thu, 24 Jul 2025 16:49:43 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <202507241640.572BF86C70@keescook>
References: <20250724123612.206110-1-bhupesh@igalia.com>
 <20250724123612.206110-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724123612.206110-3-bhupesh@igalia.com>

On Thu, Jul 24, 2025 at 06:06:11PM +0530, Bhupesh wrote:
> As Linus mentioned in [1], currently we have several memcpy() use-cases
> which use 'current->comm' to copy the task name over to local copies.
> For an example:
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  ...
> 
> These should be modified so that we can later implement approaches
> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
> in a more modular way (follow-up patch does the same):
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  comm[TASK_COMM_LEN - 1] = '\0';
>  ...

Why not switch all of these to get_task_comm()? It will correctly handle
the size check and NUL termination.

In an earlier thread[1], I pointed out that since __set_task_comm() always
keeps a final NUL byte, we're always safe to use strscpy(). (We want to
block over-reads and over-writes but don't care about garbled reads.)

In the new case of copying into a smaller buffer, strscpy() will always
handle writing the final NUL byte.

The only special cases I can think of would be non-fixed-sized
destination buffers, which get_task_comm() doesn't like since it can't
validate how to safely terminate the buffer. The example you give above
isn't that, though.

-Kees

[1] https://lore.kernel.org/all/202411301244.381F2B8D17@keescook/

-- 
Kees Cook

