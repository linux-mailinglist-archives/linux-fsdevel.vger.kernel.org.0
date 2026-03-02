Return-Path: <linux-fsdevel+bounces-78965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFNXOH7zpWkeIQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:30:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8981DF8C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22FCE30AB0F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF748094C;
	Mon,  2 Mar 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRp+2X0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA8385510;
	Mon,  2 Mar 2026 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483160; cv=none; b=G2iajV6vLGPzw9U2B1p5CSMalO5kptj+E2198CpX7V2P9ddAwdjgckJh+Ebk01FZ4ZTjwbfX/d+56wyTQk+rxtw94OWaBzGeAsEodp9/mqHChWM3pRM+Yrt9X8S+XABiIcFONrL1A9phnq7Gwa8leTryFubTRPUg3BLOcuYAq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483160; c=relaxed/simple;
	bh=UbQUSM17B8eDjqJD3X56G3Nb04mdY/iOfKJir9jCM4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KE5XGp1/NNe9YOrPcHXDYRs1tMdzVsiQNROWjshTlQL0nv3kCYTA5FD9rLjLDjAVmoLA4n/77qpLvUqqfIDGMTkDBZPMJuLiY4jByc/HlTRxWjHo4hRVa8S7a1iTv2wDitZ/L2IFAeKIDumx5C4sFDNgLQ/Uo1nMBzuMJM5RChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRp+2X0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131BCC19423;
	Mon,  2 Mar 2026 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483158;
	bh=UbQUSM17B8eDjqJD3X56G3Nb04mdY/iOfKJir9jCM4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rRp+2X0ImgIVAwMegso2leOSmZtxSmSmtg4qNHIG9ul5rMyukotTq2fkUevH7eaLV
	 ryILOF7JoqRurfiuCfJy+VjH5kU6G0uZIbLTg465bR7ww2uOp0ZjFp9DXqSqU3LApP
	 nw6cpHunjJ29JIv/fFQhhAYAusM+OEG71fbi3Jv7ebsLFEkjf2uPIj2OxnAzPD0DFz
	 3UVCNp2YRxq9sFqOhkPed1ocV8yfLW+ykwagKi0ng5Ufmk1ibKMnxWdSwfWSK+3DXJ
	 +sElapFHd+wZbdUxI61yu3DR/JpovXB/rNzg0tDIruMCdTd2kt/tT0INtGCQsE7mYb
	 IbryZLDCc5z3A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:23:48 -0500
Subject: [PATCH v2 004/110] net: change sock.sk_ino and sock_i_ino() to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-4-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15087; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UbQUSM17B8eDjqJD3X56G3Nb04mdY/iOfKJir9jCM4E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfHw+bUj5KD7645Ru6nna5NEOhgGQ/ZBSt0+S
 F6thM3zGSKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx8AAKCRAADmhBGVaC
 FQNAD/9Z+6TMZgqRnEpXcdR1p0qNAtxIsaAzMUMRjztwCF0ikGlRqtoTLb/5v5z0WOPbQKKom0D
 XSPPP2v7mca/A15gcKW23KrSsw+rcoIuCQ2Qql6BEGECkvdi9ib+H2cRA9ZVWvi4yjOjk8WmpIR
 a3RXi8ZLjR/m2ChgCvutshJuljgk/htz0tADLUtaNojY4m8MzW04D2hlYT69/pFINZdPFC4KqVp
 IUa4MwVasmawi5DoL/lxdR8ugvedDFBGnlsx9KVdWKzhG7tvVnk8cy+xiO57yO/3ntFg+MgJNyS
 AB66Ee2NWuyWDjW4bMY5c09IQUIVwUgaS8YBmpIvQ7U5cFJEV9z960/wDO/SLaQnwnZC8Pjgm8M
 2dDu/k6cVPHys4xlHc0BzpmTsotrt/2msyxy5Prj8DE+DuOR1I3d7/bdhtjCUlfkA7Dbs8sDbw8
 WKhXZ7ucreQN4RehoHk1p+821qNPOCqH0RHV9E0zmHXfSrYvCog7Pq8/UsIWNiNAo0FLlJWVHdo
 4QHbcfTcLSMjQhdv0uXzA5ziGN8eX8QI7/sdZEsOjT6bdafvKY68m5nbMalXcV9oLVt6fieSH1B
 +fUHynxooCPYvPRxXk7gb64Zp+pXLmfEV49fpmmUKq3MHilyET4Kym6LqJNEe+lQiJxk3b/s1N9
 na6/kacFrz96BhQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 5C8981DF8C2
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
	TAGGED_FROM(0.00)[bounces-78965-lists,linux-fsdevel=lfdr.de];
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

inode->i_ino is being converted to a u64. sock.sk_ino (which caches the
inode number) must also be widened to avoid truncation on 32-bit
architectures where unsigned long is only 32 bits.

Change sk_ino from unsigned long to u64, and update the return type
of sock_i_ino() to match. Fix all format strings that print the
result of sock_i_ino() (%lu -> %llu), and widen the intermediate
variables and function parameters in the diag modules that were
using int to hold the inode number.

Note that the UAPI socket diag structures (inet_diag_msg.idiag_inode,
unix_diag_msg.udiag_ino, etc.) are all __u32 and cannot be changed
without breaking the ABI. The assignments to those fields will
silently truncate, which is the existing behavior.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/net/sock.h           | 4 ++--
 net/ax25/af_ax25.c           | 2 +-
 net/bluetooth/af_bluetooth.c | 4 ++--
 net/can/bcm.c                | 2 +-
 net/ipv4/ping.c              | 2 +-
 net/ipv4/raw.c               | 2 +-
 net/ipv4/tcp_ipv4.c          | 2 +-
 net/ipv4/udp.c               | 2 +-
 net/ipv6/datagram.c          | 2 +-
 net/ipv6/tcp_ipv6.c          | 2 +-
 net/key/af_key.c             | 2 +-
 net/netlink/af_netlink.c     | 2 +-
 net/netlink/diag.c           | 2 +-
 net/packet/af_packet.c       | 2 +-
 net/packet/diag.c            | 2 +-
 net/phonet/socket.c          | 4 ++--
 net/sctp/proc.c              | 4 ++--
 net/unix/af_unix.c           | 2 +-
 net/unix/diag.c              | 6 +++---
 net/xdp/xsk_diag.c           | 2 +-
 20 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6c9a83016e9551ed2e2a0d7edf32300b8a4327e7..cfae4fefb8f55d8be6ff5ef401f7b9c601f67cc3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -537,7 +537,7 @@ struct sock {
 	rwlock_t		sk_callback_lock;
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
-	unsigned long		sk_ino;
+	u64			sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
 	struct pid		*sk_peer_pid;
@@ -2140,7 +2140,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
-static inline unsigned long sock_i_ino(const struct sock *sk)
+static inline u64 sock_i_ino(const struct sock *sk)
 {
 	/* Paired with WRITE_ONCE() in sock_graft() and sock_orphan() */
 	return READ_ONCE(sk->sk_ino);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index a76f4793aed27657dea22e9e28c1d3cd45087cb2..9d236e64f5f59abe2fd974ffd9d6ef1193db5b52 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1986,7 +1986,7 @@ static int ax25_info_show(struct seq_file *seq, void *v)
 		   ax25->paclen);
 
 	if (ax25->sk != NULL) {
-		seq_printf(seq, " %d %d %lu\n",
+		seq_printf(seq, " %d %d %llu\n",
 			   sk_wmem_alloc_get(ax25->sk),
 			   sk_rmem_alloc_get(ax25->sk),
 			   sock_i_ino(ax25->sk));
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 2b94e20772038f1d90228d214f57ab334ca01a50..33d053d634072fee79bb62c003980c203fb30111 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -817,14 +817,14 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 		struct bt_sock *bt = bt_sk(sk);
 
 		seq_printf(seq,
-			   "%pK %-6d %-6u %-6u %-6u %-6lu %-6lu",
+			   "%pK %-6d %-6u %-6u %-6u %-6llu %-6llu",
 			   sk,
 			   refcount_read(&sk->sk_refcnt),
 			   sk_rmem_alloc_get(sk),
 			   sk_wmem_alloc_get(sk),
 			   from_kuid(seq_user_ns(seq), sk_uid(sk)),
 			   sock_i_ino(sk),
-			   bt->parent ? sock_i_ino(bt->parent) : 0LU);
+			   bt->parent ? sock_i_ino(bt->parent) : 0ULL);
 
 		if (l->custom_seq_show) {
 			seq_putc(seq, ' ');
diff --git a/net/can/bcm.c b/net/can/bcm.c
index b7324e9c955b7f03a8f032676bbd89aa8e06bded..30aac2f903d57421d2761153939200813b99e0e9 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1712,7 +1712,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 #if IS_ENABLED(CONFIG_PROC_FS)
 	if (net->can.bcmproc_dir) {
 		/* unique socket address as filename */
-		sprintf(bo->procname, "%lu", sock_i_ino(sk));
+		sprintf(bo->procname, "%llu", sock_i_ino(sk));
 		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
 						     net->can.bcmproc_dir,
 						     bcm_proc_show, sk);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 71d5e17719debb14ca2400edcf5a2cc3153291c6..bc4b43e5230336521802403c5c74cfb5da8b05b1 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -1111,7 +1111,7 @@ static void ping_v4_format_sock(struct sock *sp, struct seq_file *f,
 	__u16 srcp = ntohs(inet->inet_sport);
 
 	seq_printf(f, "%5d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u",
 		bucket, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
 		sk_rmem_alloc_get(sp),
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e20c41206e29d5655f5378f08fb283f2ecbd2097..bcc99ced1ade135701e2df0e32da0da0af2fc487 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -1041,7 +1041,7 @@ static void raw_sock_seq_show(struct seq_file *seq, struct sock *sp, int i)
 	      srcp  = inet->inet_num;
 
 	seq_printf(seq, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u\n",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u\n",
 		i, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
 		sk_rmem_alloc_get(sp),
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d53d39be291a5750af3ab2a160b35f0f8a28ff9d..f2ef41583fc195e153ed848afaf3391080696f02 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2889,7 +2889,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 				      READ_ONCE(tp->copied_seq), 0);
 
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X %02X %08X:%08X %02X:%08lX "
-			"%08X %5u %8d %lu %d %pK %lu %lu %u %u %d",
+			"%08X %5u %8d %llu %d %pK %lu %lu %u %u %d",
 		i, src, srcp, dest, destp, state,
 		READ_ONCE(tp->write_seq) - tp->snd_una,
 		rx_queue,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6c6b68a66dcd3b3d8f1747fead868c195e04a0a9..db58bf786c4a8c73b5d42851bb68bbb22a5e85ab 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3428,7 +3428,7 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 	__u16 srcp	  = ntohs(inet->inet_sport);
 
 	seq_printf(f, "%5d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u",
 		bucket, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
 		udp_rqueue_get(sp),
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index c564b68a056268c7cbc81b5f29f60289ea9e09eb..611fddb90c79e94cc7dfcf85b343bcbf630c39d4 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -1055,7 +1055,7 @@ void __ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
 	src   = &sp->sk_v6_rcv_saddr;
 	seq_printf(seq,
 		   "%5d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %u\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u\n",
 		   bucket,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e46a0efae01235ae7430ed268b92cb47309b8d28..379c0935f4030b9b3432e867c357883df3089f74 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2175,7 +2175,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK %lu %lu %u %u %d\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %lu %lu %u %u %d\n",
 		   i,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 0756bac62f7c042851636badf0a5e961c4e673c1..522308ec934ed055bdce4fa672b4e6a8bb67edc7 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3783,7 +3783,7 @@ static int pfkey_seq_show(struct seq_file *f, void *v)
 	if (v == SEQ_START_TOKEN)
 		seq_printf(f ,"sk       RefCnt Rmem   Wmem   User   Inode\n");
 	else
-		seq_printf(f, "%pK %-6d %-6u %-6u %-6u %-6lu\n",
+		seq_printf(f, "%pK %-6d %-6u %-6u %-6u %-6llu\n",
 			       s,
 			       refcount_read(&s->sk_refcnt),
 			       sk_rmem_alloc_get(s),
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf40653e04de60f2d28ee26b8bdcdc2ed..aba847902be5ace66e17abf0236a5eeebfee0739 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2700,7 +2700,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 		struct sock *s = v;
 		struct netlink_sock *nlk = nlk_sk(s);
 
-		seq_printf(seq, "%pK %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8lu\n",
+		seq_printf(seq, "%pK %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8llu\n",
 			   s,
 			   s->sk_protocol,
 			   nlk->portid,
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 1dfc340736b832459388304003ff1f5e1e481d23..0b3e021bd0ed29edc094fad2c79c7c067edcdd50 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -43,7 +43,7 @@ static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
 
 static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 			struct netlink_diag_req *req,
-			u32 portid, u32 seq, u32 flags, int sk_ino)
+			u32 portid, u32 seq, u32 flags, u64 sk_ino)
 {
 	struct nlmsghdr *nlh;
 	struct netlink_diag_msg *rep;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 72d0935139f0f5feb00c051143fb47f45fd1f94d..f2af2e0a8530a982d7b95b91ac0388f67b16d46f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4721,7 +4721,7 @@ static int packet_seq_show(struct seq_file *seq, void *v)
 		const struct packet_sock *po = pkt_sk(s);
 
 		seq_printf(seq,
-			   "%pK %-6d %-4d %04x   %-5d %1d %-6u %-6u %-6lu\n",
+			   "%pK %-6d %-4d %04x   %-5d %1d %-6u %-6u %-6llu\n",
 			   s,
 			   refcount_read(&s->sk_refcnt),
 			   s->sk_type,
diff --git a/net/packet/diag.c b/net/packet/diag.c
index c8f43e0c1925fab8ef6c39de3547dcd6f7389b81..cee773f46571ca51718544227f3425192bb77f24 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -130,7 +130,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 			struct packet_diag_req *req,
 			bool may_report_filterinfo,
 			struct user_namespace *user_ns,
-			u32 portid, u32 seq, u32 flags, int sk_ino)
+			u32 portid, u32 seq, u32 flags, u64 sk_ino)
 {
 	struct nlmsghdr *nlh;
 	struct packet_diag_msg *rp;
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 4423d483c630adc93af07e0c23a78800b696d4a4..c4af26357144ebb8016d001244c1fdaf925892fc 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -579,7 +579,7 @@ static int pn_sock_seq_show(struct seq_file *seq, void *v)
 		struct sock *sk = v;
 		struct pn_sock *pn = pn_sk(sk);
 
-		seq_printf(seq, "%2d %04X:%04X:%02X %02X %08X:%08X %5d %lu "
+		seq_printf(seq, "%2d %04X:%04X:%02X %02X %08X:%08X %5d %llu "
 			"%d %pK %u",
 			sk->sk_protocol, pn->sobject, pn->dobject,
 			pn->resource, sk->sk_state,
@@ -754,7 +754,7 @@ static int pn_res_seq_show(struct seq_file *seq, void *v)
 		struct sock *sk = rcu_dereference_protected(*psk,
 					lockdep_is_held(&resource_mutex));
 
-		seq_printf(seq, "%02X %5u %lu",
+		seq_printf(seq, "%02X %5u %llu",
 			   (int) (psk - pnres.sk),
 			   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
 			   sock_i_ino(sk));
diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 1ed281f3c355d559d82e4fa2be10c191f787c85e..43433d7e2acd706ede7b59a51ab6441d1ee1dd12 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -174,7 +174,7 @@ static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 		sk = ep->base.sk;
 		if (!net_eq(sock_net(sk), seq_file_net(seq)))
 			continue;
-		seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5lu ", ep, sk,
+		seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5llu ", ep, sk,
 			   sctp_sk(sk)->type, sk->sk_state, hash,
 			   ep->base.bind_addr.port,
 			   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
@@ -261,7 +261,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq, void *v)
 
 	seq_printf(seq,
 		   "%8pK %8pK %-3d %-3d %-2d %-4d "
-		   "%4d %8d %8d %7u %5lu %-5d %5d ",
+		   "%4d %8d %8d %7u %5llu %-5d %5d ",
 		   assoc, sk, sctp_sk(sk)->type, sk->sk_state,
 		   assoc->state, 0,
 		   assoc->assoc_id,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63aabc814f7edd31e8c0b6fafa02ce7..a6c5015f3f0a19a930da636ef37eb98b3c40663f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3537,7 +3537,7 @@ static int unix_seq_show(struct seq_file *seq, void *v)
 		struct unix_sock *u = unix_sk(s);
 		unix_state_lock(s);
 
-		seq_printf(seq, "%pK: %08X %08X %08X %04X %02X %5lu",
+		seq_printf(seq, "%pK: %08X %08X %08X %04X %02X %5llu",
 			s,
 			refcount_read(&s->sk_refcnt),
 			0,
diff --git a/net/unix/diag.c b/net/unix/diag.c
index ca34730261510c2b34dc6661eadaa9d1651e59d2..410f6c8745b7a0e5287b9f7fbc0a71d15cffc850 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -45,7 +45,7 @@ static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
 {
 	struct sock *peer;
-	int ino;
+	u64 ino;
 
 	peer = unix_peer_get(sk);
 	if (peer) {
@@ -112,7 +112,7 @@ static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb,
 
 static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_req *req,
 			struct user_namespace *user_ns,
-			u32 portid, u32 seq, u32 flags, int sk_ino)
+			u32 portid, u32 seq, u32 flags, u64 sk_ino)
 {
 	struct nlmsghdr *nlh;
 	struct unix_diag_msg *rep;
@@ -186,7 +186,7 @@ static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		num = 0;
 		spin_lock(&net->unx.table.locks[slot]);
 		sk_for_each(sk, &net->unx.table.buckets[slot]) {
-			int sk_ino;
+			u64 sk_ino;
 
 			if (num < s_num)
 				goto next;
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 0e0bca031c0399901949982bf430ade6cde286d3..0170363eb542cc1874817f46fd3627857761ab77 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -92,7 +92,7 @@ static int xsk_diag_put_stats(const struct xdp_sock *xs, struct sk_buff *nlskb)
 static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 			 struct xdp_diag_req *req,
 			 struct user_namespace *user_ns,
-			 u32 portid, u32 seq, u32 flags, int sk_ino)
+			 u32 portid, u32 seq, u32 flags, u64 sk_ino)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct xdp_diag_msg *msg;

-- 
2.53.0


