Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9957B30F26B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhBDLhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 06:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235541AbhBDLfa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:35:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B41964F45;
        Thu,  4 Feb 2021 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612438488;
        bh=kdvaYUzyR0twFNgrfjDXxc4xk/nIUc95siq77AcMxUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sy9fx25cRRyQxUg4PQiuwRqTEHX658JxHyGPHq/88My/x1kvTH4DAJ2aISoI2aXkQ
         7q4ImT49/hSnXgZZe5nIte5an8yCdFl3/nKBSmL1KtXUQmhK86d+bWvAKpFB/hCPJ+
         vHFmENUyT6t71Pv7oR0jOWL5QdCiNYnsM7hkVvYdNA83FthQ8MT6l5HSIaqDtEq017
         v3Uf42+f0Hl/atXgvQESI8GiyyIE+mqMxGUZE9ZuSWQ78rGF9JCQdy6unJPKAA/OZt
         AfPnD+C9cBVf98rjrYDltnlBiJ+vDveF6Nvs2anXspx7fDGAP1j2/zrNQYpSDiRu3a
         P3N5VPANbVUIA==
Date:   Thu, 4 Feb 2021 13:34:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 06/11] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210204113432.GS242749@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-7-rppt@kernel.org>
 <YBqT/nwFpfP2EyeJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBqT/nwFpfP2EyeJ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:15:58PM +0100, Michal Hocko wrote:
> On Thu 21-01-21 14:27:18, Mike Rapoport wrote:
> > +static struct file *secretmem_file_create(unsigned long flags)
> > +{
> > +	struct file *file = ERR_PTR(-ENOMEM);
> > +	struct secretmem_ctx *ctx;
> > +	struct inode *inode;
> > +
> > +	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> > +	if (IS_ERR(inode))
> > +		return ERR_CAST(inode);
> > +
> > +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		goto err_free_inode;
> > +
> > +	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> > +				 O_RDWR, &secretmem_fops);
> > +	if (IS_ERR(file))
> > +		goto err_free_ctx;
> > +
> > +	mapping_set_unevictable(inode->i_mapping);
> 
> Btw. you need also mapping_set_gfp_mask(mapping, GFP_HIGHUSER) because
> the default is GFP_HIGHUSER_MOVABLE and you do not support migration so
> no pages from movable zones should be allowed.

Ok.

-- 
Sincerely yours,
Mike.
