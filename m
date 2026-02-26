Return-Path: <linux-fsdevel+bounces-78534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M6THVxyoGlZjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:18:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7451A9F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1CB4311D549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4FC44A702;
	Thu, 26 Feb 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCt3uwXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1277429812;
	Thu, 26 Feb 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121504; cv=none; b=nXG1yvy1BBYdcWKxmXYeRSJ0ULMhgMwLuzuYbxGB2OZceUvvXVpZINwm3CYhuMEQy+KIjF3EEmBWdT8ML7LmpefSWLmQ8Ob+g6JmZDj5AU5tMfqMeShUx3a+PHEVVXI6L0MjY74SaxL+OL4SLsTcNbooAcwU1paMFKTeRxVkfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121504; c=relaxed/simple;
	bh=LdZkgMiSMRyY7w4wkYXYbMfPdYZGHhFy6fPC/XGukhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZHLbS0E9hf6uMbJoxJyltlRCpCqGFViyPZ+X7OcGdJLc9yDySMek20rQFm0fnK4Ghs5jSqW1Tqw9R2R0CbMB7IP+TC0500pZeHahY53oI9GtyQFWUNUJZ38u8R524Cvr/N3E3ALKbjsymI9AT0Ik/f3NRp2+sQ2r3wwrgC0OmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCt3uwXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FE1C19424;
	Thu, 26 Feb 2026 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121503;
	bh=LdZkgMiSMRyY7w4wkYXYbMfPdYZGHhFy6fPC/XGukhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dCt3uwXVqrIJKbQvl3uX9/gup6SlY+mQqX91Ad9vd7S8op6Yd+KnCAZfqT4OSuZ5h
	 bFGxqPsbtlVvSFA4/Lcr/ut8yak5t5k7WCf1y5xyJDtumk+D//S9Di9nluiniHliYC
	 n6eVHA0dgSRDHNycrjK4MqfgaELytBs0GHEHSXiF38hbEWVUj9xLFXhbX16GPBXJMZ
	 EWNLIPkjbNzqBFPY4qkwolYq3Ss4/8HVyAO6aOFGde9RPZDyI3a7asDXIiMWO1moUp
	 C5DzD0aiQOnrsnc3jTtDPTUBA6EVUpdOUkm5ZK+MlUq+bpXUpYb2af9356FNFx49bL
	 9plvVtOi3V43A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:12 -0500
Subject: [PATCH 10/61] nfs: remove nfs_compat_user_ino64()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-10-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LdZkgMiSMRyY7w4wkYXYbMfPdYZGHhFy6fPC/XGukhU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0GsDBsYnVAsr/6aY+OdwYGWSxrZsM8EJuxC
 Q78RgWfUx+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBgAKCRAADmhBGVaC
 Few+D/4mutU81rl2n75boDhsJKJUaSJoujeBAfusAFqLjMdwyXIMSpj4L7+chJ7lo0OoNZKL9Tz
 FJ/WpcytXS5tASm4LU5ttoves66soBtPT/e9jqIden5a+xNYd2xdMQz2GkYLU8UoEDMKz2B4FWi
 bbXP1cdIi+Gs1L00idufQp9klca91ib/uh4ZDWmILa66KtgJiqpNT8IW/FZ+rRbL4DxXzX9Odyw
 xY3XP2mOemu+oUKNHuaVtKqd/mo7+/mrtnfTxGbycSCIYvUq4xZiWRa2HaeeW9mJ9AW8PgceRxS
 Xe+5t/g4fR7ybGLeaa1lxM441cQIrG2VjJMCglE62qoaOPbG1U7nhQQbq49cVdXftZu3qvqe08b
 xZZ1Zb1Xj2BLi+1LZc2hU083aHI6YGhzjD/uu33zfHrY43PjKARDtU8ke1+4BWZ7SDJgXlNXqqT
 +XlOWV4PRKQoQcLIhLJZMRvGpY5Uf2fAN5IWLCUcXxUG73lbx2woNUdFTxa7siP3V5FgljMFZIh
 ud/Fy3p+krV0hwTknttuuV+JC1OGV4wXj6aIOpmLjOd7gQy1p8SNSdR6SL+XZg7OsWQZCRqSZpH
 4xHedLHyQldZ+1gf5fEeSO+f7vru2AwppvkFyWar5ihu7zNrouABbWaJDO0QkNsPsXetXqyntDa
 PQTg7n2ICcFlcnw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78534-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 3D7451A9F96
X-Rspamd-Action: no action

Now that i_ino is u64, the VFS stat path handles 64-bit inode numbers
natively. The truncation to 32-bit st_ino (with -EOVERFLOW) is handled
by cp_new_stat() and cp_compat_stat() in the generic stat code, so the
NFS-specific XOR-folding hack is no longer needed.

Remove nfs_compat_user_ino64() and have callers pass the full 64-bit
fileid directly to stat->ino and dir_emit(), both of which accept u64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dir.c           |  2 +-
 fs/nfs/inode.c         | 25 +------------------------
 include/linux/nfs_fs.h |  1 -
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ddc3789363a5f8a2ef0169e37aa2292d075092c4..a9ef74d0cff8de58a42be9c2c94af428a347bb2e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1107,7 +1107,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 
 		ent = &array->array[i];
 		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
-		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
+		    ent->ino, ent->d_type)) {
 			desc->eob = true;
 			break;
 		}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d88f5689548bcb4e27d6087a49b525762fbaa9e2..1a7d7bafbb623ab603b8c517628343463277e096 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -77,29 +77,6 @@ int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 }
 EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
 
-/**
- * nfs_compat_user_ino64 - returns the user-visible inode number
- * @fileid: 64-bit fileid
- *
- * This function returns a 32-bit inode number if the boot parameter
- * nfs.enable_ino64 is zero.
- */
-u64 nfs_compat_user_ino64(u64 fileid)
-{
-#ifdef CONFIG_COMPAT
-	compat_ulong_t ino;
-#else	
-	unsigned long ino;
-#endif
-
-	if (enable_ino64)
-		return fileid;
-	ino = fileid;
-	if (sizeof(ino) < sizeof(fileid))
-		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
-	return ino;
-}
-
 int nfs_drop_inode(struct inode *inode)
 {
 	return NFS_STALE(inode) || inode_generic_drop(inode);
@@ -1061,7 +1038,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+	stat->ino = NFS_FILEID(inode);
 	stat->change_cookie = inode_peek_iversion_raw(inode);
 	stat->attributes_mask |= STATX_ATTR_CHANGE_MONOTONIC;
 	if (server->change_attr_type != NFS4_CHANGE_TYPE_IS_UNDEFINED)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 816670562d17b3f46ec2d22d4f9412e42f7e1a3b..d721a8acbb449666941ec19b18386b42c152db10 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -472,7 +472,6 @@ extern void nfs_file_set_open_context(struct file *filp, struct nfs_open_context
 extern void nfs_file_clear_open_context(struct file *flip);
 extern struct nfs_lock_context *nfs_get_lock_context(struct nfs_open_context *ctx);
 extern void nfs_put_lock_context(struct nfs_lock_context *l_ctx);
-extern u64 nfs_compat_user_ino64(u64 fileid);
 extern void nfs_fattr_init(struct nfs_fattr *fattr);
 extern void nfs_fattr_set_barrier(struct nfs_fattr *fattr);
 extern unsigned long nfs_inc_attr_generation_counter(void);

-- 
2.53.0


