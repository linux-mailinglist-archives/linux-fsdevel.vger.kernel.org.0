Return-Path: <linux-fsdevel+bounces-79046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEHmJdEIpmm9JAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:01:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F691E4886
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16A493107150
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F0492508;
	Mon,  2 Mar 2026 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvovHTO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E33CA498;
	Mon,  2 Mar 2026 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484279; cv=none; b=atKwulMa3JU3pJ2WQFlR7gfol1lM/gh2AUwwbMNbyQvltAK9lgsc5tMW6wbMCrJoUSNA19tKbMTnKZU1CgRf/p4UGJmyVIQfD+HBsxhY3GIfsTepdpM9AnpxZnB00G63eYhCGf5uNs9BewhYcx08GYGDDoqdNyMI0rsmlAdbiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484279; c=relaxed/simple;
	bh=GpoXSAIQgn/BIYS+Nk/tCtiWihZ//MwJ8Zy+f0Lcga8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQmpG6YdGLOJyf0qXs9G/tILAhJlByKrNJj0HoZLj++zZV7i9tPctNxc5b8nWDiSSEkBVKyUOjL+W8ICRShPCwo+zMnvc0LwyQgq3CeoFkaAvxwfiJ7YjBTiJFalQ4sZ/Luewrtu74miO5F6cr9SkL59jGhxbKyLX6+ARCx/diQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvovHTO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C6FC19423;
	Mon,  2 Mar 2026 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484278;
	bh=GpoXSAIQgn/BIYS+Nk/tCtiWihZ//MwJ8Zy+f0Lcga8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AvovHTO067lyD+ZjLSJpxY8Wfw6m9TS/lKDW0wYVJy3tppLbQMr8Ut2Werk5RAzh7
	 5KCcz3HhSNdectg1M7MN30RacrgFHJ8UIK6NS8T71v3uwCcpRW/GYiqX4b4hckooEf
	 fu4M8605uVLHr5jcw865Tso/y2e2Iyy1FA77WWGpp74pLjRpDTwfd5Z9HcBTnNehBW
	 M/7LNqlLha5XlqxCXpG1215wLFSBEqq8XiFeqoZpji3oBYvjuoyucMQKt2lSvIMgsl
	 zSw5iI8JrNs9fqMgeqHzBBgEaK0KLZ+BLOkM57mupMWF2U2/Qy8A2GWonfGOyzElBB
	 xSRHW5m4oMAvQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:25:06 -0500
Subject: [PATCH v2 082/110] ext2: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-82-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6275; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GpoXSAIQgn/BIYS+Nk/tCtiWihZ//MwJ8Zy+f0Lcga8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIFeUYeRSPse4fCxGgNDYIK+l25DrEjdBbN4
 hMW8oJt+9eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyBQAKCRAADmhBGVaC
 FbgtD/9SGi4ZCAigckE5c0j0w/wNI20Kmd/l9hEx1qxDeDfpdAF7/czQKFnBM80YvdtzNq8HIHT
 khCVNvYdgyxo45oTfevabzGB3sZlj94WJ96jQ7cfAH13fpM7LxdiQuIFbpilCWaog8iIzdMYbPe
 jJOL9b5e5O4J6AcC9M8BZLZhvegN+9cQ7ynZiq4wK2tyzTa/if4CM+2Jkg15OjZ54f+WPm+kr/V
 N1/jvzNuOncAgK+UOfVFAydqc3nZamV0MXvH3bABFfLxMyZSwb8sKhrEwMlEMWNYvJjXrpsF11+
 l2dEPYn8+l/sZL8zSa5Pr1PgOPe6+CMBXBR6GkjcVn/G/rbMVhapqpOV6TUCpG0eiVW/DqZv3nO
 dOy0FeQgJ1vgf9MuEPuqMZlDHrFBSDmXSmBaoyQfu3ffHRHg8sSjB5isPrsxeoDsYdPCvbKIB8A
 umvDGu8/OecEbapCjXPQkhWhOJdDrxlUNhDZ+ecWs4g/cNVcc6d9tRJlm0gr8NQ9e7ikHZVbk3Y
 tHynxNQ3AXXy4OvvcQ9knjlsFR4v2nZcYJ4f2IEZNtUwfAPHRFuZ0tl60/rIX1Nl5sd5m/dBUDK
 X7pd97Xzq79QQ2r0CqkX/GF8KMEnXj+eG5FMjm3KkGNi7q7irme8pm7/bfBXeRxujbnXuPQbkft
 Dcpv+qu8GeHoDGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: A5F691E4886
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79046-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in ext2 with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext2/dir.c    | 10 +++++-----
 fs/ext2/ialloc.c |  2 +-
 fs/ext2/inode.c  |  2 +-
 fs/ext2/xattr.c  | 14 +++++++-------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index f87106907da31bb7c1ca65c0ec2dcc0d47d27c62..278d4be8ecbe7790204b5ba985a7ce088fadb181 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -141,7 +141,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
 Ebadsize:
 	if (!quiet)
 		ext2_error(sb, __func__,
-			"size of directory #%" PRIino "u is not a multiple "
+			"size of directory #%llu is not a multiple "
 			"of chunk size", dir->i_ino);
 	goto fail;
 Eshort:
@@ -160,7 +160,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
 	error = "inode out of bounds";
 bad_entry:
 	if (!quiet)
-		ext2_error(sb, __func__, "bad entry in directory #%" PRIino "u: : %s - "
+		ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
 			"offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
 			dir->i_ino, error, folio_pos(folio) + offs,
 			(unsigned long) le32_to_cpu(p->inode),
@@ -170,7 +170,7 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
 	if (!quiet) {
 		p = (ext2_dirent *)(kaddr + offs);
 		ext2_error(sb, "ext2_check_folio",
-			"entry in directory #%" PRIino "u spans the page boundary"
+			"entry in directory #%llu spans the page boundary"
 			"offset=%llu, inode=%lu",
 			dir->i_ino, folio_pos(folio) + offs,
 			(unsigned long) le32_to_cpu(p->inode));
@@ -281,7 +281,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 
 		if (IS_ERR(kaddr)) {
 			ext2_error(sb, __func__,
-				   "bad page in #%" PRIino "u",
+				   "bad page in #%llu",
 				   inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return PTR_ERR(kaddr);
@@ -383,7 +383,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 		/* next folio is past the blocks we've got */
 		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
 			ext2_error(dir->i_sb, __func__,
-				"dir %" PRIino "u size %lld exceeds block count %llu",
+				"dir %llu size %lld exceeds block count %llu",
 				dir->i_ino, dir->i_size,
 				(unsigned long long)dir->i_blocks);
 			goto out;
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 6a317411e54191578343308b5a3990aea9c36436..bf21b57cf98cd5f90e1177454a8fd5cca482c2f8 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -590,7 +590,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 		goto fail_free_drop;
 
 	mark_inode_dirty(inode);
-	ext2_debug("allocating inode %" PRIino "u\n", inode->i_ino);
+	ext2_debug("allocating inode %llu\n", inode->i_ino);
 	ext2_preread_inode(inode);
 	return inode;
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 0ca9148583646812b478f01fd35bcad11498f951..45286c0c3b6b8f86a1ecec0e2f545c5a678dd6ac 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1152,7 +1152,7 @@ static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int de
 			 */ 
 			if (!bh) {
 				ext2_error(inode->i_sb, "ext2_free_branches",
-					"Read failure, inode=%" PRIino "u, block=%ld",
+					"Read failure, inode=%llu, block=%ld",
 					inode->i_ino, nr);
 				continue;
 			}
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 4b3dadc0a2a47c85682d9c74edb900cf0f20996f..14ada70db36a76d1436944a3622e5caf0b373b9e 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -227,7 +227,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	if (!ext2_xattr_header_valid(HDR(bh))) {
 bad_block:
 		ext2_error(inode->i_sb, "ext2_xattr_get",
-			"inode %" PRIino "u: bad block %d", inode->i_ino,
+			"inode %llu: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -313,7 +313,7 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	if (!ext2_xattr_header_valid(HDR(bh))) {
 bad_block:
 		ext2_error(inode->i_sb, "ext2_xattr_list",
-			"inode %" PRIino "u: bad block %d", inode->i_ino,
+			"inode %llu: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -454,7 +454,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (!ext2_xattr_header_valid(header)) {
 bad_block:
 			ext2_error(sb, "ext2_xattr_set",
-				"inode %" PRIino "u: bad block %d", inode->i_ino,
+				"inode %llu: bad block %d", inode->i_ino,
 				   EXT2_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -833,7 +833,7 @@ ext2_xattr_delete_inode(struct inode *inode)
 
 	if (!ext2_data_block_valid(sbi, EXT2_I(inode)->i_file_acl, 1)) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %" PRIino "u: xattr block %d is out of data blocks range",
+			"inode %llu: xattr block %d is out of data blocks range",
 			inode->i_ino, EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -841,14 +841,14 @@ ext2_xattr_delete_inode(struct inode *inode)
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	if (!bh) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %" PRIino "u: block %d read error", inode->i_ino,
+			"inode %llu: block %d read error", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
 	if (!ext2_xattr_header_valid(HDR(bh))) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %" PRIino "u: bad block %d", inode->i_ino,
+			"inode %llu: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -952,7 +952,7 @@ ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
 		bh = sb_bread(inode->i_sb, ce->e_value);
 		if (!bh) {
 			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
-				"inode %" PRIino "u: block %ld read error",
+				"inode %llu: block %ld read error",
 				inode->i_ino, (unsigned long) ce->e_value);
 		} else {
 			lock_buffer(bh);

-- 
2.53.0


