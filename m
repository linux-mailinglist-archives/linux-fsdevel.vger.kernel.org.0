Return-Path: <linux-fsdevel+bounces-74422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D53D3A2EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE1CB3009D61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BCF357A31;
	Mon, 19 Jan 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu2QXGlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14A355803;
	Mon, 19 Jan 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814848; cv=none; b=ShkW4N3+Y4jcEOz0gpEiI2ugRkrqod+xuoty9oKvi52ZryXjwscC+HAyNLm1sTztWucCCik/fYHiWnawJTPItrzt1AjJAZMGhQuJglBHipwuBL/UMlybvhtQREs0f+LJ0ZjR8ZYG7Z7hnyp5ZPQuZTkrj8ImQETfNeFBwyoOyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814848; c=relaxed/simple;
	bh=Zn6TWVYgqMMEo3G81dyTmE6wcI+Sd3bTAPgjzlTxSPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTy1SozoKd0KZ4n626dbt2ixUJjDFlSR2rVqNrlt303DFSp9VneSGfTvBmLbntnAlf+xYRmsFnypkw1yxt/Unc93Yej/jCo0NIaxJpdmXnYdij0wB7Nfub/aT0P+1KJoWcqeWLN79ExOsRHNehBODZwBxNRMm4RS7sEGJ1y+acg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu2QXGlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB482C116C6;
	Mon, 19 Jan 2026 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768814847;
	bh=Zn6TWVYgqMMEo3G81dyTmE6wcI+Sd3bTAPgjzlTxSPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu2QXGlUo4aerUV1P+3KG6SEVjE4I5PwhJE94jSGcKGFEsi89NRvYzLMGsZyQmRMx
	 AFrdo2vU9n6IMbv1w/EO9SLvuETafk1mFU5xlxvhkxtXkEJNYxoKBYE396mdxVzJZb
	 W5ZtaIJuQRCJeroGKA0KDWsJMPfBkIPP+baoniV9KyAuTgFx19+cYmtPt33Z2z6QMh
	 W/hxfZCWesZN7MEjTCRbAXitVDu+eK0Xl7sEvoG3LmudoMrRbWd+So2BZh0JGzK2g9
	 bPKHftczmsMNxhRS3WkfraWatirsn1eEv2j+V31oLZsNC4UpAnMV0UccclyHU9DeQT
	 92D5SL9b9rhFA==
Date: Mon, 19 Jan 2026 10:27:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <20260119-kanufahren-meerjungfrau-775048806544@brauner>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org>
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176880736225.16766.4203157325432990313@noble.neil.brown.name>

On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> > On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > > This was Chuck's suggested name. His point was that STABLE means that
> > > > the FH's don't change during the lifetime of the file.
> > > > 
> > > > I don't much care about the flag name, so if everyone likes PERSISTENT
> > > > better I'll roll with that.
> > > 
> > > I don't like PERSISTENT.
> > > I'd rather call a spade a spade.
> > > 
> > >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > > or
> > >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > > 
> > > The issue here is NFS export and indirection doesn't bring any benefits.
> > 
> > No, it absolutely is not.  And the whole concept of calling something
> > after the initial or main use is a recipe for a mess.
> 
> We are calling it for it's only use.  If there was ever another use, we
> could change the name if that made sense.  It is not a public name, it
> is easy to change.
> 
> > 
> > Pick a name that conveys what the flag is about, and document those
> > semantics well.  This flag is about the fact that for a given file,
> > as long as that file exists in the file system the handle is stable.
> > Both stable and persistent are suitable for that, nfs is everything
> > but.
> 
> My understanding is that kernfs would not get the flag.
> kernfs filehandles do not change as long as the file exist.
> But this is not sufficient for the files to be usefully exported.
> 
> I suspect kernfs does re-use filehandles relatively soon after the
> file/object has been destroyed.  Maybe that is the real problem here:
> filehandle reuse, not filehandle stability.
> 
> Jeff: could you please give details (and preserve them in future cover
> letters) of which filesystems are known to have problems and what
> exactly those problems are?
> 
> > 
> > Remember nfs also support volatile file handles, and other applications
> > might rely on this (I know of quite a few user space applications that
> > do, but they are kinda hardwired to xfs anyway).
> 
> The NFS protocol supports volatile file handles.  knfsd does not.
> So maybe
>   EXPORT_OP_NOT_NFSD_COMPATIBLE
> might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> (I prefer opt-out rather than opt-in because nfsd export was the
> original purpose of export_operations, but it isn't something
> I would fight for)

I prefer one of the variants you proposed here but I don't particularly
care. It's not a hill worth dying on. So if Christoph insists on the
other name then I say let's just go with it.

