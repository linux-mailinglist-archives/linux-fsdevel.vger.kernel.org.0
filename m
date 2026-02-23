Return-Path: <linux-fsdevel+bounces-77882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ7IK5epm2l94QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:12:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDC171143
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 02:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361C33027122
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 01:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826023D288;
	Mon, 23 Feb 2026 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MtC+FEAj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5eLcKsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33E1A76BB;
	Mon, 23 Feb 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771809158; cv=none; b=UTuIDq4mqFO0zluFYt6WGUewiyJTubWya910COoAsTLp+pnZCmoMclW8Jk+svjS7v7ezstjjWe/WTTxxJgCLFAbmR9qsLDhMpKRJ2yZdCrCwFLfO00cEbsppnynNVxnW8MqEuDc32fLW5WpmLoxqMxHqzHtJMkG/CXOHEhKI1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771809158; c=relaxed/simple;
	bh=JpV1NuU9nwQ+TlujBiNkZGL25g2X4UIS/xw10PvqQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Od+FdxJDPPUdo9b0AH+u0TqvcP7Exn6b3ZPLsvC7f1lcnDpIqe5b5KgvGAuhCias8t1QQmJ9b4p9+Wd78RjPZL6TT3QKImlBEUYh5np4vwcVlninLc7jXw0JPwuiYKaNlLzed2pPy+ZfVu3bz05T5yKHgTAntW2RDh1ddSfZlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MtC+FEAj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5eLcKsZ; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 24DBC13807AC;
	Sun, 22 Feb 2026 20:12:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 22 Feb 2026 20:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1771809156; x=1771816356; bh=Q+mh2yyGZq
	5WunF2kc+4OeWErNogZ7jVroU8N40m4fY=; b=MtC+FEAjwHg9g3e3ctY3Ybi2vS
	nxSQCxxNFDp6j0UfHeq+x1Z9sq/Trs1NhQyPQu9KmnGIV2OY0xmBTk0KPqRgLdh8
	eVVSwKFVunpeH/DqnRvnJf5oMa9lldCsG3pARA+2Av3Sgw2+zaEPkLrk113Rcf/w
	qErWtkNVfCbXLLsZLvVYNrtdIZuIZP9cqNDNtOjNHY8UvDpQtxtaIy7adti/h+da
	IDC9mLLw9b9Bb/opjTSFaP4Zq3CpB3xfDwYE0FpEPaZtmfTQu8b9yNkNqaq8R1mN
	T8MRLbuygGs0tIK8UKJ9s6W3kf/rlW5/Ewo1vUsqGMCbd2D7bU62RPBGNhng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771809156; x=1771816356; bh=Q+mh2yyGZq5WunF2kc+4OeWErNog
	Z7jVroU8N40m4fY=; b=P5eLcKsZ1fQ5I3g7yyn3VAlTrgB0Sg2eRZTajpvp9s7o
	I5mZVUCjoSpLIU8GO+INw+7P2q6MeXEJCqs9H+CggS7+W78nyTzJ4vgjJ/ZMXu4/
	UWh1oIRu/OZTStB9+7kGTR9FRQIGJyjrSvX1igiXoCmqY1xfhPwLFVsMVTJgcFSr
	PEtAdVe9DBFykt2EN3hwy3sJkKSDv+R/jj0w1+S49hxZjtqNygyNVByyXTt32S8y
	zjfNGaJ0fkKlnqJDnfJN5LnvzATly5BmpG7FsEXW0E0OWWXhYTnHTu2+QYF/vYtW
	3E/9zFqw5VBsOdYb0o/msxHkFcRtT7IqTbmo5LAebw==
X-ME-Sender: <xms:g6mbaTIWSciWDUW5YbgNm1xnKbJW188OucP2pQUIVVJfD2UaWDlioA>
    <xme:g6mbaTCf5AtKv8o2l1vhW8v9s-4BfCaifrACq2ZkRtlEk4Ix0ZF7z-O4ROfgDOe1t
    TVcS1LJPMiPLZRODJxcAlwWTbE9ojBJn1fvdJzr2lEDoStA>
X-ME-Received: <xmr:g6mbaUj4eEn_6AYbcdF3heofeE5J31LR_KYy049JgyUrC-iaJSsZwwEhyUniOuIn-chkTO9ewIRy43F6ziDstONjZkrvVEqWQTddqdV7jhn6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghp
    thhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:g6mbaVO5uhi7oS_NveKK306f9j4ZngTfQYMhGcCKjuJtoXkryhoCPQ>
    <xmx:g6mbaTaMzhtM5o1d5AjVgl06UrQARA5xtik1TtXa0Nx70S3uAX_1YQ>
    <xmx:g6mbaS9do85gcOzJMD4qjx0_b5HRbHyLIQZSFBLGN9iKA-dR6Q5RKw>
    <xmx:g6mbae0VPcMG7yc215y640vXBlb51M6h4D07vwOdYGkD5f3Yuv8TXw>
    <xmx:hKmback03OfbZowBOTLFzR8QWT7VcnL7NeazcmOd4NwThxMCN-AENQtw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 20:12:29 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 00/15] Further centralising of directory locking for name ops.
Date: Mon, 23 Feb 2026 12:06:15 +1100
Message-ID: <20260223011210.3853517-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-77882-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,ownmail.net:mid,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 19DDC171143
X-Rspamd-Action: no action

This is v2 of a series I sent shortly before the merge-window opened,
and now that it has closed ....

I have added:
   01/15 to improve documentation as suggested by Darrick
   11/15 as discussed with Amir to simplify the following patch
   various RB and AB (thanks Jeff in particular)

I'm hoping this could land in vfs/ shortly (tihs month?).  I will then have another
series of patches which make a small start in changing the locking
rules, which hopefully can also land in the next merge window.

Original patch description below.

Thanks,
NeilBrown

I am working towards changing the locking rules for name-operations: locking
the name rather than the whole directory.

The current part of this process is centralising all the locking so that
it can be changed in one place.

Recently "start_creating", "start_removing", "start_renaming" and related
interaces were added which combine the locking and the lookup.  At that time
many callers were changed to use the new interfaces.  However there are still
an assortment of places out side of fs/namei.c where the directory is locked
explictly, whether with inode_lock() or lock_rename() or similar.  These were
missed in the first pass for an assortment of uninteresting reasons.

This series addresses the remaining places where explicit locking is
used, and changes them to use the new interfaces, or otherwise removes
the explicit locking.

The biggest changes are in overlayfs.  The other changes are quite
simple, though maybe the cachefiles changes is the least simple of those.

I'm running the --overlay tests in xfstests and nothing has popped yet.
I'll continue with this and run some NFS tests too.

Thanks for your review of these patches!

NeilBrown


 [PATCH v2 01/15] VFS: note error returns is documentation for various
 [PATCH v2 02/15] fs/proc: Don't lock root inode when creating "self"
 [PATCH v2 03/15] VFS: move the start_dirop() kerndoc comment to
 [PATCH v2 04/15] libfs: change simple_done_creating() to use
 [PATCH v2 05/15] Apparmor: Use simple_start_creating() /
 [PATCH v2 06/15] selinux: Use simple_start_creating() /
 [PATCH v2 07/15] nfsd: switch purge_old() to use
 [PATCH v2 08/15] VFS: make lookup_one_qstr_excl() static.
 [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
 [PATCH v2 10/15] cachefiles: change cachefiles_bury_object to use
 [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
 [PATCH v2 12/15] ovl: change ovl_create_real() to get a new lock when
 [PATCH v2 13/15] ovl: use is_subdir() for testing if one thing is a
 [PATCH v2 14/15] ovl: remove ovl_lock_rename_workdir()
 [PATCH v2 15/15] VFS: unexport lock_rename(), lock_rename_child(),

