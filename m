Return-Path: <linux-fsdevel+bounces-79191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNMqIujHpmkcTwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:37:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C71EE0EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DD8F308290C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFD43C060;
	Tue,  3 Mar 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkwxPU6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="agjLNWMi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nkwxPU6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="agjLNWMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A0430B99
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537182; cv=none; b=iIMNV68P4ZR4RVelzSre7CA+dR7dVaB3Xgo7Xws47tdg6j442AhefvzSWdjWemps4qJwV74xcyJhTq8/2Qm7ngAfbGmOuL3kFOu1Od2YxSw8O+jLTpzMmySnRfkG9LAgCRr3tP86KUa7I4+uyCNk+cMRWuJKkCECSTNkuaTwhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537182; c=relaxed/simple;
	bh=MyGKJIIkngRluztSuoDnbek1ekwuNzPi1l/Etn8shCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7+viL0R3/tmwaBXoKlSwFnVhWROaVujYzXZx6/8BExJWr3KHs33OATZoq5m5vTYNz0QyHUd+XuFuJpw6SsIfI16pJ5JqztwajjommLcGhQF71lnsnzhPyfI/pGDkcpz8r7l/kgdp5ErxuJr5qn/cQqXy+599gHaDNQSYdFT2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkwxPU6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=agjLNWMi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nkwxPU6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=agjLNWMi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 430C23F778;
	Tue,  3 Mar 2026 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPu8XPuDlU1g9pC+BD612SKMgab6QY4hhTylugDlyzw=;
	b=nkwxPU6f/8r94zxGc4RXWbdDzA6AH42XX//Xsss6YCxStp0x2EcOr0GsBuSmRyKCliLMNC
	33kSvTr/ut+H6ayhMqYeTdK3NFYWWb4fo7LpP8U5eO3+VvW3rrMLpyl6x9zanAM0NlTtEe
	35vwx1OUEh1rL8GgkX/OzITY8DEMdwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPu8XPuDlU1g9pC+BD612SKMgab6QY4hhTylugDlyzw=;
	b=agjLNWMibMrxLGF3Fa07k6aUsfYIAWz4Au/CjhQcIFoZ6f1qcU8rerzkKEteqvTexnsZJk
	/gGscWX4ng0HaUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPu8XPuDlU1g9pC+BD612SKMgab6QY4hhTylugDlyzw=;
	b=nkwxPU6f/8r94zxGc4RXWbdDzA6AH42XX//Xsss6YCxStp0x2EcOr0GsBuSmRyKCliLMNC
	33kSvTr/ut+H6ayhMqYeTdK3NFYWWb4fo7LpP8U5eO3+VvW3rrMLpyl6x9zanAM0NlTtEe
	35vwx1OUEh1rL8GgkX/OzITY8DEMdwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPu8XPuDlU1g9pC+BD612SKMgab6QY4hhTylugDlyzw=;
	b=agjLNWMibMrxLGF3Fa07k6aUsfYIAWz4Au/CjhQcIFoZ6f1qcU8rerzkKEteqvTexnsZJk
	/gGscWX4ng0HaUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E4313EA6D;
	Tue,  3 Mar 2026 11:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kilBC1fFpmkbTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:26:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0715A0A1B; Tue,  3 Mar 2026 12:26:14 +0100 (CET)
Date: Tue, 3 Mar 2026 12:26:14 +0100
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
Subject: Re: [PATCH v2 040/110] ocfs2: use PRIino format for i_ino
Message-ID: <ssizzrk2zdfrfzppx75xewimgzg5rd3ofunrxa2vvrh5fmroul@rntxparm3irs>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-40-e5388800dae0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-40-e5388800dae0@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 006C71EE0EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79191-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
 g];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

On Mon 02-03-26 15:24:24, Jeff Layton wrote:
> Convert ocfs2 i_ino format strings to use the PRIino format
> macro in preparation for the widening of i_ino via kino_t.
> 
> Remove now-unnecessary (unsigned long) casts on i_ino.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/alloc.c        |  2 +-
>  fs/ocfs2/aops.c         |  4 ++--
>  fs/ocfs2/dir.c          |  8 ++++----
>  fs/ocfs2/dlmfs/dlmfs.c  | 10 +++++-----
>  fs/ocfs2/extent_map.c   | 12 ++++++------
>  fs/ocfs2/inode.c        |  2 +-
>  fs/ocfs2/quota_local.c  |  2 +-
>  fs/ocfs2/refcounttree.c | 10 +++++-----
>  fs/ocfs2/xattr.c        |  4 ++--
>  9 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 344fd4d95fbc8bd7a749e9d51d31b5682ff030d0..d7703549645b548d9f5d77b2214a9a7c0af0ef6f 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -7318,7 +7318,7 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
>  		 * to check it up here before changing the tree.
>  		*/
>  		if (root_el->l_tree_depth && rec->e_int_clusters == 0) {
> -			mlog(ML_ERROR, "Inode %lu has an empty "
> +			mlog(ML_ERROR, "Inode %" PRIino "u has an empty "
>  				    "extent record, depth %u\n", inode->i_ino,
>  				    le16_to_cpu(root_el->l_tree_depth));
>  			status = ocfs2_remove_rightmost_empty_extent(osb,
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 17ba79f443ee736cb5225702c57d13f4019f3c52..aea35b1c9fa3ce7327672c1862d0d1201c895c40 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -137,7 +137,7 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
>  			      (unsigned long long)iblock, bh_result, create);
>  
>  	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE)
> -		mlog(ML_NOTICE, "get_block on system inode 0x%p (%lu)\n",
> +		mlog(ML_NOTICE, "get_block on system inode 0x%p (%" PRIino "u)\n",
>  		     inode, inode->i_ino);
>  
>  	if (S_ISLNK(inode->i_mode)) {
> @@ -2146,7 +2146,7 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
>  	    ((iblock + ((len - 1) >> i_blkbits)) > endblk))
>  		len = (endblk - iblock + 1) << i_blkbits;
>  
> -	mlog(0, "get block of %lu at %llu:%u req %u\n",
> +	mlog(0, "get block of %" PRIino "u at %llu:%u req %u\n",
>  			inode->i_ino, pos, len, total_len);
>  
>  	/*
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index 1c8abf2c592caacbe734d49254b04d507925c9d1..eecb2b1d2ec17fb4b3f09abb9e168d2f28f9b420 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -794,7 +794,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  	if (le16_to_cpu(el->l_count) !=
>  	    ocfs2_extent_recs_per_dx_root(inode->i_sb)) {
>  		ret = ocfs2_error(inode->i_sb,
> -				  "Inode %lu has invalid extent list length %u\n",
> +				  "Inode %" PRIino "u has invalid extent list length %u\n",
>  				  inode->i_ino, le16_to_cpu(el->l_count));
>  		goto out;
>  	}
> @@ -812,7 +812,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ret = ocfs2_error(inode->i_sb,
> -					  "Inode %lu has non zero tree depth in btree tree block %llu\n",
> +					  "Inode %" PRIino "u has non zero tree depth in btree tree block %llu\n",
>  					  inode->i_ino,
>  					  (unsigned long long)eb_bh->b_blocknr);
>  			goto out;
> @@ -821,7 +821,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  
>  	if (le16_to_cpu(el->l_next_free_rec) == 0) {
>  		ret = ocfs2_error(inode->i_sb,
> -				  "Inode %lu has empty extent list at depth %u\n",
> +				  "Inode %" PRIino "u has empty extent list at depth %u\n",
>  				  inode->i_ino,
>  				  le16_to_cpu(el->l_tree_depth));
>  		goto out;
> @@ -839,7 +839,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
>  
>  	if (!found) {
>  		ret = ocfs2_error(inode->i_sb,
> -				  "Inode %lu has bad extent record (%u, %u, 0) in btree\n",
> +				  "Inode %" PRIino "u has bad extent record (%u, %u, 0) in btree\n",
>  				  inode->i_ino,
>  				  le32_to_cpu(rec->e_cpos),
>  				  ocfs2_rec_clusters(el, rec));
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 45cce261da65cab7ef48b5b88c0de5d41fa57615..e96c1c574ff7dc3dffad58ce8536b7e337d3f6fa 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -123,7 +123,7 @@ static int dlmfs_file_open(struct inode *inode,
>  	if (S_ISDIR(inode->i_mode))
>  		BUG();
>  
> -	mlog(0, "open called on inode %lu, flags 0x%x\n", inode->i_ino,
> +	mlog(0, "open called on inode %" PRIino "u, flags 0x%x\n", inode->i_ino,
>  		file->f_flags);
>  
>  	status = dlmfs_decode_open_flags(file->f_flags, &level, &flags);
> @@ -170,7 +170,7 @@ static int dlmfs_file_release(struct inode *inode,
>  	if (S_ISDIR(inode->i_mode))
>  		BUG();
>  
> -	mlog(0, "close called on inode %lu\n", inode->i_ino);
> +	mlog(0, "close called on inode %" PRIino "u\n", inode->i_ino);
>  
>  	if (fp) {
>  		level = fp->fp_lock_level;
> @@ -242,7 +242,7 @@ static ssize_t dlmfs_file_write(struct file *filp,
>  	int bytes_left;
>  	struct inode *inode = file_inode(filp);
>  
> -	mlog(0, "inode %lu, count = %zu, *ppos = %llu\n",
> +	mlog(0, "inode %" PRIino "u, count = %zu, *ppos = %llu\n",
>  		inode->i_ino, count, *ppos);
>  
>  	if (*ppos >= DLM_LVB_LEN)
> @@ -301,7 +301,7 @@ static void dlmfs_evict_inode(struct inode *inode)
>  
>  	clear_inode(inode);
>  
> -	mlog(0, "inode %lu\n", inode->i_ino);
> +	mlog(0, "inode %" PRIino "u\n", inode->i_ino);
>  
>  	ip = DLMFS_I(inode);
>  	lockres = &ip->ip_lockres;
> @@ -490,7 +490,7 @@ static int dlmfs_unlink(struct inode *dir,
>  	int status;
>  	struct inode *inode = d_inode(dentry);
>  
> -	mlog(0, "unlink inode %lu\n", inode->i_ino);
> +	mlog(0, "unlink inode %" PRIino "u\n", inode->i_ino);
>  
>  	/* if there are no current holders, or none that are waiting
>  	 * to acquire a lock, this basically destroys our lockres. */
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index d68229422dda3423971d7ab0e9a4335acab8b344..3cf93a08f7a8946810ccd2de246be4d07a23b53b 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -291,7 +291,7 @@ static int ocfs2_last_eb_is_empty(struct inode *inode,
>  
>  	if (el->l_tree_depth) {
>  		ocfs2_error(inode->i_sb,
> -			    "Inode %lu has non zero tree depth in leaf block %llu\n",
> +			    "Inode %" PRIino "u has non zero tree depth in leaf block %llu\n",
>  			    inode->i_ino,
>  			    (unsigned long long)eb_bh->b_blocknr);
>  		ret = -EROFS;
> @@ -427,7 +427,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ocfs2_error(inode->i_sb,
> -				    "Inode %lu has non zero tree depth in leaf block %llu\n",
> +				    "Inode %" PRIino "u has non zero tree depth in leaf block %llu\n",
>  				    inode->i_ino,
>  				    (unsigned long long)eb_bh->b_blocknr);
>  			ret = -EROFS;
> @@ -437,7 +437,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  
>  	if (le16_to_cpu(el->l_next_free_rec) > le16_to_cpu(el->l_count)) {
>  		ocfs2_error(inode->i_sb,
> -			    "Inode %lu has an invalid extent (next_free_rec %u, count %u)\n",
> +			    "Inode %" PRIino "u has an invalid extent (next_free_rec %u, count %u)\n",
>  			    inode->i_ino,
>  			    le16_to_cpu(el->l_next_free_rec),
>  			    le16_to_cpu(el->l_count));
> @@ -472,7 +472,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  
>  	if (!rec->e_blkno) {
>  		ocfs2_error(inode->i_sb,
> -			    "Inode %lu has bad extent record (%u, %u, 0)\n",
> +			    "Inode %" PRIino "u has bad extent record (%u, %u, 0)\n",
>  			    inode->i_ino,
>  			    le32_to_cpu(rec->e_cpos),
>  			    ocfs2_rec_clusters(el, rec));
> @@ -561,7 +561,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
>  
>  		if (el->l_tree_depth) {
>  			ocfs2_error(inode->i_sb,
> -				    "Inode %lu has non zero tree depth in xattr leaf block %llu\n",
> +				    "Inode %" PRIino "u has non zero tree depth in xattr leaf block %llu\n",
>  				    inode->i_ino,
>  				    (unsigned long long)eb_bh->b_blocknr);
>  			ret = -EROFS;
> @@ -580,7 +580,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
>  
>  		if (!rec->e_blkno) {
>  			ocfs2_error(inode->i_sb,
> -				    "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
> +				    "Inode %" PRIino "u has bad extent record (%u, %u, 0) in xattr\n",
>  				    inode->i_ino,
>  				    le32_to_cpu(rec->e_cpos),
>  				    ocfs2_rec_clusters(el, rec));
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 03a51662ea8e79f7a64fcd320b974f954b2ea8bf..c3076b450de3599291c386ceeb8b2d26e8680904 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1196,7 +1196,7 @@ static void ocfs2_clear_inode(struct inode *inode)
>  				inode->i_nlink);
>  
>  	mlog_bug_on_msg(osb == NULL,
> -			"Inode=%lu\n", inode->i_ino);
> +			"Inode=%" PRIino "u\n", inode->i_ino);
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
> index c1cdececdfa4ef51a1bd3a5addad734b324b92c0..1586c42fdabe70056bf7f103d583dd9000fe9510 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -2341,7 +2341,7 @@ static int ocfs2_mark_extent_refcounted(struct inode *inode,
>  					   cpos, len, phys);
>  
>  	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
> -		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
> +		ret = ocfs2_error(inode->i_sb, "Inode %" PRIino "u want to use refcount tree, but the feature bit is not set in the super block\n",
>  				  inode->i_ino);
>  		goto out;
>  	}
> @@ -2524,7 +2524,7 @@ int ocfs2_prepare_refcount_change_for_del(struct inode *inode,
>  	u64 start_cpos = ocfs2_blocks_to_clusters(inode->i_sb, phys_blkno);
>  
>  	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
> -		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
> +		ret = ocfs2_error(inode->i_sb, "Inode %" PRIino "u want to use refcount tree, but the feature bit is not set in the super block\n",
>  				  inode->i_ino);
>  		goto out;
>  	}
> @@ -2650,7 +2650,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ret = ocfs2_error(inode->i_sb,
> -					  "Inode %lu has non zero tree depth in leaf block %llu\n",
> +					  "Inode %" PRIino "u has non zero tree depth in leaf block %llu\n",
>  					  inode->i_ino,
>  					  (unsigned long long)eb_bh->b_blocknr);
>  			goto out;
> @@ -2662,7 +2662,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
>  		rec = &el->l_recs[i];
>  
>  		if (ocfs2_is_empty_extent(rec)) {
> -			mlog_bug_on_msg(i != 0, "Inode %lu has empty record in "
> +			mlog_bug_on_msg(i != 0, "Inode %" PRIino "u has empty record in "
>  					"index %d\n", inode->i_ino, i);
>  			continue;
>  		}
> @@ -3325,7 +3325,7 @@ static int ocfs2_replace_cow(struct ocfs2_cow_context *context)
>  	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>  
>  	if (!ocfs2_refcount_tree(osb)) {
> -		return ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
> +		return ocfs2_error(inode->i_sb, "Inode %" PRIino "u want to use refcount tree, but the feature bit is not set in the super block\n",
>  				   inode->i_ino);
>  	}
>  
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 42ee5db362d3eb6df886d6721dd7398b8aca8cdb..74cd6dd57abf71a69adef18863d057e48496ccfe 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -3741,7 +3741,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
>  
>  		if (el->l_tree_depth) {
>  			ret = ocfs2_error(inode->i_sb,
> -					  "Inode %lu has non zero tree depth in xattr tree block %llu\n",
> +					  "Inode %" PRIino "u has non zero tree depth in xattr tree block %llu\n",
>  					  inode->i_ino,
>  					  (unsigned long long)eb_bh->b_blocknr);
>  			goto out;
> @@ -3758,7 +3758,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
>  	}
>  
>  	if (!e_blkno) {
> -		ret = ocfs2_error(inode->i_sb, "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
> +		ret = ocfs2_error(inode->i_sb, "Inode %" PRIino "u has bad extent record (%u, %u, 0) in xattr\n",
>  				  inode->i_ino,
>  				  le32_to_cpu(rec->e_cpos),
>  				  ocfs2_rec_clusters(el, rec));
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

