Return-Path: <linux-fsdevel+bounces-79064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEtoLkEFpmkzJAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:46:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C341E3FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ADCD3243CF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C23DEAE4;
	Mon,  2 Mar 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVXrDOh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AC3DFC88;
	Mon,  2 Mar 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484524; cv=none; b=I9dYjno5RUASvQFUTDCogyBdryw1yqMSonR2uSv7W/e/2jfeiy67EM6kLzkHjBnx+Hx2TH7mllzaeEihRTfR3EB5n7OdZNqLkuVWXmVzLXE+X83I3vWv2c2UA+tO/HPDd9ACjHA435LZFBC/8l5e+7+OhmIzvCtz0zuSmYoCbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484524; c=relaxed/simple;
	bh=XH+uFZSmNDN2ptX3RrQASaTIj90c+ocZQ3rxyA6ATLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mycQcYhUyzm7ME1mWyiz0LeRZlveGK9FT4vQ1pSq/sNdGZspkio3POGgoHcu8lB+EnuHFgyb7HQhKtsuj5iebVwju5PJRFhSTz6epk+ecOd9XAPMx2sbipClWwbKR2o0ZSwW0CM/ZVlJr27oxA9O7TkmEdgIyAXtd+yVtzLwXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVXrDOh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40790C19425;
	Mon,  2 Mar 2026 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484523;
	bh=XH+uFZSmNDN2ptX3RrQASaTIj90c+ocZQ3rxyA6ATLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iVXrDOh2Ncf5NrMJX3ihQ0yWYBb2qKpf1HDvUW8uaT1pQpdMsT5DTGR0WLz8/PKcW
	 dE7bHgzpy10p5+ASLMDMPbJwJ+lyneDG1E/2GII25P4yGZW7tTPCBi2IwXsjtzXpza
	 gQ/67PlXgGE4V3TZod6qgfREW74kicxEttREEGGDVmakwnnSBQl/9iH8qiQwX3UUUi
	 qTYNw/V30fH3FRdzDydenPEg5d0ZpCBxvGPyfwxsCpYSFUuFo2vrKBZNb741AfLs45
	 t3aKxo67Sv9a2MrfLiyxtNdMk0hwRyd82S9gMag4wOxhRH6k3m1e6uHk3O5iJTtC+l
	 C7dNHXCjjF2Tw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:25:23 -0500
Subject: [PATCH v2 099/110] ufs: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-99-e5388800dae0@kernel.org>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, 
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yangtao Li <frank.li@vivo.com>, 
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
 Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, 
 Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
 linux-x25@vger.kernel.org, audit@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8514; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XH+uFZSmNDN2ptX3RrQASaTIj90c+ocZQ3rxyA6ATLE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIKMSoWP8hFQKjjQeno+hUGUuYd6GvJ4bDs5
 7A3Boocpn2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyCgAKCRAADmhBGVaC
 FY3oEACyqIaJVAIso5s3j+X74J8R7OIZ/3TDCJ9XB5tC1cEx7enUCvtu37j0livMQYt+5/C2Rh9
 ru6qJKy8aZ21jQpbYqyiZHIg/0is1waiDOrKEtB7HyYm98IaEN0YFz5uzcfiGuGJSdzakmiFuu2
 nMfsAW/4aEtQE1ytbOR1ZWtykmsZMe0h91vvVWbHlZ3lNJWX+5ui2x51WoK4i056frqSjzIwyAM
 nV65BDJ1Y0tAUVBUznyrFbkHe4tOWe4RpA0g6E3+zlKE1johBi2QGhPhT0t1JpefRePwXzSMZ+d
 5v5FTyhm28Gpj0m5gm5BkoO6DHT75enaedHOt/b6OhMPG+iKy1Q4BuDdnCpMgnB2piQQNiFJ6qS
 DwxuMt4AghbxBQWlmKoImjirtPYMvGQMpCVHCLm6cIhr8KQxHxVItTV0X1tRSVKorrPzeDlzTj7
 YxBIK6/M4zQHsnJXnXsVUi+fVQJA7206szogovn3GVf/tIiAmhkwVhsCjw25MppPIcsgmXBsvMs
 Iirc+TTCe6Q3FCBzUJX4x7/xhRAYOArxmoTLoon39IirCDJwAg8jI3hhd3fE992K99lw47W7Hxx
 J+el66KP4PdCBmx03OzxpYxhI2TyG4C5EZui0czqddpHczx8MN+mfe62gilR434DDf3aunJnsvv
 Z+h+VZ85i3fWN1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 30C341E3FD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79064-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in ufs with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ufs/balloc.c |  6 +++---
 fs/ufs/dir.c    | 10 +++++-----
 fs/ufs/ialloc.c |  6 +++---
 fs/ufs/inode.c  | 18 +++++++++---------
 fs/ufs/util.c   |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index b961daa05608fa52dcfc2702bb97c437ef27d9c2..628edfde3a9fd73852930094c19ae6944858f2c4 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -245,7 +245,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 	sector_t end, i;
 	struct buffer_head *head, *bh;
 
-	UFSD("ENTER, ino %" PRIino "u, count %u, oldb %llu, newb %llu\n",
+	UFSD("ENTER, ino %llu, count %u, oldb %llu, newb %llu\n",
 	      inode->i_ino, count,
 	     (unsigned long long)oldb, (unsigned long long)newb);
 
@@ -340,7 +340,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 	unsigned cgno, oldcount, newcount;
 	u64 tmp, request, result;
 	
-	UFSD("ENTER, ino %" PRIino "u, fragment %llu, goal %llu, count %u\n",
+	UFSD("ENTER, ino %llu, fragment %llu, goal %llu, count %u\n",
 	     inode->i_ino, (unsigned long long)fragment,
 	     (unsigned long long)goal, count);
 	
@@ -583,7 +583,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	unsigned oldcg, i, j, k, allocsize;
 	u64 result;
 	
-	UFSD("ENTER, ino %" PRIino "u, cgno %u, goal %llu, count %u\n",
+	UFSD("ENTER, ino %llu, cgno %u, goal %llu, count %u\n",
 	     inode->i_ino, cgno, (unsigned long long)goal, count);
 
 	sb = inode->i_sb;
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index c7a13e01119f990b8f7139fdc3005e7b65afeb54..f10a50f7e78b8020fd216eff19c147b20bd332c1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -150,7 +150,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
 
 Ebadsize:
 	ufs_error(sb, __func__,
-		  "size of directory #%" PRIino "u is not a multiple of chunk size",
+		  "size of directory #%llu is not a multiple of chunk size",
 		  dir->i_ino
 	);
 	goto fail;
@@ -169,7 +169,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
 Einumber:
 	error = "inode out of bounds";
 bad_entry:
-	ufs_error(sb, __func__, "bad entry in directory #%" PRIino "u: %s - "
+	ufs_error(sb, __func__, "bad entry in directory #%llu: %s - "
 		   "offset=%llu, rec_len=%d, name_len=%d",
 		   dir->i_ino, error, folio_pos(folio) + offs,
 		   rec_len, ufs_get_de_namlen(sb, p));
@@ -177,7 +177,7 @@ static bool ufs_check_folio(struct folio *folio, char *kaddr)
 Eend:
 	p = (struct ufs_dir_entry *)(kaddr + offs);
 	ufs_error(sb, __func__,
-		   "entry in directory #%" PRIino "u spans the page boundary"
+		   "entry in directory #%llu spans the page boundary"
 		   "offset=%llu",
 		   dir->i_ino, folio_pos(folio) + offs);
 fail:
@@ -258,7 +258,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	struct ufs_inode_info *ui = UFS_I(dir);
 	struct ufs_dir_entry *de;
 
-	UFSD("ENTER, dir_ino %" PRIino "u, name %s, namlen %u\n", dir->i_ino, name, namelen);
+	UFSD("ENTER, dir_ino %llu, name %s, namlen %u\n", dir->i_ino, name, namelen);
 
 	if (npages == 0 || namelen > UFS_MAXNAMLEN)
 		goto out;
@@ -434,7 +434,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 
 		if (IS_ERR(kaddr)) {
 			ufs_error(sb, __func__,
-				  "bad page in #%" PRIino "u",
+				  "bad page in #%llu",
 				  inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return PTR_ERR(kaddr);
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index f26fbe330a1d0e053ddf8dbe2a8ec5d41373c79f..8e51f4630d186ae49aa987ca46df20960f300614 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -63,7 +63,7 @@ void ufs_free_inode (struct inode * inode)
 	int is_directory;
 	unsigned ino, cg, bit;
 	
-	UFSD("ENTER, ino %" PRIino "u\n", inode->i_ino);
+	UFSD("ENTER, ino %llu\n", inode->i_ino);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
@@ -317,7 +317,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 		bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
 		if (!bh) {
 			ufs_warning(sb, "ufs_read_inode",
-				    "unable to read inode %" PRIino "u\n",
+				    "unable to read inode %llu\n",
 				    inode->i_ino);
 			err = -EIO;
 			goto fail_remove_inode;
@@ -336,7 +336,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	}
 	mutex_unlock(&sbi->s_lock);
 
-	UFSD("allocating inode %" PRIino "u\n", inode->i_ino);
+	UFSD("allocating inode %llu\n", inode->i_ino);
 	UFSD("EXIT\n");
 	return inode;
 
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 199f5f71f77b20bfde408cb1ac7a8ea8c45cc465..2a8728c879796403166f713d1b4ee1b05fe1ffed 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -400,7 +400,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 
 	mutex_lock(&UFS_I(inode)->truncate_mutex);
 
-	UFSD("ENTER, ino %" PRIino "u, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
+	UFSD("ENTER, ino %llu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment);
 	if (unlikely(!depth)) {
 		ufs_warning(sb, "ufs_get_block", "block > big");
 		err = -EIO;
@@ -595,7 +595,7 @@ static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 	struct super_block *sb = inode->i_sb;
 	umode_t mode;
 
-	UFSD("Reading ufs2 inode, ino %" PRIino "u\n", inode->i_ino);
+	UFSD("Reading ufs2 inode, ino %llu\n", inode->i_ino);
 	/*
 	 * Copy data to the in-core inode.
 	 */
@@ -662,7 +662,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 
 	bh = sb_bread(sb, uspi->s_sbbase + ufs_inotofsba(inode->i_ino));
 	if (!bh) {
-		ufs_warning(sb, "ufs_read_inode", "unable to read inode %" PRIino "u\n",
+		ufs_warning(sb, "ufs_read_inode", "unable to read inode %llu\n",
 			    inode->i_ino);
 		goto bad_inode;
 	}
@@ -793,17 +793,17 @@ static int ufs_update_inode(struct inode * inode, int do_sync)
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct buffer_head * bh;
 
-	UFSD("ENTER, ino %" PRIino "u\n", inode->i_ino);
+	UFSD("ENTER, ino %llu\n", inode->i_ino);
 
 	if (inode->i_ino < UFS_ROOTINO ||
 	    inode->i_ino > (uspi->s_ncg * uspi->s_ipg)) {
-		ufs_warning (sb, "ufs_read_inode", "bad inode number (%" PRIino "u)\n", inode->i_ino);
+		ufs_warning (sb, "ufs_read_inode", "bad inode number (%llu)\n", inode->i_ino);
 		return -1;
 	}
 
 	bh = sb_bread(sb, ufs_inotofsba(inode->i_ino));
 	if (!bh) {
-		ufs_warning (sb, "ufs_read_inode", "unable to read inode %" PRIino "u\n", inode->i_ino);
+		ufs_warning (sb, "ufs_read_inode", "unable to read inode %llu\n", inode->i_ino);
 		return -1;
 	}
 	if (uspi->fs_magic == UFS2_MAGIC) {
@@ -891,7 +891,7 @@ static void ufs_trunc_direct(struct inode *inode)
 	unsigned int old_tail, new_tail;
 	struct to_free ctx = {.inode = inode};
 
-	UFSD("ENTER: ino %" PRIino "u\n", inode->i_ino);
+	UFSD("ENTER: ino %llu\n", inode->i_ino);
 
 	new_frags = DIRECT_FRAGMENT;
 	// new_frags = first fragment past the new EOF
@@ -956,7 +956,7 @@ static void ufs_trunc_direct(struct inode *inode)
 		}
 	}
 done:
-	UFSD("EXIT: ino %" PRIino "u\n", inode->i_ino);
+	UFSD("EXIT: ino %llu\n", inode->i_ino);
 }
 
 static void free_full_branch(struct inode *inode, u64 ind_block, int depth)
@@ -1169,7 +1169,7 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 {
 	int err = 0;
 
-	UFSD("ENTER: ino %" PRIino "u, i_size: %llu, old_i_size: %llu\n",
+	UFSD("ENTER: ino %llu, i_size: %llu, old_i_size: %llu\n",
 	     inode->i_ino, (unsigned long long)size,
 	     (unsigned long long)i_size_read(inode));
 
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 9acb59697d85015e83cd1e59ffbccb5452e6dd2d..dff6f74618def7bd5687bd7427f3001a78b708b8 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -203,7 +203,7 @@ struct folio *ufs_get_locked_folio(struct address_space *mapping,
 		folio = read_mapping_folio(mapping, index, NULL);
 
 		if (IS_ERR(folio)) {
-			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %" PRIino "u, index: %lu\n",
+			printk(KERN_ERR "ufs_change_blocknr: read_mapping_folio error: ino %llu, index: %lu\n",
 			       mapping->host->i_ino, index);
 			return folio;
 		}

-- 
2.53.0


