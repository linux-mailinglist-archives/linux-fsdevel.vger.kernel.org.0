Return-Path: <linux-fsdevel+bounces-47398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F502A9CF25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583A57AE128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D01DED60;
	Fri, 25 Apr 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK3ro41n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12571A23A0;
	Fri, 25 Apr 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600978; cv=none; b=I+LMBzJdUFhdydyB0ekBF3H9HuA43IlH/h5+m1GIZP7GY6yV5pRFGbGV8hCZoqWOrzBhZc/pRmqyYPqUf8tvhw8d0z9U0GZLvWSEGE2Lx+raBmsKyzo1VN6YqOPTUSGjrp2demqQ11XbdJgNVRtQ/s+pMei7gFYzBJywRRJTiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600978; c=relaxed/simple;
	bh=yPI9RwIxxq/NTAS39rdib9EWfVe1cDzmMU4iH7dYSU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUYjiF+asWJZHXXJhPs/XGLgygE59kMLphzia8iPzx2gmq1BAglGx0om89Is+dXZVfWfQrhxqM7YqqjDxayZNytkMChXgPDln6TRPudV1vYBvCtQp6EgyQUoTuHZXnJBPWZts2ZtV3FDguBvbe9jOL47k3Ya7EnTobCxf2bnyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK3ro41n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D55EC4CEE4;
	Fri, 25 Apr 2025 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745600978;
	bh=yPI9RwIxxq/NTAS39rdib9EWfVe1cDzmMU4iH7dYSU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FK3ro41n0ITFuq+eCIkqVW6QZi1IqOB1y/tU2dwHj0f540wc3jIS2AFnScaQZbgBM
	 71hgD/kIhac5YlE60SKsS3Xqve1l9t/O5fz/efn5atxJM0q4VeV7gAJhFxnCNpqlEA
	 QN0Xlt2RqK+f2cvZnuep8h+ShKk+oopJiPmHr8jbyKQwJwil/XNt7vX0GXlmFEgsRi
	 nZRd20ZWOmwKQXqO72pu2tUO9nKx4JlFmpvDpdAzXIQvW6wO0n0SYaQ0uv+hUsleka
	 0RvHE0LDWMw/s79wtBqBGoeQbcz0hikY462IlUVC5ptHljF/VPY7Zi1ESGcoKOkhwQ
	 5BN7+edDki9Vg==
Date: Fri, 25 Apr 2025 10:09:34 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: abstract initial stack setup to mm subsystem
Message-ID: <202504250925.58434D763@keescook>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
 <92a8e5ef7d5ce31a3b3cf631cb65c6311374c866.1745592303.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a8e5ef7d5ce31a3b3cf631cb65c6311374c866.1745592303.git.lorenzo.stoakes@oracle.com>

On Fri, Apr 25, 2025 at 03:54:34PM +0100, Lorenzo Stoakes wrote:
> There are peculiarities within the kernel where what is very clearly mm
> code is performed elsewhere arbitrarily.
> 
> This violates separation of concerns and makes it harder to refactor code
> to make changes to how fundamental initialisation and operation of mm logic
> is performed.
> 
> One such case is the creation of the VMA containing the initial stack upon
> execve()'ing a new process. This is currently performed in __bprm_mm_init()
> in fs/exec.c.
> 
> Abstract this operation to create_init_stack_vma(). This allows us to limit
> use of vma allocation and free code to fork and mm only.
> 
> We previously did the same for the step at which we relocate the initial
> stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> establishment too.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/exec.c          | 51 +---------------------------------

I'm kind of on the fence about this. On the one hand, yes, it's all vma
goo, and should live with the rest of vma code, as you suggest. On the
other had, exec is the only consumer of this behavior, and moving it
out of fs/exec.c means that changes to the code that specifically only
impacts exec are now in a separate file, and will no longer get exec
maintainer/reviewer CCs (based on MAINTAINERS file matching). Exec is
notoriously fragile, so I'm kind of generally paranoid about changes to
its behaviors going unnoticed.

In defense of moving it, yes, this routine has gotten updates over the
many years, but it's relatively stable. But at least one thing has gone in
without exec maintainer review recently (I would have Acked it, but the
point is review): 9e567ca45f ("mm/ksm: fix ksm exec support for prctl")
Everything else was before I took on the role officially (Nov 2022).

So I guess I'm asking, how do we make sure stuff pulled out of exec
still gets exec maintainer review?

> [...]
>  static int __bprm_mm_init(struct linux_binprm *bprm)
>  {
> -	int err;
> [...]
> -	return err;
> +	return create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
>  }

I'd prefer __bprm_mm_init() go away if it's just a 1:1 wrapper now.
However, it doesn't really look like it makes too much sense for the NOMMU
logic get moved as well, since it explicitly depends on exec-specific
values (MAX_ARG_PAGES), so perhaps something like this:

diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..313dc70e0012 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -382,9 +382,13 @@ static int bprm_mm_init(struct linux_binprm *bprm)
 	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
 	task_unlock(current->group_leader);
 
-	err = __bprm_mm_init(bprm);
+#ifndef CONFIG_MMU
+	bprm->p = PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *);
+#else
+	err = create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
 	if (err)
 		goto err;
+#endif
 
 	return 0;
 


On a related note, I'd like to point out that my claim that exec is
the only consumer here, is slightly a lie. Technically this is correct,
but only because this is specifically setting up the _stack_.

The rest of the VMA setup actually surrounds this code (another
reason I remain unhappy about moving it). Specifically the mm_alloc()
before __bprm_mm_init (which is reached through alloc_brpm()). And
then, following alloc_bprm() in do_execveat_common(), is the call to
setup_new_exec(), which does the rest of the VMA setup, specifically
arch_pick_mmap_layout() and related fiddling.

The "create userspace VMA" logic, mostly through mm_alloc(), is
used in a few places (e.g. text poking), but the "bring up a _usable_
userspace VMA" logic (i.e. one also with functional mmap) is repeated in
lib/kunit/alloc_user.c for allowing testing of code that touches userspace
(see kunit_attach_mm() and the kunit_vm_mmap() users). (But these tests
don't actually run userspace code, so no stack is set up.)

I guess what I'm trying to say is that I think we need a more clearly
defined "create usable userspace VMA" API, as we've got at least 3
scattered approaches right now: exec ("everything"), non-mmap-non-stack
users (text poking, et al), and mmap-but-not-stack users (kunit tests).

And the One True User of a full userspace VMA, exec, has the full setup
scattered into several phases, mostly due to needing to separate those
phases because it needs to progressively gather the information needed
to correctly configure each piece:
- set up userspace VMA at all (mm_alloc)
- set up a stack because exec args need to go somewhere (__bprm_mm_init)
- move stack to the right place (depends on executable binary and task bits)
- set up mmap (arch_pick_mmap_layout) to actually load executable binary
  (depends on arch, binary, and task bits)

Hopefully this all explains why I'm uncomfortable to see __bprm_mm_init
get relocated. It'll _probably_ be fine, but I get antsy about changes
to code that only exec uses...

-- 
Kees Cook

