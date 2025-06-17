Return-Path: <linux-fsdevel+bounces-51898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB062ADC9E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AB118851CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F82E06DE;
	Tue, 17 Jun 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i76Wd947"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11121CA00;
	Tue, 17 Jun 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160911; cv=none; b=Ogd2BApvtD8CrMhKTAMPUF24o6Wz45GkICKPluA/UDzrt6KXPx4Q8I724DFWECqvfhDGoZiOB6gX5dVzy//6J7B3HsJ8vJlSHA/a5RrL/3ujkUXrQ0rGLh8q7UD9eHdyQP/n5pG2ThQ4frRf1yxGSX3m2yszLqxdd3NiEZOm5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160911; c=relaxed/simple;
	bh=Vnr3kmvDQPz8s5uZNmSkWKP9XPj/+f6PNSLS1Tx/MzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEuwAgYZqbkt3u3F8Av7K9o6QoQh5o2dkY5g2NA1wJFBVG7jrXA+9FILMasvqLjrNaecGVukjOiqQ/lN1isvIuVw/7j1JaFkSDRwfYWWIurA/xvRztYZY3UBNp6WLLhVMO/PTOM+XSMPK2s1dKt5yULVPc4S6KNMoQNWkhZWFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i76Wd947; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C6FC4CEE3;
	Tue, 17 Jun 2025 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750160910;
	bh=Vnr3kmvDQPz8s5uZNmSkWKP9XPj/+f6PNSLS1Tx/MzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i76Wd947DS4XwAcDpAS8fpuf+Ela4lfUx5B4Zl+sE1WJ8kzwgrCbFciE3rigUUS/6
	 wkwvrTbKDnBSYG4C5HYytRyvy7B3ZkCeJ/5F35ij31zEXxn65NXesNNhKSYHlLq/2D
	 R33NY8eYZWteN9O+9G//EUF0UQxUiz+Y2C7gC+ejd2PqldQ355joR8oksRp/9Bu+B9
	 HCJ+eqE2ygFdOjJuUuFVDO+rKmgk2g66UaZmVaAWhJlsobI+L+ldnr5kvasHnLLQtL
	 3ZDhNpWvRvvYFALgNe61XXKpKO8zT2d+3DmY+NeMp1GFEAHy45cWCYw7RMgE+f8kCe
	 WOUfPvP6PlRuw==
Date: Tue, 17 Jun 2025 13:48:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>, Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
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
Subject: Re: [PATCH 03/10] fs: consistently use file_has_valid_mmap_hooks()
 helper
Message-ID: <20250617-mitstreiter-bewahren-455b96bd1d50@brauner>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <b68145b609532e62bab603dd9686faa6562046ec.1750099179.git.lorenzo.stoakes@oracle.com>
 <aFD5AP7B80np-Szz@infradead.org>
 <b91c387e-5226-4c5e-94c3-04e80409ed62@lucifer.local>
 <kzp4cei5qq6gbtzzng7hmqj5avzblopfzzrks4e2gahcdvr7ro@cwziankavxw4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kzp4cei5qq6gbtzzng7hmqj5avzblopfzzrks4e2gahcdvr7ro@cwziankavxw4>

On Tue, Jun 17, 2025 at 12:08:13PM +0200, Jan Kara wrote:
> On Tue 17-06-25 06:25:34, Lorenzo Stoakes wrote:
> > On Mon, Jun 16, 2025 at 10:11:28PM -0700, Christoph Hellwig wrote:
> > > On Mon, Jun 16, 2025 at 08:33:22PM +0100, Lorenzo Stoakes wrote:
> > > > Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> > > > callback"), the f_op->mmap() hook has been deprecated in favour of
> > > > f_op->mmap_prepare().
> > > >
> > > > Additionally, commit bb666b7c2707 ("mm: add mmap_prepare() compatibility
> > > > layer for nested file systems") permits the use of the .mmap_prepare() hook
> > > > even in nested filesystems like overlayfs.
> > > >
> > > > There are a number of places where we check only for f_op->mmap - this is
> > > > incorrect now mmap_prepare exists, so update all of these to use the
> > > > general helper file_has_valid_mmap_hooks().
> > > >
> > > > Most notably, this updates the elf logic to allow for the ability to
> > > > execute binaries on filesystems which have the .mmap_prepare hook, but
> > > > additionally we update nested filesystems.
> > >
> > > Can you please give the function a better name before spreading it?
> > > file operations aren't hooks by any classic definition.
> > >
> > 
> > can_mmap_file()?
> 
> I like this name more as well :). With this patch looks good to me. Again a

Fixed in-tree.

