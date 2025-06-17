Return-Path: <linux-fsdevel+bounces-51878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDFADC803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9314716900D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AF2BD004;
	Tue, 17 Jun 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0vtO1r83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MFXM112g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0vtO1r83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MFXM112g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32682BEC45
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155827; cv=none; b=WWFaFp3GQMRAincDFp62uazAd+P2NiSobiUZO7N8nVYtE3pfl72hPaWsCd47BRtqxpiY8Hlj9GUI/76g1oiCrMlxyIirUdheGb3z0DzZPiM8IOB+FF2Y7RrqowybPtw/CMhVMeAfd9Bb/JLolx4w7k8RVnMpPTDsm/ieMfvr30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155827; c=relaxed/simple;
	bh=4UEi0t7UFFoGYzmfM4kkoh7sJE8752F+vgflGGIA2WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqZk79NnRAn1ZiOvCa8kwZXjG0Mi7IcjTk5deu9cTElrl1EDoqWo3ITadeUksJx245vSp2EatIa72uPnaHTjeNWNN5iUveEyQ8ys/Op1WrdVX8kqQ4kNF9fXH1eoT1zVhRE9Bj3DPEZwU+UNBU+0HP5q0gSTEK0UHkWiwDZmVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0vtO1r83; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MFXM112g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0vtO1r83; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MFXM112g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C05DC211BF;
	Tue, 17 Jun 2025 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750155821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgKx+Rhufud+xyv84CkP5jQpT6pJPjmkPqgzNgofRZY=;
	b=0vtO1r83WRAKyen/sl74pMYrwEeINd06w3kouKw4XtQ9dQRPADLJ6CM5JYXunqVAkAUnGT
	9C9SJGFB86ITz6p0vbKmlWMotVPtFVkgbtgpanOBzpBUJ5FoTXmS1oeJ2zbY4BlWg4Kjqe
	3fQ7eXKJ56YE6xUi6J3Ype8YfurulIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750155821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgKx+Rhufud+xyv84CkP5jQpT6pJPjmkPqgzNgofRZY=;
	b=MFXM112gzLzycqzUCeXn0pDIkj1ZAFT7HH7Jay35zGiLu/sJ0s7oopW+e62NvCfn15BsWZ
	ycahuii9UnS1A+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750155821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgKx+Rhufud+xyv84CkP5jQpT6pJPjmkPqgzNgofRZY=;
	b=0vtO1r83WRAKyen/sl74pMYrwEeINd06w3kouKw4XtQ9dQRPADLJ6CM5JYXunqVAkAUnGT
	9C9SJGFB86ITz6p0vbKmlWMotVPtFVkgbtgpanOBzpBUJ5FoTXmS1oeJ2zbY4BlWg4Kjqe
	3fQ7eXKJ56YE6xUi6J3Ype8YfurulIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750155821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgKx+Rhufud+xyv84CkP5jQpT6pJPjmkPqgzNgofRZY=;
	b=MFXM112gzLzycqzUCeXn0pDIkj1ZAFT7HH7Jay35zGiLu/sJ0s7oopW+e62NvCfn15BsWZ
	ycahuii9UnS1A+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE27C13AE2;
	Tue, 17 Jun 2025 10:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5BYQKi1CUWhfHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Jun 2025 10:23:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5CF2BA29F0; Tue, 17 Jun 2025 12:23:41 +0200 (CEST)
Date: Tue, 17 Jun 2025 12:23:41 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Tigran A . Aivazian" <aivazian.tigran@gmail.com>, 
	Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 09/10] fs: convert most other generic_file_*mmap() users
 to .mmap_prepare()
Message-ID: <gexpfonlstqrggxbwxlorn7c6qvt42e2dof6lahipfyfecgfru@vexc23jbaxwc>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <08db85970d89b17a995d2cffae96fb4cc462377f.1750099179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08db85970d89b17a995d2cffae96fb4cc462377f.1750099179.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kernel.dk,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,ionkov.net,codewreck.org,crudebyte.com,suse.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,kvack.org,szeredi.hu,linux.dev,fb.com,toxicpanda.com,cs.cmu.edu,tyhicks.com,linux.alibaba.com,google.com,huawei.com,samsung.com,sony.com,mit.edu,dilger.ca,mail.parknet.co.jp,dubeyko.com,physik.fu-berlin.de,vivo.com,nod.at,cambridgegreys.com,sipsolutions.net,artax.karlin.mff.cuni.cz,infradead.org,paragon-software.com,fasheh.com,evilplan.org,bobcopeland.com,omnibond.com,samba.org,manguebit.org,microsoft.com,talpey.com,wdc.com,suse.de,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,coda.cs.cmu.edu,lists.ozlabs.org,lists.sourceforge.net,lists.orangefs.org,lists.samba.org];
	URIBL_BLOCKED(0.00)[oracle.com:email,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[113];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Mon 16-06-25 20:33:28, Lorenzo Stoakes wrote:
> Update nearly all generic_file_mmap() and generic_file_readonly_mmap()
> callers to use generic_file_mmap_prepare() and
> generic_file_readonly_mmap_prepare() respectively.
> 
> We update blkdev, 9p, afs, erofs, ext2, nfs, ntfs3, smb, ubifs and vboxsf
> file systems this way.
> 
> Remaining users we cannot yet update are ecryptfs, fuse and cramfs. The
> former two are nested file systems that must support any underlying file
> ssytem, and cramfs inserts a mixed mapping which currently requires a VMA.
> 
> Once all file systems have been converted to mmap_prepare(), we can then
> update nested file systems.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Overall the patch looks good. Just a couple of notes regarding pointless
local variable being created...

> ---
>  block/fops.c           |  9 +++++----
>  fs/9p/vfs_file.c       | 11 ++++++-----
>  fs/afs/file.c          | 11 ++++++-----
>  fs/erofs/data.c        | 16 +++++++++-------
>  fs/ext2/file.c         | 12 +++++++-----
>  fs/nfs/file.c          | 13 +++++++------
>  fs/nfs/internal.h      |  2 +-
>  fs/nfs/nfs4file.c      |  2 +-
>  fs/ntfs3/file.c        | 15 ++++++++-------
>  fs/smb/client/cifsfs.c | 12 ++++++------
>  fs/smb/client/cifsfs.h |  4 ++--
>  fs/smb/client/file.c   | 14 ++++++++------
>  fs/ubifs/file.c        |  8 ++++----
>  fs/vboxsf/file.c       |  8 ++++----
>  14 files changed, 74 insertions(+), 63 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 1309861d4c2c..5a0ebc81e489 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -911,14 +911,15 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	return error;
>  }
>  
> -static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
> +static int blkdev_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
>  	struct inode *bd_inode = bdev_file_inode(file);

I guess no need to create 'file' variable here since it has only one use in
the line above...

>  
>  	if (bdev_read_only(I_BDEV(bd_inode)))
> -		return generic_file_readonly_mmap(file, vma);
> +		return generic_file_readonly_mmap_prepare(desc);
>  
> -	return generic_file_mmap(file, vma);
> +	return generic_file_mmap_prepare(desc);
>  }
>  
>  const struct file_operations def_blk_fops = {

...

> @@ -492,16 +492,17 @@ static void afs_drop_open_mmap(struct afs_vnode *vnode)
>  /*
>   * Handle setting up a memory mapping on an AFS file.
>   */
> -static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int afs_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
>  	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));

Same comment about pointless local variable here as well.

>  	int ret;
>  
>  	afs_add_open_mmap(vnode);
>  
> -	ret = generic_file_mmap(file, vma);
> +	ret = generic_file_mmap_prepare(desc);
>  	if (ret == 0)
> -		vma->vm_ops = &afs_vm_ops;
> +		desc->vm_ops = &afs_vm_ops;
>  	else
>  		afs_drop_open_mmap(vnode);
>  	return ret;
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6a329c329f43..52dfd1a44c43 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -409,20 +409,22 @@ static const struct vm_operations_struct erofs_dax_vm_ops = {
>  	.huge_fault	= erofs_dax_huge_fault,
>  };
>  
> -static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
> +
>  	if (!IS_DAX(file_inode(file)))

And here...

> -		return generic_file_readonly_mmap(file, vma);
> +		return generic_file_readonly_mmap_prepare(desc);
>  
> -	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
> +	if ((desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
>  		return -EINVAL;
>  
> -	vma->vm_ops = &erofs_dax_vm_ops;
> -	vm_flags_set(vma, VM_HUGEPAGE);
> +	desc->vm_ops = &erofs_dax_vm_ops;
> +	desc->vm_flags |= VM_HUGEPAGE;
>  	return 0;
>  }
...
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 9835672267d2..2ed5173cfa73 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -2995,8 +2995,9 @@ static const struct vm_operations_struct cifs_file_vm_ops = {
>  	.page_mkwrite = cifs_page_mkwrite,
>  };
>  
> -int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
> +int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
>  	int xid, rc = 0;
>  	struct inode *inode = file_inode(file);

Again pointless local variable 'file' here.

>  
> @@ -3005,16 +3006,17 @@ int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!CIFS_CACHE_READ(CIFS_I(inode)))
>  		rc = cifs_zap_mapping(inode);
>  	if (!rc)
> -		rc = generic_file_mmap(file, vma);
> +		rc = generic_file_mmap_prepare(desc);
>  	if (!rc)
> -		vma->vm_ops = &cifs_file_vm_ops;
> +		desc->vm_ops = &cifs_file_vm_ops;
>  
>  	free_xid(xid);
>  	return rc;
>  }
>  
> -int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +int cifs_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	struct file *file = desc->file;
>  	int rc, xid;

And here (the only use is in cifs_revalidate_file(file)).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

