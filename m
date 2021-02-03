Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C279730D9A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhBCMQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:43316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234322AbhBCMQw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:16:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612354564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWryIVYU+uhWQij5Zedr+mthwADlpM4pzIqLbc2PJTE=;
        b=ZO1FDrig5tnUD0sD709rRk12j9b+f6/535vnUH3W+CDbRbO/2c6Kc8pifEUT1BMziNVfXa
        CPTfjc6g/FfslyAYggad3k3ARdbimmNlG06TOX0F6IyHHo/BNMtx/NehxH/OCa8d7HxX5C
        VpPnKpOaRmZ4e14jLHdyuC1KXNF7S80=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0430B17A;
        Wed,  3 Feb 2021 12:16:03 +0000 (UTC)
Date:   Wed, 3 Feb 2021 13:15:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <YBqT/nwFpfP2EyeJ@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-7-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121122723.3446-7-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-01-21 14:27:18, Mike Rapoport wrote:
> +static struct file *secretmem_file_create(unsigned long flags)
> +{
> +	struct file *file = ERR_PTR(-ENOMEM);
> +	struct secretmem_ctx *ctx;
> +	struct inode *inode;
> +
> +	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		goto err_free_inode;
> +
> +	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> +				 O_RDWR, &secretmem_fops);
> +	if (IS_ERR(file))
> +		goto err_free_ctx;
> +
> +	mapping_set_unevictable(inode->i_mapping);

Btw. you need also mapping_set_gfp_mask(mapping, GFP_HIGHUSER) because
the default is GFP_HIGHUSER_MOVABLE and you do not support migration so
no pages from movable zones should be allowed.

-- 
Michal Hocko
SUSE Labs
