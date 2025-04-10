Return-Path: <linux-fsdevel+bounces-46175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD0A83D60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E998B1B83D0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D3D20D4F0;
	Thu, 10 Apr 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FRyNJ6g0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAA1EEA4B;
	Thu, 10 Apr 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274565; cv=none; b=t1dYfIhxqPGsYtSelUwuonuO9+/d8xb1S6rHX+Yiuec33ASVbUwVLA3L2aDKWHJgy6NZoGECkaQRz+DfoWwY8eGLgnCQnfgstfIOz52mGEER1dS26jVeccOv4v+d+mu+vBlYMUT4ktnwnl3WMtNtLAFtWtiNjFzrUcBsPvQTYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274565; c=relaxed/simple;
	bh=YSmAOLgssT6PQvheoyK0ouFbkX6lGlFzsxSSLWhx52U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4/VuDQ871OUiLkue89BIcY6jRoU58y/E5ZEElxpQ8tlgswp5zUZ6td4n/uHsLjmczwKH2e6JvTMCvYxkOmbHzb7zf4Wn9TWKygbOrXRq6Fy3jzxrivLx/xp3sXuxJhSsgcTAtLSz8WEHkKsls0EfCHn7TIFi94JXbmFDRDYBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FRyNJ6g0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=apfyLXFp4mpz8/dTquQGt331FyDN8GShWvECUqUQnXk=; b=FRyNJ6g0TgK3lFVFJDAty4Vx+p
	2GcIpX8aKtInetRLFajhT2MuxsfmdrzK67aUwOV9vSE+Yz4dBDmlhgRDLppTAuV8JQhVKje7BUCqA
	hGTO7t7XISNyoKPEPiH3DJ0WXN6VEgzN5oBFS6faIcwmNj/7yYXy1rRF43TD7n+jOb95oZWLtLBoS
	gDmgjhtKkfTxeiM9NUTtd6xrQyAMa1b67WdDTvbB8k3orQmxjG438aeY1h1A68CedZ64W1K+3q89j
	M4mSlBRNYhjTelrdyhg5ALuuo+uQ9Ltb0u32W92KPAFXuzTk21vifJIW0tTxmGRzDRM+KlajnjheL
	uZHFTJEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nUc-00000009n15-09rJ;
	Thu, 10 Apr 2025 08:42:38 +0000
Date: Thu, 10 Apr 2025 01:42:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz,
	willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
	pbonzini@redhat.com, ackerleytng@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
	michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com,
	jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH RFC v7 5/8] KVM: guest_memfd: Make guest mem use guest
 mem inodes instead of anonymous inodes
Message-ID: <Z_eEfjrkspAt4ACP@infradead.org>
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-6-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408112402.181574-6-shivankg@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 08, 2025 at 11:23:59AM +0000, Shivank Garg wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Using guest mem inodes allows us to store metadata for the backing
> memory on the inode. Metadata will be added in a later patch to support
> HugeTLB pages.
> 
> Metadata about backing memory should not be stored on the file, since
> the file represents a guest_memfd's binding with a struct kvm, and
> metadata about backing memory is not unique to a specific binding and
> struct kvm.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  include/uapi/linux/magic.h |   1 +
>  virt/kvm/guest_memfd.c     | 133 +++++++++++++++++++++++++++++++------
>  2 files changed, 113 insertions(+), 21 deletions(-)
> 
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index bb575f3ab45e..169dba2a6920 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -103,5 +103,6 @@
>  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
> +#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 88453b040926..002328569c9e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1,12 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/fs.h>
> +#include <linux/mount.h>
>  #include <linux/backing-dev.h>
>  #include <linux/falloc.h>
>  #include <linux/kvm_host.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
>  
>  #include "kvm_mm.h"
>  
> +static struct vfsmount *kvm_gmem_mnt;
> +
>  struct kvm_gmem {
>  	struct kvm *kvm;
>  	struct xarray bindings;
> @@ -312,6 +317,38 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>  	return gfn - slot->base_gfn + slot->gmem.pgoff;
>  }
>  
> +static const struct super_operations kvm_gmem_super_operations = {
> +	.statfs		= simple_statfs,
> +};
> +
> +static int kvm_gmem_init_fs_context(struct fs_context *fc)
> +{
> +	struct pseudo_fs_context *ctx;
> +
> +	if (!init_pseudo(fc, GUEST_MEMORY_MAGIC))
> +		return -ENOMEM;
> +
> +	ctx = fc->fs_private;
> +	ctx->ops = &kvm_gmem_super_operations;
> +
> +	return 0;
> +}
> +
> +static struct file_system_type kvm_gmem_fs = {
> +	.name		 = "kvm_guest_memory",
> +	.init_fs_context = kvm_gmem_init_fs_context,
> +	.kill_sb	 = kill_anon_super,
> +};
> +
> +static void kvm_gmem_init_mount(void)
> +{
> +	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
> +	BUG_ON(IS_ERR(kvm_gmem_mnt));
> +
> +	/* For giggles. Userspace can never map this anyways. */
> +	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
> +}
> +
>  static struct file_operations kvm_gmem_fops = {
>  	.open		= generic_file_open,
>  	.release	= kvm_gmem_release,
> @@ -321,11 +358,13 @@ static struct file_operations kvm_gmem_fops = {
>  void kvm_gmem_init(struct module *module)
>  {
>  	kvm_gmem_fops.owner = module;
> +
> +	kvm_gmem_init_mount();
>  }
>  
>  void kvm_gmem_exit(void)
>  {
> -
> +	kern_unmount(kvm_gmem_mnt);
>  }
>  
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
> @@ -407,11 +446,79 @@ static const struct inode_operations kvm_gmem_iops = {
>  	.setattr	= kvm_gmem_setattr,
>  };
>  
> +static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> +						      loff_t size, u64 flags)
> +{
> +	const struct qstr qname = QSTR_INIT(name, strlen(name));
> +	struct inode *inode;
> +	int err;
> +
> +	inode = alloc_anon_inode(kvm_gmem_mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return inode;
> +
> +	err = security_inode_init_security_anon(inode, &qname, NULL);
> +	if (err) {
> +		iput(inode);
> +		return ERR_PTR(err);
> +	}

So why do other alloc_anon_inode callers not need
security_inode_init_security_anon?


