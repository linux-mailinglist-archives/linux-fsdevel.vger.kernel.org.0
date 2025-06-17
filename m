Return-Path: <linux-fsdevel+bounces-51877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912B5ADC7D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05D83A40AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE92D2397;
	Tue, 17 Jun 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCA4vRTt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vofk+nlP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCA4vRTt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vofk+nlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C542BFC65
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155246; cv=none; b=GLp8koaJ8DUU+YE8IU+Q4idnit4SU5raz3TfT6k1EKBHDTODmLm5mhI/fZ510OsqQHoZKA7MjDt12/H0k73RHt6kLUM16xIwSpDlSJNMLXR+tZzcgz1nsawtsf7FJHsb/ab6erV3C9SUZ6f5SaSh2acxIQbHooqr4JhOJoZXnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155246; c=relaxed/simple;
	bh=sPO4WXT4jSenXo5Yqpp8hgtBRPi3I3kqJb8mnCUXJ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXYKUrsC6lqUBYJazUD9WYsb+XSXRx+caR4gm3wRCXR8Poa3OqRbj6q3G2lBDji+mT5gMChrpA0bi53ROo1VWxvU2EUxlfX6f3lY2Osyf+wmW+zsou7UA4ODpqo7ZR8DsKKnRrwlwLNBt1M/P0nIJRr7BH5Xb61FXYYquNtCN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCA4vRTt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vofk+nlP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCA4vRTt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vofk+nlP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 943731F766;
	Tue, 17 Jun 2025 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750155240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumSZqJEc3NqTuF1gCNLL1DjTVit469VH90oXWtD97g=;
	b=GCA4vRTtep8lSNqForgDoEbiH2FHffylKbTQW8ADGX0ygw7y0YzgmvKyJudwz1c+pn/vrP
	oiM1utFqq3DKasuCS+rvGIM3fht87NThulP97W1MoOrovEYbQlceN3dPfOwqPwPdTl/wzO
	Jc9QPnSqRm9TOoCgWTtotAyb95FVifI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750155240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumSZqJEc3NqTuF1gCNLL1DjTVit469VH90oXWtD97g=;
	b=vofk+nlPab1BttxugZRXW6jQtLNByPTK8FyDt52WanP8wxnuDGkGdmSvEDafeB/gXZrhW8
	SgAfoWxD1JFY7mAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GCA4vRTt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vofk+nlP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750155240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumSZqJEc3NqTuF1gCNLL1DjTVit469VH90oXWtD97g=;
	b=GCA4vRTtep8lSNqForgDoEbiH2FHffylKbTQW8ADGX0ygw7y0YzgmvKyJudwz1c+pn/vrP
	oiM1utFqq3DKasuCS+rvGIM3fht87NThulP97W1MoOrovEYbQlceN3dPfOwqPwPdTl/wzO
	Jc9QPnSqRm9TOoCgWTtotAyb95FVifI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750155240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumSZqJEc3NqTuF1gCNLL1DjTVit469VH90oXWtD97g=;
	b=vofk+nlPab1BttxugZRXW6jQtLNByPTK8FyDt52WanP8wxnuDGkGdmSvEDafeB/gXZrhW8
	SgAfoWxD1JFY7mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE4913AE1;
	Tue, 17 Jun 2025 10:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UzN6Hug/UWhbGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Jun 2025 10:14:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33D4AA29F0; Tue, 17 Jun 2025 12:14:00 +0200 (CEST)
Date: Tue, 17 Jun 2025 12:14:00 +0200
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
Subject: Re: [PATCH 08/10] fs: convert simple use of generic_file_*_mmap() to
 .mmap_prepare()
Message-ID: <3m4hxh7ybqgwr2fzymzsp4wiz254hdeelkdaajw3gxbdw7fezt@53eblikg32e3>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <c7dc90e44a9e75e750939ea369290d6e441a18e6.1750099179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7dc90e44a9e75e750939ea369290d6e441a18e6.1750099179.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 943731F766
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kernel.dk,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,ionkov.net,codewreck.org,crudebyte.com,suse.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,kvack.org,szeredi.hu,linux.dev,fb.com,toxicpanda.com,cs.cmu.edu,tyhicks.com,linux.alibaba.com,google.com,huawei.com,samsung.com,sony.com,mit.edu,dilger.ca,mail.parknet.co.jp,dubeyko.com,physik.fu-berlin.de,vivo.com,nod.at,cambridgegreys.com,sipsolutions.net,artax.karlin.mff.cuni.cz,infradead.org,paragon-software.com,fasheh.com,evilplan.org,bobcopeland.com,omnibond.com,samba.org,manguebit.org,microsoft.com,talpey.com,wdc.com,suse.de,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,coda.cs.cmu.edu,lists.ozlabs.org,lists.sourceforge.net,lists.orangefs.org,lists.samba.org];
	RCPT_COUNT_GT_50(0.00)[113];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51
X-Spam-Level: 

On Mon 16-06-25 20:33:27, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
> 
> We have provided generic .mmap_prepare() equivalents, so update all file
> systems that specify these directly in their file_operations structures.
> 
> This updates 9p, adfs, affs, bfs, fat, hfs, hfsplus, hostfs, hpfs, jffs2,
> jfs, minix, omfs, ramfs and ufs file systems directly.
> 
> It updates generic_ro_fops which impacts qnx4, cramfs, befs, squashfs,
> frebxfs, qnx6, efs, romfs, erofs and isofs file systems.
> 
> There are remaining file systems which use generic hooks in a less direct
> way which we address in a subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/9p/vfs_file.c        | 2 +-
>  fs/adfs/file.c          | 2 +-
>  fs/affs/file.c          | 2 +-
>  fs/bfs/file.c           | 2 +-
>  fs/fat/file.c           | 2 +-
>  fs/hfs/inode.c          | 2 +-
>  fs/hfsplus/inode.c      | 2 +-
>  fs/hostfs/hostfs_kern.c | 2 +-
>  fs/hpfs/file.c          | 2 +-
>  fs/jffs2/file.c         | 2 +-
>  fs/jfs/file.c           | 2 +-
>  fs/minix/file.c         | 2 +-
>  fs/omfs/file.c          | 2 +-
>  fs/ramfs/file-mmu.c     | 2 +-
>  fs/read_write.c         | 2 +-
>  fs/ufs/file.c           | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 348cc90bf9c5..2ff3e0ac7266 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -516,7 +516,7 @@ const struct file_operations v9fs_file_operations = {
>  	.open = v9fs_file_open,
>  	.release = v9fs_dir_release,
>  	.lock = v9fs_file_lock,
> -	.mmap = generic_file_readonly_mmap,
> +	.mmap_prepare = generic_file_readonly_mmap_prepare,
>  	.splice_read = v9fs_file_splice_read,
>  	.splice_write = iter_file_splice_write,
>  	.fsync = v9fs_file_fsync,
> diff --git a/fs/adfs/file.c b/fs/adfs/file.c
> index ee80718aaeec..cd13165fd904 100644
> --- a/fs/adfs/file.c
> +++ b/fs/adfs/file.c
> @@ -25,7 +25,7 @@
>  const struct file_operations adfs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.fsync		= generic_file_fsync,
>  	.write_iter	= generic_file_write_iter,
>  	.splice_read	= filemap_splice_read,
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index 7a71018e3f67..fbac204b7055 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -999,7 +999,7 @@ const struct file_operations affs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.open		= affs_file_open,
>  	.release	= affs_file_release,
>  	.fsync		= affs_file_fsync,
> diff --git a/fs/bfs/file.c b/fs/bfs/file.c
> index fa66a09e496a..6685c3411fe7 100644
> --- a/fs/bfs/file.c
> +++ b/fs/bfs/file.c
> @@ -27,7 +27,7 @@ const struct file_operations bfs_file_operations = {
>  	.llseek 	= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.splice_read	= filemap_splice_read,
>  };
>  
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index e887e9ab7472..4fc49a614fb8 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -204,7 +204,7 @@ const struct file_operations fat_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.release	= fat_file_release,
>  	.unlocked_ioctl	= fat_generic_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..d419586d668d 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -690,7 +690,7 @@ static const struct file_operations hfs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.splice_read	= filemap_splice_read,
>  	.fsync		= hfs_file_fsync,
>  	.open		= hfs_file_open,
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index f331e9574217..0af7e302730c 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -366,7 +366,7 @@ static const struct file_operations hfsplus_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.splice_read	= filemap_splice_read,
>  	.fsync		= hfsplus_file_fsync,
>  	.open		= hfsplus_file_open,
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 702c41317589..bc22b6cc72af 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -382,7 +382,7 @@ static const struct file_operations hostfs_file_fops = {
>  	.splice_write	= iter_file_splice_write,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.open		= hostfs_open,
>  	.release	= hostfs_file_release,
>  	.fsync		= hostfs_fsync,
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index 449a3fc1b8d9..a1a44e3edb19 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -255,7 +255,7 @@ const struct file_operations hpfs_file_ops =
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.release	= hpfs_file_release,
>  	.fsync		= hpfs_file_fsync,
>  	.splice_read	= filemap_splice_read,
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index 13c18ccc13b0..1e05f7fe5dd4 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -54,7 +54,7 @@ const struct file_operations jffs2_file_operations =
>   	.read_iter =	generic_file_read_iter,
>   	.write_iter =	generic_file_write_iter,
>  	.unlocked_ioctl=jffs2_ioctl,
> -	.mmap =		generic_file_readonly_mmap,
> +	.mmap_prepare =	generic_file_readonly_mmap_prepare,
>  	.fsync =	jffs2_fsync,
>  	.splice_read =	filemap_splice_read,
>  	.splice_write = iter_file_splice_write,
> diff --git a/fs/jfs/file.c b/fs/jfs/file.c
> index 01b6912e60f8..5e47951db630 100644
> --- a/fs/jfs/file.c
> +++ b/fs/jfs/file.c
> @@ -143,7 +143,7 @@ const struct file_operations jfs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.splice_read	= filemap_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fsync		= jfs_fsync,
> diff --git a/fs/minix/file.c b/fs/minix/file.c
> index 906d192ab7f3..dca7ac71f049 100644
> --- a/fs/minix/file.c
> +++ b/fs/minix/file.c
> @@ -17,7 +17,7 @@ const struct file_operations minix_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.fsync		= generic_file_fsync,
>  	.splice_read	= filemap_splice_read,
>  };
> diff --git a/fs/omfs/file.c b/fs/omfs/file.c
> index 98358d405b6a..319c04e63964 100644
> --- a/fs/omfs/file.c
> +++ b/fs/omfs/file.c
> @@ -332,7 +332,7 @@ const struct file_operations omfs_file_operations = {
>  	.llseek = generic_file_llseek,
>  	.read_iter = generic_file_read_iter,
>  	.write_iter = generic_file_write_iter,
> -	.mmap = generic_file_mmap,
> +	.mmap_prepare = generic_file_mmap_prepare,
>  	.fsync = generic_file_fsync,
>  	.splice_read = filemap_splice_read,
>  };
> diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
> index b45c7edc3225..b11f5b20b78b 100644
> --- a/fs/ramfs/file-mmu.c
> +++ b/fs/ramfs/file-mmu.c
> @@ -41,7 +41,7 @@ static unsigned long ramfs_mmu_get_unmapped_area(struct file *file,
>  const struct file_operations ramfs_file_operations = {
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.fsync		= noop_fsync,
>  	.splice_read	= filemap_splice_read,
>  	.splice_write	= iter_file_splice_write,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0ef70e128c4a..80fdab99f9e4 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -28,7 +28,7 @@
>  const struct file_operations generic_ro_fops = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
> -	.mmap		= generic_file_readonly_mmap,
> +	.mmap_prepare	= generic_file_readonly_mmap_prepare,
>  	.splice_read	= filemap_splice_read,
>  };
>  
> diff --git a/fs/ufs/file.c b/fs/ufs/file.c
> index 487ad1fc2de6..c2a391c17df7 100644
> --- a/fs/ufs/file.c
> +++ b/fs/ufs/file.c
> @@ -38,7 +38,7 @@ const struct file_operations ufs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= generic_file_read_iter,
>  	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>  	.open           = generic_file_open,
>  	.fsync		= generic_file_fsync,
>  	.splice_read	= filemap_splice_read,
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

