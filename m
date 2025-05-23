Return-Path: <linux-fsdevel+bounces-49796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDCAC2B28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 22:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0AC3AAAEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC2202976;
	Fri, 23 May 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQQ6ncZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B87482;
	Fri, 23 May 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033726; cv=none; b=aII5UEjK9A3rm7l119e94T1kbeATrhD+WNUjd1My8bLUhg+R3Oom0UzAd8nEIXiJZfo/LVzLTfAaYag2X4k8LT8UOqDbHHfUFrSsv50q/jgQpkURYEWZWsOa/TzKDVH2nyDSHgDy8vAkQIxVQzeJNyFxH8KFiHzC7usm+3DDCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033726; c=relaxed/simple;
	bh=IVHWS6tnx7kSx36MbDnXyPj4cHHcdGh60Uex+YeiCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Ujf1aUBA77UUHggCzyOqzX9Y9Rd2+SihaDhLEs86X9yF/PMNIFA8TXlckIGqrbnfEuUSzHOba2d/Hn07zPKVw9at6sBSW7lXjNwvsl+6rPAzfAn7J0XopLMFcpbrqykJwX5q5+Hjny9swbSRDAVFcMI50kscZaGTqgEwpszrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQQ6ncZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB533C4CEE9;
	Fri, 23 May 2025 20:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748033725;
	bh=IVHWS6tnx7kSx36MbDnXyPj4cHHcdGh60Uex+YeiCpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQQ6ncZoroWoXs1C/8kkHXXpG4VwSvsmRe7qDXLyEe2ZEUhKweSWRjxgE8AYy2yo/
	 pDNRYQzTpIUfHerMKjwyOR6WueWQ1e2kWu/6/vHryqyjeun3E5XzjUjUb5qd3ygLV3
	 0R/FUFasuaEROp8LOXj8Ntahg+lRKXXP/PCtFC2erPjooGebs1n9xvNnZS4F6Fbzmc
	 ZEiG9rxCtCL60pSBXc0TLr34KB0gX5CBDkyXTG36dDPMzcxoXC0q+P4ULuEYn4C6mF
	 7Fi6Ktix46mXpX3v8F5DKmmIbB0ttP8lcdLCkDTL0EouwASpD5r9Uos7bAwWFpHerI
	 X3h3ncE8+q73Q==
Date: Fri, 23 May 2025 13:55:22 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] exec: Add support for 64 byte 'tsk->comm_ext'
Message-ID: <202505231346.52F291C54@keescook>
References: <20250521062337.53262-1-bhupesh@igalia.com>
 <20250521062337.53262-4-bhupesh@igalia.com>
 <202505222041.B639D482FB@keescook>
 <a7c323fe-6d11-4a21-a203-bd60acbfd831@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7c323fe-6d11-4a21-a203-bd60acbfd831@igalia.com>

On Fri, May 23, 2025 at 06:01:41PM +0530, Bhupesh Sharma wrote:
> 2. %s usage: I checked this at multiple places and can confirm that %s usage
> to print out 'tsk->comm' (as a string), get the longer
>     new "extended comm".

As an example of why I don't like this union is that this is now lying
to the compiler. e.g. a %s of an object with a known size (sizeof(comm))
may now run off the end of comm without finding a %NUL character... this
is "safe" in the sense that the "extended comm" is %NUL terminated, but
it makes the string length ambiguous for the compiler (and any
associated security hardening).

> 3. users who do 'sizeof(->comm)' will continue to get the old value because
> of the union.

Right -- this is exactly where I think it can get very very wrong,
leaving things unterminated.

> The problem with having two separate comms: tsk->comm and tsk->ext_comm,
> instead of a union is two fold:
> (a). If we keep two separate statically allocated comms: tsk->comm and
> tsk->ext_comm in struct task_struct, we need to basically keep supporting
> backward compatibility / ABI via tsk->comm and ask new user-land users to
> move to tsk->ext_comm.
> 
> (b). If we keep one statically allocated comm: tsk->comm and one dynamically allocated tsk->ext_comm in struct task_struct, then we have the problem of allocating the tsk->ext_comm which _may_ be in the exec()  hot path.
> 
> I think the discussion between Linus and Yafang (see [1]), was more towards avoiding the approach in 3(a).
> 
> Also we discussed the 3(b) approach, during the review of v2 of this series, where there was a apprehensions around: adding another field to store the task name and allocating tsk->ext_comm dynamically in the exec() hot path (see [2]).

Right -- I agree we need them statically allocated. But I think a union
is going to be really error-prone.

How about this: rename task->comm to something else (task->comm_str?),
increase its size and then add ABI-keeping wrappers for everything that
_must_ have the old length.

Doing this guarantees we won't miss anything (since "comm" got renamed),
and during the refactoring all the places where the old length is required
will be glaringly obvious. (i.e. it will be harder to make mistakes
about leaving things unterminated.)

-- 
Kees Cook

