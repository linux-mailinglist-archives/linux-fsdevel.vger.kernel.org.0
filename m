Return-Path: <linux-fsdevel+bounces-73014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B8D07B3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC1F3078092
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5247A2FC86B;
	Fri,  9 Jan 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u/G6UHBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4D1925BC;
	Fri,  9 Jan 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767945792; cv=none; b=NPFuhy7trER1m13xTajMQ721luRbtDhCkGAsqD4+7zdW/DgJpanYJSdfCQjHW68fKpzhNIticsD6NBlh4inqA9Oj3yBbXgBeh0dUzuKOEhXrJUpvVylqmOksOlvcpun12NFv+PoN5gKUP5HzaRcG6A+1tHRgnfAQIzrEeO2RB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767945792; c=relaxed/simple;
	bh=qpKkiEmSndwjicxjhbSkEm+OqKkOEZYFr+38yoapT18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXpKSllX8aiJvAicU/q+DdrvPlphcBnED/1HDhRWomNotq/D3prUIdgqthJNnHQZbcecKgW7Ji8y5uPFJoOp7Yk6q7QP79bh+NJnyX4uHt1fnnuzTYyoyESjvxNegiUicGphXcC85fmnJ1cWsDw8N/85v79rS1TyIyIAkB1F2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u/G6UHBR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qpKkiEmSndwjicxjhbSkEm+OqKkOEZYFr+38yoapT18=; b=u/G6UHBR+5ow337c1JghYNJWDu
	469UvSVDGO6+YNoToIhvNpY/ayIALEDFf83grTS2D6y7ywOIZRCy3/iCq0ZM8cD9AQ7+fvI6fMS/l
	VjLYtprYxFtgUJOLkBpfkNoCRVxT2oFQ6XhbJajtpb60QimL+reK7hwOJ+F5oKdDQQZtNH32mdj0Y
	NYtK4gqyLHxfqzyBhdXj9XmvkLhDu8ED96O2oCUUKK/NOkC2O3HxcO7BSos4TaDLom8xvGFiEVG6n
	uXxgBBpevz0vRplri8JSg/0oY1M5QY6lVD/kkliK7tKRqWXLpEXX/jLge7VyyPvx2QBNIuYZ8+750
	dpDI5izw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1ve7TD-0000000F7AZ-0jA4;
	Fri, 09 Jan 2026 08:03:43 +0000
Date: Fri, 9 Jan 2026 08:03:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Anders Larsen <al@alarsen.net>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Dave Kleikamp <shaggy@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
	v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <20260109080343.GA3634291@ZenIV>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 08, 2026 at 12:12:55PM -0500, Jeff Layton wrote:

> I mainly focused on filesystems that are NFS exportable, since NFS and
> SMB are the main users of file leases, and they tend to end up exporting
> the same filesystem types. Let me know if I've missed any.

Series looks sane and I don't see any obvious gaps.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

