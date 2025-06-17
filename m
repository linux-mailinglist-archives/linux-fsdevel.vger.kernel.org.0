Return-Path: <linux-fsdevel+bounces-51901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8410ADCA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3062178B03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F752E06FA;
	Tue, 17 Jun 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANNRMLSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6272DF3E4;
	Tue, 17 Jun 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161463; cv=none; b=Ir1yBMXJ+OXef6SozmAF3xz12hID8N0kAKIEcsEflVCSiL6Mpj2A+uYI/d2De+WCv374oOOh0+O1gdiV0N/R3uNhBJdavL1fGF/rEWMOzBcz2Zp+sb//7EQ0IcPFdAyi1enlsiQY+ml9F6q/+6klcIjAMup8tj3nW3C8Toqeytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161463; c=relaxed/simple;
	bh=T+hj+yayJhfzqGA9kWHW1UQw8dsCOqK3Vx6p1g+lWhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiJLYkF4PZohMHy4NBQW9JVO0SJ9twAuiN+ti1p4uzIuGXPPgS3NKOmbXtsSfWQzmXkhXaEEG72SoNWLTO3r5NEBH4COojxpFZBvfyxkWRVh+jwAzQbVRZE/uloq+60SJricMiJKZCrQ3NiGqTKP2yOQd6ywSDjCNVeWE2cFCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANNRMLSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC2DC4CEE3;
	Tue, 17 Jun 2025 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750161462;
	bh=T+hj+yayJhfzqGA9kWHW1UQw8dsCOqK3Vx6p1g+lWhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANNRMLSMbFJxF0/0JcpxGnRgNC2cM3iQk05j0kIN5dUOf6a+6FhzXEhCV9tljSO6h
	 v2e3uV6HAxpTWa31kRKsnVAXQkLyFD1xYm1QZjMvIFL3ouF6AXeudY39YUcGZrolsh
	 RyM2TZ/EQMyqQ6Y6s4GUWKP0gK9gINzD7L4jwsfBCJ1suak/ya3jB5me4TnYO/YFrF
	 BrbHmvsabgMYM9Mbit9yWCy+NDOo9GjZfXkkWr9NdZCIoi7MIoTDvDFU7neHyJvL+Q
	 sCBOLJVwQyL5L44PlP9UgERzG7VA2X0BjHsxmPcW0plFtm6qxZnaOBFYXof6KFwTQp
	 Bv2/tmMRJtG5w==
Date: Tue, 17 Jun 2025 13:57:17 +0200
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
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for
 simple mappings
Message-ID: <20250617-karibus-abgrenzen-e534b9acd4c7@brauner>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
 <6nktgdc7ygt6hncfnl33d2jlwvlydspiiklwf6oxiqxxcjhzs2@j6f36ktyv774>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6nktgdc7ygt6hncfnl33d2jlwvlydspiiklwf6oxiqxxcjhzs2@j6f36ktyv774>

On Tue, Jun 17, 2025 at 12:28:17PM +0200, Jan Kara wrote:
> On Mon 16-06-25 20:33:29, Lorenzo Stoakes wrote:
> > Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> > callback"), the f_op->mmap() hook has been deprecated in favour of
> > f_op->mmap_prepare().
> > 
> > This callback is invoked in the mmap() logic far earlier, so error handling
> > can be performed more safely without complicated and bug-prone state
> > unwinding required should an error arise.
> > 
> > This hook also avoids passing a pointer to a not-yet-correctly-established
> > VMA avoiding any issues with referencing this data structure.
> > 
> > It rather provides a pointer to the new struct vm_area_desc descriptor type
> > which contains all required state and allows easy setting of required
> > parameters without any consideration needing to be paid to locking or
> > reference counts.
> > 
> > Note that nested filesystems like overlayfs are compatible with an
> > .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare()
> > compatibility layer for nested file systems").
> > 
> > In this patch we apply this change to file systems with relatively simple
> > mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> > orangefs, nilfs2, romfs, ramfs and aio.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Two small nits below. Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 60a621b00c65..37522137c380 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -2330,13 +2330,14 @@ static const struct vm_operations_struct ceph_vmops = {
> >  	.page_mkwrite	= ceph_page_mkwrite,
> >  };
> >  
> > -int ceph_mmap(struct file *file, struct vm_area_struct *vma)
> > +int ceph_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> >  	struct address_space *mapping = file->f_mapping;
> 
> Pointless local variable here...

Agreed, fixed in-tree.

> > -static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int exfat_file_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> 
> Missing empty line here.

Fixed in-tree.

