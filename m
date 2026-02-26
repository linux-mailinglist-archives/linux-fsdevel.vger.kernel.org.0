Return-Path: <linux-fsdevel+bounces-78630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAfpD8enoGnilQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:06:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C91AED43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3DE53010B5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC6364923;
	Thu, 26 Feb 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoiapCCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D313164B5;
	Thu, 26 Feb 2026 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136378; cv=none; b=BNc4ExfPHH6M4eb43y/0nuKZIwPiUCyV/so+roElQDUR/Fmta13OsLh0WM6KTWrOggMLP4K/ndS5royk91ZvYbPeB1+8PQvzq/c+MnjlL4VnxYB7h4ZRjGqnlbvApgje+b4jtBA3GtuqG/+LmOvMW3Y5QbMMdv5ivqsEcmzCYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136378; c=relaxed/simple;
	bh=amJIWoT1nC09hCk+fwfbrDXhDDzedSUJ2LEhzzxxTsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAmVADDuUMcy84oU5XnUeKkPERHIT8YhLZG/78LNp8tNqbyXSRCX9ybuCU/pHgpU3CQjJTYuE6kQFt0qLwyoBmINyV27Iq93PQmKTM9vgpmNQmMJmi11ocBGq2+lLuJ2i/0SsXEw9C6d7kBL68Vui4A5awFKTc3lHcg9infH304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoiapCCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1109C116C6;
	Thu, 26 Feb 2026 20:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772136377;
	bh=amJIWoT1nC09hCk+fwfbrDXhDDzedSUJ2LEhzzxxTsU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GoiapCCjXtcW/ncWAnCZfJR5QyfV+JUZXXnUIjhxbyDc7L9/74824XjLGF/9FcdJR
	 SHDVHPsQnmcX9UVRLy8HgT37wgK6s8QXPaw6c3IwlPsGwOa3bfi8lNSWFLe/Bah+sW
	 ZA/4okeZZPZJ7mvZzl3EE6xRSak7Kyr4Yu/stsPLfya2o43enXoLgzD9mTD+FyXLtX
	 +yY8TWh/m28GLJhf7ExEjMw72g8WiX6uYn3ecMNMArIST8tJ8isTBaGjNYY7m790z7
	 pQLCm+TMkPfrsnPhjngtxwcWPP0z2TyIJi4xqcJt/EgJRaTRJCjXT19SFgFPN0H64M
	 eqDgsSpMWSpow==
Message-ID: <d8d47ebf099b21bf20f7284837f8164a19590010.camel@kernel.org>
Subject: Re:  [PATCH 17/61] nilfs2: update for u64 i_ino
From: Jeff Layton <jlayton@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "david@kernel.org"	
 <david@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, 
 "oleg@redhat.com"	 <oleg@redhat.com>, "anna@kernel.org" <anna@kernel.org>,
 "ms@dev.tdt.de"	 <ms@dev.tdt.de>, "alexander.shishkin@linux.intel.com"	
 <alexander.shishkin@linux.intel.com>, "jack@suse.cz" <jack@suse.cz>, 
 "ebiggers@kernel.org"	 <ebiggers@kernel.org>, Ondrej Mosnacek
 <omosnace@redhat.com>,  "mark.rutland@arm.com"	 <mark.rutland@arm.com>,
 "casey@schaufler-ca.com" <casey@schaufler-ca.com>, 
 "glaubitz@physik.fu-berlin.de"	 <glaubitz@physik.fu-berlin.de>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>,  "sumit.semwal@linaro.org"	
 <sumit.semwal@linaro.org>, "john.johansen@canonical.com"	
 <john.johansen@canonical.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
 "slava@dubeyko.com"	 <slava@dubeyko.com>, "willy@infradead.org"
 <willy@infradead.org>,  "tytso@mit.edu"	 <tytso@mit.edu>,
 "asmadeus@codewreck.org" <asmadeus@codewreck.org>,  "jth@kernel.org"	
 <jth@kernel.org>, "shaggy@kernel.org" <shaggy@kernel.org>,
 "serge@hallyn.com"	 <serge@hallyn.com>, "jaharkes@cs.cmu.edu"
 <jaharkes@cs.cmu.edu>,  "trondmy@kernel.org"	 <trondmy@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>,  "ericvh@kernel.org"	
 <ericvh@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "willemb@google.com"	 <willemb@google.com>, "aivazian.tigran@gmail.com"
 <aivazian.tigran@gmail.com>,  "hubcap@omnibond.com"	 <hubcap@omnibond.com>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,  "sfrench@samba.org"	
 <sfrench@samba.org>, "neil@brown.name" <neil@brown.name>,
 "jmorris@namei.org"	 <jmorris@namei.org>, "jlbec@evilplan.org"
 <jlbec@evilplan.org>,  "chuck.lever@oracle.com"	 <chuck.lever@oracle.com>,
 "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,  "lucho@ionkov.net"	
 <lucho@ionkov.net>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
 "raven@themaw.net"	 <raven@themaw.net>, Alex Markuze <amarkuze@redhat.com>,
 "mhiramat@kernel.org"	 <mhiramat@kernel.org>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>,  "mathieu.desnoyers@efficios.com"	
 <mathieu.desnoyers@efficios.com>, "horms@kernel.org" <horms@kernel.org>, 
 "tom@talpey.com"	 <tom@talpey.com>, "mark@fasheh.com" <mark@fasheh.com>, 
 "mikulas@artax.karlin.mff.cuni.cz"	 <mikulas@artax.karlin.mff.cuni.cz>,
 "djwong@kernel.org" <djwong@kernel.org>,  "edumazet@google.com"	
 <edumazet@google.com>, Olga Kornievskaia <okorniev@redhat.com>, 
 "bharathsm@microsoft.com"	 <bharathsm@microsoft.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,  "osalvador@suse.de"	
 <osalvador@suse.de>, "peterz@infradead.org" <peterz@infradead.org>, 
 "christian.koenig@amd.com"	 <christian.koenig@amd.com>, "pc@manguebit.org"
 <pc@manguebit.org>,  "martin@omnibond.com"	 <martin@omnibond.com>,
 "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,  "frank.li@vivo.com"	
 <frank.li@vivo.com>, "dsterba@suse.com" <dsterba@suse.com>, 
 "zohar@linux.ibm.com"	 <zohar@linux.ibm.com>, "code@tyhicks.com"
 <code@tyhicks.com>,  "dwmw2@infradead.org"	 <dwmw2@infradead.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "kuniyu@google.com"	
 <kuniyu@google.com>, "nico@fluxnic.net" <nico@fluxnic.net>, "jack@suse.com"
	 <jack@suse.com>, "dlemoal@kernel.org" <dlemoal@kernel.org>, 
 "viro@zeniv.linux.org.uk"	 <viro@zeniv.linux.org.uk>,
 "stephen.smalley.work@gmail.com"	 <stephen.smalley.work@gmail.com>,
 "salah.triki@gmail.com"	 <salah.triki@gmail.com>, David Howells
 <dhowells@redhat.com>,  "paul@paul-moore.com"	 <paul@paul-moore.com>,
 "luisbg@kernel.org" <luisbg@kernel.org>,  "irogers@google.com"	
 <irogers@google.com>, "acme@kernel.org" <acme@kernel.org>, "richard@nod.at"
	 <richard@nod.at>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
 "idryomov@gmail.com"	 <idryomov@gmail.com>, "joseph.qi@linux.alibaba.com"	
 <joseph.qi@linux.alibaba.com>, "al@alarsen.net" <al@alarsen.net>, 
 "james.clark@linaro.org"	 <james.clark@linaro.org>,
 "dmitry.kasatkin@gmail.com"	 <dmitry.kasatkin@gmail.com>,
 "roberto.sassu@huawei.com"	 <roberto.sassu@huawei.com>,
 "konishi.ryusuke@gmail.com"	 <konishi.ryusuke@gmail.com>,
 "sprasad@microsoft.com" <sprasad@microsoft.com>,  "jaegeuk@kernel.org"	
 <jaegeuk@kernel.org>, "linux_oss@crudebyte.com" <linux_oss@crudebyte.com>, 
 "brauner@kernel.org"	 <brauner@kernel.org>, "Dai.Ngo@oracle.com"
 <Dai.Ngo@oracle.com>,  "eric.snowberg@oracle.com"	
 <eric.snowberg@oracle.com>, "adilger.kernel@dilger.ca"	
 <adilger.kernel@dilger.ca>, "chao@kernel.org" <chao@kernel.org>, 
 "wufan@kernel.org"	 <wufan@kernel.org>, "coda@cs.cmu.edu"
 <coda@cs.cmu.edu>, Ingo Molnar	 <mingo@redhat.com>, "alex.aring@gmail.com"
 <alex.aring@gmail.com>,  "airlied@gmail.com"	 <airlied@gmail.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,  Paolo Abeni
 <pabeni@redhat.com>, "marc.dionne@auristor.com" <marc.dionne@auristor.com>,
  "almaz.alexandrovich@paragon-software.com"	
 <almaz.alexandrovich@paragon-software.com>, "davem@davemloft.net"	
 <davem@davemloft.net>, "hch@infradead.org" <hch@infradead.org>
Cc: "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>, 
 "linux-unionfs@vger.kernel.org"	 <linux-unionfs@vger.kernel.org>,
 "apparmor@lists.ubuntu.com"	 <apparmor@lists.ubuntu.com>,
 "linux-ext4@vger.kernel.org"	 <linux-ext4@vger.kernel.org>,
 "autofs@vger.kernel.org" <autofs@vger.kernel.org>, 
 "amd-gfx@lists.freedesktop.org"	 <amd-gfx@lists.freedesktop.org>,
 "fsverity@lists.linux.dev"	 <fsverity@lists.linux.dev>,
 "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, 
 "ocfs2-devel@lists.linux.dev"	 <ocfs2-devel@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org"	 <linux-fsdevel@vger.kernel.org>,
 "linux-media@vger.kernel.org"	 <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org"	 <netdev@vger.kernel.org>,
 "linux-integrity@vger.kernel.org"	 <linux-integrity@vger.kernel.org>,
 "samba-technical@lists.samba.org"	 <samba-technical@lists.samba.org>,
 "linux-nilfs@vger.kernel.org"	 <linux-nilfs@vger.kernel.org>,
 "selinux@vger.kernel.org"	 <selinux@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org"	 <linaro-mm-sig@lists.linaro.org>,
 "linux-trace-kernel@vger.kernel.org"	 <linux-trace-kernel@vger.kernel.org>,
 "v9fs@lists.linux.dev"	 <v9fs@lists.linux.dev>, "linux-xfs@vger.kernel.org"
 <linux-xfs@vger.kernel.org>,  "linux-x25@vger.kernel.org"	
 <linux-x25@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"	
 <linux-f2fs-devel@lists.sourceforge.net>, "nvdimm@lists.linux.dev"	
 <nvdimm@lists.linux.dev>, "ceph-devel@vger.kernel.org"	
 <ceph-devel@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"	
 <jfs-discussion@lists.sourceforge.net>, "linux-mtd@lists.infradead.org"	
 <linux-mtd@lists.infradead.org>, "devel@lists.orangefs.org"	
 <devel@lists.orangefs.org>, "linux-afs@lists.infradead.org"	
 <linux-afs@lists.infradead.org>, "linux-fscrypt@vger.kernel.org"	
 <linux-fscrypt@vger.kernel.org>, "linux-security-module@vger.kernel.org"	
 <linux-security-module@vger.kernel.org>, "linux-cifs@vger.kernel.org"	
 <linux-cifs@vger.kernel.org>, "linux-hams@vger.kernel.org"	
 <linux-hams@vger.kernel.org>, "linux-nfs@vger.kernel.org"	
 <linux-nfs@vger.kernel.org>, "codalist@coda.cs.cmu.edu"	
 <codalist@coda.cs.cmu.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
 "netfs@lists.linux.dev"	 <netfs@lists.linux.dev>,
 "linux-perf-users@vger.kernel.org"	 <linux-perf-users@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org"	 <dri-devel@lists.freedesktop.org>
Date: Thu, 26 Feb 2026 15:06:03 -0500
In-Reply-To: <34b1d1f43043ca1b71a3ca9ea5ebce597a4c02aa.camel@ibm.com>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
		 <20260226-iino-u64-v1-17-ccceff366db9@kernel.org>
	 <34b1d1f43043ca1b71a3ca9ea5ebce597a4c02aa.camel@ibm.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78630-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ibm.com,kernel.org,redhat.com,dev.tdt.de,linux.intel.com,suse.cz,arm.com,schaufler-ca.com,physik.fu-berlin.de,szeredi.hu,linaro.org,canonical.com,gmail.com,dubeyko.com,infradead.org,mit.edu,codewreck.org,hallyn.com,cs.cmu.edu,ffwll.ch,google.com,omnibond.com,linux.dev,samba.org,brown.name,namei.org,evilplan.org,oracle.com,ionkov.net,intel.com,themaw.net,amd.com,efficios.com,talpey.com,fasheh.com,artax.karlin.mff.cuni.cz,microsoft.com,suse.de,manguebit.org,wdc.com,vivo.com,suse.com,linux.ibm.com,tyhicks.com,fluxnic.net,zeniv.linux.org.uk,paul-moore.com,nod.at,goodmis.org,linux.alibaba.com,alarsen.net,huawei.com,crudebyte.com,dilger.ca,auristor.com,paragon-software.com,davemloft.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 249C91AED43
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 19:46 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2026-02-26 at 10:55 -0500, Jeff Layton wrote:
> > Update nilfs2 trace events and filesystem code for u64 i_ino:
> >=20
> > - Change __field(ino_t, ...) to __field(u64, ...) in trace events
> > - Update format strings from %lu to %llu
> > - Cast to (unsigned long long) in TP_printk
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nilfs2/alloc.c             | 10 +++++-----
> >  fs/nilfs2/bmap.c              |  2 +-
> >  fs/nilfs2/btnode.c            |  2 +-
> >  fs/nilfs2/btree.c             | 12 ++++++------
> >  fs/nilfs2/dir.c               | 12 ++++++------
> >  fs/nilfs2/direct.c            |  4 ++--
> >  fs/nilfs2/gcinode.c           |  2 +-
> >  fs/nilfs2/inode.c             |  8 ++++----
> >  fs/nilfs2/mdt.c               |  2 +-
> >  fs/nilfs2/namei.c             |  2 +-
> >  fs/nilfs2/segment.c           |  2 +-
> >  include/trace/events/nilfs2.h | 12 ++++++------
> >  12 files changed, 35 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
> > index e7eebb04f9a4080a39f17d4123e58ed7df6b2f4b..7b1cd2baefcf21e54f92608=
45b02c7c95c148c64 100644
> > --- a/fs/nilfs2/alloc.c
> > +++ b/fs/nilfs2/alloc.c
> > @@ -707,7 +707,7 @@ void nilfs_palloc_commit_free_entry(struct inode *i=
node,
> > =20
> >  	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
> >  		nilfs_warn(inode->i_sb,
> > -			   "%s (ino=3D%lu): entry number %llu already freed",
> > +			   "%s (ino=3D%llu): entry number %llu already freed",
> >  			   __func__, inode->i_ino,
> >  			   (unsigned long long)req->pr_entry_nr);
> >  	else
> > @@ -748,7 +748,7 @@ void nilfs_palloc_abort_alloc_entry(struct inode *i=
node,
> > =20
> >  	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
> >  		nilfs_warn(inode->i_sb,
> > -			   "%s (ino=3D%lu): entry number %llu already freed",
> > +			   "%s (ino=3D%llu): entry number %llu already freed",
> >  			   __func__, inode->i_ino,
> >  			   (unsigned long long)req->pr_entry_nr);
> >  	else
> > @@ -861,7 +861,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *=
entry_nrs, size_t nitems)
> >  			if (!nilfs_clear_bit_atomic(lock, group_offset,
> >  						    bitmap)) {
> >  				nilfs_warn(inode->i_sb,
> > -					   "%s (ino=3D%lu): entry number %llu already freed",
> > +					   "%s (ino=3D%llu): entry number %llu already freed",
> >  					   __func__, inode->i_ino,
> >  					   (unsigned long long)entry_nrs[j]);
> >  			} else {
> > @@ -906,7 +906,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *=
entry_nrs, size_t nitems)
> >  							      last_nrs[k]);
> >  			if (ret && ret !=3D -ENOENT)
> >  				nilfs_warn(inode->i_sb,
> > -					   "error %d deleting block that object (entry=3D%llu, ino=3D%lu)=
 belongs to",
> > +					   "error %d deleting block that object (entry=3D%llu, ino=3D%llu=
) belongs to",
> >  					   ret, (unsigned long long)last_nrs[k],
> >  					   inode->i_ino);
> >  		}
> > @@ -923,7 +923,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *=
entry_nrs, size_t nitems)
> >  			ret =3D nilfs_palloc_delete_bitmap_block(inode, group);
> >  			if (ret && ret !=3D -ENOENT)
> >  				nilfs_warn(inode->i_sb,
> > -					   "error %d deleting bitmap block of group=3D%lu, ino=3D%lu",
> > +					   "error %d deleting bitmap block of group=3D%lu, ino=3D%llu",
> >  					   ret, group, inode->i_ino);
> >  		}
> >  	}
> > diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> > index ccc1a7aa52d2064d56b826058554264c498d592f..824f2bd91c167965ec3a660=
202b6e6c5f1fe007e 100644
> > --- a/fs/nilfs2/bmap.c
> > +++ b/fs/nilfs2/bmap.c
> > @@ -33,7 +33,7 @@ static int nilfs_bmap_convert_error(struct nilfs_bmap=
 *bmap,
> > =20
> >  	if (err =3D=3D -EINVAL) {
> >  		__nilfs_error(inode->i_sb, fname,
> > -			      "broken bmap (inode number=3D%lu)", inode->i_ino);
> > +			      "broken bmap (inode number=3D%llu)", inode->i_ino);
> >  		err =3D -EIO;
> >  	}
> >  	return err;
> > diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
> > index 56836712909201775907483887e8a0022851bbec..2e553d698d0f3980de98fce=
d415dfd819ddbca0a 100644
> > --- a/fs/nilfs2/btnode.c
> > +++ b/fs/nilfs2/btnode.c
> > @@ -64,7 +64,7 @@ nilfs_btnode_create_block(struct address_space *btnc,=
 __u64 blocknr)
> >  		 * clearing of an abandoned b-tree node is missing somewhere).
> >  		 */
> >  		nilfs_error(inode->i_sb,
> > -			    "state inconsistency probably due to duplicate use of b-tree no=
de block address %llu (ino=3D%lu)",
> > +			    "state inconsistency probably due to duplicate use of b-tree no=
de block address %llu (ino=3D%llu)",
> >  			    (unsigned long long)blocknr, inode->i_ino);
> >  		goto failed;
> >  	}
> > diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> > index dd0c8e560ef6a2c96515025321914e0d73f41144..3c03f5a741d144d22d1ffb5=
acf43a035e88c00dc 100644
> > --- a/fs/nilfs2/btree.c
> > +++ b/fs/nilfs2/btree.c
> > @@ -353,7 +353,7 @@ static int nilfs_btree_node_broken(const struct nil=
fs_btree_node *node,
> >  		     nchildren <=3D 0 ||
> >  		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
> >  		nilfs_crit(inode->i_sb,
> > -			   "bad btree node (ino=3D%lu, blocknr=3D%llu): level =3D %d, flags=
 =3D 0x%x, nchildren =3D %d",
> > +			   "bad btree node (ino=3D%llu, blocknr=3D%llu): level =3D %d, flag=
s =3D 0x%x, nchildren =3D %d",
> >  			   inode->i_ino, (unsigned long long)blocknr, level,
> >  			   flags, nchildren);
> >  		ret =3D 1;
> > @@ -384,7 +384,7 @@ static int nilfs_btree_root_broken(const struct nil=
fs_btree_node *node,
> >  		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX ||
> >  		     (nchildren =3D=3D 0 && level > NILFS_BTREE_LEVEL_NODE_MIN))) {
> >  		nilfs_crit(inode->i_sb,
> > -			   "bad btree root (ino=3D%lu): level =3D %d, flags =3D 0x%x, nchil=
dren =3D %d",
> > +			   "bad btree root (ino=3D%llu): level =3D %d, flags =3D 0x%x, nchi=
ldren =3D %d",
> >  			   inode->i_ino, level, flags, nchildren);
> >  		ret =3D 1;
> >  	}
> > @@ -453,7 +453,7 @@ static int nilfs_btree_bad_node(const struct nilfs_=
bmap *btree,
> >  	if (unlikely(nilfs_btree_node_get_level(node) !=3D level)) {
> >  		dump_stack();
> >  		nilfs_crit(btree->b_inode->i_sb,
> > -			   "btree level mismatch (ino=3D%lu): %d !=3D %d",
> > +			   "btree level mismatch (ino=3D%llu): %d !=3D %d",
> >  			   btree->b_inode->i_ino,
> >  			   nilfs_btree_node_get_level(node), level);
> >  		return 1;
> > @@ -521,7 +521,7 @@ static int __nilfs_btree_get_block(const struct nil=
fs_bmap *btree, __u64 ptr,
> >   out_no_wait:
> >  	if (!buffer_uptodate(bh)) {
> >  		nilfs_err(btree->b_inode->i_sb,
> > -			  "I/O error reading b-tree node block (ino=3D%lu, blocknr=3D%llu)"=
,
> > +			  "I/O error reading b-tree node block (ino=3D%llu, blocknr=3D%llu)=
",
> >  			  btree->b_inode->i_ino, (unsigned long long)ptr);
> >  		brelse(bh);
> >  		return -EIO;
> > @@ -2104,7 +2104,7 @@ static int nilfs_btree_propagate(struct nilfs_bma=
p *btree,
> >  	if (ret < 0) {
> >  		if (unlikely(ret =3D=3D -ENOENT)) {
> >  			nilfs_crit(btree->b_inode->i_sb,
> > -				   "writing node/leaf block does not appear in b-tree (ino=3D%lu) =
at key=3D%llu, level=3D%d",
> > +				   "writing node/leaf block does not appear in b-tree (ino=3D%llu)=
 at key=3D%llu, level=3D%d",
> >  				   btree->b_inode->i_ino,
> >  				   (unsigned long long)key, level);
> >  			ret =3D -EINVAL;
> > @@ -2146,7 +2146,7 @@ static void nilfs_btree_add_dirty_buffer(struct n=
ilfs_bmap *btree,
> >  	    level >=3D NILFS_BTREE_LEVEL_MAX) {
> >  		dump_stack();
> >  		nilfs_warn(btree->b_inode->i_sb,
> > -			   "invalid btree level: %d (key=3D%llu, ino=3D%lu, blocknr=3D%llu)=
",
> > +			   "invalid btree level: %d (key=3D%llu, ino=3D%llu, blocknr=3D%llu=
)",
> >  			   level, (unsigned long long)key,
> >  			   btree->b_inode->i_ino,
> >  			   (unsigned long long)bh->b_blocknr);
> > diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> > index b243199036dfa1ab2299efaaa5bdf5da2d159ff2..3653db5cdb65137d1e660bb=
509c14ec4cbc8840b 100644
> > --- a/fs/nilfs2/dir.c
> > +++ b/fs/nilfs2/dir.c
> > @@ -150,7 +150,7 @@ static bool nilfs_check_folio(struct folio *folio, =
char *kaddr)
> > =20
> >  Ebadsize:
> >  	nilfs_error(sb,
> > -		    "size of directory #%lu is not a multiple of chunk size",
> > +		    "size of directory #%llu is not a multiple of chunk size",
> >  		    dir->i_ino);
> >  	goto fail;
> >  Eshort:
> > @@ -169,7 +169,7 @@ static bool nilfs_check_folio(struct folio *folio, =
char *kaddr)
> >  	error =3D "disallowed inode number";
> >  bad_entry:
> >  	nilfs_error(sb,
> > -		    "bad entry in directory #%lu: %s - offset=3D%lu, inode=3D%lu, re=
c_len=3D%zd, name_len=3D%d",
> > +		    "bad entry in directory #%llu: %s - offset=3D%lu, inode=3D%lu, r=
ec_len=3D%zd, name_len=3D%d",
>=20
> I think you missed 'inode=3D%lu' here.=20

That is actually the placeholder for this:

    (unsigned long)le64_to_cpu(p->inode)

...which is not inode->i_ino. I do agree that the cast probably no
longer makes sense with this change, but I'd probably leave that to a
later cleanup so we can keep this set focused on the i_ino change.


> >  		    dir->i_ino, error, (folio->index << PAGE_SHIFT) + offs,
> >  		    (unsigned long)le64_to_cpu(p->inode),
> >  		    rec_len, p->name_len);
> > @@ -177,7 +177,7 @@ static bool nilfs_check_folio(struct folio *folio, =
char *kaddr)
> >  Eend:
> >  	p =3D (struct nilfs_dir_entry *)(kaddr + offs);
> >  	nilfs_error(sb,
> > -		    "entry in directory #%lu spans the page boundary offset=3D%lu, i=
node=3D%lu",
> > +		    "entry in directory #%llu spans the page boundary offset=3D%lu, =
inode=3D%lu",
>=20
> Ditto. You missed 'inode=3D%lu' here.
>=20
>

Same here.

> >  		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
> >  		    (unsigned long)le64_to_cpu(p->inode));
> >  fail:
> > @@ -251,7 +251,7 @@ static int nilfs_readdir(struct file *file, struct =
dir_context *ctx)
> > =20
> >  		kaddr =3D nilfs_get_folio(inode, n, &folio);
> >  		if (IS_ERR(kaddr)) {
> > -			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
> > +			nilfs_error(sb, "bad page in #%llu", inode->i_ino);
> >  			ctx->pos +=3D PAGE_SIZE - offset;
> >  			return -EIO;
> >  		}
> > @@ -336,7 +336,7 @@ struct nilfs_dir_entry *nilfs_find_entry(struct ino=
de *dir,
> >  		/* next folio is past the blocks we've got */
> >  		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
> >  			nilfs_error(dir->i_sb,
> > -			       "dir %lu size %lld exceeds block count %llu",
> > +			       "dir %llu size %lld exceeds block count %llu",
> >  			       dir->i_ino, dir->i_size,
> >  			       (unsigned long long)dir->i_blocks);
> >  			goto out;
> > @@ -382,7 +382,7 @@ struct nilfs_dir_entry *nilfs_dotdot(struct inode *=
dir, struct folio **foliop)
> >  	return next_de;
> > =20
> >  fail:
> > -	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
> > +	nilfs_error(dir->i_sb, "directory #%llu %s", dir->i_ino, msg);
> >  	folio_release_kmap(folio, de);
> >  	return NULL;
> >  }
> > diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
> > index 2d8dc6b35b5477947ca12a70288d3a3cce858aab..8bd0b1374e25f8ff510f3b3=
6dbde2acc01aafc1e 100644
> > --- a/fs/nilfs2/direct.c
> > +++ b/fs/nilfs2/direct.c
> > @@ -338,7 +338,7 @@ static int nilfs_direct_assign(struct nilfs_bmap *b=
map,
> >  	key =3D nilfs_bmap_data_get_key(bmap, *bh);
> >  	if (unlikely(key > NILFS_DIRECT_KEY_MAX)) {
> >  		nilfs_crit(bmap->b_inode->i_sb,
> > -			   "%s (ino=3D%lu): invalid key: %llu",
> > +			   "%s (ino=3D%llu): invalid key: %llu",
> >  			   __func__,
> >  			   bmap->b_inode->i_ino, (unsigned long long)key);
> >  		return -EINVAL;
> > @@ -346,7 +346,7 @@ static int nilfs_direct_assign(struct nilfs_bmap *b=
map,
> >  	ptr =3D nilfs_direct_get_ptr(bmap, key);
> >  	if (unlikely(ptr =3D=3D NILFS_BMAP_INVALID_PTR)) {
> >  		nilfs_crit(bmap->b_inode->i_sb,
> > -			   "%s (ino=3D%lu): invalid pointer: %llu",
> > +			   "%s (ino=3D%llu): invalid pointer: %llu",
> >  			   __func__,
> >  			   bmap->b_inode->i_ino, (unsigned long long)ptr);
> >  		return -EINVAL;
> > diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> > index 561c220799c7aee879ad866865e377799c8ee6bb..62d4c1b787e95c961a360a4=
214d621d564ad8b4c 100644
> > --- a/fs/nilfs2/gcinode.c
> > +++ b/fs/nilfs2/gcinode.c
> > @@ -137,7 +137,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer=
_head *bh)
> >  		struct inode *inode =3D bh->b_folio->mapping->host;
> > =20
> >  		nilfs_err(inode->i_sb,
> > -			  "I/O error reading %s block for GC (ino=3D%lu, vblocknr=3D%llu)",
> > +			  "I/O error reading %s block for GC (ino=3D%llu, vblocknr=3D%llu)"=
,
> >  			  buffer_nilfs_node(bh) ? "node" : "data",
> >  			  inode->i_ino, (unsigned long long)bh->b_blocknr);
> >  		return -EIO;
> > diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> > index 51bde45d586509dda3ef0cb7c46facb7fb2c61dd..51f7e125a311b868860e3e1=
11700d49d4cb98fa6 100644
> > --- a/fs/nilfs2/inode.c
> > +++ b/fs/nilfs2/inode.c
> > @@ -108,7 +108,7 @@ int nilfs_get_block(struct inode *inode, sector_t b=
lkoff,
> >  				 * be locked in this case.
> >  				 */
> >  				nilfs_warn(inode->i_sb,
> > -					   "%s (ino=3D%lu): a race condition while inserting a data block=
 at offset=3D%llu",
> > +					   "%s (ino=3D%llu): a race condition while inserting a data bloc=
k at offset=3D%llu",
> >  					   __func__, inode->i_ino,
> >  					   (unsigned long long)blkoff);
> >  				err =3D -EAGAIN;
> > @@ -789,7 +789,7 @@ static void nilfs_truncate_bmap(struct nilfs_inode_=
info *ii,
> >  		goto repeat;
> > =20
> >  failed:
> > -	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=3D%lu)"=
,
> > +	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=3D%llu)=
",
> >  		   ret, ii->vfs_inode.i_ino);
> >  }
> > =20
> > @@ -1026,7 +1026,7 @@ int nilfs_set_file_dirty(struct inode *inode, uns=
igned int nr_dirty)
> >  			 * this inode.
> >  			 */
> >  			nilfs_warn(inode->i_sb,
> > -				   "cannot set file dirty (ino=3D%lu): the file is being freed",
> > +				   "cannot set file dirty (ino=3D%llu): the file is being freed",
> >  				   inode->i_ino);
> >  			spin_unlock(&nilfs->ns_inode_lock);
> >  			return -EINVAL; /*
> > @@ -1057,7 +1057,7 @@ int __nilfs_mark_inode_dirty(struct inode *inode,=
 int flags)
> >  	err =3D nilfs_load_inode_block(inode, &ibh);
> >  	if (unlikely(err)) {
> >  		nilfs_warn(inode->i_sb,
> > -			   "cannot mark inode dirty (ino=3D%lu): error %d loading inode blo=
ck",
> > +			   "cannot mark inode dirty (ino=3D%llu): error %d loading inode bl=
ock",
> >  			   inode->i_ino, err);
> >  		return err;
> >  	}
> > diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> > index 946b0d3534a5f22f34ac44a91fb121541881c548..09adb40c65e505d92012a3d=
2f5fe8a5696e10056 100644
> > --- a/fs/nilfs2/mdt.c
> > +++ b/fs/nilfs2/mdt.c
> > @@ -203,7 +203,7 @@ static int nilfs_mdt_read_block(struct inode *inode=
, unsigned long block,
> >  	err =3D -EIO;
> >  	if (!buffer_uptodate(first_bh)) {
> >  		nilfs_err(inode->i_sb,
> > -			  "I/O error reading meta-data file (ino=3D%lu, block-offset=3D%lu)=
",
> > +			  "I/O error reading meta-data file (ino=3D%llu, block-offset=3D%lu=
)",
> >  			  inode->i_ino, block);
> >  		goto failed_bh;
> >  	}
> > diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
> > index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..40ac679ec56e400b1df98e9=
be6fe9ca338a9ba51 100644
> > --- a/fs/nilfs2/namei.c
> > +++ b/fs/nilfs2/namei.c
> > @@ -292,7 +292,7 @@ static int nilfs_do_unlink(struct inode *dir, struc=
t dentry *dentry)
> > =20
> >  	if (!inode->i_nlink) {
> >  		nilfs_warn(inode->i_sb,
> > -			   "deleting nonexistent file (ino=3D%lu), %d",
> > +			   "deleting nonexistent file (ino=3D%llu), %d",
> >  			   inode->i_ino, inode->i_nlink);
> >  		set_nlink(inode, 1);
> >  	}
> > diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> > index 098a3bd103e04cd09b0689fe2017380d74664496..4b1bf559f3524b1cc3965da=
e9fd3e5745718569d 100644
> > --- a/fs/nilfs2/segment.c
> > +++ b/fs/nilfs2/segment.c
> > @@ -2024,7 +2024,7 @@ static int nilfs_segctor_collect_dirty_files(stru=
ct nilfs_sc_info *sci,
> >  				ifile, ii->vfs_inode.i_ino, &ibh);
> >  			if (unlikely(err)) {
> >  				nilfs_warn(sci->sc_super,
> > -					   "log writer: error %d getting inode block (ino=3D%lu)",
> > +					   "log writer: error %d getting inode block (ino=3D%llu)",
> >  					   err, ii->vfs_inode.i_ino);
> >  				return err;
> >  			}
> > diff --git a/include/trace/events/nilfs2.h b/include/trace/events/nilfs=
2.h
> > index 8880c11733dd307c223cc62ee34ebeff650ecb12..86a0011c9eeaf031cfa0b79=
875b2b106ef8b7cfd 100644
> > --- a/include/trace/events/nilfs2.h
> > +++ b/include/trace/events/nilfs2.h
> > @@ -165,14 +165,14 @@ TRACE_EVENT(nilfs2_segment_usage_freed,
> > =20
> >  TRACE_EVENT(nilfs2_mdt_insert_new_block,
> >  	    TP_PROTO(struct inode *inode,
> > -		     unsigned long ino,
> > +		     u64 ino,
> >  		     unsigned long block),
> > =20
> >  	    TP_ARGS(inode, ino, block),
> > =20
> >  	    TP_STRUCT__entry(
> >  		    __field(struct inode *, inode)
> > -		    __field(unsigned long, ino)
> > +		    __field(u64, ino)
> >  		    __field(unsigned long, block)
> >  	    ),
> > =20
> > @@ -182,7 +182,7 @@ TRACE_EVENT(nilfs2_mdt_insert_new_block,
> >  		    __entry->block =3D block;
> >  		    ),
> > =20
> > -	    TP_printk("inode =3D %p ino =3D %lu block =3D %lu",
> > +	    TP_printk("inode =3D %p ino =3D %llu block =3D %lu",
> >  		      __entry->inode,
> >  		      __entry->ino,
> >  		      __entry->block)
> > @@ -190,7 +190,7 @@ TRACE_EVENT(nilfs2_mdt_insert_new_block,
> > =20
> >  TRACE_EVENT(nilfs2_mdt_submit_block,
> >  	    TP_PROTO(struct inode *inode,
> > -		     unsigned long ino,
> > +		     u64 ino,
> >  		     unsigned long blkoff,
> >  		     enum req_op mode),
> > =20
> > @@ -198,7 +198,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
> > =20
> >  	    TP_STRUCT__entry(
> >  		    __field(struct inode *, inode)
> > -		    __field(unsigned long, ino)
> > +		    __field(u64, ino)
> >  		    __field(unsigned long, blkoff)
> >  		    /*
> >  		     * Use field_struct() to avoid is_signed_type() on the
> > @@ -214,7 +214,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
> >  		    __entry->mode =3D mode;
> >  		    ),
> > =20
> > -	    TP_printk("inode =3D %p ino =3D %lu blkoff =3D %lu mode =3D %x",
> > +	    TP_printk("inode =3D %p ino =3D %llu blkoff =3D %lu mode =3D %x",
> >  		      __entry->inode,
> >  		      __entry->ino,
> >  		      __entry->blkoff,

--=20
Jeff Layton <jlayton@kernel.org>

