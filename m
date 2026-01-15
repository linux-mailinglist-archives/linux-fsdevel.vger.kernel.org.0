Return-Path: <linux-fsdevel+bounces-73896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D01D230CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A28230A5EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2C032C316;
	Thu, 15 Jan 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnbS2cfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6F32E134;
	Thu, 15 Jan 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464870; cv=none; b=U4uo60VnFDlttVWI9FeXf9xzRZbrtcI+grKkq8roM5NHoaAqiDCbJxjroTYInCe2PfhFsYvxY7yjxsokwH/ox6kwID5Xt77XHlhfpNPwH4bhGwILJ5qyuXOdp8BdtrHQpQKpMwTEnfO2iRO+qrt4v2B1/Om44agLu6N/orvPK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464870; c=relaxed/simple;
	bh=WiSNn2zvCUvnX3icYjakRozNqyZdq45DKgsu3cHWUEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4j/uXGH3nwNMIXlqD9kkMpZVF/3ykmtwetPzdL5/fO4QC6sGmSXUkd0Jb5Q2zI0cwobLLokcifl8/nOipG1s0jCJOHVB/2AH/p7qFgg1qqN6dN9wPkknVbgiWbY5tiZdui3KmlVyJZpLU7Rs5ez7gLtcY+G/4yk4tKD7jgNV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnbS2cfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64986C116D0;
	Thu, 15 Jan 2026 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768464870;
	bh=WiSNn2zvCUvnX3icYjakRozNqyZdq45DKgsu3cHWUEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnbS2cfpntTwX4GFJAoawDW2AeA5ZSsT+/PONrd75H6dIfGkNvM5vgeSHaOAPv8dM
	 FrUnVk8caQ2ZgKDdkW59pGpZdLQn5pXMBsCnewkG8ZRPBAs5NmgswKQgR2jlXOGTLH
	 1XC97DnUwAHpyZvcxc/R/9ANrCDd89hPll0MVVz035TWRgfHi07Ohy3FXm8Oi6cHMd
	 K1B5BtZtQ3crjd06l/WXb42A7DNOvPmKTEyhkbAB9zRLk0VcQ62qYkO65llb6ehby+
	 4dGtOQAqLPZ8prbPHH4nyrrHNN5EkPlne7JgZK52gq0fyn0vzFLiAfA69H2k4JHDn4
	 iObH+Pt4IvcIg==
Date: Thu, 15 Jan 2026 09:14:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <20260115-inspektion-kochbuch-505d8f94829e@brauner>
References: <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org>
 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org>
 <20260114-klarstellen-blamieren-0b7d40182800@brauner>
 <aWiMaMwI6nYGX9Bq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWiMaMwI6nYGX9Bq@infradead.org>

On Wed, Jan 14, 2026 at 10:42:48PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 04:20:13PM +0100, Christian Brauner wrote:
> > > You're still think of it the wrong way.  If we do have file systems
> > > that break the original exportfs semantics we need to fix that, and
> > > something like a "stable handles" flag will work well for that.  But
> > > a totally arbitrary "is exportable" flag is total nonsense.
> > 
> > File handles can legitimately be conceptualized independently of
> > exporting a filesystem. If we wanted to tear those concepts apart
> > implementation wise we could.
> > 
> > It is complete nonsense to expect the kernel to support exporting any
> > arbitrary internal filesystem or to not support file handles at all.
> 
> You are going even further down the path of entirely missing the point
> (or the two points by now).

You're arguing for the sake of arguing imho. You're getting exactly what
we're all saying as evidenced by the last paragraph in your mail: it is
entirely what this whole thing is about.

> If a file systems meets all technical requirements of being nfsd
> exportable and the users asks for it, it is not our job to make an
> arbitrary policy decision to say no.

This is an entirely irrelevant point because we're talking about
cgroupfs, nsfs, and pidfs. And they don't meet this criteria. cgroupfs
is a _local resource management filesystem_ why would we ever want to
support exporting it over the network. It allows to break the local
delegation model as I've explained. cgroupfs shows _local processes_. So
a server will see completely nonsensical PID identifiers listed in
cgroup files and it can fsck around with processes in a remote system.
Hard NAK. Entirely irrelevant if that filesystem meets the theoretical
standards.

> If it does not meet the technical requirements it obviously should
> not be exportable.  And it seems like the spread of file handles
> beyond nfs exporting created some ambiguity here, which we need to
> fix.

We are all in agreement here.

