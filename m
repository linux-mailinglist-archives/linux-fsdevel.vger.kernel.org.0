Return-Path: <linux-fsdevel+bounces-74869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDJxNegEcWmgbAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:55:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C05A2EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EB357803B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D824BCABC;
	Wed, 21 Jan 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lyoZtqRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2754B8DFE;
	Wed, 21 Jan 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006872; cv=none; b=emF9fh9C1aT6cv3iQ/fV/KpD00HJ7/kbxWdt4kZuoTQZFNkwXba22ViduisMtF1ttOZiFOPNezJFvbVKjcaohv5Lba4DMPqdFkoNrSe6+fOKonQqK9YIIoh7+zh3tOHfdjXuTgtPPSig7QZsinMHwgmJvIFUpCEtsF7S4Xa3C4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006872; c=relaxed/simple;
	bh=+nj0RQCD2JV8ao7C4ZSJ4j28cwei4e9FrFXvsWNw804=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ/nrfHrQx3cBcmFETcmg8MQAHPsBZLrCWfRmMCcfMQ8Rp/UyKwvicFUxKaD7RgpSu2ZA0WZVjMcADnsCXcMSErZneMvet6tHkX3esuL9WdZOaHS+6FDSf7kL/bqmM/g2jvPjJ+300gZCipqaKcjmC3t7to5HJT2tu/LPuurIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lyoZtqRM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=edtMn02AVod+IBbJIVsMu3fhJTzD4OTVoerhqOtkeWk=; b=lyoZtqRMQf0KSh1E6771IlhF4T
	RrLjV0QALpxuAPKkekpZyZQzp1pko+bePRoZZJZ8ieyVV9svFucFsTJJihcCgY79/+Ga4AHQJAc9s
	0HjxA2m6YspkhDbzNJ8FksqryID1wx0o/FHYrZbeQAZmuJVCMo088yeeWEO0vm0Tt9I/3s7710GOE
	h1vZyqOcZojbUC8ClviRx150cBwXx7bgs0Stvn7e/Y74KTKUQD3jGgHsXsJfr8QvEdBTO4/qnlaWf
	rvTpv2se5FecitDGJbn+/YyKGUb7cbrew+LBJmByxqOXDXj2JzWyvd5zyQm4Qr4kt6qFg51hdkrIL
	K1f5k5Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viZUG-00000005dMj-1Wd9;
	Wed, 21 Jan 2026 14:47:12 +0000
Date: Wed, 21 Jan 2026 06:47:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <aXDm8FPPOHs04w9m@infradead.org>
References: <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org>
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>
 <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <aW8w2SRyFnmA2uqk@infradead.org>
 <176890126683.16766.5241619788613840985@noble.neil.brown.name>
 <aXCg-MqXH0E6IuwS@infradead.org>
 <176899164457.16766.16099772451425825775@noble.neil.brown.name>
 <364d2fd98af52a2e2c32ca286decbdc1fe1c80d3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364d2fd98af52a2e2c32ca286decbdc1fe1c80d3.camel@kernel.org>
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
	FREEMAIL_CC(0.00)[brown.name,infradead.org,kernel.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74869-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7F0C05A2EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:27:38AM -0500, Jeff Layton wrote:
> Using your definitions, stability is not a problem for Linux
> filesystems. The filehandles generally don't change after they have
> been established.

fat seems to be an exception as far as the 'real' file systems go.
And it did sound to me like some of the synthetic ones had similar
issues.

> > We'll still need a stable handles flag, and expose it to userspace
> > to avoid applications being tricked into using broken non-stable
> > file handles.  We should have caught that when they were added, but
> > didn't unfortunately.
> > 
> 
> If we assume he meant "unique handles" flag, then I think we're all
> mostly in agreement here.  As far as this patchset goes: what if we
> were to just rename EXPORT_OP_STABLE_HANDLES to
> EXPORT_OP_UNIQUE_HANDLES (and clean up the documentation), since that's
> the main issue for existing filesystems. It would be fairly simple to
> advertise handle uniqueness using statx or something.

Unique seems to also only capture part of it, but I could absolutely
live with it, if the documentation includes all aspecs.  But maybe
use persistent as in the nfs spec?

> 
> Alternately, instead of denying access to these filesystems, we could
> just fix these filesystems to create unique handles (a'la random
> i_generation value or something similar). That should mostly prevent
> filehandles from being reusable across a reboot on these filesystems.

Do we even want to provide access to them?

> That would leave cgroupfs and the like exportable via nfsd, but as you
> point out, we can't deny export by userland servers. If people want to
> do this kind of crazy stuff, maybe we shouldn't deny them after all.

I think Amirs patch would take care of that.  Although userland nfs
servers or other storage applications using the handle syscalls would
still see them.  Then again fixing the problem that some handles
did not fulfill the long standing (but not documented well enough)
semantics probably is a good fix on it's own.


