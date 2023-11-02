Return-Path: <linux-fsdevel+bounces-1860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D57DF795
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E2281B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F71DDD6;
	Thu,  2 Nov 2023 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciKD3Sqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D11DA29;
	Thu,  2 Nov 2023 16:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBABC433C8;
	Thu,  2 Nov 2023 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698942279;
	bh=1oyVMjQI7OXHCUtZSgK71uJyeSsja11PK2zu0Sgh3ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciKD3SqqJbMFjIcI6bCCYkwFV34fiO2ArRgF5fXcYKuOaGXb4Wyi9zozkY1GPacll
	 Wb4+rsmrOAiUFpUvVmXoDHyclytLXtYqrhZkU0PpNpIyYDeZGFKHZDDWtqHWW99OuO
	 qo3jhEw/diJ1a/cjqpth3wyK9LJTK2A2KbT6VwEC/UhcdzfCTDR5j8l+p9MS2DAQxb
	 LzKQyThoycm/wTmhlnVYtsizofoKOqeGHL2Li2UrkzPUXr3zUUph4Dx0xK0JakNnV7
	 d57GUWFGv9wIfjooWNbwoPxilLaGhd+yLjY93dOc3Y/tHVaznNMcGB6moDDpowdxsF
	 zbisHCIeWrzQg==
Date: Thu, 2 Nov 2023 17:24:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v13 15/35] fs: Export anon_inode_getfile_secure() for use
 by KVM
Message-ID: <20231102-freihalten-vorsah-fdd68051b005@brauner>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-16-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027182217.3615211-16-seanjc@google.com>

On Fri, Oct 27, 2023 at 11:21:57AM -0700, Sean Christopherson wrote:
> Export anon_inode_getfile_secure() so that it can be used by KVM to create
> and manage file-based guest memory without need a fullblow filesystem.
> The "standard" anon_inode_getfd() doesn't work for KVM's use case as KVM
> needs a unique inode for each file, e.g. to be able to independently
> manage the size and lifecycle of a given file.
> 
> Note, KVM doesn't need a "secure" version, just unique inodes, i.e. ignore
> the name.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Before we enshrine this misleading name let's rename this to:

create_anon_inode_getfile()

I don't claim it's a great name but it's better than *_secure() which is
very confusing. So just:

struct file *create_anon_inode_getfile(const char *name,
                                       const struct file_operations *fops,
                                       void *priv, int flags)

May also just remove that context_inode argument from the exported
function. The only other caller is io_uring. And neither it nor this
patchset need the context_inode thing afaict. Merge conflict risk is
extremely low so carrying that as part of this patchset is fine and
shouldn't cause huge issues for you.

