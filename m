Return-Path: <linux-fsdevel+bounces-78979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGLhK1b3pWkEIgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:47:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5011E0A0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C92873253801
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182394B8DE5;
	Mon,  2 Mar 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+nTQi3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BE423A6B;
	Mon,  2 Mar 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483345; cv=none; b=ZVi0h6rBw7vK1m3Blco6+o8r0fgHQOnMFid8CkLCLhOYG7GNBACLKZpClf+/KvCEv4JAblVzoRmGjQoVgCte5c6SRRGo+QSrQFyL/GdkJGiF4VRKvOqNYHbqAP4Wg9E+WEg9Mz5qkC2BMrjzVg1jtvbgjZVWSxrtc6sAADaxuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483345; c=relaxed/simple;
	bh=NtXuvezA+fVmFWYFV93EFDUAv4+n19dQNrQ3gSv2IwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8kqmkH166u9GQEtRJE4POgcoH06asgMejogBDzYItsFmUi+h2P/pjLGnYcWAmiFHlw1v0MVb4NUqlMvH/y+xa7aCAIzX/n304+sAOxF2PitwOLlwgjX43WLgl59oh4r4ljI8Gb4x2ZQEWBOrDUWAUpK4i6ZXafIVrjO6s1NJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+nTQi3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6410C19423;
	Mon,  2 Mar 2026 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483345;
	bh=NtXuvezA+fVmFWYFV93EFDUAv4+n19dQNrQ3gSv2IwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g+nTQi3M2TlDWw3pLJS7d1PErJ13vAFGLInMLQ6X/DPiz74GlomWuh6YuI2L6J9bc
	 imJSwzrn8Ew5qv8joOIFQfp+gX4rf9kUJyX516It23Bm4cB5IoNn+swNHLm67EW5I1
	 lYZmaDMUGDUeSPXA/8Xv35qq1CYKLw9pnbdue1P0AYlmQw44zgCxWZ4EZD1PJSnq/D
	 NP5KwTjLibMBDGqmxQjwiCWu+fz6SZmhhvgjTebnuwH9XZv/kruUAZ17LjEUkONW2c
	 tepaj2heDQgvvRY368jor5QPrNzhXvPFY/rmAq7Os2VUsGt++M4LHDG0mK6pqqPPCb
	 WHJdc4NiwtDyA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:01 -0500
Subject: [PATCH v2 017/110] affs: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-17-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12161; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NtXuvezA+fVmFWYFV93EFDUAv4+n19dQNrQ3gSv2IwM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfHze5E3XlYkvSxbn7XunkZktukzc3SEbu4KW
 JWC5dQMQgqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx8wAKCRAADmhBGVaC
 FQFYD/9mHfd8XwdwIhVU6jhexGxl2jp07ERmyXrCCN16tINXOvFEgxA55ciZN+yC7hQ4BrJtnUL
 Rz9ag7Qs/23rBwh8GRfdm9s3YImnOK7XhPMUR/PHhYMNZ9SGPwepN+6V7nDaYn/iBypDM1AyS/g
 HWMz7H9MOP64o6Li+4uXCgMQ1ZSib8d/CfMzmClvYAJV1RdlJHLrX0nrwD9V9lzPdAflK8c1f6/
 5DaJ/XcsfHHNQw0JQYn+S3j0aCMJePoxnnGcPN2QDaQ+qOX6H97Ye1Lq4SnE8yVnTEM1sRmuJrJ
 P8sneFZEu3GI+97R0y+CM2VGGyDPJ2EQlQkWuaEitQ6VpE9yr48T+GLugiqpXbIRUX3WbIo9Wne
 XyAVIhSYtmPjEouSJxvcnwEeG9sDsGH5iPg+GO1AbIfOJg0ZdnKIlIXJFl2JOLaXWKtTqsAz05F
 NRfWS0jQLj73Vy/K+fERWDb0fHztMtZu9HGtZW7SnV6d5vjVIzace225p9O70FEe+4bxqgUi/OO
 H1qyHAsPupMJQHy9wYBVu54HbRDS+R1uidxOzvF75yhVZlmfFu4yErngDb05EbSltDOxLObFdwN
 nMiusSLf2n0wZ+8SyyIjwlS1Dc1XO6S90i7Y3q1w5aCeiX2aYVc8dxCGO48e/w1k0J+wUmOeNpY
 /UrTUuSERGILJfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 2C5011E0A0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78979-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Convert affs i_ino format strings to use the PRIino format
macro in preparation for the widening of i_ino via kino_t.

Also correct signed format specifiers to unsigned, since inode
numbers are unsigned values.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/affs/amigaffs.c |  8 ++++----
 fs/affs/bitmap.c   |  2 +-
 fs/affs/dir.c      |  2 +-
 fs/affs/file.c     | 20 ++++++++++----------
 fs/affs/inode.c    | 12 ++++++------
 fs/affs/namei.c    | 14 +++++++-------
 fs/affs/symlink.c  |  2 +-
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index fd669daa4e7bc951d8d7959c7a5ab1b60b75c61a..0e1939cf27bba0c10d2b657b94f3cd5dbee1a61c 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -33,7 +33,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 	ino = bh->b_blocknr;
 	offset = affs_hash_name(sb, AFFS_TAIL(sb, bh)->name + 1, AFFS_TAIL(sb, bh)->name[0]);
 
-	pr_debug("%s(dir=%lu, ino=%d)\n", __func__, dir->i_ino, ino);
+	pr_debug("%s(dir=%" PRIino "u, ino=%d)\n", __func__, dir->i_ino, ino);
 
 	dir_bh = affs_bread(sb, dir->i_ino);
 	if (!dir_bh)
@@ -83,7 +83,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 	sb = dir->i_sb;
 	rem_ino = rem_bh->b_blocknr;
 	offset = affs_hash_name(sb, AFFS_TAIL(sb, rem_bh)->name+1, AFFS_TAIL(sb, rem_bh)->name[0]);
-	pr_debug("%s(dir=%lu, ino=%d, hashval=%d)\n", __func__, dir->i_ino,
+	pr_debug("%s(dir=%" PRIino "u, ino=%d, hashval=%d)\n", __func__, dir->i_ino,
 		 rem_ino, offset);
 
 	bh = affs_bread(sb, dir->i_ino);
@@ -147,7 +147,7 @@ affs_remove_link(struct dentry *dentry)
 	u32 link_ino, ino;
 	int retval;
 
-	pr_debug("%s(key=%ld)\n", __func__, inode->i_ino);
+	pr_debug("%s(key=%" PRIino "u)\n", __func__, inode->i_ino);
 	retval = -EIO;
 	bh = affs_bread(sb, inode->i_ino);
 	if (!bh)
@@ -279,7 +279,7 @@ affs_remove_header(struct dentry *dentry)
 	if (!inode)
 		goto done;
 
-	pr_debug("%s(key=%ld)\n", __func__, inode->i_ino);
+	pr_debug("%s(key=%" PRIino "u)\n", __func__, inode->i_ino);
 	retval = -EIO;
 	bh = affs_bread(sb, (u32)(long)dentry->d_fsdata);
 	if (!bh)
diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
index 5ba9ef2742f6ee5e903b3df04c5f627fc4fc00ae..904cd5bc5a4bd5719017bf1820a053557c35d67c 100644
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -125,7 +125,7 @@ affs_alloc_block(struct inode *inode, u32 goal)
 	sb = inode->i_sb;
 	sbi = AFFS_SB(sb);
 
-	pr_debug("balloc(inode=%lu,goal=%u): ", inode->i_ino, goal);
+	pr_debug("balloc(inode=%" PRIino "u,goal=%u): ", inode->i_ino, goal);
 
 	if (AFFS_I(inode)->i_pa_cnt) {
 		pr_debug("%d\n", AFFS_I(inode)->i_lastalloc+1);
diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index 5c8d83387a394146f8df2e97af3b65723a076be1..127741d9cac940a45a832bf78b36296dec77cd40 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -90,7 +90,7 @@ affs_readdir(struct file *file, struct dir_context *ctx)
 	u32			 ino;
 	int			 error = 0;
 
-	pr_debug("%s(ino=%lu,f_pos=%llx)\n", __func__, inode->i_ino, ctx->pos);
+	pr_debug("%s(ino=%" PRIino "u,f_pos=%llx)\n", __func__, inode->i_ino, ctx->pos);
 
 	if (ctx->pos < 2) {
 		data->ino = 0;
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 6c9258359ddb9ba344976dd5a9a435f71f3fabc1..e2129cc3411f1cc6cf8bf29fe6740e619554e420 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -24,7 +24,7 @@ static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
 static int
 affs_file_open(struct inode *inode, struct file *filp)
 {
-	pr_debug("open(%lu,%d)\n",
+	pr_debug("open(%" PRIino "u,%d)\n",
 		 inode->i_ino, atomic_read(&AFFS_I(inode)->i_opencnt));
 	atomic_inc(&AFFS_I(inode)->i_opencnt);
 	return 0;
@@ -33,7 +33,7 @@ affs_file_open(struct inode *inode, struct file *filp)
 static int
 affs_file_release(struct inode *inode, struct file *filp)
 {
-	pr_debug("release(%lu, %d)\n",
+	pr_debug("release(%" PRIino "u, %d)\n",
 		 inode->i_ino, atomic_read(&AFFS_I(inode)->i_opencnt));
 
 	if (atomic_dec_and_test(&AFFS_I(inode)->i_opencnt)) {
@@ -301,7 +301,7 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 	struct buffer_head	*ext_bh;
 	u32			 ext;
 
-	pr_debug("%s(%lu, %llu)\n", __func__, inode->i_ino,
+	pr_debug("%s(%" PRIino "u, %llu)\n", __func__, inode->i_ino,
 		 (unsigned long long)block);
 
 	BUG_ON(block > (sector_t)0x7fffffffUL);
@@ -534,7 +534,7 @@ static int affs_do_read_folio_ofs(struct folio *folio, size_t to, int create)
 	size_t bidx, boff, bsize;
 	u32 tmp;
 
-	pr_debug("%s(%lu, %ld, 0, %zu)\n", __func__, inode->i_ino,
+	pr_debug("%s(%" PRIino "u, %ld, 0, %zu)\n", __func__, inode->i_ino,
 		 folio->index, to);
 	BUG_ON(to > folio_size(folio));
 	bsize = AFFS_SB(sb)->s_data_blksize;
@@ -566,7 +566,7 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 	u32 size, bsize;
 	u32 tmp;
 
-	pr_debug("%s(%lu, %d)\n", __func__, inode->i_ino, newsize);
+	pr_debug("%s(%" PRIino "u, %d)\n", __func__, inode->i_ino, newsize);
 	bsize = AFFS_SB(sb)->s_data_blksize;
 	bh = NULL;
 	size = AFFS_I(inode)->mmu_private;
@@ -634,7 +634,7 @@ static int affs_read_folio_ofs(struct file *file, struct folio *folio)
 	size_t to;
 	int err;
 
-	pr_debug("%s(%lu, %ld)\n", __func__, inode->i_ino, folio->index);
+	pr_debug("%s(%" PRIino "u, %ld)\n", __func__, inode->i_ino, folio->index);
 	to = folio_size(folio);
 	if (folio_pos(folio) + to > inode->i_size) {
 		to = inode->i_size - folio_pos(folio);
@@ -658,7 +658,7 @@ static int affs_write_begin_ofs(const struct kiocb *iocb,
 	pgoff_t index;
 	int err = 0;
 
-	pr_debug("%s(%lu, %llu, %llu)\n", __func__, inode->i_ino, pos,
+	pr_debug("%s(%" PRIino "u, %llu, %llu)\n", __func__, inode->i_ino, pos,
 		 pos + len);
 	if (pos > AFFS_I(inode)->mmu_private) {
 		/* XXX: this probably leaves a too-big i_size in case of
@@ -710,7 +710,7 @@ static int affs_write_end_ofs(const struct kiocb *iocb,
 	 * due to write_begin.
 	 */
 
-	pr_debug("%s(%lu, %llu, %llu)\n", __func__, inode->i_ino, pos,
+	pr_debug("%s(%" PRIino "u, %llu, %llu)\n", __func__, inode->i_ino, pos,
 		 pos + len);
 	bsize = AFFS_SB(sb)->s_data_blksize;
 	data = folio_address(folio);
@@ -854,7 +854,7 @@ affs_free_prealloc(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
-	pr_debug("free_prealloc(ino=%lu)\n", inode->i_ino);
+	pr_debug("free_prealloc(ino=%" PRIino "u)\n", inode->i_ino);
 
 	while (AFFS_I(inode)->i_pa_cnt) {
 		AFFS_I(inode)->i_pa_cnt--;
@@ -874,7 +874,7 @@ affs_truncate(struct inode *inode)
 	struct buffer_head *ext_bh;
 	int i;
 
-	pr_debug("truncate(inode=%lu, oldsize=%llu, newsize=%llu)\n",
+	pr_debug("truncate(inode=%" PRIino "u, oldsize=%llu, newsize=%llu)\n",
 		 inode->i_ino, AFFS_I(inode)->mmu_private, inode->i_size);
 
 	last_blk = 0;
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 0bfc7d151dcd383af31d1fa41723e7391ec9d4c0..14f6a6352662ba9514a64ea0893e848e79abed63 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -32,7 +32,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode_state_read_once(inode) & I_NEW))
 		return inode;
 
-	pr_debug("affs_iget(%lu)\n", inode->i_ino);
+	pr_debug("affs_iget(%" PRIino "u)\n", inode->i_ino);
 
 	block = inode->i_ino;
 	bh = affs_bread(sb, block);
@@ -171,14 +171,14 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	uid_t			 uid;
 	gid_t			 gid;
 
-	pr_debug("write_inode(%lu)\n", inode->i_ino);
+	pr_debug("write_inode(%" PRIino "u)\n", inode->i_ino);
 
 	if (!inode->i_nlink)
 		// possibly free block
 		return 0;
 	bh = affs_bread(sb, inode->i_ino);
 	if (!bh) {
-		affs_error(sb,"write_inode","Cannot read block %lu",inode->i_ino);
+		affs_error(sb, "write_inode", "Cannot read block %" PRIino "u", inode->i_ino);
 		return -EIO;
 	}
 	tail = AFFS_TAIL(sb, bh);
@@ -219,7 +219,7 @@ affs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	pr_debug("notify_change(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
+	pr_debug("notify_change(%" PRIino "u,0x%x)\n", inode->i_ino, attr->ia_valid);
 
 	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
 	if (error)
@@ -260,7 +260,7 @@ void
 affs_evict_inode(struct inode *inode)
 {
 	unsigned long cache_page;
-	pr_debug("evict_inode(ino=%lu, nlink=%u)\n",
+	pr_debug("evict_inode(ino=%" PRIino "u, nlink=%u)\n",
 		 inode->i_ino, inode->i_nlink);
 	truncate_inode_pages_final(&inode->i_data);
 
@@ -353,7 +353,7 @@ affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s3
 	u32 block = 0;
 	int retval;
 
-	pr_debug("%s(dir=%lu, inode=%lu, \"%pd\", type=%d)\n", __func__,
+	pr_debug("%s(dir=%" PRIino "u, inode=%" PRIino "u, \"%pd\", type=%d)\n", __func__,
 		 dir->i_ino, inode->i_ino, dentry, type);
 
 	retval = -EIO;
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index f883be50db122d3b09f0ae4d24618bd49b55186b..725a005a0aec9d4727b6bf561333b236844ae7ec 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -235,7 +235,7 @@ affs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 int
 affs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	pr_debug("%s(dir=%lu, %lu \"%pd\")\n", __func__, dir->i_ino,
+	pr_debug("%s(dir=%" PRIino "u, %" PRIino "u \"%pd\")\n", __func__, dir->i_ino,
 		 d_inode(dentry)->i_ino, dentry);
 
 	return affs_remove_header(dentry);
@@ -249,7 +249,7 @@ affs_create(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode	*inode;
 	int		 error;
 
-	pr_debug("%s(%lu,\"%pd\",0%ho)\n",
+	pr_debug("%s(%" PRIino "u,\"%pd\",0%ho)\n",
 		 __func__, dir->i_ino, dentry, mode);
 
 	inode = affs_new_inode(dir);
@@ -280,7 +280,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode		*inode;
 	int			 error;
 
-	pr_debug("%s(%lu,\"%pd\",0%ho)\n",
+	pr_debug("%s(%" PRIino "u,\"%pd\",0%ho)\n",
 		 __func__, dir->i_ino, dentry, mode);
 
 	inode = affs_new_inode(dir);
@@ -306,7 +306,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 int
 affs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	pr_debug("%s(dir=%lu, %lu \"%pd\")\n", __func__, dir->i_ino,
+	pr_debug("%s(dir=%" PRIino "u, %" PRIino "u \"%pd\")\n", __func__, dir->i_ino,
 		 d_inode(dentry)->i_ino, dentry);
 
 	return affs_remove_header(dentry);
@@ -323,7 +323,7 @@ affs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	int			 i, maxlen, error;
 	char			 c, lc;
 
-	pr_debug("%s(%lu,\"%pd\" -> \"%s\")\n",
+	pr_debug("%s(%" PRIino "u,\"%pd\" -> \"%s\")\n",
 		 __func__, dir->i_ino, dentry, symname);
 
 	maxlen = AFFS_SB(sb)->s_hashsize * sizeof(u32) - 1;
@@ -395,7 +395,7 @@ affs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	pr_debug("%s(%lu, %lu, \"%pd\")\n", __func__, inode->i_ino, dir->i_ino,
+	pr_debug("%s(%" PRIino "u, %" PRIino "u, \"%pd\")\n", __func__, inode->i_ino, dir->i_ino,
 		 dentry);
 
 	return affs_add_entry(dir, inode, dentry, ST_LINKFILE);
@@ -511,7 +511,7 @@ int affs_rename2(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
 		return -EINVAL;
 
-	pr_debug("%s(old=%lu,\"%pd\" to new=%lu,\"%pd\")\n", __func__,
+	pr_debug("%s(old=%" PRIino "u,\"%pd\" to new=%" PRIino "u,\"%pd\")\n", __func__,
 		 old_dir->i_ino, old_dentry, new_dir->i_ino, new_dentry);
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index 094aec8d17b88bab9392abdd497ed687cd85584e..05ec904089fb8287545ccc8128ba4057175576cf 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -21,7 +21,7 @@ static int affs_symlink_read_folio(struct file *file, struct folio *folio)
 	char			 c;
 	char			 lc;
 
-	pr_debug("get_link(ino=%lu)\n", inode->i_ino);
+	pr_debug("get_link(ino=%" PRIino "u)\n", inode->i_ino);
 
 	bh = affs_bread(inode->i_sb, inode->i_ino);
 	if (!bh)

-- 
2.53.0


