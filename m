Return-Path: <linux-fsdevel+bounces-78967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHEzKLf4pWlGIgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:53:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FA1E1028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3B03306294A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24314481FB5;
	Mon,  2 Mar 2026 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZESrDHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D0423A6B;
	Mon,  2 Mar 2026 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483187; cv=none; b=bzvqizxB9mTpE9tbbPP/p2lBhUQ+rBuWjPjLPyKIshXeaf8nLbho5KpMrw+aHew5NbLdv47K0RPQlWZ7HxqDEdOLbtHDL5YZOBqQDpTJqrzSNQB8eo9lfML9XJFa9mmORRIS+P2g3cjwubICqMFvNLJ8AgCzPz/Rj6bCMbvwoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483187; c=relaxed/simple;
	bh=eoNvK5Yl7SeIQgq9YrEwF9MuEybDgaw/cGTOe/274yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTj6HgMNhR4FH+K+hB3nyLxr6mKA0nIBPJAUmS1IUsNdgpwL1lDx0BW6y7rAnrOhw8S361C+lw3TxtPRe+T0NoepaEJXK0J6E4CzckIsQjFCo2EvOJIdJBUE8XyspKtqBMgU7ZDjtx0yIk4QI2KXwhq0yqBk9/E4N8oNG3DArGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZESrDHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16CCC2BCB8;
	Mon,  2 Mar 2026 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483187;
	bh=eoNvK5Yl7SeIQgq9YrEwF9MuEybDgaw/cGTOe/274yY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gZESrDHFBopSybBDaCrr/gadYhHmmqGteyjtsyw9Pv1m1XE6MLR/cdhwN0RnwNFCX
	 QPrCN5JSpeWOwodlWI4OQoNjzrc5vHUaGjO2R8dzz/MOqJGKpmclBoUCuwxHU3vGCL
	 +70+lpClDBk9cuezXISD0YdDWnhmpbXqHaFyn5wOKnrl1NqphXwc9iKmGSfeqobEi1
	 l6maOnpOdK1oOk8r8/lcVzrZtBYJX61HKxrTgPal3sbXhizaPR33lnmh/tdmaWhaLj
	 hEnaPacjOr2dqigfZtNesqwNm+Yl1BP/O5LbH0tfBVx/U5/dXCsco+Za3w/B6J8LkS
	 mtYyh35Kv+06A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:23:50 -0500
Subject: [PATCH v2 006/110] trace: reorder TP_STRUCT__entry fields for
 better packing on 32-bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-6-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13682; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eoNvK5Yl7SeIQgq9YrEwF9MuEybDgaw/cGTOe/274yY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfHwneWwRCtH37qDPSjc8Wo97edXJDLDHXsih
 RCid9s596mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx8AAKCRAADmhBGVaC
 FeXoD/40MQDB8ZGY3bAmS4aZn5ULoTZ7fhEUkxxa3aguvcw00rG2zuF/QNLGsDtg4gEE1YIGOg7
 xDxs5j4PXMy+C+Snbg5wk+/G/TXdL98RBqUJeZAsaVfQ+C+vVeuowoIxyY5WtgZmXVdQjwQrRbZ
 Tnz0m6PdPeWy/iwJGXMpG26DhkYKaKpFaC/D8alFD7tZqrIQhBeL3/HJTevsTAJJUQr19ohUjFY
 vhqACbzEwStOkD7DyJHw+1pYJTP2uT3IzOgAgiROmYyrGW8F8TwjIjrRp66I1Ov0fnjPSPzkJst
 9+yium6UMI+Oup1WDiyc9FXahpKE1uX3b5kyPOlnUeO7oirOc7www3Cyp6L+tNhMfUB5aT4F7VK
 +CMvIKE2OX+IaN/pMOKc48PLUb3GwfVRMjz/Marq/QE2hMuuNWlWVuO7eI0MVk3MtXxeUC0/Puk
 w7sX4hWrKYPEO6rr/KdhRp5biPoU7ezh520WhVEWmCjAQ5jHs7aibCAk+q/TUjXMp5Nuvq8ON1E
 1MigX6VhzzLKer3JNYYOGpndOkW5GlfF3gp/35EeeOa72WEkbs0B+VRblNznDCUD7KDC51pQUci
 m14ODDyp/XhBlXNdVLeMolvVzZBv5q2BWwD+8uhjnUY/clrz9z7+e4IgpcRcVK21zO959Q9AD7q
 idB+xSxglbMDOWw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 485FA1E1028
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
	TAGGED_FROM(0.00)[bounces-78967-lists,linux-fsdevel=lfdr.de];
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

The recent conversion of ino_t/unsigned long inode number fields to u64
in VFS-layer trace events can leave alignment holes on 32-bit platforms
(particularly ARM, where u64 has 8-byte alignment). Reorder the
TP_STRUCT__entry fields so that 64-bit integer fields (u64, loff_t,
time64_t) come first, followed by pointers and unsigned longs, then
integer-sized and smaller fields.

This eliminates padding holes on 32-bit without worsening packing on
64-bit. Only the field declaration order in TP_STRUCT__entry is changed;
TP_fast_assign and TP_printk reference fields by name and are unaffected.

Files affected: cachefiles.h, filelock.h, filemap.h, hugetlbfs.h,
readahead.h, timestamp.h, writeback.h.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/cachefiles.h | 10 +++++-----
 include/trace/events/filelock.h   | 22 +++++++++++-----------
 include/trace/events/filemap.h    |  4 ++--
 include/trace/events/hugetlbfs.h  | 18 +++++++++---------
 include/trace/events/readahead.h  |  6 +++---
 include/trace/events/timestamp.h  |  6 +++---
 include/trace/events/writeback.h  | 32 ++++++++++++++++----------------
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index f967027711ee823f224abc1b8ab03f63da06ae6f..6e3b1424eea4dc9e414dd9d1439339132d516339 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -249,10 +249,10 @@ TRACE_EVENT(cachefiles_lookup,
 	    TP_ARGS(obj, dir, de),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj)
-		    __field(short,			error)
 		    __field(u64,			dino)
 		    __field(u64,			ino)
+		    __field(unsigned int,		obj)
+		    __field(short,			error)
 			     ),
 
 	    TP_fast_assign(
@@ -578,8 +578,8 @@ TRACE_EVENT(cachefiles_mark_active,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj)
 		    __field(u64,			inode)
+		    __field(unsigned int,		obj)
 			     ),
 
 	    TP_fast_assign(
@@ -599,8 +599,8 @@ TRACE_EVENT(cachefiles_mark_failed,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj)
 		    __field(u64,			inode)
+		    __field(unsigned int,		obj)
 			     ),
 
 	    TP_fast_assign(
@@ -620,8 +620,8 @@ TRACE_EVENT(cachefiles_mark_inactive,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj)
 		    __field(u64,			inode)
+		    __field(unsigned int,		obj)
 			     ),
 
 	    TP_fast_assign(
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 41bc752616b25d6cd7955203e2c604029d0b440c..1167748862449ef6ff04c40b568ea8c3bbb08207 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -43,9 +43,9 @@ TRACE_EVENT(locks_get_lock_context,
 
 	TP_STRUCT__entry(
 		__field(u64, i_ino)
+		__field(struct file_lock_context *, ctx)
 		__field(dev_t, s_dev)
 		__field(unsigned char, type)
-		__field(struct file_lock_context *, ctx)
 	),
 
 	TP_fast_assign(
@@ -66,16 +66,16 @@ DECLARE_EVENT_CLASS(filelock_lock,
 	TP_ARGS(inode, fl, ret),
 
 	TP_STRUCT__entry(
-		__field(struct file_lock *, fl)
 		__field(u64, i_ino)
-		__field(dev_t, s_dev)
+		__field(loff_t, fl_start)
+		__field(loff_t, fl_end)
+		__field(struct file_lock *, fl)
 		__field(struct file_lock_core *, blocker)
 		__field(fl_owner_t, owner)
+		__field(dev_t, s_dev)
 		__field(unsigned int, pid)
 		__field(unsigned int, flags)
 		__field(unsigned char, type)
-		__field(loff_t, fl_start)
-		__field(loff_t, fl_end)
 		__field(int, ret)
 	),
 
@@ -123,15 +123,15 @@ DECLARE_EVENT_CLASS(filelock_lease,
 	TP_ARGS(inode, fl),
 
 	TP_STRUCT__entry(
-		__field(struct file_lease *, fl)
 		__field(u64, i_ino)
-		__field(dev_t, s_dev)
+		__field(struct file_lease *, fl)
 		__field(struct file_lock_core *, blocker)
 		__field(fl_owner_t, owner)
-		__field(unsigned int, flags)
-		__field(unsigned char, type)
 		__field(unsigned long, break_time)
 		__field(unsigned long, downgrade_time)
+		__field(dev_t, s_dev)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
 	),
 
 	TP_fast_assign(
@@ -176,11 +176,11 @@ TRACE_EVENT(generic_add_lease,
 
 	TP_STRUCT__entry(
 		__field(u64, i_ino)
+		__field(fl_owner_t, owner)
+		__field(dev_t, s_dev)
 		__field(int, wcount)
 		__field(int, rcount)
 		__field(int, icount)
-		__field(dev_t, s_dev)
-		__field(fl_owner_t, owner)
 		__field(unsigned int, flags)
 		__field(unsigned char, type)
 	),
diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 153491e57cce6df73e30ddee60a52ed7d8923c24..4dcf8e9e2e0d8bde7c9df9856c059d2cdebff59f 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -20,8 +20,8 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
 	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, pfn)
 		__field(u64, i_ino)
+		__field(unsigned long, pfn)
 		__field(unsigned long, index)
 		__field(dev_t, s_dev)
 		__field(unsigned char, order)
@@ -171,8 +171,8 @@ TRACE_EVENT(file_check_and_advance_wb_err,
 		TP_ARGS(file, old),
 
 		TP_STRUCT__entry(
-			__field(struct file *, file)
 			__field(u64, i_ino)
+			__field(struct file *, file)
 			__field(dev_t, s_dev)
 			__field(errseq_t, old)
 			__field(errseq_t, new)
diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
index d4fefa571b829f92729c7e175df9ad5ed701131a..8ba72c1d4f4d8ba616906be5b5c4b487972fec00 100644
--- a/include/trace/events/hugetlbfs.h
+++ b/include/trace/events/hugetlbfs.h
@@ -14,9 +14,9 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
 	TP_ARGS(inode, dir, mode),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
 		__field(u64,		dir)
+		__field(dev_t,		dev)
 		__field(__u16,		mode)
 	),
 
@@ -40,13 +40,13 @@ DECLARE_EVENT_CLASS(hugetlbfs__inode,
 	TP_ARGS(inode),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
-		__field(__u16,		mode)
 		__field(loff_t,		size)
+		__field(blkcnt_t,	blocks)
+		__field(dev_t,		dev)
 		__field(unsigned int,	nlink)
 		__field(unsigned int,	seals)
-		__field(blkcnt_t,	blocks)
+		__field(__u16,		mode)
 	),
 
 	TP_fast_assign(
@@ -87,14 +87,14 @@ TRACE_EVENT(hugetlbfs_setattr,
 	TP_ARGS(inode, dentry, attr),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
+		__field(loff_t,		old_size)
+		__field(loff_t,		ia_size)
+		__field(dev_t,		dev)
 		__field(unsigned int,	d_len)
 		__string(d_name,	dentry->d_name.name)
 		__field(unsigned int,	ia_valid)
 		__field(unsigned int,	ia_mode)
-		__field(loff_t,		old_size)
-		__field(loff_t,		ia_size)
 	),
 
 	TP_fast_assign(
@@ -122,12 +122,12 @@ TRACE_EVENT(hugetlbfs_fallocate,
 	TP_ARGS(inode, mode, offset, len, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
-		__field(int,		mode)
 		__field(loff_t,		offset)
 		__field(loff_t,		len)
 		__field(loff_t,		size)
+		__field(dev_t,		dev)
+		__field(int,		mode)
 		__field(int,		ret)
 	),
 
diff --git a/include/trace/events/readahead.h b/include/trace/events/readahead.h
index 928b2c67654735cc004d27beeee2066196e60a70..087f171e2b02d30f09179d5ed6c27a7e0224370b 100644
--- a/include/trace/events/readahead.h
+++ b/include/trace/events/readahead.h
@@ -81,15 +81,15 @@ DECLARE_EVENT_CLASS(page_cache_ra_op,
 
 	TP_STRUCT__entry(
 		__field(u64, i_ino)
-		__field(dev_t, s_dev)
+		__field(loff_t, prev_pos)
 		__field(pgoff_t, index)
+		__field(unsigned long, req_count)
+		__field(dev_t, s_dev)
 		__field(unsigned int, order)
 		__field(unsigned int, size)
 		__field(unsigned int, async_size)
 		__field(unsigned int, ra_pages)
 		__field(unsigned int, mmap_miss)
-		__field(loff_t, prev_pos)
-		__field(unsigned long, req_count)
 	),
 
 	TP_fast_assign(
diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
index 315ea8d57796617661768da24591d53095ac7649..d6503612dddf9c6a2f785fad549fa04adddb06fe 100644
--- a/include/trace/events/timestamp.h
+++ b/include/trace/events/timestamp.h
@@ -18,9 +18,9 @@ DECLARE_EVENT_CLASS(ctime,
 	TP_ARGS(inode, ctime),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
 		__field(time64_t,	ctime_s)
+		__field(dev_t,		dev)
 		__field(u32,		ctime_ns)
 		__field(u32,		gen)
 	),
@@ -58,8 +58,8 @@ TRACE_EVENT(ctime_ns_xchg,
 	TP_ARGS(inode, old, new, cur),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
+		__field(dev_t,		dev)
 		__field(u32,		gen)
 		__field(u32,		old)
 		__field(u32,		new)
@@ -93,10 +93,10 @@ TRACE_EVENT(fill_mg_cmtime,
 	TP_ARGS(inode, ctime, mtime),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
 		__field(u64,		ino)
 		__field(time64_t,	ctime_s)
 		__field(time64_t,	mtime_s)
+		__field(dev_t,		dev)
 		__field(u32,		ctime_ns)
 		__field(u32,		mtime_ns)
 		__field(u32,		gen)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index ad269142f3f9a288d87e5252f08e8a17fd06e8d5..e5cd2b80fd29dba9177b8ea7c37d63e50e9f60e2 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -280,9 +280,9 @@ TRACE_EVENT(track_foreign_dirty,
 		__array(char,		name, 32)
 		__field(u64,		bdi_id)
 		__field(u64,		ino)
-		__field(unsigned int,	memcg_id)
 		__field(u64,		cgroup_ino)
 		__field(u64,		page_cgroup_ino)
+		__field(unsigned int,	memcg_id)
 	),
 
 	TP_fast_assign(
@@ -346,8 +346,8 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 	TP_STRUCT__entry (
 		__array(char, name, 32)
 		__field(u64, ino)
-		__field(int, sync_mode)
 		__field(u64, cgroup_ino)
+		__field(int, sync_mode)
 	),
 
 	TP_fast_assign(
@@ -385,6 +385,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 	TP_ARGS(wb, work),
 	TP_STRUCT__entry(
 		__array(char, name, 32)
+		__field(u64, cgroup_ino)
 		__field(long, nr_pages)
 		__field(dev_t, sb_dev)
 		__field(int, sync_mode)
@@ -392,7 +393,6 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__field(int, range_cyclic)
 		__field(int, for_background)
 		__field(int, reason)
-		__field(u64, cgroup_ino)
 	),
 	TP_fast_assign(
 		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
@@ -482,15 +482,15 @@ DECLARE_EVENT_CLASS(wbc_class,
 	TP_ARGS(wbc, bdi),
 	TP_STRUCT__entry(
 		__array(char, name, 32)
+		__field(u64, cgroup_ino)
 		__field(long, nr_to_write)
 		__field(long, pages_skipped)
+		__field(long, range_start)
+		__field(long, range_end)
 		__field(int, sync_mode)
 		__field(int, for_kupdate)
 		__field(int, for_background)
 		__field(int, range_cyclic)
-		__field(long, range_start)
-		__field(long, range_end)
-		__field(u64, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -535,11 +535,11 @@ TRACE_EVENT(writeback_queue_io,
 	TP_ARGS(wb, work, dirtied_before, moved),
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
+		__field(u64,		cgroup_ino)
 		__field(unsigned long,	older)
 		__field(long,		age)
 		__field(int,		moved)
 		__field(int,		reason)
-		__field(u64,		cgroup_ino)
 	),
 	TP_fast_assign(
 		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
@@ -614,13 +614,13 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 
 	TP_STRUCT__entry(
 		__array(char,		bdi, 32)
+		__field(u64,		cgroup_ino)
 		__field(unsigned long,	write_bw)
 		__field(unsigned long,	avg_write_bw)
 		__field(unsigned long,	dirty_rate)
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned long,	balanced_dirty_ratelimit)
-		__field(u64,		cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -667,6 +667,7 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_STRUCT__entry(
 		__array(	 char,	bdi, 32)
+		__field(u64,		cgroup_ino)
 		__field(unsigned long,	limit)
 		__field(unsigned long,	setpoint)
 		__field(unsigned long,	dirty)
@@ -674,13 +675,12 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(unsigned long,	wb_dirty)
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
-		__field(unsigned int,	dirtied)
-		__field(unsigned int,	dirtied_pause)
 		__field(unsigned long,	paused)
 		__field(	 long,	pause)
 		__field(unsigned long,	period)
 		__field(	 long,	think)
-		__field(u64,		cgroup_ino)
+		__field(unsigned int,	dirtied)
+		__field(unsigned int,	dirtied_pause)
 	),
 
 	TP_fast_assign(
@@ -738,9 +738,9 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 	TP_STRUCT__entry(
 		__array(char, name, 32)
 		__field(u64, ino)
+		__field(u64, cgroup_ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
-		__field(u64, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -774,12 +774,12 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 	TP_STRUCT__entry(
 		__array(char, name, 32)
 		__field(u64, ino)
+		__field(u64, cgroup_ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
 		__field(unsigned long, writeback_index)
-		__field(long, nr_to_write)
 		__field(unsigned long, wrote)
-		__field(u64, cgroup_ino)
+		__field(long, nr_to_write)
 	),
 
 	TP_fast_assign(
@@ -828,11 +828,11 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 	TP_ARGS(inode),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
 		__field(	u64,	ino			)
 		__field(unsigned long,	state			)
-		__field(	__u16, mode			)
 		__field(unsigned long, dirtied_when		)
+		__field(	dev_t,	dev			)
+		__field(	__u16, mode			)
 	),
 
 	TP_fast_assign(

-- 
2.53.0


