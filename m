Return-Path: <linux-fsdevel+bounces-79197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JcfLFLMpmnIVgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:56:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5D1EEBBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D7DF313119A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441D426D02;
	Tue,  3 Mar 2026 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGMP3Fua";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gYg3DK9w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFD+ObzG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jINa2YgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327348A2D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537532; cv=none; b=HzDnDbuDs1IkhVHzse2NXbsUPYV/wFFG1AZ3oviMpc3Fd6N9MudFlfPcLVnzfTERUgk7lk5/IKMQSVTXWV+R/jBw5gk7oK/2lSNhIBKQ1ArN/6C6W0nNSTvYuvZhONnAptSEE1jP9UopQU0PPeEl7ZJ70rH2g+avT6Y1VL3Ng3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537532; c=relaxed/simple;
	bh=ynqZIEdsmnksAp+Cm2jKyEanqimmQJ7OUe2VulEAlt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEtk2w28OtmmaQrGwar256Ab9zLWFmatbWQwxPRhl5+6TYqoanu/dNEr+kFMHiGQ+TlxkOZUSNy3vE3OlR7p+TPh1lpGhgbkhLjkgCqAPqHpYmjUv+n07NgmgR/6Uf/OY+kvUNGuCY4ZYzTukXxJV/76lfMNg4lpwGAB6a4F+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGMP3Fua; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gYg3DK9w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFD+ObzG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jINa2YgC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFFB05BDF7;
	Tue,  3 Mar 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4fOwIc0ovDkc/g3pj5jFg3I84S54+Ht/E0+y1rbegk=;
	b=yGMP3FualJ6bzkamSeXAwiXLkhzpzDLcjwQ2hMUEGaXLNg0seeaLrJtKxg0CQpTsks/ht8
	HPiwd7EhBzXzg3Tg0mQH/U9O1Rb4f307op+Iu/Dl4aX4qH0hMhKe/Lcgu5A9eeWlrmviwh
	SaOU3Ivb6OQfby4t/E3NWtrVh2J+pVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4fOwIc0ovDkc/g3pj5jFg3I84S54+Ht/E0+y1rbegk=;
	b=gYg3DK9wmKOGVMps+U190ws27dNnp3JdnYNzSmvqxXTmTNXMwS0XiqLlIN8U6CNpGE2xYR
	EIkfUuT0QsGFW/BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EFD+ObzG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jINa2YgC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772537515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4fOwIc0ovDkc/g3pj5jFg3I84S54+Ht/E0+y1rbegk=;
	b=EFD+ObzGW4YZUbeM4p47Wk7DPa58y/Ct+S2m6zRhEQteSLrodCG/lGO80ayRsehj7H5XKd
	/8HHvpfqML91Qz04uEQyQACEBDZ6T1YHSfzb75q4saOs+Bf5De7F1tw6LnEXveedTkltYf
	0dmoqlu4s3stMTqTyaxIAS1Nyjd0bJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772537515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4fOwIc0ovDkc/g3pj5jFg3I84S54+Ht/E0+y1rbegk=;
	b=jINa2YgC5csBVDfDYUnfzvm+Dd3KCywMMyxI4H5Yg4oV2b9/Ahfzx4HljQEMBDLRTasvib
	rMzVwb0HL0zIX6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B98C23EA6E;
	Tue,  3 Mar 2026 11:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tjtGLavGpmmOUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:31:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6EE6BA0A1B; Tue,  3 Mar 2026 12:31:55 +0100 (CET)
Date: Tue, 3 Mar 2026 12:31:55 +0100
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
Subject: Re: [PATCH v2 061/110] ext4: replace PRIino with %llu/%llx format
 strings
Message-ID: <cs3y5xexe73t5zutcxsbu73s2n3guc2jr55ivuhw4mdoe2d3mt@p2qwwv6ngbfz>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-61-e5388800dae0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-61-e5388800dae0@kernel.org>
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0BA5D1EEBBB
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
	TAGGED_FROM(0.00)[bounces-79197-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,vaf.va:url,suse.com:email,iloc.bh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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

On Mon 02-03-26 15:24:45, Jeff Layton wrote:
> Now that i_ino is u64 and the PRIino format macro has been removed,
> replace all uses in ext4 with the concrete format strings.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/dir.c            |  2 +-
>  fs/ext4/ext4.h           |  4 ++--
>  fs/ext4/extents.c        |  8 ++++----
>  fs/ext4/extents_status.c | 28 ++++++++++++++--------------
>  fs/ext4/fast_commit.c    |  8 ++++----
>  fs/ext4/ialloc.c         |  8 ++++----
>  fs/ext4/indirect.c       |  2 +-
>  fs/ext4/inline.c         | 14 +++++++-------
>  fs/ext4/inode.c          | 22 +++++++++++-----------
>  fs/ext4/ioctl.c          |  4 ++--
>  fs/ext4/mballoc.c        |  2 +-
>  fs/ext4/move_extent.c    | 20 ++++++++++----------
>  fs/ext4/namei.c          | 10 +++++-----
>  fs/ext4/orphan.c         | 16 ++++++++--------
>  fs/ext4/page-io.c        | 10 +++++-----
>  fs/ext4/super.c          | 22 +++++++++++-----------
>  fs/ext4/xattr.c          | 10 +++++-----
>  17 files changed, 95 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 785d482b0ff01686ed420508e826eb8d2745aa92..17edd678fa87b8f024232081888c4054d42a7bd9 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -535,7 +535,7 @@ static int call_filldir(struct file *file, struct dir_context *ctx,
>  	struct super_block *sb = inode->i_sb;
>  
>  	if (!fname) {
> -		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%" PRIino "u: comm %s: "
> +		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: comm %s: "
>  			 "called with null fname?!?", __func__, __LINE__,
>  			 inode->i_ino, current->comm);
>  		return 0;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index d2bf5f7db5524c50626833a82987f89965ab7f67..85e6c2b543a82e83b777c2cc2f54a6ed53b554f2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -92,7 +92,7 @@
>   */
>  #ifdef CONFIG_EXT4_DEBUG
>  #define ext_debug(ino, fmt, ...)					\
> -	pr_debug("[%s/%d] EXT4-fs (%s): ino %" PRIino "u: (%s, %d): %s:" fmt,	\
> +	pr_debug("[%s/%d] EXT4-fs (%s): ino %llu: (%s, %d): %s:" fmt,	\
>  		 current->comm, task_pid_nr(current),			\
>  		 ino->i_sb->s_id, ino->i_ino, __FILE__, __LINE__,	\
>  		 __func__, ##__VA_ARGS__)
> @@ -3229,7 +3229,7 @@ extern void __dump_mmp_msg(struct super_block *, struct mmp_struct *mmp,
>  extern __printf(7, 8)
>  void __ext4_grp_locked_error(const char *, unsigned int,
>  			     struct super_block *, ext4_group_t,
> -			     kino_t, ext4_fsblk_t,
> +			     u64, ext4_fsblk_t,
>  			     const char *, ...);
>  
>  #define EXT4_ERROR_INODE(inode, fmt, a...) \
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 668bb30771fb4fb33e75971b4488359e636d7d1b..042e1555a674149f8d47716f288ca175556b6b45 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4603,7 +4603,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  		}
>  		ret = ext4_map_blocks(handle, inode, &map, flags);
>  		if (ret <= 0) {
> -			ext4_debug("inode #%" PRIino "u: block %u: len %u: "
> +			ext4_debug("inode #%llu: block %u: len %u: "
>  				   "ext4_ext_map_blocks returned %d",
>  				   inode->i_ino, map.m_lblk,
>  				   map.m_len, ret);
> @@ -4955,7 +4955,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
>  		ret = ext4_map_blocks(handle, inode, &map, flags);
>  		if (ret != max_blocks)
>  			ext4_msg(inode->i_sb, KERN_INFO,
> -				     "inode #%" PRIino "u: block %u: len %u: "
> +				     "inode #%llu: block %u: len %u: "
>  				     "split block mapping found for atomic write, "
>  				     "ret = %d",
>  				     inode->i_ino, map.m_lblk,
> @@ -4974,7 +4974,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
>  
>  	if (ret <= 0 || ret2)
>  		ext4_warning(inode->i_sb,
> -			     "inode #%" PRIino "u: block %u: len %u: "
> +			     "inode #%llu: block %u: len %u: "
>  			     "returned %d or %d",
>  			     inode->i_ino, map.m_lblk,
>  			     map.m_len, ret, ret2);
> @@ -5031,7 +5031,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
>  				      EXT4_EX_NOCACHE);
>  		if (ret <= 0)
>  			ext4_warning(inode->i_sb,
> -				     "inode #%" PRIino "u: block %u: len %u: "
> +				     "inode #%llu: block %u: len %u: "
>  				     "ext4_ext_map_blocks returned %d",
>  				     inode->i_ino, map.m_lblk,
>  				     map.m_len, ret);
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 01ab48602798f0cdf6312e8bbe130dc319405bff..6e4a191e821915d2b61646f46304ffab6d531126 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -214,7 +214,7 @@ static void ext4_es_print_tree(struct inode *inode)
>  	struct ext4_es_tree *tree;
>  	struct rb_node *node;
>  
> -	printk(KERN_DEBUG "status extents for inode %" PRIino "u:", inode->i_ino);
> +	printk(KERN_DEBUG "status extents for inode %llu:", inode->i_ino);
>  	tree = &EXT4_I(inode)->i_es_tree;
>  	node = rb_first(&tree->root);
>  	while (node) {
> @@ -703,7 +703,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		if (!ext4_es_is_written(es) && !ext4_es_is_unwritten(es)) {
>  			if (in_range(es->es_lblk, ee_block, ee_len)) {
>  				pr_warn("ES insert assertion failed for "
> -					"inode: %" PRIino "u we can find an extent "
> +					"inode: %llu we can find an extent "
>  					"at block [%d/%d/%llu/%c], but we "
>  					"want to add a delayed/hole extent "
>  					"[%d/%d/%llu/%x]\n",
> @@ -721,7 +721,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		 */
>  		if (es->es_lblk < ee_block ||
>  		    ext4_es_pblock(es) != ee_start + es->es_lblk - ee_block) {
> -			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"ex_status [%d/%d/%llu/%c] != "
>  				"es_status [%d/%d/%llu/%c]\n", inode->i_ino,
>  				ee_block, ee_len, ee_start,
> @@ -731,7 +731,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		}
>  
>  		if (ee_status ^ es_status) {
> -			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"ex_status [%d/%d/%llu/%c] != "
>  				"es_status [%d/%d/%llu/%c]\n", inode->i_ino,
>  				ee_block, ee_len, ee_start,
> @@ -744,7 +744,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		 * that we don't want to add an written/unwritten extent.
>  		 */
>  		if (!ext4_es_is_delayed(es) && !ext4_es_is_hole(es)) {
> -			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"can't find an extent at block %d but we want "
>  				"to add a written/unwritten extent "
>  				"[%d/%d/%llu/%x]\n", inode->i_ino,
> @@ -779,7 +779,7 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
>  			 * We want to add a delayed/hole extent but this
>  			 * block has been allocated.
>  			 */
> -			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"We can find blocks but we want to add a "
>  				"delayed/hole extent [%d/%d/%llu/%x]\n",
>  				inode->i_ino, es->es_lblk, es->es_len,
> @@ -788,13 +788,13 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
>  		} else if (ext4_es_is_written(es)) {
>  			if (retval != es->es_len) {
>  				pr_warn("ES insert assertion failed for "
> -					"inode: %" PRIino "u retval %d != es_len %d\n",
> +					"inode: %llu retval %d != es_len %d\n",
>  					inode->i_ino, retval, es->es_len);
>  				return;
>  			}
>  			if (map.m_pblk != ext4_es_pblock(es)) {
>  				pr_warn("ES insert assertion failed for "
> -					"inode: %" PRIino "u m_pblk %llu != "
> +					"inode: %llu m_pblk %llu != "
>  					"es_pblk %llu\n",
>  					inode->i_ino, map.m_pblk,
>  					ext4_es_pblock(es));
> @@ -809,7 +809,7 @@ static void ext4_es_insert_extent_ind_check(struct inode *inode,
>  		}
>  	} else if (retval == 0) {
>  		if (ext4_es_is_written(es)) {
> -			pr_warn("ES insert assertion failed for inode: %" PRIino "u "
> +			pr_warn("ES insert assertion failed for inode: %llu "
>  				"We can't find the block but we want to add "
>  				"a written extent [%d/%d/%llu/%x]\n",
>  				inode->i_ino, es->es_lblk, es->es_len,
> @@ -919,7 +919,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %" PRIino "u\n",
> +	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %llu\n",
>  		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
>  
>  	if (!len)
> @@ -1631,7 +1631,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("remove [%u/%u) from extent status tree of inode %" PRIino "u\n",
> +	es_debug("remove [%u/%u) from extent status tree of inode %llu\n",
>  		 lblk, len, inode->i_ino);
>  
>  	if (!len)
> @@ -1821,7 +1821,7 @@ int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v)
>  	seq_printf(seq, "  %lu shrunk objects\n", es_stats->es_stats_shrunk);
>  	if (inode_cnt)
>  		seq_printf(seq,
> -		    "maximum:\n  %" PRIino "u inode (%u objects, %u reclaimable)\n"
> +		    "maximum:\n  %llu inode (%u objects, %u reclaimable)\n"
>  		    "  %llu us max scan time\n",
>  		    max->vfs_inode.i_ino, max->i_es_all_nr, max->i_es_shk_nr,
>  		    div_u64(es_stats->es_stats_max_scan_time, 1000));
> @@ -1998,7 +1998,7 @@ static void ext4_print_pending_tree(struct inode *inode)
>  	struct rb_node *node;
>  	struct pending_reservation *pr;
>  
> -	printk(KERN_DEBUG "pending reservations for inode %" PRIino "u:", inode->i_ino);
> +	printk(KERN_DEBUG "pending reservations for inode %llu:", inode->i_ino);
>  	tree = &EXT4_I(inode)->i_pending_tree;
>  	node = rb_first(&tree->root);
>  	while (node) {
> @@ -2214,7 +2214,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("add [%u/%u) delayed to extent status tree of inode %" PRIino "u\n",
> +	es_debug("add [%u/%u) delayed to extent status tree of inode %llu\n",
>  		 lblk, len, inode->i_ino);
>  	if (!len)
>  		return;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 8c6512d4ebcbd377186e4ce1ad5811b626d095db..379fb66dedbcd1c87b960cfe8786601700f797f3 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -616,7 +616,7 @@ static int __track_range(handle_t *handle, struct inode *inode, void *arg,
>  		(struct __track_range_args *)arg;
>  
>  	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
> -		ext4_debug("Special inode %" PRIino "u being modified\n", inode->i_ino);
> +		ext4_debug("Special inode %llu being modified\n", inode->i_ino);
>  		return -ECANCELED;
>  	}
>  
> @@ -914,7 +914,7 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
>  	spin_unlock(&ei->i_fc_lock);
>  
>  	cur_lblk_off = old_blk_size;
> -	ext4_debug("will try writing %d to %d for inode %" PRIino "u\n",
> +	ext4_debug("will try writing %d to %d for inode %llu\n",
>  		   cur_lblk_off, new_blk_size, inode->i_ino);
>  
>  	while (cur_lblk_off <= new_blk_size) {
> @@ -1792,7 +1792,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  
>  	cur = start;
>  	remaining = len;
> -	ext4_debug("ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %" PRIino "u\n",
> +	ext4_debug("ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %llu\n",
>  		  start, start_pblk, len, ext4_ext_is_unwritten(ex),
>  		  inode->i_ino);
>  
> @@ -1903,7 +1903,7 @@ ext4_fc_replay_del_range(struct super_block *sb,
>  	if (ret)
>  		goto out;
>  
> -	ext4_debug("DEL_RANGE, inode %" PRIino "u, lblk %d, len %d\n",
> +	ext4_debug("DEL_RANGE, inode %llu, lblk %d, len %d\n",
>  			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
>  			le32_to_cpu(lrange.fc_len));
>  	while (remaining > 0) {
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 35899f04a995b2b8b0fad275ad1920467701f54b..628a74b2bbe6232eabbf2562ffd0e350ea37446e 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -253,13 +253,13 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>  		return;
>  	}
>  	if (icount_read(inode) > 1) {
> -		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%" PRIino "u: count=%d",
> +		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: count=%d",
>  			 __func__, __LINE__, inode->i_ino,
>  			 icount_read(inode));
>  		return;
>  	}
>  	if (inode->i_nlink) {
> -		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%" PRIino "u: nlink=%d\n",
> +		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%llu: nlink=%d\n",
>  			 __func__, __LINE__, inode->i_ino, inode->i_nlink);
>  		return;
>  	}
> @@ -1275,7 +1275,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		 * twice.
>  		 */
>  		err = -EIO;
> -		ext4_error(sb, "failed to insert inode %" PRIino "u: doubly allocated?",
> +		ext4_error(sb, "failed to insert inode %llu: doubly allocated?",
>  			   inode->i_ino);
>  		ext4_mark_group_bitmap_corrupted(sb, group,
>  					EXT4_GROUP_INFO_IBITMAP_CORRUPT);
> @@ -1344,7 +1344,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		goto fail_free_drop;
>  	}
>  
> -	ext4_debug("allocating inode %" PRIino "u\n", inode->i_ino);
> +	ext4_debug("allocating inode %llu\n", inode->i_ino);
>  	trace_ext4_allocate_inode(inode, dir, mode);
>  	brelse(inode_bitmap_bh);
>  	return ret;
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index ba53698cef951676f409203fbf76439510a39dbc..5aec759eed7055dbe954c25da0181ebd04bb0be3 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -102,7 +102,7 @@ static int ext4_block_to_path(struct inode *inode,
>  		offsets[n++] = i_block & (ptrs - 1);
>  		final = ptrs;
>  	} else {
> -		ext4_warning(inode->i_sb, "block %lu > max in inode %" PRIino "u",
> +		ext4_warning(inode->i_sb, "block %lu > max in inode %llu",
>  			     i_block + direct_blocks +
>  			     indirect_blocks + double_blocks, inode->i_ino);
>  	}
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index fbdad8395f92ef5683a7bd65d683650a0ec04bc3..f846fcb7db2442149776fa2ba45ddc5e0b71245e 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -119,7 +119,7 @@ int ext4_get_max_inline_size(struct inode *inode)
>  	error = ext4_get_inode_loc(inode, &iloc);
>  	if (error) {
>  		ext4_error_inode_err(inode, __func__, __LINE__, 0, -error,
> -				     "can't get inode location %" PRIino "u",
> +				     "can't get inode location %llu",
>  				     inode->i_ino);
>  		return 0;
>  	}
> @@ -512,7 +512,7 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
>  	BUG_ON(folio->index);
>  
>  	if (!EXT4_I(inode)->i_inline_off) {
> -		ext4_warning(inode->i_sb, "inode %" PRIino "u doesn't have inline data.",
> +		ext4_warning(inode->i_sb, "inode %llu doesn't have inline data.",
>  			     inode->i_ino);
>  		goto out;
>  	}
> @@ -934,7 +934,7 @@ void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
>  	struct ext4_dir_entry_2 *de = inline_start;
>  	void *dlimit = inline_start + inline_size;
>  
> -	trace_printk("inode %" PRIino "u\n", dir->i_ino);
> +	trace_printk("inode %llu\n", dir->i_ino);
>  	offset = 0;
>  	while ((void *)de < dlimit) {
>  		de_len = ext4_rec_len_from_disk(de->rec_len, inline_size);
> @@ -1071,7 +1071,7 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
>  	ret = ext4_create_inline_data(handle, inode, inline_size);
>  	if (ret) {
>  		ext4_msg(inode->i_sb, KERN_EMERG,
> -			"error restoring inline_data for inode -- potential data loss! (inode %" PRIino "u, error %d)",
> +			"error restoring inline_data for inode -- potential data loss! (inode %llu, error %d)",
>  			inode->i_ino, ret);
>  		return;
>  	}
> @@ -1740,7 +1740,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
>  	err = ext4_get_inode_loc(dir, &iloc);
>  	if (err) {
>  		EXT4_ERROR_INODE_ERR(dir, -err,
> -				     "error %d getting inode %" PRIino "u block",
> +				     "error %d getting inode %llu block",
>  				     err, dir->i_ino);
>  		return false;
>  	}
> @@ -1755,7 +1755,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
>  	de = (struct ext4_dir_entry_2 *)ext4_raw_inode(&iloc)->i_block;
>  	if (!le32_to_cpu(de->inode)) {
>  		ext4_warning(dir->i_sb,
> -			     "bad inline directory (dir #%" PRIino "u) - no `..'",
> +			     "bad inline directory (dir #%llu) - no `..'",
>  			     dir->i_ino);
>  		goto out;
>  	}
> @@ -1769,7 +1769,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
>  					 iloc.bh, inline_pos,
>  					 inline_size, offset)) {
>  			ext4_warning(dir->i_sb,
> -				     "bad inline directory (dir #%" PRIino "u) - "
> +				     "bad inline directory (dir #%llu) - "
>  				     "inode %u, rec_len %u, name_len %d"
>  				     "inline size %d",
>  				     dir->i_ino, le32_to_cpu(de->inode),
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1d694672c851dd255f905de3d6260b24295ce30f..d50f31124a784ba6eeb916f9a2f62ec840aee52e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -262,7 +262,7 @@ void ext4_evict_inode(struct inode *inode)
>  		err = ext4_truncate(inode);
>  		if (err) {
>  			ext4_error_err(inode->i_sb, -err,
> -				       "couldn't truncate inode %" PRIino "u (err %d)",
> +				       "couldn't truncate inode %llu (err %d)",
>  				       inode->i_ino, err);
>  			goto stop_handle;
>  		}
> @@ -342,7 +342,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>  	spin_lock(&ei->i_block_reservation_lock);
>  	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
>  	if (unlikely(used > ei->i_reserved_data_blocks)) {
> -		ext4_warning(inode->i_sb, "%s: ino %" PRIino "u, used %d "
> +		ext4_warning(inode->i_sb, "%s: ino %llu, used %d "
>  			 "with only %d reserved data blocks",
>  			 __func__, inode->i_ino, used,
>  			 ei->i_reserved_data_blocks);
> @@ -475,7 +475,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
>  	if (es_map->m_lblk != map->m_lblk ||
>  	    es_map->m_flags != map->m_flags ||
>  	    es_map->m_pblk != map->m_pblk) {
> -		printk("ES cache assertion failed for inode: %" PRIino "u "
> +		printk("ES cache assertion failed for inode: %llu "
>  		       "es_cached ex [%d/%d/%llu/%x] != "
>  		       "found ex [%d/%d/%llu/%x] retval %d flags %x\n",
>  		       inode->i_ino, es_map->m_lblk, es_map->m_len,
> @@ -515,7 +515,7 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
>  	if (unlikely(retval != map2.m_len)) {
>  		ext4_warning(inode->i_sb,
>  			     "ES len assertion failed for inode "
> -			     "%" PRIino "u: retval %d != map->m_len %d",
> +			     "%llu: retval %d != map->m_len %d",
>  			     inode->i_ino, retval, map2.m_len);
>  		WARN_ON(1);
>  	}
> @@ -563,7 +563,7 @@ int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  	if (unlikely(retval != map->m_len)) {
>  		ext4_warning(inode->i_sb,
>  			     "ES len assertion failed for inode "
> -			     "%" PRIino "u: retval %d != map->m_len %d",
> +			     "%llu: retval %d != map->m_len %d",
>  			     inode->i_ino, retval, map->m_len);
>  		WARN_ON(1);
>  	}
> @@ -630,7 +630,7 @@ int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  
>  	if (unlikely(retval != map->m_len)) {
>  		ext4_warning(inode->i_sb,
> -			     "ES len assertion failed for inode %" PRIino "u: "
> +			     "ES len assertion failed for inode %llu: "
>  			     "retval %d != map->m_len %d",
>  			     inode->i_ino, retval, map->m_len);
>  		WARN_ON(1);
> @@ -937,7 +937,7 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
>  {
>  	int ret = 0;
>  
> -	ext4_debug("ext4_get_block_unwritten: inode %" PRIino "u, create flag %d\n",
> +	ext4_debug("ext4_get_block_unwritten: inode %llu, create flag %d\n",
>  		   inode->i_ino, create);
>  	ret = _ext4_get_block(inode, iblock, bh_result,
>  			       EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> @@ -1659,7 +1659,7 @@ void ext4_da_release_space(struct inode *inode, int to_free)
>  		 * harmless to return without any action.
>  		 */
>  		ext4_warning(inode->i_sb, "ext4_da_release_space: "
> -			 "ino %" PRIino "u, to_free %d with only %d reserved "
> +			 "ino %llu, to_free %d with only %d reserved "
>  			 "data blocks", inode->i_ino, to_free,
>  			 ei->i_reserved_data_blocks);
>  		WARN_ON(1);
> @@ -2491,7 +2491,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  			}
>  			ext4_msg(sb, KERN_CRIT,
>  				 "Delayed block allocation failed for "
> -				 "inode %" PRIino "u at logical offset %llu with"
> +				 "inode %llu at logical offset %llu with"
>  				 " max blocks %u with error %d",
>  				 inode->i_ino,
>  				 (unsigned long long)map->m_lblk,
> @@ -2535,7 +2535,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  		err2 = ext4_mark_inode_dirty(handle, inode);
>  		if (err2) {
>  			ext4_error_err(inode->i_sb, -err2,
> -				       "Failed to mark inode %" PRIino "u dirty",
> +				       "Failed to mark inode %llu dirty",
>  				       inode->i_ino);
>  		}
>  		if (!err)
> @@ -2909,7 +2909,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		if (IS_ERR(handle)) {
>  			ret = PTR_ERR(handle);
>  			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
> -			       "%ld pages, ino %" PRIino "u; err %d", __func__,
> +			       "%ld pages, ino %llu; err %d", __func__,
>  				wbc->nr_to_write, inode->i_ino, ret);
>  			/* Release allocated io_end */
>  			ext4_put_io_end(mpd->io_submit.io_end);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index dcd71f84d9a80f464349e75e4dbbf62757dfeb03..1d0c3d4bdf472715a7070b184fdc7d9bf5885950 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -477,7 +477,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	if (err < 0) {
>  		/* No need to update quota information. */
>  		ext4_warning(inode->i_sb,
> -			"couldn't mark inode #%" PRIino "u dirty (err %d)",
> +			"couldn't mark inode #%llu dirty (err %d)",
>  			inode->i_ino, err);
>  		/* Revert all changes: */
>  		swap_inode_data(inode, inode_bl);
> @@ -493,7 +493,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	if (err < 0) {
>  		/* No need to update quota information. */
>  		ext4_warning(inode_bl->i_sb,
> -			"couldn't mark inode #%" PRIino "u dirty (err %d)",
> +			"couldn't mark inode #%llu dirty (err %d)",
>  			inode_bl->i_ino, err);
>  		goto revert;
>  	}
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f597135a669a53c05a5fd8f48c02a43ef4f1cdb0..9e8041ac56239e64326343b0adef062611189d6a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5628,7 +5628,7 @@ void ext4_discard_preallocations(struct inode *inode)
>  	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	mb_debug(sb, "discard preallocation for inode %" PRIino "u\n",
> +	mb_debug(sb, "discard preallocation for inode %llu\n",
>  		 inode->i_ino);
>  	trace_ext4_discard_preallocations(inode,
>  			atomic_read(&ei->i_prealloc_active));
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 89df4e0591055ec3c365bd51995a523e5b4d83d1..ab17c1d3a7b51198c2332e8a1dd44f7a1bff40cf 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -420,21 +420,21 @@ static int mext_check_validity(struct inode *orig_inode,
>  
>  	/* origin and donor should be different inodes */
>  	if (orig_inode == donor_inode) {
> -		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be same inode [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
>  	/* origin and donor should belone to the same filesystem */
>  	if (orig_inode->i_sb != donor_inode->i_sb) {
> -		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: The argument files should be in same FS [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
>  	/* Regular file check */
>  	if (!S_ISREG(orig_inode->i_mode) || !S_ISREG(donor_inode->i_mode)) {
> -		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: The argument files should be regular file [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> @@ -477,26 +477,26 @@ static int mext_check_validity(struct inode *orig_inode,
>  	}
>  
>  	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
> -		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
>  
>  	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode)) {
> -		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EPERM;
>  	}
>  
>  	/* Ext4 move extent does not support swap files */
>  	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
> -		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -ETXTBSY;
>  	}
>  
>  	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
> -		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EOPNOTSUPP;
>  	}
> @@ -523,7 +523,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>  	/* Start offset should be same */
>  	if ((orig_start & ~(PAGE_MASK >> orig_inode->i_blkbits)) !=
>  	    (donor_start & ~(PAGE_MASK >> orig_inode->i_blkbits))) {
> -		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> @@ -533,7 +533,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>  	    (*len > EXT_MAX_BLOCKS) ||
>  	    (donor_start + *len >= EXT_MAX_BLOCKS) ||
>  	    (orig_start + *len >= EXT_MAX_BLOCKS))  {
> -		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %llu, donor %llu]\n",
>  			   EXT_MAX_BLOCKS,
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
> @@ -550,7 +550,7 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>  	else if (donor_eof < donor_start + *len - 1)
>  		*len = donor_eof - donor_start;
>  	if (!*len) {
> -		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %" PRIino "u, donor %" PRIino "u]\n",
> +		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %llu, donor %llu]\n",
>  			   orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index e659897787de1cc7e587af191908408162511db4..503dc9ffd61465686bb1a253bfeee41c0e9acd59 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -144,7 +144,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
>  		bh = ext4_bread(NULL, inode, block, 0);
>  	if (IS_ERR(bh)) {
>  		__ext4_warning(inode->i_sb, func, line,
> -			       "inode #%" PRIino "u: lblock %lu: comm %s: "
> +			       "inode #%llu: lblock %lu: comm %s: "
>  			       "error %ld reading directory block",
>  			       inode->i_ino, (unsigned long)block,
>  			       current->comm, PTR_ERR(bh));
> @@ -841,7 +841,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
>  	indirect = root->info.indirect_levels;
>  	if (indirect >= ext4_dir_htree_level(dir->i_sb)) {
>  		ext4_warning(dir->i_sb,
> -			     "Directory (ino: %" PRIino "u) htree depth %#06x exceed"
> +			     "Directory (ino: %llu) htree depth %#06x exceed"
>  			     "supported value", dir->i_ino,
>  			     ext4_dir_htree_level(dir->i_sb));
>  		if (ext4_dir_htree_level(dir->i_sb) < EXT4_HTREE_LEVEL) {
> @@ -1793,7 +1793,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
>  		    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
>  		    !fscrypt_has_permitted_context(dir, inode)) {
>  			ext4_warning(inode->i_sb,
> -				     "Inconsistent encryption contexts: %" PRIino "u/%" PRIino "u",
> +				     "Inconsistent encryption contexts: %llu/%llu",
>  				     dir->i_ino, inode->i_ino);
>  			iput(inode);
>  			return ERR_PTR(-EPERM);
> @@ -2227,7 +2227,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  		csum_size = sizeof(struct ext4_dir_entry_tail);
>  
>  	blocksize =  dir->i_sb->s_blocksize;
> -	dxtrace(printk(KERN_DEBUG "Creating index: inode %" PRIino "u\n", dir->i_ino));
> +	dxtrace(printk(KERN_DEBUG "Creating index: inode %llu\n", dir->i_ino));
>  	BUFFER_TRACE(bh, "get_write_access");
>  	retval = ext4_journal_get_write_access(handle, dir->i_sb, bh,
>  					       EXT4_JTR_NONE);
> @@ -2523,7 +2523,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			restart = 1;
>  		}
>  		if (add_level && levels == ext4_dir_htree_level(sb)) {
> -			ext4_warning(sb, "Directory (ino: %" PRIino "u) index full, "
> +			ext4_warning(sb, "Directory (ino: %llu) index full, "
>  					 "reach max htree level :%d",
>  					 dir->i_ino, levels);
>  			if (ext4_dir_htree_level(sb) < EXT4_HTREE_LEVEL) {
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 7082af298f1c648fba8a1aa1141b3c76f4c15e22..64ea4762423386db79e739a2448bf70c12415ef8 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -179,8 +179,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
>  	} else
>  		brelse(iloc.bh);
>  
> -	ext4_debug("superblock will point to %" PRIino "u\n", inode->i_ino);
> -	ext4_debug("orphan inode %" PRIino "u will point to %d\n",
> +	ext4_debug("superblock will point to %llu\n", inode->i_ino);
> +	ext4_debug("orphan inode %llu will point to %d\n",
>  			inode->i_ino, NEXT_ORPHAN(inode));
>  out:
>  	ext4_std_error(sb, err);
> @@ -249,7 +249,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  	}
>  
>  	mutex_lock(&sbi->s_orphan_lock);
> -	ext4_debug("remove inode %" PRIino "u from orphan list\n", inode->i_ino);
> +	ext4_debug("remove inode %llu from orphan list\n", inode->i_ino);
>  
>  	prev = ei->i_orphan.prev;
>  	list_del_init(&ei->i_orphan);
> @@ -284,7 +284,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
>  		struct inode *i_prev =
>  			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
>  
> -		ext4_debug("orphan inode %" PRIino "u will point to %u\n",
> +		ext4_debug("orphan inode %llu will point to %u\n",
>  			  i_prev->i_ino, ino_next);
>  		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
>  		if (err) {
> @@ -328,9 +328,9 @@ static void ext4_process_orphan(struct inode *inode,
>  	if (inode->i_nlink) {
>  		if (test_opt(sb, DEBUG))
>  			ext4_msg(sb, KERN_DEBUG,
> -				"%s: truncating inode %" PRIino "u to %lld bytes",
> +				"%s: truncating inode %llu to %lld bytes",
>  				__func__, inode->i_ino, inode->i_size);
> -		ext4_debug("truncating inode %" PRIino "u to %lld bytes\n",
> +		ext4_debug("truncating inode %llu to %lld bytes\n",
>  			   inode->i_ino, inode->i_size);
>  		inode_lock(inode);
>  		truncate_inode_pages(inode->i_mapping, inode->i_size);
> @@ -349,9 +349,9 @@ static void ext4_process_orphan(struct inode *inode,
>  	} else {
>  		if (test_opt(sb, DEBUG))
>  			ext4_msg(sb, KERN_DEBUG,
> -				"%s: deleting unreferenced inode %" PRIino "u",
> +				"%s: deleting unreferenced inode %llu",
>  				__func__, inode->i_ino);
> -		ext4_debug("deleting unreferenced inode %" PRIino "u\n",
> +		ext4_debug("deleting unreferenced inode %llu\n",
>  			   inode->i_ino);
>  		(*nr_orphans)++;
>  	}
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 09046cfb58dd52a2fe682560fa09e39e902dd0a2..86011275ad83668d591488fad90959ec04625c55 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -180,7 +180,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  	struct super_block *sb = inode->i_sb;
>  	int ret = 0;
>  
> -	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %" PRIino "u,list->next 0x%p,"
> +	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %llu,list->next 0x%p,"
>  		   "list->prev 0x%p\n",
>  		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
>  
> @@ -204,7 +204,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  		ext4_msg(sb, KERN_EMERG,
>  			 "failed to convert unwritten extents to written "
>  			 "extents -- potential data loss!  "
> -			 "(inode %" PRIino "u, error %d)", inode->i_ino, ret);
> +			 "(inode %llu, error %d)", inode->i_ino, ret);
>  	}
>  
>  	ext4_clear_io_unwritten_flag(io_end);
> @@ -221,7 +221,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  	if (list_empty(head))
>  		return;
>  
> -	ext4_debug("Dump inode %" PRIino "u completed io list\n", inode->i_ino);
> +	ext4_debug("Dump inode %llu completed io list\n", inode->i_ino);
>  	list_for_each_entry(io_end, head, list) {
>  		cur = &io_end->list;
>  		before = cur->prev;
> @@ -229,7 +229,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  		after = cur->next;
>  		io_end1 = container_of(after, ext4_io_end_t, list);
>  
> -		ext4_debug("io 0x%p from inode %" PRIino "u,prev 0x%p,next 0x%p\n",
> +		ext4_debug("io 0x%p from inode %llu,prev 0x%p,next 0x%p\n",
>  			    io_end, inode->i_ino, io_end0, io_end1);
>  	}
>  #endif
> @@ -366,7 +366,7 @@ static void ext4_end_bio(struct bio *bio)
>  	if (bio->bi_status) {
>  		struct inode *inode = io_end->inode;
>  
> -		ext4_warning(inode->i_sb, "I/O error %d writing to inode %" PRIino "u "
> +		ext4_warning(inode->i_sb, "I/O error %d writing to inode %llu "
>  			     "starting block %llu)",
>  			     bio->bi_status, inode->i_ino,
>  			     (unsigned long long)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 17463e9cc893cf3158a5a75d64d453956373f149..781c083000c2ea2232846b0827c7d4799d87bd5d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -848,12 +848,12 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>  		vaf.va = &args;
>  		if (block)
>  			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
> -			       "inode #%" PRIino "u: block %llu: comm %s: %pV\n",
> +			       "inode #%llu: block %llu: comm %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       block, current->comm, &vaf);
>  		else
>  			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
> -			       "inode #%" PRIino "u: comm %s: %pV\n",
> +			       "inode #%llu: comm %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       current->comm, &vaf);
>  		va_end(args);
> @@ -888,13 +888,13 @@ void __ext4_error_file(struct file *file, const char *function,
>  		vaf.va = &args;
>  		if (block)
>  			printk(KERN_CRIT
> -			       "EXT4-fs error (device %s): %s:%d: inode #%" PRIino "u: "
> +			       "EXT4-fs error (device %s): %s:%d: inode #%llu: "
>  			       "block %llu: comm %s: path %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       block, current->comm, path, &vaf);
>  		else
>  			printk(KERN_CRIT
> -			       "EXT4-fs error (device %s): %s:%d: inode #%" PRIino "u: "
> +			       "EXT4-fs error (device %s): %s:%d: inode #%llu: "
>  			       "comm %s: path %s: %pV\n",
>  			       inode->i_sb->s_id, function, line, inode->i_ino,
>  			       current->comm, path, &vaf);
> @@ -1035,14 +1035,14 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
> -	       "inode #%" PRIino "u: comm %s: %pV\n", inode->i_sb->s_id,
> +	       "inode #%llu: comm %s: %pV\n", inode->i_sb->s_id,
>  	       function, line, inode->i_ino, current->comm, &vaf);
>  	va_end(args);
>  }
>  
>  void __ext4_grp_locked_error(const char *function, unsigned int line,
>  			     struct super_block *sb, ext4_group_t grp,
> -			     kino_t ino, ext4_fsblk_t block,
> +			     u64 ino, ext4_fsblk_t block,
>  			     const char *fmt, ...)
>  __releases(bitlock)
>  __acquires(bitlock)
> @@ -1061,7 +1061,7 @@ __acquires(bitlock)
>  		printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: group %u, ",
>  		       sb->s_id, function, line, grp);
>  		if (ino)
> -			printk(KERN_CONT "inode %" PRIino "u: ", ino);
> +			printk(KERN_CONT "inode %llu: ", ino);
>  		if (block)
>  			printk(KERN_CONT "block %llu:",
>  			       (unsigned long long) block);
> @@ -1170,7 +1170,7 @@ static void dump_orphan_list(struct super_block *sb, struct ext4_sb_info *sbi)
>  	list_for_each(l, &sbi->s_orphan) {
>  		struct inode *inode = orphan_list_entry(l);
>  		printk(KERN_ERR "  "
> -		       "inode %s:%" PRIino "u at %p: mode %o, nlink %d, next %d\n",
> +		       "inode %s:%llu at %p: mode %o, nlink %d, next %d\n",
>  		       inode->i_sb->s_id, inode->i_ino, inode,
>  		       inode->i_mode, inode->i_nlink,
>  		       NEXT_ORPHAN(inode));
> @@ -1446,7 +1446,7 @@ static void ext4_free_in_core_inode(struct inode *inode)
>  {
>  	fscrypt_free_inode(inode);
>  	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
> -		pr_warn("%s: inode %" PRIino "u still in fc list",
> +		pr_warn("%s: inode %llu still in fc list",
>  			__func__, inode->i_ino);
>  	}
>  	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
> @@ -1456,7 +1456,7 @@ static void ext4_destroy_inode(struct inode *inode)
>  {
>  	if (ext4_inode_orphan_tracked(inode)) {
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %" PRIino "u (%p): inode tracked as orphan!",
> +			 "Inode %llu (%p): inode tracked as orphan!",
>  			 inode->i_ino, EXT4_I(inode));
>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>  				EXT4_I(inode), sizeof(struct ext4_inode_info),
> @@ -1467,7 +1467,7 @@ static void ext4_destroy_inode(struct inode *inode)
>  	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ERROR_FS) &&
>  	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %" PRIino "u (%p): i_reserved_data_blocks (%u) not cleared!",
> +			 "Inode %llu (%p): i_reserved_data_blocks (%u) not cleared!",
>  			 inode->i_ino, EXT4_I(inode),
>  			 EXT4_I(inode)->i_reserved_data_blocks);
>  }
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 13d8f5c80b3128e3cf1044e57fd667f47f90ad6d..60aec4712f7fc52a8cc8ce31e4d5bd740a193903 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -64,7 +64,7 @@
>  
>  #ifdef EXT4_XATTR_DEBUG
>  # define ea_idebug(inode, fmt, ...)					\
> -	printk(KERN_DEBUG "inode %s:%" PRIino "u: " fmt "\n",			\
> +	printk(KERN_DEBUG "inode %s:%llu: " fmt "\n",			\
>  	       inode->i_sb->s_id, inode->i_ino, ##__VA_ARGS__)
>  # define ea_bdebug(bh, fmt, ...)					\
>  	printk(KERN_DEBUG "block %pg:%lu: " fmt "\n",			\
> @@ -1035,7 +1035,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  	ref_count = ext4_xattr_inode_get_ref(ea_inode);
>  	if ((ref_count == 0 && ref_change < 0) || (ref_count == U64_MAX && ref_change > 0)) {
>  		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
> -			"EA inode %" PRIino "u ref wraparound: ref_count=%lld ref_change=%d",
> +			"EA inode %llu ref wraparound: ref_count=%lld ref_change=%d",
>  			ea_inode->i_ino, ref_count, ref_change);
>  		brelse(iloc.bh);
>  		ret = -EFSCORRUPTED;
> @@ -1046,7 +1046,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  
>  	if (ref_change > 0) {
>  		if (ref_count == 1) {
> -			WARN_ONCE(ea_inode->i_nlink, "EA inode %" PRIino "u i_nlink=%u",
> +			WARN_ONCE(ea_inode->i_nlink, "EA inode %llu i_nlink=%u",
>  				  ea_inode->i_ino, ea_inode->i_nlink);
>  
>  			set_nlink(ea_inode, 1);
> @@ -1055,7 +1055,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  	} else {
>  		if (ref_count == 0) {
>  			WARN_ONCE(ea_inode->i_nlink != 1,
> -				  "EA inode %" PRIino "u i_nlink=%u",
> +				  "EA inode %llu i_nlink=%u",
>  				  ea_inode->i_ino, ea_inode->i_nlink);
>  
>  			clear_nlink(ea_inode);
> @@ -2854,7 +2854,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  
>  cleanup:
>  	if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
> -		ext4_warning(inode->i_sb, "Unable to expand inode %" PRIino "u. Delete some EAs or run e2fsck.",
> +		ext4_warning(inode->i_sb, "Unable to expand inode %llu. Delete some EAs or run e2fsck.",
>  			     inode->i_ino);
>  		mnt_count = le16_to_cpu(sbi->s_es->s_mnt_count);
>  	}
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

