Return-Path: <linux-fsdevel+bounces-51900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B95CADCA06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9587F18995C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8C2E06ED;
	Tue, 17 Jun 2025 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFaXplkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0621C9FF;
	Tue, 17 Jun 2025 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161288; cv=none; b=XCGvbWILQWm7cxo28S4PvooNHCIH626J6i4Zn8KsbPDvElv1W0jdVnEsELsFIMjnK5nnYYMcPHBv/jmb21B8IjClWVd7HMuIs9QW899+TwD79828JThQvWuGjJpzJ98UYOyt0qmQD9a8xyQzq4CTiOXjiLHhKFeIC2ANDzEOo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161288; c=relaxed/simple;
	bh=FM4A89teoGTiVHD+mgfi0AiySK9n5DYBMecgMr0uDqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi+xBP+Cjg9gQIx3Ziv0eWWk+XcsfFL5FVRdXOJ7dpUwbd2aSYE6sT162UGZMsu6Utqz4ypWLvkHNjfuag35MxwFnoGAY9AHkwbu330JzuTBEUzICNOufGlqMyXy363e6kMb8VAYQ9GqexGNY1okpQUgMjg6WRtpOfJF4PaYUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFaXplkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE2BC4CEE3;
	Tue, 17 Jun 2025 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750161287;
	bh=FM4A89teoGTiVHD+mgfi0AiySK9n5DYBMecgMr0uDqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFaXplkY5nyo20ol4Egr1jKpFof+Bu6EVWj8rd7Q/XVflaJDEuUt2QBZbBOzt+ds9
	 QqRJ0416pNcF2gR1cOk/fhlCLM2NyYyFsqO7E+6LcmkPsrh7dOxbot5r+EPV6Mf/Eg
	 m8Y6DUqcdfGWwY+D64Xca2p2YAi1GLXZEZrvZUt4zBrfooL7qgslbeGTMTkIs72Kmi
	 ZyPQ8xq03VfK0FOehVNSaD+X4yl6DS92oWcHFB7su60iMijW1l2mzbjqhQKi8Q2XlY
	 I0aiDlWsnalkNnHvD2WZzlIylBsOw4cpNRmvr5us4RCENbN2fbk5X67yCW3LloR+n5
	 oLveA9uaTcrqQ==
Date: Tue, 17 Jun 2025 13:54:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise <bcrl@kvack.org>, 
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
Message-ID: <20250617-allenfalls-brummen-3ce2da5794f8@brauner>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <08db85970d89b17a995d2cffae96fb4cc462377f.1750099179.git.lorenzo.stoakes@oracle.com>
 <gexpfonlstqrggxbwxlorn7c6qvt42e2dof6lahipfyfecgfru@vexc23jbaxwc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <gexpfonlstqrggxbwxlorn7c6qvt42e2dof6lahipfyfecgfru@vexc23jbaxwc>

On Tue, Jun 17, 2025 at 12:23:41PM +0200, Jan Kara wrote:
> On Mon 16-06-25 20:33:28, Lorenzo Stoakes wrote:
> > Update nearly all generic_file_mmap() and generic_file_readonly_mmap()
> > callers to use generic_file_mmap_prepare() and
> > generic_file_readonly_mmap_prepare() respectively.
> > 
> > We update blkdev, 9p, afs, erofs, ext2, nfs, ntfs3, smb, ubifs and vboxsf
> > file systems this way.
> > 
> > Remaining users we cannot yet update are ecryptfs, fuse and cramfs. The
> > former two are nested file systems that must support any underlying file
> > ssytem, and cramfs inserts a mixed mapping which currently requires a VMA.
> > 
> > Once all file systems have been converted to mmap_prepare(), we can then
> > update nested file systems.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Overall the patch looks good. Just a couple of notes regarding pointless
> local variable being created...
> 
> > ---
> >  block/fops.c           |  9 +++++----
> >  fs/9p/vfs_file.c       | 11 ++++++-----
> >  fs/afs/file.c          | 11 ++++++-----
> >  fs/erofs/data.c        | 16 +++++++++-------
> >  fs/ext2/file.c         | 12 +++++++-----
> >  fs/nfs/file.c          | 13 +++++++------
> >  fs/nfs/internal.h      |  2 +-
> >  fs/nfs/nfs4file.c      |  2 +-
> >  fs/ntfs3/file.c        | 15 ++++++++-------
> >  fs/smb/client/cifsfs.c | 12 ++++++------
> >  fs/smb/client/cifsfs.h |  4 ++--
> >  fs/smb/client/file.c   | 14 ++++++++------
> >  fs/ubifs/file.c        |  8 ++++----
> >  fs/vboxsf/file.c       |  8 ++++----
> >  14 files changed, 74 insertions(+), 63 deletions(-)
> > 
> > diff --git a/block/fops.c b/block/fops.c
> > index 1309861d4c2c..5a0ebc81e489 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -911,14 +911,15 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> >  	return error;
> >  }
> >  
> > -static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int blkdev_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> >  	struct inode *bd_inode = bdev_file_inode(file);
> 
> I guess no need to create 'file' variable here since it has only one use in
> the line above...

Agreed, fixed in-tree.

> > -static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int afs_file_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> >  	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> 
> Same comment about pointless local variable here as well.

Same.

> > -static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> > +
> >  	if (!IS_DAX(file_inode(file)))
> 
> And here...

Same.

> > -int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
> > +int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> >  	int xid, rc = 0;
> >  	struct inode *inode = file_inode(file);
> 
> Again pointless local variable 'file' here.

Same.

> > -int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +int cifs_file_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> >  	int rc, xid;
> 
> And here (the only use is in cifs_revalidate_file(file)).

Same.

