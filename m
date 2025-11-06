Return-Path: <linux-fsdevel+bounces-67237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14C2C38889
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D7E3B388C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8B11DFE26;
	Thu,  6 Nov 2025 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Vavf093Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfnnnsrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72433E7;
	Thu,  6 Nov 2025 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390438; cv=none; b=l4lDySHiT6G6wIaJ4TCBXPKTiKfiPoIb3vlhjhguV1cvlzuLnSRs1+m6G41WVrzFH7d7Kwr4K1v+NH+h8RqakxrVEj8AeVWTR/UUSSucBaZGY/IVxycDpgPncZ1mB/fBiGdkoH4iY+XdwF8FX6toldtMCCHqkFFQNgishnmQn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390438; c=relaxed/simple;
	bh=3ERjpLCmuIj9csZ2sFv6nTmhf6csyCGZas5vCN/TMfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kj6w7u7noEoSrWotdlq8COerqf4/hwzeItBAtFbShXwN/tf3HxxoDyiGpSXb0Rp3Vhi3l8KtwVRRWOW9UYd5y2J53O8avnlAq5V3PP1b0Le+h0SYmf36VPQ83DRUy0nrDU3o2xtegUJkwcmNvA9szY2lNHtMfFZnN604NEZO8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Vavf093Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XfnnnsrX; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id D6C4713005D8;
	Wed,  5 Nov 2025 19:53:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 05 Nov 2025 19:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1762390434; x=1762397634; bh=fW2s5ypcy3
	mE4M5DNemKjsqRw12Wruu7AEwnCZErNvY=; b=Vavf093ZKA3HaVhSLm3vlSy8Xd
	u0/5BH0TUN7wjN7r7AlMjXvF2BpEAPO67/rudwOQwwEiiNXZWFRKsdhPxEFx/0vR
	q8eJ8l45Azxa213QOlq/txxZSGJPD0pPzDFRnpEmM/3YIWq7vly659u4OPkgyef1
	dxndM72zUIuOZEqEnFiBYI7PeNbz+R/Usg9GvQBtK6RSlHRcv9sK8SvFCeHT6fbt
	AlsV8kv6W0CoXXKWhZ+RQ/fNpuit9Cn/c/6vyNNq31CcBUBKQFSgpwX+jTOYseBj
	rlrJY32JklsWuvGTEVnuQmb6SbNnHOlu1bqxN8KY5R/pLruXNs9NgF5nTBpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762390434; x=1762397634; bh=fW2s5ypcy3mE4M5DNemKjsqRw12W
	ruu7AEwnCZErNvY=; b=XfnnnsrXCRSGFq11XFo2dnyX9afQskqjRuN4zOxhuKc+
	QEaAJrZyyqmOeS/brWS6kHbd4MsQD2vzOXUGgEXQxxC7T4YwWHOJJDXBXkTXES7p
	7NYDhX6RCBvrmoGyyAlsJNutNgW/edGjNMabYrdjzhuTcsc5oxcK+XtolNytCdcF
	GFjo1qkifvGQu8q5Gu2YeCKTJyDFnTKKoghHuouiVuZecxMAw++fnW0O9cFwHEn2
	oPZI2nVYDEYcUY4a7I4HQFVWPIWF3N4iwBe+3loW7PQAbW6tAZqqytGC7lju2nOm
	+HXffy50EjFktW1f2DHhz6AxedNfLPxQqXAmSYiBLQ==
X-ME-Sender: <xms:ofELaWVM0Ec2_3qQmdGrCZh7bOmwSLLeNpfej0MUloFVhDsEruyleA>
    <xme:ofELaXoTcah6tJhEe2L4jeQ45KX76lk6p5f3XSAib8BO2dXitRNR8_BuHcUMoo80b
    nJlT89nCK0ue2vUhe7k_NBATsa4GCxE6sPJFc8iTb3OQbyFmw>
X-ME-Received: <xmr:ofELaXYsQ_tE_nET7oQsgxRXL3aP83AKuo3EFeq7hN0WswSLYRPoKPu-KmQ6woJMMl3MUIb4qwz0l2hTo6ZA7pJXOp1yVT5N5D2cV5DgFkOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ofELabCTghuLfp0--0hYEkU2bwBXxKLJ71aRdgB6mvhwcj8SFcycAQ>
    <xmx:ofELaSGZGYnMpOUyRsWpCEX8xkOYu-fRpkQJkv-fLFW6suYrq6hQ9A>
    <xmx:ofELaXznwnvFLJ_kGJc6OO6fsviAct-9OHOf8EWvQ0Tw_WAOSAA3VQ>
    <xmx:ofELaXcMf5i-Rj0C8H43I4YDLffIOq2ZHMfIdGInyI7PfUgf7YJDMQ>
    <xmx:ovELaatntL_mJ-3ijxYxjoG5eH2TE3wdGzPm9xGwHejIKZ20FUl_jMTO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:53:43 -0500 (EST)
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
Subject: [PATCH v5 00/14] Create and use APIs to centralise locking for directory ops.
Date: Thu,  6 Nov 2025 11:50:44 +1100
Message-ID: <20251106005333.956321-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This version contains a couple of fixes thanks to Al's review and Dan's
robot, and a couple of s-o-b and a-b tags.
It is based on vfs-all (e90fbb585e64).

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

 [PATCH v5 01/14] debugfs: rename end_creating() to
 [PATCH v5 02/14] VFS: introduce start_dirop() and end_dirop()
 [PATCH v5 03/14] VFS: tidy up do_unlinkat()
 [PATCH v5 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and
 [PATCH v5 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing()
 [PATCH v5 06/14] VFS: introduce start_creating_noperm() and
 [PATCH v5 07/14] VFS: introduce start_removing_dentry()
 [PATCH v5 08/14] VFS: add start_creating_killable() and
 [PATCH v5 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 [PATCH v5 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
 [PATCH v5 11/14] Add start_renaming_two_dentries()
 [PATCH v5 12/14] ecryptfs: use new start_creating/start_removing APIs
 [PATCH v5 13/14] VFS: change vfs_mkdir() to unlock on failure.
 [PATCH v5 14/14] VFS: introduce end_creating_keep()

