Return-Path: <linux-fsdevel+bounces-78316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJS/H40lnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:26:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00818D20D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFBF13066BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121D3451B5;
	Tue, 24 Feb 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Bm41EYvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVWCZYzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FB33A9C4;
	Tue, 24 Feb 2026 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971962; cv=none; b=CX1XtqMiUWoFYxxNbwiRWqB8t26d3UIuL+thzkn7Mbw+CQxw7xOT+/MjAjTCapb0/8F/Uk7GHwLWAqAlgXUrFPRWuM/D6XYNRHdRm7HdbiianuSVNjJYXY0t1Of5UNu0K8L1q+Tl2VRiA++QVhrfSitfoIUPY2wJGB2+lkxRFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971962; c=relaxed/simple;
	bh=XNsgNmZoNlsbdzYWAoyx+rMJkU0C5hWhl58m7ePFqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMAVZm8FpKEv8A1iJbO3iKwS+SwnPZZCQKWuAbC4LVyjaXIEe70ednw5htv9S3FVtVkMQLWjiJgu0akPfEKA/8kTFxsDADBWZJVaaql8i/W4i9ss8Fq/tYyvgZ+O0wstU2TVH4sexWAZcJk7l+YNf13f8Cw4v09HTw/R81JIkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Bm41EYvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YVWCZYzt; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 3CA271380B87;
	Tue, 24 Feb 2026 17:25:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1771971958; x=1771979158; bh=h1rNXkHkcZ
	4cMhepaUBJCHY4sMt0fLPm1jE4sfNdLx8=; b=Bm41EYvDY3wWjoKO9Dg4GQs+K7
	cZ+9rkdCqW4DWg2/n02Xxhll8WET1UKRv2xjVnyISv5eTeXPxw9lMuqv5LWlj2/l
	YzC39szJXiGzqhHmPIW5unvAljd9AINf44jC46QUbSkxJC4Uzj5S8g9wTyymc5eK
	6umAKASGZ5SNoXvX4WYCPTmKnbviVxKOlaNXi81+nMH7HsX3Dwh2OQCaVce5MXUm
	TOefBGwt4W4JhCs2+rPA2w1fHcgyz/0nJrkPoTgnTm7f1ragqA5M49ZsUqF41+Lz
	48FljGfvzG8iuI1HHzhizGeeqEg7uEPgx68xfh1Fw0MLAPKTcktOG4vlSi/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771971958; x=1771979158; bh=h1rNXkHkcZ4cMhepaUBJCHY4sMt0
	fLPm1jE4sfNdLx8=; b=YVWCZYztzFJEgw0/P15jwVo2Zq6mHpQLCPU8/3LKBLGh
	57MvUxA/kPjZOfEgwroCqeJIvAocpDonpTTzeO7VkSd0vdcYEgfAjfz1S+J27yPH
	ibp9xn/SlbXIOAANLTgfTdZ1VBtOVuFLNu74RzyUBZ2rzwFmi84V1lO1ee7nU5eU
	Swv0iwDFvsYUytGKwUXuWkuDN3ReejDJF50ww/Sv1JfeqxdlO97psVCMg5qpJdLN
	l5589hLjqQ/AdCfNnx6DH184ui/VMrHllibdRaU1oS7s4SUxTuLHTlhmeIUXIPmc
	3w/hA6dPTMTYuh/8a/5BjLr6Ydwxhtk1buo0GnixtA==
X-ME-Sender: <xms:dCWeaeN68INVWUP76lm6LSn_-KPn-BpbZV20agYBbf3-MRusda4nxg>
    <xme:dCWeaQ6MOi1M6jhBiz321-vu_icRM95I_6tTHrBS3kjPG6P4H7qv4MS40GFqlOXeL
    JWaPc9gZdbNSC717W5pWIYUDnEX-0yoZjFskhRJ0jAXvUrcsPs>
X-ME-Received: <xmr:dCWeadx1Z2VeucV0GVjerBQHJFbLfewF1ivvXIk7V7xM93rCDRjuVW8hJh3_pbP0Wvi7GoOlKRPxJbTKzbfoXXp4xdHx9RB-R1G_GBK_NM7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dCWeaYTnnAGgE05nS_GR7sZfZRuy59Y0zqIVusI9LOlQQpHGDIRuzA>
    <xmx:dCWead99R1zdBpDm82pTcMeZYBPKAx6sGnfp62gsSSCupDW5ykpRug>
    <xmx:dCWeadIDZPDRPdCUp43NByezinPatv8WUvR63xK4ud410k9ifxlfSw>
    <xmx:dCWeaZtyjSe5uARiEy6VurJ-WbKbb-zsEPhCG0-qX0zcrp0SUVBvMg>
    <xmx:diWeaSWS-R28POMt9UY8aq--iCqH1D9ZQByHSNfCqNcdrRW7UTOfk-tL>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:25:50 -0500 (EST)
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
Subject: [PATCH v3 00/15] Further centralising of directory locking for name ops.
Date: Wed, 25 Feb 2026 09:16:45 +1100
Message-ID: <20260224222542.3458677-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78316-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:replyto,messagingengine.com:dkim]
X-Rspamd-Queue-Id: DF00818D20D
X-Rspamd-Action: no action

Following Chris Mason's tool-based review, here is v3 with some fixes.
Particularly 06/15 mistakenly tested the result of start_creating for NULL
and 09/15 had some really messed up flow in error handling.
Also human-language typos fixed.

This code is in 
  github.com:neilbrown/linux.git
  branch pdirops

For anyone interested, my next batch is in branch pdirops-next

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

 [PATCH v3 01/15] VFS: note error returns in documentation for various
 [PATCH v3 02/15] fs/proc: Don't lock root inode when creating "self"
 [PATCH v3 03/15] VFS: move the start_dirop() kerndoc comment to
 [PATCH v3 04/15] libfs: change simple_done_creating() to use
 [PATCH v3 05/15] Apparmor: Use simple_start_creating() /
 [PATCH v3 06/15] selinux: Use simple_start_creating() /
 [PATCH v3 07/15] nfsd: switch purge_old() to use
 [PATCH v3 08/15] VFS: make lookup_one_qstr_excl() static.
 [PATCH v3 09/15] ovl: Simplify ovl_lookup_real_one()
 [PATCH v3 10/15] cachefiles: change cachefiles_bury_object to use
 [PATCH v3 11/15] ovl: pass name buffer to ovl_start_creating_temp()
 [PATCH v3 12/15] ovl: change ovl_create_real() to get a new lock when
 [PATCH v3 13/15] ovl: use is_subdir() for testing if one thing is a
 [PATCH v3 14/15] ovl: remove ovl_lock_rename_workdir()
 [PATCH v3 15/15] VFS: unexport lock_rename(), lock_rename_child(),

