Return-Path: <linux-fsdevel+bounces-79037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Eq2Hfr/pWl5IwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:24:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8251E2B68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D6730CE479
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC63C47FA;
	Mon,  2 Mar 2026 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/jE3ee6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB333C3C1B;
	Mon,  2 Mar 2026 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484149; cv=none; b=EEm/jIpu6gIHrlYWTRglTalf+n/aYWwpdm57jPrllN3tgIl4aQGWLIC2GQ564H0t7ws+RYIl6Ir6JmexQwckjRXXUSKz8qCXTUszw6OXKraG4PhDZr5ddkKFlAGp7nx83obW1YtQw+W1DvqRmWmBryV7QfEcpJEbpdWkWeM59ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484149; c=relaxed/simple;
	bh=YwcnJPXAAscKHpgEUGItsgnX0yRJGV/n6SkEskf1J7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRu9G3t4xee1mLEe2vt4uK1M6ceHcYYUrfJomUvmSLYa06Q6M+jyzLOv/yhhf5nFiGv3Scq+U+TVtsSb8CSDJKWjHgx34ID/A2w/Hjvvvmn7SHLN8W31Ikyh1Q6HFT4UP5RN5co6r4HVBrG9O1Bu14RHrK217ttlhrHOVos+9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/jE3ee6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B88CC19425;
	Mon,  2 Mar 2026 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484149;
	bh=YwcnJPXAAscKHpgEUGItsgnX0yRJGV/n6SkEskf1J7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a/jE3ee6RkkoAR7s9l6a1ENMXzAkQH3rzlJKvh65bROG350op/0J6iplw4D1sc4+d
	 oclKZeRf/gF9p3h+0Ecg7zQDc8pfY94Psk3F75OQyXtohzK22vgDimG9zV25t+77Fa
	 4QFCTa1FhaSK7w4t7ExfQXlnKNZGeowT7C2QYGwPkKFQGZoxe9cB8Gu4co9y2fRdPz
	 OdbDV3ayUG5lGiEuhTBPpj9O3buZIBpVUm47FTOYZAtxvGOYKsASwsEhe8WTNzaPvZ
	 x0nFFGGJCvI8tGIu9/jGqJSU8XQ3ahul/FvMkZP/YJggSxaUgXDpMkcHIaqtdgE5aW
	 pqqiTw2LzquqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:57 -0500
Subject: [PATCH v2 073/110] befs: replace PRIino with %llu/%llx format
 strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-73-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YwcnJPXAAscKHpgEUGItsgnX0yRJGV/n6SkEskf1J7U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIDQ79pU7FI0fHRZsQJj5jJC8eGbR6XylCUt
 iOfUtPsDk+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyAwAKCRAADmhBGVaC
 FVTDEACODHYOCUH/LdAmO41y4Vp/cQpSV4BkS6bppIiXGVitrXjSRpOaFdxtiz9gxx54BpWWKdR
 Al+s6e/U0ikWt8dDXfF720St9a3sq9NhnC9kk7RLKYiTYzCiysHFoxvJ2Sq5/9Xdq8+4Dl+7cDi
 UItfZbfovn1p1DaU8yxRY0gG3AGBr8YVljmhwc1jWQwATwMdZO3Ccq67ucawTLfSk0UMP1InPTP
 38hAu0GT+lCiUGUC9PsWGrtiAWoigdRD0KiYA924ehRyaAvljF2ZYXUNw39S3TdLVBao0+0UCBl
 Uo1KrUYQ+S/pg5fZSTMSe8/N4d/0KilhB6RZ+12IiUhp5JUGqEENQGik6peVTS7xUZ2UsV7AHBb
 6fJQ0zIyydryLLsSJo+wFm2AHn/S6718RwT0xJfq3gngJQmsMm3R+fJMQ0UpXOx9jRecSQlVA4x
 4hN3zUrRZzrRSy3r/AHaMthM+sn6ALA0ftLLaHTXxVTa83nswRChaRiI4QAM02yLFh30DSm3OPA
 9lbE1Mf3tJAAmVI3W5tKTn/GqACo8SiCb5TSnWQokqFjxwQawyM4Zm894Pt8md3nZwvM+IW2DMW
 GdSy9hz3NvToRFldLJ2SWMeHuOK6wRLgIVFi28TrErot3lvkCo7CGu38/w/PyKvVGa90brNOBGI
 9atXB2D5v/wb2CA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 1F8251E2B68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79037-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in befs with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c36216e23eb3678645cbdece913cc260fd10f4f8..c12caae9a96799b0a57e6cb5010de756f8b86346 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -140,11 +140,11 @@ befs_get_block(struct inode *inode, sector_t block,
 	int res;
 	ulong disk_off;
 
-	befs_debug(sb, "---> befs_get_block() for inode %" PRIino "u, block %ld",
+	befs_debug(sb, "---> befs_get_block() for inode %llu, block %ld",
 		   inode->i_ino, (long)block);
 	if (create) {
 		befs_error(sb, "befs_get_block() was asked to write to "
-			   "block %ld in inode %" PRIino "u", (long)block,
+			   "block %ld in inode %llu", (long)block,
 			   inode->i_ino);
 		return -EPERM;
 	}
@@ -152,7 +152,7 @@ befs_get_block(struct inode *inode, sector_t block,
 	res = befs_fblock2brun(sb, ds, block, &run);
 	if (res != BEFS_OK) {
 		befs_error(sb,
-			   "<--- %s for inode %" PRIino "u, block %ld ERROR",
+			   "<--- %s for inode %llu, block %ld ERROR",
 			   __func__, inode->i_ino,
 			   (long)block);
 		return -EFBIG;
@@ -162,7 +162,7 @@ befs_get_block(struct inode *inode, sector_t block,
 
 	map_bh(bh_result, inode->i_sb, disk_off);
 
-	befs_debug(sb, "<--- %s for inode %" PRIino "u, block %ld, disk address %lu",
+	befs_debug(sb, "<--- %s for inode %llu, block %ld, disk address %lu",
 		  __func__, inode->i_ino, (long)block,
 		  (unsigned long)disk_off);
 
@@ -181,7 +181,7 @@ befs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 	char *utfname;
 	const char *name = dentry->d_name.name;
 
-	befs_debug(sb, "---> %s name %pd inode %" PRIino "u", __func__,
+	befs_debug(sb, "---> %s name %pd inode %llu", __func__,
 		   dentry, dir->i_ino);
 
 	/* Convert to UTF-8 */
@@ -224,7 +224,7 @@ befs_readdir(struct file *file, struct dir_context *ctx)
 	size_t keysize;
 	char keybuf[BEFS_NAME_LEN + 1];
 
-	befs_debug(sb, "---> %s name %pD, inode %" PRIino "u, ctx->pos %lld",
+	befs_debug(sb, "---> %s name %pD, inode %llu, ctx->pos %lld",
 		  __func__, file, inode->i_ino, ctx->pos);
 
 	while (1) {
@@ -233,7 +233,7 @@ befs_readdir(struct file *file, struct dir_context *ctx)
 
 		if (result == BEFS_ERR) {
 			befs_debug(sb, "<--- %s ERROR", __func__);
-			befs_error(sb, "IO error reading %pD (inode %" PRIino "u)",
+			befs_error(sb, "IO error reading %pD (inode %llu)",
 				   file, inode->i_ino);
 			return -EIO;
 
@@ -324,7 +324,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	bh = sb_bread(sb, inode->i_ino);
 	if (!bh) {
 		befs_error(sb, "unable to read inode block - "
-			   "inode = %" PRIino "u", inode->i_ino);
+			   "inode = %llu", inode->i_ino);
 		goto unacquire_none;
 	}
 
@@ -333,7 +333,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	befs_dump_inode(sb, raw_inode);
 
 	if (befs_check_inode(sb, raw_inode, inode->i_ino) != BEFS_OK) {
-		befs_error(sb, "Bad inode: %" PRIino "u", inode->i_ino);
+		befs_error(sb, "Bad inode: %llu", inode->i_ino);
 		goto unacquire_bh;
 	}
 
@@ -407,7 +407,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 			inode->i_op = &simple_symlink_inode_operations;
 		}
 	} else {
-		befs_error(sb, "Inode %" PRIino "u is not a regular file, "
+		befs_error(sb, "Inode %llu is not a regular file, "
 			   "directory or symlink. THAT IS WRONG! BeFS has no "
 			   "on disk special files", inode->i_ino);
 		goto unacquire_bh;

-- 
2.53.0


