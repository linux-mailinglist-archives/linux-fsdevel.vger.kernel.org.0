Return-Path: <linux-fsdevel+bounces-79417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCSqFRhYqGlQtgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:04:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EA203A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FFD320DE6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083A535B642;
	Wed,  4 Mar 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFK2PcIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25A35838A;
	Wed,  4 Mar 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638466; cv=none; b=FIIZobTLttKE+JrzZw8LeFUwQHfjbfUXHdPVovkeeLtDRZTPG8jvygOtE5SiUqKpN+CkEPdSq5kVncmxbZr1skIhHltKzOBDe5pJo7SQ5yUNr+Er8wznkj+t6CWQilUYH6imYOkf7FFIoz45mqRd+1nOTtEhlxXWBJkvfgsqVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638466; c=relaxed/simple;
	bh=E8lUv5ZV2tqm8DGQreXuazegXs/r+kDs1hpPJsZQq40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SI3NJaDqClKnezwgbVqJ3S9k4oVZp7E8JbL2Dbfpgr+vw5ICtYfTyWTMGUF6hGO7WuDxvBejpmzPFcJxFqfpV2obOFjOQJRQ/pqgo+EKPHC6DhIjNIiULub8PG6NZ6yWNdv99mTwsYSRdcVQL7Y79SNCy0ihMcIpT6RfRCyfueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFK2PcIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A489C4CEF7;
	Wed,  4 Mar 2026 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638466;
	bh=E8lUv5ZV2tqm8DGQreXuazegXs/r+kDs1hpPJsZQq40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jFK2PcIetv8IU3o5qyCGZS8yfnEmKyxt05WjYIOxfomVoagmee2rH4HxfQD9wSM3R
	 XDE47kliJh8fJ1GmIPCIf38EzINurHOm24dnur01wBv0CCr1MWzm3/UodlkvfTl+Yd
	 JLMs271d68CxBnznBOsuLhuPOJwK9CijGynxxvMr1DzYo8xT5nP7xaQ2iLOo4WiuUG
	 GEyM1CYIXrez1FqWZdIBGAw55waYwPTzAZuTjz6fFeNpFv2z57PKbJiWA5N664Iul3
	 470sy//ovrFOSVbXWzgcyyueQFN/gRyPXwy3QnmUm0TS05tzEJt1sV/d2jk6nebaeT
	 jGXW/jOg/+gkA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Mar 2026 10:32:35 -0500
Subject: [PATCH v3 05/12] cachefiles: widen trace event i_ino fields to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-iino-u64-v3-5-2257ad83d372@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E8lUv5ZV2tqm8DGQreXuazegXs/r+kDs1hpPJsZQq40=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqFCnboYZuamhSjxxOsGNVe4KX4qKQ8jKhPQAS
 et+MGnh3xKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaahQpwAKCRAADmhBGVaC
 FRS2EACPETzruvNWJd9CA77sY2+/NqsP8aQJDqjrVWDpD5gBPLEZMyv3hyr/iNfrnRD1YKrR1ve
 4Bp6qUnc70Gv3PJekeMaKteUwnvKLrYaFXHRfvMW2vQxG5a+VN/ZfQqOwIFb3IxqbdLtOpKMxZZ
 /nnZ6Id/RD1dBISUcfqJTDZQwqvLPraPCMVjfhS5Z15yRDQTXFk0l2cyZa3kOeSxpU0Qt/Loa9e
 fm21nW5KV0Z9vgm0xbit0/5OpEvQBfYL5yZOHWrsoUEPkXCJ3wu7N1wj1S44XYAoq5AeWVxS3xz
 l7eoPz5B0Qp9t6jNKdY7aLDlC09gqABVVTWzUWlZUbEIWbovOTLNAUsKOccgpleXonxEw92EPbL
 m2OfW8fnr646fipgkmuQ69xHnJ5wuhHORGrYgEZLI8A7qqUclHy9LW3JS97sBkHmyw9GhpV55y7
 F5PviCDiQQW6zNjygQG9Izn8+BIBcU6M1XHl1CDUYf6IIYD4lNI3ufLroIBzwn35/AqoUL8y40k
 khU0NCP3PKt0SD7h7daLvk8VNw0uV5si6Yr52CxWSyuNFYKUidRb1nAZ0fK4IbbrqSOYCWDg1vp
 rT2AhnlH6FhofgKbRzcTMifS2MvB0zCxCHXSQnAz9y00Dt1w9OHgXTnfFmfC5KheLo20gBiPwab
 2AYYSsJVCX8y4jQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: BA1EA203A7D
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
	TAGGED_FROM(0.00)[bounces-79417-lists,linux-fsdevel=lfdr.de];
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

Update cachefiles trace event definitions to use u64 instead of
ino_t/unsigned long for inode number fields.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/cachefiles.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index a743b2a35ea7001447b3e05d41539cb88013bc7f..6e3b1424eea4dc9e414dd9d1439339132d516339 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -249,10 +249,10 @@ TRACE_EVENT(cachefiles_lookup,
 	    TP_ARGS(obj, dir, de),
 
 	    TP_STRUCT__entry(
+		    __field(u64,			dino)
+		    __field(u64,			ino)
 		    __field(unsigned int,		obj)
 		    __field(short,			error)
-		    __field(unsigned long,		dino)
-		    __field(unsigned long,		ino)
 			     ),
 
 	    TP_fast_assign(
@@ -263,7 +263,7 @@ TRACE_EVENT(cachefiles_lookup,
 		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
 			   ),
 
-	    TP_printk("o=%08x dB=%lx B=%lx e=%d",
+	    TP_printk("o=%08x dB=%llx B=%llx e=%d",
 		      __entry->obj, __entry->dino, __entry->ino, __entry->error)
 	    );
 
@@ -578,8 +578,8 @@ TRACE_EVENT(cachefiles_mark_active,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
+		    __field(u64,			inode)
 		    __field(unsigned int,		obj)
-		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -587,7 +587,7 @@ TRACE_EVENT(cachefiles_mark_active,
 		    __entry->inode	= inode->i_ino;
 			   ),
 
-	    TP_printk("o=%08x B=%lx",
+	    TP_printk("o=%08x B=%llx",
 		      __entry->obj, __entry->inode)
 	    );
 
@@ -599,8 +599,8 @@ TRACE_EVENT(cachefiles_mark_failed,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
+		    __field(u64,			inode)
 		    __field(unsigned int,		obj)
-		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -608,7 +608,7 @@ TRACE_EVENT(cachefiles_mark_failed,
 		    __entry->inode	= inode->i_ino;
 			   ),
 
-	    TP_printk("o=%08x B=%lx",
+	    TP_printk("o=%08x B=%llx",
 		      __entry->obj, __entry->inode)
 	    );
 
@@ -620,8 +620,8 @@ TRACE_EVENT(cachefiles_mark_inactive,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
+		    __field(u64,			inode)
 		    __field(unsigned int,		obj)
-		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -629,7 +629,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
 		    __entry->inode	= inode->i_ino;
 			   ),
 
-	    TP_printk("o=%08x B=%lx",
+	    TP_printk("o=%08x B=%llx",
 		      __entry->obj, __entry->inode)
 	    );
 

-- 
2.53.0


