Return-Path: <linux-fsdevel+bounces-78531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH2YC491oGmtjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:32:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B81AA753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68E763158275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F443E9CA;
	Thu, 26 Feb 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/igDdHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D843D4FE;
	Thu, 26 Feb 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121478; cv=none; b=JHkjAf5iJEWxKSJX03mNypu5a5m8sPctYbLG113NwYDPq8CPd7DpZCHAfdRZfPWWZpJs/S9xb5uOgZMU3bhl3yGqU6NVtOhbDJ3ai0lQmzSiXa94dlzLtkDInsk2d/U9WcNxsdURww3O/c8oOUr/UxfKCAN5fj8YtrUQUQRNjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121478; c=relaxed/simple;
	bh=2vDKWRQilb9IoiJLjkhK489J39APT+aTf2irzz3tlyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HewD9uXTDNqFDwLujIi7SttiDEiqHyzp8HIryIUPXX2LZJqtPXtPvNqTnHYdUClCl9bOSG6rI5zZBe7Ww0pfR4NACIavuwnk8j7gxDosuw231lUitYFwym0MwZfksS7TPVj/uLVzDGI1JsLUMObtUnWq24+B332UFCtAK9O8dJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/igDdHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BE5C2BCF5;
	Thu, 26 Feb 2026 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121478;
	bh=2vDKWRQilb9IoiJLjkhK489J39APT+aTf2irzz3tlyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A/igDdHjQqH9fWrqjSGVVs9v23OBd2fx3CB2GdIqLofJXQo7Yt7HTtoDGgI98qD0l
	 7kQ9h73j7rxfTDlQfe4ZvKtxCEjMLW39WmiOUsh9F7a5SC1wcETwmTdSBMW5wjBdFp
	 EYUWuOIfYau0x9HXdxKOGA6m3wdkAdGPW+EcLtiv9K9kgGW6CMyUQaQ3lUZuY4fVg5
	 21kPmEtZSY+Nq6Xew8HExHcXDLnlpNRmLaQQWfVvCdnd/kV+npyQfYjALD1bBfFbiO
	 CD0zDyNpJg9JZfGFOTsjro2AbdcIY+mtD+zJOhED3+8X7HbDhqjafXpwKcxKFJUge9
	 Osp67MOwCAeDQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:10 -0500
Subject: [PATCH 08/61] nfs: update for u64 i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-8-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15412; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2vDKWRQilb9IoiJLjkhK489J39APT+aTf2irzz3tlyw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0GFGj8VXhjIr6zTim1aThnEhsB1jC8V0bbX
 PB27lzU8faJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBgAKCRAADmhBGVaC
 FQ6RD/9HYYxH5HKIDUVwyzOPql9XakJoE5zucoV9xv2C5Q3zpZgv6RG1p7CoI5ilNT7UtTAfiJc
 ewJoQyXfISruUsPwt9uRlXT5XuTJfiYU/jPU3vDU3Imldz4+POB2uT2phbbOW7JLOAMJokM4WL+
 N5mLz2shlIZJdANglzkgFkw2Vh2SI0EmFdUw5VnnHA9fKOf5mOmRYw1ZCsAMOjQb/snNW68alaf
 FUGgSsTWLadGprvmtOoysEBfvC1WRzlw+C3XiCI5zbkJqdi90+IyjOojZ40hHgMYIk1TTah3Cdj
 4uYdPOvGJVbZFCQ9YhR5d0h0gt+pxpaLvvvj1n/5G8LDw8UrmKILeoktqe3aP3WCoZpb0/3iU8Y
 IMr5uvBuq3HHrXsWEE1rfHwSzRML7EWQHGPrw0chrhS5D/EmdeBhI5UHWfful2CVyu6VbTXrUNL
 BDTg7SND8QTky/53kg1Odhp7exmGm9hiG9ZTUVML4yeCVsvbncgoubGjYI0/X1Cvh2QKjsc4XKL
 fq6dWcMrQWB76reIKIG+LbEhIsYbkRvchczR39EWP/ONi0f0w6+fV/FZRQOqtIIpVg4PhYORBOs
 vryN36zi8vlV6twCmqJmNNkRRROoprllqZ3vriysVSJxdUJ8oRS9mkeCB2L5+6C4z4XBijl2o/F
 WE1oPtiM4+mBqrw==
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
	TAGGED_FROM(0.00)[bounces-78531-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 085B81AA753
X-Rspamd-Action: no action

Update NFS for u64 i_ino:

- Simplify nfs_fileid_to_ino_t() to return u64 directly, since i_ino
  can now store a full 64-bit fileid without folding on 32-bit
- Update nfs_fattr_to_ino_t() to return u64
- Update format strings from %lu/%lx to %llu/%llx
- Remove unnecessary (unsigned long) casts on i_ino

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dir.c                           | 20 ++++++++++----------
 fs/nfs/file.c                          |  8 ++++----
 fs/nfs/filelayout/filelayout.c         |  8 ++++----
 fs/nfs/flexfilelayout/flexfilelayout.c |  8 ++++----
 fs/nfs/inode.c                         | 10 +++++-----
 fs/nfs/nfs4proc.c                      |  4 ++--
 fs/nfs/pnfs.c                          | 12 ++++++------
 include/linux/nfs_fs.h                 |  7 ++-----
 8 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d932c4656a1439f1deff7954e0dc4..ddc3789363a5f8a2ef0169e37aa2292d075092c4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1906,7 +1906,7 @@ static int nfs_weak_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	error = nfs_lookup_verify_inode(inode, flags);
-	dfprintk(LOOKUPCACHE, "NFS: %s: inode %lu is %s\n",
+	dfprintk(LOOKUPCACHE, "NFS: %s: inode %llu is %s\n",
 			__func__, inode->i_ino, error ? "invalid" : "valid");
 	return !error;
 }
@@ -2121,7 +2121,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	/* Expect a negative dentry */
 	BUG_ON(d_inode(dentry));
 
-	dfprintk(VFS, "NFS: atomic_open(%s/%lu), %pd\n",
+	dfprintk(VFS, "NFS: atomic_open(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
 	err = nfs_check_flags(open_flags);
@@ -2404,7 +2404,7 @@ static int nfs_do_create(struct inode *dir, struct dentry *dentry,
 
 	open_flags |= O_CREAT;
 
-	dfprintk(VFS, "NFS: create(%s/%lu), %pd\n",
+	dfprintk(VFS, "NFS: create(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
 	attr.ia_mode = mode;
@@ -2442,7 +2442,7 @@ nfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct iattr attr;
 	int status;
 
-	dfprintk(VFS, "NFS: mknod(%s/%lu), %pd\n",
+	dfprintk(VFS, "NFS: mknod(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
 	attr.ia_mode = mode;
@@ -2469,7 +2469,7 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct iattr attr;
 	struct dentry *ret;
 
-	dfprintk(VFS, "NFS: mkdir(%s/%lu), %pd\n",
+	dfprintk(VFS, "NFS: mkdir(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
 	attr.ia_valid = ATTR_MODE;
@@ -2507,7 +2507,7 @@ int nfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int error;
 
-	dfprintk(VFS, "NFS: rmdir(%s/%lu), %pd\n",
+	dfprintk(VFS, "NFS: rmdir(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
 	trace_nfs_rmdir_enter(dir, dentry);
@@ -2578,7 +2578,7 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
 
-	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
+	dfprintk(VFS, "NFS: unlink(%s/%llu, %pd)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry);
 
 	trace_nfs_unlink_enter(dir, dentry);
@@ -2638,7 +2638,7 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	unsigned int pathlen = strlen(symname);
 	int error;
 
-	dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s)\n", dir->i_sb->s_id,
+	dfprintk(VFS, "NFS: symlink(%s/%llu, %pd, %s)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry, symname);
 
 	if (pathlen > PAGE_SIZE)
@@ -2660,7 +2660,7 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	error = NFS_PROTO(dir)->symlink(dir, dentry, folio, pathlen, &attr);
 	trace_nfs_symlink_exit(dir, dentry, error);
 	if (error != 0) {
-		dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s) error %d\n",
+		dfprintk(VFS, "NFS: symlink(%s/%llu, %pd, %s) error %d\n",
 			dir->i_sb->s_id, dir->i_ino,
 			dentry, symname, error);
 		d_drop(dentry);
@@ -3414,7 +3414,7 @@ int nfs_permission(struct mnt_idmap *idmap,
 	if (!res && (mask & MAY_EXEC))
 		res = nfs_execute_ok(inode, mask);
 
-	dfprintk(VFS, "NFS: permission(%s/%lu), mask=0x%x, res=%d\n",
+	dfprintk(VFS, "NFS: permission(%s/%llu), mask=0x%x, res=%d\n",
 		inode->i_sb->s_id, inode->i_ino, mask, res);
 	return res;
 out_notsup:
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 5d08b6409c284f1ee78f1c2fa327e447eee1ab69..25048a3c236436f334c87e2d58614f8af8929560 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -391,7 +391,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
 
 	trace_nfs_write_begin(file_inode(file), pos, len);
 
-	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
+	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%llu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos);
 
@@ -432,7 +432,7 @@ static int nfs_write_end(const struct kiocb *iocb,
 	int status;
 
 	trace_nfs_write_end(file_inode(file), pos, len);
-	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
+	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%llu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
 	/*
@@ -557,7 +557,7 @@ static int nfs_launder_folio(struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	int ret;
 
-	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
+	dfprintk(PAGECACHE, "NFS: launder_folio(%llu, %llu)\n",
 		inode->i_ino, folio_pos(folio));
 
 	folio_wait_private_2(folio); /* [DEPRECATED] */
@@ -647,7 +647,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct address_space *mapping;
 	struct folio *folio = page_folio(vmf->page);
 
-	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
+	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%llu), offset %lld)\n",
 		 filp, filp->f_mapping->host->i_ino,
 		 (long long)folio_pos(folio));
 
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 90a11afa5d05423bb289c7f2020ef3b82707a79c..e85380e3b11d7271a9b795e62840074834d77a72 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -241,7 +241,7 @@ filelayout_set_layoutcommit(struct nfs_pgio_header *hdr)
 
 	/* Note: if the write is unstable, don't set end_offs until commit */
 	pnfs_set_layoutcommit(hdr->inode, hdr->lseg, end_offs);
-	dprintk("%s inode %lu pls_end_pos %lu\n", __func__, hdr->inode->i_ino,
+	dprintk("%s inode %llu pls_end_pos %lu\n", __func__, hdr->inode->i_ino,
 		(unsigned long) NFS_I(hdr->inode)->layout->plh_lwb);
 }
 
@@ -456,7 +456,7 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 	u32 j, idx;
 	struct nfs_fh *fh;
 
-	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
+	dprintk("--> %s ino %llu pgbase %u req %zu@%llu\n",
 		__func__, hdr->inode->i_ino,
 		hdr->args.pgbase, (size_t)hdr->args.count, offset);
 
@@ -514,7 +514,7 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	if (IS_ERR(ds_clnt))
 		return PNFS_NOT_ATTEMPTED;
 
-	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d\n",
+	dprintk("%s ino %llu sync %d req %zu@%llu DS: %s cl_count %d\n",
 		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
 		offset, ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count));
 
@@ -1001,7 +1001,7 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
 	if (IS_ERR(ds_clnt))
 		goto out_err;
 
-	dprintk("%s ino %lu, how %d cl_count %d\n", __func__,
+	dprintk("%s ino %llu, how %d cl_count %d\n", __func__,
 		data->inode->i_ino, how, refcount_read(&ds->ds_clp->cl_count));
 	data->commit_done_cb = filelayout_commit_done_cb;
 	refcount_inc(&ds->ds_clp->cl_count);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f67773d52830d2ab4d12dd04caccc2077d4105e0..8b1559171fe3977f1b8461db6266c8c0d6c51ba5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1631,7 +1631,7 @@ ff_layout_set_layoutcommit(struct inode *inode,
 		return;
 
 	pnfs_set_layoutcommit(inode, lseg, end_offset);
-	dprintk("%s inode %lu pls_end_pos %llu\n", __func__, inode->i_ino,
+	dprintk("%s inode %llu pls_end_pos %llu\n", __func__, inode->i_ino,
 		(unsigned long long) NFS_I(inode)->layout->plh_lwb);
 }
 
@@ -2136,7 +2136,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	u32 dss_id;
 	bool ds_fatal_error = false;
 
-	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
+	dprintk("--> %s ino %llu pgbase %u req %zu@%llu\n",
 		__func__, hdr->inode->i_ino,
 		hdr->args.pgbase, (size_t)hdr->args.count, offset);
 
@@ -2245,7 +2245,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 
 	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
 
-	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d vers %d\n",
+	dprintk("%s ino %llu sync %d req %zu@%llu DS: %s cl_count %d vers %d\n",
 		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
 		offset, ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count),
 		vers);
@@ -2336,7 +2336,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 
 	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
 
-	dprintk("%s ino %lu, how %d cl_count %d vers %d\n", __func__,
+	dprintk("%s ino %llu, how %d cl_count %d vers %d\n", __func__,
 		data->inode->i_ino, how, refcount_read(&ds->ds_clp->cl_count),
 		vers);
 	data->commit_done_cb = ff_layout_commit_done_cb;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4786343eeee0f874aa1f31ace2f35fdcb83fc7a6..38c7b79e76b3f9eb21d325b98708fe67d159076f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -66,10 +66,10 @@ static int nfs_update_inode(struct inode *, struct nfs_fattr *);
 
 static struct kmem_cache * nfs_inode_cachep;
 
-static inline unsigned long
+static inline u64
 nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 {
-	return nfs_fileid_to_ino_t(fattr->fileid);
+	return fattr->fileid;
 }
 
 int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
@@ -2258,7 +2258,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	bool attr_changed = false;
 	bool have_delegation;
 
-	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%llx)\n",
+	dfprintk(VFS, "NFS: %s(%s/%llu fh_crc=0x%08x ct=%d info=0x%llx)\n",
 			__func__, inode->i_sb->s_id, inode->i_ino,
 			nfs_display_fhandle_hash(NFS_FH(inode)),
 			icount_read(inode), fattr->valid);
@@ -2288,7 +2288,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		/*
 		* Big trouble! The inode has become a different object.
 		*/
-		printk(KERN_DEBUG "NFS: %s: inode %lu mode changed, %07o to %07o\n",
+		printk(KERN_DEBUG "NFS: %s: inode %llu mode changed, %07o to %07o\n",
 				__func__, inode->i_ino, inode->i_mode, fattr->mode);
 		goto out_err;
 	}
@@ -2358,7 +2358,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
-				dprintk("NFS: change_attr change on server for file %s/%ld\n",
+				dprintk("NFS: change_attr change on server for file %s/%lld\n",
 						inode->i_sb->s_id,
 						inode->i_ino);
 			} else if (!have_delegation) {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743f72a008a9dcde29207bf7a36c407..d839a97df822abb9fb0efd25f3402fcca82d4038 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4714,7 +4714,7 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(server->nfs_client, &args.seq_args, &res.seq_res, 0, 0);
 
-	dprintk("NFS call  lookupp ino=0x%lx\n", inode->i_ino);
+	dprintk("NFS call  lookupp ino=0x%llx\n", inode->i_ino);
 	status = nfs4_do_call_sync(clnt, server, &msg, &args.seq_args,
 				   &res.seq_res, task_flags);
 	dprintk("NFS reply lookupp: %d\n", status);
@@ -10019,7 +10019,7 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
 	int status = 0;
 
 	dprintk("NFS: initiating layoutcommit call. sync %d "
-		"lbw: %llu inode %lu\n", sync,
+		"lbw: %llu inode %llu\n", sync,
 		data->args.lastbytewritten,
 		data->args.inode->i_ino);
 
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index bc13d1e69449ce9bb3ed3ef0bbff06dfab5c60b5..e79deb9bf664df3424d9c26d3390799969d0499e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -891,7 +891,7 @@ pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
 	while (!list_empty(layout_list)) {
 		lo = list_entry(layout_list->next, struct pnfs_layout_hdr,
 				plh_bulk_destroy);
-		dprintk("%s freeing layout for inode %lu\n", __func__,
+		dprintk("%s freeing layout for inode %llu\n", __func__,
 			lo->plh_inode->i_ino);
 		inode = lo->plh_inode;
 
@@ -1440,7 +1440,7 @@ _pnfs_return_layout(struct inode *ino)
 	int status = 0;
 	bool send, valid_layout;
 
-	dprintk("NFS: %s for inode %lu\n", __func__, ino->i_ino);
+	dprintk("NFS: %s for inode %llu\n", __func__, ino->i_ino);
 
 	spin_lock(&ino->i_lock);
 	lo = nfsi->layout;
@@ -3055,7 +3055,7 @@ pnfs_try_to_write_data(struct nfs_pgio_header *hdr,
 
 	hdr->mds_ops = call_ops;
 
-	dprintk("%s: Writing ino:%lu %u@%llu (how %d)\n", __func__,
+	dprintk("%s: Writing ino:%llu %u@%llu (how %d)\n", __func__,
 		inode->i_ino, hdr->args.count, hdr->args.offset, how);
 	trypnfs = nfss->pnfs_curr_ld->write_pagelist(hdr, how);
 	if (trypnfs != PNFS_NOT_ATTEMPTED)
@@ -3181,7 +3181,7 @@ pnfs_try_to_read_data(struct nfs_pgio_header *hdr,
 
 	hdr->mds_ops = call_ops;
 
-	dprintk("%s: Reading ino:%lu %u@%llu\n",
+	dprintk("%s: Reading ino:%llu %u@%llu\n",
 		__func__, inode->i_ino, hdr->args.count, hdr->args.offset);
 
 	trypnfs = nfss->pnfs_curr_ld->read_pagelist(hdr);
@@ -3314,7 +3314,7 @@ pnfs_set_layoutcommit(struct inode *inode, struct pnfs_layout_segment *lseg,
 	if (!test_and_set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags)) {
 		nfsi->layout->plh_lwb = end_pos;
 		mark_as_dirty = true;
-		dprintk("%s: Set layoutcommit for inode %lu ",
+		dprintk("%s: Set layoutcommit for inode %llu ",
 			__func__, inode->i_ino);
 	} else if (end_pos > nfsi->layout->plh_lwb)
 		nfsi->layout->plh_lwb = end_pos;
@@ -3363,7 +3363,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (!pnfs_layoutcommit_outstanding(inode))
 		return 0;
 
-	dprintk("--> %s inode %lu\n", __func__, inode->i_ino);
+	dprintk("--> %s inode %llu\n", __func__, inode->i_ino);
 
 	status = -EAGAIN;
 	if (test_and_set_bit(NFS_INO_LAYOUTCOMMITTING, &nfsi->flags)) {
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8dd79a3f3d662bfe8ef8f72bb88ad1e2cd40527e..0e6d03c10c3de91cac4cd4d08c961e171cbf9a41 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -667,13 +667,10 @@ static inline loff_t nfs_size_to_loff_t(__u64 size)
 	return min_t(u64, size, OFFSET_MAX);
 }
 
-static inline ino_t
+static inline u64
 nfs_fileid_to_ino_t(u64 fileid)
 {
-	ino_t ino = (ino_t) fileid;
-	if (sizeof(ino_t) < sizeof(u64))
-		ino ^= fileid >> (sizeof(u64)-sizeof(ino_t)) * 8;
-	return ino;
+	return fileid;
 }
 
 static inline void nfs_ooo_clear(struct nfs_inode *nfsi)

-- 
2.53.0


