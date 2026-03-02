Return-Path: <linux-fsdevel+bounces-79022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cr8LkEApml5IwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:25:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9B1E2C89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5B67312EC51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DC4D2ED1;
	Mon,  2 Mar 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw6fYKRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B51A6827;
	Mon,  2 Mar 2026 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483934; cv=none; b=pDDPRYvDwqsgfEO7+preJiDX7xGdilVbFIli1LbVlN9FZpOS5in/Vi+RIZ4Efk1zNtMAYyBAqJxJ6chLHW6RnmeuPLG5MTCKqbCMnzu0wQAZPfpj9SctekOOxrhS0JVzcQxSUvErdnwzNLlleXTjRHCV3RXIBhkdw7jpZTWBu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483934; c=relaxed/simple;
	bh=EkVY4OzCxoV1B6JjTU1CxpHxdOMuJb7GCMDpICOoKnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+ANW0TMnCNYVENMxtFRI2bWrA90bsi7UYIi9SusDaT4MC5JJqfA8wDeQ/pAAzIsxhm5PEpzfvL4UqFpbVUSAr5SbPokXYTyRL9+BJh8fE5eTfd2ZBnojZ23NdETnM3f1MhzLzlzhK3hOfRLujYBT8YmNV/9/8JX5U4mxf/aNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw6fYKRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475B2C19425;
	Mon,  2 Mar 2026 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483934;
	bh=EkVY4OzCxoV1B6JjTU1CxpHxdOMuJb7GCMDpICOoKnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cw6fYKRxkA/2qSg00XWLZ3vREeGKcKpXCr2z3otf7bkXJULLwvJXZFBTr8QeEXtnl
	 O3cBxE5aiqKSM1aXOiGIip6+rT4A0MrUQH9aqQU83yhz8xx/h9TGq8qEhmouP0c+Aj
	 /6PXUjtDxSwGSliUzbksOagSQR4xwcd/yRfOL2tsDICH2gl+uLTlfAbxk5gSrdPWHv
	 xw/4aJ3ejktiyiV+amJL/6JM1R2kuUkhC7Yjo7k09FiJfXJg5p5pScgxdBJr7BV8uO
	 5575ABTf8Qasm1xofy9cIyMwaj8Va59trON8+cvaXZLEJLXGYR/KR9qJUlavo5ClzX
	 fXp6LnsikOCag==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:42 -0500
Subject: [PATCH v2 058/110] net: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-58-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3590; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EkVY4OzCxoV1B6JjTU1CxpHxdOMuJb7GCMDpICOoKnM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfH+Mnc8nVtv6Lm/omX/kUloGe5xdlARw0dWD
 Dkf72ua1PiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx/gAKCRAADmhBGVaC
 FV7ND/9cbF3xOXUXzNKgQSMwCY/Z6EDC24GChRkdNAAl2jLMVrNdA7SH+rUX8wS/Xb+ecl0XjLI
 HFbdQ8UNLvQUahhf1pRfQXjDDizfsBxDz0duLiApUFVBwsiAaoWrQYbIHfWhlzdAJepp/UtQJ/D
 GIQwokNyeDXWkaggAVnPkm2d3COjH83H2J8ccxPeLu9l9zDOBvWyDLkGlOjkscwb/iR7xJr2fXc
 0CEWI9jtoEP3GEivF0SjoIc5i2h3SQEBoAYj0t8+IcbpZ90X/s/MK2k+HwpUCjvSFSNbI5BV8Tg
 3Ouof1vHdnLHBn+12oiFIs1tadfwHNStEOM7OcrKXaXrJXXLUmXy74caMCsgJ2gnR7wgeRtE/Vk
 JwqHwo3E8d5x8cbXVL+202F3p5BdjJ2kOorBQTzRHYE5ivZlttgpSL4sgvE4Gm+JK2ID7EWPdh+
 pFWKqlh0cEgynItMvOkQ5UpsXIW4ApzelXba3f60fUeLkuqQnB+ub2aeVlMhM9ohXSul6YNT6v6
 xJt3BmT7UVPe3ytZX6eKnsmRaA32wHZD71biGWWoWDE/2JSKC0IHCVBEi2BWWvHErfhWEARE7uC
 cx+k76sD2N1X1CWyiiJjpWD04bpl8Jzg6bd+yv+OkmZkJk38rrUw8X5C0qzK+ZUYfxWKya/Ufq2
 ER0lcckWB4Db/Aw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 45E9B1E2C89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79022-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Convert i_ino format strings in x25, netrom, and rose /proc output to
use the PRIino format macro. Also correct the format specifiers from
signed (%ld) to unsigned, and change 0L fallback literals to (kino_t)0,
since inode numbers are unsigned. Update the local ino variable type
from unsigned long to kino_t.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/netrom/af_netrom.c | 4 ++--
 net/rose/af_rose.c     | 4 ++--
 net/x25/x25_proc.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index b816c56124ab8b7e59689e612d36007bb11aacaa..883c8aa90235d746a688c5f38b812c20faa7c770 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -1305,7 +1305,7 @@ static int nr_info_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "%-9s ", ax2asc(buf, &nr->user_addr));
 		seq_printf(seq, "%-9s ", ax2asc(buf, &nr->dest_addr));
 		seq_printf(seq,
-"%-9s %-3s  %02X/%02X %02X/%02X %2d %3d %3d %3d %3lu/%03lu %2lu/%02lu %3lu/%03lu %3lu/%03lu %2d/%02d %3d %5d %5d %ld\n",
+"%-9s %-3s  %02X/%02X %02X/%02X %2d %3d %3d %3d %3lu/%03lu %2lu/%02lu %3lu/%03lu %3lu/%03lu %2d/%02d %3d %5d %5d %" PRIino "u\n",
 			ax2asc(buf, &nr->source_addr),
 			devname,
 			nr->my_index,
@@ -1329,7 +1329,7 @@ static int nr_info_show(struct seq_file *seq, void *v)
 			nr->window,
 			sk_wmem_alloc_get(s),
 			sk_rmem_alloc_get(s),
-			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : 0L);
+			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : (kino_t)0);
 
 		bh_unlock_sock(s);
 	}
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 841d62481048def8d800779efb6e4ea8cbe419fe..ceef3e801030d4782b3d05374b6ef48a9d544b14 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1479,7 +1479,7 @@ static int rose_info_show(struct seq_file *seq, void *v)
 			callsign = ax2asc(buf, &rose->source_call);
 
 		seq_printf(seq,
-			   "%-10s %-9s %-5s %3.3X %05d  %d  %d  %d  %d %3lu %3lu %3lu %3lu %3lu %3lu/%03lu %5d %5d %ld\n",
+			   "%-10s %-9s %-5s %3.3X %05d  %d  %d  %d  %d %3lu %3lu %3lu %3lu %3lu %3lu/%03lu %5d %5d %" PRIino "u\n",
 			rose2asc(rsbuf, &rose->source_addr),
 			callsign,
 			devname,
@@ -1498,7 +1498,7 @@ static int rose_info_show(struct seq_file *seq, void *v)
 			rose->idle / (60 * HZ),
 			sk_wmem_alloc_get(s),
 			sk_rmem_alloc_get(s),
-			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : 0L);
+			s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : (kino_t)0);
 	}
 
 	return 0;
diff --git a/net/x25/x25_proc.c b/net/x25/x25_proc.c
index 0412814a2295bba5e26f4c95697ef7b7ba5fb34f..196e1850e925e4034b2ac71df151b9b953fb2570 100644
--- a/net/x25/x25_proc.c
+++ b/net/x25/x25_proc.c
@@ -96,7 +96,7 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
 		devname = x25->neighbour->dev->name;
 
 	seq_printf(seq, "%-10s %-10s %-5s %3.3X  %d  %d  %d  %d %3lu %3lu "
-			"%3lu %3lu %3lu %5d %5d %ld\n",
+			"%3lu %3lu %3lu %5d %5d %" PRIino "u\n",
 		   !x25->dest_addr.x25_addr[0] ? "*" : x25->dest_addr.x25_addr,
 		   !x25->source_addr.x25_addr[0] ? "*" : x25->source_addr.x25_addr,
 		   devname, x25->lci & 0x0FFF, x25->state, x25->vs, x25->vr,
@@ -104,7 +104,7 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
 		   x25->t21 / HZ, x25->t22 / HZ, x25->t23 / HZ,
 		   sk_wmem_alloc_get(s),
 		   sk_rmem_alloc_get(s),
-		   s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : 0L);
+		   s->sk_socket ? SOCK_INODE(s->sk_socket)->i_ino : (kino_t)0);
 out:
 	return 0;
 }

-- 
2.53.0


