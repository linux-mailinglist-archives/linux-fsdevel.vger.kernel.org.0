Return-Path: <linux-fsdevel+bounces-25185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725F949984
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D241328744B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E416D33A;
	Tue,  6 Aug 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKfU3VmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9C158DD0;
	Tue,  6 Aug 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977247; cv=none; b=TekA1eQBtPC1UYxt6PFNKkBN/V/rwERTeu3WR6mSxswvZqLG7yLSSMLsuNUnU1MMnQqT/roflIB9Dc7v7cMcLZ6GdZ/Dt/yCoBb05MKoo6lsOQoI/UsVA7JhRuMIz4hHmLSK+gFo0MuyhQLhxEv8qHGwAe7Z+AL0ujMNBOm8hIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977247; c=relaxed/simple;
	bh=5VHfHgI0zPzOlQEu8RbtaZqA7/yYGLgbqOof8O+0r7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU2PXyhHlzkJRMVem0RioP+H8cHjxyYcokZacgkSWF7Tv3W4fad7FwEOT5cebHJKnGzmYXGSdDyGVNx99b+SXsYjC+4ZkCZ6lU49jXJpUxj94eAottNxKD7DjBQtw4ZeGY+L5kL6e1IXnN1UCelCjqXhf1v3orob/gnGS0DKhTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKfU3VmB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722977246; x=1754513246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5VHfHgI0zPzOlQEu8RbtaZqA7/yYGLgbqOof8O+0r7M=;
  b=RKfU3VmBgvFUBdCYKC69adsCHFQkXkLqEtJvqdScYOmMQa6sngCLCTa5
   7ooBhTsajiliKDIqcs50LkRbMnVQJcLR5cmMMFDKVsWVOpe+Ln1mprdF/
   v3dGGCKYnnjkUHvObTfDYTvtxEWzTIuzurXlO+NP46KWEUJGD18XKU0xY
   fHGgCmJ933DnzfaauUK4dHua+IJI/okcwdfRFbReU6pA/1OTuzqmJjBdq
   8WqgmLSPzNovUR2dMw6o2zjaX18ZxYnsnBQaMh8bUvMQ5ZY0Cz83q6JjV
   W//4FR1RXQW902lTU2ztLgSAI++5p8agGHTaaVgBMAaRJnEN7p/H9g6hZ
   A==;
X-CSE-ConnectionGUID: I2gr/0nrQkO7yB6AHlz0ag==
X-CSE-MsgGUID: 70D+hjn0RqSt8FbI4WzMoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20990323"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="20990323"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 13:47:25 -0700
X-CSE-ConnectionGUID: yy9kQiL4T+6VBtV2FjBTtA==
X-CSE-MsgGUID: 71brb65iTxmbHsAa5Cf2mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57185326"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 13:47:25 -0700
Date: Tue, 6 Aug 2024 13:47:23 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <ZrKL2youCTmO3K0Q@tassilo>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
 <87ikwdtqiy.fsf@linux.intel.com>
 <44862ec7c85cdc19529e26f47176d0ecfc90d888.camel@kernel.org>
 <CAGudoHGZVBw3h_pHDaaSMeDgf3q_qn4wmkfOoG6y-CKN9sZLVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGZVBw3h_pHDaaSMeDgf3q_qn4wmkfOoG6y-CKN9sZLVQ@mail.gmail.com>

> Before I get to the vfs layer, there is a significant loss in the
> memory allocator because of memcg -- it takes several irq off/on trips
> for every alloc (needed to grab struct file *). I have a plan what to
> do with it (handle stuff with local cmpxchg (note no lock prefix)),
> which I'm trying to get around to. Apart from that you may note the
> allocator fast path performs a 16-byte cmpxchg, which is again dog
> slow and executes twice (once for the file obj, another time for the
> namei buffer). Someone(tm) should patch it up and I have some vague
> ideas, but 0 idea when I can take a serious stab.

I just LBR sampled it on my skylake and it doesn't look
particularly slow. You see the whole massive block including CMPXCHG16 
gets IPC 2.7, which is rather good. If you see lots of cycles on it it's likely
a missing cache line.

    kmem_cache_free:
        ffffffff9944ce20                        nop %edi, %edx
        ffffffff9944ce24                        nopl  %eax, (%rax,%rax,1)
        ffffffff9944ce29                        pushq  %rbp
        ffffffff9944ce2a                        mov %rdi, %rdx
        ffffffff9944ce2d                        mov %rsp, %rbp
        ffffffff9944ce30                        pushq  %r15
        ffffffff9944ce32                        pushq  %r14
        ffffffff9944ce34                        pushq  %r13
        ffffffff9944ce36                        pushq  %r12
        ffffffff9944ce38                        mov $0x80000000, %r12d
        ffffffff9944ce3e                        pushq  %rbx
        ffffffff9944ce3f                        mov %rsi, %rbx
        ffffffff9944ce42                        and $0xfffffffffffffff0, %rsp
        ffffffff9944ce46                        sub $0x10, %rsp
        ffffffff9944ce4a                        movq  %gs:0x28, %rax
        ffffffff9944ce53                        movq  %rax, 0x8(%rsp)
        ffffffff9944ce58                        xor %eax, %eax
        ffffffff9944ce5a                        add %rsi, %r12
        ffffffff9944ce5d                        jb 0xffffffff9944d1ea
        ffffffff9944ce63                        mov $0xffffffff80000000, %rax
        ffffffff9944ce6a                        xor %r13d, %r13d
        ffffffff9944ce6d                        subq  0x17b068c(%rip), %rax
        ffffffff9944ce74                        add %r12, %rax
        ffffffff9944ce77                        shr $0xc, %rax
        ffffffff9944ce7b                        shl $0x6, %rax
        ffffffff9944ce7f                        addq  0x17b066a(%rip), %rax
        ffffffff9944ce86                        movq  0x8(%rax), %rcx
        ffffffff9944ce8a                        test $0x1, %cl
        ffffffff9944ce8d                        jnz 0xffffffff9944d15c
        ffffffff9944ce93                        nopl  %eax, (%rax,%rax,1)
        ffffffff9944ce98                        movq  (%rax), %rcx
        ffffffff9944ce9b                        and $0x8, %ch
        ffffffff9944ce9e                        jz 0xffffffff9944cfea
        ffffffff9944cea4                        test %rax, %rax
        ffffffff9944cea7                        jz 0xffffffff9944cfea
        ffffffff9944cead                        movq  0x8(%rax), %r14
        ffffffff9944ceb1                        test %r14, %r14
        ffffffff9944ceb4                        jz 0xffffffff9944cfac
        ffffffff9944ceba                        cmp %r14, %rdx
        ffffffff9944cebd                        jnz 0xffffffff9944d165
        ffffffff9944cec3                        test %r14, %r14
        ffffffff9944cec6                        jz 0xffffffff9944cfac
        ffffffff9944cecc                        movq  0x8(%rbp), %r15
        ffffffff9944ced0                        nopl  %eax, (%rax,%rax,1)
        ffffffff9944ced5                        movq  0x1fe5134(%rip), %rax
        ffffffff9944cedc                        test %r13, %r13
        ffffffff9944cedf                        jnz 0xffffffff9944ceef
        ffffffff9944cee1                        mov $0xffffffff80000000, %rax
        ffffffff9944cee8                        subq  0x17b0611(%rip), %rax
        ffffffff9944ceef                        add %rax, %r12
        ffffffff9944cef2                        shr $0xc, %r12
        ffffffff9944cef6                        shl $0x6, %r12
        ffffffff9944cefa                        addq  0x17b05ef(%rip), %r12
        ffffffff9944cf01                        movq  0x8(%r12), %rax
        ffffffff9944cf06                        mov %r12, %r13
        ffffffff9944cf09                        test $0x1, %al
        ffffffff9944cf0b                        jnz 0xffffffff9944d1b1
        ffffffff9944cf11                        nopl  %eax, (%rax,%rax,1)
        ffffffff9944cf16                        movq  (%r13), %rax
        ffffffff9944cf1a                        movq  %rbx, (%rsp)
        ffffffff9944cf1e                        test $0x8, %ah
        ffffffff9944cf21                        mov $0x0, %eax
        ffffffff9944cf26                        cmovz %rax, %r13
        ffffffff9944cf2a                        data16 nop
        ffffffff9944cf2c                        movq  0x38(%r13), %r8
        ffffffff9944cf30                        cmp $0x3, %r8
        ffffffff9944cf34                        jnbe 0xffffffff9944d1ca
        ffffffff9944cf3a                        nopl  %eax, (%rax,%rax,1)
        ffffffff9944cf3f                        movq  0x23d6f72(%rip), %rax
        ffffffff9944cf46                        mov %rbx, %rdx
        ffffffff9944cf49                        sub %rax, %rdx
        ffffffff9944cf4c                        cmp $0x1fffff, %rdx
        ffffffff9944cf53                        jbe 0xffffffff9944d03a
        ffffffff9944cf59                        movq  (%r14), %rax
        ffffffff9944cf5c                        addq  %gs:0x66bccab4(%rip), %rax
        ffffffff9944cf64                        movq  0x8(%rax), %rdx
        ffffffff9944cf68                        cmpq  %r13, 0x10(%rax)
        ffffffff9944cf6c                        jnz 0xffffffff9944d192
        ffffffff9944cf72                        movl  0x28(%r14), %ecx
        ffffffff9944cf76                        movq  (%rax), %rax
        ffffffff9944cf79                        add %rbx, %rcx
        ffffffff9944cf7c                        cmp %rbx, %rax
        ffffffff9944cf7f                        jz 0xffffffff9944d1ba
        ffffffff9944cf85                        movq  0xb8(%r14), %rsi
        ffffffff9944cf8c                        mov %rcx, %rdi
        ffffffff9944cf8f                        bswap %rdi
        ffffffff9944cf92                        xor %rax, %rsi
        ffffffff9944cf95                        xor %rdi, %rsi
        ffffffff9944cf98                        movq  %rsi, (%rcx)
        ffffffff9944cf9b                        leaq  0x2000(%rdx), %rcx
        ffffffff9944cfa2                        movq  (%r14), %rsi
        ffffffff9944cfa5                        cmpxchg16bx  %gs:(%rsi)
        ffffffff9944cfaa                        jnz 0xffffffff9944cf59
        ffffffff9944cfac                        movq  0x8(%rsp), %rax
        ffffffff9944cfb1                        subq  %gs:0x28, %rax
        ffffffff9944cfba                        jnz 0xffffffff9944d1fc
        ffffffff9944cfc0                        leaq  -0x28(%rbp), %rsp
        ffffffff9944cfc4                        popq  %rbx
        ffffffff9944cfc5                        popq  %r12
        ffffffff9944cfc7                        popq  %r13
        ffffffff9944cfc9                        popq  %r14
        ffffffff9944cfcb                        popq  %r15
        ffffffff9944cfcd                        popq  %rbp
        ffffffff9944cfce                        retq                            # PRED 38 cycles [126] 2.74 IPC    <-------------

