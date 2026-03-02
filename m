Return-Path: <linux-fsdevel+bounces-78977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHbhMxr3pWl5IQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:46:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B931E08D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 565F8308511B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC6E4A2E17;
	Mon,  2 Mar 2026 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB4qX4iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51164496918;
	Mon,  2 Mar 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483316; cv=none; b=tSWHfqrj2+URmN1Wq/7ltMS5gwnXwn74p1ID6H500oWRtPxEBEr4nzuiGhhNuYwROxnyHusTCL1CzLl7VWBhMGwMxP49rESis8lA5kGCjQinWnM6zzuzSq4J/acfQqubOa7O4KGLHEBHRGIPm5nrrhxAEirFsYmTn5pBmDYwlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483316; c=relaxed/simple;
	bh=Or7iYbRQR6Ro+Fuj5qMWsLawwpEXd/6MxzP7NG3XnZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWVrVGrt5TKZGId8BE+n6d/zShKaBi8m/xHzITsLFRfFh2R7XoBPOW42CQUMIilDeVUuyJwYnRJzpRvoegDslF9+okylWwOyPPGMUb2KYjMXFaZlpdV7CNqllzDQb/hkmxQeIeinDxzTfw5CKgP0A6Y7G5Ac1RlQunqxzvSQfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB4qX4iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14692C2BCB2;
	Mon,  2 Mar 2026 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483316;
	bh=Or7iYbRQR6Ro+Fuj5qMWsLawwpEXd/6MxzP7NG3XnZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nB4qX4iCYlM35xdkH6/Uw6G9kPQXa2L8EjnyixkDTGHa3d38dYxuUOIMZIlgO0buI
	 HE2lGeCQsT9WGrKguSE2Czg8rxw8eB+G6r3EQpQ1myFPqugBpbnnHapogszfWufhJm
	 dRJEbdFSvRiki8hsTGDVS7502/vAIthh+AzzglAIjTNYO+a4tBX9NIo6fw3UlzEGdr
	 NLVctwS/W2tAsoPR9l7d+mwjy56WWDqThK8jatFewHVyn8XVqD82EgmilmfN+JdjFt
	 IWBD6ftQgREqH4wZBYHNuEls21K6UMs3WCge84SEbUI+MPaX1p74+Us/mwAoBNkyyX
	 +BTuONLbJioBg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:23:59 -0500
Subject: [PATCH v2 015/110] nilfs2: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-15-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16704; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Or7iYbRQR6Ro+Fuj5qMWsLawwpEXd/6MxzP7NG3XnZg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfHzwdeQbqcbgLI0t0wCI2faFowE5GGxHJH6Z
 53+uguafKiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx8wAKCRAADmhBGVaC
 FblPEACIUyAQba7TcUmoHV39z8VNqlHgNYtG7nJUQ/M9Ay+a3BVuy+SPDhRUC863GWzAUEzPPKB
 p72eCRz7CssKpp/fw40BgFL5h4tIq3d5JFZ7DrHHJ7BE//OvLEZBepoVaB4g40LaQxtB8Q54d1Z
 wOU8bV6lYUxZ4omB4tKpxyEQeT93dirbiZsrGfoyOOrQaCL/WR+un5vFkrk7+3Is1slFDfy/Zsa
 h3mUQTy4cngiRStBazF4oXglOgEqG+bTzsVPS/N7YzKz5zYo8Obbw4dy2k1EiKSOv2vCbWorKfN
 zHdFfJ0LjOLJ6N9IDCkyYrvrMSCDfSqFK2gbm577jR/Khm3Wi5Bo07ym7HiFez98LYL3BIj6o8d
 HYL/uoZabfD8Z0Y4hySvnn2XBk2sMXKGb0FaqnrD/TjTnOoiIMIb+ndwpT31aR62zN1TSIYcBLL
 vzxsq6/xBsTfJ9rxom7ylkaPD0m0ppYrxC36TRPZyZ1IG0j9MsFyKmmJkiK8BsDdMKAwpcUlvPl
 k/iRTCrlhXSZZXnDnylSlvkBzXIEdvSAOkGnUG79nMhwpUSCxRTCILKWxW8bMA3REE3r+MpGACt
 aj8tekLtOzvlNkGFCPTZpGwe4ZY4FIA55bZvXKS/4I3l6ffVClsq4VhH3NbSOTN8mt+8w4DWAN9
 a2KYOjBAjzNOwdw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 88B931E08D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78977-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Convert nilfs2 i_ino format strings to use the PRIino format
macro in preparation for the widening of i_ino via kino_t.

In trace events, change __field(ino_t, ...) to __field(u64, ...)
and update TP_printk format strings to %llu/%llx to match the
widened field type.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/alloc.c             | 10 +++++-----
 fs/nilfs2/bmap.c              |  2 +-
 fs/nilfs2/btnode.c            |  2 +-
 fs/nilfs2/btree.c             | 12 ++++++------
 fs/nilfs2/dir.c               | 12 ++++++------
 fs/nilfs2/direct.c            |  4 ++--
 fs/nilfs2/gcinode.c           |  2 +-
 fs/nilfs2/inode.c             |  8 ++++----
 fs/nilfs2/mdt.c               |  2 +-
 fs/nilfs2/namei.c             |  2 +-
 fs/nilfs2/segment.c           |  2 +-
 include/trace/events/nilfs2.h | 12 ++++++------
 12 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index e7eebb04f9a4080a39f17d4123e58ed7df6b2f4b..a3c559c86e5a4c63b1c9dd4ca137f24749c3ee87 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -707,7 +707,7 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
 		nilfs_warn(inode->i_sb,
-			   "%s (ino=%lu): entry number %llu already freed",
+			   "%s (ino=%" PRIino "u): entry number %llu already freed",
 			   __func__, inode->i_ino,
 			   (unsigned long long)req->pr_entry_nr);
 	else
@@ -748,7 +748,7 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
 		nilfs_warn(inode->i_sb,
-			   "%s (ino=%lu): entry number %llu already freed",
+			   "%s (ino=%" PRIino "u): entry number %llu already freed",
 			   __func__, inode->i_ino,
 			   (unsigned long long)req->pr_entry_nr);
 	else
@@ -861,7 +861,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			if (!nilfs_clear_bit_atomic(lock, group_offset,
 						    bitmap)) {
 				nilfs_warn(inode->i_sb,
-					   "%s (ino=%lu): entry number %llu already freed",
+					   "%s (ino=%" PRIino "u): entry number %llu already freed",
 					   __func__, inode->i_ino,
 					   (unsigned long long)entry_nrs[j]);
 			} else {
@@ -906,7 +906,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 							      last_nrs[k]);
 			if (ret && ret != -ENOENT)
 				nilfs_warn(inode->i_sb,
-					   "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
+					   "error %d deleting block that object (entry=%llu, ino=%" PRIino "u) belongs to",
 					   ret, (unsigned long long)last_nrs[k],
 					   inode->i_ino);
 		}
@@ -923,7 +923,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			ret = nilfs_palloc_delete_bitmap_block(inode, group);
 			if (ret && ret != -ENOENT)
 				nilfs_warn(inode->i_sb,
-					   "error %d deleting bitmap block of group=%lu, ino=%lu",
+					   "error %d deleting bitmap block of group=%lu, ino=%" PRIino "u",
 					   ret, group, inode->i_ino);
 		}
 	}
diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index ccc1a7aa52d2064d56b826058554264c498d592f..e12979bac3c3ee5eb7fcc2bf156fe6e48fc65a7d 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -33,7 +33,7 @@ static int nilfs_bmap_convert_error(struct nilfs_bmap *bmap,
 
 	if (err == -EINVAL) {
 		__nilfs_error(inode->i_sb, fname,
-			      "broken bmap (inode number=%lu)", inode->i_ino);
+			      "broken bmap (inode number=%" PRIino "u)", inode->i_ino);
 		err = -EIO;
 	}
 	return err;
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 56836712909201775907483887e8a0022851bbec..3d64f3a9223e5601dc2332ae6e1007edd5b4827b 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -64,7 +64,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 		 * clearing of an abandoned b-tree node is missing somewhere).
 		 */
 		nilfs_error(inode->i_sb,
-			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%lu)",
+			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%" PRIino "u)",
 			    (unsigned long long)blocknr, inode->i_ino);
 		goto failed;
 	}
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index dd0c8e560ef6a2c96515025321914e0d73f41144..57163e991fbc49e2bfba2fa543f1b8dbd77718f4 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -353,7 +353,7 @@ static int nilfs_btree_node_broken(const struct nilfs_btree_node *node,
 		     nchildren <= 0 ||
 		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
 		nilfs_crit(inode->i_sb,
-			   "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
+			   "bad btree node (ino=%" PRIino "u, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
 			   inode->i_ino, (unsigned long long)blocknr, level,
 			   flags, nchildren);
 		ret = 1;
@@ -384,7 +384,7 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
 		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX ||
 		     (nchildren == 0 && level > NILFS_BTREE_LEVEL_NODE_MIN))) {
 		nilfs_crit(inode->i_sb,
-			   "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
+			   "bad btree root (ino=%" PRIino "u): level = %d, flags = 0x%x, nchildren = %d",
 			   inode->i_ino, level, flags, nchildren);
 		ret = 1;
 	}
@@ -453,7 +453,7 @@ static int nilfs_btree_bad_node(const struct nilfs_bmap *btree,
 	if (unlikely(nilfs_btree_node_get_level(node) != level)) {
 		dump_stack();
 		nilfs_crit(btree->b_inode->i_sb,
-			   "btree level mismatch (ino=%lu): %d != %d",
+			   "btree level mismatch (ino=%" PRIino "u): %d != %d",
 			   btree->b_inode->i_ino,
 			   nilfs_btree_node_get_level(node), level);
 		return 1;
@@ -521,7 +521,7 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
  out_no_wait:
 	if (!buffer_uptodate(bh)) {
 		nilfs_err(btree->b_inode->i_sb,
-			  "I/O error reading b-tree node block (ino=%lu, blocknr=%llu)",
+			  "I/O error reading b-tree node block (ino=%" PRIino "u, blocknr=%llu)",
 			  btree->b_inode->i_ino, (unsigned long long)ptr);
 		brelse(bh);
 		return -EIO;
@@ -2104,7 +2104,7 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
 	if (ret < 0) {
 		if (unlikely(ret == -ENOENT)) {
 			nilfs_crit(btree->b_inode->i_sb,
-				   "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
+				   "writing node/leaf block does not appear in b-tree (ino=%" PRIino "u) at key=%llu, level=%d",
 				   btree->b_inode->i_ino,
 				   (unsigned long long)key, level);
 			ret = -EINVAL;
@@ -2146,7 +2146,7 @@ static void nilfs_btree_add_dirty_buffer(struct nilfs_bmap *btree,
 	    level >= NILFS_BTREE_LEVEL_MAX) {
 		dump_stack();
 		nilfs_warn(btree->b_inode->i_sb,
-			   "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
+			   "invalid btree level: %d (key=%llu, ino=%" PRIino "u, blocknr=%llu)",
 			   level, (unsigned long long)key,
 			   btree->b_inode->i_ino,
 			   (unsigned long long)bh->b_blocknr);
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index b243199036dfa1ab2299efaaa5bdf5da2d159ff2..b182da076c58c4813145bc3e501a1e9a188bce85 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -150,7 +150,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 
 Ebadsize:
 	nilfs_error(sb,
-		    "size of directory #%lu is not a multiple of chunk size",
+		    "size of directory #%" PRIino "u is not a multiple of chunk size",
 		    dir->i_ino);
 	goto fail;
 Eshort:
@@ -169,7 +169,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 	error = "disallowed inode number";
 bad_entry:
 	nilfs_error(sb,
-		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
+		    "bad entry in directory #%" PRIino "u: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
 		    dir->i_ino, error, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode),
 		    rec_len, p->name_len);
@@ -177,7 +177,7 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 Eend:
 	p = (struct nilfs_dir_entry *)(kaddr + offs);
 	nilfs_error(sb,
-		    "entry in directory #%lu spans the page boundary offset=%lu, inode=%lu",
+		    "entry in directory #%" PRIino "u spans the page boundary offset=%lu, inode=%lu",
 		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode));
 fail:
@@ -251,7 +251,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 
 		kaddr = nilfs_get_folio(inode, n, &folio);
 		if (IS_ERR(kaddr)) {
-			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
+			nilfs_error(sb, "bad page in #%" PRIino "u", inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
 			return -EIO;
 		}
@@ -336,7 +336,7 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 		/* next folio is past the blocks we've got */
 		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
 			nilfs_error(dir->i_sb,
-			       "dir %lu size %lld exceeds block count %llu",
+			       "dir %" PRIino "u size %lld exceeds block count %llu",
 			       dir->i_ino, dir->i_size,
 			       (unsigned long long)dir->i_blocks);
 			goto out;
@@ -382,7 +382,7 @@ struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct folio **foliop)
 	return next_de;
 
 fail:
-	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
+	nilfs_error(dir->i_sb, "directory #%" PRIino "u %s", dir->i_ino, msg);
 	folio_release_kmap(folio, de);
 	return NULL;
 }
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 2d8dc6b35b5477947ca12a70288d3a3cce858aab..1084d4d586e078ab6825167976dd2a71d52bc8aa 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -338,7 +338,7 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
 	key = nilfs_bmap_data_get_key(bmap, *bh);
 	if (unlikely(key > NILFS_DIRECT_KEY_MAX)) {
 		nilfs_crit(bmap->b_inode->i_sb,
-			   "%s (ino=%lu): invalid key: %llu",
+			   "%s (ino=%" PRIino "u): invalid key: %llu",
 			   __func__,
 			   bmap->b_inode->i_ino, (unsigned long long)key);
 		return -EINVAL;
@@ -346,7 +346,7 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
 	ptr = nilfs_direct_get_ptr(bmap, key);
 	if (unlikely(ptr == NILFS_BMAP_INVALID_PTR)) {
 		nilfs_crit(bmap->b_inode->i_sb,
-			   "%s (ino=%lu): invalid pointer: %llu",
+			   "%s (ino=%" PRIino "u): invalid pointer: %llu",
 			   __func__,
 			   bmap->b_inode->i_ino, (unsigned long long)ptr);
 		return -EINVAL;
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 561c220799c7aee879ad866865e377799c8ee6bb..714962d010da4a23e9b5f40de8aaaca8b95a74da 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -137,7 +137,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer_head *bh)
 		struct inode *inode = bh->b_folio->mapping->host;
 
 		nilfs_err(inode->i_sb,
-			  "I/O error reading %s block for GC (ino=%lu, vblocknr=%llu)",
+			  "I/O error reading %s block for GC (ino=%" PRIino "u, vblocknr=%llu)",
 			  buffer_nilfs_node(bh) ? "node" : "data",
 			  inode->i_ino, (unsigned long long)bh->b_blocknr);
 		return -EIO;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 51bde45d586509dda3ef0cb7c46facb7fb2c61dd..0bc1c5141ec596b3c31e7d18e4ba3541bf618406 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -108,7 +108,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 				 * be locked in this case.
 				 */
 				nilfs_warn(inode->i_sb,
-					   "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
+					   "%s (ino=%" PRIino "u): a race condition while inserting a data block at offset=%llu",
 					   __func__, inode->i_ino,
 					   (unsigned long long)blkoff);
 				err = -EAGAIN;
@@ -789,7 +789,7 @@ static void nilfs_truncate_bmap(struct nilfs_inode_info *ii,
 		goto repeat;
 
 failed:
-	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=%lu)",
+	nilfs_warn(ii->vfs_inode.i_sb, "error %d truncating bmap (ino=%" PRIino "u)",
 		   ret, ii->vfs_inode.i_ino);
 }
 
@@ -1026,7 +1026,7 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 			 * this inode.
 			 */
 			nilfs_warn(inode->i_sb,
-				   "cannot set file dirty (ino=%lu): the file is being freed",
+				   "cannot set file dirty (ino=%" PRIino "u): the file is being freed",
 				   inode->i_ino);
 			spin_unlock(&nilfs->ns_inode_lock);
 			return -EINVAL; /*
@@ -1057,7 +1057,7 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
 		nilfs_warn(inode->i_sb,
-			   "cannot mark inode dirty (ino=%lu): error %d loading inode block",
+			   "cannot mark inode dirty (ino=%" PRIino "u): error %d loading inode block",
 			   inode->i_ino, err);
 		return err;
 	}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 946b0d3534a5f22f34ac44a91fb121541881c548..8629c72b62db33217d4747124885b6f727f182be 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -203,7 +203,7 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
 	err = -EIO;
 	if (!buffer_uptodate(first_bh)) {
 		nilfs_err(inode->i_sb,
-			  "I/O error reading meta-data file (ino=%lu, block-offset=%lu)",
+			  "I/O error reading meta-data file (ino=%" PRIino "u, block-offset=%lu)",
 			  inode->i_ino, block);
 		goto failed_bh;
 	}
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..29edb84a0663caa4b29fa488c0495fc53358ca00 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -292,7 +292,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (!inode->i_nlink) {
 		nilfs_warn(inode->i_sb,
-			   "deleting nonexistent file (ino=%lu), %d",
+			   "deleting nonexistent file (ino=%" PRIino "u), %d",
 			   inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 098a3bd103e04cd09b0689fe2017380d74664496..9a8bc3fa35ce9b447abbc2fb56cbd2b0cc5f76de 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2024,7 +2024,7 @@ static int nilfs_segctor_collect_dirty_files(struct nilfs_sc_info *sci,
 				ifile, ii->vfs_inode.i_ino, &ibh);
 			if (unlikely(err)) {
 				nilfs_warn(sci->sc_super,
-					   "log writer: error %d getting inode block (ino=%lu)",
+					   "log writer: error %d getting inode block (ino=%" PRIino "u)",
 					   err, ii->vfs_inode.i_ino);
 				return err;
 			}
diff --git a/include/trace/events/nilfs2.h b/include/trace/events/nilfs2.h
index 8880c11733dd307c223cc62ee34ebeff650ecb12..86a0011c9eeaf031cfa0b79875b2b106ef8b7cfd 100644
--- a/include/trace/events/nilfs2.h
+++ b/include/trace/events/nilfs2.h
@@ -165,14 +165,14 @@ TRACE_EVENT(nilfs2_segment_usage_freed,
 
 TRACE_EVENT(nilfs2_mdt_insert_new_block,
 	    TP_PROTO(struct inode *inode,
-		     unsigned long ino,
+		     u64 ino,
 		     unsigned long block),
 
 	    TP_ARGS(inode, ino, block),
 
 	    TP_STRUCT__entry(
 		    __field(struct inode *, inode)
-		    __field(unsigned long, ino)
+		    __field(u64, ino)
 		    __field(unsigned long, block)
 	    ),
 
@@ -182,7 +182,7 @@ TRACE_EVENT(nilfs2_mdt_insert_new_block,
 		    __entry->block = block;
 		    ),
 
-	    TP_printk("inode = %p ino = %lu block = %lu",
+	    TP_printk("inode = %p ino = %llu block = %lu",
 		      __entry->inode,
 		      __entry->ino,
 		      __entry->block)
@@ -190,7 +190,7 @@ TRACE_EVENT(nilfs2_mdt_insert_new_block,
 
 TRACE_EVENT(nilfs2_mdt_submit_block,
 	    TP_PROTO(struct inode *inode,
-		     unsigned long ino,
+		     u64 ino,
 		     unsigned long blkoff,
 		     enum req_op mode),
 
@@ -198,7 +198,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 
 	    TP_STRUCT__entry(
 		    __field(struct inode *, inode)
-		    __field(unsigned long, ino)
+		    __field(u64, ino)
 		    __field(unsigned long, blkoff)
 		    /*
 		     * Use field_struct() to avoid is_signed_type() on the
@@ -214,7 +214,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 		    __entry->mode = mode;
 		    ),
 
-	    TP_printk("inode = %p ino = %lu blkoff = %lu mode = %x",
+	    TP_printk("inode = %p ino = %llu blkoff = %lu mode = %x",
 		      __entry->inode,
 		      __entry->ino,
 		      __entry->blkoff,

-- 
2.53.0


