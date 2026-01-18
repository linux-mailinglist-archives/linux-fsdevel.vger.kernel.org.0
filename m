Return-Path: <linux-fsdevel+bounces-74312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0094D39796
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3413011A68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4650E33C502;
	Sun, 18 Jan 2026 15:42:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58331288D6;
	Sun, 18 Jan 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750973; cv=none; b=k1z7f31q48O+MTV0oOzpLVzrCBRDQV2K6lmvWwTTVZBizTtqG80KgcEKDbuyjsgEO/idzxVOmrMgSWcyywUGiIZzqh3kzjGYx57pPkbA0SUfz2jy+x+n6LPB8pdz+KCeY5fssUO5KBlGfbVgEd4rjPDS37gY8W6pKcQCKQHhjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750973; c=relaxed/simple;
	bh=7o8IJfB7ac3jZiXayX/iEYSCvbbdHx+mVAVSDEiNdGc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LDDue4+mUwzYjUswgDOBJQGC8zcsfTsIaSQZ9JzPxmv8ldM1o0jXvyxW8oXJByJuJ9WjRH/ZO4BAgXyjRAxnTfMMruuJ9D4hyAcT1IO4BkvvcDdCNC4OULFio89jbtAiE7gmTE3rkjOjqMxzAfaW56F5/yKUShaB1PaF6HtnUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6720229ABCA;
	Sun, 18 Jan 2026 16:36:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id f1jux-Dqp4vA; Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9282529859D;
	Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HokZmavtm8SI; Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 04C202918DC;
	Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Date: Sun, 18 Jan 2026 16:36:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	chuck lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Amir Goldstein <amir73il@gmail.com>, hughd <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, tytso <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, anna <anna@kernel.org>, 
	Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-xfs <linux-xfs@vger.kernel.org>, 
	ceph-devel <ceph-devel@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-unionfs <linux-unionfs@vger.kernel.org>, 
	devel <devel@lists.orangefs.org>, 
	ocfs2-devel <ocfs2-devel@lists.linux.dev>, 
	ntfs3 <ntfs3@lists.linux.dev>, 
	linux-nilfs <linux-nilfs@vger.kernel.org>, 
	jfs-discussion <jfs-discussion@lists.sourceforge.net>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <2119146172.135240.1768750563673.JavaMail.zimbra@nod.at>
In-Reply-To: <20260115-exportfs-nfsd-v1-23-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-23-8e80160e3c0c@kernel.org>
Subject: Re: [PATCH 23/29] jffs2: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
Thread-Index: pUsbo+Kg1d9ytlyubsob1wi+Ql8B0A==

----- Urspr=C3=BCngliche Mail -----
> Add the EXPORT_OP_STABLE_HANDLES flag to jffs2 export operations to indic=
ate
> that this filesystem can be exported via NFS.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/jffs2/super.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

