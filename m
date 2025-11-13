Return-Path: <linux-fsdevel+bounces-68124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB48C54EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93C6D343DA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA7187346;
	Thu, 13 Nov 2025 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="O4pRq1dr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNkVACbU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B71339A4;
	Thu, 13 Nov 2025 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994384; cv=none; b=t0XJOBjW+dr0ohu+BS/yPG2g8xbO7hjSmmDzDlGuGUMOQSiajz2V/DeE+lMo0pk8PMXChCXUzx5QNO7E3U1DU5xB6HQ3V0KP4tgysDIe+5YSgjsUDKhyjSzQ6jeTp+Z+TRIW+Hrv1krpWImnUqOvkHUgulCpvxppFjGhD6HBp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994384; c=relaxed/simple;
	bh=TJwyi5EieJtBOl4MGvWnSsbCY/npeGYdLD56sxhs/Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsMxe4sfIC2aJcJ2p7i9jCbiQ6UkrbXSue0XjKVWIa+l8aft4T/VRnsAU3+n3/buY89pm1uDEo1F8SclGJTJBYSXgHFrfF2x0LeHym8kpE6MzazHom7HU/SivriO/GC62FA8j2nl9Yh+OpbZyOIdCOm6sNKePxkcBNXejjhro7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=O4pRq1dr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNkVACbU; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id CF20713000C2;
	Wed, 12 Nov 2025 19:39:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 19:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1762994379; x=1763001579; bh=ZcfDp8RWPX
	wzh2Pizz4BiocTQ/th9SdtOGswSdZ17YQ=; b=O4pRq1drv3epaRfZaM+GglEA01
	+qrEBMFFIn3HnP875jm/k9ylQsErDurHJSPkZGtdCZnH8PJPYZanc+L1bvk3EGrD
	Ze6W4ta55jG1ZfnxT5s3BjYW8E6Ljz9GOE4+mnTaAw2YS/Bb8xTPfZN3YTgdj9VK
	WP208FkEEbArCsWez0fErUDJuyseqrUuz5Q7xbrqx5BMvPfeG75lGUUdacfDrD6d
	URRX3JSDdrEl5AFj536LWb6v7b5XnMtxmJqWO1LIfZLZZ6Hr3iXrbDPKaZzNp6uX
	jjXCdMbFf5yxz0Ixz5aVMlEKfuCLCotImCU15yP61NtNl6qkZ8qbZx/WvO2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762994379; x=1763001579; bh=ZcfDp8RWPXwzh2Pizz4BiocTQ/th
	9SdtOGswSdZ17YQ=; b=jNkVACbUq/bd+GdsfhbmMsBZnO0P/rOxsSWeNUzNfAIY
	LAJVE0CPqtz8yibS2dd14Yr4wKULYYd6ow11PIkkmYBt4+JYepuvcn8OqIMGay7t
	E0BdzrF6jBcVO+UoDNSmqdYHLDFTOV5YASXiukf/Y/wZ/su1ZBOIw0X7DIpGAAeQ
	8E+17rUPh/V6AEQgZWEiovcyLBP9SQe2rqDHNNUvaqIZBJPvoV8dej84X6vFWA1d
	QqW/th6ZkNq6Ev8sAxVdxsv1rVjAcx3OQAbLdwBtlf67YRA4lL0pa+5jufkfkqZv
	2NxSTheKdxaHUFn6Cwws/v2wsACUfMotbOTABXuZyg==
X-ME-Sender: <xms:ySgVaSuhHGIoPemjhO3_RP7THvbZEfG2j5XmHefm9LhJUrgMrARGqA>
    <xme:ySgVadOGx0c5gEVCB0eufTrvnVMFq_4GUh7FlSWZn-1YBz2uFTVL9V_24NnNy8Lk2
    38G-eomyOArrgEjTjFgK0FCY-wF5o9GUWQoxL1qVwB2Qp2DhA>
X-ME-Received: <xmr:ySgVaUmbyIwj7sYttJskKMoxcMZ0i_lkPjdqRKom2-SWgtYLsAPIDTJyNqIzjuBQt8me6OUGFLIZIBLAv6PCqu3Ohy4zvuv_IUA6n6u8Z1dh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:ySgVaUZLyl0iwjt-CXnrl-0Z-YVIZaTCbwpMLS9C4wzRDrtIRXa07Q>
    <xmx:ySgVaT3_JxtPXxDUCSXKxLX5VLMgg2Hsr9I549ZbI4NZsm5eAgg0xA>
    <xmx:ySgVaaSPzY1AP3_JhOH1FkF5fP0F5KnW05LAJac69ozFATQne5LcwA>
    <xmx:ySgVab8saJXwqBTEiO9RIiJZLXdsUWOv7V80GW03sX6kT382_BTbcA>
    <xmx:yygVaXJUQspliZ210PuxeaGCWSnUfYzoMh9HChSl_4Qniw0pZcGbVpgx>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:39:27 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v6 00/15] Create and use APIs to centralise locking for directory ops.
Date: Thu, 13 Nov 2025 11:18:23 +1100
Message-ID: <20251113002050.676694-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following is a new version of this series:
 - fixed a bug found by syzbot
 - cleanup suggested by Stephen Smalley
 - added patch for missing updates in smb/server - thanks Jeff Layton
 - various s-o-b


Previous description:

 this series is the next part of my effort to change directory-op
 locking to allow multiple concurrent ops in a directory.  Ultimately we
 will (in my plan) lock the target dentry(s) rather than the whole
 parent directory.

 To help with changing the locking protocol, this series centralises
 locking and lookup in some helpers.  The various helpers are introduced
 and then used in the same patch - roughly one patch per helper though
 with various exceptions.

 I haven't introduced these helpers into the various filesystems that
 Al's tree-in-dcache series is changing.  That series introduces and
 uses similar helpers tuned to the specific needs of that set of
 filesystems.  Ultimately all the helpers will use the same backends
 which can then be adjusted when it is time to change the locking
 protocol.

 One change that deserves highlighting is in patch 13 where vfs_mkdir()
 is changed to unlock the parent on failure, as well as the current
 behaviour of dput()ing the dentry on failure.  Once this change is in
 place, the final step of both create and an remove sequences only
 requires the target dentry, not the parent.  So e.g.  end_creating() is
 only given the dentry (which may be IS_ERR() after vfs_mkdir()).  This
 helps establish the pattern that it is the dentry that is being locked
 and unlocked (the lock is currently held on dentry->d_parent->d_inode,
 but that can change).

 Please review the changes I've made to your respective code areas and
 let us know of any problems.

Thanks,
NeilBrown


 [PATCH v6 01/15] debugfs: rename end_creating() to
 [PATCH v6 02/15] VFS: introduce start_dirop() and end_dirop()
 [PATCH v6 03/15] VFS: tidy up do_unlinkat()
 [PATCH v6 04/15] VFS/nfsd/cachefiles/ovl: add start_creating() and
 [PATCH v6 05/15] VFS/nfsd/cachefiles/ovl: introduce start_removing()
 [PATCH v6 06/15] VFS: introduce start_creating_noperm() and
 [PATCH v6 07/15] smb/server: use end_removing_noperm for for target
 [PATCH v6 08/15] VFS: introduce start_removing_dentry()
 [PATCH v6 09/15] VFS: add start_creating_killable() and
 [PATCH v6 10/15] VFS/nfsd/ovl: introduce start_renaming() and
 [PATCH v6 11/15] VFS/ovl/smb: introduce start_renaming_dentry()
 [PATCH v6 12/15] Add start_renaming_two_dentries()
 [PATCH v6 13/15] ecryptfs: use new start_creating/start_removing APIs
 [PATCH v6 14/15] VFS: change vfs_mkdir() to unlock on failure.
 [PATCH v6 15/15] VFS: introduce end_creating_keep()

