Return-Path: <linux-fsdevel+bounces-78537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJUkHthyoGlZjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:20:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE91AA0DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B778308E414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFEB44BCBD;
	Thu, 26 Feb 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDYCUhyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7C44CAC2;
	Thu, 26 Feb 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121541; cv=none; b=uVDkV+QWA4WtvHt4S0zzLy1SSIqYgdmtBKa1m7VYatoOHP27c0FM9wPUJIXfYHiF88e4pRW+Rjj/pJfhr2zeQzOMXjcjcQqNDKuRB724YAj77zqJ22RlVFKN03EM9/1FtIFZ/MD1AUHMt3Yc6+5PFr0U7CTqYLhRGgUyg7QbBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121541; c=relaxed/simple;
	bh=L7XUWaooTPJJGvd9q6jSAUTNKJML0XZHotIv5n8H4j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKRhanXkzpg34iHeFZaoS3he2cl1sto5vVSbspPTJrRNSf3Q+UXZ6h8as/TJ0J1aInhTzorXFbUNPbmGwOKr8Nu+MExTr600StjtkRZPI7xuozBPIbCGQzaAzmz68mI2z7uBCbqQ7P832HIw8H+u8nBO5Z0UIf4NqZoQapNJ/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDYCUhyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7611EC2BCB1;
	Thu, 26 Feb 2026 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121540;
	bh=L7XUWaooTPJJGvd9q6jSAUTNKJML0XZHotIv5n8H4j4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LDYCUhykrUdWv3Pvas2rdur0i6GL1s/gViKIjWTYOQk415nXtcRy1qub/d8XbSUUM
	 D+/aIzVlWqyiVLePUBCzKm79lnQ1Xr/wPlu8hJz+p30Ci3TFMeSOk2X8J6c0Q6CD4P
	 wqxpbdVNoiUFgiqF3pP6i9tkGZpZiFsHB2ZNh7AULTRNWpNsa6ywW5AUy1dN2Kcfe/
	 Vx5kFsXJbZRj/SIYHdOcyOOJCt2ZrUoavPeoIuA6h1ix26kDvpcIxPd9hWIadzGtzi
	 je2BpQkmmncKfavwQ3rkUY8N8k7blVwDs4zRekpa7E2wuHdmSCgnhha8D4eMzH/c5i
	 ELYCW2P9Sj9NQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 26 Feb 2026 10:55:15 -0500
Subject: [PATCH 13/61] smb: store full 64-bit uniqueid in i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-iino-u64-v1-13-ccceff366db9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2164; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L7XUWaooTPJJGvd9q6jSAUTNKJML0XZHotIv5n8H4j4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0HunOlD0IWmS5NY8qKmprauVZ/+4AaY/kFb
 2frMDh17OOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBwAKCRAADmhBGVaC
 FWspD/9kh7G8p9Lzfl68UqO9nfBVJdbhEa18mWKyCpykfsHfHVCWcZlNY8T54jBx2zYSKQAm200
 1Z0WRIhfDjcGIOJIuO1X9JkMJk74ESENbCRK1QIf+n2vy9a5+cGUx1mEKpvq0E5TqwAXHAOoFC6
 3NSHGd431TY35kp8fNX9Pv8z2qXr/BrZtf64mNkWZ+/pgmbU4lwAMmANpFvRPRnZqDD4h55PgKa
 lRo93MwRT/GFVpdhyvySZu0ylZqlFqaKbT+XlbjplF26+5RjXAyunICxi6rDIPXVGD+aibZ7EPn
 dM3dAr+QTk+c4IRV6A1q2wP27vVBRHznWmq5Z7eCnNBGaaIG8v+XzuAkLBejSZi7qst5JE4qtvd
 CC2R1LYEW6s5Jgvz/eOxoK3G4Fr/Lbqcn2BVBH5846qvSmHY/tv+80Svxawf31ts+zo8j3TcCyA
 3Bb3UAA6oh6ycWf79FO6g6bY5UQpB1HNGB0wUIW7DiG2qplnSGUTlZQuhos0ulGYVhDfOziO0by
 eGvFmxwnDmQm47WJ3l6yO+WZ865DhG4wuBmhoMjmQ/e8qkfYmrpArIHr2WNzFK9Hl+9tCXAz3oN
 +BFn6v+B/UueV6kf5rFpJzAJiyu3TKMJH4KK2uGs1vnYofltFVpo96fk1iXzdofYRCPQa9M4uut
 SbvrPRHyi0Vl/Dw==
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
	TAGGED_FROM(0.00)[bounces-78537-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 28AE91AA0DC
X-Rspamd-Action: no action

With i_ino now u64, CIFS/SMB can store the full 64-bit uniqueid in
i_ino without the XOR-folding hack previously needed on 32-bit
architectures.

- Simplify cifs_uniqueid_to_ino_t() to return u64 directly
- Update hash variable type in cifs_get_inode_info()
- Update format strings from %lu to %llu

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/cifsfs.h | 12 +++---------
 fs/smb/client/inode.c  |  4 ++--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index e320d39b01f5eca8033cc516f6f1a2f07276676c..4a1f18022c711a7ff5b141d08ec6cac8483a6b6a 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -14,18 +14,12 @@
 #define ROOT_I 2
 
 /*
- * ino_t is 32-bits on 32-bit arch. We have to squash the 64-bit value down
- * so that it will fit. We use hash_64 to convert the value to 31 bits, and
- * then add 1, to ensure that we don't end up with a 0 as the value.
+ * With i_ino being u64, we can store the full 64-bit uniqueid directly.
  */
-static inline ino_t
+static inline u64
 cifs_uniqueid_to_ino_t(u64 fileid)
 {
-	if ((sizeof(ino_t)) < (sizeof(u64)))
-		return (ino_t)hash_64(fileid, (sizeof(ino_t) * 8) - 1) + 1;
-
-	return (ino_t)fileid;
-
+	return fileid;
 }
 
 static inline void cifs_set_time(struct dentry *dentry, unsigned long time)
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d4d3cfeb6c90ee6dc71fcd9a8de31a1785cbb9ef..102e7615b658726551e9b01ba25065d1f0c505ac 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1611,13 +1611,13 @@ inode_has_hashed_dentries(struct inode *inode)
 struct inode *
 cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 {
-	unsigned long hash;
+	u64 hash;
 	struct inode *inode;
 
 retry_iget5_locked:
 	cifs_dbg(FYI, "looking for uniqueid=%llu\n", fattr->cf_uniqueid);
 
-	/* hash down to 32-bits on 32-bit arch */
+	/* With u64 i_ino, we can use the full uniqueid */
 	hash = cifs_uniqueid_to_ino_t(fattr->cf_uniqueid);
 
 	inode = iget5_locked(sb, hash, cifs_find_inode, cifs_init_inode, fattr);

-- 
2.53.0


