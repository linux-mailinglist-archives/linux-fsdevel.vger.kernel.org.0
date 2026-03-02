Return-Path: <linux-fsdevel+bounces-79023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDc+OpAApml5IwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:26:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 126F41E2D9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C723325A70C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87453A32EB;
	Mon,  2 Mar 2026 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/0mEX+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80E2F3C19;
	Mon,  2 Mar 2026 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483949; cv=none; b=JivRvxzyIGzpQuLkxhoKYOJzh6US/TibMBpYxdQ5BBBIGHh0kOHVU+gtoO0Oe86mcOPWZrASvYw8Dv71eTCvkKmJh9VRDE/NKMO9sE9D4adGcK7LmOtixLsWtGLhhfMwNX3IaXR8Jdkv9aBDViMSiOO4i8xEfaqtiTMX3y8JqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483949; c=relaxed/simple;
	bh=Gs35boKyxgnd6AK1hIGNOaT7cmCaVBjAuSuFUf3Jc5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZ4J/hA2WI/jGxPgalaRjMvTEf6le7APScrLn8WPTbeTvcN9dVvBV+1sQr42/iRp0bQpiGsB6TETwIR/FMRwF8syoypB8pyEK+1mBP3I9YgXVBWOKa34z7AYnPTj3Lw0mZEFZYVfe30d5cTViwu3T6j2unWo2WHcOsPZts/z8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/0mEX+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF15C19423;
	Mon,  2 Mar 2026 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483948;
	bh=Gs35boKyxgnd6AK1hIGNOaT7cmCaVBjAuSuFUf3Jc5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J/0mEX+2I5d/RuqYCJxGEFWFGN5i/FNi9MYTRfJiWPgEv4WyyoxOBiSwB9doWNhqu
	 8HzBDuWTWgvBnu+W5upst9Tq+IdSmegMnQfpocbi8KPqZbkqll00OGn0sxmveqikZ4
	 VrvQthnnu2V0O3B5pRmnq2ED1EMTlXl2WaQHejYEj4H07IsKE63RH0EdzulikApjz+
	 P/+4Kj3ShwuKtZGGzptw8AqpVLiduNYywEJrjLhZ6oBQnAXjOpSGsQoSG4oPYtW3WB
	 vMET5jWxbonNAxxI6wa4LZioME0jG5p1zH3tehu+VG6P/G2IaJ+m6V4/vc/C/bmA6w
	 xOBqUG2q4Sq5w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Mar 2026 15:24:43 -0500
Subject: [PATCH v2 059/110] vfs: use PRIino format for i_ino
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-iino-u64-v2-59-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Gs35boKyxgnd6AK1hIGNOaT7cmCaVBjAuSuFUf3Jc5I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfH+91J4KBDB2hDn0qDUxRonhElkhdedME3xJ
 B/BW/0vlnGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXx/gAKCRAADmhBGVaC
 FcuFD/oD8Yp/dzC9uRSQy4WTdSxX8N7nmwgkzyjPPieVQ/3bXxk9KNtjb9+aWRD+STEIs8UBGGT
 galtNwy0DCULHM4+oOeWuzxvnPo/CBCX0Qh5zx2NWhrXh8MVqKpfA79Sn/O9m0Hmv3FklJ859tS
 sm+eqGxgsaQakSp/u3f6SkouNLsnZqjcceDWMSG1AWwkWiJvehD8lOmKaZ9dNPkBbnhSt918QLl
 obKXJ5KjPeYa5voKMeGcXKqB0to6HV6xOKHaIA5UnTAuDlB8u3s+PlV7XFZ4DzkrZBHZ0IT/c4F
 E/rwhRhVGfA86rfwZbgzFdK8JpGMFG5ckQcNMH5Vf+e/hZzkXcJo8c7kDXUU8Xhol8N7ot3aaS/
 xVfP2nrw1IAhdKbGyuCT107lRvbh0s/gKOJ3iVhyTE0Dh3jRmFOPhvBDrNWIHoEJ7JnGgIO3A4m
 WOJptVxnl8uo5IGP6ChBXt6KiRCxdhiugZGm7t90o3dTvgoKr7nm7XoOM8HaM8j9fJJTI1gCNKd
 7IGZ94XW8QjdzKaDjaIgiy+0VF3g/dA4yPOnShFNKYyr6mQyO2YS9sGDMI1Q94uCI6S8ZhV1R2n
 W0xzM63QkE+KdaN7pM7W7jOIuD/Uwq8WSR1xbEl0YdsHQs9VNWYDyDKnRDkE01chpjHLLlLKOCa
 QKr/nNSOgss4FYQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 126F41E2D9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79023-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[172];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert i_ino format strings in pipe, dcache, fserror, and eventpoll to
use the PRIino format macro and update the 0UL literal in dcache to
(kino_t)0.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/dcache.c    | 4 ++--
 fs/eventpoll.c | 2 +-
 fs/fserror.c   | 2 +-
 fs/pipe.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 24f4f3acaa8cffd6f98124eec38c1a92d6c9fd8e..13fb3e89cba7442c9bed74c41ca18be5e43e28c9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1637,11 +1637,11 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 	if (dentry == _data && dentry->d_lockref.count == 1)
 		return D_WALK_CONTINUE;
 
-	WARN(1, "BUG: Dentry %p{i=%lx,n=%pd} "
+	WARN(1, "BUG: Dentry %p{i=%" PRIino "x,n=%pd} "
 			" still in use (%d) [unmount of %s %s]\n",
 		       dentry,
 		       dentry->d_inode ?
-		       dentry->d_inode->i_ino : 0UL,
+		       dentry->d_inode->i_ino : (kino_t)0,
 		       dentry,
 		       dentry->d_lockref.count,
 		       dentry->d_sb->s_type->name,
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 5714e900567c499739bb205f43bb6bf73f7ebe54..90fd92425492221d13bd0cf067d47579bb407a01 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1080,7 +1080,7 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
 		struct inode *inode = file_inode(epi->ffd.file);
 
 		seq_printf(m, "tfd: %8d events: %8x data: %16llx "
-			   " pos:%lli ino:%lx sdev:%x\n",
+			   " pos:%lli ino:%" PRIino "x sdev:%x\n",
 			   epi->ffd.fd, epi->event.events,
 			   (long long)epi->event.data,
 			   (long long)epi->ffd.file->f_pos,
diff --git a/fs/fserror.c b/fs/fserror.c
index 06ca86adab9b769dfb72ec58b9e51627abee5152..b685b329b5956a639c41b25c42cfff16e6e5ab6e 100644
--- a/fs/fserror.c
+++ b/fs/fserror.c
@@ -176,7 +176,7 @@ void fserror_report(struct super_block *sb, struct inode *inode,
 lost:
 	if (inode)
 		pr_err_ratelimited(
- "%s: lost file I/O error report for ino %lu type %u pos 0x%llx len 0x%llx error %d",
+ "%s: lost file I/O error report for ino %" PRIino "u type %u pos 0x%llx len 0x%llx error %d",
 		       sb->s_id, inode->i_ino, type, pos, len, error);
 	else
 		pr_err_ratelimited(
diff --git a/fs/pipe.c b/fs/pipe.c
index b44a756c0b4165edc2801b2290bf35480245d7a6..311928e8713989747605fd79f653e36d27ce8c0e 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -873,7 +873,7 @@ static struct vfsmount *pipe_mnt __ro_after_init;
  */
 static char *pipefs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	return dynamic_dname(buffer, buflen, "pipe:[%lu]",
+	return dynamic_dname(buffer, buflen, "pipe:[%" PRIino "u]",
 				d_inode(dentry)->i_ino);
 }
 

-- 
2.53.0


