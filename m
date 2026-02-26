Return-Path: <linux-fsdevel+bounces-78538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGb0OLp2oGmtjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:37:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C041AAA2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E3830F17F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF9044D68C;
	Thu, 26 Feb 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghaIMgZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121844CF32;
	Thu, 26 Feb 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121554; cv=none; b=Z0RdCT8MiUULmEvR8hEgObySTbROvxBwfhjNw/ODP6uW8ldmgZm+VioRque1BW3280pgaBP00bh7xJzVSm4yWX6h5nfiaGA+jQxb31DuLI1wZQVtbbB7aboq8lxOR+zB7xHe+SxnkWm2oEEJ/8e7o5Cb3ZHpPe11+x5IbBGN/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121554; c=relaxed/simple;
	bh=/dIyAeV0SWp+d5wV41a2YQTvW0T+tDEAvSeW39MxQrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXLRMJ+xCoBEkCfmGClZ/J4lYcQbQaS7hpnC8LVryQTSmLIRTzmbp78q0pQB4LcnY14ZIj/LVqIqQokoh3ggpHFqEtSqaViNGMN5Pf5BVwqqEY0F3KbnTQCcQkrnInUQVHTPidV7tuTJsqKxchl4NfLKt8UMrMZsxS8QfK2iZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghaIMgZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21497C2BCB2;
	Thu, 26 Feb 2026 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121553;
	bh=/dIyAeV0SWp+d5wV41a2YQTvW0T+tDEAvSeW39MxQrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ghaIMgZ0Kc9sSFxLqN3M3k3TK+60uJC0pPBBx9i2Lxpt0oo/B72RlYrHZ5doKyEj4
	 p/nyNLpPDIidxOkEnm7U3/35E11ov0+Rb0jIejiEJmkHCz0aVwJZRyvIN1zXco/Yjz
	 d6H2cjgr2HTg0vooB26P2lu8M8somfn6uC4kg8yaF3AKM7eZGMimt73uTMiqXnPm0N
	 yhIX1ErPK7xbvUpa2Y3UR81NlDwbK+tc3MCOm3fD704u1tguf4hCtEdOipJWTvG+90
	 W0dnZ3lqQTX5vShOId2hTZvCGE6hOF7cSapC3LXaJJboq6djJCIAwfUZQXky+bBZKX
	 KEYsgUDdZmazA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:16 -0500
Subject: [PATCH 14/61] smb: remove cifs_uniqueid_to_ino_t()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-14-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/dIyAeV0SWp+d5wV41a2YQTvW0T+tDEAvSeW39MxQrw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0HEnCSKK/SHb3sYW/c+eUblqdBA7d53olyL
 4HBWYDiVJmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBwAKCRAADmhBGVaC
 FZpYEACU6I0oc4IB+ERKTJODeo5sUbUQRcurbkTkmeBdHU+MAD5YdiZ6z83x8OfcmpXWliPk5Ya
 u7AmLMTAsggh98Rh4QxIO+fwJLpw4ZIK1sEPEhfrzx2Mgoa9MXxpfxwLrHMTDktm0UmImLGKuIf
 yIsqBYSeqK50NLbrZmGWoz6GnXH2YyhrZboFMWnt3vm2eKyCA2IfY5cpb8RmBEzOhc2MIYSUKJp
 c1vDjKmB5HdCEbItlJxl0T+SLOrSQSDwqM2tt75fI2d0FL4k36/L5myAi/kfDy85B/w7xVV6VpB
 EPgaEOCOTjEOfCNsZ3dMpzRZ1OxTuEfuYWvqD/qrQYx30qYjjv2BTr6x8/8i0AjFF2MxCT6cMUF
 JEtme2MWU9XZ6fOnYlbsXvScqGY89Xrq0gULrm//VGWgzKBiZRLR9JDj+rpklL65JZvEyXG9ODI
 v2DH1wdJq7wy+QuXfNJrHleTpkA1Efl7+FFi1OBwkJVrdFEKMDxkFUDYJlRUXEFaZqcaBZZwazU
 QjNwVDsgfKk44TmlVoSyAOa9vYw/0LYojdfN8/k6ojhYSAyaCwmTTWi8n7vY7cgmuqoJXf+DuEV
 bTHCuOqlSQp/scKU84C72kyiBfqs3OKPxgoG0kfTlDICkZK3DbX/LfyRxd4grRdimZjMkLQgkOf
 Qzu15dS5Cp6Qypw==
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
	TAGGED_FROM(0.00)[bounces-78538-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D0C041AAA2C
X-Rspamd-Action: no action

Now that i_ino is u64, cifs_uniqueid_to_ino_t() is a trivial identity
function. Remove it and use fattr->cf_uniqueid directly at both call
sites.

Also remove the now-unused #include <linux/hash.h>, which was only
needed for the old XOR-folding logic.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/cifsfs.h  | 11 -----------
 fs/smb/client/inode.c   |  2 +-
 fs/smb/client/readdir.c |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 4a1f18022c711a7ff5b141d08ec6cac8483a6b6a..f71b490b548c0274f314dd0dc76bf570ee3cfd09 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -9,19 +9,8 @@
 #ifndef _CIFSFS_H
 #define _CIFSFS_H
 
-#include <linux/hash.h>
-
 #define ROOT_I 2
 
-/*
- * With i_ino being u64, we can store the full 64-bit uniqueid directly.
- */
-static inline u64
-cifs_uniqueid_to_ino_t(u64 fileid)
-{
-	return fileid;
-}
-
 static inline void cifs_set_time(struct dentry *dentry, unsigned long time)
 {
 	dentry->d_fsdata = (void *) time;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 102e7615b658726551e9b01ba25065d1f0c505ac..a82f4fbf8146572e522080bcd7df41153403978d 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1618,7 +1618,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 	cifs_dbg(FYI, "looking for uniqueid=%llu\n", fattr->cf_uniqueid);
 
 	/* With u64 i_ino, we can use the full uniqueid */
-	hash = cifs_uniqueid_to_ino_t(fattr->cf_uniqueid);
+	hash = fattr->cf_uniqueid;
 
 	inode = iget5_locked(sb, hash, cifs_find_inode, cifs_init_inode, fattr);
 	if (inode) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 8615a8747b7f0127a781b9b3795535df4c9b73cd..cec74bd2e2302c3baeba8d7e1348ba5114d4b1e4 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -919,7 +919,7 @@ static bool cifs_dir_emit(struct dir_context *ctx,
 {
 	size_t delta_bytes = 0;
 	bool rc, added = false;
-	ino_t ino = cifs_uniqueid_to_ino_t(fattr->cf_uniqueid);
+	ino_t ino = fattr->cf_uniqueid;
 
 	rc = dir_emit(ctx, name, namelen, ino, fattr->cf_dtype);
 	if (!rc)

-- 
2.53.0


