Return-Path: <linux-fsdevel+bounces-74586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D8D3C134
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94A3567B19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827323AE713;
	Tue, 20 Jan 2026 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N18Lfx2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70933258EE0;
	Tue, 20 Jan 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895436; cv=none; b=JN9fi4Z9dRo86XGXqKcR0pVCu3HFI1MgtxZUFZ/oubUAFLIt5X1eVeKyEenlfEwBMtZIJxozmcm38US6p+GFnDna1namsbUshSvkF1bNTzXVI3t32oTT5HG5kX6CtU74DTn+XTUFAfNkNmuYXiS19Rd9433R3dKnNUUCdcv9cLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895436; c=relaxed/simple;
	bh=bWq6qnIFRw5rJinRpotPeIzOeZbQKqCHjbmSaH0uDbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPKU7Ec+ahxKUtMSqEAf4LcwSdrOWlJfy45mJ4xSTUgycZV5tjbRZb3LlaBSWJnu5J6VJtuaqK394TAsndJxb/JEl5L4s5ftugQMaDP+HfkjA6KMaMJG3O5Bp30IvcMMt0UuFZZSqfxl5brL/B0phincG0yrO96fPGKRKgB4CV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N18Lfx2l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=haSfZvoEvPhBBZDnUW3y3BhJEQ36mgFSvpNiOqhvJvI=; b=N18Lfx2l0cTzfa3HEHbSStwRPv
	iyXHar7+IL8UusFL6sjIudxhuirPKAhJMeBNA+7JTaSgRPwHzsN72C9/ED13gd4R3bzZoK6cN15el
	2OOL3ox9rvwKCy+jqAl20MM1KOQeI06m0Nqc7qZlyinWokSDH6OADy7uwk70GRUXw1dKPRbjqr1Mx
	G0x+S1U8gEmAS0uHHMxQqMK+KDGwlJXyI4/nRqaD3y/MPBEQbIe1RJKnMGnpCsJCrYQkezP6l13YD
	Bk/y5So46wc2umpZT0PCIQ7tT9Ms4VQ/Y3zVPPZ8bLDLhE9SURfv9f85/RpFqttM9TA+n04nUeD09
	UJSC4XRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi6VB-00000003NIK-3jXc;
	Tue, 20 Jan 2026 07:50:15 +0000
Date: Mon, 19 Jan 2026 23:50:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
Message-ID: <aW8ztQ-RbhxwzMk7@infradead.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
 <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 19, 2026 at 11:26:19AM -0500, Jeff Layton wrote:
> +  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
> +    stable across the lifetime of a file. This is a hard requirement for export
> +    via nfsd. Any filesystem that is eligible to be exported via nfsd must
> +    indicate this guarantee by setting this flag. Most disk-based filesystems
> +    can do this naturally. Pseudofilesystems that are for local reporting and
> +    control (e.g. kernfs, pidfs, nsfs) usually can't support this.

Suggested rewording, taking some of the ideas from Dave Chinners earlier
comments into account:

  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
    stable across the lifetime of a file.  A file in this context is an
    instantiated inode reachable by one or more file names, or still open after
    the last name has been unlinked.  Reuses of the same on-disk inode structure
    are considered new files and must provide different file handles from the
    previous incarnation.  Most file systems designed to store user data
    naturally provide this capability.  Pseudofilesystems that are for local
    reporting and control (e.g. kernfs, pidfs, nsfs) usually can't support this.

    This flags is a hard requirement for export via nfsd. Any filesystem that
    is eligible to be exported via nfsd must indicate this guarantee by
    setting this flag.


