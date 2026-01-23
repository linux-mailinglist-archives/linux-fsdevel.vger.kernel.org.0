Return-Path: <linux-fsdevel+bounces-75216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGMpOmETc2lksAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:21:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136970D77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD17A3018745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90DA374176;
	Fri, 23 Jan 2026 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OONc+Hz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C4387569;
	Fri, 23 Jan 2026 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149268; cv=none; b=Da/s+gEbIx6vvO1sBo1FUIvQJlWpOysEX/ASgQP+x1Ly/hi8HKEfKxYv78eMmzS1+/v6oDOUryvoF8wLT7G2swJ9oAczyOSGeAb8py1t9EuciBIs+ckbjUysXoFDDE/YnrBZZCX+LFeSUMpnUeMxG6608OdCbWgeJ5XvKlKIc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149268; c=relaxed/simple;
	bh=4qLfl1EKnef/GzUW0bVZNp7SUilauqiMWE77LRDXaXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai3eoYiNavdZGugg2TZIWLm2AqVzGXwwY0RVp/Ou2OoUtE5dI6HrVvxo0DOD3HfxKavJ3hoRqdSRNoltajtwQezr/WA8ADAJ+z0FJKIgpjxL9RYVRGxKqSCZMgoUnESG40TvnbC5+DdCjhLBxAjHyLE9ikWPFV1Dk+jd9VCKVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OONc+Hz4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769149255; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1870OwY7Yt3wtHMS4Kw5+Uzzq7JdVz48VXgwCaXXTJw=;
	b=OONc+Hz4lqc1HP74NtQusaU9uk/dcEZsCk52r2ESR4HBF9cIXsmU0KMm8jv1P0jB5096JAHEtML2Qgaqa+XP+adb6qIZpbtghlWD/Iu80rKb5FeQV2HR2YKl8Cp3S9Nn/aRLUSxCWnIp17SLWzv5twcC/C9IC25lv1ZbLsGjZr4=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WxemimV_1769149254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 14:20:54 +0800
Message-ID: <7ccc3447-3a39-4206-95c5-a6cd00e2bda6@linux.alibaba.com>
Date: Fri, 23 Jan 2026 14:20:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
 linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75216-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9136970D77
X-Rspamd-Action: no action



On 1/23/26 12:06 AM, Lorenzo Stoakes wrote:
> In order to be able to use only vma_flags_t in vm_area_desc we must adjust
> shmem file setup functions to operate in terms of vma_flags_t rather than
> vm_flags_t.
> 
> This patch makes this change and updates all callers to use the new
> functions.
> 
> No functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

(reduced distribution list too)

Thanks. The shmem part looks good to me with some nits below.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
>   drivers/gpu/drm/drm_gem.c                 |  5 +-
>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
>   drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
>   drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
>   drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
>   drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
>   fs/xfs/scrub/xfile.c                      |  3 +-
>   fs/xfs/xfs_buf_mem.c                      |  2 +-
>   include/linux/shmem_fs.h                  |  8 ++-
>   ipc/shm.c                                 |  6 +--
>   mm/memfd.c                                |  2 +-
>   mm/memfd_luo.c                            |  2 +-
>   mm/shmem.c                                | 59 +++++++++++++----------
>   security/keys/big_key.c                   |  2 +-
>   16 files changed, 57 insertions(+), 49 deletions(-)

[snip]

>   	inode->i_flags |= i_flags;
> @@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>    *	checks are provided at the key or shm level rather than the inode.
>    * @name: name for dentry (to be seen in /proc/<pid>/maps)
>    * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size

nit: s/vma_flags/flags

>    */
> -struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> +				     vma_flags_t flags)
>   {
>   	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
>   }
> @@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
>    * @size: size to be set for the file
>    * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size

nit: s/VM_NORESERVE/VMA_NORESERVE_BIT

>    */
> -struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
>   {
>   	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
>   }
> @@ -5889,16 +5895,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
>    * @mnt: the tmpfs mount where the file will be created
>    * @name: name for dentry (to be seen in /proc/<pid>/maps)
>    * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>    */
>   struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
> -				       loff_t size, unsigned long flags)
> +				       loff_t size, vma_flags_t flags)
>   {
>   	return __shmem_file_setup(mnt, name, size, flags, 0);
>   }
>   EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
>   
> -static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
> +static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
> +		vma_flags_t flags)
>   {
>   	loff_t size = end - start;
>   
> @@ -5908,7 +5915,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>   	 * accessible to the user through its mapping, use S_PRIVATE flag to
>   	 * bypass file security, in the same way as shmem_kernel_file_setup().
>   	 */
> -	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
> +	return shmem_kernel_file_setup("dev/zero", size, flags);
>   }
>   
>   /**
> @@ -5918,7 +5925,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>    */
>   int shmem_zero_setup(struct vm_area_struct *vma)
>   {
> -	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
> +	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);
>   
>   	if (IS_ERR(file))
>   		return PTR_ERR(file);
> @@ -5939,7 +5946,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>    */
>   int shmem_zero_setup_desc(struct vm_area_desc *desc)
>   {
> -	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);
>   
>   	if (IS_ERR(file))
>   		return PTR_ERR(file);
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index d46862ab90d6..268f702df380 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>   					 0, enckey);
>   
>   		/* save aligned data to file */
> -		file = shmem_kernel_file_setup("", enclen, 0);
> +		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
>   		if (IS_ERR(file)) {
>   			ret = PTR_ERR(file);
>   			goto err_enckey;


