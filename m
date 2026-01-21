Return-Path: <linux-fsdevel+bounces-74828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPc9LgKkcGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:01:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860B54D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A061B600E6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEAC481229;
	Wed, 21 Jan 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nZgTFNzu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B64480DE3;
	Wed, 21 Jan 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988941; cv=none; b=kKcJsOB8aLJDqrwPQj3DG34i9q8iOCz3y0T0aKgQKcpbviVSwKg4MFUO3noKmFDP2VsaeYl6VjPEYb0XVpZAURTEU2cID6AV0cpSSMK2QMXE3Ox8KkHCVRBiz6YneNulQmf3IFkmRQl+3GAnnP7Hc0v4Lqs2gHMu0fN9yfrGc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988941; c=relaxed/simple;
	bh=2txRYPj1zjlXuHZLLc6Ds/5qBjyYqZpQlWvGoUs8Ids=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU2Mg/G5LgzZF6wS51pSZ2fyL4A94MhZH5t0lRX/SrWZDHuVAQGM2IMErNPNVdfbQ+zLKaKVjuPYjP2/IYmADvdBF4S1/KfxK6UDf0MquNgcS4k9mKdNrjk1qXGimYAtcjpWvPnXVnRENzbMmSyu7vSVPKj+1FK21WbkF2F0HEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nZgTFNzu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RwuG4Zh8xzi3XsfiX+hfl4eOhPi+sTrKAwirdvzvU78=; b=nZgTFNzu14yUnMagBymm1SVNaE
	0iI2+v0tg8mrJftjxuiLasZhfk9iatzt6SV3zcWbej4U221rInInSi+IHEz/gS/qBm9sRHcJyamaY
	2iVgOPW0H3w/vq4ErMxFUpMgqMdpr99bvrrbEx1zBJxf6Oqd1tds0vHyOzdQuLPKc5V+mIOIAqEl1
	w6H+15/ZlqHoAqJ9oz6poJ5+1SXpK3oiRj9woVMFWFqnIBi9cp3UcnQlhY2ZC1n18yBMINnNb27r3
	TUQ/4lNxikcW3bhV7aDAFg1yrx2W+1KDhA9xNOfeEs+KGiyy3rKt15Wi5bHrUF/HESTAyVVaZu416
	HhHRjLFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viUpM-00000005D5S-1Xs6;
	Wed, 21 Jan 2026 09:48:40 +0000
Date: Wed, 21 Jan 2026 01:48:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
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
Message-ID: <aXCg-MqXH0E6IuwS@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org>
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>
 <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <aW8w2SRyFnmA2uqk@infradead.org>
 <176890126683.16766.5241619788613840985@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176890126683.16766.5241619788613840985@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74828-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 6860B54D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:27:46PM +1100, NeilBrown wrote:
> > If you think NFS actually explains the semantics pretty well, please
> > explain that too, especially in forms that can be put into
> > documentation, including for the user ABI.
> 
> There are multiple issues here:
> 
>  - filehandle stability.  As far as I know all filesystems provide
>    stable filehandles when the "subtree_check" export option is not used.

That is news to me, but certainly interesting.  Does this include not
reusing the file handle for a new incarnation of the same thing?

>    Certainly cgroupfs does.  So having an EXPORT_OP_STABLE_HANDLES
>    flag would mean it was set for every filesystem - unless there is
>    something else I'm not aware of.  That is certainly possible and I
>    hope someone will let me know if I'm missing something.

Well, if does not provide stable file handles with the subtree_check
export option, or more importantly with the CONNECTABLE flag passed
to encode_fh, which is the level we're operating on, it can't set the
flag.

>  - filehandle uniqueness.  This is somewhat important and if a
>    filesystem doesn't provide it, that should be considered a bug.  In a
>    different thread Christian has observed that there would be benefit
>    if pidfs and nsfs provided uniqueness across reboots.  It is quite
>    easy for a virtual filesystem to generate a 64 bit random number when
>    the fs is initialised, and include that in file handles.  Having a
>    EXPORT_OP_REUSES_HANDLES flag could mark filesystems that are still
>    buggy if that is thought to be useful.

Yes.

>  - GETATTR always reporting file size of 0.  This is the only concrete
>    symptom that Jeff has reported (that I have seen).  This  makes it
>    impossible to read files over NFS even if they have content.
>    Would EXPORT_OP_INACCURATE_SIZE be useful?

i_size = 0 for a regular file sounds like a genuine bug to me.  I'm
actually surprised anything works with that.

>  - maintainer feature choice.  A maintainer may choose not to support
>    export over NFS because they feel that there is no value and the
>    possible support burden would not be worth it.

The maintainer has no way to disallow exporting through nfs.  They can
at best disallow exporting using the kernel nfs daemon if we provide
that facility.  But as I've argued multiple times, making arbitrary,
selective and very narrow choices about use cases without technical
backing for them (which then would be expressable as a flag like those
listed by you above) is really bad software development practice, and
not something that we usually do in the Linux kernel.

>    There may be locking
>    / lease / etc issues that further complicate things.  So it might be
>    reasonable for a maintainer to choose to forbid NFS export while
>    allowing local fhandle access. EXPORT_OP_NO_NFS_EXPORT.

We already have a EXPORT_OP_NOLOCKS flag to deal with this.

> 
> It took me a while to sift through the code/patches/comments and come to
> this understanding and I apologise if I wasn't as clear earlier.  But
> my intuition was always that file handle stability was never the real
> issue, and maintainer choice was.  Hence my rejection of the
> "STABLE_HANDLES" name.

Why do you keep ignoring the fat that the stable handles are really
important for anyone wanting to actually use them for their original
storage purpose, be that for knfsd, a userland nfs damon, or other
storage applications in userspace despite explaining this countless
times?


