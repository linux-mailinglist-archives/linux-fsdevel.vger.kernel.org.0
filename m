Return-Path: <linux-fsdevel+bounces-79422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM4NCuxYqGlQtgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:08:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EFA203C28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3890B32DDEDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693E36C0A6;
	Wed,  4 Mar 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHsmhUdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398834FF45;
	Wed,  4 Mar 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638539; cv=none; b=GbiLGZsS7GRxnqmhj0pF/2K0KP5VB6jtx/kolVJLuX+xXILMDNDdJe6GyUQBskrEZ9Cqw7CH5TAwkmXOubgEUtUulfp5ISB+ve70K169z3Zhgko4vqkCi4k6eCF3/WUeFPxq9yBocITWl1OWfcsVPtmZ9PhlGuiQPwOkXJujZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638539; c=relaxed/simple;
	bh=mpnoRGuSw4SxSNPrcDcSDKeNXRSk3u7CSRiG/C+Xaqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmeYqYuDiq4MLjMJkZYQKscadVtI0K0sROK90i/bTB8VARLrLAgQ9ZUtzyUnT5MhA9PEUr8x0dyX8al4eHhjnR+49mKzfMwViilbWKWxa6220BiWlD5gdbnZmjzmbqhqFiLrh0pYl9JhvRYX905sm8WadoMtzsEeUmo+I+SfZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHsmhUdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA608C2BCB9;
	Wed,  4 Mar 2026 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638539;
	bh=mpnoRGuSw4SxSNPrcDcSDKeNXRSk3u7CSRiG/C+Xaqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qHsmhUdTZEg0otM6XnSRS7XUYwA7DkiF4flLtn6zGmgl7LOE8x+wgKqPLQdCje94E
	 cs3Ow50P8lDeAaWzL3YhxMhuHtJReTgJNlk8vYUzIA1OM9LUIbRkhXWwQhZnHjvjSx
	 CJ4WTm9BXAJTGIPIfkfg1BL+SGRWiANnpoQp94ThtAdUpWTsiUWS/MbYCmrKutFniq
	 /m+wVNRwajSaEhhPd1di94QHPTrK7X6TJdrE4MYOZrUaZHEEGMDJ72ks3Ryt4zFFbr
	 kUiG8MlUylZTdTx5rpuxUMWRb6cd9DjAZL+nvLuwaZ47BoeeMiQXddBrsoCJlEQV6W
	 u5L2tZxqtQP2A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Mar 2026 10:32:40 -0500
Subject: [PATCH v3 10/12] f2fs: widen trace event i_ino fields to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-iino-u64-v3-10-2257ad83d372@kernel.org>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
In-Reply-To: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dan Williams <dan.j.williams@intel.com>, Eric Biggers <ebiggers@kernel.org>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=26661; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mpnoRGuSw4SxSNPrcDcSDKeNXRSk3u7CSRiG/C+Xaqk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqFCp3R7f0z3n5ksDE5hFJUJdGye36joy3Yf4I
 KsSBI7cCZCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaahQqQAKCRAADmhBGVaC
 FS7CEADE2L+1fzD5iAXvQj9olGvcYBNB6aC1mGMz+YB8M2+4tmF1FglWesSDd4QNYRqzXiUlcSe
 fTFH0i+R4VhuSRY5aG4ezDeg+gUZaGVA5ZAclT9c2g31vH8OVlnca2oK3mfa6f1qEYVvRFHeix2
 s9bXUI/CRFw2b7miopS5AYxwaQ9H3enGRFsT/f8hOfjaPl6emE67Q9+xl/f4xsw36RNjqmpbpIT
 TpjZH4fT7Q7ZzkmvVUyHOBTt71sRlCjiNVVQuYk206qWgx7egP2xEhxDrUp96ktO5KJzgXbIWly
 ujGMdeUV1WvcK7UpBcnN0VHfVS6BNAx7U2BeRpPXH2KH/Eq9cnwxutQBA9LuZKUkyHS3j9n9bM/
 rY/0Q8EX8teTfCSLSyAWxpHXAcMZ0iNjQ0s5IRaXCD0gFD/rMwDzmU/bcj0UiFWkyzI82IdguGg
 b4mYyV0tNSRl0bhZKgHxTeCTrjnxeVtgzIUpoK89Bp6T7APZX/MYXje1CApSkFZ2ShHSnU7PHC+
 5G+9g00DAjFk7wgnjR4ATvKxmHBcyKxM6YQyZtSGVYVlJE0hRjPGr97ozjuruU2mpbpA1+dX9dD
 1lSbYabLwNFEiTB13s30ShzVkg56FwhsnD+IeQMPHQ8BfBDlVE6/jmOJSQQegefiuQjTuxgTC61
 Ri9HVxwcSBqZaFw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B2EFA203C28
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
	TAGGED_FROM(0.00)[bounces-79422-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In trace events, change __field(ino_t, ...) to __field(u64, ...)
and update TP_printk format strings to %llu/%llx to match the
widened field type.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/f2fs.h | 242 ++++++++++++++++++++++----------------------
 1 file changed, 121 insertions(+), 121 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 9364e677556207ac041353a9eb2d5c2ee49b9dff..05a46908acd946cf7c016d99923403c04448c697 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -9,7 +9,7 @@
 #include <uapi/linux/f2fs.h>
 
 #define show_dev(dev)		MAJOR(dev), MINOR(dev)
-#define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long)entry->ino
+#define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long long)entry->ino
 
 TRACE_DEFINE_ENUM(NODE);
 TRACE_DEFINE_ENUM(DATA);
@@ -206,13 +206,13 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 	TP_ARGS(inode),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(u64,	pino)
+		__field(loff_t,	size)
+		__field(blkcnt_t, blocks)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
-		__field(ino_t,	pino)
 		__field(umode_t, mode)
-		__field(loff_t,	size)
 		__field(unsigned int, nlink)
-		__field(blkcnt_t, blocks)
 		__field(__u8,	advise)
 	),
 
@@ -227,10 +227,10 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 		__entry->advise	= F2FS_I(inode)->i_advise;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pino = %lu, i_mode = 0x%hx, "
+	TP_printk("dev = (%d,%d), ino = %llu, pino = %llu, i_mode = 0x%hx, "
 		"i_size = %lld, i_nlink = %u, i_blocks = %llu, i_advise = 0x%x",
 		show_dev_ino(__entry),
-		(unsigned long)__entry->pino,
+		__entry->pino,
 		__entry->mode,
 		__entry->size,
 		(unsigned int)__entry->nlink,
@@ -245,8 +245,8 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 	TP_ARGS(inode, ret),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(umode_t, mode)
 		__field(int,	ret)
 	),
@@ -258,7 +258,7 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, type: %s, mode = 0%o, ret = %d",
+	TP_printk("dev = (%d,%d), ino = %llu, type: %s, mode = 0%o, ret = %d",
 		show_dev_ino(__entry),
 		show_inode_type(__entry->mode & S_IFMT),
 		__entry->mode & S_ALL_PERM,
@@ -279,8 +279,8 @@ TRACE_EVENT(f2fs_sync_file_exit,
 	TP_ARGS(inode, cp_reason, datasync, ret),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(int,	cp_reason)
 		__field(int,	datasync)
 		__field(int,	ret)
@@ -294,7 +294,7 @@ TRACE_EVENT(f2fs_sync_file_exit,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cp_reason: %s, "
+	TP_printk("dev = (%d,%d), ino = %llu, cp_reason: %s, "
 		"datasync = %d, ret = %d",
 		show_dev_ino(__entry),
 		show_fsync_cpreason(__entry->cp_reason),
@@ -361,10 +361,10 @@ TRACE_EVENT(f2fs_unlink_enter,
 	TP_ARGS(dir, dentry),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	size)
 		__field(blkcnt_t, blocks)
+		__field(dev_t,	dev)
 		__string(name,  dentry->d_name.name)
 	),
 
@@ -376,7 +376,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 		__assign_str(name);
 	),
 
-	TP_printk("dev = (%d,%d), dir ino = %lu, i_size = %lld, "
+	TP_printk("dev = (%d,%d), dir ino = %llu, i_size = %lld, "
 		"i_blocks = %llu, name = %s",
 		show_dev_ino(__entry),
 		__entry->size,
@@ -412,8 +412,8 @@ TRACE_EVENT(f2fs_truncate_data_blocks_range,
 	TP_ARGS(inode, nid,  ofs, free),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(nid_t,	nid)
 		__field(unsigned int,	ofs)
 		__field(int,	free)
@@ -427,7 +427,7 @@ TRACE_EVENT(f2fs_truncate_data_blocks_range,
 		__entry->free	= free;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, nid = %u, offset = %u, freed = %d",
+	TP_printk("dev = (%d,%d), ino = %llu, nid = %u, offset = %u, freed = %d",
 		show_dev_ino(__entry),
 		(unsigned int)__entry->nid,
 		__entry->ofs,
@@ -441,11 +441,11 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 	TP_ARGS(inode, from),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	size)
 		__field(blkcnt_t, blocks)
 		__field(u64,	from)
+		__field(dev_t,	dev)
 	),
 
 	TP_fast_assign(
@@ -456,7 +456,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 		__entry->from	= from;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld, i_blocks = %llu, "
+	TP_printk("dev = (%d,%d), ino = %llu, i_size = %lld, i_blocks = %llu, "
 		"start file offset = %llu",
 		show_dev_ino(__entry),
 		__entry->size,
@@ -499,8 +499,8 @@ DECLARE_EVENT_CLASS(f2fs__truncate_node,
 	TP_ARGS(inode, nid, blk_addr),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(nid_t,	nid)
 		__field(block_t,	blk_addr)
 	),
@@ -512,7 +512,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_node,
 		__entry->blk_addr	= blk_addr;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, nid = %u, block_address = 0x%llx",
+	TP_printk("dev = (%d,%d), ino = %llu, nid = %u, block_address = 0x%llx",
 		show_dev_ino(__entry),
 		(unsigned int)__entry->nid,
 		(unsigned long long)__entry->blk_addr)
@@ -546,8 +546,8 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 	TP_ARGS(inode, nid, depth, err),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__array(nid_t,	nid, 3)
 		__field(int,	depth)
 		__field(int,	err)
@@ -563,7 +563,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 		__entry->err	= err;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, "
 		"nid[0] = %u, nid[1] = %u, nid[2] = %u, depth = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned int)__entry->nid[0],
@@ -581,11 +581,11 @@ TRACE_EVENT(f2fs_file_write_iter,
 	TP_ARGS(inode, offset, length, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t, offset)
 		__field(size_t, length)
 		__field(ssize_t, ret)
+		__field(dev_t,	dev)
 	),
 
 	TP_fast_assign(
@@ -596,7 +596,7 @@ TRACE_EVENT(f2fs_file_write_iter,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, "
 		"offset = %lld, length = %zu, written(err) = %zd",
 		show_dev_ino(__entry),
 		__entry->offset,
@@ -611,11 +611,11 @@ TRACE_EVENT(f2fs_fadvise,
 	TP_ARGS(inode, offset, len, advice),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t, size)
 		__field(loff_t,	offset)
 		__field(loff_t,	len)
+		__field(dev_t,	dev)
 		__field(int,	advice)
 	),
 
@@ -628,7 +628,7 @@ TRACE_EVENT(f2fs_fadvise,
 		__entry->advice	= advice;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
+	TP_printk("dev = (%d,%d), ino = %llu, i_size = %lld offset:%llu, len:%llu, advise:%d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->size,
 		__entry->offset,
@@ -643,8 +643,8 @@ TRACE_EVENT(f2fs_map_blocks,
 	TP_ARGS(inode, map, flag, ret),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(block_t,	m_lblk)
 		__field(block_t,	m_pblk)
 		__field(unsigned int,	m_len)
@@ -670,7 +670,7 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
+	TP_printk("dev = (%d,%d), ino = %llu, file offset = %llu, "
 		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u, "
 		"seg_type = %d, may_create = %d, multidevice = %d, "
 		"flag = %d, err = %d",
@@ -885,8 +885,8 @@ TRACE_EVENT(f2fs_lookup_start,
 	TP_ARGS(dir, dentry, flags),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__string(name,	dentry->d_name.name)
 		__field(unsigned int, flags)
 	),
@@ -898,7 +898,7 @@ TRACE_EVENT(f2fs_lookup_start,
 		__entry->flags	= flags;
 	),
 
-	TP_printk("dev = (%d,%d), pino = %lu, name:%s, flags:%u",
+	TP_printk("dev = (%d,%d), pino = %llu, name:%s, flags:%u",
 		show_dev_ino(__entry),
 		__get_str(name),
 		__entry->flags)
@@ -912,8 +912,8 @@ TRACE_EVENT(f2fs_lookup_end,
 	TP_ARGS(dir, dentry, ino, err),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__string(name,	dentry->d_name.name)
 		__field(nid_t,	cino)
 		__field(int,	err)
@@ -927,7 +927,7 @@ TRACE_EVENT(f2fs_lookup_end,
 		__entry->err	= err;
 	),
 
-	TP_printk("dev = (%d,%d), pino = %lu, name:%s, ino:%u, err:%d",
+	TP_printk("dev = (%d,%d), pino = %llu, name:%s, ino:%u, err:%d",
 		show_dev_ino(__entry),
 		__get_str(name),
 		__entry->cino,
@@ -943,10 +943,10 @@ TRACE_EVENT(f2fs_rename_start,
 	TP_ARGS(old_dir, old_dentry, new_dir, new_dentry, flags),
 
 	TP_STRUCT__entry(
+		__field(u64,		ino)
+		__field(u64,		new_pino)
 		__field(dev_t,		dev)
-		__field(ino_t,		ino)
 		__string(old_name,	old_dentry->d_name.name)
-		__field(ino_t,		new_pino)
 		__string(new_name,	new_dentry->d_name.name)
 		__field(unsigned int,	flags)
 	),
@@ -960,8 +960,8 @@ TRACE_EVENT(f2fs_rename_start,
 		__entry->flags		= flags;
 	),
 
-	TP_printk("dev = (%d,%d), old_dir = %lu, old_name: %s, "
-		"new_dir = %lu, new_name: %s, flags = %u",
+	TP_printk("dev = (%d,%d), old_dir = %llu, old_name: %s, "
+		"new_dir = %llu, new_name: %s, flags = %u",
 		show_dev_ino(__entry),
 		__get_str(old_name),
 		__entry->new_pino,
@@ -977,8 +977,8 @@ TRACE_EVENT(f2fs_rename_end,
 	TP_ARGS(old_dentry, new_dentry, flags, ret),
 
 	TP_STRUCT__entry(
+		__field(u64,		ino)
 		__field(dev_t,		dev)
-		__field(ino_t,		ino)
 		__string(old_name,	old_dentry->d_name.name)
 		__string(new_name,	new_dentry->d_name.name)
 		__field(unsigned int,	flags)
@@ -994,7 +994,7 @@ TRACE_EVENT(f2fs_rename_end,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, old_name: %s, "
+	TP_printk("dev = (%d,%d), ino = %llu, old_name: %s, "
 		"new_name: %s, flags = %u, ret = %d",
 		show_dev_ino(__entry),
 		__get_str(old_name),
@@ -1010,10 +1010,10 @@ TRACE_EVENT(f2fs_readdir,
 	TP_ARGS(dir, start_pos, end_pos, err),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	start)
 		__field(loff_t,	end)
+		__field(dev_t,	dev)
 		__field(int,	err)
 	),
 
@@ -1025,7 +1025,7 @@ TRACE_EVENT(f2fs_readdir,
 		__entry->err	= err;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, start_pos:%llu, end_pos:%llu, err:%d",
+	TP_printk("dev = (%d,%d), ino = %llu, start_pos:%llu, end_pos:%llu, err:%d",
 		show_dev_ino(__entry),
 		__entry->start,
 		__entry->end,
@@ -1040,13 +1040,13 @@ TRACE_EVENT(f2fs_fallocate,
 	TP_ARGS(inode, mode, offset, len, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
-		__field(int,	mode)
+		__field(u64,	ino)
 		__field(loff_t,	offset)
 		__field(loff_t,	len)
 		__field(loff_t, size)
 		__field(blkcnt_t, blocks)
+		__field(dev_t,	dev)
+		__field(int,	mode)
 		__field(int,	ret)
 	),
 
@@ -1061,7 +1061,7 @@ TRACE_EVENT(f2fs_fallocate,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, mode = %x, offset = %lld, "
+	TP_printk("dev = (%d,%d), ino = %llu, mode = %x, offset = %lld, "
 		"len = %lld,  i_size = %lld, i_blocks = %llu, ret = %d",
 		show_dev_ino(__entry),
 		__entry->mode,
@@ -1079,12 +1079,12 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	TP_ARGS(inode, iocb, len, rw),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	ki_pos)
+		__field(unsigned long,	len)
+		__field(dev_t,	dev)
 		__field(int,	ki_flags)
 		__field(u16,	ki_ioprio)
-		__field(unsigned long,	len)
 		__field(int,	rw)
 	),
 
@@ -1098,7 +1098,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->rw		= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
+	TP_printk("dev = (%d,%d), ino = %llu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
 		__entry->ki_pos,
 		__entry->len,
@@ -1115,10 +1115,10 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 	TP_ARGS(inode, offset, len, rw, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	pos)
 		__field(unsigned long,	len)
+		__field(dev_t,	dev)
 		__field(int,	rw)
 		__field(int,	ret)
 	),
@@ -1132,7 +1132,7 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu "
+	TP_printk("dev = (%d,%d), ino = %llu pos = %lld len = %lu "
 		"rw = %d ret = %d",
 		show_dev_ino(__entry),
 		__entry->pos,
@@ -1176,9 +1176,9 @@ DECLARE_EVENT_CLASS(f2fs__submit_folio_bio,
 	TP_ARGS(folio, fio),
 
 	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(ino_t, ino)
+		__field(u64, ino)
 		__field(pgoff_t, index)
+		__field(dev_t, dev)
 		__field(block_t, old_blkaddr)
 		__field(block_t, new_blkaddr)
 		__field(enum req_op, op)
@@ -1199,7 +1199,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_folio_bio,
 		__entry->type		= fio->type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, folio_index = 0x%lx, "
+	TP_printk("dev = (%d,%d), ino = %llu, folio_index = 0x%lx, "
 		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s(%s), type = %s_%s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
@@ -1306,9 +1306,9 @@ TRACE_EVENT(f2fs_write_begin,
 	TP_ARGS(inode, pos, len),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	pos)
+		__field(dev_t,	dev)
 		__field(unsigned int, len)
 	),
 
@@ -1319,7 +1319,7 @@ TRACE_EVENT(f2fs_write_begin,
 		__entry->len	= len;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u",
+	TP_printk("dev = (%d,%d), ino = %llu, pos = %llu, len = %u",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->pos,
 		__entry->len)
@@ -1333,9 +1333,9 @@ TRACE_EVENT(f2fs_write_end,
 	TP_ARGS(inode, pos, len, copied),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	pos)
+		__field(dev_t,	dev)
 		__field(unsigned int, len)
 		__field(unsigned int, copied)
 	),
@@ -1348,7 +1348,7 @@ TRACE_EVENT(f2fs_write_end,
 		__entry->copied	= copied;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u, copied = %u",
+	TP_printk("dev = (%d,%d), ino = %llu, pos = %llu, len = %u, copied = %u",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->pos,
 		__entry->len,
@@ -1362,12 +1362,12 @@ DECLARE_EVENT_CLASS(f2fs__folio,
 	TP_ARGS(folio, type),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(pgoff_t, index)
+		__field(pgoff_t, nrpages)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(int, type)
 		__field(int, dir)
-		__field(pgoff_t, index)
-		__field(pgoff_t, nrpages)
 		__field(int, dirty)
 		__field(int, uptodate)
 	),
@@ -1383,7 +1383,7 @@ DECLARE_EVENT_CLASS(f2fs__folio,
 		__entry->uptodate = folio_test_uptodate(folio);
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, nr_pages = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, %s, %s, index = %lu, nr_pages = %lu, "
 		"dirty = %d, uptodate = %d",
 		show_dev_ino(__entry),
 		show_block_type(__entry->type),
@@ -1437,10 +1437,10 @@ TRACE_EVENT(f2fs_replace_atomic_write_block,
 	TP_ARGS(inode, cow_inode, index, old_addr, new_addr, recovery),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
-		__field(ino_t,	cow_ino)
+		__field(u64,	ino)
+		__field(u64,	cow_ino)
 		__field(pgoff_t, index)
+		__field(dev_t,	dev)
 		__field(block_t, old_addr)
 		__field(block_t, new_addr)
 		__field(bool, recovery)
@@ -1456,7 +1456,7 @@ TRACE_EVENT(f2fs_replace_atomic_write_block,
 		__entry->recovery	= recovery;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cow_ino = %lu, index = %lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, cow_ino = %llu, index = %lu, "
 			"old_addr = 0x%llx, new_addr = 0x%llx, recovery = %d",
 		show_dev_ino(__entry),
 		__entry->cow_ino,
@@ -1474,10 +1474,10 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
 	TP_ARGS(inode, index, flags, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t, index)
 		__field(vm_flags_t, flags)
+		__field(dev_t,	dev)
 		__field(vm_fault_t, ret)
 	),
 
@@ -1489,7 +1489,7 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, flags: %s, ret: %s",
+	TP_printk("dev = (%d,%d), ino = %llu, index = %lu, flags: %s, ret: %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		__print_flags(__entry->flags, "|", FAULT_FLAG_TRACE),
@@ -1519,15 +1519,15 @@ TRACE_EVENT(f2fs_writepages,
 	TP_ARGS(inode, wbc, type),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
-		__field(int,	type)
-		__field(int,	dir)
-		__field(long,	nr_to_write)
-		__field(long,	pages_skipped)
+		__field(u64,	ino)
 		__field(loff_t,	range_start)
 		__field(loff_t,	range_end)
+		__field(long,	nr_to_write)
+		__field(long,	pages_skipped)
 		__field(pgoff_t, writeback_index)
+		__field(dev_t,	dev)
+		__field(int,	type)
+		__field(int,	dir)
 		__field(int,	sync_mode)
 		__field(char,	for_kupdate)
 		__field(char,	for_background)
@@ -1554,7 +1554,7 @@ TRACE_EVENT(f2fs_writepages,
 		__entry->for_sync	= wbc->for_sync;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, nr_to_write %ld, "
+	TP_printk("dev = (%d,%d), ino = %llu, %s, %s, nr_to_write %ld, "
 		"skipped %ld, start %lld, end %lld, wb_idx %lu, sync_mode %d, "
 		"kupdate %u background %u tagged %u cyclic %u sync %u",
 		show_dev_ino(__entry),
@@ -1580,9 +1580,9 @@ TRACE_EVENT(f2fs_readpages,
 	TP_ARGS(inode, start, nrpage),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t,	start)
+		__field(dev_t,	dev)
 		__field(unsigned int,	nrpage)
 	),
 
@@ -1593,7 +1593,7 @@ TRACE_EVENT(f2fs_readpages,
 		__entry->nrpage	= nrpage;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, start = %lu nrpage = %u",
+	TP_printk("dev = (%d,%d), ino = %llu, start = %lu nrpage = %u",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->start,
 		__entry->nrpage)
@@ -1738,8 +1738,8 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 	TP_ARGS(inode, pgofs, type),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(enum extent_type, type)
 	),
@@ -1751,7 +1751,7 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, type = %s",
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, type = %s",
 		show_dev_ino(__entry),
 		__entry->pgofs,
 		show_extent_type(__entry->type))
@@ -1767,8 +1767,8 @@ TRACE_EVENT_CONDITION(f2fs_lookup_read_extent_tree_end,
 	TP_CONDITION(ei),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, fofs)
 		__field(unsigned int, len)
@@ -1784,7 +1784,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_read_extent_tree_end,
 		__entry->blk = ei->blk;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 		"read_ext_info(fofs: %u, len: %u, blk: %u)",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1803,13 +1803,13 @@ TRACE_EVENT_CONDITION(f2fs_lookup_age_extent_tree_end,
 	TP_CONDITION(ei),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(unsigned long long, age)
+		__field(unsigned long long, blocks)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, fofs)
 		__field(unsigned int, len)
-		__field(unsigned long long, age)
-		__field(unsigned long long, blocks)
 	),
 
 	TP_fast_assign(
@@ -1822,7 +1822,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_age_extent_tree_end,
 		__entry->blocks = ei->last_blocks;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 		"age_ext_info(fofs: %u, len: %u, age: %llu, blocks: %llu)",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1841,8 +1841,8 @@ TRACE_EVENT(f2fs_update_read_extent_tree_range,
 	TP_ARGS(inode, pgofs, len, blkaddr, c_len),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(u32, blk)
 		__field(unsigned int, len)
@@ -1858,7 +1858,7 @@ TRACE_EVENT(f2fs_update_read_extent_tree_range,
 		__entry->c_len = c_len;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 				"len = %u, blkaddr = %u, c_len = %u",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1876,12 +1876,12 @@ TRACE_EVENT(f2fs_update_age_extent_tree_range,
 	TP_ARGS(inode, pgofs, len, age, last_blks),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
+		__field(unsigned long long, age)
+		__field(unsigned long long, blocks)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(unsigned int, pgofs)
 		__field(unsigned int, len)
-		__field(unsigned long long, age)
-		__field(unsigned long long, blocks)
 	),
 
 	TP_fast_assign(
@@ -1893,7 +1893,7 @@ TRACE_EVENT(f2fs_update_age_extent_tree_range,
 		__entry->blocks = last_blks;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
+	TP_printk("dev = (%d,%d), ino = %llu, pgofs = %u, "
 				"len = %u, age = %llu, blocks = %llu",
 		show_dev_ino(__entry),
 		__entry->pgofs,
@@ -1938,8 +1938,8 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 	TP_ARGS(inode, node_cnt, type),
 
 	TP_STRUCT__entry(
+		__field(u64,	ino)
 		__field(dev_t,	dev)
-		__field(ino_t,	ino)
 		__field(unsigned int, node_cnt)
 		__field(enum extent_type, type)
 	),
@@ -1951,7 +1951,7 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 		__entry->type = type;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, destroyed: node_cnt = %u, type = %s",
+	TP_printk("dev = (%d,%d), ino = %llu, destroyed: node_cnt = %u, type = %s",
 		show_dev_ino(__entry),
 		__entry->node_cnt,
 		show_extent_type(__entry->type))
@@ -2027,9 +2027,9 @@ DECLARE_EVENT_CLASS(f2fs_zip_start,
 	TP_ARGS(inode, cluster_idx, cluster_size, algtype),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t, idx)
+		__field(dev_t,	dev)
 		__field(unsigned int, size)
 		__field(unsigned int, algtype)
 	),
@@ -2042,7 +2042,7 @@ DECLARE_EVENT_CLASS(f2fs_zip_start,
 		__entry->algtype = algtype;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cluster_idx:%lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, cluster_idx:%lu, "
 		"cluster_size = %u, algorithm = %s",
 		show_dev_ino(__entry),
 		__entry->idx,
@@ -2058,9 +2058,9 @@ DECLARE_EVENT_CLASS(f2fs_zip_end,
 	TP_ARGS(inode, cluster_idx, compressed_size, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,	dev)
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(pgoff_t, idx)
+		__field(dev_t,	dev)
 		__field(unsigned int, size)
 		__field(unsigned int, ret)
 	),
@@ -2073,7 +2073,7 @@ DECLARE_EVENT_CLASS(f2fs_zip_end,
 		__entry->ret = ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, cluster_idx:%lu, "
+	TP_printk("dev = (%d,%d), ino = %llu, cluster_idx:%lu, "
 		"compressed_size = %u, ret = %d",
 		show_dev_ino(__entry),
 		__entry->idx,
@@ -2311,10 +2311,10 @@ TRACE_EVENT(f2fs_bmap,
 	TP_ARGS(inode, lblock, pblock),
 
 	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(ino_t, ino)
+		__field(u64, ino)
 		__field(sector_t, lblock)
 		__field(sector_t, pblock)
+		__field(dev_t, dev)
 	),
 
 	TP_fast_assign(
@@ -2324,7 +2324,7 @@ TRACE_EVENT(f2fs_bmap,
 		__entry->pblock		= pblock;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld",
+	TP_printk("dev = (%d,%d), ino = %llu, lblock:%lld, pblock:%lld",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->lblock,
 		(unsigned long long)__entry->pblock)
@@ -2338,11 +2338,11 @@ TRACE_EVENT(f2fs_fiemap,
 	TP_ARGS(inode, lblock, pblock, len, flags, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(ino_t, ino)
+		__field(u64, ino)
 		__field(sector_t, lblock)
 		__field(sector_t, pblock)
 		__field(unsigned long long, len)
+		__field(dev_t, dev)
 		__field(unsigned int, flags)
 		__field(int, ret)
 	),
@@ -2357,7 +2357,7 @@ TRACE_EVENT(f2fs_fiemap,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld, "
+	TP_printk("dev = (%d,%d), ino = %llu, lblock:%lld, pblock:%lld, "
 		"len:%llu, flags:%u, ret:%d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->lblock,
@@ -2375,13 +2375,13 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 	TP_ARGS(inode, offset, bytes, pid, pathname, command),
 
 	TP_STRUCT__entry(
-		__string(pathbuf, pathname)
+		__field(u64, ino)
 		__field(loff_t, offset)
-		__field(int, bytes)
 		__field(loff_t, i_size)
+		__string(pathbuf, pathname)
 		__string(cmdline, command)
 		__field(pid_t, pid)
-		__field(ino_t, ino)
+		__field(int, bytes)
 	),
 
 	TP_fast_assign(
@@ -2402,10 +2402,10 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 	),
 
 	TP_printk("entry_name %s, offset %llu, bytes %d, cmdline %s,"
-		" pid %d, i_size %llu, ino %lu",
+		" pid %d, i_size %llu, ino %llu",
 		__get_str(pathbuf), __entry->offset, __entry->bytes,
 		__get_str(cmdline), __entry->pid, __entry->i_size,
-		(unsigned long) __entry->ino)
+		__entry->ino)
 );
 
 DECLARE_EVENT_CLASS(f2fs__rw_end,
@@ -2415,7 +2415,7 @@ DECLARE_EVENT_CLASS(f2fs__rw_end,
 	TP_ARGS(inode, offset, bytes),
 
 	TP_STRUCT__entry(
-		__field(ino_t,	ino)
+		__field(u64,	ino)
 		__field(loff_t,	offset)
 		__field(int,	bytes)
 	),
@@ -2426,8 +2426,8 @@ DECLARE_EVENT_CLASS(f2fs__rw_end,
 		__entry->bytes		= bytes;
 	),
 
-	TP_printk("ino %lu, offset %llu, bytes %d",
-		(unsigned long) __entry->ino,
+	TP_printk("ino %llu, offset %llu, bytes %d",
+		__entry->ino,
 		__entry->offset, __entry->bytes)
 );
 

-- 
2.53.0


