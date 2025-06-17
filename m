Return-Path: <linux-fsdevel+bounces-51965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50278ADDBC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB5017E0CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C796B2EAB9B;
	Tue, 17 Jun 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVKFtgJx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5D1gAnpO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVKFtgJx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5D1gAnpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96B2EAB63
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186686; cv=none; b=W7F/ypHCepYP7KNHGo7P/WC1e/jjPr2F5U/vz7RGCjDVQAHgzYHBaVTXRRrvSrIxoATEjys4kAriO2DBzEnW4fLb0T3wx5gSMEB+mZx93jgSNQWDeBLxYT2+PTAkxZnkh1dfyl7/aeqm8grZJiu6bEr+tXCBiArzigPczYvPBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186686; c=relaxed/simple;
	bh=szqGztQmJDSY7et8LHJCKiY3zsAU/FrD96MjQ0Re0s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOxUu3o4QT1iQ5ML5d7rXMgjoRHcyvoQ7XJSojDJ+YqresBv2pQfgrOFe6n1osn40WU2SCksPZs/wgMvWhnCpg+cg/+Ce8LDXSRNf2lC6pd5zDWw2tL9qCAvglKqifA1oHs6tphjysCXHicAhPgj9BnCfw+oxwIEvId/lifFPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVKFtgJx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5D1gAnpO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVKFtgJx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5D1gAnpO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7590F1F7B2;
	Tue, 17 Jun 2025 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750186679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RgNDel3KBIdFRD20NWYscLXk0kRO4T4FPA8qn3r4sXM=;
	b=ZVKFtgJxgU6rST6x9dHOvq53H+ZPhdDkqsTMNZ7d/0yKJ+jcnU1S6R0rBWo8a7kKqVmKDR
	ENZeVprBsNGqAloTMjfmaopwBrFh1v3JFCTUXrAM3nsjylqULQ91szWdRb3GulZRtVMafj
	G1fZdguD9n3huUX618MPIWVd8mTvJbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750186679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RgNDel3KBIdFRD20NWYscLXk0kRO4T4FPA8qn3r4sXM=;
	b=5D1gAnpOzFQUDBJ63fx53UMHmj/Pinvy/HjB9v/V1oneL2XPt7iaxB1I7N+BFb4hFJ+WzO
	uMSoKL7nLRlBoMDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZVKFtgJx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5D1gAnpO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750186679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RgNDel3KBIdFRD20NWYscLXk0kRO4T4FPA8qn3r4sXM=;
	b=ZVKFtgJxgU6rST6x9dHOvq53H+ZPhdDkqsTMNZ7d/0yKJ+jcnU1S6R0rBWo8a7kKqVmKDR
	ENZeVprBsNGqAloTMjfmaopwBrFh1v3JFCTUXrAM3nsjylqULQ91szWdRb3GulZRtVMafj
	G1fZdguD9n3huUX618MPIWVd8mTvJbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750186679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RgNDel3KBIdFRD20NWYscLXk0kRO4T4FPA8qn3r4sXM=;
	b=5D1gAnpOzFQUDBJ63fx53UMHmj/Pinvy/HjB9v/V1oneL2XPt7iaxB1I7N+BFb4hFJ+WzO
	uMSoKL7nLRlBoMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AF47139E2;
	Tue, 17 Jun 2025 18:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id niR8Jba6UWjwOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 17 Jun 2025 18:57:58 +0000
Message-ID: <be9523c7-d06e-4c5a-b040-94109420cfed@suse.cz>
Date: Tue, 17 Jun 2025 20:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: rename call_mmap/mmap_prepare to
 vfs_mmap/mmap_prepare
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe
 <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
 Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng
 <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-mm@kvack.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <8d389f4994fa736aa8f9172bef8533c10a9e9011.1750099179.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <8d389f4994fa736aa8f9172bef8533c10a9e9011.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,oracle.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.dk,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,ionkov.net,codewreck.org,crudebyte.com,suse.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,kvack.org,szeredi.hu,linux.dev,fb.com,toxicpanda.com,cs.cmu.edu,tyhicks.com,linux.alibaba.com,google.com,huawei.com,samsung.com,sony.com,mit.edu,dilger.ca,mail.parknet.co.jp,dubeyko.com,physik.fu-berlin.de,vivo.com,nod.at,cambridgegreys.com,sipsolutions.net,artax.karlin.mff.cuni.cz,infradead.org,paragon-software.com,fasheh.com,evilplan.org,bobcopeland.com,omnibond.com,samba.org,manguebit.org,microsoft.com,talpey.com,wdc.com,suse.de,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,coda.cs.cmu.edu,lists.ozlabs.org,lists.sourceforge.net,lists.orangefs.org,lists.samba.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[112];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7590F1F7B2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

On 6/16/25 21:33, Lorenzo Stoakes wrote:
> The call_mmap() function violates the existing convention in
> include/linux/fs.h whereby invocations of virtual file system hooks is
> performed by functions prefixed with vfs_xxx().
> 
> Correct this by renaming call_mmap() to vfs_mmap(). This also avoids
> confusion as to the fact that f_op->mmap_prepare may be invoked here.
> 
> Also rename __call_mmap_prepare() function to vfs_mmap_prepare() and adjust
> to accept a file parameter, this is useful later for nested file systems.
> 
> Finally, fix up the VMA userland tests and ensure the mmap_prepare -> mmap
> shim is implemented there.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |  2 +-
>  fs/backing-file.c                          |  2 +-
>  fs/coda/file.c                             |  4 +--
>  include/linux/fs.h                         |  5 ++--
>  ipc/shm.c                                  |  2 +-
>  mm/internal.h                              |  2 +-
>  mm/vma.c                                   |  2 +-
>  tools/testing/vma/vma_internal.h           | 32 ++++++++++++++++++----
>  8 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> index 05e440643aa2..f4f1c979d1b9 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> @@ -105,7 +105,7 @@ static int i915_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *
>  	if (!obj->base.filp)
>  		return -ENODEV;
>  
> -	ret = call_mmap(obj->base.filp, vma);
> +	ret = vfs_mmap(obj->base.filp, vma);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 763fbe9b72b2..04018679bf69 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -339,7 +339,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
>  	vma_set_file(vma, file);
>  
>  	old_cred = override_creds(ctx->cred);
> -	ret = call_mmap(vma->vm_file, vma);
> +	ret = vfs_mmap(vma->vm_file, vma);
>  	revert_creds(old_cred);
>  
>  	if (ctx->accessed)
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 148856a582a9..2e6ea9319b35 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -199,10 +199,10 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
>  	spin_unlock(&cii->c_lock);
>  
>  	vma->vm_file = get_file(host_file);
> -	ret = call_mmap(vma->vm_file, vma);
> +	ret = vfs_mmap(vma->vm_file, vma);
>  
>  	if (ret) {
> -		/* if call_mmap fails, our caller will put host_file so we
> +		/* if vfs_mmap fails, our caller will put host_file so we
>  		 * should drop the reference to the coda_file that we got.
>  		 */
>  		fput(coda_file);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 93ee0d2d6f1a..7120f80255b3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2278,7 +2278,7 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
>  
>  int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
>  
> -static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> +static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	if (file->f_op->mmap_prepare)
>  		return compat_vma_mmap_prepare(file, vma);
> @@ -2286,8 +2286,7 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  	return file->f_op->mmap(file, vma);
>  }
>  
> -static inline int __call_mmap_prepare(struct file *file,
> -		struct vm_area_desc *desc)
> +static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
>  {
>  	return file->f_op->mmap_prepare(desc);
>  }
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 492fcc699985..a9310b6dbbc3 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -602,7 +602,7 @@ static int shm_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
>  
> -	ret = call_mmap(sfd->file, vma);
> +	ret = vfs_mmap(sfd->file, vma);
>  	if (ret) {
>  		__shm_close(sfd);
>  		return ret;
> diff --git a/mm/internal.h b/mm/internal.h
> index 3823fb356d3b..a55c88afff6d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -165,7 +165,7 @@ static inline void *folio_raw_mapping(const struct folio *folio)
>   */
>  static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
>  {
> -	int err = call_mmap(file, vma);
> +	int err = vfs_mmap(file, vma);
>  
>  	if (likely(!err))
>  		return 0;
> diff --git a/mm/vma.c b/mm/vma.c
> index 5d35adadf2b5..f548bede3bbe 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2582,7 +2582,7 @@ static int call_mmap_prepare(struct mmap_state *map)
>  	};
>  
>  	/* Invoke the hook. */
> -	err = __call_mmap_prepare(map->file, &desc);
> +	err = vfs_mmap_prepare(map->file, &desc);
>  	if (err)
>  		return err;
>  
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index d7fea56e3bb3..51dd122b8d50 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1458,6 +1458,27 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  	(void)vma;
>  }
>  
> +/* Declared in vma.h. */
> +static inline void set_vma_from_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc);
> +
> +static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc);
> +
> +static int compat_vma_mmap_prepare(struct file *file,
> +		struct vm_area_struct *vma)
> +{
> +	struct vm_area_desc desc;
> +	int err;
> +
> +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> +	if (err)
> +		return err;
> +	set_vma_from_desc(vma, &desc);
> +
> +	return 0;
> +}
> +
>  /* Did the driver provide valid mmap hook configuration? */
>  static inline bool file_has_valid_mmap_hooks(struct file *file)
>  {
> @@ -1467,22 +1488,21 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
>  	/* Hooks are mutually exclusive. */
>  	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
>  		return false;
> -	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> +	if (!has_mmap && !has_mmap_prepare)
>  		return false;
>  
>  	return true;
>  }
>  
> -static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> +static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> -		return -EINVAL;
> +	if (file->f_op->mmap_prepare)
> +		return compat_vma_mmap_prepare(file, vma);
>  
>  	return file->f_op->mmap(file, vma);
>  }
>  
> -static inline int __call_mmap_prepare(struct file *file,
> -		struct vm_area_desc *desc)
> +static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
>  {
>  	return file->f_op->mmap_prepare(desc);
>  }


