Return-Path: <linux-fsdevel+bounces-37045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B319D9ECA46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B317188BB88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34582210C0;
	Wed, 11 Dec 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHZtto9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3432101B8;
	Wed, 11 Dec 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912632; cv=none; b=Uv6V3Xt0Izw24aMMItO+3mUv4BCDJE8108vIcClz/3g6p3AXaMab+bgp2Wao+fAu/wE0sLklBFJRsZmsKza+wN+JsIlYLXVlvXoqB+PffqfEaf/SSqKso3H4dID1k4VQ2KgL93Spvi6g4YqiANDaChLR63+PkWTv3+Lb8Mwa+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912632; c=relaxed/simple;
	bh=qqqXOv/RjcZrs4T7tVuZ+X03T1XAPT1JxkdxrPXPDr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCXQiDB/2mA8nhmrWuqK5JQSCVXFvrK3faLU8/JqH6Z78Xsv7wDsgco/fZwAcAHkV+L836zWwCVuOMJekxAIcZZ2JsgK1PfV8+8//z0UPhUEkATnjjMaWgNp3YGDMK33Q85hixDzP19GC2Ck5xnBRpRp7aOBp7MvLS6chDvD+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHZtto9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE8EC4CED2;
	Wed, 11 Dec 2024 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733912631;
	bh=qqqXOv/RjcZrs4T7tVuZ+X03T1XAPT1JxkdxrPXPDr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHZtto9lS6MacDzeDayzGJlJswaNGRfYfCsycwjp8+OZqjq+9OFXosM0zNKhWjB0o
	 8yL1UH8JmYll1s40biRGrQAbAiaac/pGywKLTbdhWCOR4uKyg9zf2ts7LwiruwI6dU
	 UwdLST631KKkUjdn3YaEFA/uKyl0obKfDYfHudh40oavb8Fn8JJQi+60InjvTZp5oZ
	 INnxrhqTk+F4CRoq2rVOF0VViGgx/wsNopYbiR6+/2Qh0vm4e71W6olcXExgYcvO+c
	 JDmIo3UJafgbIjie042E5Ll43N5l9/TzaEIvg4we1AekgDXfuBi8qVksfrBRT/qbVf
	 4BlBjcwSfM3GQ==
Date: Wed, 11 Dec 2024 11:23:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH RFC v3 02/10] sched_getattr: port to copy_struct_to_user
Message-ID: <20241211-gemsen-zuarbeiten-ae8d062ec251@brauner>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
 <20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
 <87y10nz9qo.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y10nz9qo.fsf@oldenburg.str.redhat.com>

On Tue, Dec 10, 2024 at 07:14:07PM +0100, Florian Weimer wrote:
> * Aleksa Sarai:
> 
> > sched_getattr(2) doesn't care about trailing non-zero bytes in the
> > (ksize > usize) case, so just use copy_struct_to_user() without checking
> > ignored_trailing.
> 
> I think this is what causes glibc's misc/tst-sched_setattr test to fail
> on recent kernels.  The previous non-modifying behavior was documented
> in the manual page:
> 
>        If the caller-provided attr buffer is larger than the kernel's
>        sched_attr structure, the additional bytes in the user-space
>        structure are not touched.
> 
> I can just drop this part of the test if the kernel deems both behaviors
> valid.

I think in general both behaviors are valid but I would consider zeroing
the unknown parts of the provided buffer to be the safer option. And all
newer extensible struct system calls do that.

But if sched_getattr(2) wants to keep its old behavior it wouldn't be a
problem to just handle this case:

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0d71fcbaf1e3..46140ec449ba 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1126,6 +1126,15 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
        }

        kattr.size = min(usize, sizeof(kattr));
+       /*
+        * If userspace passed a larger structure than the kernel knows
+        * we historically didn't zero the unknown bits but
+        * copy_struct_to_user() will. Retain the old behavior by
+        * limiting the copy_to_user() to the size the kernel knows
+        * about.
+        */
+       if (usize > sizeof(kattr))
+               usize = sizeof(kattr);
        return copy_struct_to_user(uattr, usize, &kattr, sizeof(kattr), NULL);
 }


