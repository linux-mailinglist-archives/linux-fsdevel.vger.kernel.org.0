Return-Path: <linux-fsdevel+bounces-55988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0AB114E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B361CC7DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA662472B6;
	Thu, 24 Jul 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcukdJL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78987244688;
	Thu, 24 Jul 2025 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753401016; cv=none; b=FK3tkAwLkb06g8O0dOId43U6KWyU8fFYqlmhX4aBumZNArbzVo6sxz+/lmv4qpJ+icGTSJusRTIRxvBSqNcTaBP3yxQC1fwlbzjc5OrGckIpKfWT7q1+22oiGA3eabc9OJE1EgNM8UbWQsHOw52Kg2FQ760eQncmC7hPQxwLHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753401016; c=relaxed/simple;
	bh=J6zs3FFWOtVduMYpXGiST9B8M7PoDvH4oTJVHYKE6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCaYJrDZOzYvjAgM86WG7HM4Hupca4ZrQdSfXuqjvYeWitO1bstQNCqCM716GtDLb4tlWvxygQJKQd+VUAvlEBfgE1d4PsxWwdqsj1AaqpPjRPN6Mu4/YB7ENH558YWcGOP60ozL1WKEa1WwULWliGsaroqM9yXWuoMZby0inPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcukdJL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1548C4CEED;
	Thu, 24 Jul 2025 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753401014;
	bh=J6zs3FFWOtVduMYpXGiST9B8M7PoDvH4oTJVHYKE6SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcukdJL/ITnC9B/6oSNZkRN7qMgCr3fx+HQWcklBTgNH0czFn29ZzFJh/7RGswJFB
	 XhAQlsk1vQf3rsk79Q+E6SzCG+0/fOMNSfgQWx2q90/IFeRmylGKbYImHUbt7rXBLI
	 SqTbIw+G6lsg5tscwPTOo1hO+3HSrh2JDeOf+AG1Brwvcg/TiYy0bs4986CzTaZ0GI
	 YsItvCVhIOdqN4j76ivNLyQEmhDnobMc7nF22MNtsVExgD4pyBMZZMGYe9BEJl9IS3
	 IzHClgqaNelOaEjSZ86OyHBpr1zvQpSdshxTttFjLw8NMs9lIUuuXmDqLYdk5WiEBn
	 n7unBcDgXNtqg==
Date: Thu, 24 Jul 2025 16:50:14 -0700
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
Subject: Re: [PATCH v6 1/3] exec: Remove obsolete comments
Message-ID: <202507241650.ADBB05F@keescook>
References: <20250724123612.206110-1-bhupesh@igalia.com>
 <20250724123612.206110-2-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724123612.206110-2-bhupesh@igalia.com>

On Thu, Jul 24, 2025 at 06:06:10PM +0530, Bhupesh wrote:
> Patch 3a3f61ce5e0b ("exec: Make sure task->comm is always NUL-terminated"),
> replaced 'strscpy_pad()' with 'memcpy()' implementations inside
> '__set_task_comm()'.
> 
> However a few left-over comments are still there, which mention
> the usage of 'strscpy_pad()' inside '__set_task_comm()'.
> 
> Remove those obsolete comments.
> 
> While at it, also remove an obsolete comment regarding 'task_lock()'
> usage while handing 'task->comm'.
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

