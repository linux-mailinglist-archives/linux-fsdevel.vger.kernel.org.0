Return-Path: <linux-fsdevel+bounces-79043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHWPCwkDpmmzIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:37:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0AF1E37D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A94331EAC3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA70351F7A;
	Mon,  2 Mar 2026 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhc0/IGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0587833F585;
	Mon,  2 Mar 2026 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484236; cv=none; b=IBouPy+4Ql48Y15sApTyig5tEOMPu7kUbvgpdcDvE21kMYxpwXmcVLQXMa6v65+67NiQv1JZNA3TGPMr7Sk7y3cnrphaj49if9zcKJ1xzw7uJQ/OI2RcYPV4J1dRAkddOIEn+4qKogayQ2FPepxZm94HAZ/nohcC9LXciaAvjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484236; c=relaxed/simple;
	bh=UOAEYynzD6EMQO6Y3DFiwCQHZhBo1KFizd/HOCrLZgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSecLGhoUw6Bk2yPjthAbWkY7103NWYvp5AsTWWFMXCIZ/nZaQD5q497MDl40YmW07MM1A8f2NopXXIrSO0KhprYJrQQ2EWWa+YZn7TOiUCSkWaOgATOowRB+hybL1SuSf37all5PVvxbAaW5QSBaHyafLVmlms39av4nBmGbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhc0/IGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE0C19423;
	Mon,  2 Mar 2026 20:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484235;
	bh=UOAEYynzD6EMQO6Y3DFiwCQHZhBo1KFizd/HOCrLZgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dhc0/IGxPCWnAO0jbCZROqeyev75wTetSuhR6IVoinPu4E1gWULuPW4d5RiCaQGEq
	 AFbJS55ArLRvwhpdmdATFnAdV0GUJHkRI3c8w1lWlz3ULpT5gMFFEEoZv5zxdEh+a7
	 kWoTA8Mk05bOqAWXdm3f3WCB6WTdqX7BD86y6lIXQKLSwMy3JakIrO9m47wKxJP4JF
	 KPqpqKefVELZWgjK5sG4D+uYNah9CKSQNKZQKj2pY81fYHyBvUMEVBQSlmrCirpWP2
	 8HzfNIdRTpBmtfbpFzPS9EKOpiBjNqjl/Nju19PccEHTVt4QgowIaIMeaHdzeWBE0+
	 /SqM2z5f7dvRQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:25:03 -0500
Subject: [PATCH v2 079/110] ecryptfs: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-79-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UOAEYynzD6EMQO6Y3DFiwCQHZhBo1KFizd/HOCrLZgw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIEOuphnEavDEIC3+G9bP/yGebCzlr8YPYv6
 f7CLhYHSnWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyBAAKCRAADmhBGVaC
 FTOOEACXi4R2sd3xPPG8cv+3X/RfWdB69ekqMDYPyJQsUVp6n/yLGDiQtqcTUVfgmrBB+6AJfRc
 YvpZ4LYwGC/BOekpbEQMk/XhiiLvGO5X9Uu8z3giqLLoQN/4f5oLT0F0Evqf1T87s33bKV4IXQG
 dl3gDdHNA/IK3VCypwTH4d6HIR/jmnIvEMwDOuwSPc9rezoO12Mn07KPTb/5r2ZOCP9cqiOgeFP
 8LLRk4PwVfkg1MC+BirRPJ/TVcYIIj3OgrHimnANR+BqG9u9avtjVDTTZ4eJfRBUlLTRGqMpACK
 FTA/g/fmcCr3LujF1e6yqKdEBaEIpi8N6ShH8dbh08vCuRiriFQd6Ty4jS/Cwn8i8BXIs60W4tf
 zy6N4OdstOOea6o5cLIKf0LjXynUSwR1YOv/LtkqsRa0gFXvPo+Iw9mLx2mSzEkYvxRzfhClFhf
 KfEoeOggJflUZdvIuYRnc5RuqCu9Ce0iDQmEfrmAUD2Xe7sZa4kfmQPVUJbG4vB12lyTueZHPmw
 1ZxUfjFGzwwk2epkGp2/HFuwDeYbYbVDNz3AqQ+6IUDkwr773Dt1lAhomV2+/xE2euDce/ytt1g
 OxRCuhXWvvLoDd92q7M5PNh/vGHe5FtHtwx/XaxI9w/OBs0+Izqtj1WHqE/4lL8IDUevPGhzYf+
 ekbd6QBV6PaqQWQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: CC0AF1E37D6
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
	TAGGED_FROM(0.00)[bounces-79043-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in ecryptfs with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ecryptfs/crypto.c | 6 +++---
 fs/ecryptfs/file.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 015b2e4ee11cba5b734d1f8fcd851accfa8f0481..f25c9a49e251a591695a143f64d1a81c5211ec18 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1313,7 +1313,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 		rc = ecryptfs_read_xattr_region(page_virt, ecryptfs_inode);
 		if (rc) {
 			printk(KERN_DEBUG "Valid eCryptfs headers not found in "
-			       "file header region or xattr region, inode %" PRIino "u\n",
+			       "file header region or xattr region, inode %llu\n",
 				ecryptfs_inode->i_ino);
 			rc = -EINVAL;
 			goto out;
@@ -1323,7 +1323,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 						ECRYPTFS_DONT_VALIDATE_HEADER_SIZE);
 		if (rc) {
 			printk(KERN_DEBUG "Valid eCryptfs headers not found in "
-			       "file xattr region either, inode %" PRIino "u\n",
+			       "file xattr region either, inode %llu\n",
 				ecryptfs_inode->i_ino);
 			rc = -EINVAL;
 		}
@@ -1335,7 +1335,7 @@ int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry)
 			       "crypto metadata only in the extended attribute "
 			       "region, but eCryptfs was mounted without "
 			       "xattr support enabled. eCryptfs will not treat "
-			       "this like an encrypted file, inode %" PRIino "u\n",
+			       "this like an encrypted file, inode %llu\n",
 				ecryptfs_inode->i_ino);
 			rc = -EINVAL;
 		}
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 9eff00cfbc46c5fbd599252dcc4434fceafb7223..49b0fbe0428a2d202434ce4b5fd7d82d2a63cf58 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -253,7 +253,7 @@ static int ecryptfs_open(struct inode *inode, struct file *file)
 	if (rc)
 		goto out_put;
 	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = "
-			"[0x%.16" PRIino "x] size: [0x%.16llx]\n", inode, inode->i_ino,
+			"[0x%.16llx] size: [0x%.16llx]\n", inode, inode->i_ino,
 			(unsigned long long)i_size_read(inode));
 	goto out;
 out_put:

-- 
2.53.0


