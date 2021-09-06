Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0F64018EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbhIFJgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 05:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241112AbhIFJgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630920905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bI+QSMrpQxc8wh/CBiWru2XSKk75+RIIlvQnbtIvrtU=;
        b=iqoy3lR7WJaEGBnFJJ8C6zCCm6C6fRiaYd4r3N7uuFfe7sH1RFA970yLvsvtPxg0RlnTgB
        YbzL7Hxmo/btKR46ZAnqmIopYTmr2tuyn3G9sEEg8qGNceBo75nTmy5CrIm2KTfDBKkKrM
        qgA10UOVB4inSP/Q13epFQrgJP4VO/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ZItAtwVeP-6kutDtSR4BDw-1; Mon, 06 Sep 2021 05:35:04 -0400
X-MC-Unique: ZItAtwVeP-6kutDtSR4BDw-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so3670423wmj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 02:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bI+QSMrpQxc8wh/CBiWru2XSKk75+RIIlvQnbtIvrtU=;
        b=aDHI601nmJ1uIFTLuVyaqlr6IQwoatKWdA4sZNZ3/vt9y7AX7CYiVvhdNgOC4uzFmg
         nrIRvgxh3DRDng9JnZSeJBneGxgK9HecZeelNggtTJiLU5fwM8kpkcFNv2/B4kDsd1cj
         sWzPAp6WnVKtvOl499LkKmqo/7J2aCosYbMf96MUdeiTGZtPzBNR4jCr24ZyfYu9fGAz
         BpELVXut+knMMRVWhV4G4wCW9bkfs12oqqwH2YTiooFCMq/CcUeYNo6kDqwONUTakHlI
         msTl8nRYkebg+mUF69xxgfWNpFAJqxIQc5BL6aUTLymIQb1PZ1lzBy8MDL3CP+Oi90bM
         M1Tw==
X-Gm-Message-State: AOAM5326SRHu8Zqd4lE1VnsIs3K5XATepjxDZ0QIx+YOZdnff80dOuwy
        K13yEGQN4bxkzz/qfXhnG5j2QAG/RPEHOr7fwZiC8OiGr7NVCERoLhuly0S5dTE+fM3w+ynEIRt
        m8WE+T0ymbXhDPSj71K4xGSu9vg==
X-Received: by 2002:adf:c144:: with SMTP id w4mr12400061wre.398.1630920903356;
        Mon, 06 Sep 2021 02:35:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbjWLL9Dg2dcCjoGBqscLyTJKrOzkY3j2f7fPQOprJwdMQPtB17RuwCmXe2g/aYqEVItyxtw==
X-Received: by 2002:adf:c144:: with SMTP id w4mr12400028wre.398.1630920903077;
        Mon, 06 Sep 2021 02:35:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id i4sm7804373wmd.5.2021.09.06.02.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 02:35:02 -0700 (PDT)
Subject: Re: [RFC PATCH] fs/exec: Add the support for ELF program's NUMA
 replication
To:     Huang Shijie <shijie@os.amperecomputing.com>,
        viro@zeniv.linux.org.uk
Cc:     akpm@linux-foundation.org, jlayton@kernel.org,
        bfields@fieldses.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, song.bao.hua@hisilicon.com,
        patches@amperecomputing.com, zwang@amperecomputing.com
References: <20210906161613.4249-1-shijie@os.amperecomputing.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2cb841ca-2a04-f088-cee2-6c020ecc9508@redhat.com>
Date:   Mon, 6 Sep 2021 11:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210906161613.4249-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.09.21 18:16, Huang Shijie wrote:
> This patch adds AT_NUMA_REPLICATION for execveat().
> 
> If this flag is set, the kernel will trigger COW(copy on write)
> on the mmapped ELF binary. So the program will have a copied-page
> on its NUMA node, even if the original page in page cache is
> on other NUMA nodes.

Am I missing something important or is this just absolutely not what we 
want?

This means that for each and every invocation of the binary, we'll COW 
the complete binary -- an awful lot of wasted main memory and swap.

This is not a NUMA replication, this is en executable ELF code replication.

> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>   fs/binfmt_elf.c            | 27 ++++++++++++++++++++++-----
>   fs/exec.c                  |  5 ++++-
>   include/linux/binfmts.h    |  1 +
>   include/linux/mm.h         |  2 ++
>   include/uapi/linux/fcntl.h |  2 ++
>   mm/mprotect.c              |  2 +-
>   6 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 439ed81e755a..fac8f4a4555a 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -362,13 +362,14 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>   
>   static unsigned long elf_map(struct file *filep, unsigned long addr,
>   		const struct elf_phdr *eppnt, int prot, int type,
> -		unsigned long total_size)
> +		unsigned long total_size, int numa_replication)
>   {
>   	unsigned long map_addr;
>   	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
>   	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
>   	addr = ELF_PAGESTART(addr);
>   	size = ELF_PAGEALIGN(size);
> +	int ret;
>   
>   	/* mmap() will return -EINVAL if given a zero size, but a
>   	 * segment with zero filesize is perfectly valid */
> @@ -385,11 +386,26 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>   	*/
>   	if (total_size) {
>   		total_size = ELF_PAGEALIGN(total_size);
> -		map_addr = vm_mmap(filep, addr, total_size, prot, type, off);
> +
> +		if (numa_replication) {
> +			/* Trigger the COW for this ELF code section */
> +			map_addr = vm_mmap(filep, addr, total_size, prot | PROT_WRITE,
> +						type | MAP_POPULATE, off);
> +			if (!IS_ERR_VALUE(map_addr) && !(prot & PROT_WRITE)) {
> +				/* Change back */
> +				ret = do_mprotect_pkey(map_addr, total_size, prot, -1);
> +				if (ret)
> +					return ret;
> +			}
> +		} else {
> +			map_addr = vm_mmap(filep, addr, total_size, prot, type, off);
> +		}
> +
>   		if (!BAD_ADDR(map_addr))
>   			vm_munmap(map_addr+size, total_size-size);
> -	} else
> +	} else {
>   		map_addr = vm_mmap(filep, addr, size, prot, type, off);
> +	}
>   
>   	if ((type & MAP_FIXED_NOREPLACE) &&
>   	    PTR_ERR((void *)map_addr) == -EEXIST)
> @@ -635,7 +651,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>   				load_addr = -vaddr;
>   
>   			map_addr = elf_map(interpreter, load_addr + vaddr,
> -					eppnt, elf_prot, elf_type, total_size);
> +					eppnt, elf_prot, elf_type, total_size, 0);
>   			total_size = 0;
>   			error = map_addr;
>   			if (BAD_ADDR(map_addr))
> @@ -1139,7 +1155,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>   		}
>   
>   		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
> -				elf_prot, elf_flags, total_size);
> +				elf_prot, elf_flags, total_size,
> +				bprm->support_numa_replication);
>   		if (BAD_ADDR(error)) {
>   			retval = IS_ERR((void *)error) ?
>   				PTR_ERR((void*)error) : -EINVAL;
> diff --git a/fs/exec.c b/fs/exec.c
> index 38f63451b928..d27efa540641 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -900,7 +900,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>   		.lookup_flags = LOOKUP_FOLLOW,
>   	};
>   
> -	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_NUMA_REPLICATION)) != 0)
>   		return ERR_PTR(-EINVAL);
>   	if (flags & AT_SYMLINK_NOFOLLOW)
>   		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
> @@ -1828,6 +1828,9 @@ static int bprm_execve(struct linux_binprm *bprm,
>   	if (retval)
>   		goto out;
>   
> +	/* Do we support NUMA replication for this program? */
> +	bprm->support_numa_replication = flags & AT_NUMA_REPLICATION;
> +
>   	retval = exec_binprm(bprm);
>   	if (retval < 0)
>   		goto out;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 049cf9421d83..1874e1732f20 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -64,6 +64,7 @@ struct linux_binprm {
>   	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
>   
>   	char buf[BINPRM_BUF_SIZE];
> +	int support_numa_replication;
>   } __randomize_layout;
>   
>   #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7ca22e6e694a..76611381be2a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3244,6 +3244,8 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
>   #endif
>   
>   extern int sysctl_nr_trim_pages;
> +int do_mprotect_pkey(unsigned long start, size_t len,
> +			unsigned long prot, int pkey);
>   
>   #ifdef CONFIG_PRINTK
>   void mem_dump_obj(void *object);
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 2f86b2ad6d7e..de99c5ae8eca 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -111,4 +111,6 @@
>   
>   #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
>   
> +#define AT_NUMA_REPLICATION	0x10000	/* Support NUMA replication for the ELF program */
> +
>   #endif /* _UAPI_LINUX_FCNTL_H */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 883e2cc85cad..d1f8cececfed 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -519,7 +519,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>   /*
>    * pkey==-1 when doing a legacy mprotect()
>    */
> -static int do_mprotect_pkey(unsigned long start, size_t len,
> +int do_mprotect_pkey(unsigned long start, size_t len,
>   		unsigned long prot, int pkey)
>   {
>   	unsigned long nstart, end, tmp, reqprot;
> 


-- 
Thanks,

David / dhildenb

