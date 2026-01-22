Return-Path: <linux-fsdevel+bounces-75126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCyDEPdhcmnfjQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:44:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F26B939
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F027308F30E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8913C089D;
	Thu, 22 Jan 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueyMX6oh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DEA388865;
	Thu, 22 Jan 2026 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101466; cv=none; b=gzMx3E9VlNbklcMA9+TngKjO3iC5a3g8N9NV5cs+c082uujyO6neORQsXZ/M6gwDM6HE3UChe9zrmsndEzMmKhbdimTtj106q1ch51DAsprOq+zEcktiigZeCsIY/DA9ZIdt3FEWnFd9bf1DS3T7qYJqLvcUWowroz3RaTgjAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101466; c=relaxed/simple;
	bh=xwFz5Oidq8APQpCp7THEtDpXn9O+NGssd7GC7NPkIXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFd81ztX/t49f9WbggLODfYibK4UuxdagtWRVgepi0CORcdhQyPbxj1wVP597ET6tXVYLH+0Xag7OV8RoYkIhSvlUPus3QKFAmU6/uxFLZ5xeHaLEKZSoAOxYgHLdOy3NWeZ3sQCx32Hirs26iPlO8SAQWagU6jADTn5v6SJrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueyMX6oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156DAC116C6;
	Thu, 22 Jan 2026 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101464;
	bh=xwFz5Oidq8APQpCp7THEtDpXn9O+NGssd7GC7NPkIXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueyMX6ohlT+V7E4FTnwyr+bckr2XgM0otlsgh+U8+RB7dufNou2jXtRF8/4HiLX1h
	 aiyHG+xAbRXlOpSKYNl+YW1B6es8lJGWyDpCT3G89X8Bn++QSMPHsovt5BRyWj7Z84
	 MiFPflUjkr2UeHtVIt004pQ2LHYESJ6jR9ib6bF3tKB5BvchCfBJcHtl2H7eGV6Hj+
	 XeQh59i2mPbJ0Z07CURTocG8MzgcrhLB0YpqMQ2BX+Q2rUwcSwiRIRCTHIiyBghAen
	 fRki137MnL3p5j+2P7Cc4giyKdLsB0k8xoBASjwbPFk1rE23p0Kg5qRxi8CJQxSLFn
	 VC/vMBqCcUNNQ==
Date: Thu, 22 Jan 2026 09:04:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
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
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
	gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <20260122170423.GU5945@frogsfrogsfrogs>
References: <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <aW8w2SRyFnmA2uqk@infradead.org>
 <176890126683.16766.5241619788613840985@noble.neil.brown.name>
 <aXCg-MqXH0E6IuwS@infradead.org>
 <176899164457.16766.16099772451425825775@noble.neil.brown.name>
 <364d2fd98af52a2e2c32ca286decbdc1fe1c80d3.camel@kernel.org>
 <aXDm8FPPOHs04w9m@infradead.org>
 <3210d04fa2c0b1f4312d10506cac30586cb49a3c.camel@kernel.org>
 <aXHFlF1tef68i2HU@infradead.org>
 <b491335d12e976e1ea1c07b9c14164ac69d22aea.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b491335d12e976e1ea1c07b9c14164ac69d22aea.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75126-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,brown.name,kernel.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E89F26B939
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 07:12:36AM -0500, Jeff Layton wrote:
> On Wed, 2026-01-21 at 22:37 -0800, Christoph Hellwig wrote:
> > On Wed, Jan 21, 2026 at 10:18:00AM -0500, Jeff Layton wrote:
> > > > fat seems to be an exception as far as the 'real' file systems go.
> > > > And it did sound to me like some of the synthetic ones had similar
> > > > issues.
> > > > 
> > > 
> > > Not sure what we can do about FAT without changing the filehandle
> > > format in some fashion. The export ops just use
> > > generic_encode_ino32_fh, and FAT doesn't have stable inode numbers.
> > > The "nostale" ops seem sane enough but it looks like they only work
> > > with the fs in r/o mode.
> > 
> > Yeah.  I guess we need to ignore this because of <history>
> > 
> 
> Yep. This is a case where the handles are not PERSISTENT but I don't
> think we can get away with making FAT unexportable. We're probably
> stuck with it.
> 
> > > > I think Amirs patch would take care of that.  Although userland nfs
> > > > servers or other storage applications using the handle syscalls would
> > > > still see them.  Then again fixing the problem that some handles
> > > > did not fulfill the long standing (but not documented well enough)
> > > > semantics probably is a good fix on it's own.
> > > 
> > > Agreed. We should try to ensure uniqueness and persistence in all
> > > filehandles both for nfsd and userland applications.
> > 
> > Sounds good to me.
> 
> 
> Unfortunately, there are already exceptions. Apparently pidfs and
> cgroupfs handles (at least) can't be extended because of userspace
> expectations:
> 
> https://lore.kernel.org/linux-nfs/20260120-irrelevant-zeilen-b3c40a8e6c30@brauner/

systemd cracking file handles??  Yeesh, I thought userspace was supposed
to treat a file handle as an opaque N-byte blob and nothing more, and
only certain "special" tools (e.g. xfsprogs on XFS) could do more than
that.

--D

> My personal take is that we should try to make handle uniqueness a goal
> for most existing filesystems, but we're going to have some that can't
> achieve that. For them we probably want to be able to flag them so they
> can be id'ed by userland.
> 
> So, we will need an export_operations flag of some sort
> (EXPORT_OP_UNIQUE_HANDLES?). At that point, we'll have to decide
> whether to deny nfsd export based on that flag:
> 
> We could deny export of any fs that doesn't set the flag, but NFSv4
> actually allows the server to advertise that it can't guarantee handle
> uniqueness. There isn't much guidance for the client on how to handle
> that though and the attribute seems to have the scope of the entire NFS
> server.
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

