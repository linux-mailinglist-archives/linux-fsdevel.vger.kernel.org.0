Return-Path: <linux-fsdevel+bounces-79471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNUHFVlVqWng5gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:05:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 122AC20F519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCD031419F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18BF37C11D;
	Thu,  5 Mar 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9QSzsMk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kL25MtBB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9QSzsMk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kL25MtBB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7537BE62
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704727; cv=none; b=pla6rE+zvPLdVaLOV7bBTuR+C6zc/gRMJz8cjbWq7FmMR83ZWXavOs886USYbrubXpUo/T3g6NP051nHCrMPXcyBLJYIGMGtcN+ZC7ecNI9QmBal8vHutRm8crob68m9IGrCDenvC5AoXz0x0LChEAUVEa+w4YflnW3bNrnUjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704727; c=relaxed/simple;
	bh=iIlB1mirXsO0NzWSB6uBFFiaReps4+oedtealSrty/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUsLkldyOlyf3+rd8M7rRO/337XfunAAQVD8IOu4/zTNDix0bwi5sDI3kCNdA6S61Dhgldfm1g5dv8pDy0QuxppE+8Y2jgDxxUgvN7wQ6YqQ9pEC8V5mTQSHQzErTSBQO21sE08sfWjsog1CzyKTOR5GY5Gt69OxtkYnKHgwL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9QSzsMk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kL25MtBB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9QSzsMk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kL25MtBB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D0123F797;
	Thu,  5 Mar 2026 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772704678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R5YS0xVSKzvTyHQUUGHDMAz4YcVu3Z1AbwgnnFImhgk=;
	b=J9QSzsMkwET5wU5KJs96ToQvbKG5ckz08HnISUEB/1f/tscQ6qk0RjH2zDdbIHfXBFfU2f
	Z/krH37uyUYC2z8BnZUfIcbbYCQDM29cSO/6L10Ursk15gPLyIQ7F6gebR6NwzBzFdUSUA
	C1PZmRI0GUVKF3+Kd/IXNCLtrmubAeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772704678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R5YS0xVSKzvTyHQUUGHDMAz4YcVu3Z1AbwgnnFImhgk=;
	b=kL25MtBBdzEIHYy7DpRNZAkIvSRbB+WzVaRTW7mEFbq7NQCe+WqbP+MLkp7wuAOZKBBHv/
	wOzp+CuvxO59LACg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J9QSzsMk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kL25MtBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772704678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R5YS0xVSKzvTyHQUUGHDMAz4YcVu3Z1AbwgnnFImhgk=;
	b=J9QSzsMkwET5wU5KJs96ToQvbKG5ckz08HnISUEB/1f/tscQ6qk0RjH2zDdbIHfXBFfU2f
	Z/krH37uyUYC2z8BnZUfIcbbYCQDM29cSO/6L10Ursk15gPLyIQ7F6gebR6NwzBzFdUSUA
	C1PZmRI0GUVKF3+Kd/IXNCLtrmubAeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772704678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R5YS0xVSKzvTyHQUUGHDMAz4YcVu3Z1AbwgnnFImhgk=;
	b=kL25MtBBdzEIHYy7DpRNZAkIvSRbB+WzVaRTW7mEFbq7NQCe+WqbP+MLkp7wuAOZKBBHv/
	wOzp+CuvxO59LACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 555153EA78;
	Thu,  5 Mar 2026 09:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KqRJFKZTqWnQTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 09:57:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC35BA0AB1; Thu,  5 Mar 2026 10:57:57 +0100 (CET)
Date: Thu, 5 Mar 2026 10:57:57 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dan Williams <dan.j.williams@intel.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Alexander Aring <alex.aring@gmail.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Nicolas Pitre <nico@fluxnic.net>, 
	Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
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
Subject: Re: [PATCH v3 12/12] treewide: change inode->i_ino from unsigned
 long to u64
Message-ID: <2xc4m6xcdusas6gwk6p2ju2qubxf3is24ezylhiz6s5lmdhwvs@5iltpyifcrzx>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
 <20260304-iino-u64-v3-12-2257ad83d372@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-iino-u64-v3-12-2257ad83d372@kernel.org>
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 122AC20F519
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79471-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,str.name:url,vaf.va:url,iloc.bh:url];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
 g];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 10:32:42, Jeff Layton wrote:
> On 32-bit architectures, unsigned long is only 32 bits wide, which
> causes 64-bit inode numbers to be silently truncated. Several
> filesystems (NFS, XFS, BTRFS, etc.) can generate inode numbers that
> exceed 32 bits, and this truncation can lead to inode number collisions
> and other subtle bugs on 32-bit systems.
> 
> Change the type of inode->i_ino from unsigned long to u64 to ensure that
> inode numbers are always represented as 64-bit values regardless of
> architecture. Update all format specifiers treewide from %lu/%lx to
> %llu/%llx to match the new type, along with corresponding local variable
> types.
> 
> This is the bulk treewide conversion. Earlier patches in this series
> handled trace events separately to allow trace field reordering for
> better struct packing on 32-bit.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've reviewed the VFS, ext2, ext4, ocfs2, udf, isofs, jdb2, minix,
fsnotify, and proc bits and they look good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/dma-buf/dma-buf.c                  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 +--
>  fs/9p/vfs_addr.c                           |  4 +--
>  fs/9p/vfs_inode.c                          |  6 ++--
>  fs/9p/vfs_inode_dotl.c                     |  6 ++--
>  fs/affs/amigaffs.c                         | 10 +++----
>  fs/affs/bitmap.c                           |  2 +-
>  fs/affs/dir.c                              |  2 +-
>  fs/affs/file.c                             | 20 ++++++-------
>  fs/affs/inode.c                            | 12 ++++----
>  fs/affs/namei.c                            | 14 ++++-----
>  fs/affs/symlink.c                          |  2 +-
>  fs/afs/dir.c                               | 10 +++----
>  fs/afs/dir_search.c                        |  2 +-
>  fs/afs/dynroot.c                           |  2 +-
>  fs/afs/inode.c                             |  2 +-
>  fs/autofs/inode.c                          |  2 +-
>  fs/befs/linuxvfs.c                         | 28 ++++++++---------
>  fs/bfs/dir.c                               |  4 +--
>  fs/cachefiles/io.c                         |  6 ++--
>  fs/cachefiles/namei.c                      | 12 ++++----
>  fs/cachefiles/xattr.c                      |  2 +-
>  fs/ceph/crypto.c                           |  4 +--
>  fs/coda/dir.c                              |  2 +-
>  fs/coda/inode.c                            |  2 +-
>  fs/cramfs/inode.c                          |  2 +-
>  fs/crypto/crypto.c                         |  2 +-
>  fs/crypto/hooks.c                          |  2 +-
>  fs/crypto/keyring.c                        |  4 +--
>  fs/crypto/keysetup.c                       |  2 +-
>  fs/dcache.c                                |  4 +--
>  fs/ecryptfs/crypto.c                       |  6 ++--
>  fs/ecryptfs/file.c                         |  2 +-
>  fs/efs/inode.c                             |  6 ++--
>  fs/eventpoll.c                             |  2 +-
>  fs/exportfs/expfs.c                        |  4 +--
>  fs/ext2/dir.c                              | 10 +++----
>  fs/ext2/ialloc.c                           |  9 +++---
>  fs/ext2/inode.c                            |  2 +-
>  fs/ext2/xattr.c                            | 14 ++++-----
>  fs/ext4/dir.c                              |  2 +-
>  fs/ext4/ext4.h                             |  4 +--
>  fs/ext4/extents.c                          |  8 ++---
>  fs/ext4/extents_status.c                   | 28 ++++++++---------
>  fs/ext4/fast_commit.c                      |  8 ++---
>  fs/ext4/ialloc.c                           | 10 +++----
>  fs/ext4/indirect.c                         |  2 +-
>  fs/ext4/inline.c                           | 14 ++++-----
>  fs/ext4/inode.c                            | 22 +++++++-------
>  fs/ext4/ioctl.c                            |  4 +--
>  fs/ext4/mballoc.c                          |  6 ++--
>  fs/ext4/migrate.c                          |  2 +-
>  fs/ext4/move_extent.c                      | 20 ++++++-------
>  fs/ext4/namei.c                            | 10 +++----
>  fs/ext4/orphan.c                           | 16 +++++-----
>  fs/ext4/page-io.c                          | 10 +++----
>  fs/ext4/super.c                            | 22 +++++++-------
>  fs/ext4/xattr.c                            | 10 +++----
>  fs/f2fs/compress.c                         |  4 +--
>  fs/f2fs/dir.c                              |  2 +-
>  fs/f2fs/extent_cache.c                     |  8 ++---
>  fs/f2fs/f2fs.h                             |  6 ++--
>  fs/f2fs/file.c                             | 12 ++++----
>  fs/f2fs/gc.c                               |  2 +-
>  fs/f2fs/inline.c                           |  4 +--
>  fs/f2fs/inode.c                            | 48 +++++++++++++++---------------
>  fs/f2fs/namei.c                            |  8 ++---
>  fs/f2fs/node.c                             | 10 +++----
>  fs/f2fs/recovery.c                         | 10 +++----
>  fs/f2fs/xattr.c                            | 10 +++----
>  fs/freevxfs/vxfs_bmap.c                    |  4 +--
>  fs/fserror.c                               |  2 +-
>  fs/hfs/catalog.c                           |  2 +-
>  fs/hfs/extent.c                            |  4 +--
>  fs/hfs/inode.c                             |  4 +--
>  fs/hfsplus/attributes.c                    | 10 +++----
>  fs/hfsplus/catalog.c                       |  2 +-
>  fs/hfsplus/dir.c                           |  6 ++--
>  fs/hfsplus/extents.c                       |  6 ++--
>  fs/hfsplus/inode.c                         |  8 ++---
>  fs/hfsplus/super.c                         |  6 ++--
>  fs/hfsplus/xattr.c                         | 10 +++----
>  fs/hpfs/dir.c                              |  4 +--
>  fs/hpfs/dnode.c                            |  4 +--
>  fs/hpfs/ea.c                               |  4 +--
>  fs/hpfs/inode.c                            |  4 +--
>  fs/inode.c                                 | 13 ++++----
>  fs/iomap/ioend.c                           |  2 +-
>  fs/isofs/compress.c                        |  2 +-
>  fs/isofs/dir.c                             |  2 +-
>  fs/isofs/inode.c                           |  6 ++--
>  fs/isofs/namei.c                           |  2 +-
>  fs/jbd2/journal.c                          |  4 +--
>  fs/jbd2/transaction.c                      |  2 +-
>  fs/jffs2/dir.c                             |  4 +--
>  fs/jffs2/file.c                            |  4 +--
>  fs/jffs2/fs.c                              | 18 +++++------
>  fs/jfs/inode.c                             |  2 +-
>  fs/jfs/jfs_imap.c                          |  2 +-
>  fs/jfs/jfs_metapage.c                      |  2 +-
>  fs/lockd/svclock.c                         |  8 ++---
>  fs/lockd/svcsubs.c                         |  2 +-
>  fs/locks.c                                 |  6 ++--
>  fs/minix/inode.c                           | 10 +++----
>  fs/nfs/dir.c                               | 20 ++++++-------
>  fs/nfs/file.c                              |  8 ++---
>  fs/nfs/filelayout/filelayout.c             |  8 ++---
>  fs/nfs/flexfilelayout/flexfilelayout.c     |  8 ++---
>  fs/nfs/inode.c                             |  6 ++--
>  fs/nfs/nfs4proc.c                          |  4 +--
>  fs/nfs/pnfs.c                              | 12 ++++----
>  fs/nfsd/export.c                           |  2 +-
>  fs/nfsd/nfs4state.c                        |  4 +--
>  fs/nfsd/nfsfh.c                            |  4 +--
>  fs/nfsd/vfs.c                              |  2 +-
>  fs/nilfs2/alloc.c                          | 10 +++----
>  fs/nilfs2/bmap.c                           |  2 +-
>  fs/nilfs2/btnode.c                         |  2 +-
>  fs/nilfs2/btree.c                          | 12 ++++----
>  fs/nilfs2/dir.c                            | 12 ++++----
>  fs/nilfs2/direct.c                         |  4 +--
>  fs/nilfs2/gcinode.c                        |  2 +-
>  fs/nilfs2/inode.c                          |  8 ++---
>  fs/nilfs2/mdt.c                            |  2 +-
>  fs/nilfs2/namei.c                          |  2 +-
>  fs/nilfs2/segment.c                        |  2 +-
>  fs/notify/fdinfo.c                         |  4 +--
>  fs/nsfs.c                                  |  4 +--
>  fs/ntfs3/super.c                           |  2 +-
>  fs/ocfs2/alloc.c                           |  2 +-
>  fs/ocfs2/aops.c                            |  4 +--
>  fs/ocfs2/dir.c                             |  8 ++---
>  fs/ocfs2/dlmfs/dlmfs.c                     | 10 +++----
>  fs/ocfs2/extent_map.c                      | 12 ++++----
>  fs/ocfs2/inode.c                           |  2 +-
>  fs/ocfs2/quota_local.c                     |  2 +-
>  fs/ocfs2/refcounttree.c                    | 10 +++----
>  fs/ocfs2/xattr.c                           |  4 +--
>  fs/orangefs/inode.c                        |  2 +-
>  fs/overlayfs/export.c                      |  2 +-
>  fs/overlayfs/namei.c                       |  4 +--
>  fs/overlayfs/util.c                        |  2 +-
>  fs/pipe.c                                  |  2 +-
>  fs/proc/fd.c                               |  2 +-
>  fs/proc/task_mmu.c                         |  4 +--
>  fs/qnx4/inode.c                            |  4 +--
>  fs/qnx6/inode.c                            |  2 +-
>  fs/ubifs/debug.c                           |  8 ++---
>  fs/ubifs/dir.c                             | 28 ++++++++---------
>  fs/ubifs/file.c                            | 28 ++++++++---------
>  fs/ubifs/journal.c                         |  6 ++--
>  fs/ubifs/super.c                           | 16 +++++-----
>  fs/ubifs/tnc.c                             |  4 +--
>  fs/ubifs/xattr.c                           | 14 ++++-----
>  fs/udf/directory.c                         | 18 +++++------
>  fs/udf/file.c                              |  2 +-
>  fs/udf/inode.c                             | 12 ++++----
>  fs/udf/namei.c                             |  8 ++---
>  fs/udf/super.c                             |  2 +-
>  fs/ufs/balloc.c                            |  6 ++--
>  fs/ufs/dir.c                               | 10 +++----
>  fs/ufs/ialloc.c                            |  6 ++--
>  fs/ufs/inode.c                             | 18 +++++------
>  fs/ufs/ufs_fs.h                            |  6 ++--
>  fs/ufs/util.c                              |  2 +-
>  fs/verity/init.c                           |  2 +-
>  fs/zonefs/super.c                          |  8 ++---
>  include/linux/fs.h                         |  2 +-
>  kernel/events/uprobes.c                    |  4 +--
>  net/netrom/af_netrom.c                     |  4 +--
>  net/rose/af_rose.c                         |  4 +--
>  net/socket.c                               |  2 +-
>  net/x25/x25_proc.c                         |  4 +--
>  security/apparmor/apparmorfs.c             |  4 +--
>  security/integrity/integrity_audit.c       |  2 +-
>  security/ipe/audit.c                       |  2 +-
>  security/lsm_audit.c                       | 10 +++----
>  security/selinux/hooks.c                   | 10 +++----
>  security/smack/smack_lsm.c                 | 12 ++++----
>  179 files changed, 607 insertions(+), 607 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 11711874a325b954940fb289f09936de0152e683..8c16c8c425cc84cf379d7f790d054e140471c8ac 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1708,7 +1708,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  
>  
>  		spin_lock(&buf_obj->name_lock);
> -		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
> +		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08llu\t%s\n",
>  				buf_obj->size,
>  				buf_obj->file->f_flags, buf_obj->file->f_mode,
>  				file_count(buf_obj->file),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1fb95640069667bf731df05990b57c6e0a0d2c16..aaa8cdc122c49ebf0b5b6c55edb3a1db2a4fd710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1676,9 +1676,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>  	attachment = READ_ONCE(bo->tbo.base.import_attach);
>  
>  	if (attachment)
> -		seq_printf(m, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
> +		seq_printf(m, " imported from ino:%llu", file_inode(dma_buf->file)->i_ino);
>  	else if (dma_buf)
> -		seq_printf(m, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
> +		seq_printf(m, " exported as ino:%llu", file_inode(dma_buf->file)->i_ino);
>  
>  	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
>  	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 862164181baca1e88ecf8859c55868bb01525ce1..c21d33830f5f021904f490ab6185db5fd40f736d 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -36,7 +36,7 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
>  
>  	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
>  	if (!fid) {
> -		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
> +		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%llx\n",
>  			  wreq->inode->i_ino);
>  		return;
>  	}
> @@ -133,7 +133,7 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
>  	return 0;
>  
>  no_fid:
> -	WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
> +	WARN_ONCE(1, "folio expected an open fid inode->i_ino=%llx\n",
>  		  rreq->inode->i_ino);
>  	return -EINVAL;
>  }
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 97abe65bf7c1f00e94e431fc69dc5ce647d1742b..d1508b1fe10929d8d847af313f7661d693167d96 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -1245,7 +1245,7 @@ static int
>  v9fs_vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		 struct dentry *dentry, const char *symname)
>  {
> -	p9_debug(P9_DEBUG_VFS, " %lu,%pd,%s\n",
> +	p9_debug(P9_DEBUG_VFS, " %llu,%pd,%s\n",
>  		 dir->i_ino, dentry, symname);
>  
>  	return v9fs_vfs_mkspecial(dir, dentry, P9_DMSYMLINK, symname);
> @@ -1269,7 +1269,7 @@ v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
>  	char name[1 + U32_MAX_DIGITS + 2]; /* sign + number + \n + \0 */
>  	struct p9_fid *oldfid;
>  
> -	p9_debug(P9_DEBUG_VFS, " %lu,%pd,%pd\n",
> +	p9_debug(P9_DEBUG_VFS, " %llu,%pd,%pd\n",
>  		 dir->i_ino, dentry, old_dentry);
>  
>  	oldfid = v9fs_fid_clone(old_dentry);
> @@ -1305,7 +1305,7 @@ v9fs_vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	char name[2 + U32_MAX_DIGITS + 1 + U32_MAX_DIGITS + 1];
>  	u32 perm;
>  
> -	p9_debug(P9_DEBUG_VFS, " %lu,%pd mode: %x MAJOR: %u MINOR: %u\n",
> +	p9_debug(P9_DEBUG_VFS, " %llu,%pd mode: %x MAJOR: %u MINOR: %u\n",
>  		 dir->i_ino, dentry, mode,
>  		 MAJOR(rdev), MINOR(rdev));
>  
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 643e759eacb2a46855c7db6187fe6b29b7534c9a..71796a89bcf4745363b59af1047ecfd7e3f4d956 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -691,7 +691,7 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
>  	struct p9_fid *fid = NULL;
>  
>  	name = dentry->d_name.name;
> -	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
> +	p9_debug(P9_DEBUG_VFS, "%llu,%s,%s\n", dir->i_ino, name, symname);
>  
>  	dfid = v9fs_parent_fid(dentry);
>  	if (IS_ERR(dfid)) {
> @@ -734,7 +734,7 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
>  	struct p9_fid *dfid, *oldfid;
>  	struct v9fs_session_info *v9ses;
>  
> -	p9_debug(P9_DEBUG_VFS, "dir ino: %lu, old_name: %pd, new_name: %pd\n",
> +	p9_debug(P9_DEBUG_VFS, "dir ino: %llu, old_name: %pd, new_name: %pd\n",
>  		 dir->i_ino, old_dentry, dentry);
>  
>  	v9ses = v9fs_inode2v9ses(dir);
> @@ -798,7 +798,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
>  	struct p9_qid qid;
>  	struct posix_acl *dacl = NULL, *pacl = NULL;
>  
> -	p9_debug(P9_DEBUG_VFS, " %lu,%pd mode: %x MAJOR: %u MINOR: %u\n",
> +	p9_debug(P9_DEBUG_VFS, " %llu,%pd mode: %x MAJOR: %u MINOR: %u\n",
>  		 dir->i_ino, dentry, omode,
>  		 MAJOR(rdev), MINOR(rdev));
>  
> diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
> index fd669daa4e7bc951d8d7959c7a5ab1b60b75c61a..d8a96d8cc82645323b210e3ff4796dd789e8f45e 100644
> --- a/fs/affs/amigaffs.c
> +++ b/fs/affs/amigaffs.c
> @@ -33,7 +33,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
>  	ino = bh->b_blocknr;
>  	offset = affs_hash_name(sb, AFFS_TAIL(sb, bh)->name + 1, AFFS_TAIL(sb, bh)->name[0]);
>  
> -	pr_debug("%s(dir=%lu, ino=%d)\n", __func__, dir->i_ino, ino);
> +	pr_debug("%s(dir=%llu, ino=%d)\n", __func__, dir->i_ino, ino);
>  
>  	dir_bh = affs_bread(sb, dir->i_ino);
>  	if (!dir_bh)
> @@ -83,7 +83,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
>  	sb = dir->i_sb;
>  	rem_ino = rem_bh->b_blocknr;
>  	offset = affs_hash_name(sb, AFFS_TAIL(sb, rem_bh)->name+1, AFFS_TAIL(sb, rem_bh)->name[0]);
> -	pr_debug("%s(dir=%lu, ino=%d, hashval=%d)\n", __func__, dir->i_ino,
> +	pr_debug("%s(dir=%llu, ino=%d, hashval=%d)\n", __func__, dir->i_ino,
>  		 rem_ino, offset);
>  
>  	bh = affs_bread(sb, dir->i_ino);
> @@ -128,7 +128,7 @@ affs_fix_dcache(struct inode *inode, u32 entry_ino)
>  	spin_lock(&inode->i_lock);
>  	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
>  		if (entry_ino == (u32)(long)dentry->d_fsdata) {
> -			dentry->d_fsdata = (void *)inode->i_ino;
> +			dentry->d_fsdata = (void *)(unsigned long)inode->i_ino;
>  			break;
>  		}
>  	}
> @@ -147,7 +147,7 @@ affs_remove_link(struct dentry *dentry)
>  	u32 link_ino, ino;
>  	int retval;
>  
> -	pr_debug("%s(key=%ld)\n", __func__, inode->i_ino);
> +	pr_debug("%s(key=%llu)\n", __func__, inode->i_ino);
>  	retval = -EIO;
>  	bh = affs_bread(sb, inode->i_ino);
>  	if (!bh)
> @@ -279,7 +279,7 @@ affs_remove_header(struct dentry *dentry)
>  	if (!inode)
>  		goto done;
>  
> -	pr_debug("%s(key=%ld)\n", __func__, inode->i_ino);
> +	pr_debug("%s(key=%llu)\n", __func__, inode->i_ino);
>  	retval = -EIO;
>  	bh = affs_bread(sb, (u32)(long)dentry->d_fsdata);
>  	if (!bh)
> diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
> index 5ba9ef2742f6ee5e903b3df04c5f627fc4fc00ae..40bc4ce6af4ac9d8dba81809e22516a58f0aaf15 100644
> --- a/fs/affs/bitmap.c
> +++ b/fs/affs/bitmap.c
> @@ -125,7 +125,7 @@ affs_alloc_block(struct inode *inode, u32 goal)
>  	sb = inode->i_sb;
>  	sbi = AFFS_SB(sb);
>  
> -	pr_debug("balloc(inode=%lu,goal=%u): ", inode->i_ino, goal);
> +	pr_debug("balloc(inode=%llu,goal=%u): ", inode->i_ino, goal);
>  
>  	if (AFFS_I(inode)->i_pa_cnt) {
>  		pr_debug("%d\n", AFFS_I(inode)->i_lastalloc+1);
> diff --git a/fs/affs/dir.c b/fs/affs/dir.c
> index 5c8d83387a394146f8df2e97af3b65723a076be1..11e2bac2e391896a32109335530a6af5543a0abe 100644
> --- a/fs/affs/dir.c
> +++ b/fs/affs/dir.c
> @@ -90,7 +90,7 @@ affs_readdir(struct file *file, struct dir_context *ctx)
>  	u32			 ino;
>  	int			 error = 0;
>  
> -	pr_debug("%s(ino=%lu,f_pos=%llx)\n", __func__, inode->i_ino, ctx->pos);
> +	pr_debug("%s(ino=%llu,f_pos=%llx)\n", __func__, inode->i_ino, ctx->pos);
>  
>  	if (ctx->pos < 2) {
>  		data->ino = 0;
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index 6c9258359ddb9ba344976dd5a9a435f71f3fabc1..a51dee9d7d7ec3724c642725812415bd33c76273 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -24,7 +24,7 @@ static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
>  static int
>  affs_file_open(struct inode *inode, struct file *filp)
>  {
> -	pr_debug("open(%lu,%d)\n",
> +	pr_debug("open(%llu,%d)\n",
>  		 inode->i_ino, atomic_read(&AFFS_I(inode)->i_opencnt));
>  	atomic_inc(&AFFS_I(inode)->i_opencnt);
>  	return 0;
> @@ -33,7 +33,7 @@ affs_file_open(struct inode *inode, struct file *filp)
>  static int
>  affs_file_release(struct inode *inode, struct file *filp)
>  {
> -	pr_debug("release(%lu, %d)\n",
> +	pr_debug("release(%llu, %d)\n",
>  		 inode->i_ino, atomic_read(&AFFS_I(inode)->i_opencnt));
>  
>  	if (atomic_dec_and_test(&AFFS_I(inode)->i_opencnt)) {
> @@ -301,7 +301,7 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
>  	struct buffer_head	*ext_bh;
>  	u32			 ext;
>  
> -	pr_debug("%s(%lu, %llu)\n", __func__, inode->i_ino,
> +	pr_debug("%s(%llu, %llu)\n", __func__, inode->i_ino,
>  		 (unsigned long long)block);
>  
>  	BUG_ON(block > (sector_t)0x7fffffffUL);
> @@ -534,7 +534,7 @@ static int affs_do_read_folio_ofs(struct folio *folio, size_t to, int create)
>  	size_t bidx, boff, bsize;
>  	u32 tmp;
>  
> -	pr_debug("%s(%lu, %ld, 0, %zu)\n", __func__, inode->i_ino,
> +	pr_debug("%s(%llu, %ld, 0, %zu)\n", __func__, inode->i_ino,
>  		 folio->index, to);
>  	BUG_ON(to > folio_size(folio));
>  	bsize = AFFS_SB(sb)->s_data_blksize;
> @@ -566,7 +566,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
>  	u32 size, bsize;
>  	u32 tmp;
>  
> -	pr_debug("%s(%lu, %d)\n", __func__, inode->i_ino, newsize);
> +	pr_debug("%s(%llu, %d)\n", __func__, inode->i_ino, newsize);
>  	bsize = AFFS_SB(sb)->s_data_blksize;
>  	bh = NULL;
>  	size = AFFS_I(inode)->mmu_private;
> @@ -634,7 +634,7 @@ static int affs_read_folio_ofs(struct file *file, struct folio *folio)
>  	size_t to;
>  	int err;
>  
> -	pr_debug("%s(%lu, %ld)\n", __func__, inode->i_ino, folio->index);
> +	pr_debug("%s(%llu, %ld)\n", __func__, inode->i_ino, folio->index);
>  	to = folio_size(folio);
>  	if (folio_pos(folio) + to > inode->i_size) {
>  		to = inode->i_size - folio_pos(folio);
> @@ -658,7 +658,7 @@ static int affs_write_begin_ofs(const struct kiocb *iocb,
>  	pgoff_t index;
>  	int err = 0;
>  
> -	pr_debug("%s(%lu, %llu, %llu)\n", __func__, inode->i_ino, pos,
> +	pr_debug("%s(%llu, %llu, %llu)\n", __func__, inode->i_ino, pos,
>  		 pos + len);
>  	if (pos > AFFS_I(inode)->mmu_private) {
>  		/* XXX: this probably leaves a too-big i_size in case of
> @@ -710,7 +710,7 @@ static int affs_write_end_ofs(const struct kiocb *iocb,
>  	 * due to write_begin.
>  	 */
>  
> -	pr_debug("%s(%lu, %llu, %llu)\n", __func__, inode->i_ino, pos,
> +	pr_debug("%s(%llu, %llu, %llu)\n", __func__, inode->i_ino, pos,
>  		 pos + len);
>  	bsize = AFFS_SB(sb)->s_data_blksize;
>  	data = folio_address(folio);
> @@ -854,7 +854,7 @@ affs_free_prealloc(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  
> -	pr_debug("free_prealloc(ino=%lu)\n", inode->i_ino);
> +	pr_debug("free_prealloc(ino=%llu)\n", inode->i_ino);
>  
>  	while (AFFS_I(inode)->i_pa_cnt) {
>  		AFFS_I(inode)->i_pa_cnt--;
> @@ -874,7 +874,7 @@ affs_truncate(struct inode *inode)
>  	struct buffer_head *ext_bh;
>  	int i;
>  
> -	pr_debug("truncate(inode=%lu, oldsize=%llu, newsize=%llu)\n",
> +	pr_debug("truncate(inode=%llu, oldsize=%llu, newsize=%llu)\n",
>  		 inode->i_ino, AFFS_I(inode)->mmu_private, inode->i_size);
>  
>  	last_blk = 0;
> diff --git a/fs/affs/inode.c b/fs/affs/inode.c
> index 0bfc7d151dcd383af31d1fa41723e7391ec9d4c0..561fc0185e89c47947c83bd1a56cdc8be46f8d0e 100644
> --- a/fs/affs/inode.c
> +++ b/fs/affs/inode.c
> @@ -32,7 +32,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
>  	if (!(inode_state_read_once(inode) & I_NEW))
>  		return inode;
>  
> -	pr_debug("affs_iget(%lu)\n", inode->i_ino);
> +	pr_debug("affs_iget(%llu)\n", inode->i_ino);
>  
>  	block = inode->i_ino;
>  	bh = affs_bread(sb, block);
> @@ -171,14 +171,14 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  	uid_t			 uid;
>  	gid_t			 gid;
>  
> -	pr_debug("write_inode(%lu)\n", inode->i_ino);
> +	pr_debug("write_inode(%llu)\n", inode->i_ino);
>  
>  	if (!inode->i_nlink)
>  		// possibly free block
>  		return 0;
>  	bh = affs_bread(sb, inode->i_ino);
>  	if (!bh) {
> -		affs_error(sb,"write_inode","Cannot read block %lu",inode->i_ino);
> +		affs_error(sb, "write_inode", "Cannot read block %llu", inode->i_ino);
>  		return -EIO;
>  	}
>  	tail = AFFS_TAIL(sb, bh);
> @@ -219,7 +219,7 @@ affs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	struct inode *inode = d_inode(dentry);
>  	int error;
>  
> -	pr_debug("notify_change(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
> +	pr_debug("notify_change(%llu,0x%x)\n", inode->i_ino, attr->ia_valid);
>  
>  	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
>  	if (error)
> @@ -260,7 +260,7 @@ void
>  affs_evict_inode(struct inode *inode)
>  {
>  	unsigned long cache_page;
> -	pr_debug("evict_inode(ino=%lu, nlink=%u)\n",
> +	pr_debug("evict_inode(ino=%llu, nlink=%u)\n",
>  		 inode->i_ino, inode->i_nlink);
>  	truncate_inode_pages_final(&inode->i_data);
>  
> @@ -353,7 +353,7 @@ affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s3
>  	u32 block = 0;
>  	int retval;
>  
> -	pr_debug("%s(dir=%lu, inode=%lu, \"%pd\", type=%d)\n", __func__,
> +	pr_debug("%s(dir=%llu, inode=%llu, \"%pd\", type=%d)\n", __func__,
>  		 dir->i_ino, inode->i_ino, dentry, type);
>  
>  	retval = -EIO;
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index f883be50db122d3b09f0ae4d24618bd49b55186b..8705321926007f559bac1af42fbadca8da67afcc 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -235,7 +235,7 @@ affs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
>  int
>  affs_unlink(struct inode *dir, struct dentry *dentry)
>  {
> -	pr_debug("%s(dir=%lu, %lu \"%pd\")\n", __func__, dir->i_ino,
> +	pr_debug("%s(dir=%llu, %llu \"%pd\")\n", __func__, dir->i_ino,
>  		 d_inode(dentry)->i_ino, dentry);
>  
>  	return affs_remove_header(dentry);
> @@ -249,7 +249,7 @@ affs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode	*inode;
>  	int		 error;
>  
> -	pr_debug("%s(%lu,\"%pd\",0%ho)\n",
> +	pr_debug("%s(%llu,\"%pd\",0%ho)\n",
>  		 __func__, dir->i_ino, dentry, mode);
>  
>  	inode = affs_new_inode(dir);
> @@ -280,7 +280,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode		*inode;
>  	int			 error;
>  
> -	pr_debug("%s(%lu,\"%pd\",0%ho)\n",
> +	pr_debug("%s(%llu,\"%pd\",0%ho)\n",
>  		 __func__, dir->i_ino, dentry, mode);
>  
>  	inode = affs_new_inode(dir);
> @@ -306,7 +306,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  int
>  affs_rmdir(struct inode *dir, struct dentry *dentry)
>  {
> -	pr_debug("%s(dir=%lu, %lu \"%pd\")\n", __func__, dir->i_ino,
> +	pr_debug("%s(dir=%llu, %llu \"%pd\")\n", __func__, dir->i_ino,
>  		 d_inode(dentry)->i_ino, dentry);
>  
>  	return affs_remove_header(dentry);
> @@ -323,7 +323,7 @@ affs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	int			 i, maxlen, error;
>  	char			 c, lc;
>  
> -	pr_debug("%s(%lu,\"%pd\" -> \"%s\")\n",
> +	pr_debug("%s(%llu,\"%pd\" -> \"%s\")\n",
>  		 __func__, dir->i_ino, dentry, symname);
>  
>  	maxlen = AFFS_SB(sb)->s_hashsize * sizeof(u32) - 1;
> @@ -395,7 +395,7 @@ affs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(old_dentry);
>  
> -	pr_debug("%s(%lu, %lu, \"%pd\")\n", __func__, inode->i_ino, dir->i_ino,
> +	pr_debug("%s(%llu, %llu, \"%pd\")\n", __func__, inode->i_ino, dir->i_ino,
>  		 dentry);
>  
>  	return affs_add_entry(dir, inode, dentry, ST_LINKFILE);
> @@ -511,7 +511,7 @@ int affs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
>  	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
>  		return -EINVAL;
>  
> -	pr_debug("%s(old=%lu,\"%pd\" to new=%lu,\"%pd\")\n", __func__,
> +	pr_debug("%s(old=%llu,\"%pd\" to new=%llu,\"%pd\")\n", __func__,
>  		 old_dir->i_ino, old_dentry, new_dir->i_ino, new_dentry);
>  
>  	if (flags & RENAME_EXCHANGE)
> diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
> index 094aec8d17b88bab9392abdd497ed687cd85584e..de31ed2e71dfcb71b770a98c9b43a248de8d7041 100644
> --- a/fs/affs/symlink.c
> +++ b/fs/affs/symlink.c
> @@ -21,7 +21,7 @@ static int affs_symlink_read_folio(struct file *file, struct folio *folio)
>  	char			 c;
>  	char			 lc;
>  
> -	pr_debug("get_link(ino=%lu)\n", inode->i_ino);
> +	pr_debug("get_link(ino=%llu)\n", inode->i_ino);
>  
>  	bh = affs_bread(inode->i_sb, inode->i_ino);
>  	if (!bh)
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 78caef3f13388c5f604e4970bc0874de168b57f3..aaaa55878ffd28691777668261f577d7a9472d6d 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -148,7 +148,7 @@ static bool afs_dir_check_block(struct afs_vnode *dvnode, size_t progress,
>  				union afs_xdr_dir_block *block)
>  {
>  	if (block->hdr.magic != AFS_DIR_MAGIC) {
> -		pr_warn("%s(%lx): [%zx] bad magic %04x\n",
> +		pr_warn("%s(%llx): [%zx] bad magic %04x\n",
>  		       __func__, dvnode->netfs.inode.i_ino,
>  		       progress, ntohs(block->hdr.magic));
>  		trace_afs_dir_check_failed(dvnode, progress);
> @@ -214,7 +214,7 @@ static int afs_dir_check(struct afs_vnode *dvnode)
>   */
>  static int afs_dir_open(struct inode *inode, struct file *file)
>  {
> -	_enter("{%lu}", inode->i_ino);
> +	_enter("{%llu}", inode->i_ino);
>  
>  	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
>  	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
> @@ -523,7 +523,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
>  	int retry_limit = 100;
>  	int ret;
>  
> -	_enter("{%lu},%llx,,", dir->i_ino, ctx->pos);
> +	_enter("{%llu},%llx,,", dir->i_ino, ctx->pos);
>  
>  	do {
>  		if (--retry_limit < 0) {
> @@ -610,7 +610,7 @@ static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
>  	};
>  	int ret;
>  
> -	_enter("{%lu},{%.*s},", dir->i_ino, name->len, name->name);
> +	_enter("{%llu},{%.*s},", dir->i_ino, name->len, name->name);
>  
>  	/* search the directory */
>  	ret = afs_dir_iterate(dir, &cookie.ctx, NULL, _dir_version);
> @@ -783,7 +783,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
>  	long ret;
>  	int i;
>  
> -	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
> +	_enter("{%llu},%p{%pd},", dir->i_ino, dentry, dentry);
>  
>  	cookie = kzalloc_obj(struct afs_lookup_cookie);
>  	if (!cookie)
> diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
> index d2516e55b5edb273677c9cedb6f15524bc56348d..104411c0692f570a217d8f0e6fd35818eaa02932 100644
> --- a/fs/afs/dir_search.c
> +++ b/fs/afs/dir_search.c
> @@ -194,7 +194,7 @@ int afs_dir_search(struct afs_vnode *dvnode, const struct qstr *name,
>  	struct afs_dir_iter iter = { .dvnode = dvnode, };
>  	int ret, retry_limit = 3;
>  
> -	_enter("{%lu},,,", dvnode->netfs.inode.i_ino);
> +	_enter("{%llu},,,", dvnode->netfs.inode.i_ino);
>  
>  	if (!afs_dir_init_iter(&iter, name))
>  		return -ENOENT;
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index aa56e8951e037b2e3fa9fc452b43e7bd2d61b926..1d5e33bc750224d063446ea952d5ef97a2481010 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -59,7 +59,7 @@ static struct inode *afs_iget_pseudo_dir(struct super_block *sb, ino_t ino)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	_debug("GOT INODE %p { ino=%lu, vl=%llx, vn=%llx, u=%x }",
> +	_debug("GOT INODE %p { ino=%llu, vl=%llx, vn=%llx, u=%x }",
>  	       inode, inode->i_ino, fid.vid, fid.vnode, fid.unique);
>  
>  	vnode = AFS_FS_I(inode);
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index dde1857fcabb302cc6b06cc018fb1e4108ec6284..a5173434f7862e92a127994c56b89f530ad4c298 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -683,7 +683,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	struct key *key;
>  	int ret, seq;
>  
> -	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
> +	_enter("{ ino=%llu v=%u }", inode->i_ino, inode->i_generation);
>  
>  	if (vnode->volume &&
>  	    !(query_flags & AT_STATX_DONT_SYNC) &&
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index c53dc551053ba53fa7c85ca57eb877fff74a4ed1..c1e210cec436928b80ac21af4713598bbfe04b11 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -92,7 +92,7 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
>  		seq_puts(m, ",ignore");
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	if (sbi->pipe)
> -		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
> +		seq_printf(m, ",pipe_ino=%llu", file_inode(sbi->pipe)->i_ino);
>  	else
>  		seq_puts(m, ",pipe_ino=-1");
>  #endif
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index cecbc92f959aa5098313050b515c9af38662c8e6..c12caae9a96799b0a57e6cb5010de756f8b86346 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -140,20 +140,20 @@ befs_get_block(struct inode *inode, sector_t block,
>  	int res;
>  	ulong disk_off;
>  
> -	befs_debug(sb, "---> befs_get_block() for inode %lu, block %ld",
> -		   (unsigned long)inode->i_ino, (long)block);
> +	befs_debug(sb, "---> befs_get_block() for inode %llu, block %ld",
> +		   inode->i_ino, (long)block);
>  	if (create) {
>  		befs_error(sb, "befs_get_block() was asked to write to "
> -			   "block %ld in inode %lu", (long)block,
> -			   (unsigned long)inode->i_ino);
> +			   "block %ld in inode %llu", (long)block,
> +			   inode->i_ino);
>  		return -EPERM;
>  	}
>  
>  	res = befs_fblock2brun(sb, ds, block, &run);
>  	if (res != BEFS_OK) {
>  		befs_error(sb,
> -			   "<--- %s for inode %lu, block %ld ERROR",
> -			   __func__, (unsigned long)inode->i_ino,
> +			   "<--- %s for inode %llu, block %ld ERROR",
> +			   __func__, inode->i_ino,
>  			   (long)block);
>  		return -EFBIG;
>  	}
> @@ -162,8 +162,8 @@ befs_get_block(struct inode *inode, sector_t block,
>  
>  	map_bh(bh_result, inode->i_sb, disk_off);
>  
> -	befs_debug(sb, "<--- %s for inode %lu, block %ld, disk address %lu",
> -		  __func__, (unsigned long)inode->i_ino, (long)block,
> +	befs_debug(sb, "<--- %s for inode %llu, block %ld, disk address %lu",
> +		  __func__, inode->i_ino, (long)block,
>  		  (unsigned long)disk_off);
>  
>  	return 0;
> @@ -181,7 +181,7 @@ befs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
>  	char *utfname;
>  	const char *name = dentry->d_name.name;
>  
> -	befs_debug(sb, "---> %s name %pd inode %ld", __func__,
> +	befs_debug(sb, "---> %s name %pd inode %llu", __func__,
>  		   dentry, dir->i_ino);
>  
>  	/* Convert to UTF-8 */
> @@ -224,7 +224,7 @@ befs_readdir(struct file *file, struct dir_context *ctx)
>  	size_t keysize;
>  	char keybuf[BEFS_NAME_LEN + 1];
>  
> -	befs_debug(sb, "---> %s name %pD, inode %ld, ctx->pos %lld",
> +	befs_debug(sb, "---> %s name %pD, inode %llu, ctx->pos %lld",
>  		  __func__, file, inode->i_ino, ctx->pos);
>  
>  	while (1) {
> @@ -233,7 +233,7 @@ befs_readdir(struct file *file, struct dir_context *ctx)
>  
>  		if (result == BEFS_ERR) {
>  			befs_debug(sb, "<--- %s ERROR", __func__);
> -			befs_error(sb, "IO error reading %pD (inode %lu)",
> +			befs_error(sb, "IO error reading %pD (inode %llu)",
>  				   file, inode->i_ino);
>  			return -EIO;
>  
> @@ -324,7 +324,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
>  	bh = sb_bread(sb, inode->i_ino);
>  	if (!bh) {
>  		befs_error(sb, "unable to read inode block - "
> -			   "inode = %lu", inode->i_ino);
> +			   "inode = %llu", inode->i_ino);
>  		goto unacquire_none;
>  	}
>  
> @@ -333,7 +333,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
>  	befs_dump_inode(sb, raw_inode);
>  
>  	if (befs_check_inode(sb, raw_inode, inode->i_ino) != BEFS_OK) {
> -		befs_error(sb, "Bad inode: %lu", inode->i_ino);
> +		befs_error(sb, "Bad inode: %llu", inode->i_ino);
>  		goto unacquire_bh;
>  	}
>  
> @@ -407,7 +407,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
>  			inode->i_op = &simple_symlink_inode_operations;
>  		}
>  	} else {
> -		befs_error(sb, "Inode %lu is not a regular file, "
> +		befs_error(sb, "Inode %llu is not a regular file, "
>  			   "directory or symlink. THAT IS WRONG! BeFS has no "
>  			   "on disk special files", inode->i_ino);
>  		goto unacquire_bh;
> diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
> index c375e22c4c0c15ba27307d266adfe3f093b90ab8..481514db4eae3c33c280d04371a17ef321486ac1 100644
> --- a/fs/bfs/dir.c
> +++ b/fs/bfs/dir.c
> @@ -35,7 +35,7 @@ static int bfs_readdir(struct file *f, struct dir_context *ctx)
>  	int block;
>  
>  	if (ctx->pos & (BFS_DIRENT_SIZE - 1)) {
> -		printf("Bad f_pos=%08lx for %s:%08lx\n",
> +		printf("Bad f_pos=%08lx for %s:%08llx\n",
>  					(unsigned long)ctx->pos,
>  					dir->i_sb->s_id, dir->i_ino);
>  		return -EINVAL;
> @@ -180,7 +180,7 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
>  		goto out_brelse;
>  
>  	if (!inode->i_nlink) {
> -		printf("unlinking non-existent file %s:%lu (nlink=%d)\n",
> +		printf("unlinking non-existent file %s:%llu (nlink=%d)\n",
>  					inode->i_sb->s_id, inode->i_ino,
>  					inode->i_nlink);
>  		set_nlink(inode, 1);
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index eaf47851c65f4736a7a27f13c498028c7c8dd1b4..d879b80a0bedc95533ce05361ed8cb79c7ed3826 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -93,7 +93,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
>  	object = cachefiles_cres_object(cres);
>  	file = cachefiles_cres_file(cres);
>  
> -	_enter("%pD,%li,%llx,%zx/%llx",
> +	_enter("%pD,%llu,%llx,%zx/%llx",
>  	       file, file_inode(file)->i_ino, start_pos, len,
>  	       i_size_read(file_inode(file)));
>  
> @@ -214,7 +214,7 @@ static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
>  	file = cachefiles_cres_file(cres);
>  	granularity = max_t(size_t, object->volume->cache->bsize, granularity);
>  
> -	_enter("%pD,%li,%llx,%zx/%llx",
> +	_enter("%pD,%llu,%llx,%zx/%llx",
>  	       file, file_inode(file)->i_ino, start, len,
>  	       i_size_read(file_inode(file)));
>  
> @@ -294,7 +294,7 @@ int __cachefiles_write(struct cachefiles_object *object,
>  	fscache_count_write();
>  	cache = object->volume->cache;
>  
> -	_enter("%pD,%li,%llx,%zx/%llx",
> +	_enter("%pD,%llu,%llx,%zx/%llx",
>  	       file, file_inode(file)->i_ino, start_pos, len,
>  	       i_size_read(file_inode(file)));
>  
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index e5ec90dccc27f71dc19219f7632f3e48eaf51545..4fdf7687aacb8285ae38d9b5d7e5129897b3ca03 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -147,7 +147,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  		}
>  		ASSERT(d_backing_inode(subdir));
>  
> -		_debug("mkdir -> %pd{ino=%lu}",
> +		_debug("mkdir -> %pd{ino=%llu}",
>  		       subdir, d_backing_inode(subdir)->i_ino);
>  		if (_is_new)
>  			*_is_new = true;
> @@ -158,7 +158,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  	end_creating_keep(subdir);
>  
>  	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
> -		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
> +		pr_notice("cachefiles: Inode already in use: %pd (B=%llx)\n",
>  			  subdir, d_inode(subdir)->i_ino);
>  		goto mark_error;
>  	}
> @@ -183,7 +183,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  	    !d_backing_inode(subdir)->i_op->unlink)
>  		goto check_error;
>  
> -	_leave(" = [%lu]", d_backing_inode(subdir)->i_ino);
> +	_leave(" = [%llu]", d_backing_inode(subdir)->i_ino);
>  	return subdir;
>  
>  check_error:
> @@ -529,7 +529,7 @@ static bool cachefiles_create_file(struct cachefiles_object *object)
>  
>  	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
>  	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
> -	_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
> +	_debug("create -> %pD{ino=%llu}", file, file_inode(file)->i_ino);
>  	object->file = file;
>  	return true;
>  }
> @@ -549,7 +549,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>  	_enter("%pd", dentry);
>  
>  	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
> -		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
> +		pr_notice("cachefiles: Inode already in use: %pd (B=%llx)\n",
>  			  dentry, d_inode(dentry)->i_ino);
>  		return false;
>  	}
> @@ -657,7 +657,7 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
>  	if (!ret)
>  		return false;
>  
> -	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
> +	_leave(" = t [%llu]", file_inode(object->file)->i_ino);
>  	return true;
>  
>  new_file:
> diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
> index 52383b1d0ba63d4a09413177d8c0d841b5b5b43c..f8ae78b3f7b6d368526a86b454bf0febd1ccc509 100644
> --- a/fs/cachefiles/xattr.c
> +++ b/fs/cachefiles/xattr.c
> @@ -179,7 +179,7 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
>  			ret = 0;
>  		else if (ret != -ENOMEM)
>  			cachefiles_io_error(cache,
> -					    "Can't remove xattr from %lu"
> +					    "Can't remove xattr from %llu"
>  					    " (error %d)",
>  					    d_backing_inode(dentry)->i_ino, -ret);
>  	}
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index f3de43ccb470ddbd7945426d79f9024ae615c127..64d2407592772ed61fb95b62401db194112f48a8 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -272,7 +272,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
>  	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
>  	WARN_ON(elen > 240);
>  	if (dir != parent) // leading _ is already there; append _<inum>
> -		elen += 1 + sprintf(p + elen, "_%ld", dir->i_ino);
> +		elen += 1 + sprintf(p + elen, "_%llu", dir->i_ino);
>  
>  out:
>  	kfree(cryptbuf);
> @@ -377,7 +377,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  	if (!ret && (dir != fname->dir)) {
>  		char tmp_buf[BASE64_CHARS(NAME_MAX)];
>  
> -		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> +		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu",
>  				    oname->len, oname->name, dir->i_ino);
>  		memcpy(oname->name, tmp_buf, name_len);
>  		oname->len = name_len;
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index c64b8cd81568d3a7c0055f139d4b12cfa37399de..d6b9fc3cc1ca9d581a26de48971db60abcb26af4 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -533,7 +533,7 @@ int coda_revalidate_inode(struct inode *inode)
>  		coda_vattr_to_iattr(inode, &attr);
>  
>  		if ((old_mode & S_IFMT) != (inode->i_mode & S_IFMT)) {
> -			pr_warn("inode %ld, fid %s changed type!\n",
> +			pr_warn("inode %llu, fid %s changed type!\n",
>  				inode->i_ino, coda_f2s(&(cii->c_fid)));
>  		}
>  
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index ad1654f3adf8a6f4d9322d507264472f1703ffd4..40b43866e6a5496682453b227972e89e539960ff 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -257,7 +257,7 @@ static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
>  		goto error;
>  	} 
>  
> -	pr_info("%s: rootinode is %ld dev %s\n",
> +	pr_info("%s: rootinode is %llu dev %s\n",
>  		__func__, root->i_ino, root->i_sb->s_id);
>  	sb->s_root = d_make_root(root);
>  	if (!sb->s_root) {
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index e0ba9cd640dcfe86e0976344b30a5b9a0da6b90f..4edbfccd0bbea39a1babd289afb1d8b985570eeb 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -125,7 +125,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
>  				old_decode_dev(cramfs_inode->size));
>  		break;
>  	default:
> -		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %llu.\n",
>  		       inode->i_mode, inode->i_ino);
>  		iget_failed(inode);
>  		return ERR_PTR(-EIO);
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index 07f9cbfe3ea4115b8fcc881ae5154b3c3e898c04..570a2231c945a6c649cf8dc3b457f0b55657e0c3 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -365,7 +365,7 @@ void fscrypt_msg(const struct inode *inode, const char *level,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	if (inode && inode->i_ino)
> -		printk("%sfscrypt (%s, inode %lu): %pV\n",
> +		printk("%sfscrypt (%s, inode %llu): %pV\n",
>  		       level, inode->i_sb->s_id, inode->i_ino, &vaf);
>  	else if (inode)
>  		printk("%sfscrypt (%s): %pV\n", level, inode->i_sb->s_id, &vaf);
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index b97de0d1430fd6ec764f4a758dffe00263496118..a7a8a3f581a0460537f5ff955bc8b5d30573a033 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -62,7 +62,7 @@ int fscrypt_file_open(struct inode *inode, struct file *filp)
>  	dentry_parent = dget_parent(dentry);
>  	if (!fscrypt_has_permitted_context(d_inode(dentry_parent), inode)) {
>  		fscrypt_warn(inode,
> -			     "Inconsistent encryption context (parent directory: %lu)",
> +			     "Inconsistent encryption context (parent directory: %llu)",
>  			     d_inode(dentry_parent)->i_ino);
>  		err = -EPERM;
>  	}
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 9ec6e5ef0947eff394166d8af438a808cc8a4b2b..be8e6e8011f2131f2908da746a37d33fd5295122 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> @@ -969,8 +969,8 @@ static int check_for_busy_inodes(struct super_block *sb,
>  {
>  	struct list_head *pos;
>  	size_t busy_count = 0;
> -	unsigned long ino;
>  	char ino_str[50] = "";
> +	u64 ino;
>  
>  	spin_lock(&mk->mk_decrypted_inodes_lock);
>  
> @@ -994,7 +994,7 @@ static int check_for_busy_inodes(struct super_block *sb,
>  
>  	/* If the inode is currently being created, ino may still be 0. */
>  	if (ino)
> -		snprintf(ino_str, sizeof(ino_str), ", including ino %lu", ino);
> +		snprintf(ino_str, sizeof(ino_str), ", including ino %llu", ino);
>  
>  	fscrypt_warn(NULL,
>  		     "%s: %zu inode(s) still busy after removing key with %s %*phN%s",
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 40fa05688d3a1d4aa33d29e9508441faf4bca933..df58ca4a5e3cb1df94e2f08e3f3b093c33368993 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -91,7 +91,7 @@ select_encryption_mode(const union fscrypt_policy *policy,
>  	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
>  		return &fscrypt_modes[fscrypt_policy_fnames_mode(policy)];
>  
> -	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %lu, which is not encryptable (file type %d)\n",
> +	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %llu, which is not encryptable (file type %d)\n",
>  		  inode->i_ino, (inode->i_mode & S_IFMT));
>  	return ERR_PTR(-EINVAL);
>  }
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 24f4f3acaa8cffd6f98124eec38c1a92d6c9fd8e..9ceab142896f6631017067890fd1079240448e13 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1637,11 +1637,11 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
>  	if (dentry == _data && dentry->d_lockref.count == 1)
>  		return D_WALK_CONTINUE;
>  
> -	WARN(1, "BUG: Dentry %p{i=%lx,n=%pd} "
> +	WARN(1, "BUG: Dentry %p{i=%llx,n=%pd} "
>  			" still in use (%d) [unmount of %s %s]\n",
>  		       dentry,
>  		       dentry->d_inode ?
> -		       dentry->d_inode->i_ino : 0UL,
> +		       dentry->d_inode->i_ino : (u64)0,
>  		       dentry,
>  		       dentry->d_lockref.count,
>  		       dentry->d_sb->s_type->name,
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 3b59346d68c594fcd7e27bae87849d3e19eff56e..f25c9a49e251a591695a143f64d1a81c5211ec18 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1313,7 +1313,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
>  		rc = ecryptfs_read_xattr_region(page_virt, ecryptfs_inode);
>  		if (rc) {
>  			printk(KERN_DEBUG "Valid eCryptfs headers not found in "
> -			       "file header region or xattr region, inode %lu\n",
> +			       "file header region or xattr region, inode %llu\n",
>  				ecryptfs_inode->i_ino);
>  			rc = -EINVAL;
>  			goto out;
> @@ -1323,7 +1323,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
>  						ECRYPTFS_DONT_VALIDATE_HEADER_SIZE);
>  		if (rc) {
>  			printk(KERN_DEBUG "Valid eCryptfs headers not found in "
> -			       "file xattr region either, inode %lu\n",
> +			       "file xattr region either, inode %llu\n",
>  				ecryptfs_inode->i_ino);
>  			rc = -EINVAL;
>  		}
> @@ -1335,7 +1335,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
>  			       "crypto metadata only in the extended attribute "
>  			       "region, but eCryptfs was mounted without "
>  			       "xattr support enabled. eCryptfs will not treat "
> -			       "this like an encrypted file, inode %lu\n",
> +			       "this like an encrypted file, inode %llu\n",
>  				ecryptfs_inode->i_ino);
>  			rc = -EINVAL;
>  		}
> diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
> index 7929411837cf5b2e98e1d4288791d2e07c44a4eb..49b0fbe0428a2d202434ce4b5fd7d82d2a63cf58 100644
> --- a/fs/ecryptfs/file.c
> +++ b/fs/ecryptfs/file.c
> @@ -253,7 +253,7 @@ static int ecryptfs_open(struct inode *inode, struct file *file)
>  	if (rc)
>  		goto out_put;
>  	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = "
> -			"[0x%.16lx] size: [0x%.16llx]\n", inode, inode->i_ino,
> +			"[0x%.16llx] size: [0x%.16llx]\n", inode, inode->i_ino,
>  			(unsigned long long)i_size_read(inode));
>  	goto out;
>  out_put:
> diff --git a/fs/efs/inode.c b/fs/efs/inode.c
> index 28407578f83ad5db1b8a7b082fa3e990b6b442ec..4b132729e6385de196e156400d17a86ed04dc2f4 100644
> --- a/fs/efs/inode.c
> +++ b/fs/efs/inode.c
> @@ -132,7 +132,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
>  	for(i = 0; i < EFS_DIRECTEXTENTS; i++) {
>  		extent_copy(&(efs_inode->di_u.di_extents[i]), &(in->extents[i]));
>  		if (i < in->numextents && in->extents[i].cooked.ex_magic != 0) {
> -			pr_warn("extent %d has bad magic number in inode %lu\n",
> +			pr_warn("extent %d has bad magic number in inode %llu\n",
>  				i, inode->i_ino);
>  			brelse(bh);
>  			goto read_inode_error;
> @@ -140,7 +140,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
>  	}
>  
>  	brelse(bh);
> -	pr_debug("efs_iget(): inode %lu, extents %d, mode %o\n",
> +	pr_debug("efs_iget(): inode %llu, extents %d, mode %o\n",
>  		 inode->i_ino, in->numextents, inode->i_mode);
>  	switch (inode->i_mode & S_IFMT) {
>  		case S_IFDIR: 
> @@ -171,7 +171,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
>  	return inode;
>          
>  read_inode_error:
> -	pr_warn("failed to read inode %lu\n", inode->i_ino);
> +	pr_warn("failed to read inode %llu\n", inode->i_ino);
>  	iget_failed(inode);
>  	return ERR_PTR(-EIO);
>  }
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 5714e900567c499739bb205f43bb6bf73f7ebe54..4ccd4d2e31adf571f939d2e777123e40302e565f 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1080,7 +1080,7 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
>  		struct inode *inode = file_inode(epi->ffd.file);
>  
>  		seq_printf(m, "tfd: %8d events: %8x data: %16llx "
> -			   " pos:%lli ino:%lx sdev:%x\n",
> +			   " pos:%lli ino:%llx sdev:%x\n",
>  			   epi->ffd.fd, epi->event.events,
>  			   (long long)epi->event.data,
>  			   (long long)epi->ffd.file->f_pos,
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 6c9be60a3e48dc5e984a826029375550d1494835..5c3183ce350ebc89ba4a5c10ffd644b6666395c3 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -130,12 +130,12 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
>  		parent = mnt->mnt_sb->s_export_op->get_parent(dentry);
>  
>  	if (IS_ERR(parent)) {
> -		dprintk("get_parent of %lu failed, err %ld\n",
> +		dprintk("get_parent of %llu failed, err %ld\n",
>  			dentry->d_inode->i_ino, PTR_ERR(parent));
>  		return parent;
>  	}
>  
> -	dprintk("%s: find name of %lu in %lu\n", __func__,
> +	dprintk("%s: find name of %llu in %llu\n", __func__,
>  		dentry->d_inode->i_ino, parent->d_inode->i_ino);
>  	err = exportfs_get_name(mnt, parent, nbuf, dentry);
>  	if (err == -ENOENT)
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 395fc36c089b7bb6360a8326727bd5606c7e2476..278d4be8ecbe7790204b5ba985a7ce088fadb181 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -141,7 +141,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  Ebadsize:
>  	if (!quiet)
>  		ext2_error(sb, __func__,
> -			"size of directory #%lu is not a multiple "
> +			"size of directory #%llu is not a multiple "
>  			"of chunk size", dir->i_ino);
>  	goto fail;
>  Eshort:
> @@ -160,7 +160,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  	error = "inode out of bounds";
>  bad_entry:
>  	if (!quiet)
> -		ext2_error(sb, __func__, "bad entry in directory #%lu: : %s - "
> +		ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
>  			"offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
>  			dir->i_ino, error, folio_pos(folio) + offs,
>  			(unsigned long) le32_to_cpu(p->inode),
> @@ -170,7 +170,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
>  	if (!quiet) {
>  		p = (ext2_dirent *)(kaddr + offs);
>  		ext2_error(sb, "ext2_check_folio",
> -			"entry in directory #%lu spans the page boundary"
> +			"entry in directory #%llu spans the page boundary"
>  			"offset=%llu, inode=%lu",
>  			dir->i_ino, folio_pos(folio) + offs,
>  			(unsigned long) le32_to_cpu(p->inode));
> @@ -281,7 +281,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
>  
>  		if (IS_ERR(kaddr)) {
>  			ext2_error(sb, __func__,
> -				   "bad page in #%lu",
> +				   "bad page in #%llu",
>  				   inode->i_ino);
>  			ctx->pos += PAGE_SIZE - offset;
>  			return PTR_ERR(kaddr);
> @@ -383,7 +383,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  		/* next folio is past the blocks we've got */
>  		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
>  			ext2_error(dir->i_sb, __func__,
> -				"dir %lu size %lld exceeds block count %llu",
> +				"dir %llu size %lld exceeds block count %llu",
>  				dir->i_ino, dir->i_size,
>  				(unsigned long long)dir->i_blocks);
>  			goto out;
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index fdf63e9c6e7caa6d5267c25faa6c293622f00627..bf21b57cf98cd5f90e1177454a8fd5cca482c2f8 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -169,9 +169,10 @@ static void ext2_preread_inode(struct inode *inode)
>  	unsigned long block_group;
>  	unsigned long offset;
>  	unsigned long block;
> +	unsigned int ino = inode->i_ino;
>  	struct ext2_group_desc * gdp;
>  
> -	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
> +	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
>  	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
>  	if (gdp == NULL)
>  		return;
> @@ -179,7 +180,7 @@ static void ext2_preread_inode(struct inode *inode)
>  	/*
>  	 * Figure out the offset within the block group inode table
>  	 */
> -	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
> +	offset = ((ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
>  				EXT2_INODE_SIZE(inode->i_sb);
>  	block = le32_to_cpu(gdp->bg_inode_table) +
>  				(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
> @@ -381,7 +382,7 @@ static int find_group_other(struct super_block *sb, struct inode *parent)
>  	 *
>  	 * So add our directory's i_ino into the starting point for the hash.
>  	 */
> -	group = (group + parent->i_ino) % ngroups;
> +	group = (group + (unsigned int)parent->i_ino) % ngroups;
>  
>  	/*
>  	 * Use a quadratic hash to find a group with a free inode and some
> @@ -589,7 +590,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
>  		goto fail_free_drop;
>  
>  	mark_inode_dirty(inode);
> -	ext2_debug("allocating inode %lu\n", inode->i_ino);
> +	ext2_debug("allocating inode %llu\n", inode->i_ino);
>  	ext2_preread_inode(inode);
>  	return inode;
>  
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index dbfe9098a1245d97ba97cff24395754197043c33..45286c0c3b6b8f86a1ecec0e2f545c5a678dd6ac 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1152,7 +1152,7 @@ static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int de
>  			 */ 
>  			if (!bh) {
>  				ext2_error(inode->i_sb, "ext2_free_branches",
> -					"Read failure, inode=%ld, block=%ld",
> +					"Read failure, inode=%llu, block=%ld",
>  					inode->i_ino, nr);
>  				continue;
>  			}
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index c885dcc3bd0d180c4c3f0945ca23ed8ce569ef10..14ada70db36a76d1436944a3622e5caf0b373b9e 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -227,7 +227,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
>  	if (!ext2_xattr_header_valid(HDR(bh))) {
>  bad_block:
>  		ext2_error(inode->i_sb, "ext2_xattr_get",
> -			"inode %ld: bad block %d", inode->i_ino,
> +			"inode %llu: bad block %d", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		error = -EIO;
>  		goto cleanup;
> @@ -313,7 +313,7 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	if (!ext2_xattr_header_valid(HDR(bh))) {
>  bad_block:
>  		ext2_error(inode->i_sb, "ext2_xattr_list",
> -			"inode %ld: bad block %d", inode->i_ino,
> +			"inode %llu: bad block %d", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		error = -EIO;
>  		goto cleanup;
> @@ -454,7 +454,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		if (!ext2_xattr_header_valid(header)) {
>  bad_block:
>  			ext2_error(sb, "ext2_xattr_set",
> -				"inode %ld: bad block %d", inode->i_ino, 
> +				"inode %llu: bad block %d", inode->i_ino,
>  				   EXT2_I(inode)->i_file_acl);
>  			error = -EIO;
>  			goto cleanup;
> @@ -833,7 +833,7 @@ ext2_xattr_delete_inode(struct inode *inode)
>  
>  	if (!ext2_data_block_valid(sbi, EXT2_I(inode)->i_file_acl, 1)) {
>  		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> -			"inode %ld: xattr block %d is out of data blocks range",
> +			"inode %llu: xattr block %d is out of data blocks range",
>  			inode->i_ino, EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
> @@ -841,14 +841,14 @@ ext2_xattr_delete_inode(struct inode *inode)
>  	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
>  	if (!bh) {
>  		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> -			"inode %ld: block %d read error", inode->i_ino,
> +			"inode %llu: block %d read error", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
>  	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
>  	if (!ext2_xattr_header_valid(HDR(bh))) {
>  		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
> -			"inode %ld: bad block %d", inode->i_ino,
> +			"inode %llu: bad block %d", inode->i_ino,
>  			EXT2_I(inode)->i_file_acl);
>  		goto cleanup;
>  	}
> @@ -952,7 +952,7 @@ ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
>  		bh = sb_bread(inode->i_sb, ce->e_value);
>  		if (!bh) {
>  			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
> -				"inode %ld: block %ld read error",
> +				"inode %llu: block %ld read error",
>  				inode->i_ino, (unsigned long) ce->e_value);
>  		} else {
>  			lock_buffer(bh);
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 28b2a3deb954fe275cd2f7290f2daeafa2d3dbed..17edd678fa87b8f024232081888c4054d42a7bd9 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -535,7 +535,7 @@ static int call_filldir(struct file *file, struct dir_context *ctx,
>  	struct super_block *sb = inode->i_sb;
>  
>  	if (!fname) {
> -		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: comm %s: "
> +		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: comm %s: "
>  			 "called with null fname?!?", __func__, __LINE__,
>  			 inode->i_ino, current->comm);
>  		return 0;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 293f698b7042438b2757790717db22bca060797d..85e6c2b543a82e83b777c2cc2f54a6ed53b554f2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -92,7 +92,7 @@
>   */
>  #ifdef CONFIG_EXT4_DEBUG
>  #define ext_debug(ino, fmt, ...)					\
> -	pr_debug("[%s/%d] EXT4-fs (%s): ino %lu: (%s, %d): %s:" fmt,	\
> +	pr_debug("[%s/%d] EXT4-fs (%s): ino %llu: (%s, %d): %s:" fmt,	\
>  		 current->comm, task_pid_nr(current),			\
>  		 ino->i_sb->s_id, ino->i_ino, __FILE__, __LINE__,	\
>  		 __func__, ##__VA_ARGS__)
> @@ -3229,7 +3229,7 @@ extern void __dump_mmp_msg(struct super_block *, struct mmp_struct *mmp,
>  extern __printf(7, 8)
>  void __ext4_grp_locked_error(const char *, unsigned int,
>  			     struct super_block *, ext4_group_t,
> -			     unsigned long, ext4_fsblk_t,
> +			     u64, ext4_fsblk_t,
>  			     const char *, ...);
>  
>  #define EXT4_ERROR_INODE(inode, fmt, a...) \
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ae3804f36535aeca4009bfae992e1f2f665aded2..042e1555a674149f8d47716f288ca175556b6b45 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4603,7 +4603,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  		}
>  		ret = ext4_map_blocks(handle, inode, &map, flags);
>  		if (ret <= 0) {
> -			ext4_debug("inode #%lu: block %u: len %u: "
> +			ext4_debug("inode #%llu: block %u: len %u: "
>  				   "ext4_ext_map_blocks returned %d",
>  				   inode->i_ino, map.m_lblk,
>  				   map.m_len, ret);
> @@ -4955,7 +4955,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
>  		ret = ext4_map_blocks(handle, inode, &map, flags);
>  		if (ret != max_blocks)
>  			ext4_msg(inode->i_sb, KERN_INFO,
> -				     "inode #%lu: block %u: len %u: "
> +				     "inode #%llu: block %u: len %u: "
>  				     "split block mapping found for atomic write, "
>  				     "ret = %d",
>  				     inode->i_ino, map.m_lblk,
> @@ -4974,7 +4974,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
>  
>  	if (ret <= 0 || ret2)
>  		ext4_warning(inode->i_sb,
> -			     "inode #%lu: block %u: len %u: "
> +			     "inode #%llu: block %u: len %u: "
>  			     "returned %d or %d",
>  			     inode->i_ino, map.m_lblk,
>  			     map.m_len, ret, ret2);
> @@ -5031,7 +5031,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
>  				      EXT4_EX_NOCACHE);
>  		if (ret <= 0)
>  			ext4_warning(inode->i_sb,
> -				     "inode #%lu: block %u: len %u: "
> +				     "inode #%llu: block %u: len %u: "
>  				     "ext4_ext_map_blocks returned %d",
>  				     inode->i_ino, map.m_lblk,
>  				     map.m_len, ret);
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index a1538bac51c61d81881be2e3fd67113f24c16df1..6e4a191e821915d2b61646f46304ffab6d531126 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -214,7 +214,7 @@ static void ext4_es_print_tree(struct inode *inode)
>  	struct ext4_es_tree *tree;
>  	struct rb_node *node;
>  
> -	printk(KERN_DEBUG "status extents for inode %lu:", inode->i_ino);
> +	printk(KERN_DEBUG "status extents for inode %llu:", inode->i_ino);
>  	tree = &EXT4_I(inode)->i_es_tree;
>  	node = rb_first(&tree->root);
>  	while (node) {
> @@ -703,7 +703,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		if (!ext4_es_is_written(es) && !ext4_es_is_unwritten(es)) {
>  			if (in_range(es->es_lblk, ee_block, ee_len)) {
>  				pr_warn("ES insert assertion failed for "
> -					"inode: %lu we can find an extent "
> +					"inode: %llu we can find an extent "
>  					"at block [%d/%d/%llu/%c], but we "
>  					"want to add a delayed/hole extent "
>  					"[%d/%d/%llu/%x]\n",
> @@ -721,7 +721,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		 */
>  		if (es->es_lblk < ee_block ||
>  		    ext4_es_pblock(es) != ee_start + es->es_lblk - ee_block) {
> -			pr_warn("ES insert assertion failed for inode: %lu "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"ex_status [%d/%d/%llu/%c] != "
>  				"es_status [%d/%d/%llu/%c]\n", inode->i_ino,
>  				ee_block, ee_len, ee_start,
> @@ -731,7 +731,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		}
>  
>  		if (ee_status ^ es_status) {
> -			pr_warn("ES insert assertion failed for inode: %lu "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"ex_status [%d/%d/%llu/%c] != "
>  				"es_status [%d/%d/%llu/%c]\n", inode->i_ino,
>  				ee_block, ee_len, ee_start,
> @@ -744,7 +744,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		 * that we don't want to add an written/unwritten extent.
>  		 */
>  		if (!ext4_es_is_delayed(es) && !ext4_es_is_hole(es)) {
> -			pr_warn("ES insert assertion failed for inode: %lu "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"can't find an extent at block %d but we want "
>  				"to add a written/unwritten extent "
>  				"[%d/%d/%llu/%x]\n", inode->i_ino,
> @@ -779,7 +779,7 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
>  			 * We want to add a delayed/hole extent but this
>  			 * block has been allocated.
>  			 */
> -			pr_warn("ES insert assertion failed for inode: %lu "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"We can find blocks but we want to add a "
>  				"delayed/hole extent [%d/%d/%llu/%x]\n",
>  				inode->i_ino, es->es_lblk, es->es_len,
> @@ -788,13 +788,13 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
>  		} else if (ext4_es_is_written(es)) {
>  			if (retval != es->es_len) {
>  				pr_warn("ES insert assertion failed for "
> -					"inode: %lu retval %d != es_len %d\n",
> +					"inode: %llu retval %d != es_len %d\n",
>  					inode->i_ino, retval, es->es_len);
>  				return;
>  			}
>  			if (map.m_pblk != ext4_es_pblock(es)) {
>  				pr_warn("ES insert assertion failed for "
> -					"inode: %lu m_pblk %llu != "
> +					"inode: %llu m_pblk %llu != "
>  					"es_pblk %llu\n",
>  					inode->i_ino, map.m_pblk,
>  					ext4_es_pblock(es));
> @@ -809,7 +809,7 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
>  		}
>  	} else if (retval == 0) {
>  		if (ext4_es_is_written(es)) {
> -			pr_warn("ES insert assertion failed for inode: %lu "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"We can't find the block but we want to add "
>  				"a written extent [%d/%d/%llu/%x]\n",
>  				inode->i_ino, es->es_lblk, es->es_len,
> @@ -919,7 +919,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
> +	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %llu\n",
>  		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
>  
>  	if (!len)
> @@ -1631,7 +1631,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
> +	es_debug("remove [%u/%u) from extent status tree of inode %llu\n",
>  		 lblk, len, inode->i_ino);
>  
>  	if (!len)
> @@ -1821,7 +1821,7 @@ int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v)
>  	seq_printf(seq, "  %lu shrunk objects\n", es_stats->es_stats_shrunk);
>  	if (inode_cnt)
>  		seq_printf(seq,
> -		    "maximum:\n  %lu inode (%u objects, %u reclaimable)\n"
> +		    "maximum:\n  %llu inode (%u objects, %u reclaimable)\n"
>  		    "  %llu us max scan time\n",
>  		    max->vfs_inode.i_ino, max->i_es_all_nr, max->i_es_shk_nr,
>  		    div_u64(es_stats->es_stats_max_scan_time, 1000));
> @@ -1998,7 +1998,7 @@ static void ext4_print_pending_tree(struct inode *inode)
>  	struct rb_node *node;
>  	struct pending_reservation *pr;
>  
> -	printk(KERN_DEBUG "pending reservations for inode %lu:", inode->i_ino);
> +	printk(KERN_DEBUG "pending reservations for inode %llu:", inode->i_ino);
>  	tree = &EXT4_I(inode)->i_pending_tree;
>  	node = rb_first(&tree->root);
>  	while (node) {
> @@ -2214,7 +2214,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("add [%u/%u) delayed to extent status tree of inode %lu\n",
> +	es_debug("add [%u/%u) delayed to extent status tree of inode %llu\n",
>  		 lblk, len, inode->i_ino);
>  	if (!len)
>  		return;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index f575751f1cae430eead31afa4f7d03ade1099d4a..379fb66dedbcd1c87b960cfe8786601700f797f3 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -616,7 +616,7 @@ static int __track_range(handle_t *handle, struct inode *inode, void *arg,
>  		(struct __track_range_args *)arg;
>  
>  	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
> -		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
> +		ext4_debug("Special inode %llu being modified\n", inode->i_ino);
>  		return -ECANCELED;
>  	}
>  
> @@ -914,7 +914,7 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
>  	spin_unlock(&ei->i_fc_lock);
>  
>  	cur_lblk_off = old_blk_size;
> -	ext4_debug("will try writing %d to %d for inode %ld\n",
> +	ext4_debug("will try writing %d to %d for inode %llu\n",
>  		   cur_lblk_off, new_blk_size, inode->i_ino);
>  
>  	while (cur_lblk_off <= new_blk_size) {
> @@ -1792,7 +1792,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  
>  	cur = start;
>  	remaining = len;
> -	ext4_debug("ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
> +	ext4_debug("ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %llu\n",
>  		  start, start_pblk, len, ext4_ext_is_unwritten(ex),
>  		  inode->i_ino);
>  
> @@ -1903,7 +1903,7 @@ ext4_fc_replay_del_range(struct super_block *sb,
>  	if (ret)
>  		goto out;
>  
> -	ext4_debug("DEL_RANGE, inode %ld, lblk %d, len %d\n",
> +	ext4_debug("DEL_RANGE, inode %llu, lblk %d, len %d\n",
>  			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
>  			le32_to_cpu(lrange.fc_len));
>  	while (remaining > 0) {
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index b20a1bf866abedf3a768ee8a147f108ea09ecb01..628a74b2bbe6232eabbf2562ffd0e350ea37446e 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -253,13 +253,13 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>  		return;
>  	}
>  	if (icount_read(inode) > 1) {
> -		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: count=%d",
> +		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: count=%d",
>  			 __func__, __LINE__, inode->i_ino,
>  			 icount_read(inode));
>  		return;
>  	}
>  	if (inode->i_nlink) {
> -		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: nlink=%d\n",
> +		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: nlink=%d\n",
>  			 __func__, __LINE__, inode->i_ino, inode->i_nlink);
>  		return;
>  	}
> @@ -631,7 +631,7 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
>  	 *
>  	 * So add our directory's i_ino into the starting point for the hash.
>  	 */
> -	*group = (*group + parent->i_ino) % ngroups;
> +	*group = (*group + (unsigned int)parent->i_ino) % ngroups;
>  
>  	/*
>  	 * Use a quadratic hash to find a group with a free inode and some free
> @@ -1275,7 +1275,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		 * twice.
>  		 */
>  		err = -EIO;
> -		ext4_error(sb, "failed to insert inode %lu: doubly allocated?",
> +		ext4_error(sb, "failed to insert inode %llu: doubly allocated?",
>  			   inode->i_ino);
>  		ext4_mark_group_bitmap_corrupted(sb, group,
>  					EXT4_GROUP_INFO_IBITMAP_CORRUPT);
> @@ -1344,7 +1344,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		goto fail_free_drop;
>  	}
>  
> -	ext4_debug("allocating inode %lu\n", inode->i_ino);
> +	ext4_debug("allocating inode %llu\n", inode->i_ino);
>  	trace_ext4_allocate_inode(inode, dir, mode);
>  	brelse(inode_bitmap_bh);
>  	return ret;
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index da76353b3a5750987d7b4803c388248b749a68a8..5aec759eed7055dbe954c25da0181ebd04bb0be3 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -102,7 +102,7 @@ static int ext4_block_to_path(struct inode *inode,
>  		offsets[n++] = i_block & (ptrs - 1);
>  		final = ptrs;
>  	} else {
> -		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
> +		ext4_warning(inode->i_sb, "block %lu > max in inode %llu",
>  			     i_block + direct_blocks +
>  			     indirect_blocks + double_blocks, inode->i_ino);
>  	}
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 1f6bc05593df165776fda3ab2c272af586d80279..f846fcb7db2442149776fa2ba45ddc5e0b71245e 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -119,7 +119,7 @@ int ext4_get_max_inline_size(struct inode *inode)
>  	error = ext4_get_inode_loc(inode, &iloc);
>  	if (error) {
>  		ext4_error_inode_err(inode, __func__, __LINE__, 0, -error,
> -				     "can't get inode location %lu",
> +				     "can't get inode location %llu",
>  				     inode->i_ino);
>  		return 0;
>  	}
> @@ -512,7 +512,7 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
>  	BUG_ON(folio->index);
>  
>  	if (!EXT4_I(inode)->i_inline_off) {
> -		ext4_warning(inode->i_sb, "inode %lu doesn't have inline data.",
> +		ext4_warning(inode->i_sb, "inode %llu doesn't have inline data.",
>  			     inode->i_ino);
>  		goto out;
>  	}
> @@ -934,7 +934,7 @@ void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
>  	struct ext4_dir_entry_2 *de = inline_start;
>  	void *dlimit = inline_start + inline_size;
>  
> -	trace_printk("inode %lu\n", dir->i_ino);
> +	trace_printk("inode %llu\n", dir->i_ino);
>  	offset = 0;
>  	while ((void *)de < dlimit) {
>  		de_len = ext4_rec_len_from_disk(de->rec_len, inline_size);
> @@ -1071,7 +1071,7 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
>  	ret = ext4_create_inline_data(handle, inode, inline_size);
>  	if (ret) {
>  		ext4_msg(inode->i_sb, KERN_EMERG,
> -			"error restoring inline_data for inode -- potential data loss! (inode %lu, error %d)",
> +			"error restoring inline_data for inode -- potential data loss! (inode %llu, error %d)",
>  			inode->i_ino, ret);
>  		return;
>  	}
> @@ -1740,7 +1740,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
>  	err = ext4_get_inode_loc(dir, &iloc);
>  	if (err) {
>  		EXT4_ERROR_INODE_ERR(dir, -err,
> -				     "error %d getting inode %lu block",
> +				     "error %d getting inode %llu block",
>  				     err, dir->i_ino);
>  		return false;
>  	}
> @@ -1755,7 +1755,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
>  	de = (struct ext4_dir_entry_2 *)ext4_raw_inode(&iloc)->i_block;
>  	if (!le32_to_cpu(de->inode)) {
>  		ext4_warning(dir->i_sb,
> -			     "bad inline directory (dir #%lu) - no `..'",
> +			     "bad inline directory (dir #%llu) - no `..'",
>  			     dir->i_ino);
>  		goto out;
>  	}
> @@ -1769,7 +1769,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
>  					 iloc.bh, inline_pos,
>  					 inline_size, offset)) {
>  			ext4_warning(dir->i_sb,
> -				     "bad inline directory (dir #%lu) - "
> +				     "bad inline directory (dir #%llu) - "
>  				     "inode %u, rec_len %u, name_len %d"
>  				     "inline size %d",
>  				     dir->i_ino, le32_to_cpu(de->inode),
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 396dc3a5d16b4dc4d3e5c6541871a9bb896f6d7a..d50f31124a784ba6eeb916f9a2f62ec840aee52e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -262,7 +262,7 @@ void ext4_evict_inode(struct inode *inode)
>  		err = ext4_truncate(inode);
>  		if (err) {
>  			ext4_error_err(inode->i_sb, -err,
> -				       "couldn't truncate inode %lu (err %d)",
> +				       "couldn't truncate inode %llu (err %d)",
>  				       inode->i_ino, err);
>  			goto stop_handle;
>  		}
> @@ -342,7 +342,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>  	spin_lock(&ei->i_block_reservation_lock);
>  	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
>  	if (unlikely(used > ei->i_reserved_data_blocks)) {
> -		ext4_warning(inode->i_sb, "%s: ino %lu, used %d "
> +		ext4_warning(inode->i_sb, "%s: ino %llu, used %d "
>  			 "with only %d reserved data blocks",
>  			 __func__, inode->i_ino, used,
>  			 ei->i_reserved_data_blocks);
> @@ -475,7 +475,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
>  	if (es_map->m_lblk != map->m_lblk ||
>  	    es_map->m_flags != map->m_flags ||
>  	    es_map->m_pblk != map->m_pblk) {
> -		printk("ES cache assertion failed for inode: %lu "
> +		printk("ES cache assertion failed for inode: %llu "
>  		       "es_cached ex [%d/%d/%llu/%x] != "
>  		       "found ex [%d/%d/%llu/%x] retval %d flags %x\n",
>  		       inode->i_ino, es_map->m_lblk, es_map->m_len,
> @@ -515,7 +515,7 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
>  	if (unlikely(retval != map2.m_len)) {
>  		ext4_warning(inode->i_sb,
>  			     "ES len assertion failed for inode "
> -			     "%lu: retval %d != map->m_len %d",
> +			     "%llu: retval %d != map->m_len %d",
>  			     inode->i_ino, retval, map2.m_len);
>  		WARN_ON(1);
>  	}
> @@ -563,7 +563,7 @@ int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  	if (unlikely(retval != map->m_len)) {
>  		ext4_warning(inode->i_sb,
>  			     "ES len assertion failed for inode "
> -			     "%lu: retval %d != map->m_len %d",
> +			     "%llu: retval %d != map->m_len %d",
>  			     inode->i_ino, retval, map->m_len);
>  		WARN_ON(1);
>  	}
> @@ -630,7 +630,7 @@ int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  
>  	if (unlikely(retval != map->m_len)) {
>  		ext4_warning(inode->i_sb,
> -			     "ES len assertion failed for inode %lu: "
> +			     "ES len assertion failed for inode %llu: "
>  			     "retval %d != map->m_len %d",
>  			     inode->i_ino, retval, map->m_len);
>  		WARN_ON(1);
> @@ -937,7 +937,7 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
>  {
>  	int ret = 0;
>  
> -	ext4_debug("ext4_get_block_unwritten: inode %lu, create flag %d\n",
> +	ext4_debug("ext4_get_block_unwritten: inode %llu, create flag %d\n",
>  		   inode->i_ino, create);
>  	ret = _ext4_get_block(inode, iblock, bh_result,
>  			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> @@ -1659,7 +1659,7 @@ void ext4_da_release_space(struct inode *inode, int to_free)
>  		 * harmless to return without any action.
>  		 */
>  		ext4_warning(inode->i_sb, "ext4_da_release_space: "
> -			 "ino %lu, to_free %d with only %d reserved "
> +			 "ino %llu, to_free %d with only %d reserved "
>  			 "data blocks", inode->i_ino, to_free,
>  			 ei->i_reserved_data_blocks);
>  		WARN_ON(1);
> @@ -2491,7 +2491,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  			}
>  			ext4_msg(sb, KERN_CRIT,
>  				 "Delayed block allocation failed for "
> -				 "inode %lu at logical offset %llu with"
> +				 "inode %llu at logical offset %llu with"
>  				 " max blocks %u with error %d",
>  				 inode->i_ino,
>  				 (unsigned long long)map->m_lblk,
> @@ -2535,7 +2535,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  		err2 = ext4_mark_inode_dirty(handle, inode);
>  		if (err2) {
>  			ext4_error_err(inode->i_sb, -err2,
> -				       "Failed to mark inode %lu dirty",
> +				       "Failed to mark inode %llu dirty",
>  				       inode->i_ino);
>  		}
>  		if (!err)
> @@ -2909,7 +2909,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		if (IS_ERR(handle)) {
>  			ret = PTR_ERR(handle);
>  			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
> -			       "%ld pages, ino %lu; err %d", __func__,
> +			       "%ld pages, ino %llu; err %d", __func__,
>  				wbc->nr_to_write, inode->i_ino, ret);
>  			/* Release allocated io_end */
>  			ext4_put_io_end(mpd->io_submit.io_end);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 3ae9cb50a0c057f10f6bda8165ba45fd2c368cfb..1d0c3d4bdf472715a7070b184fdc7d9bf5885950 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -477,7 +477,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	if (err < 0) {
>  		/* No need to update quota information. */
>  		ext4_warning(inode->i_sb,
> -			"couldn't mark inode #%lu dirty (err %d)",
> +			"couldn't mark inode #%llu dirty (err %d)",
>  			inode->i_ino, err);
>  		/* Revert all changes: */
>  		swap_inode_data(inode, inode_bl);
> @@ -493,7 +493,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	if (err < 0) {
>  		/* No need to update quota information. */
>  		ext4_warning(inode_bl->i_sb,
> -			"couldn't mark inode #%lu dirty (err %d)",
> +			"couldn't mark inode #%llu dirty (err %d)",
>  			inode_bl->i_ino, err);
>  		goto revert;
>  	}
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20e9fdaf4301b61c9d54401ed95067db6b6b8173..9e8041ac56239e64326343b0adef062611189d6a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2266,7 +2266,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  	folio_get(ac->ac_buddy_folio);
>  	/* store last allocated for subsequent stream allocation */
>  	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
> +		int hash = (unsigned int)ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
>  
>  		WRITE_ONCE(sbi->s_mb_last_groups[hash], ac->ac_f_ex.fe_group);
>  	}
> @@ -3032,7 +3032,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  
>  	/* if stream allocation is enabled, use global goal */
>  	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		int hash = ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
> +		int hash = (unsigned int)ac->ac_inode->i_ino % sbi->s_mb_nr_global_goals;
>  
>  		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_groups[hash]);
>  		ac->ac_g_ex.fe_start = -1;
> @@ -5628,7 +5628,7 @@ void ext4_discard_preallocations(struct inode *inode)
>  	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	mb_debug(sb, "discard preallocation for inode %lu\n",
> +	mb_debug(sb, "discard preallocation for inode %llu\n",
>  		 inode->i_ino);
>  	trace_ext4_discard_preallocations(inode,
>  			atomic_read(&ei->i_prealloc_active));
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 96ab95167bd6e10ba86e61a60cb0be9fbafe157f..477d43d7e2942b2286d0c81d0f9ea2379c968c9d 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -455,7 +455,7 @@ int ext4_ext_migrate(struct inode *inode)
>  	 * log, so disable fast commits for this transaction.
>  	 */
>  	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MIGRATE, handle);
> -	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
> +	goal = ((((u32)inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
>  		EXT4_INODES_PER_GROUP(inode->i_sb)) + 1;
>  	owner[0] = i_uid_read(inode);
>  	owner[1] = i_gid_read(inode);
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index ce1f738dff938c5685ef87099df4c87702657a39..ab17c1d3a7b51198c2332e8a1dd44f7a1bff40cf 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -420,21 +420,21 @@ static int mext_check_validity(struct inode *orig_inode,
>  
>  	/* origin and donor should be different inodes */
>  	if (orig_inode == donor_inode) {
> -		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
>  	/* origin and donor should belone to the same filesystem */
>  	if (orig_inode->i_sb != donor_inode->i_sb) {
> -		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
>  	/* Regular file check */
>  	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
> -		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> @@ -477,26 +477,26 @@ static int mext_check_validity(struct inode *orig_inode,
>  	}
>  
>  	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
> -		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
>  	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode)) {
> -		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EPERM;
>  	}
>  
>  	/* Ext4 move extent does not support swap files */
>  	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
> -		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -ETXTBSY;
>  	}
>  
>  	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
> -		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EOPNOTSUPP;
>  	}
> @@ -523,7 +523,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>  	/* Start offset should be same */
>  	if ((orig_start & ~(PAGE_MASK >> orig_inode->i_blkbits)) !=
>  	    (donor_start & ~(PAGE_MASK >> orig_inode->i_blkbits))) {
> -		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> @@ -533,7 +533,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>  	    (*len > EXT_MAX_BLOCKS) ||
>  	    (donor_start + *len >= EXT_MAX_BLOCKS) ||
>  	    (orig_start + *len >= EXT_MAX_BLOCKS))  {
> -		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %llu, donor %llu]\n",
>  			   EXT_MAX_BLOCKS,
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
> @@ -550,7 +550,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>  	else if (donor_eof < donor_start + *len - 1)
>  		*len = donor_eof - donor_start;
>  	if (!*len) {
> -		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %lu, donor %lu]\n",
> +		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index c4b5e252af0efbfcbaf83688a32d445327a74a02..503dc9ffd61465686bb1a253bfeee41c0e9acd59 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -144,7 +144,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  		bh = ext4_bread(NULL, inode, block, 0);
>  	if (IS_ERR(bh)) {
>  		__ext4_warning(inode->i_sb, func, line,
> -			       "inode #%lu: lblock %lu: comm %s: "
> +			       "inode #%llu: lblock %lu: comm %s: "
>  			       "error %ld reading directory block",
>  			       inode->i_ino, (unsigned long)block,
>  			       current->comm, PTR_ERR(bh));
> @@ -841,7 +841,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
>  	indirect = root->info.indirect_levels;
>  	if (indirect >= ext4_dir_htree_level(dir->i_sb)) {
>  		ext4_warning(dir->i_sb,
> -			     "Directory (ino: %lu) htree depth %#06x exceed"
> +			     "Directory (ino: %llu) htree depth %#06x exceed"
>  			     "supported value", dir->i_ino,
>  			     ext4_dir_htree_level(dir->i_sb));
>  		if (ext4_dir_htree_level(dir->i_sb) < EXT4_HTREE_LEVEL) {
> @@ -1793,7 +1793,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
>  		    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
>  		    !fscrypt_has_permitted_context(dir, inode)) {
>  			ext4_warning(inode->i_sb,
> -				     "Inconsistent encryption contexts: %lu/%lu",
> +				     "Inconsistent encryption contexts: %llu/%llu",
>  				     dir->i_ino, inode->i_ino);
>  			iput(inode);
>  			return ERR_PTR(-EPERM);
> @@ -2227,7 +2227,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  		csum_size = sizeof(struct ext4_dir_entry_tail);
>  
>  	blocksize =  dir->i_sb->s_blocksize;
> -	dxtrace(printk(KERN_DEBUG "Creating index: inode %lu\n", dir->i_ino));
> +	dxtrace(printk(KERN_DEBUG "Creating index: inode %llu\n", dir->i_ino));
>  	BUFFER_TRACE(bh, "get_write_access");
>  	retval = ext4_journal_get_write_access(handle, dir->i_sb, bh,
>  					       EXT4_JTR_NONE);
> @@ -2523,7 +2523,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			restart = 1;
>  		}
>  		if (add_level && levels == ext4_dir_htree_level(sb)) {
> -			ext4_warning(sb, "Directory (ino: %lu) index full, "
> +			ext4_warning(sb, "Directory (ino: %llu) index full, "
>  					 "reach max htree level :%d",
>  					 dir->i_ino, levels);
>  			if (ext4_dir_htree_level(sb) < EXT4_HTREE_LEVEL) {
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index c0022f0bff8749badfe80d2a7628bea5ce96ab1e..64ea4762423386db79e739a2448bf70c12415ef8 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -179,8 +179,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  	} else
>  		brelse(iloc.bh);
>  
> -	ext4_debug("superblock will point to %lu\n", inode->i_ino);
> -	ext4_debug("orphan inode %lu will point to %d\n",
> +	ext4_debug("superblock will point to %llu\n", inode->i_ino);
> +	ext4_debug("orphan inode %llu will point to %d\n",
>  			inode->i_ino, NEXT_ORPHAN(inode));
>  out:
>  	ext4_std_error(sb, err);
> @@ -249,7 +249,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  	}
>  
>  	mutex_lock(&sbi->s_orphan_lock);
> -	ext4_debug("remove inode %lu from orphan list\n", inode->i_ino);
> +	ext4_debug("remove inode %llu from orphan list\n", inode->i_ino);
>  
>  	prev = ei->i_orphan.prev;
>  	list_del_init(&ei->i_orphan);
> @@ -284,7 +284,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  		struct inode *i_prev =
>  			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
>  
> -		ext4_debug("orphan inode %lu will point to %u\n",
> +		ext4_debug("orphan inode %llu will point to %u\n",
>  			  i_prev->i_ino, ino_next);
>  		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
>  		if (err) {
> @@ -328,9 +328,9 @@ static void ext4_process_orphan(struct inode *inode,
>  	if (inode->i_nlink) {
>  		if (test_opt(sb, DEBUG))
>  			ext4_msg(sb, KERN_DEBUG,
> -				"%s: truncating inode %lu to %lld bytes",
> +				"%s: truncating inode %llu to %lld bytes",
>  				__func__, inode->i_ino, inode->i_size);
> -		ext4_debug("truncating inode %lu to %lld bytes\n",
> +		ext4_debug("truncating inode %llu to %lld bytes\n",
>  			   inode->i_ino, inode->i_size);
>  		inode_lock(inode);
>  		truncate_inode_pages(inode->i_mapping, inode->i_size);
> @@ -349,9 +349,9 @@ static void ext4_process_orphan(struct inode *inode,
>  	} else {
>  		if (test_opt(sb, DEBUG))
>  			ext4_msg(sb, KERN_DEBUG,
> -				"%s: deleting unreferenced inode %lu",
> +				"%s: deleting unreferenced inode %llu",
>  				__func__, inode->i_ino);
> -		ext4_debug("deleting unreferenced inode %lu\n",
> +		ext4_debug("deleting unreferenced inode %llu\n",
>  			   inode->i_ino);
>  		(*nr_orphans)++;
>  	}
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index a8c95eee91b79e36ebde09fac9033be359baf8fc..86011275ad83668d591488fad90959ec04625c55 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -180,7 +180,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  	struct super_block *sb = inode->i_sb;
>  	int ret = 0;
>  
> -	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
> +	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %llu,list->next 0x%p,"
>  		   "list->prev 0x%p\n",
>  		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
>  
> @@ -204,7 +204,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  		ext4_msg(sb, KERN_EMERG,
>  			 "failed to convert unwritten extents to written "
>  			 "extents -- potential data loss!  "
> -			 "(inode %lu, error %d)", inode->i_ino, ret);
> +			 "(inode %llu, error %d)", inode->i_ino, ret);
>  	}
>  
>  	ext4_clear_io_unwritten_flag(io_end);
> @@ -221,7 +221,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  	if (list_empty(head))
>  		return;
>  
> -	ext4_debug("Dump inode %lu completed io list\n", inode->i_ino);
> +	ext4_debug("Dump inode %llu completed io list\n", inode->i_ino);
>  	list_for_each_entry(io_end, head, list) {
>  		cur = &io_end->list;
>  		before = cur->prev;
> @@ -229,7 +229,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  		after = cur->next;
>  		io_end1 = container_of(after, ext4_io_end_t, list);
>  
> -		ext4_debug("io 0x%p from inode %lu,prev 0x%p,next 0x%p\n",
> +		ext4_debug("io 0x%p from inode %llu,prev 0x%p,next 0x%p\n",
>  			    io_end, inode->i_ino, io_end0, io_end1);
>  	}
>  #endif
> @@ -366,7 +366,7 @@ static void ext4_end_bio(struct bio *bio)
>  	if (bio->bi_status) {
>  		struct inode *inode = io_end->inode;
>  
> -		ext4_warning(inode->i_sb, "I/O error %d writing to inode %lu "
> +		ext4_warning(inode->i_sb, "I/O error %d writing to inode %llu "
>  			     "starting block %llu)",
>  			     bio->bi_status, inode->i_ino,
>  			     (unsigned long long)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 43f680c750ae6b2cacb35bcaad262ba234676ef4..781c083000c2ea2232846b0827c7d4799d87bd5d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -848,12 +848,12 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>  		vaf.va = &args;
>  		if (block)
>  			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
> -			       "inode #%lu: block %llu: comm %s: %pV\n",
> +			       "inode #%llu: block %llu: comm %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       block, current->comm, &vaf);
>  		else
>  			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
> -			       "inode #%lu: comm %s: %pV\n",
> +			       "inode #%llu: comm %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       current->comm, &vaf);
>  		va_end(args);
> @@ -888,13 +888,13 @@ void __ext4_error_file(struct file *file, const char *function,
>  		vaf.va = &args;
>  		if (block)
>  			printk(KERN_CRIT
> -			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
> +			       "EXT4-fs error (device %s): %s:%d: inode #%llu: "
>  			       "block %llu: comm %s: path %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       block, current->comm, path, &vaf);
>  		else
>  			printk(KERN_CRIT
> -			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
> +			       "EXT4-fs error (device %s): %s:%d: inode #%llu: "
>  			       "comm %s: path %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       current->comm, path, &vaf);
> @@ -1035,14 +1035,14 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
> -	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
> +	       "inode #%llu: comm %s: %pV\n", inode->i_sb->s_id,
>  	       function, line, inode->i_ino, current->comm, &vaf);
>  	va_end(args);
>  }
>  
>  void __ext4_grp_locked_error(const char *function, unsigned int line,
>  			     struct super_block *sb, ext4_group_t grp,
> -			     unsigned long ino, ext4_fsblk_t block,
> +			     u64 ino, ext4_fsblk_t block,
>  			     const char *fmt, ...)
>  __releases(bitlock)
>  __acquires(bitlock)
> @@ -1061,7 +1061,7 @@ __acquires(bitlock)
>  		printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: group %u, ",
>  		       sb->s_id, function, line, grp);
>  		if (ino)
> -			printk(KERN_CONT "inode %lu: ", ino);
> +			printk(KERN_CONT "inode %llu: ", ino);
>  		if (block)
>  			printk(KERN_CONT "block %llu:",
>  			       (unsigned long long) block);
> @@ -1170,7 +1170,7 @@ static void dump_orphan_list(struct super_block *sb, struct ext4_sb_info *sbi)
>  	list_for_each(l, &sbi->s_orphan) {
>  		struct inode *inode = orphan_list_entry(l);
>  		printk(KERN_ERR "  "
> -		       "inode %s:%lu at %p: mode %o, nlink %d, next %d\n",
> +		       "inode %s:%llu at %p: mode %o, nlink %d, next %d\n",
>  		       inode->i_sb->s_id, inode->i_ino, inode,
>  		       inode->i_mode, inode->i_nlink,
>  		       NEXT_ORPHAN(inode));
> @@ -1446,7 +1446,7 @@ static void ext4_free_in_core_inode(struct inode *inode)
>  {
>  	fscrypt_free_inode(inode);
>  	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
> -		pr_warn("%s: inode %ld still in fc list",
> +		pr_warn("%s: inode %llu still in fc list",
>  			__func__, inode->i_ino);
>  	}
>  	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
> @@ -1456,7 +1456,7 @@ static void ext4_destroy_inode(struct inode *inode)
>  {
>  	if (ext4_inode_orphan_tracked(inode)) {
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): inode tracked as orphan!",
> +			 "Inode %llu (%p): inode tracked as orphan!",
>  			 inode->i_ino, EXT4_I(inode));
>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>  				EXT4_I(inode), sizeof(struct ext4_inode_info),
> @@ -1467,7 +1467,7 @@ static void ext4_destroy_inode(struct inode *inode)
>  	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ERROR_FS) &&
>  	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
> +			 "Inode %llu (%p): i_reserved_data_blocks (%u) not cleared!",
>  			 inode->i_ino, EXT4_I(inode),
>  			 EXT4_I(inode)->i_reserved_data_blocks);
>  }
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7bf9ba19a89db2cd9e9536191eb904afe4c5f5d8..60aec4712f7fc52a8cc8ce31e4d5bd740a193903 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -64,7 +64,7 @@
>  
>  #ifdef EXT4_XATTR_DEBUG
>  # define ea_idebug(inode, fmt, ...)					\
> -	printk(KERN_DEBUG "inode %s:%lu: " fmt "\n",			\
> +	printk(KERN_DEBUG "inode %s:%llu: " fmt "\n",			\
>  	       inode->i_sb->s_id, inode->i_ino, ##__VA_ARGS__)
>  # define ea_bdebug(bh, fmt, ...)					\
>  	printk(KERN_DEBUG "block %pg:%lu: " fmt "\n",			\
> @@ -1035,7 +1035,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  	ref_count = ext4_xattr_inode_get_ref(ea_inode);
>  	if ((ref_count == 0 && ref_change < 0) || (ref_count == U64_MAX && ref_change > 0)) {
>  		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
> -			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",
> +			"EA inode %llu ref wraparound: ref_count=%lld ref_change=%d",
>  			ea_inode->i_ino, ref_count, ref_change);
>  		brelse(iloc.bh);
>  		ret = -EFSCORRUPTED;
> @@ -1046,7 +1046,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  
>  	if (ref_change > 0) {
>  		if (ref_count == 1) {
> -			WARN_ONCE(ea_inode->i_nlink, "EA inode %lu i_nlink=%u",
> +			WARN_ONCE(ea_inode->i_nlink, "EA inode %llu i_nlink=%u",
>  				  ea_inode->i_ino, ea_inode->i_nlink);
>  
>  			set_nlink(ea_inode, 1);
> @@ -1055,7 +1055,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  	} else {
>  		if (ref_count == 0) {
>  			WARN_ONCE(ea_inode->i_nlink != 1,
> -				  "EA inode %lu i_nlink=%u",
> +				  "EA inode %llu i_nlink=%u",
>  				  ea_inode->i_ino, ea_inode->i_nlink);
>  
>  			clear_nlink(ea_inode);
> @@ -2854,7 +2854,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  
>  cleanup:
>  	if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
> -		ext4_warning(inode->i_sb, "Unable to expand inode %lu. Delete some EAs or run e2fsck.",
> +		ext4_warning(inode->i_sb, "Unable to expand inode %llu. Delete some EAs or run e2fsck.",
>  			     inode->i_ino);
>  		mnt_count = le16_to_cpu(sbi->s_es->s_mnt_count);
>  	}
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 8c76400ba6317d9b62428a1d7b53a54d7c5d07ef..0b8be500db656f8439725cac2f6a927c2f06ca4f 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -773,7 +773,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
>  			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
>  				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
>  				f2fs_info_ratelimited(sbi,
> -					"checksum invalid, nid = %lu, %x vs %x",
> +					"checksum invalid, nid = %llu, %x vs %x",
>  					dic->inode->i_ino,
>  					provided, calculated);
>  			}
> @@ -932,7 +932,7 @@ bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
>  
>  	return false;
>  out:
> -	f2fs_warn(sbi, "access invalid cluster, ino:%lu, nid:%u, ofs_in_node:%u, reason:%s",
> +	f2fs_warn(sbi, "access invalid cluster, ino:%llu, nid:%u, ofs_in_node:%u, reason:%s",
>  			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
>  	set_sbi_flag(sbi, SBI_NEED_FSCK);
>  	return true;
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index f70092e231f0f47e589d648b0c6f83ef3aa8fd6c..38802ee2e40deb4995a4e5f4118330b90b2f10e2 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -368,7 +368,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  
>  	max_depth = F2FS_I(dir)->i_current_depth;
>  	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
> -		f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %lu: %u",
> +		f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %llu: %u",
>  			  dir->i_ino, max_depth);
>  		max_depth = MAX_DIR_HASH_DEPTH;
>  		f2fs_i_depth_write(dir, max_depth);
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 0ed84cc065a7eda66c50eae97d70e9ab93de31c3..d73aeef333a24766aaab9914a02b99fbf035e78d 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -34,7 +34,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
>  	if (!f2fs_is_valid_blkaddr(sbi, ei.blk, DATA_GENERIC_ENHANCE) ||
>  	    !f2fs_is_valid_blkaddr(sbi, ei.blk + ei.len - 1,
>  					DATA_GENERIC_ENHANCE)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>  			  __func__, inode->i_ino,
>  			  ei.blk, ei.fofs, ei.len);
>  		return false;
> @@ -50,14 +50,14 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
>  
>  		if (devi == 0) {
>  			f2fs_warn(sbi,
> -			    "%s: inode (ino=%lx) is an alias of meta device",
> +			    "%s: inode (ino=%llx) is an alias of meta device",
>  			    __func__, inode->i_ino);
>  			return false;
>  		}
>  
>  		if (bdev_is_zoned(FDEV(devi).bdev)) {
>  			f2fs_warn(sbi,
> -			    "%s: device alias inode (ino=%lx)'s extent info "
> +			    "%s: device alias inode (ino=%llx)'s extent info "
>  			    "[%u, %u, %u] maps to zoned block device",
>  			    __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
>  			return false;
> @@ -65,7 +65,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
>  		return true;
>  	}
>  
> -	f2fs_warn(sbi, "%s: device alias inode (ino=%lx)'s extent info "
> +	f2fs_warn(sbi, "%s: device alias inode (ino=%llx)'s extent info "
>  			"[%u, %u, %u] is inconsistent w/ any devices",
>  			__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
>  	return false;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index bb34e864d0efc742c651a285c5989bd73530fbe3..760e6d80bbddd8393394c30c740ba05faded332f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2706,7 +2706,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>  
>  	spin_lock(&sbi->stat_lock);
>  	if (unlikely(sbi->total_valid_block_count < count)) {
> -		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%lu, count:%u",
> +		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%llu, count:%u",
>  			  sbi->total_valid_block_count, inode->i_ino, count);
>  		sbi->total_valid_block_count = 0;
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
> @@ -2719,7 +2719,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>  					sbi->current_reserved_blocks + count);
>  	spin_unlock(&sbi->stat_lock);
>  	if (unlikely(inode->i_blocks < sectors)) {
> -		f2fs_warn(sbi, "Inconsistent i_blocks, ino:%lu, iblocks:%llu, sectors:%llu",
> +		f2fs_warn(sbi, "Inconsistent i_blocks, ino:%llu, iblocks:%llu, sectors:%llu",
>  			  inode->i_ino,
>  			  (unsigned long long)inode->i_blocks,
>  			  (unsigned long long)sectors);
> @@ -2993,7 +2993,7 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
>  		dquot_free_inode(inode);
>  	} else {
>  		if (unlikely(inode->i_blocks == 0)) {
> -			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%lu, iblocks:%llu",
> +			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%llu, iblocks:%llu",
>  				  inode->i_ino,
>  				  (unsigned long long)inode->i_blocks);
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c8a2f17a8f11cfc746c6a6ec4a225199929c2ee6..a7957e03ee034d8f860952df4563d026151ddcc5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1917,7 +1917,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>  				f2fs_up_write(&sbi->pin_sem);
>  				err = -ENOSPC;
>  				f2fs_warn_ratelimited(sbi,
> -					"ino:%lu, start:%lu, end:%lu, need to trigger GC to "
> +					"ino:%llu, start:%lu, end:%lu, need to trigger GC to "
>  					"reclaim enough free segment when checkpoint is enabled",
>  					inode->i_ino, pg_start, pg_end);
>  				goto out_err;
> @@ -2307,7 +2307,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  	 * f2fs_is_atomic_file.
>  	 */
>  	if (get_dirty_pages(inode))
> -		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%lu, npages=%u",
> +		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%llu, npages=%u",
>  			  inode->i_ino, get_dirty_pages(inode));
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret)
> @@ -3494,7 +3494,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
>  		return -EINVAL;
>  
>  	if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
> -		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
> +		f2fs_warn(sbi, "%s: Enable GC = ino %llx after %x GC trials",
>  			  __func__, inode->i_ino, fi->i_gc_failures);
>  		clear_inode_flag(inode, FI_PIN_FILE);
>  		return -EAGAIN;
> @@ -3679,7 +3679,7 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
>  
>  	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
>  		f2fs_warn(F2FS_I_SB(inode),
> -			  "Can't enable fs-verity on inode %lu: the verity feature is not enabled on this filesystem",
> +			  "Can't enable fs-verity on inode %llu: the verity feature is not enabled on this filesystem",
>  			  inode->i_ino);
>  		return -EOPNOTSUPP;
>  	}
> @@ -3950,7 +3950,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	} else if (released_blocks &&
>  			atomic_read(&fi->i_compr_blocks)) {
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
> +		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%llx "
>  			"iblocks=%llu, released=%u, compr_blocks=%u, "
>  			"run fsck to fix.",
>  			__func__, inode->i_ino, inode->i_blocks,
> @@ -4133,7 +4133,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  	} else if (reserved_blocks &&
>  			atomic_read(&fi->i_compr_blocks)) {
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%lx "
> +		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%llx "
>  			"iblocks=%llu, reserved=%u, compr_blocks=%u, "
>  			"run fsck to fix.",
>  			__func__, inode->i_ino, inode->i_blocks,
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index f46b2673d31f5a334bac543947e713cfe85dc68a..c0c8a1056d6b089397b4aa92b88b14cfd88c9de5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1622,7 +1622,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  				iput(inode);
>  				set_sbi_flag(sbi, SBI_NEED_FSCK);
>  				f2fs_err_ratelimited(sbi,
> -					"inode %lx has both inline_data flag and "
> +					"inode %llu has both inline_data flag and "
>  					"data block, nid=%u, ofs_in_node=%u",
>  					inode->i_ino, dni.nid, ofs_in_node);
>  				continue;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 0a1052d5ee624e68ba27200b100a567a5d216f2a..2669439b941387a96318f77fca7dfe35723e59d9 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -176,7 +176,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
>  	if (unlikely(dn->data_blkaddr != NEW_ADDR)) {
>  		f2fs_put_dnode(dn);
>  		set_sbi_flag(fio.sbi, SBI_NEED_FSCK);
> -		f2fs_warn(fio.sbi, "%s: corrupted inline inode ino=%lx, i_addr[0]:0x%x, run fsck to fix.",
> +		f2fs_warn(fio.sbi, "%s: corrupted inline inode ino=%llu, i_addr[0]:0x%x, run fsck to fix.",
>  			  __func__, dn->inode->i_ino, dn->data_blkaddr);
>  		f2fs_handle_error(fio.sbi, ERROR_INVALID_BLKADDR);
>  		return -EFSCORRUPTED;
> @@ -431,7 +431,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
>  	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
>  		f2fs_put_dnode(&dn);
>  		set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
> -		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%lx, i_addr[0]:0x%x, run fsck to fix.",
> +		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%llu, i_addr[0]:0x%x, run fsck to fix.",
>  			  __func__, dir->i_ino, dn.data_blkaddr);
>  		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
>  		err = -EFSCORRUPTED;
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index e0f850b3f0c38797fbba726af424161a147ee4f7..f27198d6695b91d2a041318aeecd04c65d38a4ba 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -203,14 +203,14 @@ static bool sanity_check_compress_inode(struct inode *inode,
>  
>  	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
>  		f2fs_warn(sbi,
> -			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
> +			"%s: inode (ino=%llx) has unsupported compress algorithm: %u, run fsck to fix",
>  			__func__, inode->i_ino, ri->i_compress_algorithm);
>  		return false;
>  	}
>  	if (le64_to_cpu(ri->i_compr_blocks) >
>  			SECTOR_TO_BLOCK(inode->i_blocks)) {
>  		f2fs_warn(sbi,
> -			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> +			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
>  			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
>  			SECTOR_TO_BLOCK(inode->i_blocks));
>  		return false;
> @@ -218,7 +218,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
>  	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
>  		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
>  		f2fs_warn(sbi,
> -			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
> +			"%s: inode (ino=%llx) has unsupported log cluster size: %u, run fsck to fix",
>  			__func__, inode->i_ino, ri->i_log_cluster_size);
>  		return false;
>  	}
> @@ -262,7 +262,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
>  
>  	return true;
>  err_level:
> -	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
> +	f2fs_warn(sbi, "%s: inode (ino=%llx) has unsupported compress level: %u, run fsck to fix",
>  		  __func__, inode->i_ino, clevel);
>  	return false;
>  }
> @@ -276,40 +276,40 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
>  
>  	iblocks = le64_to_cpu(F2FS_INODE(node_folio)->i_blocks);
>  	if (!iblocks) {
> -		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%lx iblocks=%llu, run fsck to fix.",
> +		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%llx iblocks=%llu, run fsck to fix.",
>  			  __func__, inode->i_ino, iblocks);
>  		return false;
>  	}
>  
>  	if (ino_of_node(node_folio) != nid_of_node(node_folio)) {
> -		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%lx, ino,nid: [%u, %u] run fsck to fix.",
> +		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%llx, ino,nid: [%u, %u] run fsck to fix.",
>  			  __func__, inode->i_ino,
>  			  ino_of_node(node_folio), nid_of_node(node_folio));
>  		return false;
>  	}
>  
>  	if (ino_of_node(node_folio) == fi->i_xattr_nid) {
> -		f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx, xnid=%x, run fsck to fix.",
> +		f2fs_warn(sbi, "%s: corrupted inode i_ino=%llx, xnid=%x, run fsck to fix.",
>  			  __func__, inode->i_ino, fi->i_xattr_nid);
>  		return false;
>  	}
>  
>  	if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
> -		f2fs_warn(sbi, "%s: directory inode (ino=%lx) has a single i_nlink",
> +		f2fs_warn(sbi, "%s: directory inode (ino=%llx) has a single i_nlink",
>  			  __func__, inode->i_ino);
>  		return false;
>  	}
>  
>  	if (f2fs_has_extra_attr(inode)) {
>  		if (!f2fs_sb_has_extra_attr(sbi)) {
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
> +			f2fs_warn(sbi, "%s: inode (ino=%llx) is with extra_attr, but extra_attr feature is off",
>  				  __func__, inode->i_ino);
>  			return false;
>  		}
>  		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
>  			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
>  			fi->i_extra_isize % sizeof(__le32)) {
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
> +			f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_extra_isize: %d, max: %zu",
>  				  __func__, inode->i_ino, fi->i_extra_isize,
>  				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
>  			return false;
> @@ -327,7 +327,7 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
>  		f2fs_has_inline_xattr(inode) &&
>  		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
>  		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
>  			  __func__, inode->i_ino, fi->i_inline_xattr_size,
>  			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
>  		return false;
> @@ -335,64 +335,64 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
>  
>  	if (!f2fs_sb_has_extra_attr(sbi)) {
>  		if (f2fs_sb_has_project_quota(sbi)) {
> -			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
>  				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
>  			return false;
>  		}
>  		if (f2fs_sb_has_inode_chksum(sbi)) {
> -			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
>  				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
>  			return false;
>  		}
>  		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
> -			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
>  				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
>  			return false;
>  		}
>  		if (f2fs_sb_has_inode_crtime(sbi)) {
> -			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
>  				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
>  			return false;
>  		}
>  		if (f2fs_sb_has_compression(sbi)) {
> -			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
>  				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
>  			return false;
>  		}
>  	}
>  
>  	if (f2fs_sanity_check_inline_data(inode, node_folio)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_data, run fsck to fix",
>  			  __func__, inode->i_ino, inode->i_mode);
>  		return false;
>  	}
>  
>  	if (f2fs_has_inline_dentry(inode) && !S_ISDIR(inode->i_mode)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_dentry, run fsck to fix",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_dentry, run fsck to fix",
>  			  __func__, inode->i_ino, inode->i_mode);
>  		return false;
>  	}
>  
>  	if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx) has casefold flag, but casefold feature is off",
>  			  __func__, inode->i_ino);
>  		return false;
>  	}
>  
>  	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_xattr_nid: %u, run fsck to fix.",
>  			  __func__, inode->i_ino, fi->i_xattr_nid);
>  		return false;
>  	}
>  
>  	if (IS_DEVICE_ALIASING(inode)) {
>  		if (!f2fs_sb_has_device_alias(sbi)) {
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but the feature is off",
> +			f2fs_warn(sbi, "%s: inode (ino=%llx) has device alias flag, but the feature is off",
>  				  __func__, inode->i_ino);
>  			return false;
>  		}
>  		if (!f2fs_is_pinned_file(inode)) {
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but is not pinned",
> +			f2fs_warn(sbi, "%s: inode (ino=%llx) has device alias flag, but is not pinned",
>  				  __func__, inode->i_ino);
>  			return false;
>  		}
> @@ -925,7 +925,7 @@ void f2fs_evict_inode(struct inode *inode)
>  			 */
>  			if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
>  				f2fs_warn(F2FS_I_SB(inode),
> -					"f2fs_evict_inode: inconsistent node id, ino:%lu",
> +					"f2fs_evict_inode: inconsistent node id, ino:%llu",
>  					inode->i_ino);
>  				f2fs_inode_synced(inode);
>  				set_sbi_flag(sbi, SBI_NEED_FSCK);
> @@ -954,7 +954,7 @@ void f2fs_evict_inode(struct inode *inode)
>  		 */
>  		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
>  			f2fs_warn(sbi,
> -				"f2fs_evict_inode: inode is dirty, ino:%lu",
> +				"f2fs_evict_inode: inode is dirty, ino:%llu",
>  				inode->i_ino);
>  			f2fs_inode_synced(inode);
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index e360f08a9586ab5b75d6e1e1748219c3190a7580..efbb0732d4206f63b5221605a08ffa5c17e8a8b6 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -505,7 +505,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  	}
>  
>  	if (inode->i_nlink == 0) {
> -		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
> +		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%llx) has zero i_nlink",
>  			  __func__, inode->i_ino);
>  		err = -EFSCORRUPTED;
>  		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
> @@ -515,7 +515,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  	if (IS_ENCRYPTED(dir) &&
>  	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
>  	    !fscrypt_has_permitted_context(dir, inode)) {
> -		f2fs_warn(F2FS_I_SB(inode), "Inconsistent encryption contexts: %lu/%lu",
> +		f2fs_warn(F2FS_I_SB(inode), "Inconsistent encryption contexts: %llu/%llu",
>  			  dir->i_ino, inode->i_ino);
>  		err = -EPERM;
>  		goto out_iput;
> @@ -573,11 +573,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>  	}
>  
>  	if (unlikely(inode->i_nlink == 0)) {
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) has zero i_nlink",
> +		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
>  			  __func__, inode->i_ino);
>  		goto corrupted;
>  	} else if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
> -		f2fs_warn(sbi, "%s: directory inode (ino=%lx) has a single i_nlink",
> +		f2fs_warn(sbi, "%s: directory inode (ino=%llx) has a single i_nlink",
>  			  __func__, inode->i_ino);
>  		goto corrupted;
>  	}
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d8d02870cfd1c22cf1951201361519de534b6bf7..2856d5dbdd00a659b548ca6a0d8a973fc1341297 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -847,7 +847,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
>  			err = -EFSCORRUPTED;
>  			f2fs_err_ratelimited(sbi,
>  				"inode mapping table is corrupted, run fsck to fix it, "
> -				"ino:%lu, nid:%u, level:%d, offset:%d",
> +				"ino:%llu, nid:%u, level:%d, offset:%d",
>  				dn->inode->i_ino, nids[i], level, offset[level]);
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
>  			goto release_pages;
> @@ -1013,7 +1013,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
>  		return PTR_ERR(folio);
>  
>  	if (IS_INODE(folio) || ino_of_node(folio) != dn->inode->i_ino) {
> -		f2fs_err(sbi, "incorrect node reference, ino: %lu, nid: %u, ino_of_node: %u",
> +		f2fs_err(sbi, "incorrect node reference, ino: %llu, nid: %u, ino_of_node: %u",
>  				dn->inode->i_ino, dn->nid, ino_of_node(folio));
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
>  		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
> @@ -1194,7 +1194,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
>  	if (level <= 0) {
>  		if (!level) {
>  			level = -EFSCORRUPTED;
> -			f2fs_err(sbi, "%s: inode ino=%lx has corrupted node block, from:%lu addrs:%u",
> +			f2fs_err(sbi, "%s: inode ino=%llx has corrupted node block, from:%lu addrs:%u",
>  					__func__, inode->i_ino,
>  					from, ADDRS_PER_INODE(inode));
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
> @@ -1265,7 +1265,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
>  			set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
>  			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			f2fs_err_ratelimited(sbi,
> -				"truncate node fail, ino:%lu, nid:%u, "
> +				"truncate node fail, ino:%llu, nid:%u, "
>  				"offset[0]:%d, offset[1]:%d, nofs:%d",
>  				inode->i_ino, dn.nid, offset[0],
>  				offset[1], nofs);
> @@ -1351,7 +1351,7 @@ int f2fs_remove_inode_page(struct inode *inode)
>  
>  	if (unlikely(inode->i_blocks != 0 && inode->i_blocks != 8)) {
>  		f2fs_warn(F2FS_I_SB(inode),
> -			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%lu, iblocks:%llu",
> +			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%llu, iblocks:%llu",
>  			inode->i_ino, (unsigned long long)inode->i_blocks);
>  		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>  	}
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index a26071f2b0bc81fb768982841e37a63b2ca701b3..3d3dacec94825f6695d67043fd3ca42329aa5929 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -232,7 +232,7 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
>  		name = "<encrypted>";
>  	else
>  		name = raw_inode->i_name;
> -	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %lx, err = %d",
> +	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %llu, err = %d",
>  		    __func__, ino_of_node(ifolio), name,
>  		    IS_ERR(dir) ? 0 : dir->i_ino, err);
>  	return err;
> @@ -532,7 +532,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
>  
>  	max_addrs = ADDRS_PER_PAGE(dn->node_folio, dn->inode);
>  	if (ofs_in_node >= max_addrs) {
> -		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%lu, nid:%u, max:%u",
> +		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%llu, nid:%u, max:%u",
>  			ofs_in_node, dn->inode->i_ino, nid, max_addrs);
>  		f2fs_handle_error(sbi, ERROR_INCONSISTENT_SUMMARY);
>  		return -EFSCORRUPTED;
> @@ -674,7 +674,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  	f2fs_bug_on(sbi, ni.ino != ino_of_node(folio));
>  
>  	if (ofs_of_node(dn.node_folio) != ofs_of_node(folio)) {
> -		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%lu, ofs:%u, %u",
> +		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
>  			  inode->i_ino, ofs_of_node(dn.node_folio),
>  			  ofs_of_node(folio));
>  		err = -EFSCORRUPTED;
> @@ -748,7 +748,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  
>  			if (f2fs_is_valid_blkaddr(sbi, dest,
>  					DATA_GENERIC_ENHANCE_UPDATE)) {
> -				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
> +				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%llu, ofs:%u",
>  					dest, inode->i_ino, dn.ofs_in_node);
>  				err = -EFSCORRUPTED;
>  				goto err;
> @@ -768,7 +768,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  err:
>  	f2fs_put_dnode(&dn);
>  out:
> -	f2fs_notice(sbi, "recover_data: ino = %lx, nid = %x (i_size: %s), "
> +	f2fs_notice(sbi, "recover_data: ino = %llx, nid = %x (i_size: %s), "
>  		    "range (%u, %u), recovered = %d, err = %d",
>  		    inode->i_ino, nid_of_node(folio),
>  		    file_keep_isize(inode) ? "keep" : "recover",
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 941dc62a6d6f7c50c1a661397ef1bbb611e6c304..610d5810074dc501d02c93a4feb308e12a21a056 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -365,7 +365,7 @@ static int lookup_all_xattrs(struct inode *inode, struct folio *ifolio,
>  
>  	*xe = __find_xattr(cur_addr, last_txattr_addr, NULL, index, len, name);
>  	if (!*xe) {
> -		f2fs_err(F2FS_I_SB(inode), "lookup inode (%lu) has corrupted xattr",
> +		f2fs_err(F2FS_I_SB(inode), "lookup inode (%llu) has corrupted xattr",
>  								inode->i_ino);
>  		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>  		err = -ENODATA;
> @@ -585,7 +585,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  
>  		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
>  			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
> -			f2fs_err(F2FS_I_SB(inode), "list inode (%lu) has corrupted xattr",
> +			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
>  						inode->i_ino);
>  			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>  			f2fs_handle_error(F2FS_I_SB(inode),
> @@ -664,14 +664,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  		if (!F2FS_I(inode)->i_xattr_nid) {
>  			error = f2fs_recover_xattr_data(inode, NULL);
>  			f2fs_notice(F2FS_I_SB(inode),
> -				"recover xattr in inode (%lu), error(%d)",
> +				"recover xattr in inode (%llu), error(%d)",
>  					inode->i_ino, error);
>  			if (!error) {
>  				kfree(base_addr);
>  				goto retry;
>  			}
>  		}
> -		f2fs_err(F2FS_I_SB(inode), "set inode (%lu) has corrupted xattr",
> +		f2fs_err(F2FS_I_SB(inode), "set inode (%llu) has corrupted xattr",
>  								inode->i_ino);
>  		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>  		error = -EFSCORRUPTED;
> @@ -699,7 +699,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  	while (!IS_XATTR_LAST_ENTRY(last)) {
>  		if ((void *)(last) + sizeof(__u32) > last_base_addr ||
>  			(void *)XATTR_NEXT_ENTRY(last) > last_base_addr) {
> -			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has invalid last xattr entry, entry_size: %zu",
> +			f2fs_err(F2FS_I_SB(inode), "inode (%llu) has invalid last xattr entry, entry_size: %zu",
>  					inode->i_ino, ENTRY_SIZE(last));
>  			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>  			error = -EFSCORRUPTED;
> diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
> index 26d367e3668da0cfd916881c7a07c047a7ef1bf5..e85222892038fd676d0bc02b9a8b00d1e3799142 100644
> --- a/fs/freevxfs/vxfs_bmap.c
> +++ b/fs/freevxfs/vxfs_bmap.c
> @@ -260,12 +260,12 @@ vxfs_bmap1(struct inode *ip, long iblock)
>  	if (VXFS_ISIMMED(vip))
>  		goto unsupp;
>  
> -	printk(KERN_WARNING "vxfs: inode %ld has no valid orgtype (%x)\n",
> +	printk(KERN_WARNING "vxfs: inode %llu has no valid orgtype (%x)\n",
>  			ip->i_ino, vip->vii_orgtype);
>  	BUG();
>  
>  unsupp:
> -	printk(KERN_WARNING "vxfs: inode %ld has an unsupported orgtype (%x)\n",
> +	printk(KERN_WARNING "vxfs: inode %llu has an unsupported orgtype (%x)\n",
>  			ip->i_ino, vip->vii_orgtype);
>  	return 0;
>  }
> diff --git a/fs/fserror.c b/fs/fserror.c
> index 06ca86adab9b769dfb72ec58b9e51627abee5152..1e4d11fd9562fd158a23b64ca60e9b7e01719cb8 100644
> --- a/fs/fserror.c
> +++ b/fs/fserror.c
> @@ -176,7 +176,7 @@ void fserror_report(struct super_block *sb, struct inode *inode,
>  lost:
>  	if (inode)
>  		pr_err_ratelimited(
> - "%s: lost file I/O error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
> + "%s: lost file I/O error report for ino %llu type %u pos 0x%llx len 0x%llx error %d",
>  		       sb->s_id, inode->i_ino, type, pos, len, error);
>  	else
>  		pr_err_ratelimited(
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index b80ba40e38776123759df4b85c7f65daa19c6436..7f5339ee57c15aae2d5d00474133a985be3af6ca 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -417,7 +417,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
>  	int entry_size, type;
>  	int err;
>  
> -	hfs_dbg("cnid %u - (ino %lu, name %s) - (ino %lu, name %s)\n",
> +	hfs_dbg("cnid %u - (ino %llu, name %s) - (ino %llu, name %s)\n",
>  		cnid, src_dir->i_ino, src_name->name,
>  		dst_dir->i_ino, dst_name->name);
>  	sb = src_dir->i_sb;
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index a097908b269d0ad1575847dd01d6d4a4538262bf..f066a99a863bc739948aac921bc906874c6009b2 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -411,7 +411,7 @@ int hfs_extend_file(struct inode *inode)
>  		goto out;
>  	}
>  
> -	hfs_dbg("ino %lu, start %u, len %u\n", inode->i_ino, start, len);
> +	hfs_dbg("ino %llu, start %u, len %u\n", inode->i_ino, start, len);
>  	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks) {
>  		if (!HFS_I(inode)->first_blocks) {
>  			hfs_dbg("first_extent: start %u, len %u\n",
> @@ -482,7 +482,7 @@ void hfs_file_truncate(struct inode *inode)
>  	u32 size;
>  	int res;
>  
> -	hfs_dbg("ino %lu, phys_size %llu -> i_size %llu\n",
> +	hfs_dbg("ino %llu, phys_size %llu -> i_size %llu\n",
>  		inode->i_ino, (long long)HFS_I(inode)->phys_size,
>  		inode->i_size);
>  	if (inode->i_size > HFS_I(inode)->phys_size) {
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 878535db64d679995cd1f5c215f56c5258c3c720..95f0333a608b0fb57239cf5eec7d9489a25efb3a 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -270,7 +270,7 @@ void hfs_delete_inode(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  
> -	hfs_dbg("ino %lu\n", inode->i_ino);
> +	hfs_dbg("ino %llu\n", inode->i_ino);
>  	if (S_ISDIR(inode->i_mode)) {
>  		atomic64_dec(&HFS_SB(sb)->folder_count);
>  		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
> @@ -455,7 +455,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  	hfs_cat_rec rec;
>  	int res;
>  
> -	hfs_dbg("ino %lu\n", inode->i_ino);
> +	hfs_dbg("ino %llu\n", inode->i_ino);
>  	res = hfs_ext_write_extent(inode);
>  	if (res)
>  		return res;
> diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
> index 4b79cd606276e31c20fa18ef3a099596f50e8a0f..174cd13106ad66008a120e3e70984be7cb42a65f 100644
> --- a/fs/hfsplus/attributes.c
> +++ b/fs/hfsplus/attributes.c
> @@ -203,7 +203,7 @@ int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
>  	int entry_size;
>  	int err;
>  
> -	hfs_dbg("name %s, ino %ld\n",
> +	hfs_dbg("name %s, ino %llu\n",
>  		name ? name : NULL, inode->i_ino);
>  
>  	if (name) {
> @@ -255,7 +255,7 @@ int hfsplus_create_attr(struct inode *inode,
>  	hfsplus_attr_entry *entry_ptr;
>  	int err;
>  
> -	hfs_dbg("name %s, ino %ld\n",
> +	hfs_dbg("name %s, ino %llu\n",
>  		name ? name : NULL, inode->i_ino);
>  
>  	if (!HFSPLUS_SB(sb)->attr_tree) {
> @@ -337,7 +337,7 @@ int hfsplus_delete_attr_nolock(struct inode *inode, const char *name,
>  	struct super_block *sb = inode->i_sb;
>  	int err;
>  
> -	hfs_dbg("name %s, ino %ld\n",
> +	hfs_dbg("name %s, ino %llu\n",
>  		name ? name : NULL, inode->i_ino);
>  
>  	if (name) {
> @@ -367,7 +367,7 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
>  	struct super_block *sb = inode->i_sb;
>  	struct hfs_find_data fd;
>  
> -	hfs_dbg("name %s, ino %ld\n",
> +	hfs_dbg("name %s, ino %llu\n",
>  		name ? name : NULL, inode->i_ino);
>  
>  	if (!HFSPLUS_SB(sb)->attr_tree) {
> @@ -436,7 +436,7 @@ int hfsplus_replace_attr(struct inode *inode,
>  	hfsplus_attr_entry *entry_ptr;
>  	int err = 0;
>  
> -	hfs_dbg("name %s, ino %ld\n",
> +	hfs_dbg("name %s, ino %llu\n",
>  		name ? name : NULL, inode->i_ino);
>  
>  	if (!HFSPLUS_SB(sb)->attr_tree) {
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b86059ceaab7a7c68ab65adba6fa26..0e961e99b9856ab7d95da5d070b4fbce1e67ebde 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
>  	int entry_size, type;
>  	int err;
>  
> -	hfs_dbg("cnid %u - ino %lu, name %s - ino %lu, name %s\n",
> +	hfs_dbg("cnid %u - ino %llu, name %s - ino %llu, name %s\n",
>  		cnid, src_dir->i_ino, src_name->name,
>  		dst_dir->i_ino, dst_name->name);
>  	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index d559bf8625f853d50fd316d157cf8afe22069565..054f6da46033404bbbcf299beb5d8765495c0de3 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -313,7 +313,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
>  	if (!S_ISREG(inode->i_mode))
>  		return -EPERM;
>  
> -	hfs_dbg("src_dir->i_ino %lu, dst_dir->i_ino %lu, inode->i_ino %lu\n",
> +	hfs_dbg("src_dir->i_ino %llu, dst_dir->i_ino %llu, inode->i_ino %llu\n",
>  		src_dir->i_ino, dst_dir->i_ino, inode->i_ino);
>  
>  	mutex_lock(&sbi->vh_mutex);
> @@ -385,7 +385,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
>  	if (HFSPLUS_IS_RSRC(inode))
>  		return -EPERM;
>  
> -	hfs_dbg("dir->i_ino %lu, inode->i_ino %lu\n",
> +	hfs_dbg("dir->i_ino %llu, inode->i_ino %llu\n",
>  		dir->i_ino, inode->i_ino);
>  
>  	mutex_lock(&sbi->vh_mutex);
> @@ -393,7 +393,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
>  	if (inode->i_ino == cnid &&
>  	    atomic_read(&HFSPLUS_I(inode)->opencnt)) {
>  		str.name = name;
> -		str.len = sprintf(name, "temp%lu", inode->i_ino);
> +		str.len = sprintf(name, "temp%llu", inode->i_ino);
>  		res = hfsplus_rename_cat(inode->i_ino,
>  					 dir, &dentry->d_name,
>  					 sbi->hidden_dir, &str);
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index 8e886514d27f1e5d4d94be75142f197669e62234..474fde1a1653be6cf74b26e757c6d8a6f8d2906a 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
>  	mutex_unlock(&hip->extents_lock);
>  
>  done:
> -	hfs_dbg("ino %lu, iblock %llu - dblock %u\n",
> +	hfs_dbg("ino %llu, iblock %llu - dblock %u\n",
>  		inode->i_ino, (long long)iblock, dblock);
>  
>  	mask = (1 << sbi->fs_shift) - 1;
> @@ -476,7 +476,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
>  			goto out;
>  	}
>  
> -	hfs_dbg("ino %lu, start %u, len %u\n", inode->i_ino, start, len);
> +	hfs_dbg("ino %llu, start %u, len %u\n", inode->i_ino, start, len);
>  
>  	if (hip->alloc_blocks <= hip->first_blocks) {
>  		if (!hip->first_blocks) {
> @@ -545,7 +545,7 @@ void hfsplus_file_truncate(struct inode *inode)
>  	u32 alloc_cnt, blk_cnt, start;
>  	int res;
>  
> -	hfs_dbg("ino %lu, phys_size %llu -> i_size %llu\n",
> +	hfs_dbg("ino %llu, phys_size %llu -> i_size %llu\n",
>  		inode->i_ino, (long long)hip->phys_size, inode->i_size);
>  
>  	if (inode->i_size > hip->phys_size) {
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 922ff41df042a83d47364f2d941c45dabda29afb..02be32dc6833dfdd767c407ec0263485d1a2c3c6 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -230,7 +230,7 @@ static int hfsplus_get_perms(struct inode *inode,
>  		inode->i_flags &= ~S_APPEND;
>  	return 0;
>  bad_type:
> -	pr_err("invalid file type 0%04o for inode %lu\n", mode, inode->i_ino);
> +	pr_err("invalid file type 0%04o for inode %llu\n", mode, inode->i_ino);
>  	return -EIO;
>  }
>  
> @@ -328,7 +328,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
>  	struct hfsplus_vh *vhdr = sbi->s_vhdr;
>  	int error = 0, error2;
>  
> -	hfs_dbg("inode->i_ino %lu, start %llu, end %llu\n",
> +	hfs_dbg("inode->i_ino %llu, start %llu, end %llu\n",
>  		inode->i_ino, start, end);
>  
>  	error = file_write_and_wait_range(file, start, end);
> @@ -639,7 +639,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
>  	hfsplus_cat_entry entry;
>  	int res = 0;
>  
> -	hfs_dbg("inode->i_ino %lu\n", inode->i_ino);
> +	hfs_dbg("inode->i_ino %llu\n", inode->i_ino);
>  
>  	if (HFSPLUS_IS_RSRC(inode))
>  		main_inode = HFSPLUS_I(inode)->rsrc_inode;
> @@ -716,7 +716,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
>  	if (!res) {
>  		res = hfs_btree_write(tree);
>  		if (res) {
> -			pr_err("b-tree write err: %d, ino %lu\n",
> +			pr_err("b-tree write err: %d, ino %llu\n",
>  			       res, inode->i_ino);
>  		}
>  	}
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 7229a8ae89f9469109b1c3a317ee9b7705a83f8b..b3917249c206c3a25fe98b39a5eb2168b7404dc2 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -156,7 +156,7 @@ static int hfsplus_system_write_inode(struct inode *inode)
>  		int err = hfs_btree_write(tree);
>  
>  		if (err) {
> -			pr_err("b-tree write err: %d, ino %lu\n",
> +			pr_err("b-tree write err: %d, ino %llu\n",
>  			       err, inode->i_ino);
>  			return err;
>  		}
> @@ -169,7 +169,7 @@ static int hfsplus_write_inode(struct inode *inode,
>  {
>  	int err;
>  
> -	hfs_dbg("ino %lu\n", inode->i_ino);
> +	hfs_dbg("ino %llu\n", inode->i_ino);
>  
>  	err = hfsplus_ext_write_extent(inode);
>  	if (err)
> @@ -184,7 +184,7 @@ static int hfsplus_write_inode(struct inode *inode,
>  
>  static void hfsplus_evict_inode(struct inode *inode)
>  {
> -	hfs_dbg("ino %lu\n", inode->i_ino);
> +	hfs_dbg("ino %llu\n", inode->i_ino);
>  	truncate_inode_pages_final(&inode->i_data);
>  	clear_inode(inode);
>  	if (HFSPLUS_IS_RSRC(inode)) {
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9904944cbd54e3d326591fa65a5ed678f38ca583..c70bb6f494b22b1e3f74e18a9ef378e0c87f8194 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -277,7 +277,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
>  	u16 folder_finderinfo_len = sizeof(DInfo) + sizeof(DXInfo);
>  	u16 file_finderinfo_len = sizeof(FInfo) + sizeof(FXInfo);
>  
> -	hfs_dbg("ino %lu, name %s, value %p, size %zu\n",
> +	hfs_dbg("ino %llu, name %s, value %p, size %zu\n",
>  		inode->i_ino, name ? name : NULL,
>  		value, size);
>  
> @@ -447,7 +447,7 @@ int hfsplus_setxattr(struct inode *inode, const char *name,
>  		NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1;
>  	int res;
>  
> -	hfs_dbg("ino %lu, name %s, prefix %s, prefixlen %zu, "
> +	hfs_dbg("ino %llu, name %s, prefix %s, prefixlen %zu, "
>  		"value %p, size %zu\n",
>  		inode->i_ino, name ? name : NULL,
>  		prefix ? prefix : NULL, prefixlen,
> @@ -607,7 +607,7 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
>  	int res;
>  	char *xattr_name;
>  
> -	hfs_dbg("ino %lu, name %s, prefix %s\n",
> +	hfs_dbg("ino %llu, name %s, prefix %s\n",
>  		inode->i_ino, name ? name : NULL,
>  		prefix ? prefix : NULL);
>  
> @@ -717,7 +717,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  	size_t strbuf_size;
>  	int xattr_name_len;
>  
> -	hfs_dbg("ino %lu\n", inode->i_ino);
> +	hfs_dbg("ino %llu\n", inode->i_ino);
>  
>  	if (!is_xattr_operation_supported(inode))
>  		return -EOPNOTSUPP;
> @@ -819,7 +819,7 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
>  	int is_xattr_acl_deleted;
>  	int is_all_xattrs_deleted;
>  
> -	hfs_dbg("ino %lu, name %s\n",
> +	hfs_dbg("ino %llu, name %s\n",
>  		inode->i_ino, name ? name : NULL);
>  
>  	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
> diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
> index ceb50b2dc91a9da02997a40836d6543786d883d3..3bf11202e2d3c585a3f1aefb5180da82fd7d4a3f 100644
> --- a/fs/hpfs/dir.c
> +++ b/fs/hpfs/dir.c
> @@ -96,8 +96,8 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
>  		}
>  		if (!fnode_is_dir(fno)) {
>  			e = 1;
> -			hpfs_error(inode->i_sb, "not a directory, fnode %08lx",
> -					(unsigned long)inode->i_ino);
> +			hpfs_error(inode->i_sb, "not a directory, fnode %08llx",
> +					inode->i_ino);
>  		}
>  		if (hpfs_inode->i_dno != le32_to_cpu(fno->u.external[0].disk_secno)) {
>  			e = 1;
> diff --git a/fs/hpfs/dnode.c b/fs/hpfs/dnode.c
> index dde764ebe24673c339d4602172618dbf6ca0b5c9..8c6aa060fd874ac9ac844268b016491204d978fd 100644
> --- a/fs/hpfs/dnode.c
> +++ b/fs/hpfs/dnode.c
> @@ -550,9 +550,9 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
>  			if (hpfs_sb(i->i_sb)->sb_chk)
>  				if (up != i->i_ino) {
>  					hpfs_error(i->i_sb,
> -						   "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08lx",
> +						   "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08llx",
>  						   dno, up,
> -						   (unsigned long)i->i_ino);
> +						   i->i_ino);
>  					return;
>  				}
>  			if ((d1 = hpfs_map_dnode(i->i_sb, down, &qbh1))) {
> diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
> index 2149d3ca530b6f635ff884988383bdde21be5e7a..4664f9ab06eef3795b33cebcdc57e598cf83b0e9 100644
> --- a/fs/hpfs/ea.c
> +++ b/fs/hpfs/ea.c
> @@ -245,8 +245,8 @@ void hpfs_set_ea(struct inode *inode, struct fnode *fnode, const char *key,
>  		fnode->ea_offs = cpu_to_le16(0xc4);
>  	}
>  	if (le16_to_cpu(fnode->ea_offs) < 0xc4 || le16_to_cpu(fnode->ea_offs) + le16_to_cpu(fnode->acl_size_s) + le16_to_cpu(fnode->ea_size_s) > 0x200) {
> -		hpfs_error(s, "fnode %08lx: ea_offs == %03x, ea_size_s == %03x",
> -			(unsigned long)inode->i_ino,
> +		hpfs_error(s, "fnode %08llx: ea_offs == %03x, ea_size_s == %03x",
> +			inode->i_ino,
>  			le16_to_cpu(fnode->ea_offs), le16_to_cpu(fnode->ea_size_s));
>  		return;
>  	}
> diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
> index 93d528f4f4f28d5070162faacd65d3fc2341248a..0e932cc8be1b28353cffd8e62e26f77a02394edb 100644
> --- a/fs/hpfs/inode.c
> +++ b/fs/hpfs/inode.c
> @@ -250,8 +250,8 @@ void hpfs_write_inode_nolock(struct inode *i)
>  			hpfs_brelse4(&qbh);
>  		} else
>  			hpfs_error(i->i_sb,
> -				"directory %08lx doesn't have '.' entry",
> -				(unsigned long)i->i_ino);
> +				"directory %08llx doesn't have '.' entry",
> +				i->i_ino);
>  	}
>  	mark_buffer_dirty(bh);
>  	brelse(bh);
> diff --git a/fs/inode.c b/fs/inode.c
> index 62df5dda05894297dde05e541e4c8550bd866fef..5ad169d51728c260aeaabb810e59eb3ec1d1ce52 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -726,7 +726,7 @@ void dump_mapping(const struct address_space *mapping)
>  	struct dentry *dentry_ptr;
>  	struct dentry dentry;
>  	char fname[64] = {};
> -	unsigned long ino;
> +	u64 ino;
>  
>  	/*
>  	 * If mapping is an invalid pointer, we don't want to crash
> @@ -750,14 +750,14 @@ void dump_mapping(const struct address_space *mapping)
>  	}
>  
>  	if (!dentry_first) {
> -		pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
> +		pr_warn("aops:%ps ino:%llx\n", a_ops, ino);
>  		return;
>  	}
>  
>  	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
>  	if (get_kernel_nofault(dentry, dentry_ptr) ||
>  	    !dentry.d_parent || !dentry.d_name.name) {
> -		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
> +		pr_warn("aops:%ps ino:%llx invalid dentry:%px\n",
>  				a_ops, ino, dentry_ptr);
>  		return;
>  	}
> @@ -768,7 +768,7 @@ void dump_mapping(const struct address_space *mapping)
>  	 * Even if strncpy_from_kernel_nofault() succeeded,
>  	 * the fname could be unreliable
>  	 */
> -	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
> +	pr_warn("aops:%ps ino:%llx dentry name(?):\"%s\"\n",
>  		a_ops, ino, fname);
>  }
>  
> @@ -2641,9 +2641,8 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
>  		/* leave it no_open_fops */
>  		break;
>  	default:
> -		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o) for"
> -				  " inode %s:%lu\n", mode, inode->i_sb->s_id,
> -				  inode->i_ino);
> +		pr_debug("init_special_inode: bogus i_mode (%o) for inode %s:%llu\n",
> +			 mode, inode->i_sb->s_id, inode->i_ino);
>  		break;
>  	}
>  }
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 4d1ef8a2cee90b91591d387f8e1c3f75350c1da0..94d9a3c77bd68581d752fef4c16b88e1cb5f88da 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -48,7 +48,7 @@ static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  		mapping_set_error(inode->i_mapping, ioend->io_error);
>  		if (!bio_flagged(bio, BIO_QUIET)) {
>  			pr_err_ratelimited(
> -"%s: writeback error on inode %lu, offset %lld, sector %llu",
> +"%s: writeback error on inode %llu, offset %lld, sector %llu",
>  				inode->i_sb->s_id, inode->i_ino,
>  				ioend->io_offset, ioend->io_sector);
>  		}
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 50b4cb3aea87c7fc46b8b5483162bce84573b483..397568b9c7e7d3e28873be02c8a4befcddaec7b5 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -156,7 +156,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  				else {
>  					printk(KERN_DEBUG
>  					       "zisofs: zisofs_inflate returned"
> -					       " %d, inode = %lu,"
> +					       " %d, inode = %llu,"
>  					       " page idx = %d, bh idx = %d,"
>  					       " avail_in = %ld,"
>  					       " avail_out = %ld\n",
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index 2ca16c3fe5ef3427e5bbd0631eb8323ef3c58bf1..2fd9948d606e9c92f3003bfbaa4f0271c750a93d 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -152,7 +152,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  		    de_len < de->name_len[0] +
>  					sizeof(struct iso_directory_record)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
> -			       " in block %lu of inode %lu\n", block,
> +			       " in block %lu of inode %llu\n", block,
>  			       inode->i_ino);
>  			brelse(bh);
>  			return -EIO;
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 5c01536c5e8fecb73a95d801cdd3b8ee22011a3c..3593e02e75fef8567643137e0ff992019d2b6fbb 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1261,7 +1261,7 @@ static int isofs_read_level3_size(struct inode *inode)
>  
>  out_toomany:
>  	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
> -		"isofs_read_level3_size: inode=%lu\n",
> +		"isofs_read_level3_size: inode=%llu\n",
>  		__func__, inode->i_ino);
>  	goto out;
>  }
> @@ -1380,7 +1380,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
>  	/* I have no idea what file_unit_size is used for, so
>  	   we will flag it for now */
>  	if (de->file_unit_size[0] != 0) {
> -		printk(KERN_DEBUG "ISOFS: File unit size != 0 for ISO file (%ld).\n",
> +		printk(KERN_DEBUG "ISOFS: File unit size != 0 for ISO file (%llu).\n",
>  			inode->i_ino);
>  	}
>  
> @@ -1450,7 +1450,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
>  		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
>  		init_special_inode(inode, inode->i_mode, inode->i_rdev);
>  	} else {
> -		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %llu.\n",
>  			inode->i_mode, inode->i_ino);
>  		ret = -EIO;
>  		goto fail;
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index 58f80e1b3ac0d5082c24b5dbfd064cf5bff7d5a5..8dd3911717e0cc221f60fb6447e1bf26cc2223dd 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -100,7 +100,7 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
>  		/* Basic sanity check, whether name doesn't exceed dir entry */
>  		if (de_len < dlen + sizeof(struct iso_directory_record)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
> -			       " in block %lu of inode %lu\n", block,
> +			       " in block %lu of inode %llu\n", block,
>  			       dir->i_ino);
>  			brelse(bh);
>  			return 0;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index cb2c529a8f1bea33df6d4135e5782b9a77792732..b60918ed8a9965efe42419e6de3f449be50f7ca0 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1677,7 +1677,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  		return err ? ERR_PTR(err) : ERR_PTR(-EINVAL);
>  	}
>  
> -	jbd2_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
> +	jbd2_debug(1, "JBD2: inode %s/%llu, size %lld, bits %d, blksize %ld\n",
>  		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
>  		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
>  
> @@ -1689,7 +1689,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  
>  	journal->j_inode = inode;
>  	snprintf(journal->j_devname, sizeof(journal->j_devname),
> -		 "%pg-%lu", journal->j_dev, journal->j_inode->i_ino);
> +		 "%pg-%llu", journal->j_dev, journal->j_inode->i_ino);
>  	strreplace(journal->j_devname, '/', '!');
>  	jbd2_stats_proc_init(journal);
>  
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index dca4b5d8aaaa3e1505b09fab42eb45bb201a8db8..a90f9092706cceea56c1100f7d40ccba0d50adba 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2651,7 +2651,7 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
>  		return -EROFS;
>  	journal = transaction->t_journal;
>  
> -	jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
> +	jbd2_debug(4, "Adding inode %llu, tid:%d\n", jinode->i_vfs_inode->i_ino,
>  			transaction->t_tid);
>  
>  	spin_lock(&journal->j_list_lock);
> diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
> index 2b38ce1fd8e8d8d59e80f6ffb9ea2935f8cb27e4..c4088c3b4ac0362074cfa186c04f9c3afcccdff2 100644
> --- a/fs/jffs2/dir.c
> +++ b/fs/jffs2/dir.c
> @@ -129,7 +129,7 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
>  	struct jffs2_full_dirent *fd;
>  	unsigned long curofs = 1;
>  
> -	jffs2_dbg(1, "jffs2_readdir() for dir_i #%lu\n", inode->i_ino);
> +	jffs2_dbg(1, "jffs2_readdir() for dir_i #%llu\n", inode->i_ino);
>  
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
> @@ -211,7 +211,7 @@ static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
>  
>  	jffs2_free_raw_inode(ri);
>  
> -	jffs2_dbg(1, "%s(): Created ino #%lu with mode %o, nlink %d(%d). nrpages %ld\n",
> +	jffs2_dbg(1, "%s(): Created ino #%llu with mode %o, nlink %d(%d). nrpages %ld\n",
>  		  __func__, inode->i_ino, inode->i_mode, inode->i_nlink,
>  		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
>  
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index 5e1ef4bc009b6e5b4818a7467639fc328c137c12..1e18d3a798409d23440a5890808bc25372549e93 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -88,7 +88,7 @@ static int jffs2_do_readpage_nolock(struct inode *inode, struct folio *folio)
>  	unsigned char *kaddr;
>  	int ret;
>  
> -	jffs2_dbg(2, "%s(): ino #%lu, page at offset 0x%lx\n",
> +	jffs2_dbg(2, "%s(): ino #%llu, page at offset 0x%lx\n",
>  		  __func__, inode->i_ino, folio->index << PAGE_SHIFT);
>  
>  	BUG_ON(!folio_test_locked(folio));
> @@ -259,7 +259,7 @@ static int jffs2_write_end(const struct kiocb *iocb,
>  	uint32_t writtenlen = 0;
>  	void *buf;
>  
> -	jffs2_dbg(1, "%s(): ino #%lu, page at 0x%llx, range %d-%d, flags %lx\n",
> +	jffs2_dbg(1, "%s(): ino #%llu, page at 0x%llx, range %d-%d, flags %lx\n",
>  		  __func__, inode->i_ino, folio_pos(folio),
>  		  start, end, folio->flags.f);
>  
> diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
> index c3ce2c868f7a33476d5cde4f1af7c7ed9c6c6c41..6ada8369a76227c30ec27e8efebd93939376494e 100644
> --- a/fs/jffs2/fs.c
> +++ b/fs/jffs2/fs.c
> @@ -43,7 +43,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
>  	int ret;
>  	int alloc_type = ALLOC_NORMAL;
>  
> -	jffs2_dbg(1, "%s(): ino #%lu\n", __func__, inode->i_ino);
> +	jffs2_dbg(1, "%s(): ino #%llu\n", __func__, inode->i_ino);
>  
>  	/* Special cases - we don't want more than one data node
>  	   for these types on the medium at any time. So setattr
> @@ -243,7 +243,7 @@ void jffs2_evict_inode (struct inode *inode)
>  	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
>  	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
>  
> -	jffs2_dbg(1, "%s(): ino #%lu mode %o\n",
> +	jffs2_dbg(1, "%s(): ino #%llu mode %o\n",
>  		  __func__, inode->i_ino, inode->i_mode);
>  	truncate_inode_pages_final(&inode->i_data);
>  	clear_inode(inode);
> @@ -334,8 +334,8 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
>  		ret = jffs2_read_dnode(c, f, f->metadata, (char *)&jdev, 0, f->metadata->size);
>  		if (ret < 0) {
>  			/* Eep */
> -			pr_notice("Read device numbers for inode %lu failed\n",
> -				  (unsigned long)inode->i_ino);
> +			pr_notice("Read device numbers for inode %llu failed\n",
> +				  inode->i_ino);
>  			goto error;
>  		}
>  		if (f->metadata->size == sizeof(jdev.old_id))
> @@ -351,8 +351,8 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
>  		break;
>  
>  	default:
> -		pr_warn("%s(): Bogus i_mode %o for ino %lu\n",
> -			__func__, inode->i_mode, (unsigned long)inode->i_ino);
> +		pr_warn("%s(): Bogus i_mode %o for ino %llu\n",
> +			__func__, inode->i_mode, inode->i_ino);
>  	}
>  
>  	mutex_unlock(&f->sem);
> @@ -374,12 +374,12 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
>  	struct iattr iattr;
>  
>  	if (!(inode_state_read_once(inode) & I_DIRTY_DATASYNC)) {
> -		jffs2_dbg(2, "%s(): not calling setattr() for ino #%lu\n",
> +		jffs2_dbg(2, "%s(): not calling setattr() for ino #%llu\n",
>  			  __func__, inode->i_ino);
>  		return;
>  	}
>  
> -	jffs2_dbg(1, "%s(): calling setattr() for ino #%lu\n",
> +	jffs2_dbg(1, "%s(): calling setattr() for ino #%llu\n",
>  		  __func__, inode->i_ino);
>  
>  	iattr.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_MTIME|ATTR_CTIME;
> @@ -428,7 +428,7 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
>  	struct jffs2_inode_info *f;
>  	int ret;
>  
> -	jffs2_dbg(1, "%s(): dir_i %ld, mode 0x%x\n",
> +	jffs2_dbg(1, "%s(): dir_i %llu, mode 0x%x\n",
>  		  __func__, dir_i->i_ino, mode);
>  
>  	c = JFFS2_SB_INFO(sb);
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 4709762713efc5f1c6199ccfd9ecefe933e13f67..c7914dbc91ed97e200edbd114e2d4c695b46fb7e 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -64,7 +64,7 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
>  		inode->i_op = &jfs_file_inode_operations;
>  		init_special_inode(inode, inode->i_mode, inode->i_rdev);
>  	} else {
> -		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %llu.\n",
>  		       inode->i_mode, inode->i_ino);
>  		iget_failed(inode);
>  		return ERR_PTR(-EIO);
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 294a67327c735fb9cbe074078ed72e872862d710..13ab21e66f510befc477bd15d40f69544cb7a386 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -302,7 +302,7 @@ int diRead(struct inode *ip)
>  	unsigned long pageno;
>  	int rel_inode;
>  
> -	jfs_info("diRead: ino = %ld", ip->i_ino);
> +	jfs_info("diRead: ino = %llu", ip->i_ino);
>  
>  	ipimap = sbi->ipimap;
>  	JFS_IP(ip)->ipimap = ipimap;
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 64c6eaa7f3f264ac7c6c71ad8dd0d59b63f15414..c95804f6dc1912510c51163cc120d536de652fd3 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -692,7 +692,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
>  	unsigned long page_index;
>  	unsigned long page_offset;
>  
> -	jfs_info("__get_metapage: ino = %ld, lblock = 0x%lx, abs=%d",
> +	jfs_info("__get_metapage: ino = %llu, lblock = 0x%lx, abs=%d",
>  		 inode->i_ino, lblock, absolute);
>  
>  	l2bsize = inode->i_blkbits;
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 255a847ca0b6b9f7ab5a99c3aaa6856044ac0535..0b6be8b8aeb1edf85cbb1063763a230e70c64e18 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -487,7 +487,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>  	int			async_block = 0;
>  	__be32			ret;
>  
> -	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
> +	dprintk("lockd: nlmsvc_lock(%s/%llu, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
>  				inode->i_sb->s_id, inode->i_ino,
>  				lock->fl.c.flc_type,
>  				lock->fl.c.flc_pid,
> @@ -617,7 +617,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
>  	int			mode;
>  	__be32			ret;
>  
> -	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
> +	dprintk("lockd: nlmsvc_testlock(%s/%llu, ty=%d, %Ld-%Ld)\n",
>  				nlmsvc_file_inode(file)->i_sb->s_id,
>  				nlmsvc_file_inode(file)->i_ino,
>  				lock->fl.c.flc_type,
> @@ -676,7 +676,7 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
>  {
>  	int	error = 0;
>  
> -	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
> +	dprintk("lockd: nlmsvc_unlock(%s/%llu, pi=%d, %Ld-%Ld)\n",
>  				nlmsvc_file_inode(file)->i_sb->s_id,
>  				nlmsvc_file_inode(file)->i_ino,
>  				lock->fl.c.flc_pid,
> @@ -716,7 +716,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
>  	int status = 0;
>  	int mode;
>  
> -	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
> +	dprintk("lockd: nlmsvc_cancel(%s/%llu, pi=%d, %Ld-%Ld)\n",
>  				nlmsvc_file_inode(file)->i_sb->s_id,
>  				nlmsvc_file_inode(file)->i_ino,
>  				lock->fl.c.flc_pid,
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index dd0214dcb69503006181a1533c440fc04a329d73..79f3dd2fd3666d835161a54a6b3d2b69e7741dd5 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -47,7 +47,7 @@ static inline void nlm_debug_print_file(char *msg, struct nlm_file *file)
>  {
>  	struct inode *inode = nlmsvc_file_inode(file);
>  
> -	dprintk("lockd: %s %s/%ld\n",
> +	dprintk("lockd: %s %s/%llu\n",
>  		msg, inode->i_sb->s_id, inode->i_ino);
>  }
>  #else
> diff --git a/fs/locks.c b/fs/locks.c
> index d13ec930b7bb03905df50bdce30b84749edab8d0..d8b066fb42108971f6b3c7449dbc9b5f8df16b13 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -234,7 +234,7 @@ locks_check_ctx_lists(struct inode *inode)
>  	if (unlikely(!list_empty(&ctx->flc_flock) ||
>  		     !list_empty(&ctx->flc_posix) ||
>  		     !list_empty(&ctx->flc_lease))) {
> -		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%lx:\n",
> +		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%llx:\n",
>  			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
>  			inode->i_ino);
>  		locks_dump_ctx_list(&ctx->flc_flock, "FLOCK");
> @@ -251,7 +251,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list, char *list_
>  
>  	list_for_each_entry(flc, list, flc_list)
>  		if (flc->flc_file == filp)
> -			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
> +			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%llx "
>  				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
>  				list_type, MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino,
> @@ -2896,7 +2896,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
>  			     (type == F_RDLCK) ? "READ" : "UNLCK");
>  	if (inode) {
>  		/* userspace relies on this representation of dev_t */
> -		seq_printf(f, "%d %02x:%02x:%lu ", pid,
> +		seq_printf(f, "%d %02x:%02x:%llu ", pid,
>  				MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino);
>  	} else {
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index 99541c6a5bbf13f3be27474a316b31d8db9fbce0..838b072b6cf0b54c955320916ac996e72f994a14 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -36,7 +36,7 @@ void __minix_error_inode(struct inode *inode, const char *function,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	printk(KERN_CRIT "minix-fs error (device %s): %s:%d: "
> -	       "inode #%lu: comm %s: %pV\n",
> +	       "inode #%llu: comm %s: %pV\n",
>  	       inode->i_sb->s_id, function, line, inode->i_ino,
>  	       current->comm, &vaf);
>  	va_end(args);
> @@ -520,7 +520,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
>  		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>  		init_special_inode(inode, inode->i_mode, rdev);
>  	} else {
> -		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %llu.\n",
>  		       inode->i_mode, inode->i_ino);
>  		make_bad_inode(inode);
>  	}
> @@ -542,7 +542,7 @@ static struct inode *V1_minix_iget(struct inode *inode)
>  		return ERR_PTR(-EIO);
>  	}
>  	if (raw_inode->i_nlinks == 0) {
> -		printk("MINIX-fs: deleted inode referenced: %lu\n",
> +		printk("MINIX-fs: deleted inode referenced: %llu\n",
>  		       inode->i_ino);
>  		brelse(bh);
>  		iget_failed(inode);
> @@ -580,7 +580,7 @@ static struct inode *V2_minix_iget(struct inode *inode)
>  		return ERR_PTR(-EIO);
>  	}
>  	if (raw_inode->i_nlinks == 0) {
> -		printk("MINIX-fs: deleted inode referenced: %lu\n",
> +		printk("MINIX-fs: deleted inode referenced: %llu\n",
>  		       inode->i_ino);
>  		brelse(bh);
>  		iget_failed(inode);
> @@ -692,7 +692,7 @@ static int minix_write_inode(struct inode *inode, struct writeback_control *wbc)
>  	if (wbc->sync_mode == WB_SYNC_ALL && buffer_dirty(bh)) {
>  		sync_dirty_buffer(bh);
>  		if (buffer_req(bh) && !buffer_uptodate(bh)) {
> -			printk("IO error syncing minix inode [%s:%08lx]\n",
> +			printk("IO error syncing minix inode [%s:%08llx]\n",
>  				inode->i_sb->s_id, inode->i_ino);
>  			err = -EIO;
>  		}
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 2402f57c8e7d932c4656a1439f1deff7954e0dc4..ddc3789363a5f8a2ef0169e37aa2292d075092c4 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1906,7 +1906,7 @@ static int nfs_weak_revalidate(struct dentry *dentry, unsigned int flags)
>  	}
>  
>  	error = nfs_lookup_verify_inode(inode, flags);
> -	dfprintk(LOOKUPCACHE, "NFS: %s: inode %lu is %s\n",
> +	dfprintk(LOOKUPCACHE, "NFS: %s: inode %llu is %s\n",
>  			__func__, inode->i_ino, error ? "invalid" : "valid");
>  	return !error;
>  }
> @@ -2121,7 +2121,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
>  	/* Expect a negative dentry */
>  	BUG_ON(d_inode(dentry));
>  
> -	dfprintk(VFS, "NFS: atomic_open(%s/%lu), %pd\n",
> +	dfprintk(VFS, "NFS: atomic_open(%s/%llu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
>  
>  	err = nfs_check_flags(open_flags);
> @@ -2404,7 +2404,7 @@ static int nfs_do_create(struct inode *dir, struct dentry *dentry,
>  
>  	open_flags |= O_CREAT;
>  
> -	dfprintk(VFS, "NFS: create(%s/%lu), %pd\n",
> +	dfprintk(VFS, "NFS: create(%s/%llu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
>  
>  	attr.ia_mode = mode;
> @@ -2442,7 +2442,7 @@ nfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	struct iattr attr;
>  	int status;
>  
> -	dfprintk(VFS, "NFS: mknod(%s/%lu), %pd\n",
> +	dfprintk(VFS, "NFS: mknod(%s/%llu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
>  
>  	attr.ia_mode = mode;
> @@ -2469,7 +2469,7 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct iattr attr;
>  	struct dentry *ret;
>  
> -	dfprintk(VFS, "NFS: mkdir(%s/%lu), %pd\n",
> +	dfprintk(VFS, "NFS: mkdir(%s/%llu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
>  
>  	attr.ia_valid = ATTR_MODE;
> @@ -2507,7 +2507,7 @@ int nfs_rmdir(struct inode *dir, struct dentry *dentry)
>  {
>  	int error;
>  
> -	dfprintk(VFS, "NFS: rmdir(%s/%lu), %pd\n",
> +	dfprintk(VFS, "NFS: rmdir(%s/%llu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
>  
>  	trace_nfs_rmdir_enter(dir, dentry);
> @@ -2578,7 +2578,7 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	int error;
>  
> -	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
> +	dfprintk(VFS, "NFS: unlink(%s/%llu, %pd)\n", dir->i_sb->s_id,
>  		dir->i_ino, dentry);
>  
>  	trace_nfs_unlink_enter(dir, dentry);
> @@ -2638,7 +2638,7 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	unsigned int pathlen = strlen(symname);
>  	int error;
>  
> -	dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s)\n", dir->i_sb->s_id,
> +	dfprintk(VFS, "NFS: symlink(%s/%llu, %pd, %s)\n", dir->i_sb->s_id,
>  		dir->i_ino, dentry, symname);
>  
>  	if (pathlen > PAGE_SIZE)
> @@ -2660,7 +2660,7 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	error = NFS_PROTO(dir)->symlink(dir, dentry, folio, pathlen, &attr);
>  	trace_nfs_symlink_exit(dir, dentry, error);
>  	if (error != 0) {
> -		dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s) error %d\n",
> +		dfprintk(VFS, "NFS: symlink(%s/%llu, %pd, %s) error %d\n",
>  			dir->i_sb->s_id, dir->i_ino,
>  			dentry, symname, error);
>  		d_drop(dentry);
> @@ -3414,7 +3414,7 @@ int nfs_permission(struct mnt_idmap *idmap,
>  	if (!res && (mask & MAY_EXEC))
>  		res = nfs_execute_ok(inode, mask);
>  
> -	dfprintk(VFS, "NFS: permission(%s/%lu), mask=0x%x, res=%d\n",
> +	dfprintk(VFS, "NFS: permission(%s/%llu), mask=0x%x, res=%d\n",
>  		inode->i_sb->s_id, inode->i_ino, mask, res);
>  	return res;
>  out_notsup:
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 5d08b6409c284f1ee78f1c2fa327e447eee1ab69..25048a3c236436f334c87e2d58614f8af8929560 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -391,7 +391,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
>  
>  	trace_nfs_write_begin(file_inode(file), pos, len);
>  
> -	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
> +	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%llu), %u@%lld)\n",
>  		file, mapping->host->i_ino, len, (long long) pos);
>  	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos);
>  
> @@ -432,7 +432,7 @@ static int nfs_write_end(const struct kiocb *iocb,
>  	int status;
>  
>  	trace_nfs_write_end(file_inode(file), pos, len);
> -	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
> +	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%llu), %u@%lld)\n",
>  		file, mapping->host->i_ino, len, (long long) pos);
>  
>  	/*
> @@ -557,7 +557,7 @@ static int nfs_launder_folio(struct folio *folio)
>  	struct inode *inode = folio->mapping->host;
>  	int ret;
>  
> -	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
> +	dfprintk(PAGECACHE, "NFS: launder_folio(%llu, %llu)\n",
>  		inode->i_ino, folio_pos(folio));
>  
>  	folio_wait_private_2(folio); /* [DEPRECATED] */
> @@ -647,7 +647,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
>  	struct address_space *mapping;
>  	struct folio *folio = page_folio(vmf->page);
>  
> -	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
> +	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%llu), offset %lld)\n",
>  		 filp, filp->f_mapping->host->i_ino,
>  		 (long long)folio_pos(folio));
>  
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
> index 90a11afa5d05423bb289c7f2020ef3b82707a79c..e85380e3b11d7271a9b795e62840074834d77a72 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -241,7 +241,7 @@ filelayout_set_layoutcommit(struct nfs_pgio_header *hdr)
>  
>  	/* Note: if the write is unstable, don't set end_offs until commit */
>  	pnfs_set_layoutcommit(hdr->inode, hdr->lseg, end_offs);
> -	dprintk("%s inode %lu pls_end_pos %lu\n", __func__, hdr->inode->i_ino,
> +	dprintk("%s inode %llu pls_end_pos %lu\n", __func__, hdr->inode->i_ino,
>  		(unsigned long) NFS_I(hdr->inode)->layout->plh_lwb);
>  }
>  
> @@ -456,7 +456,7 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
>  	u32 j, idx;
>  	struct nfs_fh *fh;
>  
> -	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
> +	dprintk("--> %s ino %llu pgbase %u req %zu@%llu\n",
>  		__func__, hdr->inode->i_ino,
>  		hdr->args.pgbase, (size_t)hdr->args.count, offset);
>  
> @@ -514,7 +514,7 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
>  	if (IS_ERR(ds_clnt))
>  		return PNFS_NOT_ATTEMPTED;
>  
> -	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d\n",
> +	dprintk("%s ino %llu sync %d req %zu@%llu DS: %s cl_count %d\n",
>  		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
>  		offset, ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count));
>  
> @@ -1001,7 +1001,7 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
>  	if (IS_ERR(ds_clnt))
>  		goto out_err;
>  
> -	dprintk("%s ino %lu, how %d cl_count %d\n", __func__,
> +	dprintk("%s ino %llu, how %d cl_count %d\n", __func__,
>  		data->inode->i_ino, how, refcount_read(&ds->ds_clp->cl_count));
>  	data->commit_done_cb = filelayout_commit_done_cb;
>  	refcount_inc(&ds->ds_clp->cl_count);
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
> index f67773d52830d2ab4d12dd04caccc2077d4105e0..8b1559171fe3977f1b8461db6266c8c0d6c51ba5 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1631,7 +1631,7 @@ ff_layout_set_layoutcommit(struct inode *inode,
>  		return;
>  
>  	pnfs_set_layoutcommit(inode, lseg, end_offset);
> -	dprintk("%s inode %lu pls_end_pos %llu\n", __func__, inode->i_ino,
> +	dprintk("%s inode %llu pls_end_pos %llu\n", __func__, inode->i_ino,
>  		(unsigned long long) NFS_I(inode)->layout->plh_lwb);
>  }
>  
> @@ -2136,7 +2136,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
>  	u32 dss_id;
>  	bool ds_fatal_error = false;
>  
> -	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
> +	dprintk("--> %s ino %llu pgbase %u req %zu@%llu\n",
>  		__func__, hdr->inode->i_ino,
>  		hdr->args.pgbase, (size_t)hdr->args.count, offset);
>  
> @@ -2245,7 +2245,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
>  
>  	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
>  
> -	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d vers %d\n",
> +	dprintk("%s ino %llu sync %d req %zu@%llu DS: %s cl_count %d vers %d\n",
>  		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
>  		offset, ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count),
>  		vers);
> @@ -2336,7 +2336,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
>  
>  	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
>  
> -	dprintk("%s ino %lu, how %d cl_count %d vers %d\n", __func__,
> +	dprintk("%s ino %llu, how %d cl_count %d vers %d\n", __func__,
>  		data->inode->i_ino, how, refcount_read(&ds->ds_clp->cl_count),
>  		vers);
>  	data->commit_done_cb = ff_layout_commit_done_cb;
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 4786343eeee0f874aa1f31ace2f35fdcb83fc7a6..98a8f0de1199190241dfcb6603fc715540deec11 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2258,7 +2258,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  	bool attr_changed = false;
>  	bool have_delegation;
>  
> -	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%llx)\n",
> +	dfprintk(VFS, "NFS: %s(%s/%llu fh_crc=0x%08x ct=%d info=0x%llx)\n",
>  			__func__, inode->i_sb->s_id, inode->i_ino,
>  			nfs_display_fhandle_hash(NFS_FH(inode)),
>  			icount_read(inode), fattr->valid);
> @@ -2288,7 +2288,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  		/*
>  		* Big trouble! The inode has become a different object.
>  		*/
> -		printk(KERN_DEBUG "NFS: %s: inode %lu mode changed, %07o to %07o\n",
> +		printk(KERN_DEBUG "NFS: %s: inode %llu mode changed, %07o to %07o\n",
>  				__func__, inode->i_ino, inode->i_mode, fattr->mode);
>  		goto out_err;
>  	}
> @@ -2358,7 +2358,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  				if (S_ISDIR(inode->i_mode))
>  					nfs_force_lookup_revalidate(inode);
>  				attr_changed = true;
> -				dprintk("NFS: change_attr change on server for file %s/%ld\n",
> +				dprintk("NFS: change_attr change on server for file %s/%llu\n",
>  						inode->i_sb->s_id,
>  						inode->i_ino);
>  			} else if (!have_delegation) {
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 91bcf67bd743f72a008a9dcde29207bf7a36c407..d839a97df822abb9fb0efd25f3402fcca82d4038 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4714,7 +4714,7 @@ static int _nfs4_proc_lookupp(struct inode *inode,
>  	nfs_fattr_init(fattr);
>  	nfs4_init_sequence(server->nfs_client, &args.seq_args, &res.seq_res, 0, 0);
>  
> -	dprintk("NFS call  lookupp ino=0x%lx\n", inode->i_ino);
> +	dprintk("NFS call  lookupp ino=0x%llx\n", inode->i_ino);
>  	status = nfs4_do_call_sync(clnt, server, &msg, &args.seq_args,
>  				   &res.seq_res, task_flags);
>  	dprintk("NFS reply lookupp: %d\n", status);
> @@ -10019,7 +10019,7 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
>  	int status = 0;
>  
>  	dprintk("NFS: initiating layoutcommit call. sync %d "
> -		"lbw: %llu inode %lu\n", sync,
> +		"lbw: %llu inode %llu\n", sync,
>  		data->args.lastbytewritten,
>  		data->args.inode->i_ino);
>  
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index bc13d1e69449ce9bb3ed3ef0bbff06dfab5c60b5..e79deb9bf664df3424d9c26d3390799969d0499e 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -891,7 +891,7 @@ pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
>  	while (!list_empty(layout_list)) {
>  		lo = list_entry(layout_list->next, struct pnfs_layout_hdr,
>  				plh_bulk_destroy);
> -		dprintk("%s freeing layout for inode %lu\n", __func__,
> +		dprintk("%s freeing layout for inode %llu\n", __func__,
>  			lo->plh_inode->i_ino);
>  		inode = lo->plh_inode;
>  
> @@ -1440,7 +1440,7 @@ _pnfs_return_layout(struct inode *ino)
>  	int status = 0;
>  	bool send, valid_layout;
>  
> -	dprintk("NFS: %s for inode %lu\n", __func__, ino->i_ino);
> +	dprintk("NFS: %s for inode %llu\n", __func__, ino->i_ino);
>  
>  	spin_lock(&ino->i_lock);
>  	lo = nfsi->layout;
> @@ -3055,7 +3055,7 @@ pnfs_try_to_write_data(struct nfs_pgio_header *hdr,
>  
>  	hdr->mds_ops = call_ops;
>  
> -	dprintk("%s: Writing ino:%lu %u@%llu (how %d)\n", __func__,
> +	dprintk("%s: Writing ino:%llu %u@%llu (how %d)\n", __func__,
>  		inode->i_ino, hdr->args.count, hdr->args.offset, how);
>  	trypnfs = nfss->pnfs_curr_ld->write_pagelist(hdr, how);
>  	if (trypnfs != PNFS_NOT_ATTEMPTED)
> @@ -3181,7 +3181,7 @@ pnfs_try_to_read_data(struct nfs_pgio_header *hdr,
>  
>  	hdr->mds_ops = call_ops;
>  
> -	dprintk("%s: Reading ino:%lu %u@%llu\n",
> +	dprintk("%s: Reading ino:%llu %u@%llu\n",
>  		__func__, inode->i_ino, hdr->args.count, hdr->args.offset);
>  
>  	trypnfs = nfss->pnfs_curr_ld->read_pagelist(hdr);
> @@ -3314,7 +3314,7 @@ pnfs_set_layoutcommit(struct inode *inode, struct pnfs_layout_segment *lseg,
>  	if (!test_and_set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags)) {
>  		nfsi->layout->plh_lwb = end_pos;
>  		mark_as_dirty = true;
> -		dprintk("%s: Set layoutcommit for inode %lu ",
> +		dprintk("%s: Set layoutcommit for inode %llu ",
>  			__func__, inode->i_ino);
>  	} else if (end_pos > nfsi->layout->plh_lwb)
>  		nfsi->layout->plh_lwb = end_pos;
> @@ -3363,7 +3363,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
>  	if (!pnfs_layoutcommit_outstanding(inode))
>  		return 0;
>  
> -	dprintk("--> %s inode %lu\n", __func__, inode->i_ino);
> +	dprintk("--> %s inode %llu\n", __func__, inode->i_ino);
>  
>  	status = -EAGAIN;
>  	if (test_and_set_bit(NFS_INO_LAYOUTCOMMITTING, &nfsi->flags)) {
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 8fdbba7cad96443d92cc7fdeea6158c4cc681be1..d2259d948cc33e1c192531d34679123b826cf4dc 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1039,7 +1039,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
>  	}
>  	inode = d_inode(path.dentry);
>  
> -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> +	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%llu)\n",
>  		 name, path.dentry, clp->name,
>  		 inode->i_sb->s_id, inode->i_ino);
>  	exp = exp_parent(cd, clp, &path);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6b9c399b89dfb71a52b9c97f0efe9a1dea0558a6..a569d89ac9123d66bb47e7d74c7c98610de21da2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1253,7 +1253,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
>  	if (ret) {
>  		struct inode *inode = file_inode(f);
>  
> -		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
> +		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%llu: %d\n",
>  					MAJOR(inode->i_sb->s_dev),
>  					MINOR(inode->i_sb->s_dev),
>  					inode->i_ino, ret);
> @@ -2888,7 +2888,7 @@ static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
>  {
>  	struct inode *inode = file_inode(f->nf_file);
>  
> -	seq_printf(s, "superblock: \"%02x:%02x:%ld\"",
> +	seq_printf(s, "superblock: \"%02x:%02x:%llu\"",
>  					MAJOR(inode->i_sb->s_dev),
>  					 MINOR(inode->i_sb->s_dev),
>  					 inode->i_ino);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..ee72c9565e4fe85356674b22b4505d3d531dbe40 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -601,9 +601,9 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
>  	struct inode * inode = d_inode(dentry);
>  	dev_t ex_dev = exp_sb(exp)->s_dev;
>  
> -	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
> +	dprintk("nfsd: fh_compose(exp %02x:%02x/%llu %pd2, ino=%llu)\n",
>  		MAJOR(ex_dev), MINOR(ex_dev),
> -		(long) d_inode(exp->ex_path.dentry)->i_ino,
> +		d_inode(exp->ex_path.dentry)->i_ino,
>  		dentry,
>  		(inode ? inode->i_ino : 0));
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c884c3f34afb044ee5cacc962a04a97de2f7fd88..eafdf7b7890fdee55ddf802d040363f33a7be628 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1163,7 +1163,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	} else if (unlikely(host_err == -EINVAL)) {
>  		struct inode *inode = d_inode(fhp->fh_dentry);
>  
> -		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
> +		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%llu\n",
>  				    inode->i_sb->s_id, inode->i_ino);
>  		host_err = -ESERVERFAULT;
>  	}
> diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
> index e7eebb04f9a4080a39f17d4123e58ed7df6b2f4b..7b1cd2baefcf21e54f9260845b02c7c95c148c64 100644
> --- a/fs/nilfs2/alloc.c
> +++ b/fs/nilfs2/alloc.c
> @@ -707,7 +707,7 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
>  
>  	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
>  		nilfs_warn(inode->i_sb,
> -			   "%s (ino=%lu): entry number %llu already freed",
> +			   "%s (ino=%llu): entry number %llu already freed",
>  			   __func__, inode->i_ino,
>  			   (unsigned long long)req->pr_entry_nr);
>  	else
> @@ -748,7 +748,7 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
>  
>  	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
>  		nilfs_warn(inode->i_sb,
> -			   "%s (ino=%lu): entry number %llu already freed",
> +			   "%s (ino=%llu): entry number %llu already freed",
>  			   __func__, inode->i_ino,
>  			   (unsigned long long)req->pr_entry_nr);
>  	else
> @@ -861,7 +861,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
>  			if (!nilfs_clear_bit_atomic(lock, group_offset,
>  						    bitmap)) {
>  				nilfs_warn(inode->i_sb,
> -					   "%s (ino=%lu): entry number %llu already freed",
> +					   "%s (ino=%llu): entry number %llu already freed",
>  					   __func__, inode->i_ino,
>  					   (unsigned long long)entry_nrs[j]);
>  			} else {
> @@ -906,7 +906,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
>  							      last_nrs[k]);
>  			if (ret && ret != -ENOENT)
>  				nilfs_warn(inode->i_sb,
> -					   "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
> +					   "error %d deleting block that object (entry=%llu, ino=%llu) belongs to",
>  					   ret, (unsigned long long)last_nrs[k],
>  					   inode->i_ino);
>  		}
> @@ -923,7 +923,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
>  			ret = nilfs_palloc_delete_bitmap_block(inode, group);
>  			if (ret && ret != -ENOENT)
>  				nilfs_warn(inode->i_sb,
> -					   "error %d deleting bitmap block of group=%lu, ino=%lu",
> +					   "error %d deleting bitmap block of group=%lu, ino=%llu",
>  					   ret, group, inode->i_ino);
>  		}
>  	}
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index ccc1a7aa52d2064d56b826058554264c498d592f..824f2bd91c167965ec3a660202b6e6c5f1fe007e 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -33,7 +33,7 @@ static int nilfs_bmap_convert_error(struct nilfs_bmap *bmap,
>  
>  	if (err == -EINVAL) {
>  		__nilfs_error(inode->i_sb, fname,
> -			      "broken bmap (inode number=%lu)", inode->i_ino);
> +			      "broken bmap (inode number=%llu)", inode->i_ino);
>  		err = -EIO;
>  	}
>  	return err;
> diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
> index 56836712909201775907483887e8a0022851bbec..2e553d698d0f3980de98fced415dfd819ddbca0a 100644
> --- a/fs/nilfs2/btnode.c
> +++ b/fs/nilfs2/btnode.c
> @@ -64,7 +64,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
>  		 * clearing of an abandoned b-tree node is missing somewhere).
>  		 */
>  		nilfs_error(inode->i_sb,
> -			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%lu)",
> +			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%llu)",
>  			    (unsigned long long)blocknr, inode->i_ino);
>  		goto failed;
>  	}
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index dd0c8e560ef6a2c96515025321914e0d73f41144..3c03f5a741d144d22d1ffb5acf43a035e88c00dc 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -353,7 +353,7 @@ static int nilfs_btree_node_broken(const struct nilfs_btree_node *node,
>  		     nchildren <= 0 ||
>  		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
>  		nilfs_crit(inode->i_sb,
> -			   "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
> +			   "bad btree node (ino=%llu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
>  			   inode->i_ino, (unsigned long long)blocknr, level,
>  			   flags, nchildren);
>  		ret = 1;
> @@ -384,7 +384,7 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
>  		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX ||
>  		     (nchildren == 0 && level > NILFS_BTREE_LEVEL_NODE_MIN))) {
>  		nilfs_crit(inode->i_sb,
> -			   "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
> +			   "bad btree root (ino=%llu): level = %d, flags = 0x%x, nchildren = %d",
>  			   inode->i_ino, level, flags, nchildren);
>  		ret = 1;
>  	}
> @@ -453,7 +453,7 @@ static int nilfs_btree_bad_node(const struct nilfs_bmap *btree,
>  	if (unlikely(nilfs_btree_node_get_level(node) != level)) {
>  		dump_stack();
>  		nilfs_crit(btree->b_inode->i_sb,
> -			   "btree level mismatch (ino=%lu): %d != %d",
> +			   "btree level mismatch (ino=%llu): %d != %d",
>  			   btree->b_inode->i_ino,
>  			   nilfs_btree_node_get_level(node), level);
>  		return 1;
> @@ -521,7 +521,7 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
>   out_no_wait:
>  	if (!buffer_uptodate(bh)) {
>  		nilfs_err(btree->b_inode->i_sb,
> -			  "I/O error reading b-tree node block (ino=%lu, blocknr=%llu)",
> +			  "I/O error reading b-tree node block (ino=%llu, blocknr=%llu)",
>  			  btree->b_inode->i_ino, (unsigned long long)ptr);
>  		brelse(bh);
>  		return -EIO;
> @@ -2104,7 +2104,7 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
>  	if (ret < 0) {
>  		if (unlikely(ret == -ENOENT)) {
>  			nilfs_crit(btree->b_inode->i_sb,
> -				   "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
> +				   "writing node/leaf block does not appear in b-tree (ino=%llu) at key=%llu, level=%d",
>  				   btree->b_inode->i_ino,
>  				   (unsigned long long)key, level);
>  			ret = -EINVAL;
> @@ -2146,7 +2146,7 @@ static void nilfs_btree_add_dirty_buffer(struct nilfs_bmap *btree,
>  	    level >= NILFS_BTREE_LEVEL_MAX) {
>  		dump_stack();
>  		nilfs_warn(btree->b_inode->i_sb,
> -			   "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
> +			   "invalid btree level: %d (key=%llu, ino=%llu, blocknr=%llu)",
>  			   level, (unsigned long long)key,
>  			   btree->b_inode->i_ino,
>  			   (unsigned long long)bh->b_blocknr);
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index b243199036dfa1ab2299efaaa5bdf5da2d159ff2..3653db5cdb65137d1e660bb509c14ec4cbc8840b 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -150,7 +150,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
>  
>  Ebadsize:
>  	nilfs_error(sb,
> -		    "size of directory #%lu is not a multiple of chunk size",
> +		    "size of directory #%llu is not a multiple of chunk size",
>  		    dir->i_ino);
>  	goto fail;
>  Eshort:
> @@ -169,7 +169,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
>  	error = "disallowed inode number";
>  bad_entry:
>  	nilfs_error(sb,
> -		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
> +		    "bad entry in directory #%llu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
>  		    dir->i_ino, error, (folio->index << PAGE_SHIFT) + offs,
>  		    (unsigned long)le64_to_cpu(p->inode),
>  		    rec_len, p->name_len);
> @@ -177,7 +177,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
>  Eend:
>  	p = (struct nilfs_dir_entry *)(kaddr + offs);
>  	nilfs_error(sb,
> -		    "entry in directory #%lu spans the page boundary offset=%lu, inode=%lu",
> +		    "entry in directory #%llu spans the page boundary offset=%lu, inode=%lu",
>  		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
>  		    (unsigned long)le64_to_cpu(p->inode));
>  fail:
> @@ -251,7 +251,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
>  
>  		kaddr = nilfs_get_folio(inode, n, &folio);
>  		if (IS_ERR(kaddr)) {
> -			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
> +			nilfs_error(sb, "bad page in #%llu", inode->i_ino);
>  			ctx->pos += PAGE_SIZE - offset;
>  			return -EIO;
>  		}
> @@ -336,7 +336,7 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
>  		/* next folio is past the blocks we've got */
>  		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
>  			nilfs_error(dir->i_sb,
> -			       "dir %lu size %lld exceeds block count %llu",
> +			       "dir %llu size %lld exceeds block count %llu",
>  			       dir->i_ino, dir->i_size,
>  			       (unsigned long long)dir->i_blocks);
>  			goto out;
> @@ -382,7 +382,7 @@ struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct folio **foliop)
>  	return next_de;
>  
>  fail:
> -	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
> +	nilfs_error(dir->i_sb, "directory #%llu %s", dir->i_ino, msg);
>  	folio_release_kmap(folio, de);
>  	return NULL;
>  }
> diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
> index 2d8dc6b35b5477947ca12a70288d3a3cce858aab..8bd0b1374e25f8ff510f3b36dbde2acc01aafc1e 100644
> --- a/fs/nilfs2/direct.c
> +++ b/fs/nilfs2/direct.c
> @@ -338,7 +338,7 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
>  	key = nilfs_bmap_data_get_key(bmap, *bh);
>  	if (unlikely(key > NILFS_DIRECT_KEY_MAX)) {
>  		nilfs_crit(bmap->b_inode->i_sb,
> -			   "%s (ino=%lu): invalid key: %llu",
> +			   "%s (ino=%llu): invalid key: %llu",
>  			   __func__,
>  			   bmap->b_inode->i_ino, (unsigned long long)key);
>  		return -EINVAL;
> @@ -346,7 +346,7 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
>  	ptr = nilfs_direct_get_ptr(bmap, key);
>  	if (unlikely(ptr == NILFS_BMAP_INVALID_PTR)) {
>  		nilfs_crit(bmap->b_inode->i_sb,
> -			   "%s (ino=%lu): invalid pointer: %llu",
> +			   "%s (ino=%llu): invalid pointer: %llu",
>  			   __func__,
>  			   bmap->b_inode->i_ino, (unsigned long long)ptr);
>  		return -EINVAL;
> diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> index 561c220799c7aee879ad866865e377799c8ee6bb..62d4c1b787e95c961a360a4214d621d564ad8b4c 100644
> --- a/fs/nilfs2/gcinode.c
> +++ b/fs/nilfs2/gcinode.c
> @@ -137,7 +137,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer_head *bh)
>  		struct inode *inode = bh->b_folio->mapping->host;
>  
>  		nilfs_err(inode->i_sb,
> -			  "I/O error reading %s block for GC (ino=%lu, vblocknr=%llu)",
> +			  "I/O error reading %s block for GC (ino=%llu, vblocknr=%llu)",
>  			  buffer_nilfs_node(bh) ? "node" : "data",
>  			  inode->i_ino, (unsigned long long)bh->b_blocknr);
>  		return -EIO;
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 51bde45d586509dda3ef0cb7c46facb7fb2c61dd..51f7e125a311b868860e3e111700d49d4cb98fa6 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -108,7 +108,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
>  				 * be locked in this case.
>  				 */
>  				nilfs_warn(inode->i_sb,
> -					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
> +					   "%s (ino=%llu): a race condition while inserting a data block at offset=%llu",
>  					   __func__, inode->i_ino,
>  					   (unsigned long long)blkoff);
>  				err = -EAGAIN;
> @@ -789,7 +789,7 @@ static void nilfs_truncate_bmap(struct nilfs_inode_info *ii,
>  		goto repeat;
>  
>  failed:
> -	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=%lu)",
> +	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=%llu)",
>  		   ret, ii->vfs_inode.i_ino);
>  }
>  
> @@ -1026,7 +1026,7 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
>  			 * this inode.
>  			 */
>  			nilfs_warn(inode->i_sb,
> -				   "cannot set file dirty (ino=%lu): the file is being freed",
> +				   "cannot set file dirty (ino=%llu): the file is being freed",
>  				   inode->i_ino);
>  			spin_unlock(&nilfs->ns_inode_lock);
>  			return -EINVAL; /*
> @@ -1057,7 +1057,7 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
>  	err = nilfs_load_inode_block(inode, &ibh);
>  	if (unlikely(err)) {
>  		nilfs_warn(inode->i_sb,
> -			   "cannot mark inode dirty (ino=%lu): error %d loading inode block",
> +			   "cannot mark inode dirty (ino=%llu): error %d loading inode block",
>  			   inode->i_ino, err);
>  		return err;
>  	}
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index 946b0d3534a5f22f34ac44a91fb121541881c548..09adb40c65e505d92012a3d2f5fe8a5696e10056 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -203,7 +203,7 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
>  	err = -EIO;
>  	if (!buffer_uptodate(first_bh)) {
>  		nilfs_err(inode->i_sb,
> -			  "I/O error reading meta-data file (ino=%lu, block-offset=%lu)",
> +			  "I/O error reading meta-data file (ino=%llu, block-offset=%lu)",
>  			  inode->i_ino, block);
>  		goto failed_bh;
>  	}
> diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
> index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..40ac679ec56e400b1df98e9be6fe9ca338a9ba51 100644
> --- a/fs/nilfs2/namei.c
> +++ b/fs/nilfs2/namei.c
> @@ -292,7 +292,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
>  
>  	if (!inode->i_nlink) {
>  		nilfs_warn(inode->i_sb,
> -			   "deleting nonexistent file (ino=%lu), %d",
> +			   "deleting nonexistent file (ino=%llu), %d",
>  			   inode->i_ino, inode->i_nlink);
>  		set_nlink(inode, 1);
>  	}
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 098a3bd103e04cd09b0689fe2017380d74664496..4b1bf559f3524b1cc3965dae9fd3e5745718569d 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2024,7 +2024,7 @@ static int nilfs_segctor_collect_dirty_files(struct nilfs_sc_info *sci,
>  				ifile, ii->vfs_inode.i_ino, &ibh);
>  			if (unlikely(err)) {
>  				nilfs_warn(sci->sc_super,
> -					   "log writer: error %d getting inode block (ino=%lu)",
> +					   "log writer: error %d getting inode block (ino=%llu)",
>  					   err, ii->vfs_inode.i_ino);
>  				return err;
>  			}
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 9cc7eb863643774b83da8b6228c38db16d0dbed1..0f731eddeb8be74113361f45aa4fca2943395e9d 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -84,7 +84,7 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
>  	inode_mark = container_of(mark, struct inotify_inode_mark, fsn_mark);
>  	inode = igrab(fsnotify_conn_inode(mark->connector));
>  	if (inode) {
> -		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:0 ",
> +		seq_printf(m, "inotify wd:%x ino:%llx sdev:%x mask:%x ignored_mask:0 ",
>  			   inode_mark->wd, inode->i_ino, inode->i_sb->s_dev,
>  			   inotify_mark_user_mask(mark));
>  		show_mark_fhandle(m, inode);
> @@ -111,7 +111,7 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
>  		inode = igrab(fsnotify_conn_inode(mark->connector));
>  		if (!inode)
>  			return;
> -		seq_printf(m, "fanotify ino:%lx sdev:%x mflags:%x mask:%x ignored_mask:%x ",
> +		seq_printf(m, "fanotify ino:%llx sdev:%x mflags:%x mask:%x ignored_mask:%x ",
>  			   inode->i_ino, inode->i_sb->s_dev,
>  			   mflags, mark->mask, mark->ignore_mask);
>  		show_mark_fhandle(m, inode);
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index db91de2086456bb9fe0547be7dbbd2de87c97ca7..eac326b85314ac8080248347154d599c953969c7 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -46,7 +46,7 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
>  	struct ns_common *ns = inode->i_private;
>  	const struct proc_ns_operations *ns_ops = ns->ops;
>  
> -	return dynamic_dname(buffer, buflen, "%s:[%lu]",
> +	return dynamic_dname(buffer, buflen, "%s:[%llu]",
>  		ns_ops->name, inode->i_ino);
>  }
>  
> @@ -394,7 +394,7 @@ static int nsfs_show_path(struct seq_file *seq, struct dentry *dentry)
>  	const struct ns_common *ns = inode->i_private;
>  	const struct proc_ns_operations *ns_ops = ns->ops;
>  
> -	seq_printf(seq, "%s:[%lu]", ns_ops->name, inode->i_ino);
> +	seq_printf(seq, "%s:[%llu]", ns_ops->name, inode->i_ino);
>  	return 0;
>  }
>  
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 174a7cb202a08c550b3b8497cdf6105192be2e43..51aa008e126a8af18c39dd825a17c12df859329d 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -153,7 +153,7 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
>  	vaf.fmt = printk_skip_level(fmt);
>  	vaf.va = &args;
>  
> -	printk("%c%cntfs3(%s): ino=%lx,%s %pV\n", KERN_SOH_ASCII, level,
> +	printk("%c%cntfs3(%s): ino=%llx,%s %pV\n", KERN_SOH_ASCII, level,
>  	       sb->s_id, inode->i_ino, name ? name : "", &vaf);
>  
>  	va_end(args);
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 344fd4d95fbc8bd7a749e9d51d31b5682ff030d0..d40f5d205bce3675ffd37e0e6c228e88c1804a1a 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -7318,7 +7318,7 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
>  		 * to check it up here before changing the tree.
>  		*/
>  		if (root_el->l_tree_depth && rec->e_int_clusters == 0) {
> -			mlog(ML_ERROR, "Inode %lu has an empty "
> +			mlog(ML_ERROR, "Inode %llu has an empty "
>  				    "extent record, depth %u\n", inode->i_ino,
>  				    le16_to_cpu(root_el->l_tree_depth));
>  			status = ocfs2_remove_rightmost_empty_extent(osb,
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 17ba79f443ee736cb5225702c57d13f4019f3c52..c7ad912ec7a0d6fffd09c3d38f110e5d1517d829 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -137,7 +137,7 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
>  			      (unsigned long long)iblock, bh_result, create);
>  
>  	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE)
> -		mlog(ML_NOTICE, "get_block on system inode 0x%p (%lu)\n",
> +		mlog(ML_NOTICE, "get_block on system inode 0x%p (%llu)\n",
>  		     inode, inode->i_ino);
>  
>  	if (S_ISLNK(inode->i_mode)) {
> @@ -2146,7 +2146,7 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
>  	    ((iblock + ((len - 1) >> i_blkbits)) > endblk))
>  		len = (endblk - iblock + 1) << i_blkbits;
>  
> -	mlog(0, "get block of %lu at %llu:%u req %u\n",
> +	mlog(0, "get block of %llu at %llu:%u req %u\n",
>  			inode->i_ino, pos, len, total_len);
>  
>  	/*
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index 1c8abf2c592caacbe734d49254b04d507925c9d1..b82fe4431eb1f0811d81525237d02c5a3f3b021c 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -794,7 +794,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  	if (le16_to_cpu(el->l_count) !=
>  	    ocfs2_extent_recs_per_dx_root(inode->i_sb)) {
>  		ret = ocfs2_error(inode->i_sb,
> -				  "Inode %lu has invalid extent list length %u\n",
> +				  "Inode %llu has invalid extent list length %u\n",
>  				  inode->i_ino, le16_to_cpu(el->l_count));
>  		goto out;
>  	}
> @@ -812,7 +812,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ret = ocfs2_error(inode->i_sb,
> -					  "Inode %lu has non zero tree depth in btree tree block %llu\n",
> +					  "Inode %llu has non zero tree depth in btree tree block %llu\n",
>  					  inode->i_ino,
>  					  (unsigned long long)eb_bh->b_blocknr);
>  			goto out;
> @@ -821,7 +821,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  
>  	if (le16_to_cpu(el->l_next_free_rec) == 0) {
>  		ret = ocfs2_error(inode->i_sb,
> -				  "Inode %lu has empty extent list at depth %u\n",
> +				  "Inode %llu has empty extent list at depth %u\n",
>  				  inode->i_ino,
>  				  le16_to_cpu(el->l_tree_depth));
>  		goto out;
> @@ -839,7 +839,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  
>  	if (!found) {
>  		ret = ocfs2_error(inode->i_sb,
> -				  "Inode %lu has bad extent record (%u, %u, 0) in btree\n",
> +				  "Inode %llu has bad extent record (%u, %u, 0) in btree\n",
>  				  inode->i_ino,
>  				  le32_to_cpu(rec->e_cpos),
>  				  ocfs2_rec_clusters(el, rec));
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 45cce261da65cab7ef48b5b88c0de5d41fa57615..5821e33df78fd92fabc7fe7fa1c3b3c62c50f9f8 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -123,7 +123,7 @@ static int dlmfs_file_open(struct inode *inode,
>  	if (S_ISDIR(inode->i_mode))
>  		BUG();
>  
> -	mlog(0, "open called on inode %lu, flags 0x%x\n", inode->i_ino,
> +	mlog(0, "open called on inode %llu, flags 0x%x\n", inode->i_ino,
>  		file->f_flags);
>  
>  	status = dlmfs_decode_open_flags(file->f_flags, &level, &flags);
> @@ -170,7 +170,7 @@ static int dlmfs_file_release(struct inode *inode,
>  	if (S_ISDIR(inode->i_mode))
>  		BUG();
>  
> -	mlog(0, "close called on inode %lu\n", inode->i_ino);
> +	mlog(0, "close called on inode %llu\n", inode->i_ino);
>  
>  	if (fp) {
>  		level = fp->fp_lock_level;
> @@ -242,7 +242,7 @@ static ssize_t dlmfs_file_write(struct file *filp,
>  	int bytes_left;
>  	struct inode *inode = file_inode(filp);
>  
> -	mlog(0, "inode %lu, count = %zu, *ppos = %llu\n",
> +	mlog(0, "inode %llu, count = %zu, *ppos = %llu\n",
>  		inode->i_ino, count, *ppos);
>  
>  	if (*ppos >= DLM_LVB_LEN)
> @@ -301,7 +301,7 @@ static void dlmfs_evict_inode(struct inode *inode)
>  
>  	clear_inode(inode);
>  
> -	mlog(0, "inode %lu\n", inode->i_ino);
> +	mlog(0, "inode %llu\n", inode->i_ino);
>  
>  	ip = DLMFS_I(inode);
>  	lockres = &ip->ip_lockres;
> @@ -490,7 +490,7 @@ static int dlmfs_unlink(struct inode *dir,
>  	int status;
>  	struct inode *inode = d_inode(dentry);
>  
> -	mlog(0, "unlink inode %lu\n", inode->i_ino);
> +	mlog(0, "unlink inode %llu\n", inode->i_ino);
>  
>  	/* if there are no current holders, or none that are waiting
>  	 * to acquire a lock, this basically destroys our lockres. */
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index d68229422dda3423971d7ab0e9a4335acab8b344..eb5dcd17d43752c08eab423fd667b7c0363ba6a1 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -291,7 +291,7 @@ static int ocfs2_last_eb_is_empty(struct inode *inode,
>  
>  	if (el->l_tree_depth) {
>  		ocfs2_error(inode->i_sb,
> -			    "Inode %lu has non zero tree depth in leaf block %llu\n",
> +			    "Inode %llu has non zero tree depth in leaf block %llu\n",
>  			    inode->i_ino,
>  			    (unsigned long long)eb_bh->b_blocknr);
>  		ret = -EROFS;
> @@ -427,7 +427,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ocfs2_error(inode->i_sb,
> -				    "Inode %lu has non zero tree depth in leaf block %llu\n",
> +				    "Inode %llu has non zero tree depth in leaf block %llu\n",
>  				    inode->i_ino,
>  				    (unsigned long long)eb_bh->b_blocknr);
>  			ret = -EROFS;
> @@ -437,7 +437,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  
>  	if (le16_to_cpu(el->l_next_free_rec) > le16_to_cpu(el->l_count)) {
>  		ocfs2_error(inode->i_sb,
> -			    "Inode %lu has an invalid extent (next_free_rec %u, count %u)\n",
> +			    "Inode %llu has an invalid extent (next_free_rec %u, count %u)\n",
>  			    inode->i_ino,
>  			    le16_to_cpu(el->l_next_free_rec),
>  			    le16_to_cpu(el->l_count));
> @@ -472,7 +472,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  
>  	if (!rec->e_blkno) {
>  		ocfs2_error(inode->i_sb,
> -			    "Inode %lu has bad extent record (%u, %u, 0)\n",
> +			    "Inode %llu has bad extent record (%u, %u, 0)\n",
>  			    inode->i_ino,
>  			    le32_to_cpu(rec->e_cpos),
>  			    ocfs2_rec_clusters(el, rec));
> @@ -561,7 +561,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
>  
>  		if (el->l_tree_depth) {
>  			ocfs2_error(inode->i_sb,
> -				    "Inode %lu has non zero tree depth in xattr leaf block %llu\n",
> +				    "Inode %llu has non zero tree depth in xattr leaf block %llu\n",
>  				    inode->i_ino,
>  				    (unsigned long long)eb_bh->b_blocknr);
>  			ret = -EROFS;
> @@ -580,7 +580,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
>  
>  		if (!rec->e_blkno) {
>  			ocfs2_error(inode->i_sb,
> -				    "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
> +				    "Inode %llu has bad extent record (%u, %u, 0) in xattr\n",
>  				    inode->i_ino,
>  				    le32_to_cpu(rec->e_cpos),
>  				    ocfs2_rec_clusters(el, rec));
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 03a51662ea8e79f7a64fcd320b974f954b2ea8bf..26025ba2656c66b61866deaff60a0da204745c4f 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1196,7 +1196,7 @@ static void ocfs2_clear_inode(struct inode *inode)
>  				inode->i_nlink);
>  
>  	mlog_bug_on_msg(osb == NULL,
> -			"Inode=%lu\n", inode->i_ino);
> +			"Inode=%llu\n", inode->i_ino);
>  
>  	dquot_drop(inode);
>  
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index c4e0117d8977807dd6f0f4df64e1ddf72a62ea09..269b0f27d5679aba317059b245ee4bf4f5580eca 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -471,7 +471,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
>  	qsize_t spacechange, inodechange;
>  	unsigned int memalloc;
>  
> -	trace_ocfs2_recover_local_quota_file((unsigned long)lqinode->i_ino, type);
> +	trace_ocfs2_recover_local_quota_file(lqinode->i_ino, type);
>  
>  	list_for_each_entry_safe(rchunk, next, &(rec->r_list[type]), rc_list) {
>  		chunk = rchunk->rc_chunk;
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index c1cdececdfa4ef51a1bd3a5addad734b324b92c0..6d7f44d3e929d94f3ba6121cc30a867887e0bbe3 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -2341,7 +2341,7 @@ static int ocfs2_mark_extent_refcounted(struct inode *inode,
>  					   cpos, len, phys);
>  
>  	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
> -		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
> +		ret = ocfs2_error(inode->i_sb, "Inode %llu want to use refcount tree, but the feature bit is not set in the super block\n",
>  				  inode->i_ino);
>  		goto out;
>  	}
> @@ -2524,7 +2524,7 @@ int ocfs2_prepare_refcount_change_for_del(struct inode *inode,
>  	u64 start_cpos = ocfs2_blocks_to_clusters(inode->i_sb, phys_blkno);
>  
>  	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
> -		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
> +		ret = ocfs2_error(inode->i_sb, "Inode %llu want to use refcount tree, but the feature bit is not set in the super block\n",
>  				  inode->i_ino);
>  		goto out;
>  	}
> @@ -2650,7 +2650,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ret = ocfs2_error(inode->i_sb,
> -					  "Inode %lu has non zero tree depth in leaf block %llu\n",
> +					  "Inode %llu has non zero tree depth in leaf block %llu\n",
>  					  inode->i_ino,
>  					  (unsigned long long)eb_bh->b_blocknr);
>  			goto out;
> @@ -2662,7 +2662,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
>  		rec = &el->l_recs[i];
>  
>  		if (ocfs2_is_empty_extent(rec)) {
> -			mlog_bug_on_msg(i != 0, "Inode %lu has empty record in "
> +			mlog_bug_on_msg(i != 0, "Inode %llu has empty record in "
>  					"index %d\n", inode->i_ino, i);
>  			continue;
>  		}
> @@ -3325,7 +3325,7 @@ static int ocfs2_replace_cow(struct ocfs2_cow_context *context)
>  	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>  
>  	if (!ocfs2_refcount_tree(osb)) {
> -		return ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
> +		return ocfs2_error(inode->i_sb, "Inode %llu want to use refcount tree, but the feature bit is not set in the super block\n",
>  				   inode->i_ino);
>  	}
>  
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 42ee5db362d3eb6df886d6721dd7398b8aca8cdb..4d55ad963ac514b4b4081447af0992345facd83a 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -3741,7 +3741,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ret = ocfs2_error(inode->i_sb,
> -					  "Inode %lu has non zero tree depth in xattr tree block %llu\n",
> +					  "Inode %llu has non zero tree depth in xattr tree block %llu\n",
>  					  inode->i_ino,
>  					  (unsigned long long)eb_bh->b_blocknr);
>  			goto out;
> @@ -3758,7 +3758,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
>  	}
>  
>  	if (!e_blkno) {
> -		ret = ocfs2_error(inode->i_sb, "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
> +		ret = ocfs2_error(inode->i_sb, "Inode %llu has bad extent record (%u, %u, 0) in xattr\n",
>  				  inode->i_ino,
>  				  le32_to_cpu(rec->e_cpos),
>  				  ocfs2_rec_clusters(el, rec));
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 2d4710d0e05e195855186c6bedd211bc419abc36..9e8a2a9e5229861a4976d67483a0f6452048f86b 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -1062,7 +1062,7 @@ struct inode *orangefs_iget(struct super_block *sb,
>  	unlock_new_inode(inode);
>  
>  	gossip_debug(GOSSIP_INODE_DEBUG,
> -		     "iget handle %pU, fsid %d hash %ld i_ino %lu\n",
> +		     "iget handle %pU, fsid %d hash %ld i_ino %llu\n",
>  		     &ref->khandle,
>  		     ref->fs_id,
>  		     hash,
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..0a35d1a20f13fbab5bbee5f271d41f52334a9a6a 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -262,7 +262,7 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct inode *inode,
>  	return err;
>  
>  fail:
> -	pr_warn_ratelimited("failed to encode file handle (ino=%lu, err=%i)\n",
> +	pr_warn_ratelimited("failed to encode file handle (ino=%llu, err=%i)\n",
>  			    inode->i_ino, err);
>  	goto out;
>  }
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index d8dd4b0529843bc20e4efc1924c2be3b5712b343..ca899fdfaafd21f4bb31807e73883b4978116732 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -591,7 +591,7 @@ int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
>  
>  fail:
>  	inode = d_inode(real);
> -	pr_warn_ratelimited("failed to verify %s (%pd2, ino=%lu, err=%i)\n",
> +	pr_warn_ratelimited("failed to verify %s (%pd2, ino=%llu, err=%i)\n",
>  			    is_upper ? "upper" : "origin", real,
>  			    inode ? inode->i_ino : 0, err);
>  	goto out;
> @@ -831,7 +831,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
>  			index = NULL;
>  			goto out;
>  		}
> -		pr_warn_ratelimited("failed inode index lookup (ino=%lu, key=%.*s, err=%i);\n"
> +		pr_warn_ratelimited("failed inode index lookup (ino=%llu, key=%.*s, err=%i);\n"
>  				    "overlayfs: mount with '-o index=off' to disable inodes index.\n",
>  				    d_inode(origin)->i_ino, name.len, name.name,
>  				    err);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 3f1b763a8bb4cb842e5d5cebffbee6b8dbe01de9..2edad9a146486bda5edf47dc60e1645d49af6539 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1092,7 +1092,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
>  	got_write = true;
>  	inode = d_inode(upperdentry);
>  	if (!S_ISDIR(inode->i_mode) && inode->i_nlink != 1) {
> -		pr_warn_ratelimited("cleanup linked index (%pd2, ino=%lu, nlink=%u)\n",
> +		pr_warn_ratelimited("cleanup linked index (%pd2, ino=%llu, nlink=%u)\n",
>  				    upperdentry, inode->i_ino, inode->i_nlink);
>  		/*
>  		 * We either have a bug with persistent union nlink or a lower
> diff --git a/fs/pipe.c b/fs/pipe.c
> index b44a756c0b4165edc2801b2290bf35480245d7a6..9841648c9cf3e8e569cf6ba5c792624fe92396f5 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -873,7 +873,7 @@ static struct vfsmount *pipe_mnt __ro_after_init;
>   */
>  static char *pipefs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> -	return dynamic_dname(buffer, buflen, "pipe:[%lu]",
> +	return dynamic_dname(buffer, buflen, "pipe:[%llu]",
>  				d_inode(dentry)->i_ino);
>  }
>  
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 9eeccff49b2abf57d766ce17fe47070c379ed2c8..aae1a83e884686471758703634f0d3479e77c9a7 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -54,7 +54,7 @@ static int seq_show(struct seq_file *m, void *v)
>  	if (ret)
>  		return ret;
>  
> -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
> +	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%llu\n",
>  		   (long long)file->f_pos, f_flags,
>  		   real_mount(file->f_path.mnt)->mnt_id,
>  		   file_inode(file)->i_ino);
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e091931d7ca19d71f31699913d177eec0821ca7b..751b9ba160fbf15499555875871d727644b0df44 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -442,7 +442,7 @@ static void get_vma_name(struct vm_area_struct *vma,
>  static void show_vma_header_prefix(struct seq_file *m,
>  				   unsigned long start, unsigned long end,
>  				   vm_flags_t flags, unsigned long long pgoff,
> -				   dev_t dev, unsigned long ino)
> +				   dev_t dev, u64 ino)
>  {
>  	seq_setwidth(m, 25 + sizeof(void *) * 6 - 1);
>  	seq_put_hex_ll(m, NULL, start, 8);
> @@ -465,7 +465,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
>  	const struct path *path;
>  	const char *name_fmt, *name;
>  	vm_flags_t flags = vma->vm_flags;
> -	unsigned long ino = 0;
> +	u64 ino = 0;
>  	unsigned long long pgoff = 0;
>  	unsigned long start, end;
>  	dev_t dev = 0;
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 8aeb63d397cfd6c87b7862f0dc7a34cdfdf02f9b..4deb0eeadbdef3a580d57fbe4e8518da0f550cb7 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -62,7 +62,7 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
>  {
>  	unsigned long phys;
>  
> -	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%ld] iblock=[%ld]\n",inode->i_ino,iblock));
> +	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%llu] iblock=[%ld]\n", inode->i_ino, iblock));
>  
>  	phys = qnx4_block_map( inode, iblock );
>  	if ( phys ) {
> @@ -128,7 +128,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
>  			brelse( bh );
>  	}
>  
> -	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));
> +	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %llu = %ld\n", iblock, inode->i_ino, block));
>  	return block;
>  }
>  
> diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> index c4049bb8bd60d47f9edd3d724a5d5be6b5deb5ee..6de49333acadbf08a8ce20d86e566433bc911f7d 100644
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c
> @@ -75,7 +75,7 @@ static int qnx6_get_block(struct inode *inode, sector_t iblock,
>  {
>  	unsigned phys;
>  
> -	pr_debug("qnx6_get_block inode=[%ld] iblock=[%ld]\n",
> +	pr_debug("qnx6_get_block inode=[%llu] iblock=[%ld]\n",
>  		 inode->i_ino, (unsigned long)iblock);
>  
>  	phys = qnx6_block_map(inode, iblock);
> diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> index 160c16aa7b6e7088355582670357262ab3930225..5794de5a9069f20302b6630c39c1452183137acc 100644
> --- a/fs/ubifs/debug.c
> +++ b/fs/ubifs/debug.c
> @@ -230,7 +230,7 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
>  	int count = 2;
>  
>  	pr_err("Dump in-memory inode:");
> -	pr_err("\tinode          %lu\n", inode->i_ino);
> +	pr_err("\tinode          %llu\n", inode->i_ino);
>  	pr_err("\tsize           %llu\n",
>  	       (unsigned long long)i_size_read(inode));
>  	pr_err("\tnlink          %u\n", inode->i_nlink);
> @@ -1101,7 +1101,7 @@ int dbg_check_synced_i_size(const struct ubifs_info *c, struct inode *inode)
>  	if (ui->ui_size != ui->synced_i_size && !ui->dirty) {
>  		ubifs_err(c, "ui_size is %lld, synced_i_size is %lld, but inode is clean",
>  			  ui->ui_size, ui->synced_i_size);
> -		ubifs_err(c, "i_ino %lu, i_mode %#x, i_size %lld", inode->i_ino,
> +		ubifs_err(c, "i_ino %llu, i_mode %#x, i_size %lld", inode->i_ino,
>  			  inode->i_mode, i_size_read(inode));
>  		dump_stack();
>  		err = -EINVAL;
> @@ -1163,7 +1163,7 @@ int dbg_check_dir(struct ubifs_info *c, const struct inode *dir)
>  	kfree(pdent);
>  
>  	if (i_size_read(dir) != size) {
> -		ubifs_err(c, "directory inode %lu has size %llu, but calculated size is %llu",
> +		ubifs_err(c, "directory inode %llu has size %llu, but calculated size is %llu",
>  			  dir->i_ino, (unsigned long long)i_size_read(dir),
>  			  (unsigned long long)size);
>  		ubifs_dump_inode(c, dir);
> @@ -1171,7 +1171,7 @@ int dbg_check_dir(struct ubifs_info *c, const struct inode *dir)
>  		return -EINVAL;
>  	}
>  	if (dir->i_nlink != nlink) {
> -		ubifs_err(c, "directory inode %lu has nlink %u, but calculated nlink is %u",
> +		ubifs_err(c, "directory inode %llu has nlink %u, but calculated nlink is %u",
>  			  dir->i_ino, dir->i_nlink, nlink);
>  		ubifs_dump_inode(c, dir);
>  		dump_stack();
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 4c9f57f3b2adbbd396b288878cb18fa87cdbd0df..86d41e077e4d621dbb8c448acd0065c8ac7ae225 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -223,7 +223,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
>  	struct ubifs_info *c = dir->i_sb->s_fs_info;
>  	struct fscrypt_name nm;
>  
> -	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
> +	dbg_gen("'%pd' in dir ino %llu", dentry, dir->i_ino);
>  
>  	err = fscrypt_prepare_lookup(dir, dentry, &nm);
>  	if (err == -ENOENT)
> @@ -281,7 +281,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
>  	if (IS_ENCRYPTED(dir) &&
>  	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
>  	    !fscrypt_has_permitted_context(dir, inode)) {
> -		ubifs_warn(c, "Inconsistent encryption contexts: %lu/%lu",
> +		ubifs_warn(c, "Inconsistent encryption contexts: %llu/%llu",
>  			   dir->i_ino, inode->i_ino);
>  		iput(inode);
>  		inode = ERR_PTR(-EPERM);
> @@ -318,7 +318,7 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	 * parent directory inode.
>  	 */
>  
> -	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
> +	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
>  		dentry, mode, dir->i_ino);
>  
>  	err = ubifs_budget_space(c, &req);
> @@ -386,7 +386,7 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
>  	 * atomically.
>  	 */
>  
> -	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
> +	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
>  		dentry, mode, dir->i_ino);
>  
>  	inode = ubifs_new_inode(c, dir, mode, false);
> @@ -460,7 +460,7 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  	 * be released via writeback.
>  	 */
>  
> -	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
> +	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
>  		dentry, mode, dir->i_ino);
>  
>  	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
> @@ -589,7 +589,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  	bool encrypted = IS_ENCRYPTED(dir);
>  	struct ubifs_dir_data *data = file->private_data;
>  
> -	dbg_gen("dir ino %lu, f_pos %#llx", dir->i_ino, ctx->pos);
> +	dbg_gen("dir ino %llu, f_pos %#llx", dir->i_ino, ctx->pos);
>  
>  	if (ctx->pos > UBIFS_S_KEY_HASH_MASK || ctx->pos == 2)
>  		/*
> @@ -764,7 +764,7 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
>  	 * changing the parent inode.
>  	 */
>  
> -	dbg_gen("dent '%pd' to ino %lu (nlink %d) in dir ino %lu",
> +	dbg_gen("dent '%pd' to ino %llu (nlink %d) in dir ino %llu",
>  		dentry, inode->i_ino,
>  		inode->i_nlink, dir->i_ino);
>  	ubifs_assert(c, inode_is_locked(dir));
> @@ -836,7 +836,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
>  	 * deletions.
>  	 */
>  
> -	dbg_gen("dent '%pd' from ino %lu (nlink %d) in dir ino %lu",
> +	dbg_gen("dent '%pd' from ino %llu (nlink %d) in dir ino %llu",
>  		dentry, inode->i_ino,
>  		inode->i_nlink, dir->i_ino);
>  
> @@ -941,7 +941,7 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
>  	 * because we have extra space reserved for deletions.
>  	 */
>  
> -	dbg_gen("directory '%pd', ino %lu in dir ino %lu", dentry,
> +	dbg_gen("directory '%pd', ino %llu in dir ino %llu", dentry,
>  		inode->i_ino, dir->i_ino);
>  	ubifs_assert(c, inode_is_locked(dir));
>  	ubifs_assert(c, inode_is_locked(inode));
> @@ -1018,7 +1018,7 @@ static struct dentry *ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	 * directory inode.
>  	 */
>  
> -	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
> +	dbg_gen("dent '%pd', mode %#hx in dir ino %llu",
>  		dentry, mode, dir->i_ino);
>  
>  	err = ubifs_budget_space(c, &req);
> @@ -1096,7 +1096,7 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	 * directory inode.
>  	 */
>  
> -	dbg_gen("dent '%pd' in dir ino %lu", dentry, dir->i_ino);
> +	dbg_gen("dent '%pd' in dir ino %llu", dentry, dir->i_ino);
>  
>  	if (S_ISBLK(mode) || S_ISCHR(mode)) {
>  		dev = kmalloc_obj(union ubifs_dev_desc, GFP_NOFS);
> @@ -1183,7 +1183,7 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  					.dirtied_ino = 1 };
>  	struct fscrypt_name nm;
>  
> -	dbg_gen("dent '%pd', target '%s' in dir ino %lu", dentry,
> +	dbg_gen("dent '%pd', target '%s' in dir ino %llu", dentry,
>  		symname, dir->i_ino);
>  
>  	err = fscrypt_prepare_symlink(dir, symname, len, UBIFS_MAX_INO_DATA,
> @@ -1349,7 +1349,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	 *   ino_req: marks the target inode as dirty and does not write it.
>  	 */
>  
> -	dbg_gen("dent '%pd' ino %lu in dir ino %lu to dent '%pd' in dir ino %lu flags 0x%x",
> +	dbg_gen("dent '%pd' ino %llu in dir ino %llu to dent '%pd' in dir ino %llu flags 0x%x",
>  		old_dentry, old_inode->i_ino, old_dir->i_ino,
>  		new_dentry, new_dir->i_ino, flags);
>  
> @@ -1597,7 +1597,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>  	 * parent directory inodes.
>  	 */
>  
> -	dbg_gen("dent '%pd' ino %lu in dir ino %lu exchange dent '%pd' ino %lu in dir ino %lu",
> +	dbg_gen("dent '%pd' ino %llu in dir ino %llu exchange dent '%pd' ino %llu in dir ino %llu",
>  		old_dentry, fst_inode->i_ino, old_dir->i_ino,
>  		new_dentry, snd_inode->i_ino, new_dir->i_ino);
>  
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index cd04755e792a7f8e7d33ed4e67806cd202c71fad..e73c28b12f97fd1fbeb67510434e499eab84da70 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -90,7 +90,7 @@ static int read_block(struct inode *inode, struct folio *folio, size_t offset,
>  	return 0;
>  
>  dump:
> -	ubifs_err(c, "bad data node (block %u, inode %lu)",
> +	ubifs_err(c, "bad data node (block %u, inode %llu)",
>  		  block, inode->i_ino);
>  	ubifs_dump_node(c, dn, UBIFS_MAX_DATA_NODE_SZ);
>  	return -EINVAL;
> @@ -106,7 +106,7 @@ static int do_readpage(struct folio *folio)
>  	loff_t i_size = i_size_read(inode);
>  	size_t offset = 0;
>  
> -	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
> +	dbg_gen("ino %llu, pg %lu, i_size %lld, flags %#lx",
>  		inode->i_ino, folio->index, i_size, folio->flags.f);
>  	ubifs_assert(c, !folio_test_checked(folio));
>  	ubifs_assert(c, !folio->private);
> @@ -162,7 +162,7 @@ static int do_readpage(struct folio *folio)
>  			dbg_gen("hole");
>  			err = 0;
>  		} else {
> -			ubifs_err(c, "cannot read page %lu of inode %lu, error %d",
> +			ubifs_err(c, "cannot read page %lu of inode %llu, error %d",
>  				  folio->index, inode->i_ino, err);
>  		}
>  	}
> @@ -212,7 +212,7 @@ static int write_begin_slow(struct address_space *mapping,
>  	int err, appending = !!(pos + len > inode->i_size);
>  	struct folio *folio;
>  
> -	dbg_gen("ino %lu, pos %llu, len %u, i_size %lld",
> +	dbg_gen("ino %llu, pos %llu, len %u, i_size %lld",
>  		inode->i_ino, pos, len, inode->i_size);
>  
>  	/*
> @@ -526,7 +526,7 @@ static int ubifs_write_end(const struct kiocb *iocb,
>  	loff_t end_pos = pos + len;
>  	int appending = !!(end_pos > inode->i_size);
>  
> -	dbg_gen("ino %lu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
> +	dbg_gen("ino %llu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
>  		inode->i_ino, pos, folio->index, len, copied, inode->i_size);
>  
>  	if (unlikely(copied < len && !folio_test_uptodate(folio))) {
> @@ -599,7 +599,7 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
>  	size_t offset = 0;
>  	pgoff_t end_index;
>  
> -	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
> +	dbg_gen("ino %llu, pg %lu, i_size %lld, flags %#lx",
>  		inode->i_ino, folio->index, i_size, folio->flags.f);
>  
>  	end_index = (i_size - 1) >> PAGE_SHIFT;
> @@ -680,7 +680,7 @@ static int populate_page(struct ubifs_info *c, struct folio *folio,
>  	return 0;
>  
>  out_err:
> -	ubifs_err(c, "bad data node (block %u, inode %lu)",
> +	ubifs_err(c, "bad data node (block %u, inode %llu)",
>  		  page_block, inode->i_ino);
>  	return -EINVAL;
>  }
> @@ -913,7 +913,7 @@ static int do_writepage(struct folio *folio, size_t len)
>  	}
>  	if (err) {
>  		mapping_set_error(folio->mapping, err);
> -		ubifs_err(c, "cannot write folio %lu of inode %lu, error %d",
> +		ubifs_err(c, "cannot write folio %lu of inode %llu, error %d",
>  			  folio->index, inode->i_ino, err);
>  		ubifs_ro_mode(c, err);
>  	}
> @@ -987,7 +987,7 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc)
>  	loff_t i_size =  i_size_read(inode), synced_i_size;
>  	int err, len = folio_size(folio);
>  
> -	dbg_gen("ino %lu, pg %lu, pg flags %#lx",
> +	dbg_gen("ino %llu, pg %lu, pg flags %#lx",
>  		inode->i_ino, folio->index, folio->flags.f);
>  	ubifs_assert(c, folio->private != NULL);
>  
> @@ -1106,7 +1106,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
>  	int offset = new_size & (UBIFS_BLOCK_SIZE - 1), budgeted = 1;
>  	struct ubifs_inode *ui = ubifs_inode(inode);
>  
> -	dbg_gen("ino %lu, size %lld -> %lld", inode->i_ino, old_size, new_size);
> +	dbg_gen("ino %llu, size %lld -> %lld", inode->i_ino, old_size, new_size);
>  	memset(&req, 0, sizeof(struct ubifs_budget_req));
>  
>  	/*
> @@ -1258,7 +1258,7 @@ int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	struct inode *inode = d_inode(dentry);
>  	struct ubifs_info *c = inode->i_sb->s_fs_info;
>  
> -	dbg_gen("ino %lu, mode %#x, ia_valid %#x",
> +	dbg_gen("ino %llu, mode %#x, ia_valid %#x",
>  		inode->i_ino, inode->i_mode, attr->ia_valid);
>  	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
>  	if (err)
> @@ -1308,7 +1308,7 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  	struct ubifs_info *c = inode->i_sb->s_fs_info;
>  	int err;
>  
> -	dbg_gen("syncing inode %lu", inode->i_ino);
> +	dbg_gen("syncing inode %llu", inode->i_ino);
>  
>  	if (c->ro_mount)
>  		/*
> @@ -1495,7 +1495,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>  	struct ubifs_budget_req req = { .new_page = 1 };
>  	int err, update_time;
>  
> -	dbg_gen("ino %lu, pg %lu, i_size %lld",	inode->i_ino, folio->index,
> +	dbg_gen("ino %llu, pg %lu, i_size %lld",	inode->i_ino, folio->index,
>  		i_size_read(inode));
>  	ubifs_assert(c, !c->ro_media && !c->ro_mount);
>  
> @@ -1531,7 +1531,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>  	err = ubifs_budget_space(c, &req);
>  	if (unlikely(err)) {
>  		if (err == -ENOSPC)
> -			ubifs_warn(c, "out of space for mmapped file (inode number %lu)",
> +			ubifs_warn(c, "out of space for mmapped file (inode number %llu)",
>  				   inode->i_ino);
>  		return VM_FAULT_SIGBUS;
>  	}
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index e28ab4395e5ca404d8e8d8f735c3113b58bcc941..40a95a2fad50039f39917e71da7b71a735237469 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -982,7 +982,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
>  	int kill_xattrs = ui->xattr_cnt && last_reference;
>  	u8 hash[UBIFS_HASH_ARR_SZ];
>  
> -	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
> +	dbg_jnl("ino %llu, nlink %u", inode->i_ino, inode->i_nlink);
>  
>  	if (kill_xattrs && ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
>  		ubifs_err(c, "Cannot delete inode, it has too many xattrs!");
> @@ -1743,7 +1743,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
>  			int dn_len = le32_to_cpu(dn->size);
>  
>  			if (dn_len <= 0 || dn_len > UBIFS_BLOCK_SIZE) {
> -				ubifs_err(c, "bad data node (block %u, inode %lu)",
> +				ubifs_err(c, "bad data node (block %u, inode %llu)",
>  					  blk, inode->i_ino);
>  				ubifs_dump_node(c, dn, dn_size);
>  				err = -EUCLEAN;
> @@ -1987,7 +1987,7 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
>  	u8 hash_host[UBIFS_HASH_ARR_SZ];
>  	u8 hash[UBIFS_HASH_ARR_SZ];
>  
> -	dbg_jnl("ino %lu, ino %lu", host->i_ino, inode->i_ino);
> +	dbg_jnl("ino %llu, ino %llu", host->i_ino, inode->i_ino);
>  	ubifs_assert(c, inode->i_nlink > 0);
>  	ubifs_assert(c, mutex_is_locked(&host_ui->ui_mutex));
>  
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 03bf924756ca003809d229837a970d5935450f23..9a77d8b64ffa70f9d5b695fb3d87c22cb223704f 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -92,7 +92,7 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
>  		return 5;
>  
>  	if (!ubifs_compr_present(c, ui->compr_type)) {
> -		ubifs_warn(c, "inode %lu uses '%s' compression, but it was not compiled in",
> +		ubifs_warn(c, "inode %llu uses '%s' compression, but it was not compiled in",
>  			   inode->i_ino, ubifs_compr_name(c, ui->compr_type));
>  	}
>  
> @@ -248,14 +248,14 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
>  	return inode;
>  
>  out_invalid:
> -	ubifs_err(c, "inode %lu validation failed, error %d", inode->i_ino, err);
> +	ubifs_err(c, "inode %llu validation failed, error %d", inode->i_ino, err);
>  	ubifs_dump_node(c, ino, UBIFS_MAX_INO_NODE_SZ);
>  	ubifs_dump_inode(c, inode);
>  	err = -EINVAL;
>  out_ino:
>  	kfree(ino);
>  out:
> -	ubifs_err(c, "failed to read inode %lu, error %d", inode->i_ino, err);
> +	ubifs_err(c, "failed to read inode %llu, error %d", inode->i_ino, err);
>  	iget_failed(inode);
>  	return ERR_PTR(err);
>  }
> @@ -316,12 +316,12 @@ static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  	 * As an optimization, do not write orphan inodes to the media just
>  	 * because this is not needed.
>  	 */
> -	dbg_gen("inode %lu, mode %#x, nlink %u",
> +	dbg_gen("inode %llu, mode %#x, nlink %u",
>  		inode->i_ino, (int)inode->i_mode, inode->i_nlink);
>  	if (inode->i_nlink) {
>  		err = ubifs_jnl_write_inode(c, inode);
>  		if (err)
> -			ubifs_err(c, "can't write inode %lu, error %d",
> +			ubifs_err(c, "can't write inode %llu, error %d",
>  				  inode->i_ino, err);
>  		else
>  			err = dbg_check_inode_size(c, inode, ui->ui_size);
> @@ -357,7 +357,7 @@ static void ubifs_evict_inode(struct inode *inode)
>  		 */
>  		goto out;
>  
> -	dbg_gen("inode %lu, mode %#x", inode->i_ino, (int)inode->i_mode);
> +	dbg_gen("inode %llu, mode %#x", inode->i_ino, (int)inode->i_mode);
>  	ubifs_assert(c, !icount_read(inode));
>  
>  	truncate_inode_pages_final(&inode->i_data);
> @@ -375,7 +375,7 @@ static void ubifs_evict_inode(struct inode *inode)
>  		 * Worst case we have a lost orphan inode wasting space, so a
>  		 * simple error message is OK here.
>  		 */
> -		ubifs_err(c, "can't delete inode %lu, error %d",
> +		ubifs_err(c, "can't delete inode %llu, error %d",
>  			  inode->i_ino, err);
>  
>  out:
> @@ -399,7 +399,7 @@ static void ubifs_dirty_inode(struct inode *inode, int flags)
>  	ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
>  	if (!ui->dirty) {
>  		ui->dirty = 1;
> -		dbg_gen("inode %lu",  inode->i_ino);
> +		dbg_gen("inode %llu",  inode->i_ino);
>  	}
>  }
>  
> diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
> index 694b08d27d7d9c7d9d7d9039f406637c702f8613..c9d8935f667805d89b1307628a78ccf32f11212b 100644
> --- a/fs/ubifs/tnc.c
> +++ b/fs/ubifs/tnc.c
> @@ -3561,8 +3561,8 @@ int dbg_check_inode_size(struct ubifs_info *c, const struct inode *inode,
>  
>  out_dump:
>  	block = key_block(c, key);
> -	ubifs_err(c, "inode %lu has size %lld, but there are data at offset %lld",
> -		  (unsigned long)inode->i_ino, size,
> +	ubifs_err(c, "inode %llu has size %lld, but there are data at offset %lld",
> +		  inode->i_ino, size,
>  		  ((loff_t)block) << UBIFS_BLOCK_SHIFT);
>  	mutex_unlock(&c->tnc_mutex);
>  	ubifs_dump_inode(c, inode);
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index c21a0c2b3e907c1572780d4a3e48cc9d2a11b9d6..b5a9ab9d8a10adcf49e6d7228d385cb986e6e75e 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -76,7 +76,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>  				.dirtied_ino_d = ALIGN(host_ui->data_len, 8) };
>  
>  	if (host_ui->xattr_cnt >= ubifs_xattr_max_cnt(c)) {
> -		ubifs_err(c, "inode %lu already has too many xattrs (%d), cannot create more",
> +		ubifs_err(c, "inode %llu already has too many xattrs (%d), cannot create more",
>  			  host->i_ino, host_ui->xattr_cnt);
>  		return -ENOSPC;
>  	}
> @@ -88,7 +88,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>  	 */
>  	names_len = host_ui->xattr_names + host_ui->xattr_cnt + fname_len(nm) + 1;
>  	if (names_len > XATTR_LIST_MAX) {
> -		ubifs_err(c, "cannot add one more xattr name to inode %lu, total names length would become %d, max. is %d",
> +		ubifs_err(c, "cannot add one more xattr name to inode %llu, total names length would become %d, max. is %d",
>  			  host->i_ino, names_len, XATTR_LIST_MAX);
>  		return -ENOSPC;
>  	}
> @@ -390,7 +390,7 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  	int err, len, written = 0;
>  	struct fscrypt_name nm = {0};
>  
> -	dbg_gen("ino %lu ('%pd'), buffer size %zd", host->i_ino,
> +	dbg_gen("ino %llu ('%pd'), buffer size %zd", host->i_ino,
>  		dentry, size);
>  
>  	down_read(&host_ui->xattr_sem);
> @@ -498,7 +498,7 @@ int ubifs_purge_xattrs(struct inode *host)
>  	if (ubifs_inode(host)->xattr_cnt <= ubifs_xattr_max_cnt(c))
>  		return 0;
>  
> -	ubifs_warn(c, "inode %lu has too many xattrs, doing a non-atomic deletion",
> +	ubifs_warn(c, "inode %llu has too many xattrs, doing a non-atomic deletion",
>  		   host->i_ino);
>  
>  	down_write(&ubifs_inode(host)->xattr_sem);
> @@ -641,7 +641,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
>  					   &init_xattrs, NULL);
>  	if (err) {
>  		struct ubifs_info *c = dentry->i_sb->s_fs_info;
> -		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
> +		ubifs_err(c, "cannot initialize security for inode %llu, error %d",
>  			  inode->i_ino, err);
>  	}
>  	return err;
> @@ -652,7 +652,7 @@ static int xattr_get(const struct xattr_handler *handler,
>  			   struct dentry *dentry, struct inode *inode,
>  			   const char *name, void *buffer, size_t size)
>  {
> -	dbg_gen("xattr '%s', ino %lu ('%pd'), buf size %zd", name,
> +	dbg_gen("xattr '%s', ino %llu ('%pd'), buf size %zd", name,
>  		inode->i_ino, dentry, size);
>  
>  	name = xattr_full_name(handler, name);
> @@ -665,7 +665,7 @@ static int xattr_set(const struct xattr_handler *handler,
>  			   const char *name, const void *value,
>  			   size_t size, int flags)
>  {
> -	dbg_gen("xattr '%s', host ino %lu ('%pd'), size %zd",
> +	dbg_gen("xattr '%s', host ino %llu ('%pd'), size %zd",
>  		name, inode->i_ino, dentry, size);
>  
>  	name = xattr_full_name(handler, name);
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 632453aa38934a0b58b420717ec0674c85627ce5..f5c81e13eacb17f931d2df564ec4f2a6e9a5d7ab 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -22,7 +22,7 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
>  
>  	if (iter->fi.descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has entry at pos %llu with incorrect tag %x\n",
> +			"directory (ino %llu) has entry at pos %llu with incorrect tag %x\n",
>  			iter->dir->i_ino, (unsigned long long)iter->pos,
>  			le16_to_cpu(iter->fi.descTag.tagIdent));
>  		return -EFSCORRUPTED;
> @@ -30,7 +30,7 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
>  	len = udf_dir_entry_len(&iter->fi);
>  	if (le16_to_cpu(iter->fi.lengthOfImpUse) & 3) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has entry at pos %llu with unaligned length of impUse field\n",
> +			"directory (ino %llu) has entry at pos %llu with unaligned length of impUse field\n",
>  			iter->dir->i_ino, (unsigned long long)iter->pos);
>  		return -EFSCORRUPTED;
>  	}
> @@ -41,20 +41,20 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
>  	 */
>  	if (len > 1 << iter->dir->i_blkbits) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has too big (%u) entry at pos %llu\n",
> +			"directory (ino %llu) has too big (%u) entry at pos %llu\n",
>  			iter->dir->i_ino, len, (unsigned long long)iter->pos);
>  		return -EFSCORRUPTED;
>  	}
>  	if (iter->pos + len > iter->dir->i_size) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has entry past directory size at pos %llu\n",
> +			"directory (ino %llu) has entry past directory size at pos %llu\n",
>  			iter->dir->i_ino, (unsigned long long)iter->pos);
>  		return -EFSCORRUPTED;
>  	}
>  	if (udf_dir_entry_len(&iter->fi) !=
>  	    sizeof(struct tag) + le16_to_cpu(iter->fi.descTag.descCRCLength)) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has entry where CRC length (%u) does not match entry length (%u)\n",
> +			"directory (ino %llu) has entry where CRC length (%u) does not match entry length (%u)\n",
>  			iter->dir->i_ino,
>  			(unsigned)le16_to_cpu(iter->fi.descTag.descCRCLength),
>  			(unsigned)(udf_dir_entry_len(&iter->fi) -
> @@ -78,7 +78,7 @@ static int udf_copy_fi(struct udf_fileident_iter *iter)
>  	}
>  	if (iter->dir->i_size < iter->pos + sizeof(struct fileIdentDesc)) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has entry straddling EOF\n",
> +			"directory (ino %llu) has entry straddling EOF\n",
>  			iter->dir->i_ino);
>  		return -EFSCORRUPTED;
>  	}
> @@ -184,7 +184,7 @@ static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
>  			return 0;
>  		}
>  		udf_err(iter->dir->i_sb,
> -			"extent after position %llu not allocated in directory (ino %lu)\n",
> +			"extent after position %llu not allocated in directory (ino %llu)\n",
>  			(unsigned long long)iter->pos, iter->dir->i_ino);
>  		return -EFSCORRUPTED;
>  	}
> @@ -272,7 +272,7 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
>  		if (pos == dir->i_size)
>  			return 0;
>  		udf_err(dir->i_sb,
> -			"position %llu not allocated in directory (ino %lu)\n",
> +			"position %llu not allocated in directory (ino %llu)\n",
>  			(unsigned long long)pos, dir->i_ino);
>  		err = -EFSCORRUPTED;
>  		goto out;
> @@ -483,7 +483,7 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
>  		   &iter->loffset, &etype);
>  	if (err <= 0 || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
>  		udf_err(iter->dir->i_sb,
> -			"block %llu not allocated in directory (ino %lu)\n",
> +			"block %llu not allocated in directory (ino %llu)\n",
>  			(unsigned long long)block, iter->dir->i_ino);
>  		return -EFSCORRUPTED;
>  	}
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 32ae7cfd72c549958b70824b449cf146f6750f44..b043fe10e5d605b62988512bbda65bd357fb649a 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -133,7 +133,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	int result;
>  
>  	if (file_permission(filp, MAY_READ) != 0) {
> -		udf_debug("no permission to access inode %lu\n", inode->i_ino);
> +		udf_debug("no permission to access inode %llu\n", inode->i_ino);
>  		return -EPERM;
>  	}
>  
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 7fae8002344a0e1e7e51022e97f1e0e2424185f9..902f81729bd886a534c9da644771c7c04c067cbf 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -147,7 +147,7 @@ void udf_evict_inode(struct inode *inode)
>  		if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB &&
>  		    inode->i_size != iinfo->i_lenExtents) {
>  			udf_warn(inode->i_sb,
> -				 "Inode %lu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
> +				 "Inode %llu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
>  				 inode->i_ino, inode->i_mode,
>  				 (unsigned long long)inode->i_size,
>  				 (unsigned long long)iinfo->i_lenExtents);
> @@ -1386,13 +1386,13 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  	 */
>  	bh = udf_read_ptagged(inode->i_sb, iloc, 0, &ident);
>  	if (!bh) {
> -		udf_err(inode->i_sb, "(ino %lu) failed !bh\n", inode->i_ino);
> +		udf_err(inode->i_sb, "(ino %llu) failed !bh\n", inode->i_ino);
>  		return -EIO;
>  	}
>  
>  	if (ident != TAG_IDENT_FE && ident != TAG_IDENT_EFE &&
>  	    ident != TAG_IDENT_USE) {
> -		udf_err(inode->i_sb, "(ino %lu) failed ident=%u\n",
> +		udf_err(inode->i_sb, "(ino %llu) failed ident=%u\n",
>  			inode->i_ino, ident);
>  		goto out;
>  	}
> @@ -1641,7 +1641,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  		udf_debug("METADATA BITMAP FILE-----\n");
>  		break;
>  	default:
> -		udf_err(inode->i_sb, "(ino %lu) failed unknown file type=%u\n",
> +		udf_err(inode->i_sb, "(ino %llu) failed unknown file type=%u\n",
>  			inode->i_ino, fe->icbTag.fileType);
>  		goto out;
>  	}
> @@ -1942,7 +1942,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
>  	if (do_sync) {
>  		sync_dirty_buffer(bh);
>  		if (buffer_write_io_error(bh)) {
> -			udf_warn(inode->i_sb, "IO error syncing udf inode [%08lx]\n",
> +			udf_warn(inode->i_sb, "IO error syncing udf inode [%08llx]\n",
>  				 inode->i_ino);
>  			err = -EIO;
>  		}
> @@ -2224,7 +2224,7 @@ int udf_next_aext(struct inode *inode, struct extent_position *epos,
>  
>  		if (++indirections > UDF_MAX_INDIR_EXTS) {
>  			udf_err(inode->i_sb,
> -				"too many indirect extents in inode %lu\n",
> +				"too many indirect extents in inode %llu\n",
>  				inode->i_ino);
>  			return -EFSCORRUPTED;
>  		}
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 5f2e9a892bffa9579143cedf71d80efa7ad6e9fb..ccafcaa9680982decaabc180833b67ace5c92973 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -550,7 +550,7 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
>  		goto end_unlink;
>  
>  	if (!inode->i_nlink) {
> -		udf_debug("Deleting nonexistent file (%lu), %u\n",
> +		udf_debug("Deleting nonexistent file (%llu), %u\n",
>  			  inode->i_ino, inode->i_nlink);
>  		set_nlink(inode, 1);
>  	}
> @@ -809,7 +809,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  					       &diriter);
>  		if (retval == -ENOENT) {
>  			udf_err(old_inode->i_sb,
> -				"directory (ino %lu) has no '..' entry\n",
> +				"directory (ino %llu) has no '..' entry\n",
>  				old_inode->i_ino);
>  			retval = -EFSCORRUPTED;
>  		}
> @@ -821,7 +821,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  				old_dir->i_ino) {
>  			retval = -EFSCORRUPTED;
>  			udf_err(old_inode->i_sb,
> -				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
> +				"directory (ino %llu) has parent entry pointing to another inode (%llu != %u)\n",
>  				old_inode->i_ino, old_dir->i_ino,
>  				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
>  			goto out_oiter;
> @@ -869,7 +869,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	retval = udf_fiiter_find_entry(old_dir, &old_dentry->d_name, &oiter);
>  	if (retval) {
>  		udf_err(old_dir->i_sb,
> -			"failed to find renamed entry again in directory (ino %lu)\n",
> +			"failed to find renamed entry again in directory (ino %llu)\n",
>  			old_dir->i_ino);
>  	} else {
>  		udf_fiiter_delete_entry(&oiter);
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 27f463fd1d89e8ae4844cd70c291d737aee1589e..3a2d66c7e856383cc5c8a605180a9582396ba805 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1166,7 +1166,7 @@ static int udf_fill_partdesc_info(struct super_block *sb,
>  		}
>  		map->s_uspace.s_table = inode;
>  		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_TABLE;
> -		udf_debug("unallocSpaceTable (part %d) @ %lu\n",
> +		udf_debug("unallocSpaceTable (part %d) @ %llu\n",
>  			  p_index, map->s_uspace.s_table->i_ino);
>  	}
>  
> diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
> index 194ed3ab945e3eae94db085ee8d37eb1a4439470..628edfde3a9fd73852930094c19ae6944858f2c4 100644
> --- a/fs/ufs/balloc.c
> +++ b/fs/ufs/balloc.c
> @@ -245,7 +245,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
>  	sector_t end, i;
>  	struct buffer_head *head, *bh;
>  
> -	UFSD("ENTER, ino %lu, count %u, oldb %llu, newb %llu\n",
> +	UFSD("ENTER, ino %llu, count %u, oldb %llu, newb %llu\n",
>  	      inode->i_ino, count,
>  	     (unsigned long long)oldb, (unsigned long long)newb);
>  
> @@ -340,7 +340,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
>  	unsigned cgno, oldcount, newcount;
>  	u64 tmp, request, result;
>  	
> -	UFSD("ENTER, ino %lu, fragment %llu, goal %llu, count %u\n",
> +	UFSD("ENTER, ino %llu, fragment %llu, goal %llu, count %u\n",
>  	     inode->i_ino, (unsigned long long)fragment,
>  	     (unsigned long long)goal, count);
>  	
> @@ -583,7 +583,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
>  	unsigned oldcg, i, j, k, allocsize;
>  	u64 result;
>  	
> -	UFSD("ENTER, ino %lu, cgno %u, goal %llu, count %u\n",
> +	UFSD("ENTER, ino %llu, cgno %u, goal %llu, count %u\n",
>  	     inode->i_ino, cgno, (unsigned long long)goal, count);
>  
>  	sb = inode->i_sb;
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 43f1578ab8666a9611d4a77f5aababfce812fbe4..f10a50f7e78b8020fd216eff19c147b20bd332c1 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -150,7 +150,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
>  
>  Ebadsize:
>  	ufs_error(sb, __func__,
> -		  "size of directory #%lu is not a multiple of chunk size",
> +		  "size of directory #%llu is not a multiple of chunk size",
>  		  dir->i_ino
>  	);
>  	goto fail;
> @@ -169,7 +169,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
>  Einumber:
>  	error = "inode out of bounds";
>  bad_entry:
> -	ufs_error(sb, __func__, "bad entry in directory #%lu: %s - "
> +	ufs_error(sb, __func__, "bad entry in directory #%llu: %s - "
>  		   "offset=%llu, rec_len=%d, name_len=%d",
>  		   dir->i_ino, error, folio_pos(folio) + offs,
>  		   rec_len, ufs_get_de_namlen(sb, p));
> @@ -177,7 +177,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
>  Eend:
>  	p = (struct ufs_dir_entry *)(kaddr + offs);
>  	ufs_error(sb, __func__,
> -		   "entry in directory #%lu spans the page boundary"
> +		   "entry in directory #%llu spans the page boundary"
>  		   "offset=%llu",
>  		   dir->i_ino, folio_pos(folio) + offs);
>  fail:
> @@ -258,7 +258,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  	struct ufs_inode_info *ui = UFS_I(dir);
>  	struct ufs_dir_entry *de;
>  
> -	UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen);
> +	UFSD("ENTER, dir_ino %llu, name %s, namlen %u\n", dir->i_ino, name, namelen);
>  
>  	if (npages == 0 || namelen > UFS_MAXNAMLEN)
>  		goto out;
> @@ -434,7 +434,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  
>  		if (IS_ERR(kaddr)) {
>  			ufs_error(sb, __func__,
> -				  "bad page in #%lu",
> +				  "bad page in #%llu",
>  				  inode->i_ino);
>  			ctx->pos += PAGE_SIZE - offset;
>  			return PTR_ERR(kaddr);
> diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
> index 73531827ecee12b3dff09aef0acc0e374b00fb29..8e51f4630d186ae49aa987ca46df20960f300614 100644
> --- a/fs/ufs/ialloc.c
> +++ b/fs/ufs/ialloc.c
> @@ -63,7 +63,7 @@ void ufs_free_inode (struct inode * inode)
>  	int is_directory;
>  	unsigned ino, cg, bit;
>  	
> -	UFSD("ENTER, ino %lu\n", inode->i_ino);
> +	UFSD("ENTER, ino %llu\n", inode->i_ino);
>  
>  	sb = inode->i_sb;
>  	uspi = UFS_SB(sb)->s_uspi;
> @@ -317,7 +317,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
>  		bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
>  		if (!bh) {
>  			ufs_warning(sb, "ufs_read_inode",
> -				    "unable to read inode %lu\n",
> +				    "unable to read inode %llu\n",
>  				    inode->i_ino);
>  			err = -EIO;
>  			goto fail_remove_inode;
> @@ -336,7 +336,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
>  	}
>  	mutex_unlock(&sbi->s_lock);
>  
> -	UFSD("allocating inode %lu\n", inode->i_ino);
> +	UFSD("allocating inode %llu\n", inode->i_ino);
>  	UFSD("EXIT\n");
>  	return inode;
>  
> diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
> index e2b0a35de2a7000f46a298114c1dcaffa17c43dc..2a8728c879796403166f713d1b4ee1b05fe1ffed 100644
> --- a/fs/ufs/inode.c
> +++ b/fs/ufs/inode.c
> @@ -400,7 +400,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
>  
>  	mutex_lock(&UFS_I(inode)->truncate_mutex);
>  
> -	UFSD("ENTER, ino %lu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
> +	UFSD("ENTER, ino %llu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
>  	if (unlikely(!depth)) {
>  		ufs_warning(sb, "ufs_get_block", "block > big");
>  		err = -EIO;
> @@ -595,7 +595,7 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
>  	struct super_block *sb = inode->i_sb;
>  	umode_t mode;
>  
> -	UFSD("Reading ufs2 inode, ino %lu\n", inode->i_ino);
> +	UFSD("Reading ufs2 inode, ino %llu\n", inode->i_ino);
>  	/*
>  	 * Copy data to the in-core inode.
>  	 */
> @@ -662,7 +662,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
>  
>  	bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
>  	if (!bh) {
> -		ufs_warning(sb, "ufs_read_inode", "unable to read inode %lu\n",
> +		ufs_warning(sb, "ufs_read_inode", "unable to read inode %llu\n",
>  			    inode->i_ino);
>  		goto bad_inode;
>  	}
> @@ -793,17 +793,17 @@ static int ufs_update_inode(struct inode * inode, int do_sync)
>  	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
>  	struct buffer_head * bh;
>  
> -	UFSD("ENTER, ino %lu\n", inode->i_ino);
> +	UFSD("ENTER, ino %llu\n", inode->i_ino);
>  
>  	if (inode->i_ino < UFS_ROOTINO ||
>  	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
> -		ufs_warning (sb, "ufs_read_inode", "bad inode number (%lu)\n", inode->i_ino);
> +		ufs_warning (sb, "ufs_read_inode", "bad inode number (%llu)\n", inode->i_ino);
>  		return -1;
>  	}
>  
>  	bh = sb_bread(sb, ufs_inotofsba(inode->i_ino));
>  	if (!bh) {
> -		ufs_warning (sb, "ufs_read_inode", "unable to read inode %lu\n", inode->i_ino);
> +		ufs_warning (sb, "ufs_read_inode", "unable to read inode %llu\n", inode->i_ino);
>  		return -1;
>  	}
>  	if (uspi->fs_magic == UFS2_MAGIC) {
> @@ -891,7 +891,7 @@ static void ufs_trunc_direct(struct inode *inode)
>  	unsigned int old_tail, new_tail;
>  	struct to_free ctx = {.inode = inode};
>  
> -	UFSD("ENTER: ino %lu\n", inode->i_ino);
> +	UFSD("ENTER: ino %llu\n", inode->i_ino);
>  
>  	new_frags = DIRECT_FRAGMENT;
>  	// new_frags = first fragment past the new EOF
> @@ -956,7 +956,7 @@ static void ufs_trunc_direct(struct inode *inode)
>  		}
>  	}
>  done:
> -	UFSD("EXIT: ino %lu\n", inode->i_ino);
> +	UFSD("EXIT: ino %llu\n", inode->i_ino);
>  }
>  
>  static void free_full_branch(struct inode *inode, u64 ind_block, int depth)
> @@ -1169,7 +1169,7 @@ static int ufs_truncate(struct inode *inode, loff_t size)
>  {
>  	int err = 0;
>  
> -	UFSD("ENTER: ino %lu, i_size: %llu, old_i_size: %llu\n",
> +	UFSD("ENTER: ino %llu, i_size: %llu, old_i_size: %llu\n",
>  	     inode->i_ino, (unsigned long long)size,
>  	     (unsigned long long)i_size_read(inode));
>  
> diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
> index 0905f9a16b9150b656bd6d8966c0f8cc220b439d..b8dc354ae90f4a0839303f89c87bd2940db62b99 100644
> --- a/fs/ufs/ufs_fs.h
> +++ b/fs/ufs/ufs_fs.h
> @@ -226,10 +226,10 @@ typedef __u16 __bitwise __fs16;
>   *     inode number to cylinder group number.
>   *     inode number to file system block address.
>   */
> -#define	ufs_inotocg(x)		((x) / uspi->s_ipg)
> -#define	ufs_inotocgoff(x)	((x) % uspi->s_ipg)
> +#define	ufs_inotocg(x)		((unsigned int)(x) / uspi->s_ipg)
> +#define	ufs_inotocgoff(x)	((unsigned int)(x) % uspi->s_ipg)
>  #define	ufs_inotofsba(x)	(((u64)ufs_cgimin(ufs_inotocg(x))) + ufs_inotocgoff(x) / uspi->s_inopf)
> -#define	ufs_inotofsbo(x)	((x) % uspi->s_inopf)
> +#define	ufs_inotofsbo(x)	((unsigned int)(x) % uspi->s_inopf)
>  
>  /*
>   * Compute the cylinder and rotational position of a cyl block addr.
> diff --git a/fs/ufs/util.c b/fs/ufs/util.c
> index 034b1d82c355ca49ec917e98dcfcc6d80e6eb00b..dff6f74618def7bd5687bd7427f3001a78b708b8 100644
> --- a/fs/ufs/util.c
> +++ b/fs/ufs/util.c
> @@ -203,7 +203,7 @@ struct folio *ufs_get_locked_folio(struct address_space *mapping,
>  		folio = read_mapping_folio(mapping, index, NULL);
>  
>  		if (IS_ERR(folio)) {
> -			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %lu, index: %lu\n",
> +			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %llu, index: %lu\n",
>  			       mapping->host->i_ino, index);
>  			return folio;
>  		}
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index d6520660858386d3b7d69b20a459dc27d8017a5f..3aa55dec88fc919792a2cb4be476f8481ef78a9e 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -50,7 +50,7 @@ void fsverity_msg(const struct inode *inode, const char *level,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	if (inode)
> -		printk("%sfs-verity (%s, inode %lu): %pV\n",
> +		printk("%sfs-verity (%s, inode %llu): %pV\n",
>  		       level, inode->i_sb->s_id, inode->i_ino, &vaf);
>  	else
>  		printk("%sfs-verity: %pV\n", level, &vaf);
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index e83b2ec5e49f81674bfbb5e1fd2c65add32cda1c..9b646cb5335d0643bc0431aa8efc35a90fbcdac5 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -297,7 +297,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
>  	 */
>  	if (isize != data_size)
>  		zonefs_warn(sb,
> -			    "inode %lu: invalid size %lld (should be %lld)\n",
> +			    "inode %llu: invalid size %lld (should be %lld)\n",
>  			    inode->i_ino, isize, data_size);
>  
>  	/*
> @@ -308,7 +308,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
>  	 */
>  	if ((z->z_flags & ZONEFS_ZONE_OFFLINE) ||
>  	    (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZOL)) {
> -		zonefs_warn(sb, "inode %lu: read/write access disabled\n",
> +		zonefs_warn(sb, "inode %llu: read/write access disabled\n",
>  			    inode->i_ino);
>  		if (!(z->z_flags & ZONEFS_ZONE_OFFLINE))
>  			z->z_flags |= ZONEFS_ZONE_OFFLINE;
> @@ -316,7 +316,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
>  		data_size = 0;
>  	} else if ((z->z_flags & ZONEFS_ZONE_READONLY) ||
>  		   (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO)) {
> -		zonefs_warn(sb, "inode %lu: write access disabled\n",
> +		zonefs_warn(sb, "inode %llu: write access disabled\n",
>  			    inode->i_ino);
>  		if (!(z->z_flags & ZONEFS_ZONE_READONLY))
>  			z->z_flags |= ZONEFS_ZONE_READONLY;
> @@ -402,7 +402,7 @@ void __zonefs_io_error(struct inode *inode, bool write)
>  	memalloc_noio_restore(noio_flag);
>  
>  	if (ret != 1) {
> -		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
> +		zonefs_err(sb, "Get inode %llu zone information failed %d\n",
>  			   inode->i_ino, ret);
>  		zonefs_warn(sb, "remounting filesystem read-only\n");
>  		sb->s_flags |= SB_RDONLY;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dfa1f475b1c480c503ab6f00e891aa9b051607fa..097443bf12e289c347651e5f3da5b67eb6b53121 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -783,7 +783,7 @@ struct inode {
>  #endif
>  
>  	/* Stat data, not accessed from path walking */
> -	unsigned long		i_ino;
> +	u64			i_ino;
>  	/*
>  	 * Filesystems may only read i_nlink directly.  They shall use the
>  	 * following functions for modification:
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 923b24b321cc0fbdecaf016645cdac0457a74463..4084e926e284487ea7e28b63721797b20f0dfefd 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -344,7 +344,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>  static void update_ref_ctr_warn(struct uprobe *uprobe,
>  				struct mm_struct *mm, short d)
>  {
> -	pr_warn("ref_ctr %s failed for inode: 0x%lx offset: "
> +	pr_warn("ref_ctr %s failed for inode: 0x%llx offset: "
>  		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%p\n",
>  		d > 0 ? "increment" : "decrement", uprobe->inode->i_ino,
>  		(unsigned long long) uprobe->offset,
> @@ -982,7 +982,7 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>  static void
>  ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
>  {
> -	pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
> +	pr_warn("ref_ctr_offset mismatch. inode: 0x%llx offset: 0x%llx "
>  		"ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
>  		uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
>  		(unsigned long long) cur_uprobe->ref_ctr_offset,
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index b816c56124ab8b7e59689e612d36007bb11aacaa..5fc54836dfa859379957bbfd299881e7d2f9ce89 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -1305,7 +1305,7 @@ static int nr_info_show(struct seq_file *seq, void *v)
>  		seq_printf(seq, "%-9s ", ax2asc(buf, &nr->user_addr));
>  		seq_printf(seq, "%-9s ", ax2asc(buf, &nr->dest_addr));
>  		seq_printf(seq,
> -"%-9s %-3s  %02X/%02X %02X/%02X %2d %3d %3d %3d %3lu/%03lu %2lu/%02lu %3lu/%03lu %3lu/%03lu %2d/%02d %3d %5d %5d %ld\n",
> +"%-9s %-3s  %02X/%02X %02X/%02X %2d %3d %3d %3d %3lu/%03lu %2lu/%02lu %3lu/%03lu %3lu/%03lu %2d/%02d %3d %5d %5d %llu\n",
>  			ax2asc(buf, &nr->source_addr),
>  			devname,
>  			nr->my_index,
> @@ -1329,7 +1329,7 @@ static int nr_info_show(struct seq_file *seq, void *v)
>  			nr->window,
>  			sk_wmem_alloc_get(s),
>  			sk_rmem_alloc_get(s),
> -			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : 0L);
> +			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : (u64)0);
>  
>  		bh_unlock_sock(s);
>  	}
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index 841d62481048def8d800779efb6e4ea8cbe419fe..53557176b41ea76fd44a0554568dedac7b3c91a5 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -1479,7 +1479,7 @@ static int rose_info_show(struct seq_file *seq, void *v)
>  			callsign = ax2asc(buf, &rose->source_call);
>  
>  		seq_printf(seq,
> -			   "%-10s %-9s %-5s %3.3X %05d  %d  %d  %d  %d %3lu %3lu %3lu %3lu %3lu %3lu/%03lu %5d %5d %ld\n",
> +			   "%-10s %-9s %-5s %3.3X %05d  %d  %d  %d  %d %3lu %3lu %3lu %3lu %3lu %3lu/%03lu %5d %5d %llu\n",
>  			rose2asc(rsbuf, &rose->source_addr),
>  			callsign,
>  			devname,
> @@ -1498,7 +1498,7 @@ static int rose_info_show(struct seq_file *seq, void *v)
>  			rose->idle / (60 * HZ),
>  			sk_wmem_alloc_get(s),
>  			sk_rmem_alloc_get(s),
> -			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : 0L);
> +			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : (u64)0);
>  	}
>  
>  	return 0;
> diff --git a/net/socket.c b/net/socket.c
> index d25be67e4b84a5a0a033802404ad06a837b299b3..89ad750ea536a0fffddd640ff0a47810be1cf16d 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -399,7 +399,7 @@ static const struct super_operations sockfs_ops = {
>   */
>  static char *sockfs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> -	return dynamic_dname(buffer, buflen, "socket:[%lu]",
> +	return dynamic_dname(buffer, buflen, "socket:[%llu]",
>  				d_inode(dentry)->i_ino);
>  }
>  
> diff --git a/net/x25/x25_proc.c b/net/x25/x25_proc.c
> index 0412814a2295bba5e26f4c95697ef7b7ba5fb34f..7e0dbff8f538f2682665b78e89ce87d56326655c 100644
> --- a/net/x25/x25_proc.c
> +++ b/net/x25/x25_proc.c
> @@ -96,7 +96,7 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
>  		devname = x25->neighbour->dev->name;
>  
>  	seq_printf(seq, "%-10s %-10s %-5s %3.3X  %d  %d  %d  %d %3lu %3lu "
> -			"%3lu %3lu %3lu %5d %5d %ld\n",
> +			"%3lu %3lu %3lu %5d %5d %llu\n",
>  		   !x25->dest_addr.x25_addr[0] ? "*" : x25->dest_addr.x25_addr,
>  		   !x25->source_addr.x25_addr[0] ? "*" : x25->source_addr.x25_addr,
>  		   devname, x25->lci & 0x0FFF, x25->state, x25->vs, x25->vr,
> @@ -104,7 +104,7 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
>  		   x25->t21 / HZ, x25->t22 / HZ, x25->t23 / HZ,
>  		   sk_wmem_alloc_get(s),
>  		   sk_rmem_alloc_get(s),
> -		   s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : 0L);
> +		   s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : (u64)0);
>  out:
>  	return 0;
>  }
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 2f84bd23edb69e7e69cb097e554091df0132816d..7b645f40e71c956f216fa6a7d69c3ecd4e2a5ff4 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -149,7 +149,7 @@ static int aafs_count;
>  
>  static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
>  {
> -	seq_printf(seq, "%s:[%lu]", AAFS_NAME, d_inode(dentry)->i_ino);
> +	seq_printf(seq, "%s:[%llu]", AAFS_NAME, d_inode(dentry)->i_ino);
>  	return 0;
>  }
>  
> @@ -2644,7 +2644,7 @@ static int policy_readlink(struct dentry *dentry, char __user *buffer,
>  	char name[32];
>  	int res;
>  
> -	res = snprintf(name, sizeof(name), "%s:[%lu]", AAFS_NAME,
> +	res = snprintf(name, sizeof(name), "%s:[%llu]", AAFS_NAME,
>  		       d_inode(dentry)->i_ino);
>  	if (res > 0 && res < sizeof(name))
>  		res = readlink_copy(buffer, buflen, name, strlen(name));
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 0ec5e4c22cb2a1066c2b897776ead6d3db72635c..d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -62,7 +62,7 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>  	if (inode) {
>  		audit_log_format(ab, " dev=");
>  		audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -		audit_log_format(ab, " ino=%lu", inode->i_ino);
> +		audit_log_format(ab, " ino=%llu", inode->i_ino);
>  	}
>  	audit_log_format(ab, " res=%d errno=%d", !result, errno);
>  	audit_log_end(ab);
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index 3f0deeb54912730d9acf5e021a4a0cb29a34e982..93fb59fbddd60b56c0b22be2a38b809ef9e18b76 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -153,7 +153,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		} else {
>  			audit_log_format(ab, " dev=? ino=?");
>  		}
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 7d623b00495c14b079e10e963c21a9f949c11f07..737f5a263a8f79416133315edf363ece3d79c722 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -202,7 +202,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  		break;
>  	}
> @@ -215,7 +215,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  		break;
>  	}
> @@ -228,7 +228,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  
>  		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
> @@ -246,7 +246,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		if (inode) {
>  			audit_log_format(ab, " dev=");
>  			audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -			audit_log_format(ab, " ino=%lu", inode->i_ino);
> +			audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		}
>  		break;
>  	}
> @@ -265,7 +265,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  		}
>  		audit_log_format(ab, " dev=");
>  		audit_log_untrustedstring(ab, inode->i_sb->s_id);
> -		audit_log_format(ab, " ino=%lu", inode->i_ino);
> +		audit_log_format(ab, " ino=%llu", inode->i_ino);
>  		rcu_read_unlock();
>  		break;
>  	}
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1ac273aac1fb52324f00b3301ae75..8f38de4d223ea59cfea6bbe73747d7b228e0c33f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1400,7 +1400,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
>  	if (rc < 0) {
>  		kfree(context);
>  		if (rc != -ENODATA) {
> -			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
> +			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%llu\n",
>  				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
>  			return rc;
>  		}
> @@ -1412,13 +1412,13 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
>  					     def_sid, GFP_NOFS);
>  	if (rc) {
>  		char *dev = inode->i_sb->s_id;
> -		unsigned long ino = inode->i_ino;
> +		u64 ino = inode->i_ino;
>  
>  		if (rc == -EINVAL) {
> -			pr_notice_ratelimited("SELinux: inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> +			pr_notice_ratelimited("SELinux: inode=%llu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
>  					      ino, dev, context);
>  		} else {
> -			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%ld\n",
> +			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%llu\n",
>  				__func__, context, -rc, dev, ino);
>  		}
>  	}
> @@ -3477,7 +3477,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  					   &newsid);
>  	if (rc) {
>  		pr_err("SELinux:  unable to map context to SID"
> -		       "for (%s, %lu), rc=%d\n",
> +		       "for (%s, %llu), rc=%d\n",
>  		       inode->i_sb->s_id, inode->i_ino, -rc);
>  		return;
>  	}
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 98af9d7b943469d0ddd344fc78c0b87ca40c16c4..2eb3368a3632b836df54ba8628c16f7215ddf3ea 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -182,7 +182,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
>  			inode->i_sb->s_id, inode->i_ino, current->comm);
>  
>  	if (rc <= 0)
> @@ -195,7 +195,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
>  
>  	smk_bu_mode(mode, acc);
>  
> -	pr_info("Smack %s: (%s %s %s) inode=(%s %ld) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) inode=(%s %llu) %s\n", smk_bu_mess[rc],
>  		tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
>  		inode->i_sb->s_id, inode->i_ino, current->comm);
>  	return 0;
> @@ -214,7 +214,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
>  			inode->i_sb->s_id, inode->i_ino, current->comm);
>  
>  	if (rc <= 0)
> @@ -223,7 +223,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
>  		rc = 0;
>  
>  	smk_bu_mode(mode, acc);
> -	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
>  		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
>  		inode->i_sb->s_id, inode->i_ino, file,
>  		current->comm);
> @@ -244,7 +244,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
>  			inode->i_sb->s_id, inode->i_ino, current->comm);
>  
>  	if (rc <= 0)
> @@ -253,7 +253,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
>  		rc = 0;
>  
>  	smk_bu_mode(mode, acc);
> -	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
>  		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
>  		inode->i_sb->s_id, inode->i_ino, file,
>  		current->comm);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

