Return-Path: <linux-fsdevel+bounces-79420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL9oNEFaqGmZtgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:13:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B075203F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3F13019393
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE3360722;
	Wed,  4 Mar 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLqXtRWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41234A78E;
	Wed,  4 Mar 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638510; cv=none; b=IBDdR2OIHuh4XjwGi2mH96VMS8KNkJP/JBHqk8a/gD+bL2BJrI8eJrX1inu+lH2rLWF/HWT+1wTAFs9IyqN1iP5Dl34cRKvC0otsDfPfj65vAindal+UxEZyxb47jZQcJeufDBvnuWBa4aUDDoZKid8OmWJD3E2Q/EApAmoANws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638510; c=relaxed/simple;
	bh=7d5s8zYlgF/lxn2hSCCS8u0A6JkMvE6BfZrHhmcvv5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0YO9YzwJGNMu2WooARIhbeXgDAfFFljWpyh0ZN3epLhtb/LJYITWEz6oOT1xqAcgajqlTOFpYD+slwuNUWaWUfJSZVzKCC7Qckxx4eikmm4AV5EB5b6X3jIVoZrkatYJ4MkAWy50ckMZ/DRjASO8OqqNgDtCFmHLCPwsZtuiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLqXtRWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD8FC2BC87;
	Wed,  4 Mar 2026 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638509;
	bh=7d5s8zYlgF/lxn2hSCCS8u0A6JkMvE6BfZrHhmcvv5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GLqXtRWRoNGJMHyWHLnOCXoLNoJzQHRY0AoEFBcmoW64rpUj7ZyZCM9KJ/B0DgxVD
	 17JeaFzCkGPtsvUioGWmvuvjxzTvJMvyTguwsoQp1FaVb1MDrPhUO5AFxuvqSGz5c5
	 QHbGiBoVjK26AW83s0nID9TgWfVPUUDfXG28sDAga2gA8/g9qWAExQ8umMkKSzMDPl
	 B6SGChdWm6qLXlzZcr8sbu7f/at+eCVg/ihmE6/JQuSgpde8xyfR91+lTqFLv/qypJ
	 BTVxAR0eysCb+ZW/m1tD2fOaD1AMOqY9HrXP2GfSEylCczJOTgSx+VwDI42FOofYat
	 gMae4pALY03zw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Mar 2026 10:32:38 -0500
Subject: [PATCH v3 08/12] zonefs: widen trace event i_ino fields to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-iino-u64-v3-8-2257ad83d372@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7d5s8zYlgF/lxn2hSCCS8u0A6JkMvE6BfZrHhmcvv5o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqFCottPu4Q2RkcxpmSAyx9ymCIr5X9BEkN4+F
 0P0g0I3eSCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaahQqAAKCRAADmhBGVaC
 FewYEADXed5E+znEwLtt1AWpw+ToLxRLATu62cx3IoQgoCJuiJjq76Cp6823onBDOze65FZSF+d
 AkG7fRU1gEZ/5nIIocoPB9UjM+vzFjXjkkb5YTkavZ3HQGbqqkjO9bCYO+dObg26lGea1Atp5EV
 2lszMCSj6/EPPuOqxuRnWhrnheM9mnCkVjL1wIS3SJkxeHK2vUe4jfSoZxLc1mBrJxLmbwzjN8y
 W+YWFyC29h3awuxhGKFipNUK+GTfhfeLjymfG/Pbw7egYbaVFh4ngD8s5jXaWsD0XRquSCiMl6N
 woeRRbNNPZAk6PSe9JRQIXWGYlZDXjQDPSHAuqw3vLzpVllfAHF/Za5tDLU2AMP31Q9w4OoJQuX
 Zpl0FDPSRnGmCOPqkq+yDVb7noBJizXqhgmIEOIEaFiey6L5r0gFw40LzK6lIujysO/Fe7vDeqi
 E8m2QvN/Ud197wFfqq6NupfCSaRFYIn5CVL/A5VfV5temGtwePGoRNBtBSHUVlCDWMAAoQpCao+
 Qeoy/PNxAI808YAgv9W4XlxBnrVuF2dZOfhmuqO6je9IZ5WKFHsHb6eZ8Jl++JaYTTxdhsf5ELp
 yRB4lZFxQy+YmE8jzG7vBq2z4+YmDmOqn38M5n/QE7MkXsrfx8+9arTsaLhEFf1q9CIeODA7rjQ
 JoJg9VvMd1uBfXQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 8B075203F2C
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
	TAGGED_FROM(0.00)[bounces-79420-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Update zonefs trace event definitions to use u64 instead of
ino_t/unsigned long for inode number fields.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/zonefs/trace.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index 9969db3a9c7dc9e212ed04a7c256e02fbe73880e..7315a72ca2f6fb8ac34f7aaa9f7f24224bb5e801 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
 	    TP_ARGS(sb, z, op),
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
-			     __field(ino_t, ino)
+			     __field(u64, ino)
 			     __field(enum req_op, op)
 			     __field(sector_t, sector)
 			     __field(sector_t, nr_sectors)
@@ -38,8 +38,8 @@ TRACE_EVENT(zonefs_zone_mgmt,
 			   __entry->sector = z->z_sector;
 			   __entry->nr_sectors = z->z_size >> SECTOR_SHIFT;
 	    ),
-	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
-		      show_dev(__entry->dev), (unsigned long)__entry->ino,
+	    TP_printk("bdev=(%d,%d), ino=%llu op=%s, sector=%llu, nr_sectors=%llu",
+		      show_dev(__entry->dev), __entry->ino,
 		      blk_op_str(__entry->op), __entry->sector,
 		      __entry->nr_sectors
 	    )
@@ -50,7 +50,7 @@ TRACE_EVENT(zonefs_file_dio_append,
 	    TP_ARGS(inode, size, ret),
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
-			     __field(ino_t, ino)
+			     __field(u64, ino)
 			     __field(sector_t, sector)
 			     __field(ssize_t, size)
 			     __field(loff_t, wpoffset)
@@ -65,8 +65,8 @@ TRACE_EVENT(zonefs_file_dio_append,
 				zonefs_inode_zone(inode)->z_wpoffset;
 			   __entry->ret = ret;
 	    ),
-	    TP_printk("bdev=(%d, %d), ino=%lu, sector=%llu, size=%zu, wpoffset=%llu, ret=%zu",
-		      show_dev(__entry->dev), (unsigned long)__entry->ino,
+	    TP_printk("bdev=(%d, %d), ino=%llu, sector=%llu, size=%zu, wpoffset=%llu, ret=%zu",
+		      show_dev(__entry->dev), __entry->ino,
 		      __entry->sector, __entry->size, __entry->wpoffset,
 		      __entry->ret
 	    )
@@ -77,7 +77,7 @@ TRACE_EVENT(zonefs_iomap_begin,
 	    TP_ARGS(inode, iomap),
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
-			     __field(ino_t, ino)
+			     __field(u64, ino)
 			     __field(u64, addr)
 			     __field(loff_t, offset)
 			     __field(u64, length)
@@ -89,8 +89,8 @@ TRACE_EVENT(zonefs_iomap_begin,
 			   __entry->offset = iomap->offset;
 			   __entry->length = iomap->length;
 	    ),
-	    TP_printk("bdev=(%d,%d), ino=%lu, addr=%llu, offset=%llu, length=%llu",
-		      show_dev(__entry->dev), (unsigned long)__entry->ino,
+	    TP_printk("bdev=(%d,%d), ino=%llu, addr=%llu, offset=%llu, length=%llu",
+		      show_dev(__entry->dev), __entry->ino,
 		      __entry->addr, __entry->offset, __entry->length
 	    )
 );

-- 
2.53.0


