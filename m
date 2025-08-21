Return-Path: <linux-fsdevel+bounces-58624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E62B30065
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2581759ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A62E371B;
	Thu, 21 Aug 2025 16:43:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555BC2E2829;
	Thu, 21 Aug 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794608; cv=none; b=W9hpp61zgjGb3cpPsuk9YSklTL3IAo0lcohnbeVR7bvSQX77ZRLw/YLr9Dmbq7rFwAkMWRNK65oiYmEQQYYV17iaFtrbM9WGQN6iSC8TOeklEL2SiRg44iv3TOOku50OblTGURFxpgc6s+pb1BHmcBAwjh99A+ECa3LeUFlrJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794608; c=relaxed/simple;
	bh=4v0idbTXzPKg9a6oIy2TErpjIQpXjlyAJfPy7bGdEH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuNYyyhNUWMLc4IZ/FKT1qz6lmFXPU0BdcjomfGj12MF/nvZam1nedX7aOJSIkyz4VLA9y1sehe57QJxqrSLFK3KsnZ5tzMOwgJ3Gx5yAVNaOKX0h1nf9Oj6+R/RV5Bx51qDCmI935xYQuIxLyfE0lnfK2chIYAM5rVUyXmrWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id BCE8BC04A4;
	Thu, 21 Aug 2025 16:43:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id AAB9B41;
	Thu, 21 Aug 2025 16:43:14 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:43:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
 kees@kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v8 4/5] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <20250821124319.07843e17@gandalf.local.home>
In-Reply-To: <20250821102152.323367-5-bhupesh@igalia.com>
References: <20250821102152.323367-1-bhupesh@igalia.com>
	<20250821102152.323367-5-bhupesh@igalia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AAB9B41
X-Stat-Signature: 1oa1t5qqbkks8kqanx8ka8mut54jjjfi
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+mRtTllI9WHAwDf6lxFlPKg37+M3gy9xo=
X-HE-Tag: 1755794594-825770
X-HE-Meta: U2FsdGVkX18d4x1NK/MTRDnXGK4K44au4CLBgnuOsLPMQS97oEClGF08S1UQPBqAXUhOYT2+eq5/sAi1mgXdeKmHe3pcFulqgI53Ec4Rb67snLuAtLtfVEavfPmRoD5y7JYHmGcn4Hro2p6dSjq/gIi4DyWBoVzCq3mxjRVILe6FugSo/lVjVT/il2NZmD1RMZHIRrrhVfKMIF217v1uQBErnO0+KI+hW1t4ZB4lPrmLe/Kkw2XO1RYIw7qhRDsjjiko4PcHZx8Idw7WLpJYEFX460Pa2NxLzazRNb+PG3fgUrLoiUP922YDshk8ps52PLY+fC+cpSKl/2qsrZy3Iu9bWaI9/zhmCvlMP6SAHTFm1f+GPmbrHkxx6vkxlhCB

On Thu, 21 Aug 2025 15:51:51 +0530
Bhupesh <bhupesh@igalia.com> wrote:

> +static __always_inline void
> +	__cstr_array_copy(char *dst, const char *src,
> +			  __kernel_size_t size)
> +{
> +	memcpy(dst, src, size);
> +	dst[size] = 0;

Shouldn't this be: dst[size - 1] = 0;

?

Perhaps also add:

	BUILD_BUG_ON(size == 0);

-- Steve

> +}
> +

