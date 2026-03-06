Return-Path: <linux-fsdevel+bounces-79593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK7/KBLEqmnhWwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:09:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DECD22036C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549EA313091E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49D38F25B;
	Fri,  6 Mar 2026 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCjBLVlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E63815E4;
	Fri,  6 Mar 2026 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798614; cv=none; b=U5EuB+a3ys7VQ28qqJozNh6iajgiRSjUEZe3hPqYwb4zakSK3Cy8LxoW2W6XkGgO60GUVcfydSFs7S40Bh7HmrzZbIU5I9SnoKeiHpCh65WZV0R8496xYU43SzZ/8WYzTvch2w+HemKtw3/+tl2dY1tjY1HQn/Sm6fg6jC/GYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798614; c=relaxed/simple;
	bh=CzoqwvSAeRfK44X4Sq+CvuqCGufXKFog8r6S8FJOxVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f8U5qjJOB6Qa3ZrRhhxLmYZBy6joJV7uEreoY6X8rxboHZ/LotIz7GNFDJlnZKQTyCmI/l8uBdkl52xigwoGVudKq9sqvlacEdIMLwEhrmBxpadf8HwdS0SLgQiQaYqPgNUX92CJmz+41flZLkSlj6zQCUkrrdFKpNNniMWRjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCjBLVlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1420C2BCB7;
	Fri,  6 Mar 2026 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772798613;
	bh=CzoqwvSAeRfK44X4Sq+CvuqCGufXKFog8r6S8FJOxVw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PCjBLVlDFqG1oBbiQd+HrQ8rEG3m21Qiku684yY84WX7GTtS+y22sDcetMx6fqlDG
	 LyaV2QWfjEjHKnaTBhb2ZyNX9SFxkrcFxd8xmBSw10TVnHnhS0zklAYvDZWfy1MhCv
	 EqAAKKPvBAf8/leoZU2xyvvUC2H2ff6epkVxlixuQAdN30RqgGAAANDm6+QgRlIONP
	 nSZFLHXIxiEEdhVxKiUpBs4MgDfHXlWKg6jpYf1CJ6BWin5R9K6G5kaUjvZWbwwqHc
	 /GlMSkLIs98hGrKPSpz99NUzB1chQOGo7EfaFgQI/brIj9+nBjb2M5ZbjJGNoDObHM
	 NMEjDVji5mrvw==
Message-ID: <c1845a4b8d35d367953ac6cbfcf91ac36958ba51.camel@kernel.org>
Subject: Re: [PATCH v3 01/12] vfs: widen inode hash/lookup functions to u64
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams
 <dan.j.williams@intel.com>, Eric Biggers	 <ebiggers@kernel.org>, "Theodore
 Y. Ts'o" <tytso@mit.edu>, Muchun Song	 <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, David Hildenbrand	 <david@kernel.org>, David
 Howells <dhowells@redhat.com>, Paulo Alcantara	 <pc@manguebit.org>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Jan Kara	 <jack@suse.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,  Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>,  NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,  Tom Talpey
 <tom@talpey.com>, Steve French <sfrench@samba.org>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>,  Shyam Prasad N <sprasad@microsoft.com>,
 Bharath SM <bharathsm@microsoft.com>, Alexander Aring	
 <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko	 <slava@dubeyko.com>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov	 <lucho@ionkov.net>, Dominique
 Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, Marc Dionne	
 <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de
 Bethencourt	 <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian"	 <aivazian.tigran@gmail.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze	 <amarkuze@redhat.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,  Nicolas Pitre <nico@fluxnic.net>,
 Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
 <frank.li@vivo.com>, Mikulas Patocka	 <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>,  Richard Weinberger	
 <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, Konstantin Komarov	
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mike Marshall	 <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Miklos Szeredi	 <miklos@szeredi.hu>, Anders Larsen
 <al@alarsen.net>, Zhihao Cheng	 <chengzhihao1@huawei.com>, Damien Le Moal
 <dlemoal@kernel.org>, Naohiro Aota	 <naohiro.aota@wdc.com>, Johannes
 Thumshirn <jth@kernel.org>, John Johansen	 <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Mimi Zohar	 <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Fan
 Wu	 <wufan@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Alex Deucher	 <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Eric Dumazet	 <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller"	 <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman	 <horms@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra	 <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland	 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>,  James Clark <james.clark@linaro.org>, "Darrick
 J. Wong" <djwong@kernel.org>, Martin Schiller <ms@dev.tdt.de>,  Eric Paris
 <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann
 <marcel@holtmann.org>,  Johan Hedberg <johan.hedberg@gmail.com>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp	
 <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, David
 Ahern	 <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, Steffen
 Klassert	 <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,  Remi Denis-Courmont	 <courmisch@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,  Xin Long
 <lucien.xin@gmail.com>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski	 <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer	 <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, 	fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, 	linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, 	linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, 	samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, 	v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, 	linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, 	ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, 	audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, 	linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 06 Mar 2026 07:03:15 -0500
In-Reply-To: <aamSFgXhrORAJLBC@infradead.org>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
	 <20260304-iino-u64-v3-1-2257ad83d372@kernel.org>
	 <aamSFgXhrORAJLBC@infradead.org>
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
X-Rspamd-Queue-Id: 4DECD22036C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,infradead.org,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
 g];
	TAGGED_FROM(0.00)[bounces-79593-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[170];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

On Thu, 2026-03-05 at 06:24 -0800, Christoph Hellwig wrote:
> > =C2=A0extern struct inode *ilookup5_nowait(struct super_block *sb,
> > -		unsigned long hashval, int (*test)(struct inode *, void *),
> > +		u64 hashval, int (*test)(struct inode *, void *),
> > =C2=A0		void *data, bool *isnew);
> > -extern struct inode *ilookup5(struct super_block *sb, unsigned long ha=
shval,
> > +extern struct inode *ilookup5(struct super_block *sb, u64 hashval,
> > =C2=A0		int (*test)(struct inode *, void *), void *data);
>=20
> ...
>=20
> Can you please drop all these pointless externs while you're at it?
>=20

I was planning to do that, but then Christian merged it!

I'll do a patch on top of this that does this in the range of fs.h that
the patch touches. Christian can throw it on top of the series, and
that shouldn't be too bad for backports.

> Otherwise looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

