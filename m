Return-Path: <linux-fsdevel+bounces-78995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOTxFB74pWkEIgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:50:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3A1E0D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEBAF3014A2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59C47DF92;
	Mon,  2 Mar 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3DXMe2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8C367F3C;
	Mon,  2 Mar 2026 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483575; cv=none; b=GWUoyJFRWckGlHeu8nmG8Ls40eXvShwLwQ2U3elekD3bBPGzZRA9maIucE78Iflcxex/ajv11BwRqign4aEt5GDy8flP1UVuman7OoFZaKCBC8loEGSLG55Z3NduyqmSZUTsQ804Bpj7gkyzE3oKaLjNH2N6zqEIs0op7j2NEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483575; c=relaxed/simple;
	bh=6he62HkTmrAJJK1V+F014fP6cP4Uk2TDa7mAcm5F3PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPE7jhwVOS1BR2uiuUBON4GqSdDFf1qUTJ/sBJqm7AGvl+Jl9GBWgv4qDE2/s+MKd4Hth5eG68xtstZ6Bg5nrgfThXFedwO39zK7GQ63KYZlI53yqOcDBucA0EAuZiKd2tqfxCE31ULEOcR8zKdM4r/l2e1YeYbHkDB2ntXetOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3DXMe2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C565C19425;
	Mon,  2 Mar 2026 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483575;
	bh=6he62HkTmrAJJK1V+F014fP6cP4Uk2TDa7mAcm5F3PM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I3DXMe2EZLLgmbJ+4COsXB7QmFoiqqwBMZHBERmgMBum1GEmM9WBOndN6QOxNrTa6
	 XodAOBXKzRxZqLXzs/LEkDIQwz663dLxlCzXbT7ly7Mjq4OGMQCOwPLr6PqHY9OKJR
	 6nOHbSKj4KRHm3p3+DKRAe9jY/5WHpG4Yqq8ZZAfvQ4GfxsD65XDTnSyUcFO4wf2jy
	 mIDrGEFRJBRURxhU0mTu8jVk0xVVdDZe3p2nzsNKB+LpyYp2fQLz6QYL0Uy6cUqpBG
	 UQx90IGGFTeMYJ8B5R3SgVBVkYUm3YI63u6Ngwh42A48ZsoIXxLzXwHjS96ACfHe/H
	 RbZPpKHHnn+zg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:17 -0500
Subject: [PATCH v2 033/110] hpfs: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-33-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6he62HkTmrAJJK1V+F014fP6cP4Uk2TDa7mAcm5F3PM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfH3QkUy253PqLXrCPd4bzHtp562xc6o9hGTd
 APWnnkqD92JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx9wAKCRAADmhBGVaC
 FYuCEACCUfWHkYFuIq/9X5eqdFwf9bC6OV9r2Q3T6m28PCze7gl9TRluZli+IW3JCUNHVTnyjs/
 dfPF9HSuq0C4m5hhDuABwyUyWQ8Vm7AA1MoL6wZe3Mg6WCS8BxDfT/0p6J6hziiAvdymvcPYhia
 7Ap1VKx8lzJbTNe8L459ylLmo6bm+FH1GJuiu3DH3iMZ9idxhXDOEB9H0FqKriyAGjeFa6UVdHG
 qaxKUVm5cjh/9sahddb9icD2E+MVCzRci8C8+/QsgL+n1gEF+t9JKzg2qvBAwJWPBNrUYXWSLru
 7Yu2GrxJIJiVxs7P8S1bNp2PQBtpE9cOjcL/DTj/yGqXags4FDoZOmjta+8CUrv2EszWgQF43Q5
 SMRNoHT+8nVlCGUeeA0jCCrQ7T676Z1ML5o7lugaNKq3RE46ASPtpNOk8Qlmdez9CCrT09SPRAF
 1L7T54i0wH2e59Up8p8gMQVpBAPOZoLiytzikLWjfTMDiNr10z0cjqnlxLv4jvR2jVK4BlpEoSM
 GEFxdU8OmY0iiH/4/dGejJX9qkBMmuQscoTYADycPtHI9WkpdPYUM08ytZU8Wl28NJ4bRv9dIjH
 abldNKX7F2qN//q04f4/za/Im6dy66lMRpWX8m5mEG1+6CCjLsut0spC7foCfz1fcRsLWMOpeEV
 NKzahrEAEsuxzGQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 00D3A1E0D96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78995-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Convert hpfs i_ino format strings to use the PRIino format
macro in preparation for the widening of i_ino via kino_t.

Remove now-unnecessary (unsigned long) casts on i_ino.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hpfs/dir.c   | 4 ++--
 fs/hpfs/dnode.c | 4 ++--
 fs/hpfs/ea.c    | 4 ++--
 fs/hpfs/inode.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index ceb50b2dc91a9da02997a40836d6543786d883d3..9db0e7a101c2a8d9cc265c14ed74c58533ab31ff 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -96,8 +96,8 @@ static int hpfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 		if (!fnode_is_dir(fno)) {
 			e = 1;
-			hpfs_error(inode->i_sb, "not a directory, fnode %08lx",
-					(unsigned long)inode->i_ino);
+			hpfs_error(inode->i_sb, "not a directory, fnode %08" PRIino "x",
+					inode->i_ino);
 		}
 		if (hpfs_inode->i_dno != le32_to_cpu(fno->u.external[0].disk_secno)) {
 			e = 1;
diff --git a/fs/hpfs/dnode.c b/fs/hpfs/dnode.c
index dde764ebe24673c339d4602172618dbf6ca0b5c9..5df10c82f84ca40c4d65b97b6c6b61ec364029b5 100644
--- a/fs/hpfs/dnode.c
+++ b/fs/hpfs/dnode.c
@@ -550,9 +550,9 @@ static void delete_empty_dnode(struct inode *i, dnode_secno dno)
 			if (hpfs_sb(i->i_sb)->sb_chk)
 				if (up != i->i_ino) {
 					hpfs_error(i->i_sb,
-						   "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08lx",
+						   "bad pointer to fnode, dnode %08x, pointing to %08x, should be %08" PRIino "x",
 						   dno, up,
-						   (unsigned long)i->i_ino);
+						   i->i_ino);
 					return;
 				}
 			if ((d1 = hpfs_map_dnode(i->i_sb, down, &qbh1))) {
diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 2149d3ca530b6f635ff884988383bdde21be5e7a..f4fce87110d77c6af47fd45e024fb913c09e82f7 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -245,8 +245,8 @@ void hpfs_set_ea(struct inode *inode, struct fnode *fnode, const char *key,
 		fnode->ea_offs = cpu_to_le16(0xc4);
 	}
 	if (le16_to_cpu(fnode->ea_offs) < 0xc4 || le16_to_cpu(fnode->ea_offs) + le16_to_cpu(fnode->acl_size_s) + le16_to_cpu(fnode->ea_size_s) > 0x200) {
-		hpfs_error(s, "fnode %08lx: ea_offs == %03x, ea_size_s == %03x",
-			(unsigned long)inode->i_ino,
+		hpfs_error(s, "fnode %08" PRIino "x: ea_offs == %03x, ea_size_s == %03x",
+			inode->i_ino,
 			le16_to_cpu(fnode->ea_offs), le16_to_cpu(fnode->ea_size_s));
 		return;
 	}
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 93d528f4f4f28d5070162faacd65d3fc2341248a..c82f5f7f435a1a6f6c26fc62ff0c680c26c9f4ad 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -250,8 +250,8 @@ void hpfs_write_inode_nolock(struct inode *i)
 			hpfs_brelse4(&qbh);
 		} else
 			hpfs_error(i->i_sb,
-				"directory %08lx doesn't have '.' entry",
-				(unsigned long)i->i_ino);
+				"directory %08" PRIino "x doesn't have '.' entry",
+				i->i_ino);
 	}
 	mark_buffer_dirty(bh);
 	brelse(bh);

-- 
2.53.0


