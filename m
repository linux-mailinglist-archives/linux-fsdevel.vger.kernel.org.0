Return-Path: <linux-fsdevel+bounces-79414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOm6LA5XqGlutQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:00:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933920388D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23CB931C2F10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784734EF17;
	Wed,  4 Mar 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbxvm05x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EB8347BD1;
	Wed,  4 Mar 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638422; cv=none; b=uoxo6LfbWl/lQFSbG0gWXXsqSpt4wPnkDbyAEDIQoX/UiHF+CCBrGEcqtQvGxavUEZLlS+o1knZTigGlXXqlN+OYQPNFe8STbZnKh0kW+BSAUtsPdaHwPBUyBk4UbVudVlg/fQ/GJk2tgtl06WrNaLUz5Gb7cOBpDPizNgYP0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638422; c=relaxed/simple;
	bh=ciNSSeLqRr2BU//qa+tQIIiBFv/zr4BgDhwVpMxT7rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJNAL5AH2WH3+20yY5/HGTjAlRM9Sh9cF8bZrmAR7y0E0J2i4CBfhxVESl6cgE7G17l75CV0dHX6MffFYna8028VFt2iF54nCD849Wu2d+jhtXQFkdjtQvpnnm/KVajAOVvco6EdZNoVL+8//Mnd5VJIGz/fB01/e8C9GxXjamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbxvm05x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C4C2BC9E;
	Wed,  4 Mar 2026 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638421;
	bh=ciNSSeLqRr2BU//qa+tQIIiBFv/zr4BgDhwVpMxT7rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kbxvm05xEkrnY8P/tRyCMTKI2dUt9lQTIT87tn/iqa5xj1Nf4RVNN4IeFKVK+/i/h
	 cCuy6DwK5kf0eHpADxr0uui0yqClmO5RzkQiq+hiarKU0R9OfrTxCwrwsL2U5WPKb4
	 x/cVNwHwTbJsERVnOUQYRWWB4zPSvs4XPwm7hmk8yYB5N0WOdQuw6QOCEo+Skehnll
	 dfh6gHvSqguhj6ATJwi/mNVwCQQzvf72au7kSngXMugLBZnGpF8EOy2i2TV7CENRqy
	 jz50pLi1cAo9FJqFzmNNlLuh7Pki4UWyeJO5/COBPnM7ZAH+6PYUsHHCQ7S8ZK9Gnl
	 4asDv/cQsr6PQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Mar 2026 10:32:32 -0500
Subject: [PATCH v3 02/12] audit: widen ino fields to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-iino-u64-v3-2-2257ad83d372@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7545; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ciNSSeLqRr2BU//qa+tQIIiBFv/zr4BgDhwVpMxT7rs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqFCmqmFUMh1WlR9KQ8rb35f1AaC/6SMNRQit0
 fpl2asozXeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaahQpgAKCRAADmhBGVaC
 FRYoD/wIBIrwGcTFOF41QzahbNDfzFpIV1/911ZWCrCmpN5O+1eeArtgs+fVyy3nEcn3GQZxSGj
 WDZ39Hlt2l5zY+WDTLYGDWamaLGGS+kuyYR2cMBfMiUZj3a/8p4EoRSUaTQuXMSWwk50Uov+AK1
 oLRlw6CiPmuPnGNbpn1YN4jSwDBtsw0Yqf1uDpc0fh579gtJlJyJWBsZYEZ1tgF4tpkEloDsqw1
 cAeE3PWIwMNKY3kM5Ly9ugLsJLpHD2UmlqV7zTLFfEHpXWsN/m4RmjNGfHS2ZMYZzoFtjVdEFG4
 yw4OnUx81ZlFYLw6Jlf7JX98hoPGdMu/l1Wz4dqebVX6JjJ8s07kW2ifdUdT4sOPRGR2BlAfgRG
 Hhys286dKG09WzHbXfCWTThcGfox2fXbblbyIsM6NprJfyLfJPmJbR/0cXvC0uMA94qtxWaJNA+
 AzqK8pog0HLa5WfBVdgYqC/PNUTGvfeqCK/DygdkbqgOP6URRThg9ui0oaDb8Xr98rM/pZGWots
 1C/rGVrQkpTfQa1osFjKA6GjXKIP6yJ7prSYAZRi9hFHwHCg+OGxvu4xldqyQ5fDMHNgu1tcNuL
 OxqY317DSUySNeD/EGUxR/wbyIFVZFpxmB0oj2j6/GMVSnZ8WQxq8NBWlbXYlmwHQw92HJz4oSy
 nvMId++sLPZY57A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 1933920388D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79414-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

inode->i_ino is being widened from unsigned long to u64. The audit
subsystem uses unsigned long ino in struct fields, function parameters,
and local variables that store inode numbers from arbitrary filesystems.
On 32-bit platforms this truncates inode numbers that exceed 32 bits,
which will cause incorrect audit log entries and broken watch/mark
comparisons.

Widen all audit ino fields, parameters, and locals to u64, and update
the inode format string from %lu to %llu to match.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/audit.h   |  2 +-
 kernel/audit.h          | 13 ++++++-------
 kernel/audit_fsnotify.c |  4 ++--
 kernel/audit_watch.c    | 12 ++++++------
 kernel/auditsc.c        |  4 ++--
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b642b5faca654c8465b6839c32b633426e1d3d9a..b915aaa7ed7399a6e453b1bb9bacbda686028638 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -15,7 +15,7 @@
 #include <uapi/linux/audit.h>
 #include <uapi/linux/fanotify.h>
 
-#define AUDIT_INO_UNSET ((unsigned long)-1)
+#define AUDIT_INO_UNSET ((u64)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
 
 struct audit_sig_info {
diff --git a/kernel/audit.h b/kernel/audit.h
index 7c401729e21bbcb062e2d5f3059d4496ed83529b..ac81fa02bcd7501e31461a346c4e599841525001 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -76,7 +76,7 @@ struct audit_names {
 	int			name_len;	/* number of chars to log */
 	bool			hidden;		/* don't log this record */
 
-	unsigned long		ino;
+	u64			ino;
 	dev_t			dev;
 	umode_t			mode;
 	kuid_t			uid;
@@ -225,9 +225,9 @@ extern int auditd_test_task(struct task_struct *task);
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
 
-static inline int audit_hash_ino(u32 ino)
+static inline int audit_hash_ino(u64 ino)
 {
-	return (ino & (AUDIT_INODE_BUCKETS-1));
+	return ((u32)ino & (AUDIT_INODE_BUCKETS-1));
 }
 
 /* Indicates that audit should log the full pathname. */
@@ -277,16 +277,15 @@ extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
 extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
 extern void audit_remove_watch_rule(struct audit_krule *krule);
 extern char *audit_watch_path(struct audit_watch *watch);
-extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
-			       dev_t dev);
+extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
 						    char *pathname, int len);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
-extern int audit_mark_compare(struct audit_fsnotify_mark *mark,
-			      unsigned long ino, dev_t dev);
+extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
+			      dev_t dev);
 extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
 extern int audit_exe_compare(struct task_struct *tsk,
 			     struct audit_fsnotify_mark *mark);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index a4401f6510608119fd928944c36103326475e3b2..711454f9f7242847f78e7eeed92db7a66be265e6 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -25,7 +25,7 @@
  */
 struct audit_fsnotify_mark {
 	dev_t dev;		/* associated superblock device */
-	unsigned long ino;	/* associated inode number */
+	u64 ino;		/* associated inode number */
 	char *path;		/* insertion path */
 	struct fsnotify_mark mark; /* fsnotify mark on the inode */
 	struct audit_krule *rule;
@@ -57,7 +57,7 @@ char *audit_mark_path(struct audit_fsnotify_mark *mark)
 	return mark->path;
 }
 
-int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev)
+int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino, dev_t dev)
 {
 	if (mark->ino == AUDIT_INO_UNSET)
 		return 0;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 096faac2435ce2b3741fb1f623ea7fab65ae7a07..33577f0f54eff1eafe48a94dd2839b00fe7dffcc 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -37,7 +37,7 @@ struct audit_watch {
 	refcount_t		count;	/* reference count */
 	dev_t			dev;	/* associated superblock device */
 	char			*path;	/* insertion path */
-	unsigned long		ino;	/* associated inode number */
+	u64			ino;	/* associated inode number */
 	struct audit_parent	*parent; /* associated parent */
 	struct list_head	wlist;	/* entry in parent->watches list */
 	struct list_head	rules;	/* anchor for krule->rlist */
@@ -125,7 +125,7 @@ char *audit_watch_path(struct audit_watch *watch)
 	return watch->path;
 }
 
-int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
+int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev)
 {
 	return (watch->ino != AUDIT_INO_UNSET) &&
 		(watch->ino == ino) &&
@@ -244,7 +244,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       unsigned long ino, unsigned invalidating)
+			       u64 ino, unsigned invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -285,7 +285,7 @@ static void audit_update_watch(struct audit_parent *parent,
 				list_del(&oentry->rule.list);
 				audit_panic("error updating watch, removing");
 			} else {
-				int h = audit_hash_ino((u32)ino);
+				int h = audit_hash_ino(ino);
 
 				/*
 				 * nentry->rule.watch == oentry->rule.watch so
@@ -439,7 +439,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 
 	audit_add_to_parent(krule, parent);
 
-	h = audit_hash_ino((u32)watch->ino);
+	h = audit_hash_ino(watch->ino);
 	*list = &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
@@ -527,7 +527,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 {
 	struct file *exe_file;
-	unsigned long ino;
+	u64 ino;
 	dev_t dev;
 
 	/* only do exe filtering if we are recording @current events/records */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index f6af6a8f68c4f6d14d9a899934138df2036e1f9a..ab54fccba215ca61d56335d1a22a7f26297e28ee 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -886,7 +886,7 @@ static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
 				   struct audit_context *ctx)
 {
-	int h = audit_hash_ino((u32)n->ino);
+	int h = audit_hash_ino(n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 
 	return __audit_filter_op(tsk, ctx, list, n, ctx->major);
@@ -1534,7 +1534,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+		audit_log_format(ab, " inode=%llu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
 				 n->ino,
 				 MAJOR(n->dev),
 				 MINOR(n->dev),

-- 
2.53.0


