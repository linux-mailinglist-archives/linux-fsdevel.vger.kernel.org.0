Return-Path: <linux-fsdevel+bounces-75878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAeZDs6Ce2mvFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:54:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC60B1B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73782301BF63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E6289E13;
	Thu, 29 Jan 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUcgvYuB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933E2765D4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701949; cv=none; b=EgUGJGiwtR7TWrWN43euprfWUKJGOIrSCGGfNEQNPVcUliw/GV5GBiJk/XpwRw+0LSW70r7wZgbE/PQCMXexMf8qqchdaDpW2MaM9IWUUPjU8huST0s618CnbOQZZHOjBg9LPNFEFTAaqWKqxUr43/mwAlRdzDnqZGVz9aQnj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701949; c=relaxed/simple;
	bh=+cljR74+YHxr9XhlvIjmrKGCLMbaA24Gx/1RI3plWMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbTVJOF2YsoNkVotOp4b6o0LTa0v7HlsE0u0uBkzjkmM4LUBB5G2+s2GMG1Mqtv6e8rAtrMhoHyD5XJ3oXLpsDlwBEqkpa7MuVBWCZuCcnraKwEvIQsW6U+qUxlBPJk9qbSCiXT4VfOAC+I5yZhMM63Dc+hr2/Cgen/wUDsNgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUcgvYuB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769701935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YD8ilPD5aDY76ZjJ9PtsjkhZQAHsEKJcZjcp250rvJY=;
	b=nUcgvYuBZ0XgKTa8o6ECWNaf9HRaujboyfbqtMAhzg2xf4HSfd+SkjcdW1h5I99/0d02nu
	IEIobtaBwTnKPaR0/ftFsVw2h479lQaO6oYtVpb/3tnFm4esf0dT0Qvk0fx2xOAFqDxZjc
	1AkXPOiaoIe8e5ls7T6YyTNPuI0593I=
Date: Thu, 29 Jan 2026 07:52:07 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
 linux-mm@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
References: <20260128183232.2854138-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260128183232.2854138-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75878-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yonghong.song@linux.dev,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 8EC60B1B0D
X-Rspamd-Action: no action



On 1/28/26 10:32 AM, Andrii Nakryiko wrote:
> Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_lock or
> per-VMA lock, whichever was used to lock VMA under question, to avoid deadlock
> reported by syzbot:
>
>   -> #1 (&mm->mmap_lock){++++}-{4:4}:
>          __might_fault+0xed/0x170
>          _copy_to_iter+0x118/0x1720
>          copy_page_to_iter+0x12d/0x1e0
>          filemap_read+0x720/0x10a0
>          blkdev_read_iter+0x2b5/0x4e0
>          vfs_read+0x7f4/0xae0
>          ksys_read+0x12a/0x250
>          do_syscall_64+0xcb/0xf80
>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>          __lock_acquire+0x1509/0x26d0
>          lock_acquire+0x185/0x340
>          down_read+0x98/0x490
>          blkdev_read_iter+0x2a7/0x4e0
>          __kernel_read+0x39a/0xa90
>          freader_fetch+0x1d5/0xa80
>          __build_id_parse.isra.0+0xea/0x6a0
>          do_procmap_query+0xd75/0x1050
>          procfs_procmap_ioctl+0x7a/0xb0
>          __x64_sys_ioctl+0x18e/0x210
>          do_syscall_64+0xcb/0xf80
>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   other info that might help us debug this:
>
>    Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     rlock(&mm->mmap_lock);
>                                  lock(&sb->s_type->i_mutex_key#8);
>                                  lock(&mm->mmap_lock);
>     rlock(&sb->s_type->i_mutex_key#8);
>
>    *** DEADLOCK ***
>
> To make this safe, we need to grab file refcount while VMA is still locked, but
> other than that everything is pretty straightforward. Internal build_id_parse()
> API assumes VMA is passed, but it only needs the underlying file reference, so
> just add another variant build_id_parse_file() that expects file passed
> directly.
>
> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
>   include/linux/buildid.h |  3 +++
>   lib/buildid.c           | 34 +++++++++++++++++++++++++--------
>   3 files changed, 56 insertions(+), 23 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 480db575553e..dd3b5cf9f0b7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>   	struct proc_maps_locking_ctx lock_ctx = { .mm = mm };
>   	struct procmap_query karg;
>   	struct vm_area_struct *vma;
> +	struct file *vm_file = NULL;
>   	const char *name = NULL;
>   	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
>   	__u64 usize;
> @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>   		karg.inode = 0;
>   	}
>   
> -	if (karg.build_id_size) {
> -		__u32 build_id_sz;
> -
> -		err = build_id_parse(vma, build_id_buf, &build_id_sz);
> -		if (err) {
> -			karg.build_id_size = 0;
> -		} else {
> -			if (karg.build_id_size < build_id_sz) {
> -				err = -ENAMETOOLONG;
> -				goto out;
> -			}
> -			karg.build_id_size = build_id_sz;
> -		}
> -	}
> -
>   	if (karg.vma_name_size) {
>   		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
>   		const struct path *path;
> @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>   		karg.vma_name_size = name_sz;
>   	}
>   
> +	if (karg.build_id_size && vma->vm_file)
> +		vm_file = get_file(vma->vm_file);
> +
>   	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
>   	query_vma_teardown(&lock_ctx);
>   	mmput(mm);
>   
> +	if (karg.build_id_size) {
> +		__u32 build_id_sz;
> +
> +		if (vm_file)
> +			err = build_id_parse_file(vm_file, build_id_buf, &build_id_sz);
> +		else
> +			err = -ENOENT;
> +		if (err) {
> +			karg.build_id_size = 0;
> +		} else {
> +			if (karg.build_id_size < build_id_sz) {
> +				err = -ENAMETOOLONG;
> +				goto out;
> +			}
> +			karg.build_id_size = build_id_sz;
> +		}
> +	}
> +
> +	if (vm_file)
> +		fput(vm_file);
> +
>   	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
>   					       name, karg.vma_name_size)) {
>   		kfree(name_buf);
> @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>   out:
>   	query_vma_teardown(&lock_ctx);
>   	mmput(mm);
> +	if (vm_file)
> +		fput(vm_file);
>   	kfree(name_buf);
>   	return err;
>   }
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 831c1b4b626c..7acc06b22fb7 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -7,7 +7,10 @@
>   #define BUILD_ID_SIZE_MAX 20
>   
>   struct vm_area_struct;
> +struct file;
> +
>   int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
> +int build_id_parse_file(struct file *file, unsigned char *build_id, __u32 *size);
>   int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
>   int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>   
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 818331051afe..dc643a6293c1 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
>   /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
>   #define MAX_FREADER_BUF_SZ 64
>   
> -static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> +static int __build_id_parse(struct file *file, unsigned char *build_id,
>   			    __u32 *size, bool may_fault)
>   {
>   	const Elf32_Ehdr *ehdr;
> @@ -287,11 +287,7 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>   	char buf[MAX_FREADER_BUF_SZ];
>   	int ret;
>   
> -	/* only works for page backed storage  */
> -	if (!vma->vm_file)
> -		return -EINVAL;
> -
> -	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
> +	freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
>   
>   	/* fetch first 18 bytes of ELF header for checks */
>   	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
> @@ -332,7 +328,10 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>    */
>   int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
>   {
> -	return __build_id_parse(vma, build_id, size, false /* !may_fault */);
> +	if (!vma->vm_file)
> +		return -EINVAL;
> +
> +	return __build_id_parse(vma->vm_file, build_id, size, false /* !may_fault */);
>   }
>   
>   /*
> @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
>    */
>   int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
>   {
> -	return __build_id_parse(vma, build_id, size, true /* may_fault */);
> +	if (!vma->vm_file)
> +		return -EINVAL;
> +
> +	return __build_id_parse(vma->vm_file, build_id, size, true /* may_fault */);
> +}
> +
> +/*
> + * Parse build ID of ELF file
> + * @vma:      file object

Should this be
      @file:	file object
?

> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Assumes faultable context and can cause page faults to bring in file data
> + * into page cache.
> + *
> + * Return: 0 on success; negative error, otherwise
> + */
> +int build_id_parse_file(struct file *file, unsigned char *build_id, __u32 *size)
> +{
> +	return __build_id_parse(file, build_id, size, true /* may_fault */);
>   }
>   
>   /**


