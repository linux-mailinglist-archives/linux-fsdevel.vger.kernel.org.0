Return-Path: <linux-fsdevel+bounces-79200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AkqLs/Ipmk0TwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:41:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1B41EE340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3210D30101DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A249251E;
	Tue,  3 Mar 2026 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kpuEv/ra";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="giQRaJtY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kpuEv/ra";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="giQRaJtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73684611C9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537621; cv=none; b=n9krDhAlmR7R0HBDkR27O+HNEZc4l/X3gW1ZWK4mwORTvD+eKf7RGcUnWRvnPGRLAPvqy6pScfYaud3kI3m4CHX8EDvcgLzcWP64XrLXTliXpvOpD8eYVPDOF5neiML296O+mA6gWV5sb1eOcqZpVxMwQ1eI3+flSDuk2HNTjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537621; c=relaxed/simple;
	bh=NE9KgfDeflqauL9GRJRkXfuHM1LG/Soun4s/NYJftv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbmo1zAe9k4onC/36FLc++iKB9P7ylPcG/XI5AEf9SsBFOLbn6H8wad7DttPtocZZKNLtwB7jCsxwgKjJhzwxou7RkFNdX2nyH57qwYC5OzZ8LUmSOy7StvfzFSw5NybaexIdagX30phx+DExLglN89Y+Nj0DzAP5T94zo27BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kpuEv/ra; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=giQRaJtY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kpuEv/ra; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=giQRaJtY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 080683F8CE;
	Tue,  3 Mar 2026 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4DdREtNiJiOQrLwoyUgGYussCYHVyIxoDajXjekPXE=;
	b=kpuEv/raO0eFZTfGUyM+Zp0J3N8d/BUc56ofJM3npHqMnUodITGE00WQXx2aJzIh8OmGRi
	djUl98VPvFOmJaF3RG8TbY14u/wNVNsNbpO2KCdHXd2JhDtNcahijqb6GinSQeIx2YF7dS
	RGFXs8NFjCMxKc9DFVPaDzIwBAIpxzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4DdREtNiJiOQrLwoyUgGYussCYHVyIxoDajXjekPXE=;
	b=giQRaJtY2xPj1wOFq6Fa2xMiBEgSBCEyj1CDFiY1PGUtyx5b36SikfpUlOrmAycGcKKEg1
	gOFGyXQ4XTv9MECg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="kpuEv/ra";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=giQRaJtY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4DdREtNiJiOQrLwoyUgGYussCYHVyIxoDajXjekPXE=;
	b=kpuEv/raO0eFZTfGUyM+Zp0J3N8d/BUc56ofJM3npHqMnUodITGE00WQXx2aJzIh8OmGRi
	djUl98VPvFOmJaF3RG8TbY14u/wNVNsNbpO2KCdHXd2JhDtNcahijqb6GinSQeIx2YF7dS
	RGFXs8NFjCMxKc9DFVPaDzIwBAIpxzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4DdREtNiJiOQrLwoyUgGYussCYHVyIxoDajXjekPXE=;
	b=giQRaJtY2xPj1wOFq6Fa2xMiBEgSBCEyj1CDFiY1PGUtyx5b36SikfpUlOrmAycGcKKEg1
	gOFGyXQ4XTv9MECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E88EB3EA69;
	Tue,  3 Mar 2026 11:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QtXAOAvHpmncUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:33:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ADD8FA0A1B; Tue,  3 Mar 2026 12:33:27 +0100 (CET)
Date: Tue, 3 Mar 2026 12:33:27 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jan Kara <jack@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, 
	Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anders Larsen <al@alarsen.net>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, 
	Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org, 
	netfs@lists.linux.dev, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-afs@lists.infradead.org, autofs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 082/110] ext2: replace PRIino with %llu/%llx format
 strings
Message-ID: <632zh5igh5dlniw2aboh23enl34csbfb5oizz4udz2mca55rxc@ncjzx2adt5za>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-82-e5388800dae0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-82-e5388800dae0@kernel.org>
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 9C1B41EE340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79200-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
 g];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 15:25:06, Jeff Layton wrote:
> Now that i_ino is u64 and the PRIino format macro has been removed,
> replace all uses in ext2 with the concrete format strings.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/dir.c    | 10 +++++-----
>  fs/ext2/ialloc.c |  2 +-
>  fs/ext2/inode.c  |  2 +-
>  fs/ext2/xattr.c  | 14 +++++++-------
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index f87106907da31bb7c1ca65c0ec2dcc0d47d27c62..278d4be8ecbe7790204b5ba985a7ce088fadb181 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -141,7 +141,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  Ebadsize:
>  	if (!quiet)
>  		ext2_error(sb, __func__,
> -			"size of directory #%" PRIino "u is not a multiple "
> +			"size of directory #%llu is not a multiple "
>  			"of chunk size", dir->i_ino);
>  	goto fail;
>  Eshort:
> @@ -160,7 +160,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  	error = "inode out of bounds";
>  bad_entry:
>  	if (!quiet)
> -		ext2_error(sb, __func__, "bad entry in directory #%" PRIino "u: : %s - "
> +		ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
>  			"offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
>  			dir->i_ino, error, folio_pos(folio) + offs,
>  			(unsigned long) le32_to_cpu(p->inode),
> @@ -170,7 +170,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  	if (!quiet) {
>  		p = (ext2_dirent *)(kaddr + offs);
>  		ext2_error(sb, "ext2_check_folio",
> -			"entry in directory #%" PRIino "u spans the page boundary"
> +			"entry in directory #%llu spans the page boundary"
>  			"offset=%llu, inode=%lu",
>  			dir->i_ino, folio_pos(folio) + offs,
>  			(unsigned long) le32_to_cpu(p->inode));
> @@ -281,7 +281,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
>  
>  		if (IS_ERR(kaddr)) {
>  			ext2_error(sb, __func__,
> -				   "bad page in #%" PRIino "u",
> +				   "bad page in #%llu",
>  				   inode->i_ino);
>  			ctx->pos += PAGE_SIZE - offset;
>  			return PTR_ERR(kaddr);
> @@ -383,7 +383,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  		/* next folio is past the blocks we've got */
>  		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
>  			ext2_error(dir->i_sb, __func__,
> -				"dir %" PRIino "u size %lld exceeds block count %llu",
> +				"dir %llu size %lld exceeds block count %llu",
>  				dir->i_ino, dir->i_size,
>  				(unsigned long long)dir->i_blocks);
>  			goto out;
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index 6a317411e54191578343308b5a3990aea9c36436..bf21b57cf98cd5f90e1177454a8fd5cca482c2f8 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -590,7 +590,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
>  		goto fail_free_drop;
>  
>  	mark_inode_dirty(inode);
> -	ext2_debug("allocating inode %" PRIino "u\n", inode->i_ino);
> +	ext2_debug("allocating inode %llu\n", inode->i_ino);
>  	ext2_preread_inode(inode);
>  	return inode;
>  
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 0ca9148583646812b478f01fd35bcad11498f951..45286c0c3b6b8f86a1ecec0e2f545c5a678dd6ac 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1152,7 +1152,7 @@ static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int de
>  			 */ 
>  			if (!bh) {
>  				ext2_error(inode->i_sb, "ext2_free_branches",
> -					"Read failure, inode=%" PRIino "u, block=%ld",
> +					"Read failure, inode=%llu, block=%ld",
>  					inode->i_ino, nr);
>  				continue;
>  			}
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 4b3dadc0a2a47c85682d9c74edb900cf0f20996f..14ada70db36a76d1436944a3622e5caf0b373b9e 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -227,7 +227,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
>  	if (!ext2_xattr_header_valid(HDR(bh))) {
>  bad_block:
>  		ext2_error(inode->i_sb, "ext2_xattr_get",
> -			"inode %" PRIino "u: bad block %d", inode->i_ino,
> +			"inode %llu: bad block %d", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		error = -EIO;
>  		goto cleanup;
> @@ -313,7 +313,7 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	if (!ext2_xattr_header_valid(HDR(bh))) {
>  bad_block:
>  		ext2_error(inode->i_sb, "ext2_xattr_list",
> -			"inode %" PRIino "u: bad block %d", inode->i_ino,
> +			"inode %llu: bad block %d", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		error = -EIO;
>  		goto cleanup;
> @@ -454,7 +454,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		if (!ext2_xattr_header_valid(header)) {
>  bad_block:
>  			ext2_error(sb, "ext2_xattr_set",
> -				"inode %" PRIino "u: bad block %d", inode->i_ino,
> +				"inode %llu: bad block %d", inode->i_ino,
>  				   EXT2_I(inode)->i_file_acl);
>  			error = -EIO;
>  			goto cleanup;
> @@ -833,7 +833,7 @@ ext2_xattr_delete_inode(struct inode *inode)
>  
>  	if (!ext2_data_block_valid(sbi, EXT2_I(inode)->i_file_acl, 1)) {
>  		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> -			"inode %" PRIino "u: xattr block %d is out of data blocks range",
> +			"inode %llu: xattr block %d is out of data blocks range",
>  			inode->i_ino, EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
> @@ -841,14 +841,14 @@ ext2_xattr_delete_inode(struct inode *inode)
>  	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
>  	if (!bh) {
>  		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> -			"inode %" PRIino "u: block %d read error", inode->i_ino,
> +			"inode %llu: block %d read error", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
>  	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
>  	if (!ext2_xattr_header_valid(HDR(bh))) {
>  		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> -			"inode %" PRIino "u: bad block %d", inode->i_ino,
> +			"inode %llu: bad block %d", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
> @@ -952,7 +952,7 @@ ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
>  		bh = sb_bread(inode->i_sb, ce->e_value);
>  		if (!bh) {
>  			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
> -				"inode %" PRIino "u: block %ld read error",
> +				"inode %llu: block %ld read error",
>  				inode->i_ino, (unsigned long) ce->e_value);
>  		} else {
>  			lock_buffer(bh);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

