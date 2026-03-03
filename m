Return-Path: <linux-fsdevel+bounces-79206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDvXHpTRpmnHWgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:18:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD31EF397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C963047058
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33A3D5654;
	Tue,  3 Mar 2026 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqVsy1dC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nS4StdiC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/VMDDhS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IavhWDx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177A42F544
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537862; cv=none; b=DMzlM5QzxdrolVAk8T4+vNsELN+cVTp7GSWIwFNKgPaxCLjwV3CYQBe0ut3prw9VUJm3/bBVPUtAZCXDpcuUjLsxSq/STnPy+HxoPTJS3dv0sk1Fl99E5AKj+V+rKfK6/Q8Dxznc5wrQZ3NxdFAN3prcdyjcWmnXnnHT/BR4akY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537862; c=relaxed/simple;
	bh=epvFymGdRxyCTFhbjbGVKU+K28MOGRZ9+cHvDcHmyes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5ITU6Zzxb6d7YEkHxCG5sJsi//DqaP1V7JHnSELwQETWvyM7eAXnTPu/76g1yY2fzyXMS9m1cuVOXW+FZrV9TxNcxE31Qr05kesex+fcj0rlGKf6NamRknGVpIc0UU1PUTOTolJSoUuFYXcbKy0wkukh/A9yucbUSNwWM5Ysgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqVsy1dC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nS4StdiC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/VMDDhS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IavhWDx2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7B2E5BE0C;
	Tue,  3 Mar 2026 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
	b=XqVsy1dC2pHASguU1+KG2xYt/C1RmmixP+foKebQnBFh94XXH2eBDNNRgkhBYFosP4SRw0
	Y2V1Hlo/oo9DjO4GgqgbNtsyEvkdAvdbDG01buwc8Mo6oGH3K8WtfzgYTCR9d67SpVFusc
	mYsypXpN4Zztuo2xJNuos8B4YHYRO3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
	b=nS4StdiCHIdwNQO7HJ67ZmoCUvZNuJFAEH5ylMW56e+tRTkYRzi9O/tibKaBvAnzCAj/jd
	qj0PEnMXcT+Zt+DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="s/VMDDhS";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IavhWDx2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
	b=s/VMDDhSu6BZiztym6Ch+Vqn+dEYit5a+K9wld20IQPyPF0MfkQcPZbt1JXN5C9+h4qCLh
	ID6Zk7+HSAG4ZSjD2n1LEFqMuhKE2VZbDLeUc7OveJVNc7A4UGQVRL1slSpb+r6q19pEpE
	n5vVxWbmt5mSZQVZox7T5gtS/fcza38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
	b=IavhWDx2Kh3DHq1zANsSVI/WiJB5RbdvrN53jtu4s07STfLomCtQ+AyQtB77CtfxuNuELQ
	WJjg27+5hANJ3lDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5E913EA69;
	Tue,  3 Mar 2026 11:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u59NMAHIpml5WAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:37:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86E9EA0A1B; Tue,  3 Mar 2026 12:37:29 +0100 (CET)
Date: Tue, 3 Mar 2026 12:37:29 +0100
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
Subject: Re: [PATCH v2 110/110] vfs: remove kino_t typedef and PRIino format
 macro
Message-ID: <rallmd55miopcn5jdtzd33ez5udz2haadugzu7vaqxvv2udhje@i73uyn62zwyp>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-110-e5388800dae0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-110-e5388800dae0@kernel.org>
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E8FD31EF397
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
	TAGGED_FROM(0.00)[bounces-79206-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:dkim,suse.cz:email];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 15:25:34, Jeff Layton wrote:
> Now that i_ino has been widened to u64, replace the kino_t typedef with
> u64 and the PRIino format macro with the concrete format strings.
> 
> Replace the remaining PRIino uses throughout the tree, and remove the
> typedef and #define from include/linux/fs.h. Change the i_ino field in
> struct inode from kino_t to u64.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c        |  4 ++--
>  fs/eventpoll.c     |  2 +-
>  fs/fserror.c       |  2 +-
>  fs/inode.c         | 10 +++++-----
>  fs/locks.c         |  6 +++---
>  fs/nsfs.c          |  4 ++--
>  fs/pipe.c          |  2 +-
>  include/linux/fs.h |  5 +----
>  8 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 13fb3e89cba7442c9bed74c41ca18be5e43e28c9..9ceab142896f6631017067890fd1079240448e13 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1637,11 +1637,11 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
>  	if (dentry == _data && dentry->d_lockref.count == 1)
>  		return D_WALK_CONTINUE;
>  
> -	WARN(1, "BUG: Dentry %p{i=%" PRIino "x,n=%pd} "
> +	WARN(1, "BUG: Dentry %p{i=%llx,n=%pd} "
>  			" still in use (%d) [unmount of %s %s]\n",
>  		       dentry,
>  		       dentry->d_inode ?
> -		       dentry->d_inode->i_ino : (kino_t)0,
> +		       dentry->d_inode->i_ino : (u64)0,
>  		       dentry,
>  		       dentry->d_lockref.count,
>  		       dentry->d_sb->s_type->name,
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 90fd92425492221d13bd0cf067d47579bb407a01..4ccd4d2e31adf571f939d2e777123e40302e565f 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1080,7 +1080,7 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
>  		struct inode *inode = file_inode(epi->ffd.file);
>  
>  		seq_printf(m, "tfd: %8d events: %8x data: %16llx "
> -			   " pos:%lli ino:%" PRIino "x sdev:%x\n",
> +			   " pos:%lli ino:%llx sdev:%x\n",
>  			   epi->ffd.fd, epi->event.events,
>  			   (long long)epi->event.data,
>  			   (long long)epi->ffd.file->f_pos,
> diff --git a/fs/fserror.c b/fs/fserror.c
> index b685b329b5956a639c41b25c42cfff16e6e5ab6e..1e4d11fd9562fd158a23b64ca60e9b7e01719cb8 100644
> --- a/fs/fserror.c
> +++ b/fs/fserror.c
> @@ -176,7 +176,7 @@ void fserror_report(struct super_block *sb, struct inode *inode,
>  lost:
>  	if (inode)
>  		pr_err_ratelimited(
> - "%s: lost file I/O error report for ino %" PRIino "u type %u pos 0x%llx len 0x%llx error %d",
> + "%s: lost file I/O error report for ino %llu type %u pos 0x%llx len 0x%llx error %d",
>  		       sb->s_id, inode->i_ino, type, pos, len, error);
>  	else
>  		pr_err_ratelimited(
> diff --git a/fs/inode.c b/fs/inode.c
> index 24ab9fa10baf7c885244f23bfccd731efe4a14cc..5ad169d51728c260aeaabb810e59eb3ec1d1ce52 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -726,7 +726,7 @@ void dump_mapping(const struct address_space *mapping)
>  	struct dentry *dentry_ptr;
>  	struct dentry dentry;
>  	char fname[64] = {};
> -	kino_t ino;
> +	u64 ino;
>  
>  	/*
>  	 * If mapping is an invalid pointer, we don't want to crash
> @@ -750,14 +750,14 @@ void dump_mapping(const struct address_space *mapping)
>  	}
>  
>  	if (!dentry_first) {
> -		pr_warn("aops:%ps ino:%" PRIino "x\n", a_ops, ino);
> +		pr_warn("aops:%ps ino:%llx\n", a_ops, ino);
>  		return;
>  	}
>  
>  	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
>  	if (get_kernel_nofault(dentry, dentry_ptr) ||
>  	    !dentry.d_parent || !dentry.d_name.name) {
> -		pr_warn("aops:%ps ino:%" PRIino "x invalid dentry:%px\n",
> +		pr_warn("aops:%ps ino:%llx invalid dentry:%px\n",
>  				a_ops, ino, dentry_ptr);
>  		return;
>  	}
> @@ -768,7 +768,7 @@ void dump_mapping(const struct address_space *mapping)
>  	 * Even if strncpy_from_kernel_nofault() succeeded,
>  	 * the fname could be unreliable
>  	 */
> -	pr_warn("aops:%ps ino:%" PRIino "x dentry name(?):\"%s\"\n",
> +	pr_warn("aops:%ps ino:%llx dentry name(?):\"%s\"\n",
>  		a_ops, ino, fname);
>  }
>  
> @@ -2641,7 +2641,7 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
>  		/* leave it no_open_fops */
>  		break;
>  	default:
> -		pr_debug("init_special_inode: bogus i_mode (%o) for inode %s:%" PRIino "u\n",
> +		pr_debug("init_special_inode: bogus i_mode (%o) for inode %s:%llu\n",
>  			 mode, inode->i_sb->s_id, inode->i_ino);
>  		break;
>  	}
> diff --git a/fs/locks.c b/fs/locks.c
> index 9c5aa23f09b6e061dc94c81cd802bb65dd0053c1..d8b066fb42108971f6b3c7449dbc9b5f8df16b13 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -234,7 +234,7 @@ locks_check_ctx_lists(struct inode *inode)
>  	if (unlikely(!list_empty(&ctx->flc_flock) ||
>  		     !list_empty(&ctx->flc_posix) ||
>  		     !list_empty(&ctx->flc_lease))) {
> -		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%" PRIino "x:\n",
> +		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%llx:\n",
>  			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
>  			inode->i_ino);
>  		locks_dump_ctx_list(&ctx->flc_flock, "FLOCK");
> @@ -251,7 +251,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list, char *list_
>  
>  	list_for_each_entry(flc, list, flc_list)
>  		if (flc->flc_file == filp)
> -			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%" PRIino "x "
> +			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%llx "
>  				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
>  				list_type, MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino,
> @@ -2896,7 +2896,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
>  			     (type == F_RDLCK) ? "READ" : "UNLCK");
>  	if (inode) {
>  		/* userspace relies on this representation of dev_t */
> -		seq_printf(f, "%d %02x:%02x:%" PRIino "u ", pid,
> +		seq_printf(f, "%d %02x:%02x:%llu ", pid,
>  				MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino);
>  	} else {
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 0e099ee2121f8831645c3a25d759793ef2ff9ce6..eac326b85314ac8080248347154d599c953969c7 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -46,7 +46,7 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
>  	struct ns_common *ns = inode->i_private;
>  	const struct proc_ns_operations *ns_ops = ns->ops;
>  
> -	return dynamic_dname(buffer, buflen, "%s:[%" PRIino "u]",
> +	return dynamic_dname(buffer, buflen, "%s:[%llu]",
>  		ns_ops->name, inode->i_ino);
>  }
>  
> @@ -394,7 +394,7 @@ static int nsfs_show_path(struct seq_file *seq, struct dentry *dentry)
>  	const struct ns_common *ns = inode->i_private;
>  	const struct proc_ns_operations *ns_ops = ns->ops;
>  
> -	seq_printf(seq, "%s:[%" PRIino "u]", ns_ops->name, inode->i_ino);
> +	seq_printf(seq, "%s:[%llu]", ns_ops->name, inode->i_ino);
>  	return 0;
>  }
>  
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 311928e8713989747605fd79f653e36d27ce8c0e..9841648c9cf3e8e569cf6ba5c792624fe92396f5 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -873,7 +873,7 @@ static struct vfsmount *pipe_mnt __ro_after_init;
>   */
>  static char *pipefs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> -	return dynamic_dname(buffer, buflen, "pipe:[%" PRIino "u]",
> +	return dynamic_dname(buffer, buflen, "pipe:[%llu]",
>  				d_inode(dentry)->i_ino);
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4193817e02e8bf94f29514ca43379af21f37ac61..097443bf12e289c347651e5f3da5b67eb6b53121 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -758,9 +758,6 @@ struct inode_state_flags {
>  	enum inode_state_flags_enum __state;
>  };
>  
> -typedef u64		kino_t;
> -#define PRIino		"ll"
> -
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -786,7 +783,7 @@ struct inode {
>  #endif
>  
>  	/* Stat data, not accessed from path walking */
> -	kino_t			i_ino;
> +	u64			i_ino;
>  	/*
>  	 * Filesystems may only read i_nlink directly.  They shall use the
>  	 * following functions for modification:
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

