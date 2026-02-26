Return-Path: <linux-fsdevel+bounces-78533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMYQMSNyoGlZjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:17:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63E1A9EF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AD2931D6EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191A14418C9;
	Thu, 26 Feb 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl95cpRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CF43DA5B;
	Thu, 26 Feb 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121491; cv=none; b=PeYZmj/L5xI1QLKlv55jnblNd52F4v39xaaj0yTTNJVThWQ8hIPfgPxxhKZYHWLh+N7BXbJ3ZJ5/i3Qh50WxHVesgRtAB4N6ihwJc9t3oF/K45OXC3LJUoggSLoUttcmfmLPamKZTO2Gz30GEkJLNFFGO5hPL1H7LF+33Wo6iYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121491; c=relaxed/simple;
	bh=ozE/lysUboEWCQ4+AsDbyvozbN/xqnJrVIKCk8YVbZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUT1Gd/XrrmUYqlm5ZLccPGtpgUZAO9N3IZNfLWs8ecV1yD07BrT4APol5CHRQnnkDGR6YN9CRI/qxh04X/CAy8GASvtfl5Ja5+JtqEVyw4VXH4Zxxiu36GTgiKGOyl0Vr1rCZomWBNPmV8D1qG1WmvbeWHfcy3611OyLE/aBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl95cpRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D41DC2BCB2;
	Thu, 26 Feb 2026 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121490;
	bh=ozE/lysUboEWCQ4+AsDbyvozbN/xqnJrVIKCk8YVbZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tl95cpRHVEy9a69M1dPyVMNrFACinfcHkMSnrsJSJ41F1IPipWKjqo400vZ/NbQmL
	 YUPeHdgF2ouooH4/jZnPdmjQPX2RSD6dAFNXEQ4tMNkFK1U5S52ZKh6MacyqQwTE26
	 wtSaX+iIVp1eFKbZDh7W12pyubn8xXSAdxvT8s1HINUFUGTtKWmViGgo3to2LJ/GNZ
	 x3e9HhxcQyaf3N7GJfprPRO8OPW0OeidM/kJazebnZ1I5YfZCZuocYOM79vYH//gbU
	 evmOTHvoE55jR4g40jSZIXcwGHIK51p3FtqxaWtIEiTLZ9sMRLpKTTeDM+GABiHWej
	 gMu4A7jJHqAHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:11 -0500
Subject: [PATCH 09/61] nfs: remove nfs_fattr_to_ino_t() and
 nfs_fileid_to_ino_t()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-9-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ozE/lysUboEWCQ4+AsDbyvozbN/xqnJrVIKCk8YVbZ8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0GZ9mae1UfEzZjvJD4JiNnRPl5Nhr/tQ1B0
 m90fRG+XeKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBgAKCRAADmhBGVaC
 FUNNEACfph9HeCWuD/qrlt/anxXHRLFJ+N55/jO9WUFZDUHVC1uWe/qFGQB4inv5lvQdKqPNVQz
 kLo8M1E4LrqRBj3bgzhpjGtBRtdmYiYiFQt2QN/RTJcbwBIijGa0Lkeld9r6/v0YlyZZAyCJfRD
 NhjnwmW+pXiLmqpSqPxIJDI//+XA3Zd7HZfWNvamWsLP7P6pRi50+mxB4gSwNuE82jNnfysQ4hr
 xNgXlVCvaQVFcnQY4nIFqDesc7HZ3I6HsZs5cugSfIC7YhrAHnHgzUX1X3F1N7EqHIvN/ETvTxT
 5Kb1+IsLgP78RH9rlvcaM4+z6gCKQ4I0LX0nhb1q+nOK0/yF0B5Wj4FIAJRtnNLtUiyUcBn2yDU
 2B1itmjUhIwUONEgxN6+sBxZsrkmEvCoxhWKbIvKEt7ouyoJPHotIkpyi4Fy6G3gVMX+D962p6U
 +MNYPcdKlUz440uTYnQ0WbFTn+gtR9UZa+8V2v+kTpWMFOlvIa5ChRPEGDqjaMEAzTtgIJJigwL
 hAJZyp1hVGDXzIakUmhDjansPNiZV5PNsqjr3VQle3FQeHZ7zFF2ts2dXb0dky9ODuyE8mmPumA
 Sq2urAsWLtVirge+Vok4tOUNhvuZqt+IVPyWX3gk0VwWIFDl/IGHt+VH4jnZFmOmgKOzkMYIVTI
 c26wc1AgzjeJcnA==
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
	TAGGED_FROM(0.00)[bounces-78533-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6A63E1A9EF6
X-Rspamd-Action: no action

Now that i_ino is u64, these helpers are trivial identity functions that
just return the fileid unchanged. Remove them and use fattr->fileid
directly at the two call sites.

nfs_fileid_to_ino_t() had no callers at all.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c         | 17 +++--------------
 include/linux/nfs_fs.h |  6 ------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 38c7b79e76b3f9eb21d325b98708fe67d159076f..d88f5689548bcb4e27d6087a49b525762fbaa9e2 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -66,12 +66,6 @@ static int nfs_update_inode(struct inode *, struct nfs_fattr *);
 
 static struct kmem_cache * nfs_inode_cachep;
 
-static inline u64
-nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
-{
-	return fattr->fileid;
-}
-
 int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
 	if (unlikely(nfs_current_task_exiting()))
@@ -413,14 +407,12 @@ nfs_ilookup(struct super_block *sb, struct nfs_fattr *fattr, struct nfs_fh *fh)
 		.fattr	= fattr,
 	};
 	struct inode *inode;
-	unsigned long hash;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID) ||
 	    !(fattr->valid & NFS_ATTR_FATTR_TYPE))
 		return NULL;
 
-	hash = nfs_fattr_to_ino_t(fattr);
-	inode = ilookup5(sb, hash, nfs_find_actor, &desc);
+	inode = ilookup5(sb, fattr->fileid, nfs_find_actor, &desc);
 
 	dprintk("%s: returning %p\n", __func__, inode);
 	return inode;
@@ -456,7 +448,6 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 	};
 	struct inode *inode = ERR_PTR(-ENOENT);
 	u64 fattr_supported = NFS_SB(sb)->fattr_valid;
-	unsigned long hash;
 
 	nfs_attr_check_mountpoint(sb, fattr);
 
@@ -467,9 +458,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) == 0)
 		goto out_no_inode;
 
-	hash = nfs_fattr_to_ino_t(fattr);
-
-	inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc);
+	inode = iget5_locked(sb, fattr->fileid, nfs_find_actor, nfs_init_locked, &desc);
 	if (inode == NULL) {
 		inode = ERR_PTR(-ENOMEM);
 		goto out_no_inode;
@@ -481,7 +470,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 
 		/* We set i_ino for the few things that still rely on it,
 		 * such as stat(2) */
-		inode->i_ino = hash;
+		inode->i_ino = fattr->fileid;
 
 		/* We can't support update_atime(), since the server will reset it */
 		inode->i_flags |= S_NOATIME|S_NOCMTIME;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0e6d03c10c3de91cac4cd4d08c961e171cbf9a41..816670562d17b3f46ec2d22d4f9412e42f7e1a3b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -667,12 +667,6 @@ static inline loff_t nfs_size_to_loff_t(__u64 size)
 	return min_t(u64, size, OFFSET_MAX);
 }
 
-static inline u64
-nfs_fileid_to_ino_t(u64 fileid)
-{
-	return fileid;
-}
-
 static inline void nfs_ooo_clear(struct nfs_inode *nfsi)
 {
 	nfsi->cache_validity &= ~NFS_INO_DATA_INVAL_DEFER;

-- 
2.53.0


