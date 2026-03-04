Return-Path: <linux-fsdevel+bounces-79320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNt3M1bRp2lrkAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 07:29:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6758B1FB28A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 07:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CB330D2EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 06:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BF38229B;
	Wed,  4 Mar 2026 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QGqGuB1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oyBs4Cid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557A37FF61;
	Wed,  4 Mar 2026 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605679; cv=none; b=J+6lWQVeiOeom71q4u9g+OYBMoV2pDjpl0v1Ks1FxvqOP4Z6hAOL4gdS0QJzItwxf7BdEZpx9harDXba05CE/N4HVAJjtxkiO8lP+7kdKjpqY/cA8HrpPJ+xVNoTxuiz5zI2LZMC8wtyynO6iagrvTAdIv7/MtgrjG0oTs1Fmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605679; c=relaxed/simple;
	bh=r4qocZurAwsI94u1up+Vdusek7Vi5253Hd7N48BDko4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NNcPsvT/SXIPEaC4J9rxwf12NuytDrrqcJuzg+LZ+EV2yxDekV6ziDVjvYXWowAQF8SqD+7qLzzJ/BAw8ueSFGo+K6WT7nvMfgrKZ85JQBCtU9xj2ApDC1Qg6vvI94D5PcYufVWh/z9O8wGRzgIMp42t9t7ZSMDwNFIBcvt9LN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QGqGuB1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oyBs4Cid; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id C99AF1380E87;
	Wed,  4 Mar 2026 01:27:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Mar 2026 01:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772605675; x=1772612875; bh=5+RTgashw6751XVNDWQdZH+Q/6MhJxiaQle
	0ycbNIPA=; b=QGqGuB1HfRnACei6sx6c+uNgMwLaYwouTEpFj2VP0mlDfEqPtRY
	hq1PRy4CBOv70+oVSYpqqZpM0oM/LMhJunekgV3eBzmsgcDG0OI2C4tzloWCpVvl
	4i3VE4LhXttp25s0ZK9pW3oyxGl321uWgHvjWqgL414piiUtcU8j/RBBg3lpxTfz
	hyOETJnm1GZ3Vny7khF6LstdjtjpNA05Sn0+69teOfVwM8bTgFFfpYoCWjZ2d4gj
	zJQVyFRZl/QUmgQAY8aclFxSMlCDdqzk+ns1JfsxU4GqHtILyAxxV1rlJifkZ7nV
	XCXCXCRkAeoUwFwEPnGvyan/ZZjUaQt5PAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772605675; x=
	1772612875; bh=5+RTgashw6751XVNDWQdZH+Q/6MhJxiaQle0ycbNIPA=; b=o
	yBs4Cidn0fowkiQNkfBBbpvMteFnmb6KK9N9BnOLF7DAXMw7rLEfq8O8XkeXs0++
	AItJEKwgOy6+J2k0jKmt5y/gjZkZygq6/z20y552PqK0SvgaS8EPmsW6WcRrV1pP
	Cka6lApHFX3ajwbAqxHOCPa0WJuwpyjOxVf4rBBc72uzD/6CW2235GcM//0i19W8
	7L5pQzsL0OaBqS4U5vUHJiQNiyzDfXHteA0Tj9OpC2tpQ91dxDiKNGlVpY+sXR+u
	F/1B+M7f+72ADS4w6cTGLYwsrCBQ9Ty53UNfXLWsSJmwJfMdphzrO6855O9pzOSm
	tL559XeFSYE02Ng/iW/iA==
X-ME-Sender: <xms:4tCnaSNbDrQ_gxgn-FDSHw2lZNLRjN-bQWFxNuyRrlsjf6GtgESQmg>
    <xme:4tCnacDbxasyEcYHsybPZFFbKL0qOs4hHCyDZ8PnwLz-6RsB4wLBwEgkGnXcsPOlZ
    vDBEl8eoy7hp-6BzaC204ogbJpjXhIDJYl7RZzbFer_2uIshg>
X-ME-Received: <xmr:4tCnaYoX3ksWGbwPjYXqqxsqc0TduUwk20wMvX7c0reLYwrKoLdGz80eJTir0A1PtkE58RYexQ3nSkgmperFT043a9PjJpOJNYr5279CEe3n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudejuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh
    dprhgtphhtthhopehjrhgvuhhtvghrseihrghinhgrrdguvgdprhgtphhtthhopehnrgho
    hhhirhhordgrohhtrgesfigutgdrtghomhdprhgtphhtthhopehfrhgrnhhkrdhlihesvh
    hivhhordgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqgidvheesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4tCnaVnhO8CafOSbZVc9pJUxfys9OoZeY1Z5ndlwHjH7CSajOCGlDw>
    <xmx:4tCnafRh4kpYARpWLK-yCUUMUT7nS6ebAyXQDsGD0JLDF2Tv3K7JJQ>
    <xmx:4tCnac5DU4GRJRJMC10qjpWx3MESrDXeWNEaJqiwQejNUX5p7MDMMw>
    <xmx:4tCnaZg3__L3okNus_55Ab1m3xjLlY3uKakknX-vQwxPKM6XDQv_Ng>
    <xmx:69CnafTUulKHVEiWHbvsFlAmyCSQisz6ZPFKNRFf-ai8k8007x9TdQYK>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 01:27:03 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>,
 "David Hildenbrand" <david@kernel.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Steve French" <sfrench@samba.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Sterba" <dsterba@suse.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Ian Kent" <raven@themaw.net>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, "Nicolas Pitre" <nico@fluxnic.net>,
 "Tyler Hicks" <code@tyhicks.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Yangtao Li" <frank.li@vivo.com>,
 "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Dave Kleikamp" <shaggy@kernel.org>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Anders Larsen" <al@alarsen.net>,
 "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Naohiro Aota" <naohiro.aota@wdc.com>,
 "Johannes Thumshirn" <jth@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Roberto Sassu" <roberto.sassu@huawei.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Fan Wu" <wufan@kernel.org>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>,
 "Darrick J. Wong" <djwong@kernel.org>, "Martin Schiller" <ms@dev.tdt.de>,
 "Eric Paris" <eparis@redhat.com>, "Joerg Reuter" <jreuter@yaina.de>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Johan Hedberg" <johan.hedberg@gmail.com>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 "David Ahern" <dsahern@kernel.org>,
 "Neal Cardwell" <ncardwell@google.com>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Remi Denis-Courmont" <courmisch@gmail.com>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>,
 "Magnus Karlsson" <magnus.karlsson@intel.com>,
 "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 autofs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-hams@vger.kernel.org, linux-x25@vger.kernel.org,
 audit@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-can@vger.kernel.org, linux-sctp@vger.kernel.org,
 bpf@vger.kernel.org
Subject:
 Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long to u64
In-reply-to: <1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>,
 <1787281.1772535332@warthog.procyon.org.uk>,
 <1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
Date: Wed, 04 Mar 2026 17:26:59 +1100
Message-id: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 6758B1FB28A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79320-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,manguebit.org,dilger.ca,suse.com,oracle.com,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,noble.neil.brown.name:mid,brown.name:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026, Jeff Layton wrote:
> On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:
> > Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > > This version splits the change up to be more bisectable. It first adds a
> > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > for format strings. The conversion is done, and then everything is
> > > changed to remove the new macro and typedef.
> > 
> > Why remove the typedef?  It might be better to keep it.
> > 
> 
> Why? After this change, internel kernel inodes will be u64's -- full
> stop. I don't see what the macro or typedef will buy us at that point.

Implicit documentation?
ktime_t is (now) always s64, but we still keep the typedef;

It would be cool if we could teach vsprintf to understand some new
specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
gcc warnings.

NeilBrown

