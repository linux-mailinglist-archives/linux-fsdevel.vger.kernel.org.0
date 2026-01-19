Return-Path: <linux-fsdevel+bounces-74381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E929D39FA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA74E303C294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99ED2F12D4;
	Mon, 19 Jan 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="irDVjFha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8ltski0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8482EBDEB;
	Mon, 19 Jan 2026 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807391; cv=none; b=XLSlo6YMZ4i3qO7X2lUXloV1iQFGZaWLIO69dkn6LfbzqLdROthEwTV8i68pRKpgzhFkZzb/rrew7vJfjRsC2Sym4VbgWPTB3yEjdfDDU1aBS3GUNsQIhqNl8rtdO8VpSCXXMUqFbbZKSFSUNE6lF+84zW07fAQAQ+HbAzkBtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807391; c=relaxed/simple;
	bh=VayQ8LBQ8ITb7zXH2IltJZOWK/FYKB5M0T/fJMZxG+g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZFwIAdTaD2X9aMDAwz8mGJdbkcYlnepbnI/qyQ2mGbM11ljQO/nioz6vbWjBhdst5YXZzdH3hi+cAYBIe4qWSMZn+Rp5uG3k0hLOfwH0Aamp1nuj5qAE8U/5l5PgPWsj4BkeZYQcL/RQGUhTflFON6r7H48VDLVb9DiYglVc6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=irDVjFha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8ltski0; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 3219E130103E;
	Mon, 19 Jan 2026 02:23:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Jan 2026 02:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768807386; x=1768814586; bh=l0q9OiSiL57A1oXpVwou+Qazcwu9lF8/fKQ
	yDTZuHuY=; b=irDVjFhaz/K8YtiXzQ31MDOgMGCo+Gz//EwM4OijAM0vOKynyB6
	BpwYFZYCEe3o7Gx5L4V6M4FhbipwQNJV0ujCSLBSc5IHezW/FyB/LWZraYVlaMJu
	YnnpUl4JgVLbrNIec+WcKPTR09keVUJuKuo5IR+gQesu/p0p7PhQm/pf+9OgvKR5
	WdaCaILT5Zm8fqMcKW/PAdv1HxPiIM+Z3QX4jypg1fiENCArP/M8KaRMfJ7uYtgT
	cBjjHOj9Mr9wPQirkQS2BYF8pjwZRelVojFvJtbhrJ5l9QZPmQNMkhdcWIaHKOt+
	ltoa8OTg2UGC53H+WAMXgf82R3jVtEKBVww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768807386; x=
	1768814586; bh=l0q9OiSiL57A1oXpVwou+Qazcwu9lF8/fKQyDTZuHuY=; b=K
	8ltski0YBtBzy6uowaabbff8s5zuRDbtUFWXcDtg931MBwRc16+CKDMRYekaXZHk
	LOnd7mQjODx3F7HVmyPZWvLOv8yjti4w+MIAbxpLRgNDP65uPFl9Gfl058RUJHH+
	Fk6+cJVTq4wuDdMq1Z5W9k1ZuC7iRuYcXx1GwUdvxisFOcHq/jX6VpQCI2oyR0CU
	ZM3JKGGiUVRS4Nbh4KzQMT/wi9djnt+fqIQkRVTwyAKauSyNTqZZcQHWI735MH16
	4XBGsVULicKWqCSMDT9bs+x+/xy/Gu1Q6khze7NDCvAP+QvrXTWLwqj3Y9LKIzDB
	XZKhCr7irnaORckcnoZBQ==
X-ME-Sender: <xms:1tttaQEL1zY-cqjAi3LwisLLYig4vGmVFZGnEWqvFdfPu_1cBx4ryQ>
    <xme:1tttadNPXJyKg4i6N7NiajEYCS_ixBqVWnODY0xDbeIYm-0ddIGPmXX4nPobqTrUH
    FdEox9n77yL1V53kkmfQXZnVrRbAt8y41xmdzHA26xbb4UiNw>
X-ME-Received: <xmr:1tttaX2pXmbQvkTPzq0NQg4Hf4lyVdk2Kt7K2P2YoY0rgkMkSP0qEY7AWJnIFHDorFcLBSqfoL6DkzzzXRH8ujZGIJqMnM5xQhHy1RkjUWf6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1tttabHi5RQs76Xz74nOwWrYIZ47zQ7Zj71gIm-NgtkzokJPtBcMHA>
    <xmx:1tttafzYjiWXRjDGlVz6_k-3h2GeOsbL3CzwIMyCt37eR3PuktBG4w>
    <xmx:1tttaaofGHLgl2z91oIIPm_yXGWHUeCGCqWi64kkrnWVR5nBeLXySA>
    <xmx:1tttaUlKdw4URdR2-6lB_1IM56jb7LL9_P5nu35Q0sPULNdt9mAF_A>
    <xmx:2tttacnPYyzS2rQik0c4UgQtzVVe9-q502rX9-wmNn1taRjPmfmDMIhi>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 02:22:45 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp" <shaggy@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
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
In-reply-to: <aW3SAKIr_QsnEE5Q@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>
Date: Mon, 19 Jan 2026 18:22:42 +1100
Message-id: <176880736225.16766.4203157325432990313@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > This was Chuck's suggested name. His point was that STABLE means that
> > > the FH's don't change during the lifetime of the file.
> > > 
> > > I don't much care about the flag name, so if everyone likes PERSISTENT
> > > better I'll roll with that.
> > 
> > I don't like PERSISTENT.
> > I'd rather call a spade a spade.
> > 
> >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > or
> >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > 
> > The issue here is NFS export and indirection doesn't bring any benefits.
> 
> No, it absolutely is not.  And the whole concept of calling something
> after the initial or main use is a recipe for a mess.

We are calling it for it's only use.  If there was ever another use, we
could change the name if that made sense.  It is not a public name, it
is easy to change.

> 
> Pick a name that conveys what the flag is about, and document those
> semantics well.  This flag is about the fact that for a given file,
> as long as that file exists in the file system the handle is stable.
> Both stable and persistent are suitable for that, nfs is everything
> but.

My understanding is that kernfs would not get the flag.
kernfs filehandles do not change as long as the file exist.
But this is not sufficient for the files to be usefully exported.

I suspect kernfs does re-use filehandles relatively soon after the
file/object has been destroyed.  Maybe that is the real problem here:
filehandle reuse, not filehandle stability.

Jeff: could you please give details (and preserve them in future cover
letters) of which filesystems are known to have problems and what
exactly those problems are?

> 
> Remember nfs also support volatile file handles, and other applications
> might rely on this (I know of quite a few user space applications that
> do, but they are kinda hardwired to xfs anyway).

The NFS protocol supports volatile file handles.  knfsd does not.
So maybe
  EXPORT_OP_NOT_NFSD_COMPATIBLE
might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
(I prefer opt-out rather than opt-in because nfsd export was the
original purpose of export_operations, but it isn't something
I would fight for)

NeilBrown

