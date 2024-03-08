Return-Path: <linux-fsdevel+bounces-13996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891AC876284
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59471C2121B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099D55C24;
	Fri,  8 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt/pTjjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAC54BF1;
	Fri,  8 Mar 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895504; cv=none; b=mWnHKM68XH8PRBMgw6eAibixyqRTv3PJzFiHlMrEZFnJQaxGH42LuFJT/cO98xrzN88Ng4+o7F5GasTjr816J0nCvsXuafcwa+55hNg2EBuptDzCBNBRADOOE4inIquShwMlw24LdyHIE7WC1GN0qQq4Td2t9F5MZYq9pvCQzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895504; c=relaxed/simple;
	bh=t+CUSuGz1oswbfA1pD8nv4aLnvXGsLe3pXT7Zvxm/o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ5EMU4ye5cTT6+6j2suwaeVLtgAPVjGYZHzY7gGL+boORyClNWJp+LwWYGaSGQ1TZw9YcnmEvZRvQC1Sv1UrDL3PP3QfTdF0auFXPcBIU6HjIjjyQq9+/E8tb+WrSDcIyyg4eYhUFPpbNnnDynf/ff7jPESfVVGXbqR8AzsPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt/pTjjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13062C433F1;
	Fri,  8 Mar 2024 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709895503;
	bh=t+CUSuGz1oswbfA1pD8nv4aLnvXGsLe3pXT7Zvxm/o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nt/pTjjQU4/t3Ui9AfP/dhesu6bAiD8W7/miIsLlhrZSjAlXV7WqES8euFVx1uQD4
	 +FUUlqnKwoS70h1rnQLHKUE5PWZ+QNxd8mwh+EVmb51Nxl5mdwTs3ZvCTDRHw8jOMl
	 iaRd79094+RZjPKhlT466/S49+7RXqxpvctoSDlLNMYYtrrXsl6uz5FMtdYa9Bp3BX
	 UcNjbhTiTDzuoqDuEjGKXGg1DPuGZytR/4O1Lb0+lT1rmW+WU2sKy0tAwUREzm4+L/
	 Ad52rwEl00CILgMst32JlQY5LS83uve/k+lHCaFiM0Iq8f5oVITi1qkEYvt4MumUcr
	 ItKmzldvPudgw==
Date: Fri, 8 Mar 2024 11:58:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240308-diese-kartbahn-7f87d054964b@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAHC9VhTbjzS88uU=7Pau7tzsYD+UW5=3TGw2qkqrA5a-GVunrQ@mail.gmail.com>
 <CAADnVQLQ8uVaSKx-zth1HTT44T3ZC8C1cyNxxuhPMqywGVV9Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLQ8uVaSKx-zth1HTT44T3ZC8C1cyNxxuhPMqywGVV9Pw@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:25:05PM -0800, Alexei Starovoitov wrote:
> On Thu, Mar 7, 2024 at 12:51 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Mar 7, 2024 at 4:55 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > There's one fundamental question here that we'll need an official answer to:
> > >
> > > Is it ok for an out-of-tree BPF LSM program, that nobody has ever seen
> > > to request access to various helpers in the kernel?
> >
> > Phrased in a slightly different way, and a bit more generalized: do we
> > treat out-of-tree BPF programs the same as we do with out-of-tree
> > kernel modules?  I believe that's the real question, and if we answer
> > that, we should also have our answer for the internal helper function
> > question.
> 
> From 10k ft view bpf programs may look like kernel modules,
> but looking closely they are very different.
> 
> Modules can read/write any data structure and can call any exported function.
> All modules fall into two categories GPL or not.
> While bpf progs are divided by program type.
> Tracing progs can read any kernel memory safely via probe_read_kernel.
> Networking prog can read/write packets, but cannot read kernel memory.
> bpf_lsm programs can be called from lsm hooks and
> call only kfuncs that were explicitly allowlisted to bpf_lsm prog type.
> Furthermore kfuncs have acquire/release semantics enforced by
> the verifier.
> For example, bpf progs can do bpf_rcu_read_lock() which is
> a wrapper around rcu_read_lock() and the verifier will make sure
> that bpf_rcu_read_unlock() is called.
> Under bpf_rcu_read_lock() bpf programs can dereference __rcu tagged
> fields and the verifier will track them as rcu protected objects
> until bpf_rcu_read_unlock().
> In other words the verifier is doing sparse-on-steroids analysis
> and enforcing it.
> Kernel modules are not subject to such enforcement.
> 
> One more distinction: 99.9% of bpf features require a GPL-ed bpf program.
> All kfuncs are GPL only.

While these are certainly all very nice properties it doesn't change the
core question.

An out of-tree BPF LSM program is requesting us to add nine vfs helpers
to the BPF kfunc api. That out-of-tree BPF LSM program is not even
accessible to the public. There is no meaningful difference to an
out-of-tree kernel module asking us to add nine functions to the export
api. The safety properties don't matter for this. Clearly, they didn't
prevent the previous bpf_d_path() stuff from happening.

We need rules for how this is supposed to be handled. Unless those rules
are clearly specified and make sense we shouldn't be adding BPF kfuncs
based on requests from out-of-tree BPF LSMs that amount to "we need
this".

