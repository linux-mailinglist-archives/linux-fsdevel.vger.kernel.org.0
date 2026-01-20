Return-Path: <linux-fsdevel+bounces-74589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF0D3C282
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B09E4AA601
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1A3B8D69;
	Tue, 20 Jan 2026 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXbl/VQV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDOUWFgZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXbl/VQV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDOUWFgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46D3B8BD1
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898412; cv=none; b=IHmkSb3XWPXW74Hi31TzPhc1rTno1WvL3NlZicxRleZqKYtGTf2NL2krdN8eA62GuqMZzSE8dH8MClFXCbvgvcBMyLr0dhCu113LBgQ93xdgafyasfA7CPlN3ShvwhXAmEqwml4eH173k3MyFFLmbfOtpar9zuOiQ2FbLzjG2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898412; c=relaxed/simple;
	bh=8BR8FshNwnTtZve8kPjGIanAYuvxkiLgYA0voF5sQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9r8ShTrCksjQFSR1XJkYf98P3LBmZTMAtv0X/8uK1jqUjHXjBCJZGrX1X33HNKygIZ73d53Wak0fsiElb9cNy1Sp8ALg7cO8tTK4BjrBbVVpOgcx3SQ6N2m902sS7bG/4taLpozg/hzw03A95Iy3y7crxqL8rw6QxrSxgTbR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXbl/VQV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDOUWFgZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXbl/VQV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDOUWFgZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A132E337CA;
	Tue, 20 Jan 2026 08:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768898407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=241NHzkrAsafry/49JFnJwfuSaj964PJNO6i4H5lhSI=;
	b=lXbl/VQVuVPBPaq9av5smG5OFa/NhiwefeYAnKTxiTxM2QX9a0Jsbdpis0tVJFy+unWMtD
	bNh/ywftBTm5m2O2e7f0QmCLthEIxPwfSwEbrsfum9UBevwRj24bv8DnE2XCtOBZOykvGt
	AUYIB66up1nxz+RBb/9UrZZim7/aN7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768898407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=241NHzkrAsafry/49JFnJwfuSaj964PJNO6i4H5lhSI=;
	b=LDOUWFgZ9L1jfR2KXNRaliX4q7afY0RWN0QEnpzcnPdpU998Wx8+N3DLW81My4a1pFp2EE
	dwI54JIvYwP/B5AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="lXbl/VQV";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LDOUWFgZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768898407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=241NHzkrAsafry/49JFnJwfuSaj964PJNO6i4H5lhSI=;
	b=lXbl/VQVuVPBPaq9av5smG5OFa/NhiwefeYAnKTxiTxM2QX9a0Jsbdpis0tVJFy+unWMtD
	bNh/ywftBTm5m2O2e7f0QmCLthEIxPwfSwEbrsfum9UBevwRj24bv8DnE2XCtOBZOykvGt
	AUYIB66up1nxz+RBb/9UrZZim7/aN7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768898407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=241NHzkrAsafry/49JFnJwfuSaj964PJNO6i4H5lhSI=;
	b=LDOUWFgZ9L1jfR2KXNRaliX4q7afY0RWN0QEnpzcnPdpU998Wx8+N3DLW81My4a1pFp2EE
	dwI54JIvYwP/B5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D993EA63;
	Tue, 20 Jan 2026 08:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RJLPJGc/b2l6AwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 08:40:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47975A09DA; Tue, 20 Jan 2026 09:40:07 +0100 (CET)
Date: Tue, 20 Jan 2026 09:40:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Amir Goldstein <amir73il@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
Message-ID: <56fr33ju43h6zzp6jrzrkyfag6r3jz6wpnk45oe5byy6fqyvti@d43hgikfuk7t>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
 <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
 <aW8ztQ-RbhxwzMk7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW8ztQ-RbhxwzMk7@infradead.org>
X-Spam-Score: -2.51
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,oracle.com,brown.name,redhat.com,talpey.com,gmail.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,infradead.org,nod.at,suse.cz,mail.parknet.co.jp,lwn.net,fromorbit.com,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.samba.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	RCPT_COUNT_GT_50(0.00)[78];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLn1fby4ztoa71w9ewejbxf7et)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A132E337CA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon 19-01-26 23:50:13, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 11:26:19AM -0500, Jeff Layton wrote:
> > +  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
> > +    stable across the lifetime of a file. This is a hard requirement for export
> > +    via nfsd. Any filesystem that is eligible to be exported via nfsd must
> > +    indicate this guarantee by setting this flag. Most disk-based filesystems
> > +    can do this naturally. Pseudofilesystems that are for local reporting and
> > +    control (e.g. kernfs, pidfs, nsfs) usually can't support this.
> 
> Suggested rewording, taking some of the ideas from Dave Chinners earlier
> comments into account:
> 
>   EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
>     stable across the lifetime of a file.  A file in this context is an
>     instantiated inode reachable by one or more file names, or still open after
>     the last name has been unlinked.  Reuses of the same on-disk inode structure
>     are considered new files and must provide different file handles from the
>     previous incarnation.  Most file systems designed to store user data
>     naturally provide this capability.  Pseudofilesystems that are for local
>     reporting and control (e.g. kernfs, pidfs, nsfs) usually can't support this.
> 
>     This flags is a hard requirement for export via nfsd. Any filesystem that
>     is eligible to be exported via nfsd must indicate this guarantee by
>     setting this flag.

I like this. It certainly makes the requirement of stability clearer to me
(with explanations before I couldn't quite see the difference between shmem
and kernfs). I'd note that fat or shmem (which are both exportable)
satisfy this only with reasonably high probability as they use
get_random_u32() for initializing their i_generation but I guess it's as
good as it gets for them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

