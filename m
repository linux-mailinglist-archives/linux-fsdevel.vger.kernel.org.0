Return-Path: <linux-fsdevel+bounces-73017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57FD07F43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 09:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6BA30471A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C74352927;
	Fri,  9 Jan 2026 08:48:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E806345CC8;
	Fri,  9 Jan 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948532; cv=none; b=UC7Z+q/taTmI3Dw4zEOfjsJNvN6iKiv9j2ncfaOiD/w0aSHpQgK0VASP7fnC8CgxNezaDpDdESZoVxhXTB59b6Ql9ZCxvwk9hRacir2/jzDyImrnlRzue7Dc/05SKmJIImUthN5ACHHcDDhehlqx1f5f7TeOUdNzzi1tcuQQ6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948532; c=relaxed/simple;
	bh=4QaFFR8yQNvWu6hmP5ORiJ3JrOB69XBlmV1Bh4uLptA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RTI6RDpj0d+48UigpR4L7Z68j4x8dcY/3/UmOjCb39M8+iGq8Y04CbnU/pX8QXT0fOgx6c1AIKMPCgNadqBjmILXD9ASZVPETKpoc7YgGkAD1ZFxHwVOjO3qoV3qmY2WsLwZ7NyY2D8cFsv5cI/JQwzTn5sRIMfWnK2R9njvX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6A19D29ABCA;
	Fri,  9 Jan 2026 09:48:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Q5my43uhi71j; Fri,  9 Jan 2026 09:48:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D0BC029859E;
	Fri,  9 Jan 2026 09:48:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ys-NzouVpSJW; Fri,  9 Jan 2026 09:48:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 30C7B29859D;
	Fri,  9 Jan 2026 09:48:45 +0100 (CET)
Date: Fri, 9 Jan 2026 09:48:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, 
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Jan Kara <jack@suse.com>, tytso <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, 
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
	Carlos Maiolino <cem@kernel.org>, hughd <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, 
	chuck lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, 
	Matthew Wilcox <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, anna <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	jfs-discussion <jfs-discussion@lists.sourceforge.net>, 
	linux-nilfs <linux-nilfs@vger.kernel.org>, 
	ntfs3 <ntfs3@lists.linux.dev>, 
	ocfs2-devel <ocfs2-devel@lists.linux.dev>, 
	devel <devel@lists.orangefs.org>, 
	linux-unionfs <linux-unionfs@vger.kernel.org>, 
	linux-xfs <linux-xfs@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	v9fs <v9fs@lists.linux.dev>, ceph-devel <ceph-devel@vger.kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>
Message-ID: <393733638.88534.1767948525135.JavaMail.zimbra@nod.at>
In-Reply-To: <218403128.88322.1767944438487.JavaMail.zimbra@nod.at>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-12-ea4dec9b67fa@kernel.org> <218403128.88322.1767944438487.JavaMail.zimbra@nod.at>
Subject: Re: [PATCH 12/24] jfs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: add setlease file operation
Thread-Index: Ijb4veyM6wDb0tIeqxd8skdz5qkIYBNsmijj

----- Urspr=C3=BCngliche Mail -----
> Von: "richard" <richard@nod.at>
>> ---
>> fs/jfs/file.c  | 2 ++
>> fs/jfs/namei.c | 2 ++
>> 2 files changed, 4 insertions(+)
>=20
> Acked-by: Richard Weinberger <richard@nod.at>

Whoops! I meant to reply to the jffs2 patch...

Thanks,
//richard

