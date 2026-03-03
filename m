Return-Path: <linux-fsdevel+bounces-79201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIb3HdzQpmntWwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:15:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC71EF2B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DB130D36ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E875494A10;
	Tue,  3 Mar 2026 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iTDQ92u9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbHT7f4K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iTDQ92u9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbHT7f4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D3649252A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537637; cv=none; b=NI3eI4h9ZP5rxPN/FRvc+nSus2hO/5njxEx3l+mw24DFWBTlJV+vFcsEEdAgRCqSDMbWlXeuR81XlFC2TrSBCoJRyX8ygTIxEIFNVAX4rgtnttwADiwGncr68Mew0OhfFe+oqWbusHohlztyoKCQdoZrwZpd9hJm2Jxs8FoYEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537637; c=relaxed/simple;
	bh=pXlgbD44yiJjz+b4T9dA/kZskAy3zSW3R3l5nS0rKE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEIu3xsGITONSNbmdJwtFmDzZWwrGmPDhDf8ZoVViKK9NhPdzdt1wimjL9txExzVMWblnx36MZdcxEfv0asT/xUFNWmqQgIGrdP1zuYPefkj02+5MbFbQ0PpT42QZNNrI6aVA5A27lpLbch/cTqTgDDWJkZON9JkLpyuKx9cf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iTDQ92u9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbHT7f4K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iTDQ92u9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbHT7f4K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7945BE01;
	Tue,  3 Mar 2026 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMmHC5tnpofLlXcYTVcJFpK5OzfQknG7AaaojvDUgik=;
	b=iTDQ92u9eNbf2ao+RuOymkmCDVw/XBW9HphQAIazIZz1kx750zvPpDHUtNTpCQETiqqSDv
	IgGus5h5MGb8bcixWgr/QBhDf0DeylI6r+9FCBYKch0yl9b6v7mz8tF+1owW/SDK/9/PRC
	gCPkD3Cub6EJtb3p9EuBql351dJygOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMmHC5tnpofLlXcYTVcJFpK5OzfQknG7AaaojvDUgik=;
	b=VbHT7f4KxCwdLDtsk4IvFQoOp05K/VV2j/FlDdKZYoBOcdhy8XPeIxZioLLCy00usoHvIk
	qpQyvVs3ARxUckDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMmHC5tnpofLlXcYTVcJFpK5OzfQknG7AaaojvDUgik=;
	b=iTDQ92u9eNbf2ao+RuOymkmCDVw/XBW9HphQAIazIZz1kx750zvPpDHUtNTpCQETiqqSDv
	IgGus5h5MGb8bcixWgr/QBhDf0DeylI6r+9FCBYKch0yl9b6v7mz8tF+1owW/SDK/9/PRC
	gCPkD3Cub6EJtb3p9EuBql351dJygOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMmHC5tnpofLlXcYTVcJFpK5OzfQknG7AaaojvDUgik=;
	b=VbHT7f4KxCwdLDtsk4IvFQoOp05K/VV2j/FlDdKZYoBOcdhy8XPeIxZioLLCy00usoHvIk
	qpQyvVs3ARxUckDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AA4D3EA6C;
	Tue,  3 Mar 2026 11:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LU99Bh7HpmnnVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:33:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE61AA0A1B; Tue,  3 Mar 2026 12:33:49 +0100 (CET)
Date: Tue, 3 Mar 2026 12:33:49 +0100
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
Subject: Re: [PATCH v2 087/110] isofs: replace PRIino with %llu/%llx format
 strings
Message-ID: <2mme4klgztb3hiutdnsp4pntmk7zf75frle4dexeuvv6f5j4ax@hn6evhnkzfx6>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-87-e5388800dae0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-87-e5388800dae0@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 20AC71EF2B6
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
	TAGGED_FROM(0.00)[bounces-79201-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
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
	RCPT_COUNT_GT_50(0.00)[172];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 15:25:11, Jeff Layton wrote:
> Now that i_ino is u64 and the PRIino format macro has been removed,
> replace all uses in isofs with the concrete format strings.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/isofs/compress.c | 2 +-
>  fs/isofs/dir.c      | 2 +-
>  fs/isofs/inode.c    | 6 +++---
>  fs/isofs/namei.c    | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index dc6c7d247cf880720be47cd26d23206d25a4e453..397568b9c7e7d3e28873be02c8a4befcddaec7b5 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -156,7 +156,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  				else {
>  					printk(KERN_DEBUG
>  					       "zisofs: zisofs_inflate returned"
> -					       " %d, inode = %" PRIino "u,"
> +					       " %d, inode = %llu,"
>  					       " page idx = %d, bh idx = %d,"
>  					       " avail_in = %ld,"
>  					       " avail_out = %ld\n",
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index 0a8f9e411c23425a6919b7a4fa3fb387eb2c3209..2fd9948d606e9c92f3003bfbaa4f0271c750a93d 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -152,7 +152,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  		    de_len < de->name_len[0] +
>  					sizeof(struct iso_directory_record)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
> -			       " in block %lu of inode %" PRIino "u\n", block,
> +			       " in block %lu of inode %llu\n", block,
>  			       inode->i_ino);
>  			brelse(bh);
>  			return -EIO;
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 678d7363e157d893e005152e64e922d9170468d0..3593e02e75fef8567643137e0ff992019d2b6fbb 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1261,7 +1261,7 @@ static int isofs_read_level3_size(struct inode *inode)
>  
>  out_toomany:
>  	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
> -		"isofs_read_level3_size: inode=%" PRIino "u\n",
> +		"isofs_read_level3_size: inode=%llu\n",
>  		__func__, inode->i_ino);
>  	goto out;
>  }
> @@ -1380,7 +1380,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
>  	/* I have no idea what file_unit_size is used for, so
>  	   we will flag it for now */
>  	if (de->file_unit_size[0] != 0) {
> -		printk(KERN_DEBUG "ISOFS: File unit size != 0 for ISO file (%" PRIino "u).\n",
> +		printk(KERN_DEBUG "ISOFS: File unit size != 0 for ISO file (%llu).\n",
>  			inode->i_ino);
>  	}
>  
> @@ -1450,7 +1450,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
>  		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
>  		init_special_inode(inode, inode->i_mode, inode->i_rdev);
>  	} else {
> -		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %" PRIino "u.\n",
> +		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %llu.\n",
>  			inode->i_mode, inode->i_ino);
>  		ret = -EIO;
>  		goto fail;
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index 494d2ae4c0955123335a97f23672b959dcc9e0bd..8dd3911717e0cc221f60fb6447e1bf26cc2223dd 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -100,7 +100,7 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
>  		/* Basic sanity check, whether name doesn't exceed dir entry */
>  		if (de_len < dlen + sizeof(struct iso_directory_record)) {
>  			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
> -			       " in block %lu of inode %" PRIino "u\n", block,
> +			       " in block %lu of inode %llu\n", block,
>  			       dir->i_ino);
>  			brelse(bh);
>  			return 0;
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

