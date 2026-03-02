Return-Path: <linux-fsdevel+bounces-79027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LnlNkn+pWlQIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:16:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853441E23FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3950934F9674
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E753B8928;
	Mon,  2 Mar 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta7tLBiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BA3B7B92;
	Mon,  2 Mar 2026 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484006; cv=none; b=kBD13tUTjXJxrWPlqhzJFaLbw5RzG510MnewlvPGDOQpYtYR80TJ+ll6bTl4nRZCg9qgU0GI+7YYRnu+CvLwMTvOIOptEkhVdfhGAXo/o1+pRmkm3ICZ0tpGnhnnH1JhO8fP+zU0gP/jP9I3XDJCbKA/mupGjD+oSpyM/BKBhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484006; c=relaxed/simple;
	bh=+8ClTK7vhtfFiVVbpIq6HAnhDkb9LptqIfRMoGhc6+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePR3oainPogUNvitEovVobxar8QwC0qi+fDDnF6JoQrXYXbyxMWAvDlexJp3xUz+s6dorxnJBxVsuoHvpmigZ9bLUsIcQB0GfMO6/TrmkLmRh5UqJu0NaKhTy63fvhhaSfwOX6q/0tdWVouutRerf7PAgflpfjSBEEeJ5a4gl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta7tLBiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AA5C19425;
	Mon,  2 Mar 2026 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484006;
	bh=+8ClTK7vhtfFiVVbpIq6HAnhDkb9LptqIfRMoGhc6+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ta7tLBiDFAdvNXaECO6rLS5vMxz7KlFhIdJ5FwZBrLP7AgGOLy2BltUdf9bykPVRJ
	 ZL82BblP87fHCNqitBKaKO54ayD56vnBTnBK6hVKHw7x/3PXz4AASy6xQD8FMUsEOC
	 uZqygnvd3XwgzMnKCb56ThuRi/o6OWQyglAl97YcLq041kh47lpYEWoQfUGsEiY0XH
	 xWYXpEk/KkoZoDxZmhRr/rcPkCKOzTD4futHaLJ27+wj/L/ReugsCb4NRvVn/nFdT5
	 +A6WwuUaN+/gJy9bqDIlWMPbwpLJwiwRxdaZHLKeno3E4LnI0XT8WorZ6MUhdHbWzi
	 7s4cXEEO9chlQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:47 -0500
Subject: [PATCH v2 063/110] f2fs: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-63-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=28872; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+8ClTK7vhtfFiVVbpIq6HAnhDkb9LptqIfRMoGhc6+M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIA/Gmen3gv4J5n/HCi7T33pLlhzjzrS+yut
 YM531zK/NyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyAAAKCRAADmhBGVaC
 FURUD/9Pi+bvmR5o/N3ZJJu5gmf8LXsZsfdPOWxFJ4nV+mq+HHo2yDMYD1Rdfp7py7U8zg7l6Ak
 YBxOITP7I2+Nyvt8wDXDgkiAuK+JQEJF1K0CQeyNYqeF61t+rmPzwQDL6GWjg5r9a+113G508+M
 Ph/igHWc8htKz6v0CkC0ktalFIVBvRAJBwc9sGx6CtUjyHkgmRiyONbG2NyEKinChpy8iyCnbFH
 5Kuhhcy+P0hfiW+ku2r50BDlHffG8g/suxgWPU5aStAw2or+IuXDKlG9Mdane2dOsLr+5O6KoTJ
 bKOF36p/mvgcSuQrjL6YcNfig5kRS7rtFUExjUv1k8U0TjwRl120JYS+b/l8XtzNPokwN2RTzhF
 gNWRW2lvYxrvLkMFgBT7yDkPZWjms2tXcQDodlOpl4NsZkmoEuuFBiDJQkVXn84BBCu+mDcI0p/
 3PAqPaqEhqWBmB9a/dwkqcg4/DZVGfG7Cpu9mV32q0gTjYI6HAiKmP1532Ra6CWOfCeFTknlhqQ
 5oD8u9wWwtDiQwaHKJu4yHwuM8/iQpTCnoHSXQDo7bXgpr6ML4fZs0MBrHeafcIjvQpA+KjH3p7
 nW/l7EE78u9vsd2jTPQk0i3NAVGRdGLV3wIb7am/cNaa0Me4+rAzFvWPfRIuUV11EVxqqkgJgr7
 MN0xWzCpz+6OEfw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 853441E23FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79027-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in f2fs with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/compress.c     |  4 ++--
 fs/f2fs/dir.c          |  2 +-
 fs/f2fs/extent_cache.c |  8 ++++----
 fs/f2fs/f2fs.h         |  6 +++---
 fs/f2fs/file.c         | 12 ++++++------
 fs/f2fs/gc.c           |  2 +-
 fs/f2fs/inline.c       |  4 ++--
 fs/f2fs/inode.c        | 48 ++++++++++++++++++++++++------------------------
 fs/f2fs/namei.c        |  8 ++++----
 fs/f2fs/node.c         | 12 ++++++------
 fs/f2fs/recovery.c     | 10 +++++-----
 fs/f2fs/xattr.c        | 10 +++++-----
 12 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 04ca483017a4db4ffe5ba21674af969ccb3d4ef3..0b8be500db656f8439725cac2f6a927c2f06ca4f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -773,7 +773,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
 				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
 				f2fs_info_ratelimited(sbi,
-					"checksum invalid, nid = %" PRIino "u, %x vs %x",
+					"checksum invalid, nid = %llu, %x vs %x",
 					dic->inode->i_ino,
 					provided, calculated);
 			}
@@ -932,7 +932,7 @@ bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
 
 	return false;
 out:
-	f2fs_warn(sbi, "access invalid cluster, ino:%" PRIino "u, nid:%u, ofs_in_node:%u, reason:%s",
+	f2fs_warn(sbi, "access invalid cluster, ino:%llu, nid:%u, ofs_in_node:%u, reason:%s",
 			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	return true;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d8ddf530663c9f30af0243bfabab2c169951ddc8..38802ee2e40deb4995a4e5f4118330b90b2f10e2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -368,7 +368,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
-		f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %" PRIino "u: %u",
+		f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %llu: %u",
 			  dir->i_ino, max_depth);
 		max_depth = MAX_DIR_HASH_DEPTH;
 		f2fs_i_depth_write(dir, max_depth);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 45c098b1f89f47aecd6354ecf2d4803abb275480..d73aeef333a24766aaab9914a02b99fbf035e78d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -34,7 +34,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
 	if (!f2fs_is_valid_blkaddr(sbi, ei.blk, DATA_GENERIC_ENHANCE) ||
 	    !f2fs_is_valid_blkaddr(sbi, ei.blk + ei.len - 1,
 					DATA_GENERIC_ENHANCE)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) extent info [%u, %u, %u] is incorrect, run fsck to fix",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
 			  ei.blk, ei.fofs, ei.len);
 		return false;
@@ -50,14 +50,14 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
 
 		if (devi == 0) {
 			f2fs_warn(sbi,
-			    "%s: inode (ino=%" PRIino "x) is an alias of meta device",
+			    "%s: inode (ino=%llx) is an alias of meta device",
 			    __func__, inode->i_ino);
 			return false;
 		}
 
 		if (bdev_is_zoned(FDEV(devi).bdev)) {
 			f2fs_warn(sbi,
-			    "%s: device alias inode (ino=%" PRIino "x)'s extent info "
+			    "%s: device alias inode (ino=%llx)'s extent info "
 			    "[%u, %u, %u] maps to zoned block device",
 			    __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
 			return false;
@@ -65,7 +65,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
 		return true;
 	}
 
-	f2fs_warn(sbi, "%s: device alias inode (ino=%" PRIino "x)'s extent info "
+	f2fs_warn(sbi, "%s: device alias inode (ino=%llx)'s extent info "
 			"[%u, %u, %u] is inconsistent w/ any devices",
 			__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
 	return false;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c5d175b6eab52bd366bbef870d54d13f35c8fe00..760e6d80bbddd8393394c30c740ba05faded332f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2706,7 +2706,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	if (unlikely(sbi->total_valid_block_count < count)) {
-		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%" PRIino "u, count:%u",
+		f2fs_warn(sbi, "Inconsistent total_valid_block_count:%u, ino:%llu, count:%u",
 			  sbi->total_valid_block_count, inode->i_ino, count);
 		sbi->total_valid_block_count = 0;
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -2719,7 +2719,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 					sbi->current_reserved_blocks + count);
 	spin_unlock(&sbi->stat_lock);
 	if (unlikely(inode->i_blocks < sectors)) {
-		f2fs_warn(sbi, "Inconsistent i_blocks, ino:%" PRIino "u, iblocks:%llu, sectors:%llu",
+		f2fs_warn(sbi, "Inconsistent i_blocks, ino:%llu, iblocks:%llu, sectors:%llu",
 			  inode->i_ino,
 			  (unsigned long long)inode->i_blocks,
 			  (unsigned long long)sectors);
@@ -2993,7 +2993,7 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 		dquot_free_inode(inode);
 	} else {
 		if (unlikely(inode->i_blocks == 0)) {
-			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%" PRIino "u, iblocks:%llu",
+			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%llu, iblocks:%llu",
 				  inode->i_ino,
 				  (unsigned long long)inode->i_blocks);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2029fc802669700c7b29cdb04ca022dec6632fd2..a56bbcca7898282eab1fea7e1b2acee5ea00df88 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1917,7 +1917,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 				f2fs_up_write(&sbi->pin_sem);
 				err = -ENOSPC;
 				f2fs_warn_ratelimited(sbi,
-					"ino:%" PRIino "u, start:%lu, end:%lu, need to trigger GC to"
+					"ino:%llu, start:%lu, end:%lu, need to trigger GC to"
 					"reclaim enough free segment when checkpoint is enabled",
 					inode->i_ino, pg_start, pg_end);
 				goto out_err;
@@ -2307,7 +2307,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	 * f2fs_is_atomic_file.
 	 */
 	if (get_dirty_pages(inode))
-		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%" PRIino "u, npages=%u",
+		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%llu, npages=%u",
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
@@ -3494,7 +3494,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 		return -EINVAL;
 
 	if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
-		f2fs_warn(sbi, "%s: Enable GC = ino %" PRIino "x after %x GC trials",
+		f2fs_warn(sbi, "%s: Enable GC = ino %llx after %x GC trials",
 			  __func__, inode->i_ino, fi->i_gc_failures);
 		clear_inode_flag(inode, FI_PIN_FILE);
 		return -EAGAIN;
@@ -3679,7 +3679,7 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
 
 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
 		f2fs_warn(F2FS_I_SB(inode),
-			  "Can't enable fs-verity on inode %" PRIino "u: the verity feature is not enabled on this filesystem",
+			  "Can't enable fs-verity on inode %llu: the verity feature is not enabled on this filesystem",
 			  inode->i_ino);
 		return -EOPNOTSUPP;
 	}
@@ -3950,7 +3950,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	} else if (released_blocks &&
 			atomic_read(&fi->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%" PRIino "x "
+		f2fs_warn(sbi, "%s: partial blocks were released i_ino=%llx "
 			"iblocks=%llu, released=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
@@ -4133,7 +4133,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	} else if (reserved_blocks &&
 			atomic_read(&fi->i_compr_blocks)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%" PRIino "x "
+		f2fs_warn(sbi, "%s: partial blocks were reserved i_ino=%llx "
 			"iblocks=%llu, reserved=%u, compr_blocks=%u, "
 			"run fsck to fix.",
 			__func__, inode->i_ino, inode->i_blocks,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c7efb7807e9c276d60b65768fb0c98f405345af0..c0c8a1056d6b089397b4aa92b88b14cfd88c9de5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1622,7 +1622,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				iput(inode);
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
 				f2fs_err_ratelimited(sbi,
-					"inode %" PRIino "u has both inline_data flag and "
+					"inode %llu has both inline_data flag and "
 					"data block, nid=%u, ofs_in_node=%u",
 					inode->i_ino, dni.nid, ofs_in_node);
 				continue;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 33f434a7031b725816b7a71359daeffa4c8c6af9..2669439b941387a96318f77fca7dfe35723e59d9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -176,7 +176,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	if (unlikely(dn->data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(dn);
 		set_sbi_flag(fio.sbi, SBI_NEED_FSCK);
-		f2fs_warn(fio.sbi, "%s: corrupted inline inode ino=%" PRIino "u, i_addr[0]:0x%x, run fsck to fix.",
+		f2fs_warn(fio.sbi, "%s: corrupted inline inode ino=%llu, i_addr[0]:0x%x, run fsck to fix.",
 			  __func__, dn->inode->i_ino, dn->data_blkaddr);
 		f2fs_handle_error(fio.sbi, ERROR_INVALID_BLKADDR);
 		return -EFSCORRUPTED;
@@ -431,7 +431,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(&dn);
 		set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
-		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%" PRIino "u, i_addr[0]:0x%x, run fsck to fix.",
+		f2fs_warn(F2FS_F_SB(folio), "%s: corrupted inline inode ino=%llu, i_addr[0]:0x%x, run fsck to fix.",
 			  __func__, dir->i_ino, dn.data_blkaddr);
 		f2fs_handle_error(F2FS_F_SB(folio), ERROR_INVALID_BLKADDR);
 		err = -EFSCORRUPTED;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e3fb676b417bcc63e23137949e26f68ccce09cb4..f27198d6695b91d2a041318aeecd04c65d38a4ba 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -203,14 +203,14 @@ static bool sanity_check_compress_inode(struct inode *inode,
 
 	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%" PRIino "x) has unsupported compress algorithm: %u, run fsck to fix",
+			"%s: inode (ino=%llx) has unsupported compress algorithm: %u, run fsck to fix",
 			__func__, inode->i_ino, ri->i_compress_algorithm);
 		return false;
 	}
 	if (le64_to_cpu(ri->i_compr_blocks) >
 			SECTOR_TO_BLOCK(inode->i_blocks)) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%" PRIino "x) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
+			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
 			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
 			SECTOR_TO_BLOCK(inode->i_blocks));
 		return false;
@@ -218,7 +218,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
 	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
 		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%" PRIino "x) has unsupported log cluster size: %u, run fsck to fix",
+			"%s: inode (ino=%llx) has unsupported log cluster size: %u, run fsck to fix",
 			__func__, inode->i_ino, ri->i_log_cluster_size);
 		return false;
 	}
@@ -262,7 +262,7 @@ static bool sanity_check_compress_inode(struct inode *inode,
 
 	return true;
 err_level:
-	f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has unsupported compress level: %u, run fsck to fix",
+	f2fs_warn(sbi, "%s: inode (ino=%llx) has unsupported compress level: %u, run fsck to fix",
 		  __func__, inode->i_ino, clevel);
 	return false;
 }
@@ -276,40 +276,40 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 
 	iblocks = le64_to_cpu(F2FS_INODE(node_folio)->i_blocks);
 	if (!iblocks) {
-		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%" PRIino "x iblocks=%llu, run fsck to fix.",
+		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%llx iblocks=%llu, run fsck to fix.",
 			  __func__, inode->i_ino, iblocks);
 		return false;
 	}
 
 	if (ino_of_node(node_folio) != nid_of_node(node_folio)) {
-		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%" PRIino "x, ino,nid: [%u, %u] run fsck to fix.",
+		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%llx, ino,nid: [%u, %u] run fsck to fix.",
 			  __func__, inode->i_ino,
 			  ino_of_node(node_folio), nid_of_node(node_folio));
 		return false;
 	}
 
 	if (ino_of_node(node_folio) == fi->i_xattr_nid) {
-		f2fs_warn(sbi, "%s: corrupted inode i_ino=%" PRIino "x, xnid=%x, run fsck to fix.",
+		f2fs_warn(sbi, "%s: corrupted inode i_ino=%llx, xnid=%x, run fsck to fix.",
 			  __func__, inode->i_ino, fi->i_xattr_nid);
 		return false;
 	}
 
 	if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
-		f2fs_warn(sbi, "%s: directory inode (ino=%" PRIino "x) has a single i_nlink",
+		f2fs_warn(sbi, "%s: directory inode (ino=%llx) has a single i_nlink",
 			  __func__, inode->i_ino);
 		return false;
 	}
 
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
-			f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) is with extra_attr, but extra_attr feature is off",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) is with extra_attr, but extra_attr feature is off",
 				  __func__, inode->i_ino);
 			return false;
 		}
 		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize % sizeof(__le32)) {
-			f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has corrupted i_extra_isize: %d, max: %zu",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_extra_isize: %d, max: %zu",
 				  __func__, inode->i_ino, fi->i_extra_isize,
 				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
 			return false;
@@ -327,7 +327,7 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		f2fs_has_inline_xattr(inode) &&
 		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
 		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
 			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
 		return false;
@@ -335,64 +335,64 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 
 	if (!f2fs_sb_has_extra_attr(sbi)) {
 		if (f2fs_sb_has_project_quota(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%" PRIino "x, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
 			return false;
 		}
 		if (f2fs_sb_has_inode_chksum(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%" PRIino "x, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
 			return false;
 		}
 		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%" PRIino "x, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
 			return false;
 		}
 		if (f2fs_sb_has_inode_crtime(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%" PRIino "x, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
 			return false;
 		}
 		if (f2fs_sb_has_compression(sbi)) {
-			f2fs_warn(sbi, "%s: corrupted inode ino=%" PRIino "x, wrong feature flag: %u, run fsck to fix.",
+			f2fs_warn(sbi, "%s: corrupted inode ino=%llx, wrong feature flag: %u, run fsck to fix.",
 				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
 			return false;
 		}
 	}
 
 	if (f2fs_sanity_check_inline_data(inode, node_folio)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x, mode=%u) should not have inline_data, run fsck to fix",
+		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_data, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
 	}
 
 	if (f2fs_has_inline_dentry(inode) && !S_ISDIR(inode->i_mode)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x, mode=%u) should not have inline_dentry, run fsck to fix",
+		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_dentry, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
 	}
 
 	if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has casefold flag, but casefold feature is off",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has casefold flag, but casefold feature is off",
 			  __func__, inode->i_ino);
 		return false;
 	}
 
 	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has corrupted i_xattr_nid: %u, run fsck to fix.",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_xattr_nid: %u, run fsck to fix.",
 			  __func__, inode->i_ino, fi->i_xattr_nid);
 		return false;
 	}
 
 	if (IS_DEVICE_ALIASING(inode)) {
 		if (!f2fs_sb_has_device_alias(sbi)) {
-			f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has device alias flag, but the feature is off",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has device alias flag, but the feature is off",
 				  __func__, inode->i_ino);
 			return false;
 		}
 		if (!f2fs_is_pinned_file(inode)) {
-			f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has device alias flag, but is not pinned",
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has device alias flag, but is not pinned",
 				  __func__, inode->i_ino);
 			return false;
 		}
@@ -925,7 +925,7 @@ void f2fs_evict_inode(struct inode *inode)
 			 */
 			if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
 				f2fs_warn(F2FS_I_SB(inode),
-					"f2fs_evict_inode: inconsistent node id, ino:%" PRIino "u",
+					"f2fs_evict_inode: inconsistent node id, ino:%llu",
 					inode->i_ino);
 				f2fs_inode_synced(inode);
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -954,7 +954,7 @@ void f2fs_evict_inode(struct inode *inode)
 		 */
 		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
 			f2fs_warn(sbi,
-				"f2fs_evict_inode: inode is dirty, ino:%" PRIino "u",
+				"f2fs_evict_inode: inode is dirty, ino:%llu",
 				inode->i_ino);
 			f2fs_inode_synced(inode);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e230bc84fc62b5049963b928affd801c28e1ba58..efbb0732d4206f63b5221605a08ffa5c17e8a8b6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -505,7 +505,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	if (inode->i_nlink == 0) {
-		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%" PRIino "x) has zero i_nlink",
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%llx) has zero i_nlink",
 			  __func__, inode->i_ino);
 		err = -EFSCORRUPTED;
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
@@ -515,7 +515,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
-		f2fs_warn(F2FS_I_SB(inode), "Inconsistent encryption contexts: %" PRIino "u/%" PRIino "u",
+		f2fs_warn(F2FS_I_SB(inode), "Inconsistent encryption contexts: %llu/%llu",
 			  dir->i_ino, inode->i_ino);
 		err = -EPERM;
 		goto out_iput;
@@ -573,11 +573,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (unlikely(inode->i_nlink == 0)) {
-		f2fs_warn(sbi, "%s: inode (ino=%" PRIino "x) has zero i_nlink",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
 			  __func__, inode->i_ino);
 		goto corrupted;
 	} else if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
-		f2fs_warn(sbi, "%s: directory inode (ino=%" PRIino "x) has a single i_nlink",
+		f2fs_warn(sbi, "%s: directory inode (ino=%llx) has a single i_nlink",
 			  __func__, inode->i_ino);
 		goto corrupted;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 89d85faa615249a716e9eb56861ace6eac9d5d8f..2856d5dbdd00a659b548ca6a0d8a973fc1341297 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -847,7 +847,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			err = -EFSCORRUPTED;
 			f2fs_err_ratelimited(sbi,
 				"inode mapping table is corrupted, run fsck to fix it, "
-				"ino:%" PRIino "u, nid:%u, level:%d, offset:%d",
+				"ino:%llu, nid:%u, level:%d, offset:%d",
 				dn->inode->i_ino, nids[i], level, offset[level]);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			goto release_pages;
@@ -1013,7 +1013,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
 		return PTR_ERR(folio);
 
 	if (IS_INODE(folio) || ino_of_node(folio) != dn->inode->i_ino) {
-		f2fs_err(sbi, "incorrect node reference, ino: %" PRIino "u, nid: %u, ino_of_node: %u",
+		f2fs_err(sbi, "incorrect node reference, ino: %llu, nid: %u, ino_of_node: %u",
 				dn->inode->i_ino, dn->nid, ino_of_node(folio));
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
@@ -1194,7 +1194,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	if (level <= 0) {
 		if (!level) {
 			level = -EFSCORRUPTED;
-			f2fs_err(sbi, "%s: inode ino=%" PRIino "x has corrupted node block, from:%lu addrs:%u",
+			f2fs_err(sbi, "%s: inode ino=%llx has corrupted node block, from:%lu addrs:%u",
 					__func__, inode->i_ino,
 					from, ADDRS_PER_INODE(inode));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -1265,7 +1265,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 			set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
 			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			f2fs_err_ratelimited(sbi,
-				"truncate node fail, ino:%" PRIino "u, nid:%u, "
+				"truncate node fail, ino:%llu, nid:%u, "
 				"offset[0]:%d, offset[1]:%d, nofs:%d",
 				inode->i_ino, dn.nid, offset[0],
 				offset[1], nofs);
@@ -1351,7 +1351,7 @@ int f2fs_remove_inode_page(struct inode *inode)
 
 	if (unlikely(inode->i_blocks != 0 && inode->i_blocks != 8)) {
 		f2fs_warn(F2FS_I_SB(inode),
-			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%" PRIino "u, iblocks:%llu",
+			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%llu, iblocks:%llu",
 			inode->i_ino, (unsigned long long)inode->i_blocks);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 	}
@@ -1997,7 +1997,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	return ret;
 }
 
-static int f2fs_match_ino(struct inode *inode, kino_t ino, void *data)
+static int f2fs_match_ino(struct inode *inode, u64 ino, void *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	bool clean;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 86a9a289bde4ff5087b8ba194691880c9a8b5446..3d3dacec94825f6695d67043fd3ca42329aa5929 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -232,7 +232,7 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 		name = "<encrypted>";
 	else
 		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %" PRIino "u, err = %d",
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %llu, err = %d",
 		    __func__, ino_of_node(ifolio), name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
@@ -532,7 +532,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 
 	max_addrs = ADDRS_PER_PAGE(dn->node_folio, dn->inode);
 	if (ofs_in_node >= max_addrs) {
-		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%" PRIino "u, nid:%u, max:%u",
+		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%llu, nid:%u, max:%u",
 			ofs_in_node, dn->inode->i_ino, nid, max_addrs);
 		f2fs_handle_error(sbi, ERROR_INCONSISTENT_SUMMARY);
 		return -EFSCORRUPTED;
@@ -674,7 +674,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(folio));
 
 	if (ofs_of_node(dn.node_folio) != ofs_of_node(folio)) {
-		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%" PRIino "u, ofs:%u, %u",
+		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
 			  inode->i_ino, ofs_of_node(dn.node_folio),
 			  ofs_of_node(folio));
 		err = -EFSCORRUPTED;
@@ -748,7 +748,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (f2fs_is_valid_blkaddr(sbi, dest,
 					DATA_GENERIC_ENHANCE_UPDATE)) {
-				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%" PRIino "u, ofs:%u",
+				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%llu, ofs:%u",
 					dest, inode->i_ino, dn.ofs_in_node);
 				err = -EFSCORRUPTED;
 				goto err;
@@ -768,7 +768,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 err:
 	f2fs_put_dnode(&dn);
 out:
-	f2fs_notice(sbi, "recover_data: ino = %" PRIino "x, nid = %x (i_size: %s), "
+	f2fs_notice(sbi, "recover_data: ino = %llx, nid = %x (i_size: %s), "
 		    "range (%u, %u), recovered = %d, err = %d",
 		    inode->i_ino, nid_of_node(folio),
 		    file_keep_isize(inode) ? "keep" : "recover",
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 03a33b5acb5df1244de72d91731a94cbb2142503..610d5810074dc501d02c93a4feb308e12a21a056 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -365,7 +365,7 @@ static int lookup_all_xattrs(struct inode *inode, struct folio *ifolio,
 
 	*xe = __find_xattr(cur_addr, last_txattr_addr, NULL, index, len, name);
 	if (!*xe) {
-		f2fs_err(F2FS_I_SB(inode), "lookup inode (%" PRIino "u) has corrupted xattr",
+		f2fs_err(F2FS_I_SB(inode), "lookup inode (%llu) has corrupted xattr",
 								inode->i_ino);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		err = -ENODATA;
@@ -585,7 +585,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
-			f2fs_err(F2FS_I_SB(inode), "list inode (%" PRIino "u) has corrupted xattr",
+			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
 						inode->i_ino);
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			f2fs_handle_error(F2FS_I_SB(inode),
@@ -664,14 +664,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		if (!F2FS_I(inode)->i_xattr_nid) {
 			error = f2fs_recover_xattr_data(inode, NULL);
 			f2fs_notice(F2FS_I_SB(inode),
-				"recover xattr in inode (%" PRIino "u), error(%d)",
+				"recover xattr in inode (%llu), error(%d)",
 					inode->i_ino, error);
 			if (!error) {
 				kfree(base_addr);
 				goto retry;
 			}
 		}
-		f2fs_err(F2FS_I_SB(inode), "set inode (%" PRIino "u) has corrupted xattr",
+		f2fs_err(F2FS_I_SB(inode), "set inode (%llu) has corrupted xattr",
 								inode->i_ino);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		error = -EFSCORRUPTED;
@@ -699,7 +699,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	while (!IS_XATTR_LAST_ENTRY(last)) {
 		if ((void *)(last) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(last) > last_base_addr) {
-			f2fs_err(F2FS_I_SB(inode), "inode (%" PRIino "u) has invalid last xattr entry, entry_size: %zu",
+			f2fs_err(F2FS_I_SB(inode), "inode (%llu) has invalid last xattr entry, entry_size: %zu",
 					inode->i_ino, ENTRY_SIZE(last));
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 			error = -EFSCORRUPTED;

-- 
2.53.0


