Return-Path: <linux-fsdevel+bounces-67526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F4C42817
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 07:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAE31886C9C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF52DF153;
	Sat,  8 Nov 2025 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="B+D3byKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6822C0270;
	Sat,  8 Nov 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762582386; cv=none; b=h1pusQwfaQxnPeg6yU3BqrThk4NwPltas9Shxy60ruowit28ttmw02GAZer2DX6aHj4SYN6RT7Ay32QppMdQarTBfFmUP9UohsBwSLIqmHM9IjQdULOolIb7ltCUJ4DciUgXu2FYv8MpFmDC4+9a7EjRsX60UtHHWw2RXcYVY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762582386; c=relaxed/simple;
	bh=DgH5GUT7j3a/+liLaMLDQ+ppgc87s/ERzvidbBqi8Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkikl/JRoX4zln4YTg/f/wrUrA+yGv5EE4xNA2rco9ct1p3/Ep5t5+ccuLWMtRTY0rjfC0TZpHDgxaxIbymlkTKFPAEjnUy3Pv5GTMV9SHITJvc/mS4ym28yzZzas4icQjD63IrTsk21HMoVa6qVLROFf7rJ/2/TH8os8YoZzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=B+D3byKt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A419014C2D3;
	Sat,  8 Nov 2025 07:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1762582373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTM5LkyL3mfB0IbHJeS1oRharyj4iNDNdaZ7y5irjmg=;
	b=B+D3byKtJ5aLyRiu2rooP0B2TJlyh9NnWKaBHKY3oGl5WrI9R/ZTOokRqfrmQkRjA4d6PF
	hVA+2jtaIxDHKJVm19YOlIu00RJFzbMjiJ2IJMY5v8SjTtfCjEZWBxEPfRtzuPasj++KiY
	8Sahe5eVbfmwmhQeo5uzL3Rp7AKK7Nzr7m3ipU5qmaiTEStLej1x9iBcfVqKnY9WidAi8X
	rwVB6qqUGBZMEcUSkoPWBbqf240gmgWcLbAb7B4RNHuho0O1rPy72OuweBfiXGGrgaJqO1
	amO1aDXHVrMyRWIApKs7c+o9NFvUODZZvMkcXugNCGdZ2S65dzPgh2BACKmoHA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 26a2c8b4;
	Sat, 8 Nov 2025 06:12:25 +0000 (UTC)
Date: Sat, 8 Nov 2025 15:12:10 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Chris Mason <clm@fb.com>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hansg@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	NeilBrown <neilb@ownmail.net>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	gfs2@lists.linux.dev, linux-um@lists.infradead.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove the excl argument from the ->create()
 inode_operation
Message-ID: <aQ7fOmknHIxcxuha@codewreck.org>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>

Jeff Layton wrote on Fri, Nov 07, 2025 at 10:05:03AM -0500:
> With two exceptions, ->create() methods provided by filesystems ignore
> the "excl" flag.  Those exception are NFS and GFS2 which both also
> provide ->atomic_open.
> 
> Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
> the "excl" argument to the ->create() inode_operation is always set to
> true in vfs_create(). The ->create() call in lookup_open() sets it
> according to the O_EXCL open flag, but is never called if the filesystem
> provides ->atomic_open().
> 
> The excl flag is therefore always either ignored or true.  Remove it,
> and change NFS and GFS2 to act as if it were always true.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Good cleanup, just one whitespace nitpick below but:
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>


> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 4f13b01e42eb5e2ad9d60cbbce7e47d09ad831e6..7a55e491e0c87a0d18909bd181754d6d68318059 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -505,7 +505,10 @@ otherwise noted.
>  	if you want to support regular files.  The dentry you get should
>  	not have an inode (i.e. it should be a negative dentry).  Here
>  	you will probably call d_instantiate() with the dentry and the
> -	newly created inode
> +        newly created inode. This operation should always provide O_EXCL

This and the block below change halfway from tab (old text) to spaces
(your patch)

Looks like the file has a few space-indented sections though so it won't
be the first if that goes in as is, the html-rendering doesn't seem to
care :)

Cheers,
-- 
Dominique Martinet | Asmadeus

