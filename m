Return-Path: <linux-fsdevel+bounces-78523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBDwL/ByoGmDjwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:21:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460C1AA12F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1ABD3208041
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A720426D2F;
	Thu, 26 Feb 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqfxb/JP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07D423A8B;
	Thu, 26 Feb 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121377; cv=none; b=U/ubmFhjZik6XpVigA+1rclN303SSvYHBmuLyLHlKNjHt599I2cDTXQ1WBwKBW80HmKAp6r7mT0Pv4HVuQpFZa0rNkRS/OzXAtahpw3dsoOFgjffcql3+psIqwY90wRjNJ+Antlpl74AZcwv+L9u37TZXdQzbRDwa8FeWjY1RpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121377; c=relaxed/simple;
	bh=bm8lqWJV39M4eG7U+QbchhnID3rpkEPNWqFnFcK9h50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SArB4fHCzTSvJpdjU3t1ozneVbpNj7AKIvYmkZBzQanGbGvToPgjpn5e5EzzhjxYBh2xDpNBbSvAB8sB0FKdWZYndeQ4I24ZTS8Vd9ypbaOCSqP4GFqXhFijfQsqMMupRR3ZPIj5BUuPOJtcx4s6woyozg6ZXwKNMFYd2lyOgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqfxb/JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E25C116C6;
	Thu, 26 Feb 2026 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121376;
	bh=bm8lqWJV39M4eG7U+QbchhnID3rpkEPNWqFnFcK9h50=;
	h=From:Subject:Date:To:Cc:From;
	b=pqfxb/JPB+9A0DdEmihrSR1od+MmqlePtV5ia1XT3Jxe4lyCPW63Y66CQyfmzEb+v
	 /IwagyED23uEKn4TYUZRNJnRnzyAzafzpIpu059iFAlMlm/x6UJP5UIoKuK0QE7RhI
	 s1kPeLnP3jKq5b8ff3bxDEpvrtkxU8Zgy3TCX1glQSBbvp4px1/TkOpbmgXtPTs1R0
	 q1QzY0eaxDQZXfRYvjWH4D1U5yoYKNeZfYi6SDnln/tU2EKvzr8b03UGXLRmEptBnE
	 k7ngVYFF3PiaogbYG0gVKmtphsJjGy6IEOhC8woyjLWgWHnKfDthZuKCKyDXQwwi5j
	 EgBHsyvn9gmMA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/61] vfs: change inode->i_ino from unsigned long to u64
Date: Thu, 26 Feb 2026 10:55:02 -0500
Message-Id: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMT3czMvHzdUjMT3SQTk0TjRHMjUxPjZCWg8oKi1LTMCrBR0bG1tQA
 SGtUlWgAAAA==
X-Change-ID: 20260224-iino-u64-b44a3a72543c
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
 Martin Schiller <ms@dev.tdt.de>
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
 linux-x25@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15312; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bm8lqWJV39M4eG7U+QbchhnID3rpkEPNWqFnFcK9h50=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpoG0E7ak+Mylvq4N32bK1I3/WSmlri3O20ntel
 ynlDCAf5J+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaBtBAAKCRAADmhBGVaC
 FQNaD/99dNIe9GktLTBzwopZ9yEGFrRTFIcmxisOkvFnYrxs7pvyJguByZr/T9eX2cNVUEpdjzD
 C1iuOte5SQ45dD0PjwPJPiK3FG0CQk+EHKxp/XFvwWOmR5Notnj4PjXsZsPE9vkoKAPRoo7N/+E
 VhGmfuR2DDecDqDhM4BKt90HenRbGbgxjDDJnBbJAOJWg4Bg/EdjF6biS3LVebOFBuUe0YdUwrs
 u5/8rzD+AE1IstmFVsGHrvkZ1s+IUCm5IqXQuym9YwDN8keTlmAiG502esniJ/r61Q1E5EKsaDG
 tGZQEhXHmQSQk24ELJUdDAekMGRh8xxQ9WjLMbddWAT6yozs1bgm/Qc25vJln0H8tyL+MdruE0R
 EZaHTaxm7ejC8n7zzOriY4b5BJyyD+HU8ejrE0SzdrYu2cZ/9JbanXHyfkk8aPs6QdtHGt9RpQc
 lqjS9fIuX5sgbILJnQ4puht3XSoRWE3+3ggHZOF62lEIEy286MWX2QEdHC88LXHGVni64VZ/LEX
 SBsBmZgyyTnusTh9cFSX0ZBvyy5ULBbHQVwmznONmCsIhpfuyJGn9lqADtLZieII+rvq/1kGKpF
 rg1YwXdTIQ/z/gW3X6vOUv4fg4/y9G6DWzvdmr8IKkQeoOg2P0242rvkp+nvgUTXwsUOjUbMovD
 z2z7t40oREOfaVA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-78523-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[146];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5460C1AA12F
X-Rspamd-Action: no action

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
Jeff Layton (61):
      vfs: widen inode hash/lookup functions to u64
      vfs: change i_ino from unsigned long to u64
      trace: update VFS-layer trace events for u64 i_ino
      ext4: update for u64 i_ino
      jbd2: update format strings for u64 i_ino
      f2fs: update for u64 i_ino
      lockd: update format strings for u64 i_ino
      nfs: update for u64 i_ino
      nfs: remove nfs_fattr_to_ino_t() and nfs_fileid_to_ino_t()
      nfs: remove nfs_compat_user_ino64()
      nfs: remove enable_ino64 module parameter
      nfsd: update format strings for u64 i_ino
      smb: store full 64-bit uniqueid in i_ino
      smb: remove cifs_uniqueid_to_ino_t()
      locks: update /proc/locks format for u64 i_ino
      proc: update /proc/PID/maps for u64 i_ino
      nilfs2: update for u64 i_ino
      9p: update format strings for u64 i_ino
      affs: update format strings for u64 i_ino
      afs: update format strings for u64 i_ino
      autofs: update format strings for u64 i_ino
      befs: update format strings for u64 i_ino
      bfs: update format strings for u64 i_ino
      cachefiles: update format strings for u64 i_ino
      ceph: update format strings for u64 i_ino
      coda: update format strings for u64 i_ino
      cramfs: update format strings for u64 i_ino
      ecryptfs: update format strings for u64 i_ino
      efs: update format strings for u64 i_ino
      exportfs: update format strings for u64 i_ino
      ext2: update format strings for u64 i_ino
      freevxfs: update format strings for u64 i_ino
      hfs: update format strings for u64 i_ino
      hfsplus: update format strings for u64 i_ino
      hpfs: update format strings for u64 i_ino
      isofs: update format strings for u64 i_ino
      jffs2: update format strings for u64 i_ino
      jfs: update format strings for u64 i_ino
      minix: update format strings for u64 i_ino
      nsfs: update format strings for u64 i_ino
      ntfs3: update format strings for u64 i_ino
      ocfs2: update format strings for u64 i_ino
      orangefs: update format strings for u64 i_ino
      overlayfs: update format strings for u64 i_ino
      qnx4: update format strings for u64 i_ino
      qnx6: update format strings for u64 i_ino
      ubifs: update format strings for u64 i_ino
      udf: update format strings for u64 i_ino
      ufs: update format strings for u64 i_ino
      zonefs: update format strings for u64 i_ino
      security: update audit format strings for u64 i_ino
      drm/amdgpu: update for u64 i_ino
      fsnotify: update fdinfo format strings for u64 i_ino
      net: update socket dname format for u64 i_ino
      uprobes: update format strings for u64 i_ino
      dma-buf: update format string for u64 i_ino
      fscrypt: update format strings for u64 i_ino
      fsverity: update format string for u64 i_ino
      iomap: update format string for u64 i_ino
      net: update legacy protocol format strings for u64 i_ino
      vfs: update core format strings for u64 i_ino

 drivers/dma-buf/dma-buf.c                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +-
 fs/9p/vfs_addr.c                           |   4 +-
 fs/9p/vfs_inode.c                          |   6 +-
 fs/9p/vfs_inode_dotl.c                     |   6 +-
 fs/affs/amigaffs.c                         |   8 +-
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
 fs/f2fs/inode.c                            |  48 ++--
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
 fs/inode.c                                 |  46 ++--
 fs/iomap/ioend.c                           |   2 +-
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
 fs/nfs/dir.c                               |  22 +-
 fs/nfs/file.c                              |   8 +-
 fs/nfs/filelayout/filelayout.c             |   8 +-
 fs/nfs/flexfilelayout/flexfilelayout.c     |   8 +-
 fs/nfs/inode.c                             |  54 +---
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
 fs/smb/client/cifsfs.h                     |  17 --
 fs/smb/client/inode.c                      |   6 +-
 fs/smb/client/readdir.c                    |   2 +-
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
 include/linux/fs.h                         |  28 +-
 include/linux/nfs_fs.h                     |  10 -
 include/trace/events/cachefiles.h          |  18 +-
 include/trace/events/ext4.h                | 427 +++++++++++++++--------------
 include/trace/events/f2fs.h                | 172 ++++++------
 include/trace/events/filelock.h            |  16 +-
 include/trace/events/filemap.h             |  20 +-
 include/trace/events/fs_dax.h              |  20 +-
 include/trace/events/fsverity.h            |  30 +-
 include/trace/events/hugetlbfs.h           |  28 +-
 include/trace/events/netfs.h               |   4 +-
 include/trace/events/nilfs2.h              |  12 +-
 include/trace/events/readahead.h           |  12 +-
 include/trace/events/timestamp.h           |  12 +-
 include/trace/events/writeback.h           | 148 +++++-----
 kernel/events/uprobes.c                    |   4 +-
 net/netrom/af_netrom.c                     |   4 +-
 net/rose/af_rose.c                         |   4 +-
 net/socket.c                               |   2 +-
 net/x25/x25_proc.c                         |   4 +-
 security/apparmor/apparmorfs.c             |   4 +-
 security/integrity/integrity_audit.c       |   2 +-
 security/ipe/audit.c                       |   2 +-
 security/lsm_audit.c                       |  10 +-
 security/selinux/hooks.c                   |   4 +-
 security/smack/smack_lsm.c                 |  12 +-
 195 files changed, 1101 insertions(+), 1166 deletions(-)
---
base-commit: 2bf35e96cf6c6c3a290b69b777d34be15888e364
change-id: 20260224-iino-u64-b44a3a72543c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


