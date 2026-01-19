Return-Path: <linux-fsdevel+bounces-74374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA2D39EC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 536FA30042AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882E283C89;
	Mon, 19 Jan 2026 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QwGA4hgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93826B764;
	Mon, 19 Jan 2026 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804891; cv=none; b=ZbQbbjrHl+b0N0X8u+MliRHtY8xk8eKrh5GDyUXBVTDwQnPxV9ngYQKJSyQfAec6jVFHy+ogLMk44oJ0ykE8CYzUDlHIPHDySaIpyIpcU49bD1wEO/X/zg+S8GW43v94caEFDPqyNDQHUUV0CUvv5AqFrjzU6pzlaY+DmBet4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804891; c=relaxed/simple;
	bh=pkwNomX83OjJa/gtViFneNGlwPqjG+thuV10N9WQaEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW8vDPGb1dYdV8fSp72h3bQ5z3GYSGEd0yeW1pS5qhiYfR+9cD7Z8WJTGNoHpJq7P3D1KZByjoGEwDBvtX1dpQ5AbA33QkHGX0K7qWfaOuEsRtMbcryoC7fraD/vWFMMcrUeuBzkWHYMd8EH2jO6scrluwI9MAC668vKDiDN+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QwGA4hgL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SwbeRkUkK9OO/mqWtmzTHxyd7fbhxxJhakqf4s0kNIg=; b=QwGA4hgL9aMV6sQTixPK1n3SnR
	Zri8G531dV5x98A84aReqp2G6UaHJpN4nTXf/6+Wnxr1XHLmqM3RDH1HwtqEKXYEuQzraEqef4ifS
	Rfg7JDYGeHeFp5XweYvklrNR0opJLe/tNClTdos3Mg+TXmulpYbbch6WDkxiaD+n25edx4Evpx16K
	chywKYqiRDwlqzijGrTxiZtG1P3yiRHDEqNuPQfZFCJ+hNE2459H6pBY6SMwsK15gU7luCRmdJNqI
	wOQgeUtkH/rzLOhP3JaZKrgna/cZqGj1BqYMwYctab45DTy467HukeFKRPuJN1wnShp9GMgFQxNTY
	QpZdjvWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhiwi-00000001PpP-1B5K;
	Mon, 19 Jan 2026 06:41:04 +0000
Date: Sun, 18 Jan 2026 22:41:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
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
	Jaegeuk Kim <jaegeuk@kernel.org>,
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
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <aW3SAKIr_QsnEE5Q@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176877859306.16766.15009835437490907207@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > This was Chuck's suggested name. His point was that STABLE means that
> > the FH's don't change during the lifetime of the file.
> > 
> > I don't much care about the flag name, so if everyone likes PERSISTENT
> > better I'll roll with that.
> 
> I don't like PERSISTENT.
> I'd rather call a spade a spade.
> 
>   EXPORT_OP_SUPPORTS_NFS_EXPORT
> or
>   EXPORT_OP_NOT_NFS_COMPATIBLE
> 
> The issue here is NFS export and indirection doesn't bring any benefits.

No, it absolutely is not.  And the whole concept of calling something
after the initial or main use is a recipe for a mess.

Pick a name that conveys what the flag is about, and document those
semantics well.  This flag is about the fact that for a given file,
as long as that file exists in the file system the handle is stable.
Both stable and persistent are suitable for that, nfs is everything
but.

Remember nfs also support volatile file handles, and other applications
might rely on this (I know of quite a few user space applications that
do, but they are kinda hardwired to xfs anyway).


