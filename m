Return-Path: <linux-fsdevel+bounces-79445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFqLEMWyqGlSwgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 23:31:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB75208A28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 23:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82AC1302AD2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4939B94B;
	Wed,  4 Mar 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7E6g6Lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8A395D8F;
	Wed,  4 Mar 2026 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663389; cv=none; b=QqgqmjN/e3bj1WHaBPQekVIiNecpFWy3PziFWy9e1nZmhe233blDyeU4e3sh82XKIK8JohEERxWWPd+4KRzUXh5e9x3V53FaCOm+Fp+xvQSfkvKWxawbmRfS1GvnM+bFZ7me1pw2zL8ujBpYy8pJltX9V64H+YlmyEAL9xX30qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663389; c=relaxed/simple;
	bh=4g9Hc6BCi1UzcQ6UmFUsAKXtEqFK6/wIIRnu62xorDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjZvILiPgwssanEB8Z/tZ9zpOIqjohBnm5YKJ4Nv/BRkKxTdrLDqc9Pf5OB2aIrG8xLLR/Debd/yB/e9euQqS6ompmJrSe0JDIU7e3Le6+6mONOuEaceWfcF0AoD2jbllCuD3CtUVxkbm2S1U9lLI85Tv5WGnulXuUApC3o/TXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7E6g6Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E566C4CEF7;
	Wed,  4 Mar 2026 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663388;
	bh=4g9Hc6BCi1UzcQ6UmFUsAKXtEqFK6/wIIRnu62xorDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7E6g6Lm08bdby4/2tHEolh5uuAfzAVSsM3yLpncdqLzpMpx2R/jiaVVx3BrpUlHV
	 zLgQZLl3q+J8YOTxOWa4cFn0qM9qtzHl3urpYxu/J8dk/Ng4eTR5ve5/MwMG2EM0x4
	 13hRsUgqaHxQn1bDCNJafYTopHM59GSiSSfWDaMrsTRgNMP0a8wibVOr0aBrw1II97
	 INDpQBDBhw/6g/ZfJeCr4GjGF8S8trfaYHGCsvv3rBpIoZHp4hfWrZiyJa1NX9T5Ya
	 lxm3zNjb7ZsIhtDD0mqurpzxaf9es4FePOHSAnjX78l7+ajL920pZ2wjsA901PjGJl
	 9YO9TEkdx8L9Q==
Date: Wed, 4 Mar 2026 17:29:46 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Anders Larsen <al@alarsen.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH 24/24] fs: remove simple_nosetlease()
Message-ID: <aaiyWlJelhHju741@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-24-ea4dec9b67fa@kernel.org>
 <aZ84VRrRVyGEzSJn@kernel.org>
 <e07e9b893ca04ce6ead4790e72c7f285a7159070.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07e9b893ca04ce6ead4790e72c7f285a7159070.camel@kernel.org>
X-Rspamd-Queue-Id: BEB75208A28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,vger.kernel.org,lists.ozlabs.org,lists.sourceforge.net,lists.infradead.org,lists.linux.dev,lists.orangefs.org,kvack.org,lists.samba.org];
	TAGGED_FROM(0.00)[bounces-79445-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[86];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:59:32AM -0500, Jeff Layton wrote:
> On Wed, 2026-02-25 at 12:58 -0500, Mike Snitzer wrote:
> > On Thu, Jan 08, 2026 at 12:13:19PM -0500, Jeff Layton wrote:
> > > Setting ->setlease() to a NULL pointer now has the same effect as
> > > setting it to simple_nosetlease(). Remove all of the setlease
> > > file_operations that are set to simple_nosetlease, and the function
> > > itself.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/9p/vfs_dir.c        |  2 --
> > >  fs/9p/vfs_file.c       |  2 --
> > >  fs/ceph/dir.c          |  2 --
> > >  fs/ceph/file.c         |  1 -
> > >  fs/fuse/dir.c          |  1 -
> > >  fs/gfs2/file.c         |  2 --
> > >  fs/libfs.c             | 18 ------------------
> > >  fs/nfs/dir.c           |  1 -
> > >  fs/nfs/file.c          |  1 -
> > >  fs/smb/client/cifsfs.c |  1 -
> > >  fs/vboxsf/dir.c        |  1 -
> > >  fs/vboxsf/file.c       |  1 -
> > >  include/linux/fs.h     |  1 -
> > >  13 files changed, 34 deletions(-)
> > > 
> > 
> > <snip>
> > 
> > > diff --git a/fs/libfs.c b/fs/libfs.c
> > > index 697c6d5fc12786c036f0086886297fb5cd52ae00..f1860dff86f2703266beecf31e9d2667af7a9684 100644
> > > --- a/fs/libfs.c
> > > +++ b/fs/libfs.c
> > > @@ -1699,24 +1699,6 @@ struct inode *alloc_anon_inode(struct super_block *s)
> > >  }
> > >  EXPORT_SYMBOL(alloc_anon_inode);
> > >  
> > > -/**
> > > - * simple_nosetlease - generic helper for prohibiting leases
> > > - * @filp: file pointer
> > > - * @arg: type of lease to obtain
> > > - * @flp: new lease supplied for insertion
> > > - * @priv: private data for lm_setup operation
> > > - *
> > > - * Generic helper for filesystems that do not wish to allow leases to be set.
> > > - * All arguments are ignored and it just returns -EINVAL.
> > > - */
> > > -int
> > > -simple_nosetlease(struct file *filp, int arg, struct file_lease **flp,
> > > -		  void **priv)
> > > -{
> > > -	return -EINVAL;
> > > -}
> > > -EXPORT_SYMBOL(simple_nosetlease);
> > > -
> > >  /**
> > >   * simple_get_link - generic helper to get the target of "fast" symlinks
> > >   * @dentry: not used here
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index 71df279febf797880ded19e45528c3df4cea2dde..23a78a742b619dea8b76ddf28f4f59a1c8a015e2 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -66,7 +66,6 @@ const struct file_operations nfs_dir_operations = {
> > >  	.open		= nfs_opendir,
> > >  	.release	= nfs_closedir,
> > >  	.fsync		= nfs_fsync_dir,
> > > -	.setlease	= simple_nosetlease,
> > >  };
> > >  
> > >  const struct address_space_operations nfs_dir_aops = {
> > > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > > index d020aab40c64ebda30d130b6acee1b9194621457..9d269561961825f88529551b0f0287920960ac62 100644
> > > --- a/fs/nfs/file.c
> > > +++ b/fs/nfs/file.c
> > > @@ -962,7 +962,6 @@ const struct file_operations nfs_file_operations = {
> > >  	.splice_read	= nfs_file_splice_read,
> > >  	.splice_write	= iter_file_splice_write,
> > >  	.check_flags	= nfs_check_flags,
> > > -	.setlease	= simple_nosetlease,
> > >  	.fop_flags	= FOP_DONTCACHE,
> > >  };
> > >  EXPORT_SYMBOL_GPL(nfs_file_operations);
> > 
> > Hey Jeff,
> > 
> > I've noticed an NFS reexport regression in v6.19 and now v7.0-rc1
> > (similar but different due to your series that requires opt-in via
> > .setlease).
> > 
> > Bisect first pointed out this commit:
> > 10dcd5110678 nfs: properly disallow delegation requests on directories
> > 
> > And now with v7.0-rc1 its the fact that NFS doesn't provide .setlease
> > so lstat() on parent dir (of file that I touch) gets -EINVAL.
> > 
> > So its a confluence of NFS's dir delegations and your setlease changes.
> > 
> > If I reexport NFSv4.2 filesystem in terms of NFSv4.1, the regression
> > is seen by doing (lstat reproducer that gemini spit out for me is
> > attached):
> > 
> > $ touch /mnt/share41/test
> > $ strace ./lstat /mnt/share41
> > ...
> > lstat("/mnt/share41", 0x7ffec0d79920)   = -1 EINVAL (Invalid argument)
> > 
> > If I immediately re-run it works:
> > ...
> > lstat("/mnt/share41", {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
> > 
> > I'm not sure what the proper fix is yet, but I feel like you've missed
> > that NFS itself can be (re)exported?
> > 
> > 
> 
> My apologies. I missed seeing this last week.
> 
> That's a very simple reproducer! That's very strange behavior,
> especially since NFS4 does provide a setlease operation:
> 
> const struct file_operations nfs4_file_operations = {
> 	[...]
> 	.setlease       = nfs4_setlease,
> 	[...]
> };

Huh, not sure how I missed nfs4_setlease...

> I'm not sure why this would cause lstat() to return -EINVAL.

Likewise, especially given nfs4_setlease

> What's happening on the wire when this occurs?
> 
> I'll plan to take a look here soon either way.

I'll have to revisit myself, been a bit.

Will let you know.

Thanks,
Mike

