Return-Path: <linux-fsdevel+bounces-79048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG5tNCkBpml5IwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:29:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47E1E2FA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC0D53346EAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375413725DD;
	Mon,  2 Mar 2026 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVw7xJah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B8371D1F;
	Mon,  2 Mar 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484307; cv=none; b=owgu9q+amYcFiNSy0ZQV9zck7EqPMWHuTQgalDg5h3t/lePl8P2nravoucTF8qC+WHnbJI5weTWid83Q+FtN/UM4BEhgkv9rSuc34KGHgsuOMEvj5I93ylLV3BVyOw0qd2EruEwH5Q+IGr+pnPOOuYOpXmM39pm5Sw7VvbIonIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484307; c=relaxed/simple;
	bh=AleFBN5sPrQMDxoQcz7RCiAUkW1M4y/w/e4fiUlZ1xQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7aAKpZv3sZHofzrlbqS/7Osh2T+tlloiIO6NA1f3QWbPka+Bd9HAQGS1oRxWbtZyN7q3/LN/U+Y60fsgTe5hqUNlMzC8tpI1CdEj7uU4/YwyXf+fgj8MiCzONG8i4qR8QOtqDbDcFbCH18DwJUKR43XAdFX0il4///MikgZ+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVw7xJah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA94C19425;
	Mon,  2 Mar 2026 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484307;
	bh=AleFBN5sPrQMDxoQcz7RCiAUkW1M4y/w/e4fiUlZ1xQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bVw7xJahfm8Tm4bdZCyfu9P+ZCi6iCMfEgJmGOL343/w8HBOS3WJSPgeazUL20mEh
	 Md8ughee7NhUqXO6x3bQHqYigaVlCjxp5hO+Pz5xOr/pXujjHW7c1ksaEmHybrfqYD
	 tiZNxerAZmZtyrFfhXdQg/Cy5zNDrsRIzhZvKnEOdrdI0K8SJt2qJlfoRXfnDu/fDa
	 dYuW9qi4QO0mJiXkhAUASBfIm+QkMWlPfaGdA0sT0gUaZr9XpPsbneKwSj5k3neDnW
	 FwcfM4oN0G+zThHw++OqtWYJZJNQpEA264Tub1PeSciUq5+FPaRVtgu+rhFKO11pEh
	 PDq3cTCbyQycA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:25:08 -0500
Subject: [PATCH v2 084/110] hfs: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-84-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AleFBN5sPrQMDxoQcz7RCiAUkW1M4y/w/e4fiUlZ1xQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIGUHTTAeH14AJWhmBMM+46YGeMmg+2iIHQu
 C44K4yGKBWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyBgAKCRAADmhBGVaC
 FdPkD/9z51R7liAqp5UFbxwRLqvIszl+C5qd/GP67j1aaC/feMl/zq/MoEHMtECSHLQ9Cr3vli3
 KpUje8gXVPw8c5FJNmy+SPLAUOICqlAoyIrtY1Q/tievM+0wDAAYH/Y7uDsDl4MmVcB2USjO6UQ
 ukvOawig2HgJZ0JvJALhNY4Sj9KgenVymKYm127j9mmiDTvBOzMz6N+S1qZ5mhd5PepsJPfCZkn
 hplvsjjEHQs2/sUppyDaCCdYjICR1TJt8KG714Zesw8MNlGx0eIuUceT64U+dIkPvy2qesW8ofR
 DgLylhrKsu/uxfcDL9qCTfcOnRNXOsELegSHGOCPJmo/VSzvCZOwg8e2dD1d/6BxrE//YhflElq
 xRPy0UKjO9n8kmHjhb1xBl+KqNJoQxODV9Et1DTPcrli1PHyaTMWil5LmUe1MUUomv9yX5Btv2V
 q+KhWTjonmYMELcnDujhF/krR3jJy4qo9IWYMKEQo08+U+sw+FhUwwfAj3uWW5nuB7kNQWhxWHx
 g9cuwPby+C5yqOUbWZxIEYJ5+oZTXDZynkOBOTyXjrEpCZDPGlAUyeXcOql9EpeKKMeItDP3Y+w
 RSmXgCAyrXMXP9me0PpEVNjIBd4ll4mceHkANulCrg6cRHy/vstlFXOM1V6W5at3+tDq5NDhkwe
 ZW2EtEyXcB5JPTQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 8B47E1E2FA1
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
	TAGGED_FROM(0.00)[bounces-79048-lists,linux-fsdevel=lfdr.de];
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
replace all uses in hfs with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hfs/catalog.c | 2 +-
 fs/hfs/extent.c  | 4 ++--
 fs/hfs/inode.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index b07c0a3ffc61584165e8cc9f646de6066a6ad2c9..7f5339ee57c15aae2d5d00474133a985be3af6ca 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -417,7 +417,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	int entry_size, type;
 	int err;
 
-	hfs_dbg("cnid %u - (ino %" PRIino "u, name %s) - (ino %" PRIino "u, name %s)\n",
+	hfs_dbg("cnid %u - (ino %llu, name %s) - (ino %llu, name %s)\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
 	sb = src_dir->i_sb;
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 60875cc23880b758bbbb5e4b8281d9ee1f2dbcbb..f066a99a863bc739948aac921bc906874c6009b2 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -411,7 +411,7 @@ int hfs_extend_file(struct inode *inode)
 		goto out;
 	}
 
-	hfs_dbg("ino %" PRIino "u, start %u, len %u\n", inode->i_ino, start, len);
+	hfs_dbg("ino %llu, start %u, len %u\n", inode->i_ino, start, len);
 	if (HFS_I(inode)->alloc_blocks == HFS_I(inode)->first_blocks) {
 		if (!HFS_I(inode)->first_blocks) {
 			hfs_dbg("first_extent: start %u, len %u\n",
@@ -482,7 +482,7 @@ void hfs_file_truncate(struct inode *inode)
 	u32 size;
 	int res;
 
-	hfs_dbg("ino %" PRIino "u, phys_size %llu -> i_size %llu\n",
+	hfs_dbg("ino %llu, phys_size %llu -> i_size %llu\n",
 		inode->i_ino, (long long)HFS_I(inode)->phys_size,
 		inode->i_size);
 	if (inode->i_size > HFS_I(inode)->phys_size) {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index b19866525c1e9c43decf3a943c709922ee8630f6..95f0333a608b0fb57239cf5eec7d9489a25efb3a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -270,7 +270,7 @@ void hfs_delete_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
-	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
+	hfs_dbg("ino %llu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
@@ -455,7 +455,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	hfs_cat_rec rec;
 	int res;
 
-	hfs_dbg("ino %" PRIino "u\n", inode->i_ino);
+	hfs_dbg("ino %llu\n", inode->i_ino);
 	res = hfs_ext_write_extent(inode);
 	if (res)
 		return res;

-- 
2.53.0


