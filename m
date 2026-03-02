Return-Path: <linux-fsdevel+bounces-79049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADptCPwDpmnvIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:41:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2581E3B64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BB2A306514B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CEF49250B;
	Mon,  2 Mar 2026 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcG9rlTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8333CE49B;
	Mon,  2 Mar 2026 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484321; cv=none; b=NcmKzM0keTYPUvLmcwfzMy3xT3cVnjcJ/KMOq9siSd/SifbouoBMOS5xTw+PxVsvCqZ0dajn1KFyxaHWW4j3wGIIYSVIgEr7htwPulp9AJscKk0BEpUyDaEjHyVwzbbFk25iUKq5FcEbA9w+9/hZTdDJMw2QugOGn7R4m5Y8z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484321; c=relaxed/simple;
	bh=hXZa7KMq0thqNyf3M2ptoW/dddwHvltqq9Ic1Sx2+m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mbo8VToGRHg1r8mqDTb+n3oiNoyzoubHnaTNeIWdNxMCGioDZd5/FVunOcs/t6II2Z2MgXErSm9tQSNy5c0pEvCVGemil2XHgEOZRwVKKe9jz2den5RpKMEdgRrE8ylyzpJQMwXj87FACQGHr8Vu+i8o5ToR1yIw47tDXRnlQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcG9rlTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5BFC19423;
	Mon,  2 Mar 2026 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484321;
	bh=hXZa7KMq0thqNyf3M2ptoW/dddwHvltqq9Ic1Sx2+m4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pcG9rlTnEqBa4+qhvGpZ9dgf1tP86eL/AQxOFeaV48xtNdFjK6DO691QO4GdUUWx6
	 rhtzufD0On501TB1/TqgED73jZgl6cinyiFDSXjV1j/KiqBZ8WQaybUyLo5j7EW8wK
	 AQmjfdhk4/it2n9DU50WJQcunG/RV4aqE5UlXG5lEnWrWCCCMUF2WFg1rVp3ZJxrWh
	 qwWoUajgEAuE8Jcm83RHVW6od8cFFapYlaDRHBiW/U0zDpQ24//yGxE0FYy5fnrYei
	 YonE1g93IxukqssEdeX8PpUWwDwvJVEmwBnHYoRhAwmCbLT91cVrg4Op47V31jGeBP
	 dP/NemM98K3xA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:25:09 -0500
Subject: [PATCH v2 085/110] hfsplus: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-85-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9695; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hXZa7KMq0thqNyf3M2ptoW/dddwHvltqq9Ic1Sx2+m4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIGI6mtXlw4jltNkiZO3yOQTAZCguLk6KmrG
 aLE4661BuWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyBgAKCRAADmhBGVaC
 FbzkD/9mMMSqjUxSShVq5p+gmO4O0xxbgB/rm1XXmGLb85uUh7io3vVAKAv0tvOy8n+KZFj6ABn
 pBdo2DCgqxdlefyAA8IRaID/zK8evjcLGNjfvkWy2n8lHsqebSE5r3Wrgk1FaCmUi691r6fZBHi
 txOOs0A+NH+NVxCq6q+i0j2VkbErfh1ok83PjSZf115YzWgZ5aM96+MrQnunRMIyhgMdS69Qi22
 yDMhToXagfPir17CCUFDLJC71uSruJGPxh/gQFfW3rOODLJO4a5S6JCO8AMjP29BCM8g4qGDgwE
 B7KBeV6PJlqB9xsksXoloWcb8HEuNICacscC/yEcjAKjaAYVj4mKmoNemYOeN1TTo6enqNxV5Zh
 ij8j7Zyr6uvxYFqn5ZO/clL3Vl095OzH4gUAPxo83nilYLvscWCd+fo174Q2jCMGkzQKDKLmD9D
 uaDLXFIF1zVB/HeH17woowdt0DVJbU38mwrsjciAJ9nxjHEU/w6XEuHcnOPVL7PrL9WxoyMjXyq
 L0hVjLOhxRRv5DGbe6bGT4CzdVkDG7IqQAWlN1/G+48r1vSJeU0CnSFUgSKKpNjU6BjSQMRNsBJ
 pE0sLA8LAQe+BsrMOF8A3ddLa/2rh1ImGZSonPuvL2j8Ia3GAYwMpB8AqTnTsc6qPriWWpvcJNQ
 GNagc/MtRR9bIZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 8D2581E3B64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79049-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,str.name:url]
X-Rspamd-Action: no action

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in hfsplus with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hfsplus/attributes.c | 10 +++++-----
 fs/hfsplus/catalog.c    |  2 +-
 fs/hfsplus/dir.c        |  6 +++---
 fs/hfsplus/extents.c    |  6 +++---
 fs/hfsplus/inode.c      |  8 ++++----
 fs/hfsplus/super.c      |  6 +++---
 fs/hfsplus/xattr.c      | 10 +++++-----
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index d0b3f58166a057c0a5bf2e41cf6fc839798c0ded..174cd13106ad66008a120e3e70984be7cb42a65f 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -203,7 +203,7 @@ int hfsplus_create_attr_nolock(struct inode *inode, const char *name,
 	int entry_size;
 	int err;
 
-	hfs_dbg("name %s, ino %" PRIino "u\n",
+	hfs_dbg("name %s, ino %llu\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (name) {
@@ -255,7 +255,7 @@ int hfsplus_create_attr(struct inode *inode,
 	hfsplus_attr_entry *entry_ptr;
 	int err;
 
-	hfs_dbg("name %s, ino %" PRIino "u\n",
+	hfs_dbg("name %s, ino %llu\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (!HFSPLUS_SB(sb)->attr_tree) {
@@ -337,7 +337,7 @@ int hfsplus_delete_attr_nolock(struct inode *inode, const char *name,
 	struct super_block *sb = inode->i_sb;
 	int err;
 
-	hfs_dbg("name %s, ino %" PRIino "u\n",
+	hfs_dbg("name %s, ino %llu\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (name) {
@@ -367,7 +367,7 @@ int hfsplus_delete_attr(struct inode *inode, const char *name)
 	struct super_block *sb = inode->i_sb;
 	struct hfs_find_data fd;
 
-	hfs_dbg("name %s, ino %" PRIino "u\n",
+	hfs_dbg("name %s, ino %llu\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (!HFSPLUS_SB(sb)->attr_tree) {
@@ -436,7 +436,7 @@ int hfsplus_replace_attr(struct inode *inode,
 	hfsplus_attr_entry *entry_ptr;
 	int err = 0;
 
-	hfs_dbg("name %s, ino %" PRIino "u\n",
+	hfs_dbg("name %s, ino %llu\n",
 		name ? name : NULL, inode->i_ino);
 
 	if (!HFSPLUS_SB(sb)->attr_tree) {
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index d422f117c60dee6fd8ece0d01d4ce66e04421e4a..0e961e99b9856ab7d95da5d070b4fbce1e67ebde 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
 	int entry_size, type;
 	int err;
 
-	hfs_dbg("cnid %u - ino %" PRIino "u, name %s - ino %" PRIino "u, name %s\n",
+	hfs_dbg("cnid %u - ino %llu, name %s - ino %llu, name %s\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index e701b11437f09172f88d68b4e4f5998591572b38..054f6da46033404bbbcf299beb5d8765495c0de3 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -313,7 +313,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	if (!S_ISREG(inode->i_mode))
 		return -EPERM;
 
-	hfs_dbg("src_dir->i_ino %" PRIino "u, dst_dir->i_ino %" PRIino "u, inode->i_ino %" PRIino "u\n",
+	hfs_dbg("src_dir->i_ino %llu, dst_dir->i_ino %llu, inode->i_ino %llu\n",
 		src_dir->i_ino, dst_dir->i_ino, inode->i_ino);
 
 	mutex_lock(&sbi->vh_mutex);
@@ -385,7 +385,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 	if (HFSPLUS_IS_RSRC(inode))
 		return -EPERM;
 
-	hfs_dbg("dir->i_ino %" PRIino "u, inode->i_ino %" PRIino "u\n",
+	hfs_dbg("dir->i_ino %llu, inode->i_ino %llu\n",
 		dir->i_ino, inode->i_ino);
 
 	mutex_lock(&sbi->vh_mutex);
@@ -393,7 +393,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_ino == cnid &&
 	    atomic_read(&HFSPLUS_I(inode)->opencnt)) {
 		str.name = name;
-		str.len = sprintf(name, "temp%" PRIino "u", inode->i_ino);
+		str.len = sprintf(name, "temp%llu", inode->i_ino);
 		res = hfsplus_rename_cat(inode->i_ino,
 					 dir, &dentry->d_name,
 					 sbi->hidden_dir, &str);
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 1dbfdf44f954f2768852678d1e386a91758848f9..474fde1a1653be6cf74b26e757c6d8a6f8d2906a 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	mutex_unlock(&hip->extents_lock);
 
 done:
-	hfs_dbg("ino %" PRIino "u, iblock %llu - dblock %u\n",
+	hfs_dbg("ino %llu, iblock %llu - dblock %u\n",
 		inode->i_ino, (long long)iblock, dblock);
 
 	mask = (1 << sbi->fs_shift) - 1;
@@ -476,7 +476,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 			goto out;
 	}
 
-	hfs_dbg("ino %" PRIino "u, start %u, len %u\n", inode->i_ino, start, len);
+	hfs_dbg("ino %llu, start %u, len %u\n", inode->i_ino, start, len);
 
 	if (hip->alloc_blocks <= hip->first_blocks) {
 		if (!hip->first_blocks) {
@@ -545,7 +545,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	u32 alloc_cnt, blk_cnt, start;
 	int res;
 
-	hfs_dbg("ino %" PRIino "u, phys_size %llu -> i_size %llu\n",
+	hfs_dbg("ino %llu, phys_size %llu -> i_size %llu\n",
 		inode->i_ino, (long long)hip->phys_size, inode->i_size);
 
 	if (inode->i_size > hip->phys_size) {
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index f61397db976e8b15fa186c3b31af71e55f9e26a6..02be32dc6833dfdd767c407ec0263485d1a2c3c6 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -230,7 +230,7 @@ static int hfsplus_get_perms(struct inode *inode,
 		inode->i_flags &= ~S_APPEND;
 	return 0;
 bad_type:
-	pr_err("invalid file type 0%04o for inode %" PRIino "u\n", mode, inode->i_ino);
+	pr_err("invalid file type 0%04o for inode %llu\n", mode, inode->i_ino);
 	return -EIO;
 }
 
@@ -328,7 +328,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	int error = 0, error2;
 
-	hfs_dbg("inode->i_ino %" PRIino "u, start %llu, end %llu\n",
+	hfs_dbg("inode->i_ino %llu, start %llu, end %llu\n",
 		inode->i_ino, start, end);
 
 	error = file_write_and_wait_range(file, start, end);
@@ -639,7 +639,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	hfsplus_cat_entry entry;
 	int res = 0;
 
-	hfs_dbg("inode->i_ino %" PRIino "u\n", inode->i_ino);
+	hfs_dbg("inode->i_ino %llu\n", inode->i_ino);
 
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -716,7 +716,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (!res) {
 		res = hfs_btree_write(tree);
 		if (res) {
-			pr_err("b-tree write err: %d, ino %" PRIino "u\n",
+			pr_err("b-tree write err: %d, ino %llu\n",
 			       res, inode->i_ino);
 		}
 	}
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index b76865e2eac5260b681fc46b297f1665f1bc10da..b3917249c206c3a25fe98b39a5eb2168b7404dc2 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -156,7 +156,7 @@ static int hfsplus_system_write_inode(struct inode *inode)
 		int err = hfs_btree_write(tree);
 
 		if (err) {
-			pr_err("b-tree write err: %d, ino %" PRIino "u\n",
+			pr_err("b-tree write err: %d, ino %llu\n",
 			       err, inode->i_ino);
 			return err;
 		}
@@ -169,7 +169,7 @@ static int hfsplus_write_inode(struct inode *inode,
 {
 	int err;
 
-	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
+	hfs_dbg("ino %llu\n", inode->i_ino);
 
 	err = hfsplus_ext_write_extent(inode);
 	if (err)
@@ -184,7 +184,7 @@ static int hfsplus_write_inode(struct inode *inode,
 
 static void hfsplus_evict_inode(struct inode *inode)
 {
-	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
+	hfs_dbg("ino %llu\n", inode->i_ino);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (HFSPLUS_IS_RSRC(inode)) {
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index ef9121843482e81961fa541c53c906ab04d6fc33..c70bb6f494b22b1e3f74e18a9ef378e0c87f8194 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -277,7 +277,7 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	u16 folder_finderinfo_len = sizeof(DInfo) + sizeof(DXInfo);
 	u16 file_finderinfo_len = sizeof(FInfo) + sizeof(FXInfo);
 
-	hfs_dbg("ino %" PRIino "u, name %s, value %p, size %zu\n",
+	hfs_dbg("ino %llu, name %s, value %p, size %zu\n",
 		inode->i_ino, name ? name : NULL,
 		value, size);
 
@@ -447,7 +447,7 @@ int hfsplus_setxattr(struct inode *inode, const char *name,
 		NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1;
 	int res;
 
-	hfs_dbg("ino %" PRIino "u, name %s, prefix %s, prefixlen %zu, "
+	hfs_dbg("ino %llu, name %s, prefix %s, prefixlen %zu, "
 		"value %p, size %zu\n",
 		inode->i_ino, name ? name : NULL,
 		prefix ? prefix : NULL, prefixlen,
@@ -607,7 +607,7 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 	int res;
 	char *xattr_name;
 
-	hfs_dbg("ino %" PRIino "u, name %s, prefix %s\n",
+	hfs_dbg("ino %llu, name %s, prefix %s\n",
 		inode->i_ino, name ? name : NULL,
 		prefix ? prefix : NULL);
 
@@ -717,7 +717,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	size_t strbuf_size;
 	int xattr_name_len;
 
-	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
+	hfs_dbg("ino %llu\n", inode->i_ino);
 
 	if (!is_xattr_operation_supported(inode))
 		return -EOPNOTSUPP;
@@ -819,7 +819,7 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 	int is_xattr_acl_deleted;
 	int is_all_xattrs_deleted;
 
-	hfs_dbg("ino %" PRIino "u, name %s\n",
+	hfs_dbg("ino %llu, name %s\n",
 		inode->i_ino, name ? name : NULL);
 
 	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)

-- 
2.53.0


