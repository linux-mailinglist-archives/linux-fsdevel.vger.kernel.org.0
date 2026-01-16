Return-Path: <linux-fsdevel+bounces-74034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B2D2A139
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D83E3047102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588EA2FBDE6;
	Fri, 16 Jan 2026 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="P9kfgKNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74833507D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530205; cv=none; b=DpotScfIsNKlqLhvrBUMzc/8fObxUxxyaWuFZpuNezZrvSoFVvnYBAWgPSJb+bJc+OcpCAHDInsevEuBvFvHn5vHgGAHbeJ3Bwb2E690r3Lbiq+SqX1bWvfEM8ufHdeju8lfmLTZhEKReiffOBVR7BMlYW6erjtcZFP/3TXOpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530205; c=relaxed/simple;
	bh=AU8ydwM+6bS6tN4tu5gRNYM3pm8mBvS0h3zIXbblp64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhB0ldp4YgazfNpS0uwQAHiXxPy9NioggkbtZYGfp9Uc0yxq9+0HNFHGblsRpD9UP75RKe6kUOiGBjJgREJUAdARRL083WizvPZaV8gG4fPaGzfqmj/hp8jtTkgew1osaHjRQkbYnppLRt4LHGj98fAkcl/HsdPOAHRXdtRmLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=P9kfgKNL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([37.140.223.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60G2MYX0013183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 21:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768530160; bh=e7+ZkXTf+cEt8COK7ZiBm7FpEGCZkXwmsqQ2YKKQgYQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=P9kfgKNLi6OJwcPg4rVMTROJzz4az9SYBcQOe0G0GFGs82DvRENFkm1YgSb39d3nH
	 AGhnwzj1RFqcSKbZOicJ+nFpVd4Sb2TTKGetDB0RpYps8YKVTz/q1D9dChu4KGnt00
	 F9qbPF5IkyVUAG1oSvWw5yNdKLkq55GF3d6RBCC+6h/fJgObPBIkscBAmatK8OWUeA
	 44QkCvEUYHhWUMDLDRP0nKLUmo25Fvq3Y+rvJsSZxeeOfrEsRnGnjkeyk8CcAFTrP/
	 uLf9PDmtpch4C3FfLs1otcMi7C+sjxkaLMhdbOGgUfTH1zuJX6iCF3ztPn6LMn2SOi
	 LVfyZmz7mZaTA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id A12EE54D8E5B; Thu, 15 Jan 2026 17:22:03 -0900 (AKST)
Date: Thu, 15 Jan 2026 17:22:03 -0900
From: "Theodore Tso" <tytso@mit.edu>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
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
Subject: Re: [PATCH 03/29] ext4: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Message-ID: <20260116022203.GE19200@macsyma.local>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <20260115-exportfs-nfsd-v1-3-8e80160e3c0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-exportfs-nfsd-v1-3-8e80160e3c0c@kernel.org>

On Thu, Jan 15, 2026 at 12:47:34PM -0500, Jeff Layton wrote:
> Add the EXPORT_OP_STABLE_HANDLES flag to ext4 export operations to indicate
> that this filesystem can be exported via NFS.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

