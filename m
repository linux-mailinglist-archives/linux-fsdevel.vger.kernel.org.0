Return-Path: <linux-fsdevel+bounces-50663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15AACE394
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23293A9FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B11FBEB6;
	Wed,  4 Jun 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqT+LeMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD401DF748;
	Wed,  4 Jun 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057761; cv=none; b=HZqXYSH58feFkHvDlunyjznytakfwjwUC6lMLkRUW4qGG8HH4o+sp1ylbWmbBWYe9XzBwraYYAgkHrInCbxkKxe/mZv4Sa5PvYCPp5GYUknZSlLzhZNZmkYutxAXMbMRECV2xkYvfyDNZTF9eztaO1o0uc+c4Ahs98OoXM4dLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057761; c=relaxed/simple;
	bh=ZlRUFj0GYPcvTtwRaPSKjGOIbkYz5m5DUWyk7cUFG8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8LUeuKXAJxILjC7Vks2QHHZcd9R0hnnmqda1iES9zh5tisF9CZ389H0te5t6o771iAa6Viy42t4MVqwGozc8eJHasJooTx2arwz2XhBatrT9ghinS+GxfFLblSzyC/yULEOPKH/AVjGE/cukIsYHzkFqM4y+gBrlZ+T8C9qdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqT+LeMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9778AC4CEE4;
	Wed,  4 Jun 2025 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749057760;
	bh=ZlRUFj0GYPcvTtwRaPSKjGOIbkYz5m5DUWyk7cUFG8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqT+LeMTP3xW02EwM0DOgoJfU9/RmQzI0SMO5dHiEivtGwh038BiwoJsc0gzcQ+yy
	 CJy2cZ+gOg6LWh7e8kxQT0d/6WVjv9UcOH1A7bKTWIDAG3yPawGWRU6pXsthg7T7HG
	 giUWeUFeatGVAodEFpPDRMsmgCc2Nil50jfRjBDSXPKle+GJH6uo53WFdImnXiV1z8
	 qT9k0tN5Fpn47y39OdXAhYcc9SKzwkL5nuHSv8941JfVBURcHFu7r8ZqAtR6CeeeEr
	 /Z31SpOEA99dPcPMmO+DWs+NlybiQspRTpctORr5R7xfnB59FK2LnmC4NrWqMBslkV
	 Db/iGjvimN+NQ==
Date: Wed, 4 Jun 2025 19:22:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, m@maowtm.org
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250604-mitnahm-dreharbeiten-a13527b04b78@brauner>
References: <20250603065920.3404510-1-song@kernel.org>
 <20250603065920.3404510-4-song@kernel.org>
 <CAADnVQLjvJCFjTiWpsBmfbyH5i88oq7yxjvaf+Th7tQANouA_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLjvJCFjTiWpsBmfbyH5i88oq7yxjvaf+Th7tQANouA_Q@mail.gmail.com>

On Tue, Jun 03, 2025 at 08:13:18AM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 2, 2025 at 11:59 PM Song Liu <song@kernel.org> wrote:
> >
> > Introduce a path iterator, which reliably walk a struct path toward
> > the root. This path iterator is based on path_walk_parent. A fixed
> > zero'ed root is passed to path_walk_parent(). Therefore, unless the
> > user terminates it earlier, the iterator will terminate at the real
> > root.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  kernel/bpf/Makefile    |  1 +
> >  kernel/bpf/helpers.c   |  3 +++
> >  kernel/bpf/path_iter.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c  |  5 ++++
> >  4 files changed, 67 insertions(+)
> >  create mode 100644 kernel/bpf/path_iter.c
> >
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 3a335c50e6e3..454a650d934e 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
> >  ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> >  obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
> >  endif
> > +obj-$(CONFIG_BPF_SYSCALL) += path_iter.o
> >
> >  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b71e428ad936..b190c78e40f6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3397,6 +3397,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
> >  BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
> >  #endif
> >  BTF_ID_FLAGS(func, __bpf_trap)
> > +BTF_ID_FLAGS(func, bpf_iter_path_new, KF_ITER_NEW | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_path_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_path_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
> >  BTF_KFUNCS_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set = {
> > diff --git a/kernel/bpf/path_iter.c b/kernel/bpf/path_iter.c
> > new file mode 100644
> > index 000000000000..0d972ec84beb
> > --- /dev/null
> > +++ b/kernel/bpf/path_iter.c
> 
> I think Christian's preference was to keep
> everything in fs/bpf_fs_kfuncs.c

Yes. And since that also adds new fs helpers I want to take that through
the VFS tree, please. I'll provide a stable branch as we do with all
other subsystems.

