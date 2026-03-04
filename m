Return-Path: <linux-fsdevel+bounces-79412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJspJlhUqGlutQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:48:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5E2033E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 475C2312623D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806334B1B4;
	Wed,  4 Mar 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjZnrAfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA816344D9D;
	Wed,  4 Mar 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638393; cv=none; b=cNg1oaf73bGoQ0OBbTxsRsyDE4ypHU9X7bNMSiHJDYcY0hzeuWp4/5d8/tY8wlt30MmM/tVb8mkTX7hiw/aJaEZRUAs08zWfvJWg2ehpWpzZEyk4BmZkM5FEh1MccZCA4LSZ4EM7Cl/4oFMSBNF1bz+CywjhPTZ4nLDbRI6tJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638393; c=relaxed/simple;
	bh=EvIxci8XOiLl4n/2GeBIsKqplwU5bONQrJ/+crL2wy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tKE1be0Vnyj7u17Ccw16K5dGKnkXPcYtkLYu/1rLyl+rA1YYMz0XtLLNzGHFuKjGvfIug+8/pIAyW27qOKt/ZCN+NodcRCO6WVTPNaiBEo4XoiaqbGOIFkugK74edkr+VPvcqhDH0bvb11ukG98771uFIJxtC+81nQj0j6NQwfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjZnrAfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E0C2BC9E;
	Wed,  4 Mar 2026 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638392;
	bh=EvIxci8XOiLl4n/2GeBIsKqplwU5bONQrJ/+crL2wy0=;
	h=From:Subject:Date:To:Cc:From;
	b=tjZnrAfTQY1egcaOHf43QElBbuHttSDoazI+LhukmrntOJQQAiiebEjQy/XlLFIY6
	 YZBRowumS+CbfL8vCCZJ5ZNJ6/AuhMs+JKxLQn/rsiE38K0mrezhI9zm13iQXv/+v0
	 8b4CaZIxgaqa06ai0MIFmXbaiCEa7u+DIQgSNfl/GZVw4IjFUwa0m1sAT+eBfYGNH+
	 /oAPpYF8Pr7sbmfd5yhxB31Nk/jRCBtZQSpT5OlmT7keh30sXYijYmK3N3sLlC34NN
	 e5vk9jzJkoQkaXORDozAzv3TLVD/vhk71bcohAk5Rj1zHBH/VsCs7Q4VVm9VmXnzkn
	 19P4RrX9m9yDA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/12] vfs: change inode->i_ino from unsigned long to
 u64
Date: Wed, 04 Mar 2026 10:32:30 -0500
Message-Id: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMwQ6CMBAFf4X0bE3Zloqe/A/joZQFNpqWtNpoC
 P9uITHocV7ezMQiBsLITsXEAiaK5F0GuSuYHYzrkVObmYEALQAUJ3KeP7XijVJGmgNUSlqW72P
 Ajl5r6nLNPFB8+PBey6lc1m9Eb5FUcsGttdh1Uuu2OZ5vGBze9z70bKkk2Ewp4MeEbGIl67oWo
 jUo/sx5nj+ixfmA2wAAAA==
X-Change-ID: 20260224-iino-u64-b44a3a72543c
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15620; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EvIxci8XOiLl4n/2GeBIsKqplwU5bONQrJ/+crL2wy0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqFCmtSXlBjo6dQnzEqcLO8yRk/GwocfV+Ys43
 1r2nHJWZLKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaahQpgAKCRAADmhBGVaC
 FZUuD/9cUVHXDTOWJ8EHyosX0JVcAaa8EjHKBSKXi5RdtbvclsnQzxZFo3IHsJRUr5rS20/LlhZ
 Q7bvvGD3ObSLMUnGJ5qEsuw6qLLQl+AHcZHkBNV82iTQ0HbycsLjgvug8TFq977jlXJnAdPObCG
 lInf86Xw+IOQIHirr5f4X6M7dXlLOO2Sr7Z0aR+teb2fo6yeAO1PmY/3RSRNWUYP2OJHUwBbcKc
 2AUrx1vpCMEhOySlHJikzpiNMpdr08wVChoNCQCaXXnk6LUhVVYq77SBKfeRyZAEWlp5As2TiOd
 zvjttN0LJ2Si7bJwcjlTZ08DjZxGiskZ6e56aWJqwoemPzH5xfZ7UQsIk5TThABLumTWSFb9Ytp
 du3oW+3igfz8Mvl0naLgzAt68c3XULfxcmstOXn+iXTvjX0tc0CI4UVCQPpotbo1VIbTSouzh/u
 OLKWsFTrGH3f5MksUXp7bHWVDjaxi3Y/7Kv7oLKpAmd2BzTFGcXjPGFZSx7Kp7uDEWj6h2t4EEN
 bBZvroEHtbd9dUC4XmdWp3iuoRrniH7Tbbx4lD5BHONfGwGsvjttpdJ7DJCm6PgnZZQH22AvID4
 /iG1k2TsVrnLswQvrKkb+SI2T36SGrQsRxcxKEWGtP3ttmRB+Ofhxy/K22a457401aBQq9wv5p/
 thBn08iirCMMzCg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 50E5E2033E5
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
	TAGGED_FROM(0.00)[bounces-79412-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

This version squashes all of the format-string changes and the i_ino
type change into the same patch. This results in a giant 600+ line patch
at the end of the series, but it does remain bisectable.  Because the
patchset was reorganized (again) some of the R-b's and A-b's have been
dropped.

The entire pile is in the "iino-u64" branch of my tree, if anyone is
interested in testing this.

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/

Original cover letter follows:

----------------------8<-----------------------

Christian said [1] to "just do it" when I proposed this, so here we are!

For historical reasons, the inode->i_ino field is an unsigned long,
which means that it's 32 bits on 32 bit architectures. This has caused a
number of filesystems to implement hacks to hash a 64-bit identifier
into a 32-bit field, and deprives us of a universal identifier field for
an inode.

This patchset changes the inode->i_ino field from an unsigned long to a
u64. This shouldn't make any material difference on 64-bit hosts, but
32-bit hosts will see struct inode grow by at least 4 bytes. This could
have effects on slabcache sizes and field alignment.

The bulk of the changes are to format strings and tracepoints, since the
kernel itself doesn't care that much about the i_ino field. The first
patch changes some vfs function arguments, so check that one out
carefully.

With this change, we may be able to shrink some inode structures. For
instance, struct nfs_inode has a fileid field that holds the 64-bit
inode number. With this set of changes, that field could be eliminated.
I'd rather leave that sort of cleanups for later just to keep this
simple.

Much of this set was generated by LLM, but I attributed it to myself
since I consider this to be in the "menial tasks" category of LLM usage.

[1]: https://lore.kernel.org/linux-fsdevel/20260219-portrait-winkt-959070cee42f@brauner/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- reorganize set for fewer patches, drop kino_t typedef and PRIino macro
- reorganize more TP_struct fields for better packing
- clean up ext4 goal calculation in ext4_ext_migrate()
- make audit_inode_hash() take a 64-bit argument
- Link to v2: https://lore.kernel.org/r/20260302-iino-u64-v2-0-e5388800dae0@kernel.org

Changes in v2:
- Use a typedef and macro and do the change in two steps to make it cleanly bisectable
- Fix check_for_busy_inodes() in fscrypt
- Added patch to reorganize tracepoint structs for better packing
- Added patch to change sock.sk_ino to u64
- Added patch to clean up internal handling of inode numbers in audit subsystem
- Drop some unnecessary casts
- Link to v1: https://lore.kernel.org/r/20260226-iino-u64-v1-0-ccceff366db9@kernel.org

---
Jeff Layton (12):
      vfs: widen inode hash/lookup functions to u64
      audit: widen ino fields to u64
      net: change sock.sk_ino and sock_i_ino() to u64
      vfs: widen trace event i_ino fields to u64
      cachefiles: widen trace event i_ino fields to u64
      ext2: widen trace event i_ino fields to u64
      hugetlbfs: widen trace event i_ino fields to u64
      zonefs: widen trace event i_ino fields to u64
      ext4: widen trace event i_ino fields to u64
      f2fs: widen trace event i_ino fields to u64
      nilfs2: widen trace event i_ino fields to u64
      treewide: change inode->i_ino from unsigned long to u64

 drivers/dma-buf/dma-buf.c                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +-
 fs/9p/vfs_addr.c                           |   4 +-
 fs/9p/vfs_inode.c                          |   6 +-
 fs/9p/vfs_inode_dotl.c                     |   6 +-
 fs/affs/amigaffs.c                         |  10 +-
 fs/affs/bitmap.c                           |   2 +-
 fs/affs/dir.c                              |   2 +-
 fs/affs/file.c                             |  20 +-
 fs/affs/inode.c                            |  12 +-
 fs/affs/namei.c                            |  14 +-
 fs/affs/symlink.c                          |   2 +-
 fs/afs/dir.c                               |  10 +-
 fs/afs/dir_search.c                        |   2 +-
 fs/afs/dynroot.c                           |   2 +-
 fs/afs/inode.c                             |   2 +-
 fs/autofs/inode.c                          |   2 +-
 fs/befs/linuxvfs.c                         |  28 +-
 fs/bfs/dir.c                               |   4 +-
 fs/cachefiles/io.c                         |   6 +-
 fs/cachefiles/namei.c                      |  12 +-
 fs/cachefiles/xattr.c                      |   2 +-
 fs/ceph/crypto.c                           |   4 +-
 fs/coda/dir.c                              |   2 +-
 fs/coda/inode.c                            |   2 +-
 fs/cramfs/inode.c                          |   2 +-
 fs/crypto/crypto.c                         |   2 +-
 fs/crypto/hooks.c                          |   2 +-
 fs/crypto/keyring.c                        |   4 +-
 fs/crypto/keysetup.c                       |   2 +-
 fs/dcache.c                                |   4 +-
 fs/ecryptfs/crypto.c                       |   6 +-
 fs/ecryptfs/file.c                         |   2 +-
 fs/efs/inode.c                             |   6 +-
 fs/eventpoll.c                             |   2 +-
 fs/exportfs/expfs.c                        |   4 +-
 fs/ext2/dir.c                              |  10 +-
 fs/ext2/ialloc.c                           |   9 +-
 fs/ext2/inode.c                            |   2 +-
 fs/ext2/trace.h                            |   8 +-
 fs/ext2/xattr.c                            |  14 +-
 fs/ext4/dir.c                              |   2 +-
 fs/ext4/ext4.h                             |   4 +-
 fs/ext4/extents.c                          |   8 +-
 fs/ext4/extents_status.c                   |  28 +-
 fs/ext4/fast_commit.c                      |   8 +-
 fs/ext4/ialloc.c                           |  10 +-
 fs/ext4/indirect.c                         |   2 +-
 fs/ext4/inline.c                           |  14 +-
 fs/ext4/inode.c                            |  22 +-
 fs/ext4/ioctl.c                            |   4 +-
 fs/ext4/mballoc.c                          |   6 +-
 fs/ext4/migrate.c                          |   2 +-
 fs/ext4/move_extent.c                      |  20 +-
 fs/ext4/namei.c                            |  10 +-
 fs/ext4/orphan.c                           |  16 +-
 fs/ext4/page-io.c                          |  10 +-
 fs/ext4/super.c                            |  22 +-
 fs/ext4/xattr.c                            |  10 +-
 fs/f2fs/compress.c                         |   4 +-
 fs/f2fs/dir.c                              |   2 +-
 fs/f2fs/extent_cache.c                     |   8 +-
 fs/f2fs/f2fs.h                             |   6 +-
 fs/f2fs/file.c                             |  12 +-
 fs/f2fs/gc.c                               |   2 +-
 fs/f2fs/inline.c                           |   4 +-
 fs/f2fs/inode.c                            |  48 +--
 fs/f2fs/namei.c                            |   8 +-
 fs/f2fs/node.c                             |  12 +-
 fs/f2fs/recovery.c                         |  10 +-
 fs/f2fs/xattr.c                            |  10 +-
 fs/freevxfs/vxfs_bmap.c                    |   4 +-
 fs/fserror.c                               |   2 +-
 fs/hfs/catalog.c                           |   2 +-
 fs/hfs/extent.c                            |   4 +-
 fs/hfs/inode.c                             |   4 +-
 fs/hfsplus/attributes.c                    |  10 +-
 fs/hfsplus/catalog.c                       |   2 +-
 fs/hfsplus/dir.c                           |   6 +-
 fs/hfsplus/extents.c                       |   6 +-
 fs/hfsplus/inode.c                         |   8 +-
 fs/hfsplus/super.c                         |   6 +-
 fs/hfsplus/xattr.c                         |  10 +-
 fs/hpfs/dir.c                              |   4 +-
 fs/hpfs/dnode.c                            |   4 +-
 fs/hpfs/ea.c                               |   4 +-
 fs/hpfs/inode.c                            |   4 +-
 fs/inode.c                                 |  49 ++-
 fs/iomap/ioend.c                           |   2 +-
 fs/iomap/trace.h                           |   8 +-
 fs/isofs/compress.c                        |   2 +-
 fs/isofs/dir.c                             |   2 +-
 fs/isofs/inode.c                           |   6 +-
 fs/isofs/namei.c                           |   2 +-
 fs/jbd2/journal.c                          |   4 +-
 fs/jbd2/transaction.c                      |   2 +-
 fs/jffs2/dir.c                             |   4 +-
 fs/jffs2/file.c                            |   4 +-
 fs/jffs2/fs.c                              |  18 +-
 fs/jfs/inode.c                             |   2 +-
 fs/jfs/jfs_imap.c                          |   2 +-
 fs/jfs/jfs_metapage.c                      |   2 +-
 fs/lockd/svclock.c                         |   8 +-
 fs/lockd/svcsubs.c                         |   2 +-
 fs/locks.c                                 |   6 +-
 fs/minix/inode.c                           |  10 +-
 fs/nfs/dir.c                               |  20 +-
 fs/nfs/file.c                              |   8 +-
 fs/nfs/filelayout/filelayout.c             |   8 +-
 fs/nfs/flexfilelayout/flexfilelayout.c     |   8 +-
 fs/nfs/inode.c                             |   6 +-
 fs/nfs/nfs4proc.c                          |   4 +-
 fs/nfs/pnfs.c                              |  12 +-
 fs/nfsd/export.c                           |   2 +-
 fs/nfsd/nfs4state.c                        |   4 +-
 fs/nfsd/nfsfh.c                            |   4 +-
 fs/nfsd/vfs.c                              |   2 +-
 fs/nilfs2/alloc.c                          |  10 +-
 fs/nilfs2/bmap.c                           |   2 +-
 fs/nilfs2/btnode.c                         |   2 +-
 fs/nilfs2/btree.c                          |  12 +-
 fs/nilfs2/dir.c                            |  12 +-
 fs/nilfs2/direct.c                         |   4 +-
 fs/nilfs2/gcinode.c                        |   2 +-
 fs/nilfs2/inode.c                          |   8 +-
 fs/nilfs2/mdt.c                            |   2 +-
 fs/nilfs2/namei.c                          |   2 +-
 fs/nilfs2/segment.c                        |   2 +-
 fs/notify/fdinfo.c                         |   4 +-
 fs/nsfs.c                                  |   4 +-
 fs/ntfs3/super.c                           |   2 +-
 fs/ocfs2/alloc.c                           |   2 +-
 fs/ocfs2/aops.c                            |   4 +-
 fs/ocfs2/dir.c                             |   8 +-
 fs/ocfs2/dlmfs/dlmfs.c                     |  10 +-
 fs/ocfs2/extent_map.c                      |  12 +-
 fs/ocfs2/inode.c                           |   2 +-
 fs/ocfs2/quota_local.c                     |   2 +-
 fs/ocfs2/refcounttree.c                    |  10 +-
 fs/ocfs2/xattr.c                           |   4 +-
 fs/orangefs/inode.c                        |   2 +-
 fs/overlayfs/export.c                      |   2 +-
 fs/overlayfs/namei.c                       |   4 +-
 fs/overlayfs/util.c                        |   2 +-
 fs/pipe.c                                  |   2 +-
 fs/proc/fd.c                               |   2 +-
 fs/proc/task_mmu.c                         |   4 +-
 fs/qnx4/inode.c                            |   4 +-
 fs/qnx6/inode.c                            |   2 +-
 fs/ubifs/debug.c                           |   8 +-
 fs/ubifs/dir.c                             |  28 +-
 fs/ubifs/file.c                            |  28 +-
 fs/ubifs/journal.c                         |   6 +-
 fs/ubifs/super.c                           |  16 +-
 fs/ubifs/tnc.c                             |   4 +-
 fs/ubifs/xattr.c                           |  14 +-
 fs/udf/directory.c                         |  18 +-
 fs/udf/file.c                              |   2 +-
 fs/udf/inode.c                             |  12 +-
 fs/udf/namei.c                             |   8 +-
 fs/udf/super.c                             |   2 +-
 fs/ufs/balloc.c                            |   6 +-
 fs/ufs/dir.c                               |  10 +-
 fs/ufs/ialloc.c                            |   6 +-
 fs/ufs/inode.c                             |  18 +-
 fs/ufs/ufs_fs.h                            |   6 +-
 fs/ufs/util.c                              |   2 +-
 fs/verity/init.c                           |   2 +-
 fs/zonefs/super.c                          |   8 +-
 fs/zonefs/trace.h                          |  18 +-
 include/linux/audit.h                      |   2 +-
 include/linux/fs.h                         |  28 +-
 include/net/sock.h                         |   4 +-
 include/trace/events/cachefiles.h          |  18 +-
 include/trace/events/ext4.h                | 544 ++++++++++++++---------------
 include/trace/events/f2fs.h                | 242 ++++++-------
 include/trace/events/filelock.h            |  34 +-
 include/trace/events/filemap.h             |  20 +-
 include/trace/events/fs_dax.h              |  20 +-
 include/trace/events/fsverity.h            |  30 +-
 include/trace/events/hugetlbfs.h           |  42 +--
 include/trace/events/netfs.h               |   8 +-
 include/trace/events/nilfs2.h              |  12 +-
 include/trace/events/readahead.h           |  18 +-
 include/trace/events/timestamp.h           |  16 +-
 include/trace/events/writeback.h           | 162 ++++-----
 kernel/audit.h                             |  13 +-
 kernel/audit_fsnotify.c                    |   4 +-
 kernel/audit_watch.c                       |  12 +-
 kernel/auditsc.c                           |   4 +-
 kernel/events/uprobes.c                    |   4 +-
 net/ax25/af_ax25.c                         |   2 +-
 net/bluetooth/af_bluetooth.c               |   4 +-
 net/can/bcm.c                              |   2 +-
 net/ipv4/ping.c                            |   2 +-
 net/ipv4/raw.c                             |   2 +-
 net/ipv4/tcp_ipv4.c                        |   2 +-
 net/ipv4/udp.c                             |   2 +-
 net/ipv6/datagram.c                        |   2 +-
 net/ipv6/tcp_ipv6.c                        |   2 +-
 net/key/af_key.c                           |   2 +-
 net/netlink/af_netlink.c                   |   2 +-
 net/netlink/diag.c                         |   2 +-
 net/netrom/af_netrom.c                     |   4 +-
 net/packet/af_packet.c                     |   2 +-
 net/packet/diag.c                          |   2 +-
 net/phonet/socket.c                        |   4 +-
 net/rose/af_rose.c                         |   4 +-
 net/sctp/proc.c                            |   4 +-
 net/socket.c                               |   2 +-
 net/unix/af_unix.c                         |   2 +-
 net/unix/diag.c                            |   6 +-
 net/x25/x25_proc.c                         |   4 +-
 net/xdp/xsk_diag.c                         |   2 +-
 security/apparmor/apparmorfs.c             |   4 +-
 security/integrity/integrity_audit.c       |   2 +-
 security/ipe/audit.c                       |   2 +-
 security/lsm_audit.c                       |  10 +-
 security/selinux/hooks.c                   |  10 +-
 security/smack/smack_lsm.c                 |  12 +-
 220 files changed, 1282 insertions(+), 1283 deletions(-)
---
base-commit: 842cfe0733c5a03982a7ae496de6fdc0dd661a41
change-id: 20260224-iino-u64-b44a3a72543c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


