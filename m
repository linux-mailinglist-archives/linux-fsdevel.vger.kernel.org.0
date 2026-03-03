Return-Path: <linux-fsdevel+bounces-79190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKxBE1POpmntWQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:04:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21A1EEF0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E9B320156E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B0426EC9;
	Tue,  3 Mar 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cp2wGG3b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FY1dH1mO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cp2wGG3b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FY1dH1mO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5847B43D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537111; cv=none; b=pr8R3BoUagAXnuufZUbVw32ltFyEz82J2DOx9ZfqdDxGjirmKV/e6mzvui43osKyotZlPJKk9B1dIXMOOFHNQYNv7bcNfXu7kiJ92uRepGf3ayfUH7JS/9LNV47gzDs0iQP5Cc1mkNOPylswfZfbPFZpakcfzWsEuQ/ZE8DvExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537111; c=relaxed/simple;
	bh=32GJ8u9HbbkRJtxXtFN1zR28g9LVlC7wBdT5OEdf8+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0qmF2s6OdMv+wbbaIXJFZw4wG32Mh0ZMA/oNaNGX+S1DG1j7qwITye/7wMzsO/dvnzqoFhGLj9OToZs30LbpEuExs0zk5azpHQY2wjXFfhzja7SYpNdHBcEBl6ysCyqbqpp0eC04jGgeKt95vv1N7nRyC9EQI6FId8sTVCydZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cp2wGG3b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FY1dH1mO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cp2wGG3b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FY1dH1mO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9425A3F944;
	Tue,  3 Mar 2026 11:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YxnSO6wYqIgHlG99vcTIcGeXP4duMd7Ux36r4Q1ofk=;
	b=cp2wGG3bRJKiUYN68nRpyBn77MC8reO7VI0NDbMUH6Gavvlj+c5tRTwOFIqiPnWjX0Qwjw
	RW+zrIQPbA+KbSu++nhAT81fG5esOebAI7zXOMKcR/GP/zZkW7LEAhJ3bGMOz6iqfFeDkU
	p6Dj8reQ+EQ+Mps44OzpOJ4Th4tYT6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YxnSO6wYqIgHlG99vcTIcGeXP4duMd7Ux36r4Q1ofk=;
	b=FY1dH1mOn/Pqm+1fJQmhvM5A1inXBqPa+uljfNfdnSMdwhQWodNFFBHl9VOeyBBhRfZvet
	42ntbDXFRTWgP0AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cp2wGG3b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FY1dH1mO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YxnSO6wYqIgHlG99vcTIcGeXP4duMd7Ux36r4Q1ofk=;
	b=cp2wGG3bRJKiUYN68nRpyBn77MC8reO7VI0NDbMUH6Gavvlj+c5tRTwOFIqiPnWjX0Qwjw
	RW+zrIQPbA+KbSu++nhAT81fG5esOebAI7zXOMKcR/GP/zZkW7LEAhJ3bGMOz6iqfFeDkU
	p6Dj8reQ+EQ+Mps44OzpOJ4Th4tYT6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YxnSO6wYqIgHlG99vcTIcGeXP4duMd7Ux36r4Q1ofk=;
	b=FY1dH1mOn/Pqm+1fJQmhvM5A1inXBqPa+uljfNfdnSMdwhQWodNFFBHl9VOeyBBhRfZvet
	42ntbDXFRTWgP0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F1A63EA6E;
	Tue,  3 Mar 2026 11:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7IHHw7FpmkfSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:25:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3474FA0A1B; Tue,  3 Mar 2026 12:25:02 +0100 (CET)
Date: Tue, 3 Mar 2026 12:25:02 +0100
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
Subject: Re: [PATCH v2 037/110] minix: use PRIino format for i_ino
Message-ID: <kywopfbqsllo7hy75okmrpljpjppknqbqk26hl4lp7vzspif6w@vs2n3nni4vda>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-37-e5388800dae0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-37-e5388800dae0@kernel.org>
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spam-Level: 
X-Rspamd-Queue-Id: DC21A1EEF0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79190-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vaf.va:url];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
 g];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Mon 02-03-26 15:24:21, Jeff Layton wrote:
> Convert minix i_ino format strings to use the PRIino format
> macro in preparation for the widening of i_ino via kino_t.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/minix/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index 99541c6a5bbf13f3be27474a316b31d8db9fbce0..d92059227d273564c86f100dea3366be4509090b 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -36,7 +36,7 @@ void __minix_error_inode(struct inode *inode, const char *function,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	printk(KERN_CRIT "minix-fs error (device %s): %s:%d: "
> -	       "inode #%lu: comm %s: %pV\n",
> +	       "inode #%" PRIino "u: comm %s: %pV\n",
>  	       inode->i_sb->s_id, function, line, inode->i_ino,
>  	       current->comm, &vaf);
>  	va_end(args);
> @@ -520,7 +520,7 @@ void minix_set_inode(struct inode *inode, dev_t rdev)
>  		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>  		init_special_inode(inode, inode->i_mode, rdev);
>  	} else {
> -		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "MINIX-fs: Invalid file type 0%04o for inode %" PRIino "u.\n",
>  		       inode->i_mode, inode->i_ino);
>  		make_bad_inode(inode);
>  	}
> @@ -542,7 +542,7 @@ static struct inode *V1_minix_iget(struct inode *inode)
>  		return ERR_PTR(-EIO);
>  	}
>  	if (raw_inode->i_nlinks == 0) {
> -		printk("MINIX-fs: deleted inode referenced: %lu\n",
> +		printk("MINIX-fs: deleted inode referenced: %" PRIino "u\n",
>  		       inode->i_ino);
>  		brelse(bh);
>  		iget_failed(inode);
> @@ -580,7 +580,7 @@ static struct inode *V2_minix_iget(struct inode *inode)
>  		return ERR_PTR(-EIO);
>  	}
>  	if (raw_inode->i_nlinks == 0) {
> -		printk("MINIX-fs: deleted inode referenced: %lu\n",
> +		printk("MINIX-fs: deleted inode referenced: %" PRIino "u\n",
>  		       inode->i_ino);
>  		brelse(bh);
>  		iget_failed(inode);
> @@ -692,7 +692,7 @@ static int minix_write_inode(struct inode *inode, struct writeback_control *wbc)
>  	if (wbc->sync_mode == WB_SYNC_ALL && buffer_dirty(bh)) {
>  		sync_dirty_buffer(bh);
>  		if (buffer_req(bh) && !buffer_uptodate(bh)) {
> -			printk("IO error syncing minix inode [%s:%08lx]\n",
> +			printk("IO error syncing minix inode [%s:%08" PRIino "x]\n",
>  				inode->i_sb->s_id, inode->i_ino);
>  			err = -EIO;
>  		}
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

