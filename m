Return-Path: <linux-fsdevel+bounces-16127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF3898CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B789B272B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9312BF22;
	Thu,  4 Apr 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VE+TMXT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2474129E8A
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249892; cv=none; b=IolHL/Hku+Lv+tuwnEXM3eV1sb9LzpW6acLpNdL4xHtq9tHuPJDCaC//TBogOpdXRtxpyGPCnuZMyUFl3WU2G/bRn/Pl5RKMUzrNEs7Ng+QDaSj2Lx80U0A54Q4q+pxf2HwabSqck7JpMSmGAoOrq/rlToUbcwHbWvd8nG0eFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249892; c=relaxed/simple;
	bh=Ug3wNn9rUYSiApUWsdmJAfxaH7gkdUjC0d0zsQR/y4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDNxJe0pvwkjfIUAMgWWkhwlMCAPxGFiReggudSdf1sfN/F50atTXj/HV/D7eB2+nVbFbuPgWKlmMlOuUhNMS8OLVavoemiWXXCssguC7h1rwPe9A62fleIDdNosZW0Q7zQT6cJP+59tZQPi+5Xat0LmugoNAxRNp6Yw9vhzeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VE+TMXT1; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so1227882276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712249890; x=1712854690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnNkrv9amLNSOChMZU1xiNRngWLHsWRGHJdyDWSVIjQ=;
        b=VE+TMXT19IlGsNP/1GZ4QkeACDqlNHhbUWPxK9JAFxupGgfIy3o9CUYHwC3zIILeE/
         dw0le8WSHyjn/yq30nG7WGIBs+X6a9VPfx1czXi3gORFjnFlex63/z9NmeK+P7uf4FiD
         RHJKVnZ48GhO6Q4rq8jgk0qaybB9hdHz4S+E0g6+tSZchhycJvFOpbl7D2UtYx1SXGvj
         gepwgqcJ7Jg/qqAYl7LvxwqsD5gHQVzcaToe3QQoSJR+sUbcEAX8lpWLwVUPvWrUQ6mm
         MWXNXICHXg6DmfFEa3hCb/McRPKDAOzCAeHvys1ChiPt0IZ9j9LrXVHefmOmwHrmBH7X
         jS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249890; x=1712854690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnNkrv9amLNSOChMZU1xiNRngWLHsWRGHJdyDWSVIjQ=;
        b=TMpS/QwQIhMA2ZmK/5woI6jvC+QQ0dJZPdZz4VCHMP+siQgNJJppewX/BdzMTu9JVe
         ZveQX1J3GwMc9mas3FR+U4NxDKYvtoaE+w/7hL6bh+AM2X8JiZrpiVZMVPimCvKUiief
         /iNhZEgsr2TprBtp7gexE9YeuXzJ+HxF/sgqldKNZqj3pDE3t4UtYx1ewZEbS6GgmPUJ
         x//fUMy/Jd6/icbfykQxqJnRyt/lPrMj4BU75mBVUB3+2+vfDPYaGNg2v5gabZJxGnf0
         QdY6SNOETmqvmp6YLWQhJNRrd7Lfy8hjDIONDYxutPS5nQ3fv1lpYc3fhRIqAARph0Ql
         9+kw==
X-Forwarded-Encrypted: i=1; AJvYcCUSa5HjMgYtY9w0iUWD5A2sArF1h7g9XGuoECih45zpKWVG2F5czkA8jeyXZwYisTBUtTdAo7ri7pwi9UbigVSl0gfVJc2lI/jZG8opIw==
X-Gm-Message-State: AOJu0YzpIU3uiid1ownv8Q+0PvWgtnBSxDutTuCqmfuDtJmq+KYufAaO
	yTeZ293DPMrc5fNoyHvz4CEPkrhasUG/EmIwCOmSMLx/d9E81rb1++sHEUxVEhIjmC3YIN9pLxS
	3+gC91zfV2Vds5Ss/u9JNRdREFHXOQGfDrfMe
X-Google-Smtp-Source: AGHT+IF7B3akhgfxRrnqjce/FXowsw1E3eakccZbE6M28J8HXpTOkV5OPQcXw5mCpvOPKhYETIzOkOwrlUerT+o2JDc=
X-Received: by 2002:a5b:481:0:b0:dcc:9d30:58a0 with SMTP id
 n1-20020a5b0481000000b00dcc9d3058a0mr2683124ybp.64.1712249889460; Thu, 04 Apr
 2024 09:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-6-surenb@google.com>
 <20240321133147.6d05af5744f9d4da88234fb4@linux-foundation.org>
 <gnqztvimdnvz2hcepdh3o3dpg4cmvlkug4sl7ns5vd4lm7hmao@dpstjnacdubq>
 <20240321150908.48283ba55a6c786dee273ec3@linux-foundation.org>
 <bliyhrwtskv5xhg3rxxszouxntrhnm3nxhcmrmdwwk4iyx5wdo@vodd22dbtn75> <CAJuCfpEO4NjYysJ7X8ME_GjHc41u-_dK4AhrhmaSMh_9mxaHSA@mail.gmail.com>
In-Reply-To: <CAJuCfpEO4NjYysJ7X8ME_GjHc41u-_dK4AhrhmaSMh_9mxaHSA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 09:57:55 -0700
Message-ID: <CAJuCfpEGJHs=ygb2_PNcqEy__dvhby5N7dvwnno=3pDEvE1+2g@mail.gmail.com>
Subject: Re: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:47=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Mar 21, 2024 at 3:17=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Mar 21, 2024 at 03:09:08PM -0700, Andrew Morton wrote:
> > > On Thu, 21 Mar 2024 17:15:39 -0400 Kent Overstreet <kent.overstreet@l=
inux.dev> wrote:
> > >
> > > > On Thu, Mar 21, 2024 at 01:31:47PM -0700, Andrew Morton wrote:
> > > > > On Thu, 21 Mar 2024 09:36:27 -0700 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > >
> > > > > > We're introducing alloc tagging, which tracks memory allocation=
s by
> > > > > > callsite. Converting alloc_inode_sb() to a macro means allocati=
ons will
> > > > > > be tracked by its caller, which is a bit more useful.
> > > > >
> > > > > I'd have thought that there would be many similar
> > > > > inlines-which-allocate-memory.  Such as, I dunno, jbd2_alloc_inod=
e().
> > > > > Do we have to go converting things to macros as people report
> > > > > misleading or less useful results, or is there some more general
> > > > > solution to this?
> > > >
> > > > No, this is just what we have to do.
> > >
> > > Well, this is something we strike in other contexts - kallsyms gives =
us
> > > an inlined function and it's rarely what we wanted.
> > >
> > > I think kallsyms has all the data which is needed to fix this - how
> > > hard can it be to figure out that a particular function address lies
> > > within an outer function?  I haven't looked...
> >
> > This is different, though - even if a function is inlined in multiple
> > places there's only going to be one instance of a static var defined
> > within that function.
>
> I guess one simple way to detect the majority of these helpers would
> be to filter all entries from /proc/allocinfo which originate from
> header files.
>
> ~# grep ".*\.h:." /proc/allocinfo
>       933888      228 include/linux/mm.h:2863 func:pagetable_alloc
>          848       53 include/linux/mm_types.h:1175 func:mm_alloc_cid
>            0        0 include/linux/bpfptr.h:70 func:kvmemdup_bpfptr
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
>            0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/bpf.h:2249 func:bpf_map_kvcalloc
>            0        0 include/linux/bpf.h:2243 func:bpf_map_kzalloc
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/ptr_ring.h:471
> func:__ptr_ring_init_queue_alloc
>            0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/net/tcx.h:80 func:tcx_entry_create
>            0        0 arch/x86/include/asm/pgalloc.h:156 func:p4d_alloc_o=
ne
>       487424      119 include/linux/mm.h:2863 func:pagetable_alloc
>            0        0 include/linux/mm.h:2863 func:pagetable_alloc
>          832       13 include/linux/jbd2.h:1607 func:jbd2_alloc_inode
>            0        0 include/linux/jbd2.h:1591 func:jbd2_alloc_handle
>            0        0 fs/nfs/iostat.h:51 func:nfs_alloc_iostats
>            0        0 include/net/netlabel.h:281 func:netlbl_secattr_cach=
e_alloc
>            0        0 include/net/netlabel.h:381 func:netlbl_secattr_allo=
c
>            0        0 include/crypto/internal/acompress.h:76
> func:__acomp_request_alloc
>         8064       84 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>         1016       74 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          384        4 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          704        3 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>           32        1 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>           64        1 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>           40        2 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>           32        1 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>        30000      625 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          512        1 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>          192        6 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          192        3 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>        61992      861 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtabl=
e_page
>            0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtabl=
e_page
>            0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtabl=
e_page
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/hid_bpf.h:154 func:call_hid_bpf_rdesc=
_fixup
>            0        0 include/linux/skbuff.h:3392 func:__dev_alloc_pages
>       114688       56 include/linux/ptr_ring.h:471
> func:__ptr_ring_init_queue_alloc
>            0        0 include/linux/skmsg.h:415 func:sk_psock_init_link
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/ptr_ring.h:628 func:ptr_ring_resize_m=
ultiple
>        24576        3 include/linux/ptr_ring.h:471
> func:__ptr_ring_init_queue_alloc
>            0        0 include/net/netlink.h:1896 func:nla_memdup
>            0        0 include/linux/sockptr.h:97 func:memdup_sockptr
>            0        0 include/net/request_sock.h:131 func:reqsk_alloc
>            0        0 include/net/tcp.h:2456 func:tcp_v4_save_options
>            0        0 include/net/tcp.h:2456 func:tcp_v4_save_options
>            0        0 include/crypto/hash.h:586 func:ahash_request_alloc
>            0        0 include/linux/sockptr.h:97 func:memdup_sockptr
>            0        0 include/linux/sockptr.h:97 func:memdup_sockptr
>            0        0 net/sunrpc/auth_gss/auth_gss_internal.h:38
> func:simple_get_netobj
>            0        0 include/crypto/hash.h:586 func:ahash_request_alloc
>            0        0 include/net/netlink.h:1896 func:nla_memdup
>            0        0 include/crypto/skcipher.h:869 func:skcipher_request=
_alloc
>            0        0 include/net/fq_impl.h:361 func:fq_init
>            0        0 include/net/netlabel.h:316 func:netlbl_catmap_alloc
>
> and it finds our example:
>
>          832       13 include/linux/jbd2.h:1607 func:jbd2_alloc_inode
>
> Interestingly the inlined functions which are called from multiple
> places will have multiple entries with the same file+line:
>
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>
> So, duplicate entries can be also used as an indication of an inlined all=
ocator.
> I'll go chase these down and will post a separate patch converting them.

I just posted https://lore.kernel.org/all/20240404165404.3805498-1-surenb@g=
oogle.com/
to report allocations done from the inlined functions in the headers
to their callers.

