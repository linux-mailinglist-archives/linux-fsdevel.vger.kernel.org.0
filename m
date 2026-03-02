Return-Path: <linux-fsdevel+bounces-78993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOV7K+78pWkOIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:11:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE11E1F10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313F33749E74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CE31E844;
	Mon,  2 Mar 2026 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeqjF7Mo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1548122C;
	Mon,  2 Mar 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483547; cv=none; b=KCjNzvd6bHpgJDYwAvn35OQhpxC3ZEgiONF88sPx2wExdpA5+xokrmgkhbUiFb+sdD7xy6k8fyQqvibuXlUy+PspoqZShtZ6plrbPLMS9Xlj+v9kE1Gw1ga6ENaCvtpnZOQHy8bHBe3UcAiWut9TVSEPKVHqpzxi5sVizR4vYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483547; c=relaxed/simple;
	bh=4zZLVZosTMapzlnQbViChZRIJwQ1YxnweV1e0IzMxKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grFAJOPHG0KrM3ZWZtKEruEcjMMEwy1esWRrVhFmSYwF8oxQpFiciDr+/9vvbDfZe4WNYBSdf3As/xdWQ/dpPa68dFkfFZG+xXWO7uB0gKd/BG1Mywrl9UrTUSCWDDFqfMohd4PyeZ7DmESz9K/vjxvl0qm+vLkrf2JUFJdTClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeqjF7Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862C6C2BCAF;
	Mon,  2 Mar 2026 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483546;
	bh=4zZLVZosTMapzlnQbViChZRIJwQ1YxnweV1e0IzMxKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EeqjF7MoRlh/kOdenMQlIQE0g82iImB4Uqc17fvZNGHc9MCYhZRKQUrzHwrNeRq2p
	 BBd77tlP32HU+4aiXzIYfNufQXBt3X8waKSDljOzULdc2ZzPgaNbJuziGiAeIjrdwT
	 DwOQXm3XqIrKfCh6JfQAi71zjeYrPS7NwYlDS54RXNALxFlh84pcNKXllQMlS0+rWr
	 ObIc83qr4E1Ng8CJup4HLyksU6saNDa39jLQWyCxqJyFgFOMzbY9U3+kcB3HNXDaoI
	 S35PTiTtQsrGJUXNbJoGHIJr8oB2LXx/1BDWJzcsUHPVjDCcrGKCuxlFpzcMVIXDc0
	 8djRYyhYmSagQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:15 -0500
Subject: [PATCH v2 031/110] hfs: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-31-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4zZLVZosTMapzlnQbViChZRIJwQ1YxnweV1e0IzMxKk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfH3/7MIAGsUTXCwQG56/sekwpotJydX2UJpS
 A4cYEttsOSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx9wAKCRAADmhBGVaC
 FQm3D/oD/nBEETcBUTWgdz+XCetI2Fr0jbRxFfuFvOIBZ6EGdtu5UWMBtyOxFVVjs3diIrb4PTx
 /M8z8MRQrujiBZ4E1XZeTgynSueGxnTAZdQK3vCRI9BrRqRDs+Yqxyg5LgkCINzS2rmO70woRVw
 OsAptb/wdU9AQLyMsGwgsTueVaN9omGgS/50G3uN/3cQm/WYKeCClkRPGzRRIEfIUKtmQnNRhfv
 C1HTPxtq5w+ThSVEdCtjAG8OakcLP+cMFfDX4T6rBRIFEr/N95umFouZ0cHCjabDE9DaxWjhtm1
 BrKedqbNpn5enrOcdwU866m2oqgdji5QoHO0aBgHdXGHjIKdjtC8+NxylR7FqU+p1hFOZQCzFQK
 c7PLmGif/brK7rUao2mM438Zeh2abJAZXdMKrguZv1XVRWcO2XYGS4Viptsjzh0rzDfuTY6d78J
 moge0sjDLD+JozJi7HqQNserJ5xdGDzrmj2Opw7TMXfGsZBX4gaZIyf5iCGi6BBn58ZI9fT4bFt
 G8dW3lXq3s7O/GNGaf7/QQ35FnNZP86XcmMYGbHbET0dD8V/ps6xfb3Q8rWCfYxot7GEGOvelP5
 m546feb2CKU8E0nSiVk3DL254B1ZNgEchgRGxtBtn2OzKVLBwwPIsy59/W+qr77Q/YZosjsT5qQ
 YzATlmVEc4NMI+w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 34FE11E1F10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78993-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert hfs i_ino format strings to use the PRIino format
macro in preparation for the widening of i_ino via kino_t.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hfs/catalog.c | 2 +-
 fs/hfs/extent.c  | 4 ++--
 fs/hfs/inode.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index b80ba40e38776123759df4b85c7f65daa19c6436..b07c0a3ffc61584165e8cc9f646de6066a6ad2c9 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -417,7 +417,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	int entry_size, type;
 	int err;
 
-	hfs_dbg("cnid %u - (ino %lu, name %s) - (ino %lu, name %s)\n",
+	hfs_dbg("cnid %u - (ino %" PRIino "u, name %s) - (ino %" PRIino "u, name %s)\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
 	sb = src_dir->i_sb;
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index a097908b269d0ad1575847dd01d6d4a4538262bf..60875cc23880b758bbbb5e4b8281d9ee1f2dbcbb 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -411,7 +411,7 @@ int hfs_extend_file(struct inode *inode)
 		goto out;
 	}
 
-	hfs_dbg("ino %lu, start %u, len %u\n", inode->i_ino, start, len);
+	hfs_dbg("ino %" PRIino "u, start %u, len %u\n", inode->i_ino, start, len);
 	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks) {
 		if (!HFS_I(inode)->first_blocks) {
 			hfs_dbg("first_extent: start %u, len %u\n",
@@ -482,7 +482,7 @@ void hfs_file_truncate(struct inode *inode)
 	u32 size;
 	int res;
 
-	hfs_dbg("ino %lu, phys_size %llu -> i_size %llu\n",
+	hfs_dbg("ino %" PRIino "u, phys_size %llu -> i_size %llu\n",
 		inode->i_ino, (long long)HFS_I(inode)->phys_size,
 		inode->i_size);
 	if (inode->i_size > HFS_I(inode)->phys_size) {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d679995cd1f5c215f56c5258c3c720..b19866525c1e9c43decf3a943c709922ee8630f6 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -270,7 +270,7 @@ void hfs_delete_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
-	hfs_dbg("ino %lu\n", inode->i_ino);
+	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
@@ -455,7 +455,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	hfs_cat_rec rec;
 	int res;
 
-	hfs_dbg("ino %lu\n", inode->i_ino);
+	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
 	res = hfs_ext_write_extent(inode);
 	if (res)
 		return res;

-- 
2.53.0


