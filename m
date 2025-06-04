Return-Path: <linux-fsdevel+bounces-50598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B584BACD92A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 10:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85253A35EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C5268C7F;
	Wed,  4 Jun 2025 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM14O1Vy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13C26A0EA;
	Wed,  4 Jun 2025 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023983; cv=none; b=R3qWhI058d/6WJKNb2TEOPtfNB4/lraQAF2Mb98/An8SOf28/FcRPH7vpIbmfLNWyCIPp67qbKRvOkb/eotyx+E8oJ2sdV8xVsdVkE26wdPQwKX5Z7HRwoldzY5WRGA730RRTK4Mrwy6cspmopS97HCLV3VWWpL+5GtzZm9Mcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023983; c=relaxed/simple;
	bh=cM075RtYNtApE6hMLvBD71DnCdfNXCoBoA9hVqxEA7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTmQhWbeCu+NUQjVEe1wqs6xs9K8Mrf65zanje9mpRTLCNL4xKZC9UTYuqzZceyTbTng2O2fHf2dmC8wgfZPxVFFp2BzverQuj5YPaBCeNu9w0QZz8Yntf8DmvhF/f6njDtLmUDj/AXpjF1uYK1M2NOneU3A7V01oSPwmSO4o5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM14O1Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D557FC4CEE7;
	Wed,  4 Jun 2025 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749023982;
	bh=cM075RtYNtApE6hMLvBD71DnCdfNXCoBoA9hVqxEA7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM14O1VyGa217AmCOHG9SGUX7udL4TZjk7VZDuGwKSsgsWQdN1y460ldmuGEsd7Ym
	 x+uW9eeelKeG+CjuuiWnWOP7XKFu7dDcJ/Tp0qiN9UnsDDnSOb8ia9qoJpj9TLbNE2
	 8R5ET6gd1w/m88Q1b0xKgGgOzkbRE2cWCyiUjqB1CSyZ2q/QnCxFknTVjkpoDYmSxF
	 Q2SVdK9UQTITBK4Q6LXFjYpnAYI/z95qKGzZKR+6VqQ/rOtCR03n9+ubv6ZQchE1aS
	 Sv1iEYv6FtPnoPJT+GUb4k5rbOVdJ/5tUP+Fg/UIImNFfMiHMDlxx1Z/etssMtN+LQ
	 lFs6ynfLF4+OA==
Date: Wed, 4 Jun 2025 10:59:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
	ajones@ventanamicro.com, akpm@linux-foundation.org,
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	kirill.shutemov@intel.com, liam.merwick@oracle.com,
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name,
	maz@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com,
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com,
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com,
	pvorel@suse.cz, qperret@google.com, quic_cvanscha@quicinc.com,
	quic_eberman@quicinc.com, quic_mnalajal@quicinc.com,
	quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com,
	rientjes@google.com, roypat@amazon.co.uk, seanjc@google.com,
	shuah@kernel.org, steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, tabba@google.com, thomas.lendacky@amd.com,
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
Message-ID: <aD_8z4pd7JcFkAwX@kernel.org>
References: <cover.1748890962.git.ackerleytng@google.com>
 <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>

(added Paul Moore for selinux bits)

On Mon, Jun 02, 2025 at 12:17:54PM -0700, Ackerley Tng wrote:
> The new function, alloc_anon_secure_inode(), returns an inode after
> running checks in security_inode_init_security_anon().
> 
> Also refactor secretmem's file creation process to use the new
> function.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  fs/anon_inodes.c   | 22 ++++++++++++++++------
>  include/linux/fs.h |  1 +
>  mm/secretmem.c     |  9 +--------
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 583ac81669c2..4c3110378647 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,17 +55,20 @@ static struct file_system_type anon_inode_fs_type = {
>  	.kill_sb	= kill_anon_super,
>  };
> 
> -static struct inode *anon_inode_make_secure_inode(
> -	const char *name,
> -	const struct inode *context_inode)
> +static struct inode *anon_inode_make_secure_inode(struct super_block *s,
> +		const char *name, const struct inode *context_inode,
> +		bool fs_internal)
>  {
>  	struct inode *inode;
>  	int error;
> 
> -	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode(s);
>  	if (IS_ERR(inode))
>  		return inode;
> -	inode->i_flags &= ~S_PRIVATE;
> +
> +	if (!fs_internal)
> +		inode->i_flags &= ~S_PRIVATE;
> +
>  	error =	security_inode_init_security_anon(inode, &QSTR(name),
>  						  context_inode);
>  	if (error) {
> @@ -75,6 +78,12 @@ static struct inode *anon_inode_make_secure_inode(
>  	return inode;
>  }
> 
> +struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
> +{
> +	return anon_inode_make_secure_inode(s, name, NULL, true);
> +}
> +EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
> +
>  static struct file *__anon_inode_getfile(const char *name,
>  					 const struct file_operations *fops,
>  					 void *priv, int flags,
> @@ -88,7 +97,8 @@ static struct file *__anon_inode_getfile(const char *name,
>  		return ERR_PTR(-ENOENT);
> 
>  	if (make_inode) {
> -		inode =	anon_inode_make_secure_inode(name, context_inode);
> +		inode = anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
> +						     name, context_inode, false);
>  		if (IS_ERR(inode)) {
>  			file = ERR_CAST(inode);
>  			goto err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..0fded2e3c661 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
>  extern const struct address_space_operations ram_aops;
>  extern int always_delete_dentry(const struct dentry *);
>  extern struct inode *alloc_anon_inode(struct super_block *);
> +extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
>  extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
>  extern const struct dentry_operations simple_dentry_operations;
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1b0a214ee558..c0e459e58cb6 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
>  	struct file *file;
>  	struct inode *inode;
>  	const char *anon_name = "[secretmem]";
> -	int err;
> 
> -	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> +	inode = alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_name);
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);

I don't think we should not hide secretmem and guest_memfd inodes from
selinux, so clearing S_PRIVATE for them is not needed and you can just drop
fs_internal parameter in anon_inode_make_secure_inode() 

> 
> -	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
> -	if (err) {
> -		file = ERR_PTR(err);
> -		goto err_free_inode;
> -	}
> -
>  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>  				 O_RDWR, &secretmem_fops);
>  	if (IS_ERR(file))
> --
> 2.49.0.1204.g71687c7c1d-goog

-- 
Sincerely yours,
Mike.

