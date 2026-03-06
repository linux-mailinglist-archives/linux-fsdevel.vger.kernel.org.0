Return-Path: <linux-fsdevel+bounces-79580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AJMFSebqmmbUQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 10:15:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B321DB88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F2B030325D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF2344D90;
	Fri,  6 Mar 2026 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyR366hp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9A33B6CB;
	Fri,  6 Mar 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788508; cv=none; b=e+8vKnSn84cLNLd4ZqnhbpZQ8kIURZi7XqPNUAdVTGF1vkwY96Wprk7pcQZqALiso2xj+M5ginnmVgyAJ/eu6l2y/nFH+GVemtYGsUX4wnV8uZpVUki+WoGqVbpm++w6Mtq9LozfiSAAp/feMTT1fvNbOojpBxMNczzpuS6lCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788508; c=relaxed/simple;
	bh=7RvOdnrFs/iEe9G84pPe+q4PLv+gFd3Sa58Nl0eTC8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhkrUNew/kVjjDX00OOp2HBs5hVrUxZeQ+VO91IGOaVaGPyrv/7spRARgvL4zQSEQEm5Soq62lHODY+P8EFU2BSfjsBxus5wxEs6wP6knTO423TDZzAZK0kJ8WCPPK06gaQ5BB7kgguVlb6DEYYVM5ZKe5J9x4Q4fnwuwp8KipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyR366hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C425BC4CEF7;
	Fri,  6 Mar 2026 09:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772788507;
	bh=7RvOdnrFs/iEe9G84pPe+q4PLv+gFd3Sa58Nl0eTC8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyR366hpH5SBgvb3stJOO+3+JgB4eyp8Ub6SIcEY5Wv5+DIXq3qwQ1akUuyGzm4GI
	 oVWqv0SYGKFQk/aIJcLbDc3SkZdh03GwnjPJPfc8DHBxnnTk3pTwokbH2aquirHejB
	 nz1gJxpKMhkWSd0cvlbIm12Yo0dUUSzlaMGnA70lo5LCfYmGHYkoB3BEoaWxEw9skO
	 0XSBCv8+kTn/Gf5HrA+24udlPqxoLhC1731SEC00PUdG+t6hKArOjAPEtT/hHxR1LY
	 s+VuE2scXcViJMBvNGcnMzw7bfK0RAeQxP1RLAMHfxMD+S62KQ5DOUo/0QF6h57vkJ
	 rf8R3FiiVNktg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	fsverity@lists.linux.dev,
	linux-mm@kvack.org,
	netfs@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-nilfs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	autofs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	netdev@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-x25@vger.kernel.org,
	audit@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <sfrench@samba.org>,
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
	David Sterba <dsterba@suse.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ian Kent <raven@themaw.net>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Nicolas Pitre <nico@fluxnic.net>,
	Tyler Hicks <code@tyhicks.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Anders Larsen <al@alarsen.net>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Martin Schiller <ms@dev.tdt.de>,
	Eric Paris <eparis@redhat.com>,
	Joerg Reuter <jreuter@yaina.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v3 00/12] vfs: change inode->i_ino from unsigned long to u64
Date: Fri,  6 Mar 2026 10:09:33 +0100
Message-ID: <20260306-kennen-zubrot-2605fcfd6950@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708; i=brauner@kernel.org; h=from:subject:message-id; bh=7RvOdnrFs/iEe9G84pPe+q4PLv+gFd3Sa58Nl0eTC8M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSumvWu2uNxbBFXikaZQKrMtl0PLj1c+kZGWOrvZiHz/ W/CTGOed5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk4A5GhimT869vPnNH4Vqj t6Tr0fqPLXs3v0g/qbXpwf6o52L5D7YyMnxU+idovG+O5JQe0WVOK45/sI9bw9AjJfah78/izrQ aXg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 298B321DB88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79580-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,intel.com,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,infradead.org,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.ne
 t];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 10:32:30 -0500, Jeff Layton wrote:
> Christian said [1] to "just do it" when I proposed this, so here we are!
> 
> For historical reasons, the inode->i_ino field is an unsigned long,
> which means that it's 32 bits on 32 bit architectures. This has caused a
> number of filesystems to implement hacks to hash a 64-bit identifier
> into a 32-bit field, and deprives us of a universal identifier field for
> an inode.
> 
> [...]

This series makes me happy. We've been talking about this conversion for
a while and I'm thankful that you did this work. Without the automation
available this probably wouldn't have happened as quickly as it did now.
Let's see what bits and pieces it missed.

---

Applied to the vfs-7.1.kino branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.kino branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.kino

[01/12] vfs: widen inode hash/lookup functions to u64
        https://git.kernel.org/vfs/vfs/c/2412a9fa518a
[02/12] audit: widen ino fields to u64
        https://git.kernel.org/vfs/vfs/c/a5e863be4d02
[03/12] net: change sock.sk_ino and sock_i_ino() to u64
        https://git.kernel.org/vfs/vfs/c/c21144a0a33f
[04/12] vfs: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/5e5c380870b2
[05/12] cachefiles: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/25291f67aad7
[06/12] ext2: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/797d04a355e3
[07/12] hugetlbfs: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/3c976fb36a9a
[08/12] zonefs: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/988f68c01b3a
[09/12] ext4: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/1c1427c79bc2
[10/12] f2fs: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/6e62bf74bd8a
[11/12] nilfs2: widen trace event i_ino fields to u64
        https://git.kernel.org/vfs/vfs/c/6ce73711525a
[12/12] treewide: change inode->i_ino from unsigned long to u64
        https://git.kernel.org/vfs/vfs/c/af82d143e869

