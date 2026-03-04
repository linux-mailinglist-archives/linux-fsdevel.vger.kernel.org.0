Return-Path: <linux-fsdevel+bounces-79419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNUWEdRTqGlBtQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:46:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4E203273
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95DC325C671
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C935E942;
	Wed,  4 Mar 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXE2Q9Ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BB34A78E;
	Wed,  4 Mar 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638495; cv=none; b=gbE14PTTfNS9aOwEFFHy3NNXheD9gfLw+/UA9Zxa/1Q11zSDbZPpK84G4FX/e/CjiabUXN9S+AY2aPSCzSnz60XpFi+9olzGOPjdvJ/Xnc/FzgBmdH1RynBPyvXFw05iqc1+mN0RJ2ANQ22GeVa7a3lvW8IDtQ9IlLk5bVulDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638495; c=relaxed/simple;
	bh=pfzMsOYRRPF1Omutl9Wzsj/v4OymtZsNcWF1In5v5f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUBcGwuFKNzRay2f6w8poeoDMQY1A4h7zUtAMtWl7210yqrHWvN2Z8RvhBDU7MqZuZBOk5TPkwRLTeJbTHTkYute8WaCIYmv7rFZXdeLYa31cRJSz1w30LRvFu3XIdrokg5NMYP1kgjs+mBPmxMQPizB2JuSOzqMMl25WPvCbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXE2Q9Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8107C4CEF7;
	Wed,  4 Mar 2026 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638495;
	bh=pfzMsOYRRPF1Omutl9Wzsj/v4OymtZsNcWF1In5v5f8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tXE2Q9Ks2tkr375jZM52XmqFW0dn4JFmjuPn8LXDtk5D7XMH59EhbjF03E9DE4r2E
	 gESzdIumn/zSP8x3m8O5EOhWEJ1PjI8sROJeijvBUq+G602kHEKVZxOS5WlJZNiWEf
	 ysRfjxi9BHPmqmS9dLRKqgMNSjXWATww45sgbmyGGDO8n7XbN/jhFWZE+M0aWj3bvM
	 s5t4TYxrzdFbuX+ueygZDOGwv3Mi1ZD4j1+PCFY+du7X0OBhU96G127FDCcjySRWvC
	 WIc0YnB4HSCQEjbjImNyUaBw57icPjynkldyyExeBFZO1uf4X3S3rY5+5Y1qsIUtqm
	 i6g8FzsZHvZJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Mar 2026 10:32:37 -0500
Subject: [PATCH v3 07/12] hugetlbfs: widen trace event i_ino fields to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-iino-u64-v3-7-2257ad83d372@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4105; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pfzMsOYRRPF1Omutl9Wzsj/v4OymtZsNcWF1In5v5f8=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGmoUKih/b5XA4c12kwIo+94gsSuVqUY2ifrVzx7MIWmY4czq
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpqFCoAAoJEAAOaEEZVoIVtqwQAI2c
 nH8OLzbicVfCcwgT7n9P6M7t4O0jSoWkDpkOnW5uYzqadeBA7vXo3g4BVSTLUJTJGhMeMweBvMu
 wH6JnBGvFz9DQEnzycO/ts0dx7ctK6deENDyfiOw9xFtL88u95GyKJjrYCaI/R03odStLCgqKrO
 QydS/H+pDQ2986UiMfvZTX4iAM5ryA/1uRe0l1r4DntVr8/+P+ybXJfTPyzlci6ZMeeghkP03xr
 oePUF31usdtfeIwplbBoulNZBxyw0y2oYwmJd5rsjUWZbJ8DbdA+l2uGiEtnmvVQn4dkIblbHe3
 V8aAH1URKwwhIL6G4fTGY0i1UBhoccOS6X+a+JjlUIcGlPfleEuFusJaHzOcZNFG3Gdw6QRGpoi
 1W2N4QxdTqf6p3nwR4YELtFb2nWku6JRQUDiaHFELUkJSvwulAEBKgsPG8/Ddz6j2WoG/hazUY8
 mq6O4ZWbELtD1YqMi1nHbULvdEFBnRs1ZsAPHj09vlo5lMcbOienETuTNJEt3UAmNRLrgL5Qae9
 BlADi29P9GjnWuXLT9mW6acwjHJcr9rQ77jl4t9e+pHXoDxfMf6RSgmbvxBkOkQRdcHa84Mfm6w
 Z427ySavl0tSQY8pC+9+ItSH4jPhpAqZXVEizDM6HQ6n1p6bYqMJRtxG85bUM9qJgduPP0ft2Fk
 oPpfe
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 9CC4E203273
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
	TAGGED_FROM(0.00)[bounces-79419-lists,linux-fsdevel=lfdr.de];
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

Update hugetlbfs trace event definitions to use u64 instead of
ino_t/unsigned long for inode number fields.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/hugetlbfs.h | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
index 59605dfaeeb43d9e7657e338fdbe740e8486a286..8ba72c1d4f4d8ba616906be5b5c4b487972fec00 100644
--- a/include/trace/events/hugetlbfs.h
+++ b/include/trace/events/hugetlbfs.h
@@ -14,9 +14,9 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
 	TP_ARGS(inode, dir, mode),
 
 	TP_STRUCT__entry(
+		__field(u64,		ino)
+		__field(u64,		dir)
 		__field(dev_t,		dev)
-		__field(ino_t,		ino)
-		__field(ino_t,		dir)
 		__field(__u16,		mode)
 	),
 
@@ -27,10 +27,10 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
 		__entry->mode		= mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu dir %lu mode 0%o",
+	TP_printk("dev %d,%d ino %llu dir %llu mode 0%o",
 		MAJOR(__entry->dev), MINOR(__entry->dev),
-		(unsigned long) __entry->ino,
-		(unsigned long) __entry->dir, __entry->mode)
+		__entry->ino,
+		__entry->dir, __entry->mode)
 );
 
 DECLARE_EVENT_CLASS(hugetlbfs__inode,
@@ -40,13 +40,13 @@ DECLARE_EVENT_CLASS(hugetlbfs__inode,
 	TP_ARGS(inode),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
-		__field(ino_t,		ino)
-		__field(__u16,		mode)
+		__field(u64,		ino)
 		__field(loff_t,		size)
+		__field(blkcnt_t,	blocks)
+		__field(dev_t,		dev)
 		__field(unsigned int,	nlink)
 		__field(unsigned int,	seals)
-		__field(blkcnt_t,	blocks)
+		__field(__u16,		mode)
 	),
 
 	TP_fast_assign(
@@ -59,8 +59,8 @@ DECLARE_EVENT_CLASS(hugetlbfs__inode,
 		__entry->blocks		= inode->i_blocks;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o size %lld nlink %u seals %u blocks %llu",
-		MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long) __entry->ino,
+	TP_printk("dev %d,%d ino %llu mode 0%o size %lld nlink %u seals %u blocks %llu",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
 		__entry->mode, __entry->size, __entry->nlink, __entry->seals,
 		(unsigned long long)__entry->blocks)
 );
@@ -87,14 +87,14 @@ TRACE_EVENT(hugetlbfs_setattr,
 	TP_ARGS(inode, dentry, attr),
 
 	TP_STRUCT__entry(
+		__field(u64,		ino)
+		__field(loff_t,		old_size)
+		__field(loff_t,		ia_size)
 		__field(dev_t,		dev)
-		__field(ino_t,		ino)
 		__field(unsigned int,	d_len)
 		__string(d_name,	dentry->d_name.name)
 		__field(unsigned int,	ia_valid)
 		__field(unsigned int,	ia_mode)
-		__field(loff_t,		old_size)
-		__field(loff_t,		ia_size)
 	),
 
 	TP_fast_assign(
@@ -108,8 +108,8 @@ TRACE_EVENT(hugetlbfs_setattr,
 		__entry->ia_size	= attr->ia_size;
 	),
 
-	TP_printk("dev %d,%d ino %lu name %.*s valid %#x mode 0%o old_size %lld size %lld",
-		MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long)__entry->ino,
+	TP_printk("dev %d,%d ino %llu name %.*s valid %#x mode 0%o old_size %lld size %lld",
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
 		__entry->d_len, __get_str(d_name), __entry->ia_valid, __entry->ia_mode,
 		__entry->old_size, __entry->ia_size)
 );
@@ -122,12 +122,12 @@ TRACE_EVENT(hugetlbfs_fallocate,
 	TP_ARGS(inode, mode, offset, len, ret),
 
 	TP_STRUCT__entry(
-		__field(dev_t,		dev)
-		__field(ino_t,		ino)
-		__field(int,		mode)
+		__field(u64,		ino)
 		__field(loff_t,		offset)
 		__field(loff_t,		len)
 		__field(loff_t,		size)
+		__field(dev_t,		dev)
+		__field(int,		mode)
 		__field(int,		ret)
 	),
 
@@ -141,9 +141,9 @@ TRACE_EVENT(hugetlbfs_fallocate,
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o offset %lld len %lld size %lld ret %d",
+	TP_printk("dev %d,%d ino %llu mode 0%o offset %lld len %lld size %lld ret %d",
 		MAJOR(__entry->dev), MINOR(__entry->dev),
-		(unsigned long)__entry->ino, __entry->mode,
+		__entry->ino, __entry->mode,
 		(unsigned long long)__entry->offset,
 		(unsigned long long)__entry->len,
 		(unsigned long long)__entry->size,

-- 
2.53.0


