Return-Path: <linux-fsdevel+bounces-78529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKm0OCF1oGmtjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:30:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F811AA64D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2525C3108064
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1EB43CEE9;
	Thu, 26 Feb 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnQJg5FC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E9438FEA;
	Thu, 26 Feb 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121453; cv=none; b=occTB+DUZmRXJSIIuR08XdHQ0xWm4L9SROePRCwkR4n1YBmalGbJ+5J4uby4uL93XihNn3kleFQSi1gYBhxfDEpZY4juAlLu4AwlKxk9v9A9B4Y5SS2Yj+wjM0hZYqWsOSSeT9mBSSA4YZWLNhkdGgMSwe9woRcAx53qU2vV1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121453; c=relaxed/simple;
	bh=ssx2IpAMqaxniype/4uVoYfZEQDEAGD8rhxutC32X1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDEN1nM6/WObcPKCy1hVq4wCeaax8oJynwNQoWTb2ezpDrPhLHBSlO9Q0qHr1KVBHpEioowB9vK/dFM/0z/chpIRGx+MXLp9rK4T834LinUfwMR3zx4IkH4E3CMv0AddOoLkdtUU/hKfyf4p7pkSbEXbR10IGTLMOQELU0J0l+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnQJg5FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615F9C2BCB2;
	Thu, 26 Feb 2026 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121452;
	bh=ssx2IpAMqaxniype/4uVoYfZEQDEAGD8rhxutC32X1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnQJg5FC2TrfmGKCHtBXTKsdnxdFxJmNXnISICWPbnC3hb1wfxEgebI6iJoLTtgQy
	 173uYgqDx5i298Xu3EperqcDskmyX9ilPHqGcQ12xD14FR0b14WtYD4k8CQU6atGUl
	 yi8BqxIys5mzQIFdPo9FTsDiy8H2gxu9FKnTpDIVWYnYnbLgsu6IxrpC4TqRfizQ/q
	 NmpTjIKf8B2L1AHXMJFFDcX2LpwmiBloBBaLJJFSfCEeHZm08y2cXksJjhlp0tfJJW
	 YeU6GQxJ1aQnbIN6oYZo5mpGP5nMYZveOM8a/KJv+TZJRvdoYDAv0MCCZ/bXo154uR
	 p7FceaY/1R8Jg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:08 -0500
Subject: [PATCH 06/61] f2fs: update for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-6-ccceff366db9@kernel.org>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
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
 Martin Schiller <ms@dev.tdt.de>
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
 linux-x25@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=51378; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ssx2IpAMqaxniype/4uVoYfZEQDEAGD8rhxutC32X1Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0F4KRhMIfqGLim+RK2KV8IRqMs9t86x89Cy
 oK6lXXq0duJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBQAKCRAADmhBGVaC
 FWkKEACNiFZZW2m66ieWqSQLZlEtqvhGteFEAoLMS5ynfPSAQ5Vp54WLP+WIf2O7QxNZqE8aKdZ
 yDloorLkKlv0nTZkg283rP3ENShgUFZbyqGJQVNmT5Pbvl4x/e0PHzRZG7k027Ou3YLgTpZJdfN
 n2KR2UfwSgjxU3tm9IooaPhEiUrFHFoWgLAegJRWwUdLKE7/77+64LvVq8N08XvzZo3++9v5m5J
 d9Uuv1YWai2HW9q5xcJ7EpmToHak6JX0BE0CM4oiOdqqSmIO1dIw4Lkscxp42dVrgpEr6soVxRE
 2oRAM4rEX1ynjx8codPXjueYWWxtJ3Ru7zcmCKD6IHmsTt5rQyNjqnFOCP78izFiUF5PSQFnP97
 9ZtjHsxDouVTxbC3Q5r9Ks5PC3IhGYGuRr9FDIiV+I7DfEHjKzgJUN+sMUbp5r8W/GBaiveLgbS
 /gUHVAvvqpddVRKVJuXI2SOzU8oTNKa3UwJY7/fVu15Ixwg4AAaXp6zW5VVgd6eJ/jJ9EKpRgJN
 gBMef7nsj9VQy3YnabhR+12FRUGANpAuNrRZv8areyIomw3cIxmx0j2LFWwvSCK5OA63z7SyF57
 Hg8WeYX73NLo/muPPO/KW0qf+D9P98gRY5RhrBbfkTo+7HENaFcnbtKCuaJgT62ioAZg4YNwSeE
 5SjJJJezWBS/5rw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78529-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88F811AA64D
X-Rspamd-Action: no action

Update f2fs trace events and filesystem code for u64 i_ino:

- Change __field(ino_t, ...) to __field(u64, ...) in trace events
- Update show_dev_ino() macro format strings from %lu to %llu
- Cast inode numbers to (unsigned long long) in TP_printk
- Update format string in fs/f2fs/node.c

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/compress.c          |   4 +-
 fs/f2fs/dir.c               |   2 +-
 fs/f2fs/extent_cache.c      |   8 +--
 fs/f2fs/f2fs.h              |   6 +-
 fs/f2fs/file.c              |  12 ++--
 fs/f2fs/gc.c                |   2 +-
 fs/f2fs/inline.c            |   4 +-
 fs/f2fs/inode.c             |  48 ++++++-------
 fs/f2fs/namei.c             |   8 +--
 fs/f2fs/node.c              |  12 ++--
 fs/f2fs/recovery.c          |  10 +--
 fs/f2fs/xattr.c             |  10 +--
 include/trace/events/f2fs.h | 172 ++++++++++++++++++++++----------------------
 13 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8c76400ba6317d9b62428a1d7b53a54d7c5d07ef..0b8be500db656f8439725cac2f6a927c2f06ca4f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -773,7 +773,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
 				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
 				f2fs_info_ratelimited(sbi,
-					"checksum invalid, nid = %lu, %x vs %x",
+					"checksum invalid, nid = %llu, %x vs %x",
 					dic->inode->i_ino,
 					provided, calculated);
 			}
@@ -932,7 +932,7 @@ bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
 
 	return false;
 out:
-	f2fs_warn(sbi, "access invalid cluster, ino:%lu, nid:%u, ofs_in_node:%u, reason:%s",
+	f2fs_warn(sbi, "access invalid cluster, ino:%llu, nid:%u, ofs_in_node:%u, reason:%s",
 			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	return true;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f70092e231f0f47e589d648b0c6f83ef3aa8fd6c..38802ee2e40deb4995a4e5f4118330b90b2f10e2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -368,7 +368,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
-		f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %lu: %u",
+		f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %llu: %u",
 			  dir->i_ino, max_depth);
 		max_depth = MAX_DIR_HASH_DEPTH;
 		f2fs_i_depth_write(dir, max_depth);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0ed84cc065a7eda66c50eae97d70e9ab93de31c3..d73aeef333a24766aaab9914a02b99fbf035e78d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -34,7 +34,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
 	if (!f2fs_is_valid_blkaddr(sbi, ei.blk, DATA_GENERIC_ENHANCE) ||
 	    !f2fs_is_valid_blkaddr(sbi, ei.blk + ei.len - 1,
 					DATA_GENERIC_ENHANCE)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
 			  ei.blk, ei.fofs, ei.len);
 		return false;
@@ -50,14 +50,14 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
 
 		if (devi == 0) {
 			f2fs_warn(sbi,
-			    "%s: inode (ino=%lx) is an alias of meta device",
+			    "%s: inode (ino=%llx) is an alias of meta device",
 			    __func__, inode->i_ino);
 			return false;
 		}
 
 		if (bdev_is_zoned(FDEV(devi).bdev)) {
 			f2fs_warn(sbi,
-			    "%s: device alias inode (ino=%lx)'s extent info "
+			    "%s: device alias inode (ino=%llx)'s extent info "
 			    "[%u, %u, %u] maps to zoned block device",
 			    __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
 			return false;
@@ -65,7 +65,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
 		return true;
 	}
 
-	f2fs_warn(sbi, "%s: device alias inode (ino=%lx)'s extent info "
+	f2fs_warn(sbi, "%s: device alias inode (ino=%llx)'s extent info "
 			"[%u, %u, %u] is inconsistent w/ any devices",
 			__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
 	return false;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb34e864d0efc742c651a285c5989bd73530fbe3..760e6d80bbddd8393394c30c740ba05faded332f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2706,7 +2706,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	if (unlikely(sbi->total_valid_block_count < count)) {
-		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%lu, count:%u",
+		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%llu, count:%u",
 			  sbi->total_valid_block_count, inode->i_ino, count);
 		sbi->total_valid_block_count = 0;
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -2719,7 +2719,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 					sbi->current_reserved_blocks + count);
 	spin_unlock(&sbi->stat_lock);
 	if (unlikely(inode->i_blocks < sectors)) {
-		f2fs_warn(sbi, "Inconsistent i_blocks, ino:%lu, iblocks:%llu, sectors:%llu",
+		f2fs_warn(sbi, "Inconsistent i_blocks, ino:%llu, iblocks:%llu, sectors:%llu",
 			  inode->i_ino,
 			  (unsigned long long)inode->i_blocks,
 			  (unsigned long long)sectors);
@@ -2993,7 +2993,7 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 		dquot_free_inode(inode);
 	} else {
 		if (unlikely(inode->i_blocks == 0)) {
-			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%lu, iblocks:%llu",
+			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%llu, iblocks:%llu",
 				  inode->i_ino,
 				  (unsigned long long)inode->i_blocks);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c8a2f17a8f11cfc746c6a6ec4a225199929c2ee6..a56bbcca7898282eab1fea7e1b2acee5ea00df88 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1917,7 +1917,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 				f2fs_up_write(&sbi->pin_sem);
 				err = -ENOSPC;
 				f2fs_warn_ratelimited(sbi,
-					"ino:%lu, start:%lu, end:%lu, need to trigger GC to "
+					"ino:%llu, start:%lu, end:%lu, need to trigger GC to"
 					"reclaim enough free segment when checkpoint is enabled",
 					inode->i_ino, pg_start, pg_end);
 				goto out_err;
@@ -2307,7 +2307,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	 * f2fs_is_atomic_file.
 	 */
 	if (get_dirty_pages(inode))
-		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%lu, npages=%u",
+		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%llu, npages=%u",
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
@@ -3494,7 +3494,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 		return -EINVAL;
 
 	if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
-		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
+		f2fs_warn(sbi, "%s: Enable GC = ino %llx after %x GC trials",
 			  __func__, inode->i_ino, fi->i_gc_failures);
 		clear_inode_flag(inode, FI_PIN_FILE);
 		return -EAGAIN;
@@ -3679,7 +3679,7 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
 
 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
 		f2fs_warn(F2FS_I_SB(inode),
-			  "Can't enable fs-verity on inode %lu: the verity feature is not enabled on this filesystem",
+			  "Can't enable fs-verity on inode %llu: the verity feature is not enabled on this filesystem",
 			  inode->i_ino);
 		return -EOPNOTSUPP;
 	}
@@ -3950,7 +3950,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	} else if (released_blocks &&
 			atomic_read(&fi->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%lx "
+		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%llx "
 			"iblocks=%llu, released=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
@@ -4133,7 +4133,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	} else if (reserved_blocks &&
 			atomic_read(&fi->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%lx "
+		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%llx "
 			"iblocks=%llu, reserved=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f46b2673d31f5a334bac543947e713cfe85dc68a..c0c8a1056d6b089397b4aa92b88b14cfd88c9de5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1622,7 +1622,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				iput(inode);
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
 				f2fs_err_ratelimited(sbi,
-					"inode %lx has both inline_data flag and "
+					"inode %llu has both inline_data flag and "
 					"data block, nid=%u, ofs_in_node=%u",
 					inode->i_ino, dni.nid, ofs_in_node);
 				continue;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0a1052d5ee624e68ba27200b100a567a5d216f2a..2669439b941387a96318f77fca7dfe35723e59d9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -176,7 +176,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	if (unlikely(dn->data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(dn);
 		set_sbi_flag(fio.sbi, SBI_NEED_FSCK);
-		f2fs_warn(fio.sbi, "%s: corrupted inline inode ino=%lx, i_addr[0]:0x%x, run fsck to fix.",
+		f2fs_warn(fio.sbi, "%s: corrupted inline inode ino=%llu, i_addr[0]:0x%x, run fsck to fix.",
 			  __func__, dn->inode->i_ino, dn->data_blkaddr);
 		f2fs_handle_error(fio.sbi, ERROR_INVALID_BLKADDR);
 		return -EFSCORRUPTED;
@@ -431,7 +431,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(&dn);
 		set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
-		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%lx, i_addr[0]:0x%x, run fsck to fix.",
+		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%llu, i_addr[0]:0x%x, run fsck to fix.",
 			  __func__, dir->i_ino, dn.data_blkaddr);
 		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
 		err = -EFSCORRUPTED;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e0f850b3f0c38797fbba726af424161a147ee4f7..f27198d6695b91d2a041318aeecd04c65d38a4ba 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -203,14 +203,14 @@ static bool sanity_check_compress_inode(struct inode *inode,
 
 	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
+			"%s: inode (ino=%llx) has unsupported compress algorithm: %u, run fsck to fix",
 			__func__, inode->i_ino, ri->i_compress_algorithm);
 		return false;
 	}
 	if (le64_to_cpu(ri->i_compr_blocks) >
 			SECTOR_TO_BLOCK(inode->i_blocks)) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
+			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
 			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
 			SECTOR_TO_BLOCK(inode->i_blocks));
 		return false;
@@ -218,7 +218,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
 	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
 		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
+			"%s: inode (ino=%llx) has unsupported log cluster size: %u, run fsck to fix",
 			__func__, inode->i_ino, ri->i_log_cluster_size);
 		return false;
 	}
@@ -262,7 +262,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
 
 	return true;
 err_level:
-	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
+	f2fs_warn(sbi, "%s: inode (ino=%llx) has unsupported compress level: %u, run fsck to fix",
 		  __func__, inode->i_ino, clevel);
 	return false;
 }
@@ -276,40 +276,40 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 
 	iblocks = le64_to_cpu(F2FS_INODE(node_folio)->i_blocks);
 	if (!iblocks) {
-		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%lx iblocks=%llu, run fsck to fix.",
+		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%llx iblocks=%llu, run fsck to fix.",
 			  __func__, inode->i_ino, iblocks);
 		return false;
 	}
 
 	if (ino_of_node(node_folio) != nid_of_node(node_folio)) {
-		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%lx, ino,nid: [%u, %u] run fsck to fix.",
+		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%llx, ino,nid: [%u, %u] run fsck to fix.",
 			  __func__, inode->i_ino,
 			  ino_of_node(node_folio), nid_of_node(node_folio));
 		return false;
 	}
 
 	if (ino_of_node(node_folio) == fi->i_xattr_nid) {
-		f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx, xnid=%x, run fsck to fix.",
+		f2fs_warn(sbi, "%s: corrupted inode i_ino=%llx, xnid=%x, run fsck to fix.",
 			  __func__, inode->i_ino, fi->i_xattr_nid);
 		return false;
 	}
 
 	if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
-		f2fs_warn(sbi, "%s: directory inode (ino=%lx) has a single i_nlink",
+		f2fs_warn(sbi, "%s: directory inode (ino=%llx) has a single i_nlink",
 			  __func__, inode->i_ino);
 		return false;
 	}
 
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) is with extra_attr, but extra_attr feature is off",
 				  __func__, inode->i_ino);
 			return false;
 		}
 		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize % sizeof(__le32)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_extra_isize: %d, max: %zu",
 				  __func__, inode->i_ino, fi->i_extra_isize,
 				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
 			return false;
@@ -327,7 +327,7 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		f2fs_has_inline_xattr(inode) &&
 		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
 		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
 			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
 		return false;
@@ -335,64 +335,64 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 
 	if (!f2fs_sb_has_extra_attr(sbi)) {
 		if (f2fs_sb_has_project_quota(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
 			return false;
 		}
 		if (f2fs_sb_has_inode_chksum(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
 			return false;
 		}
 		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
 			return false;
 		}
 		if (f2fs_sb_has_inode_crtime(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
 			return false;
 		}
 		if (f2fs_sb_has_compression(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
 			return false;
 		}
 	}
 
 	if (f2fs_sanity_check_inline_data(inode, node_folio)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
+		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_data, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
 	}
 
 	if (f2fs_has_inline_dentry(inode) && !S_ISDIR(inode->i_mode)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_dentry, run fsck to fix",
+		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_dentry, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
 	}
 
 	if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has casefold flag, but casefold feature is off",
 			  __func__, inode->i_ino);
 		return false;
 	}
 
 	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_xattr_nid: %u, run fsck to fix.",
 			  __func__, inode->i_ino, fi->i_xattr_nid);
 		return false;
 	}
 
 	if (IS_DEVICE_ALIASING(inode)) {
 		if (!f2fs_sb_has_device_alias(sbi)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but the feature is off",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has device alias flag, but the feature is off",
 				  __func__, inode->i_ino);
 			return false;
 		}
 		if (!f2fs_is_pinned_file(inode)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but is not pinned",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has device alias flag, but is not pinned",
 				  __func__, inode->i_ino);
 			return false;
 		}
@@ -925,7 +925,7 @@ void f2fs_evict_inode(struct inode *inode)
 			 */
 			if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
 				f2fs_warn(F2FS_I_SB(inode),
-					"f2fs_evict_inode: inconsistent node id, ino:%lu",
+					"f2fs_evict_inode: inconsistent node id, ino:%llu",
 					inode->i_ino);
 				f2fs_inode_synced(inode);
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -954,7 +954,7 @@ void f2fs_evict_inode(struct inode *inode)
 		 */
 		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
 			f2fs_warn(sbi,
-				"f2fs_evict_inode: inode is dirty, ino:%lu",
+				"f2fs_evict_inode: inode is dirty, ino:%llu",
 				inode->i_ino);
 			f2fs_inode_synced(inode);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e360f08a9586ab5b75d6e1e1748219c3190a7580..efbb0732d4206f63b5221605a08ffa5c17e8a8b6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -505,7 +505,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	if (inode->i_nlink == 0) {
-		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%llx) has zero i_nlink",
 			  __func__, inode->i_ino);
 		err = -EFSCORRUPTED;
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
@@ -515,7 +515,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
-		f2fs_warn(F2FS_I_SB(inode), "Inconsistent encryption contexts: %lu/%lu",
+		f2fs_warn(F2FS_I_SB(inode), "Inconsistent encryption contexts: %llu/%llu",
 			  dir->i_ino, inode->i_ino);
 		err = -EPERM;
 		goto out_iput;
@@ -573,11 +573,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (unlikely(inode->i_nlink == 0)) {
-		f2fs_warn(sbi, "%s: inode (ino=%lx) has zero i_nlink",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
 			  __func__, inode->i_ino);
 		goto corrupted;
 	} else if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
-		f2fs_warn(sbi, "%s: directory inode (ino=%lx) has a single i_nlink",
+		f2fs_warn(sbi, "%s: directory inode (ino=%llx) has a single i_nlink",
 			  __func__, inode->i_ino);
 		goto corrupted;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2030e943ab9b3d5e2deb20efe9a44cf5093a61fb..2856d5dbdd00a659b548ca6a0d8a973fc1341297 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -847,7 +847,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			err = -EFSCORRUPTED;
 			f2fs_err_ratelimited(sbi,
 				"inode mapping table is corrupted, run fsck to fix it, "
-				"ino:%lu, nid:%u, level:%d, offset:%d",
+				"ino:%llu, nid:%u, level:%d, offset:%d",
 				dn->inode->i_ino, nids[i], level, offset[level]);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			goto release_pages;
@@ -1013,7 +1013,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
 		return PTR_ERR(folio);
 
 	if (IS_INODE(folio) || ino_of_node(folio) != dn->inode->i_ino) {
-		f2fs_err(sbi, "incorrect node reference, ino: %lu, nid: %u, ino_of_node: %u",
+		f2fs_err(sbi, "incorrect node reference, ino: %llu, nid: %u, ino_of_node: %u",
 				dn->inode->i_ino, dn->nid, ino_of_node(folio));
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
@@ -1194,7 +1194,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	if (level <= 0) {
 		if (!level) {
 			level = -EFSCORRUPTED;
-			f2fs_err(sbi, "%s: inode ino=%lx has corrupted node block, from:%lu addrs:%u",
+			f2fs_err(sbi, "%s: inode ino=%llx has corrupted node block, from:%lu addrs:%u",
 					__func__, inode->i_ino,
 					from, ADDRS_PER_INODE(inode));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -1265,7 +1265,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 			set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
 			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			f2fs_err_ratelimited(sbi,
-				"truncate node fail, ino:%lu, nid:%u, "
+				"truncate node fail, ino:%llu, nid:%u, "
 				"offset[0]:%d, offset[1]:%d, nofs:%d",
 				inode->i_ino, dn.nid, offset[0],
 				offset[1], nofs);
@@ -1351,7 +1351,7 @@ int f2fs_remove_inode_page(struct inode *inode)
 
 	if (unlikely(inode->i_blocks != 0 && inode->i_blocks != 8)) {
 		f2fs_warn(F2FS_I_SB(inode),
-			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%lu, iblocks:%llu",
+			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%llu, iblocks:%llu",
 			inode->i_ino, (unsigned long long)inode->i_blocks);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 	}
@@ -1997,7 +1997,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	return ret;
 }
 
-static int f2fs_match_ino(struct inode *inode, unsigned long ino, void *data)
+static int f2fs_match_ino(struct inode *inode, u64 ino, void *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	bool clean;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index a26071f2b0bc81fb768982841e37a63b2ca701b3..3d3dacec94825f6695d67043fd3ca42329aa5929 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -232,7 +232,7 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 		name = "<encrypted>";
 	else
 		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %lx, err = %d",
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %llu, err = %d",
 		    __func__, ino_of_node(ifolio), name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
@@ -532,7 +532,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 
 	max_addrs = ADDRS_PER_PAGE(dn->node_folio, dn->inode);
 	if (ofs_in_node >= max_addrs) {
-		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%lu, nid:%u, max:%u",
+		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%llu, nid:%u, max:%u",
 			ofs_in_node, dn->inode->i_ino, nid, max_addrs);
 		f2fs_handle_error(sbi, ERROR_INCONSISTENT_SUMMARY);
 		return -EFSCORRUPTED;
@@ -674,7 +674,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(folio));
 
 	if (ofs_of_node(dn.node_folio) != ofs_of_node(folio)) {
-		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%lu, ofs:%u, %u",
+		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
 			  inode->i_ino, ofs_of_node(dn.node_folio),
 			  ofs_of_node(folio));
 		err = -EFSCORRUPTED;
@@ -748,7 +748,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (f2fs_is_valid_blkaddr(sbi, dest,
 					DATA_GENERIC_ENHANCE_UPDATE)) {
-				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
+				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%llu, ofs:%u",
 					dest, inode->i_ino, dn.ofs_in_node);
 				err = -EFSCORRUPTED;
 				goto err;
@@ -768,7 +768,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 err:
 	f2fs_put_dnode(&dn);
 out:
-	f2fs_notice(sbi, "recover_data: ino = %lx, nid = %x (i_size: %s), "
+	f2fs_notice(sbi, "recover_data: ino = %llx, nid = %x (i_size: %s), "
 		    "range (%u, %u), recovered = %d, err = %d",
 		    inode->i_ino, nid_of_node(folio),
 		    file_keep_isize(inode) ? "keep" : "recover",
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 941dc62a6d6f7c50c1a661397ef1bbb611e6c304..610d5810074dc501d02c93a4feb308e12a21a056 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -365,7 +365,7 @@ static int lookup_all_xattrs(struct inode *inode, struct folio *ifolio,
 
 	*xe = __find_xattr(cur_addr, last_txattr_addr, NULL, index, len, name);
 	if (!*xe) {
-		f2fs_err(F2FS_I_SB(inode), "lookup inode (%lu) has corrupted xattr",
+		f2fs_err(F2FS_I_SB(inode), "lookup inode (%llu) has corrupted xattr",
 								inode->i_ino);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		err = -ENODATA;
@@ -585,7 +585,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
-			f2fs_err(F2FS_I_SB(inode), "list inode (%lu) has corrupted xattr",
+			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
 						inode->i_ino);
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			f2fs_handle_error(F2FS_I_SB(inode),
@@ -664,14 +664,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		if (!F2FS_I(inode)->i_xattr_nid) {
 			error = f2fs_recover_xattr_data(inode, NULL);
 			f2fs_notice(F2FS_I_SB(inode),
-				"recover xattr in inode (%lu), error(%d)",
+				"recover xattr in inode (%llu), error(%d)",
 					inode->i_ino, error);
 			if (!error) {
 				kfree(base_addr);
 				goto retry;
 			}
 		}
-		f2fs_err(F2FS_I_SB(inode), "set inode (%lu) has corrupted xattr",
+		f2fs_err(F2FS_I_SB(inode), "set inode (%llu) has corrupted xattr",
 								inode->i_ino);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		error = -EFSCORRUPTED;
@@ -699,7 +699,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	while (!IS_XATTR_LAST_ENTRY(last)) {
 		if ((void *)(last) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(last) > last_base_addr) {
-			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has invalid last xattr entry, entry_size: %zu",
+			f2fs_err(F2FS_I_SB(inode), "inode (%llu) has invalid last xattr entry, entry_size: %zu",
 					inode->i_ino, ENTRY_SIZE(last));
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			error = -EFSCORRUPTED;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9364e677556207ac041353a9eb2d5c2ee49b9dff..109b4f5771cbd5b019a1a9cfdc178892a19b7c54 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -9,7 +9,7 @@
 #include <uapi/linux/f2fs.h>
 
 #define show_dev(dev)		MAJOR(dev), MINOR(dev)
-#define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long)entry->ino
+#define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long long)entry->ino
 
 TRACE_DEFINE_ENUM(NODE);
 TRACE_DEFINE_ENUM(DATA);
@@ -207,8 +207,8 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
-		__field(ino_t,	pino)
+		__field(u64,	ino)
+		__field(u64,	pino)
 		__field(umode_t, mode)
 		__field(loff_t,	size)
 		__field(unsigned int, nlink)
@@ -227,10 +227,10 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 		__entry->advise	= F2FS_I(inode)->i_advise;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pino = %lu, i_mode = 0x%hx, "
+	TP_printk("dev = (%d,%d), ino = %llu, pino = %llu, i_mode = 0x%hx, "
 		"i_size = %lld, i_nlink = %u, i_blocks = %llu, i_advise = 0x%x",
 		show_dev_ino(__entry),
-		(unsigned long)__entry->pino,
+		(unsigned long long)__entry->pino,
 		__entry->mode,
 		__entry->size,
 		(unsigned int)__entry->nlink,
@@ -246,7 +246,7 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(umode_t, mode)
 		__field(int,	ret)
 	),
@@ -258,7 +258,7 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, type: %s, mode = 0%o, ret = %d",
+	TP_printk("dev = (%d,%d), ino = %llu, type: %s, mode = 0%o, ret = %d",
 		show_dev_ino(__entry),
 		show_inode_type(__entry->mode & S_IFMT),
 		__entry->mode & S_ALL_PERM,
@@ -280,7 +280,7 @@ TRACE_EVENT(f2fs_sync_file_exit,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(int,	cp_reason)
 		__field(int,	datasync)
 		__field(int,	ret)
@@ -294,7 +294,7 @@ TRACE_EVENT(f2fs_sync_file_exit,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cp_reason: %s, "
+	TP_printk("dev = (%d,%d), ino = %llu, cp_reason: %s, "
 		"datasync = %d, ret = %d",
 		show_dev_ino(__entry),
 		show_fsync_cpreason(__entry->cp_reason),
@@ -362,7 +362,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	size)
 		__field(blkcnt_t, blocks)
 		__string(name,  dentry->d_name.name)
@@ -376,7 +376,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 		__assign_str(name);
 	),
 
-	TP_printk("dev = (%d,%d), dir ino = %lu, i_size = %lld, "
+	TP_printk("dev = (%d,%d), dir ino = %llu, i_size = %lld, "
 		"i_blocks = %llu, name = %s",
 		show_dev_ino(__entry),
 		__entry->size,
@@ -413,7 +413,7 @@ TRACE_EVENT(f2fs_truncate_data_blocks_range,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(nid_t,	nid)
 		__field(unsigned int,	ofs)
 		__field(int,	free)
@@ -427,7 +427,7 @@ TRACE_EVENT(f2fs_truncate_data_blocks_range,
 		__entry->free	= free;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, nid = %u, offset = %u, freed = %d",
+	TP_printk("dev = (%d,%d), ino = %llu, nid = %u, offset = %u, freed = %d",
 		show_dev_ino(__entry),
 		(unsigned int)__entry->nid,
 		__entry->ofs,
@@ -442,7 +442,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	size)
 		__field(blkcnt_t, blocks)
 		__field(u64,	from)
@@ -456,7 +456,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 		__entry->from	= from;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld, i_blocks = %llu, "
+	TP_printk("dev = (%d,%d), ino = %llu, i_size = %lld, i_blocks = %llu, "
 		"start file offset = %llu",
 		show_dev_ino(__entry),
 		__entry->size,
@@ -500,7 +500,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_node,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(nid_t,	nid)
 		__field(block_t,	blk_addr)
 	),
@@ -512,7 +512,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_node,
 		__entry->blk_addr	= blk_addr;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, nid = %u, block_address = 0x%llx",
+	TP_printk("dev = (%d,%d), ino = %llu, nid = %u, block_address = 0x%llx",
 		show_dev_ino(__entry),
 		(unsigned int)__entry->nid,
 		(unsigned long long)__entry->blk_addr)
@@ -547,7 +547,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__array(nid_t,	nid, 3)
 		__field(int,	depth)
 		__field(int,	err)
@@ -563,7 +563,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 		__entry->err	= err;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, "
 		"nid[0] = %u, nid[1] = %u, nid[2] = %u, depth = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned int)__entry->nid[0],
@@ -582,7 +582,7 @@ TRACE_EVENT(f2fs_file_write_iter,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t, offset)
 		__field(size_t, length)
 		__field(ssize_t, ret)
@@ -596,7 +596,7 @@ TRACE_EVENT(f2fs_file_write_iter,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, "
 		"offset = %lld, length = %zu, written(err) = %zd",
 		show_dev_ino(__entry),
 		__entry->offset,
@@ -612,7 +612,7 @@ TRACE_EVENT(f2fs_fadvise,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t, size)
 		__field(loff_t,	offset)
 		__field(loff_t,	len)
@@ -628,7 +628,7 @@ TRACE_EVENT(f2fs_fadvise,
 		__entry->advice	= advice;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
+	TP_printk("dev = (%d,%d), ino = %llu, i_size = %lld offset:%llu, len:%llu, advise:%d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->size,
 		__entry->offset,
@@ -644,7 +644,7 @@ TRACE_EVENT(f2fs_map_blocks,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(block_t,	m_lblk)
 		__field(block_t,	m_pblk)
 		__field(unsigned int,	m_len)
@@ -670,7 +670,7 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
+	TP_printk("dev = (%d,%d), ino = %llu, file offset = %llu, "
 		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u, "
 		"seg_type = %d, may_create = %d, multidevice = %d, "
 		"flag = %d, err = %d",
@@ -886,7 +886,7 @@ TRACE_EVENT(f2fs_lookup_start,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__string(name,	dentry->d_name.name)
 		__field(unsigned int, flags)
 	),
@@ -898,7 +898,7 @@ TRACE_EVENT(f2fs_lookup_start,
 		__entry->flags	= flags;
 	),
 
-	TP_printk("dev = (%d,%d), pino = %lu, name:%s, flags:%u",
+	TP_printk("dev = (%d,%d), pino = %llu, name:%s, flags:%u",
 		show_dev_ino(__entry),
 		__get_str(name),
 		__entry->flags)
@@ -913,7 +913,7 @@ TRACE_EVENT(f2fs_lookup_end,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__string(name,	dentry->d_name.name)
 		__field(nid_t,	cino)
 		__field(int,	err)
@@ -927,7 +927,7 @@ TRACE_EVENT(f2fs_lookup_end,
 		__entry->err	= err;
 	),
 
-	TP_printk("dev = (%d,%d), pino = %lu, name:%s, ino:%u, err:%d",
+	TP_printk("dev = (%d,%d), pino = %llu, name:%s, ino:%u, err:%d",
 		show_dev_ino(__entry),
 		__get_str(name),
 		__entry->cino,
@@ -944,9 +944,9 @@ TRACE_EVENT(f2fs_rename_start,
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev)
-		__field(ino_t,		ino)
+		__field(u64,		ino)
 		__string(old_name,	old_dentry->d_name.name)
-		__field(ino_t,		new_pino)
+		__field(u64,		new_pino)
 		__string(new_name,	new_dentry->d_name.name)
 		__field(unsigned int,	flags)
 	),
@@ -960,8 +960,8 @@ TRACE_EVENT(f2fs_rename_start,
 		__entry->flags		= flags;
 	),
 
-	TP_printk("dev = (%d,%d), old_dir = %lu, old_name: %s, "
-		"new_dir = %lu, new_name: %s, flags = %u",
+	TP_printk("dev = (%d,%d), old_dir = %llu, old_name: %s, "
+		"new_dir = %llu, new_name: %s, flags = %u",
 		show_dev_ino(__entry),
 		__get_str(old_name),
 		__entry->new_pino,
@@ -978,7 +978,7 @@ TRACE_EVENT(f2fs_rename_end,
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev)
-		__field(ino_t,		ino)
+		__field(u64,		ino)
 		__string(old_name,	old_dentry->d_name.name)
 		__string(new_name,	new_dentry->d_name.name)
 		__field(unsigned int,	flags)
@@ -994,7 +994,7 @@ TRACE_EVENT(f2fs_rename_end,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, old_name: %s, "
+	TP_printk("dev = (%d,%d), ino = %llu, old_name: %s, "
 		"new_name: %s, flags = %u, ret = %d",
 		show_dev_ino(__entry),
 		__get_str(old_name),
@@ -1011,7 +1011,7 @@ TRACE_EVENT(f2fs_readdir,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	start)
 		__field(loff_t,	end)
 		__field(int,	err)
@@ -1025,7 +1025,7 @@ TRACE_EVENT(f2fs_readdir,
 		__entry->err	= err;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, start_pos:%llu, end_pos:%llu, err:%d",
+	TP_printk("dev = (%d,%d), ino = %llu, start_pos:%llu, end_pos:%llu, err:%d",
 		show_dev_ino(__entry),
 		__entry->start,
 		__entry->end,
@@ -1041,7 +1041,7 @@ TRACE_EVENT(f2fs_fallocate,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(int,	mode)
 		__field(loff_t,	offset)
 		__field(loff_t,	len)
@@ -1061,7 +1061,7 @@ TRACE_EVENT(f2fs_fallocate,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, mode = %x, offset = %lld, "
+	TP_printk("dev = (%d,%d), ino = %llu, mode = %x, offset = %lld, "
 		"len = %lld,  i_size = %lld, i_blocks = %llu, ret = %d",
 		show_dev_ino(__entry),
 		__entry->mode,
@@ -1080,7 +1080,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	ki_pos)
 		__field(int,	ki_flags)
 		__field(u16,	ki_ioprio)
@@ -1098,7 +1098,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->rw		= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
+	TP_printk("dev = (%d,%d), ino = %llu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
 		__entry->ki_pos,
 		__entry->len,
@@ -1116,7 +1116,7 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	pos)
 		__field(unsigned long,	len)
 		__field(int,	rw)
@@ -1132,7 +1132,7 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu "
+	TP_printk("dev = (%d,%d), ino = %llu pos = %lld len = %lu "
 		"rw = %d ret = %d",
 		show_dev_ino(__entry),
 		__entry->pos,
@@ -1177,7 +1177,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_folio_bio,
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
-		__field(ino_t, ino)
+		__field(u64, ino)
 		__field(pgoff_t, index)
 		__field(block_t, old_blkaddr)
 		__field(block_t, new_blkaddr)
@@ -1199,7 +1199,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_folio_bio,
 		__entry->type		= fio->type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, folio_index = 0x%lx, "
+	TP_printk("dev = (%d,%d), ino = %llu, folio_index = 0x%lx, "
 		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s(%s), type = %s_%s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
@@ -1307,7 +1307,7 @@ TRACE_EVENT(f2fs_write_begin,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	pos)
 		__field(unsigned int, len)
 	),
@@ -1319,7 +1319,7 @@ TRACE_EVENT(f2fs_write_begin,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u",
+	TP_printk("dev = (%d,%d), ino = %llu, pos = %llu, len = %u",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->pos,
 		__entry->len)
@@ -1334,7 +1334,7 @@ TRACE_EVENT(f2fs_write_end,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	pos)
 		__field(unsigned int, len)
 		__field(unsigned int, copied)
@@ -1348,7 +1348,7 @@ TRACE_EVENT(f2fs_write_end,
 		__entry->copied	= copied;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u, copied = %u",
+	TP_printk("dev = (%d,%d), ino = %llu, pos = %llu, len = %u, copied = %u",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->pos,
 		__entry->len,
@@ -1363,7 +1363,7 @@ DECLARE_EVENT_CLASS(f2fs__folio,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(int, type)
 		__field(int, dir)
 		__field(pgoff_t, index)
@@ -1383,7 +1383,7 @@ DECLARE_EVENT_CLASS(f2fs__folio,
 		__entry->uptodate = folio_test_uptodate(folio);
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, nr_pages = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, %s, %s, index = %lu, nr_pages = %lu, "
 		"dirty = %d, uptodate = %d",
 		show_dev_ino(__entry),
 		show_block_type(__entry->type),
@@ -1438,8 +1438,8 @@ TRACE_EVENT(f2fs_replace_atomic_write_block,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
-		__field(ino_t,	cow_ino)
+		__field(u64,	ino)
+		__field(u64,	cow_ino)
 		__field(pgoff_t, index)
 		__field(block_t, old_addr)
 		__field(block_t, new_addr)
@@ -1456,7 +1456,7 @@ TRACE_EVENT(f2fs_replace_atomic_write_block,
 		__entry->recovery	= recovery;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cow_ino = %lu, index = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, cow_ino = %llu, index = %lu, "
 			"old_addr = 0x%llx, new_addr = 0x%llx, recovery = %d",
 		show_dev_ino(__entry),
 		__entry->cow_ino,
@@ -1475,7 +1475,7 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t, index)
 		__field(vm_flags_t, flags)
 		__field(vm_fault_t, ret)
@@ -1489,7 +1489,7 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, flags: %s, ret: %s",
+	TP_printk("dev = (%d,%d), ino = %llu, index = %lu, flags: %s, ret: %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		__print_flags(__entry->flags, "|", FAULT_FLAG_TRACE),
@@ -1520,7 +1520,7 @@ TRACE_EVENT(f2fs_writepages,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(int,	type)
 		__field(int,	dir)
 		__field(long,	nr_to_write)
@@ -1554,7 +1554,7 @@ TRACE_EVENT(f2fs_writepages,
 		__entry->for_sync	= wbc->for_sync;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, nr_to_write %ld, "
+	TP_printk("dev = (%d,%d), ino = %llu, %s, %s, nr_to_write %ld, "
 		"skipped %ld, start %lld, end %lld, wb_idx %lu, sync_mode %d, "
 		"kupdate %u background %u tagged %u cyclic %u sync %u",
 		show_dev_ino(__entry),
@@ -1581,7 +1581,7 @@ TRACE_EVENT(f2fs_readpages,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t,	start)
 		__field(unsigned int,	nrpage)
 	),
@@ -1593,7 +1593,7 @@ TRACE_EVENT(f2fs_readpages,
 		__entry->nrpage	= nrpage;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, start = %lu nrpage = %u",
+	TP_printk("dev = (%d,%d), ino = %llu, start = %lu nrpage = %u",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->start,
 		__entry->nrpage)
@@ -1739,7 +1739,7 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(unsigned int, pgofs)
 		__field(enum extent_type, type)
 	),
@@ -1751,7 +1751,7 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, type = %s",
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, type = %s",
 		show_dev_ino(__entry),
 		__entry->pgofs,
 		show_extent_type(__entry->type))
@@ -1768,7 +1768,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_read_extent_tree_end,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, fofs)
 		__field(unsigned int, len)
@@ -1784,7 +1784,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_read_extent_tree_end,
 		__entry->blk = ei->blk;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 		"read_ext_info(fofs: %u, len: %u, blk: %u)",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1804,7 +1804,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_age_extent_tree_end,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, fofs)
 		__field(unsigned int, len)
@@ -1822,7 +1822,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_age_extent_tree_end,
 		__entry->blocks = ei->last_blocks;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 		"age_ext_info(fofs: %u, len: %u, age: %llu, blocks: %llu)",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1842,7 +1842,7 @@ TRACE_EVENT(f2fs_update_read_extent_tree_range,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(unsigned int, pgofs)
 		__field(u32, blk)
 		__field(unsigned int, len)
@@ -1858,7 +1858,7 @@ TRACE_EVENT(f2fs_update_read_extent_tree_range,
 		__entry->c_len = c_len;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 				"len = %u, blkaddr = %u, c_len = %u",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1877,7 +1877,7 @@ TRACE_EVENT(f2fs_update_age_extent_tree_range,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, len)
 		__field(unsigned long long, age)
@@ -1893,7 +1893,7 @@ TRACE_EVENT(f2fs_update_age_extent_tree_range,
 		__entry->blocks = last_blks;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 				"len = %u, age = %llu, blocks = %llu",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1939,7 +1939,7 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(unsigned int, node_cnt)
 		__field(enum extent_type, type)
 	),
@@ -1951,7 +1951,7 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, destroyed: node_cnt = %u, type = %s",
+	TP_printk("dev = (%d,%d), ino = %llu, destroyed: node_cnt = %u, type = %s",
 		show_dev_ino(__entry),
 		__entry->node_cnt,
 		show_extent_type(__entry->type))
@@ -2028,7 +2028,7 @@ DECLARE_EVENT_CLASS(f2fs_zip_start,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t, idx)
 		__field(unsigned int, size)
 		__field(unsigned int, algtype)
@@ -2042,7 +2042,7 @@ DECLARE_EVENT_CLASS(f2fs_zip_start,
 		__entry->algtype = algtype;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cluster_idx:%lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, cluster_idx:%lu, "
 		"cluster_size = %u, algorithm = %s",
 		show_dev_ino(__entry),
 		__entry->idx,
@@ -2059,7 +2059,7 @@ DECLARE_EVENT_CLASS(f2fs_zip_end,
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t, idx)
 		__field(unsigned int, size)
 		__field(unsigned int, ret)
@@ -2073,7 +2073,7 @@ DECLARE_EVENT_CLASS(f2fs_zip_end,
 		__entry->ret = ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cluster_idx:%lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, cluster_idx:%lu, "
 		"compressed_size = %u, ret = %d",
 		show_dev_ino(__entry),
 		__entry->idx,
@@ -2312,7 +2312,7 @@ TRACE_EVENT(f2fs_bmap,
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
-		__field(ino_t, ino)
+		__field(u64, ino)
 		__field(sector_t, lblock)
 		__field(sector_t, pblock)
 	),
@@ -2324,7 +2324,7 @@ TRACE_EVENT(f2fs_bmap,
 		__entry->pblock		= pblock;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld",
+	TP_printk("dev = (%d,%d), ino = %llu, lblock:%lld, pblock:%lld",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->lblock,
 		(unsigned long long)__entry->pblock)
@@ -2339,7 +2339,7 @@ TRACE_EVENT(f2fs_fiemap,
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
-		__field(ino_t, ino)
+		__field(u64, ino)
 		__field(sector_t, lblock)
 		__field(sector_t, pblock)
 		__field(unsigned long long, len)
@@ -2357,7 +2357,7 @@ TRACE_EVENT(f2fs_fiemap,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld, "
+	TP_printk("dev = (%d,%d), ino = %llu, lblock:%lld, pblock:%lld, "
 		"len:%llu, flags:%u, ret:%d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->lblock,
@@ -2381,7 +2381,7 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 		__field(loff_t, i_size)
 		__string(cmdline, command)
 		__field(pid_t, pid)
-		__field(ino_t, ino)
+		__field(u64, ino)
 	),
 
 	TP_fast_assign(
@@ -2402,10 +2402,10 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 	),
 
 	TP_printk("entry_name %s, offset %llu, bytes %d, cmdline %s,"
-		" pid %d, i_size %llu, ino %lu",
+		" pid %d, i_size %llu, ino %llu",
 		__get_str(pathbuf), __entry->offset, __entry->bytes,
 		__get_str(cmdline), __entry->pid, __entry->i_size,
-		(unsigned long) __entry->ino)
+		(unsigned long long) __entry->ino)
 );
 
 DECLARE_EVENT_CLASS(f2fs__rw_end,
@@ -2415,7 +2415,7 @@ DECLARE_EVENT_CLASS(f2fs__rw_end,
 	TP_ARGS(inode, offset, bytes),
 
 	TP_STRUCT__entry(
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	offset)
 		__field(int,	bytes)
 	),
@@ -2426,8 +2426,8 @@ DECLARE_EVENT_CLASS(f2fs__rw_end,
 		__entry->bytes		= bytes;
 	),
 
-	TP_printk("ino %lu, offset %llu, bytes %d",
-		(unsigned long) __entry->ino,
+	TP_printk("ino %llu, offset %llu, bytes %d",
+		(unsigned long long) __entry->ino,
 		__entry->offset, __entry->bytes)
 );
 

-- 
2.53.0


