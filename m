Return-Path: <linux-fsdevel+bounces-66386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1947EC1DB64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 00:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF05D405E39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DF31DDB8;
	Wed, 29 Oct 2025 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GhjEouVc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVJBB8ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2B31BC96;
	Wed, 29 Oct 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781475; cv=none; b=KOzLg0FCs1dL7UJFkRihYP8m6oV2jO/EUQ6I4KVA4Y8Lpgvqc9/3tcECapSRqK26/LsFrcHUyXBDZXdTrAGjC7K1jklTn8OeiJsfJgXLXahlqh1ZNWcoIJ+hWy8TOcW8ZTdysjrY0lybQ6V4HYPgQYnIVH9AHvbU0bxRaeEcEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781475; c=relaxed/simple;
	bh=w1kCxW1iy8c7ihHn/8+NGQc8R16rrkANmzgDW8z4SK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sodaNFZAmJTLBnbyHbwkbewZV6SZLFlYP4ZNlrAkG8wdB3YBBNHv7lgLe5YjeUhlbigX9v6dkQ1AgUjxMdXOJW6mbod6+0xslwrnszmdNqYz7+Uvj3KjHeA5Ao22li/apQOm0HioiuLC1d8fFW4NHx/YFuWbya3REI1vdX3KSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GhjEouVc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVJBB8ko; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 7E41A1300085;
	Wed, 29 Oct 2025 19:44:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Oct 2025 19:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1761781471; x=1761788671; bh=3x5QrKJbAU
	5RZlYDSzt8Tpga/kvzXZxC49Muc/R7QZE=; b=GhjEouVcRX5SJnd2xC8PpJrDd4
	5gkLEdREwDoq8sl+DBfc/BmSP3BbU8Mna/yRQ0mJT+YerlIyKxQnHG9JNIdfdvWG
	SEgIFc0Ia63eBD42oxiyZb0QhCz9o3xmVx7jBrsXRZ49p5n5OOlsWj0hSQbFvZeF
	z5AqkgCSiUEnM/CNER15/xVrFQ90ZlFLCV40LolbJNPKakcnQHHX35eus1VgipNz
	9mrDLPYpRiymWw5AnPf2k2bnhd7JdUrzezStmq3NbcceOpamzP50amLIRGUUtc2B
	NQQQo5tUZY5nwh3gZyBpQY/zBR5ZdH71eGZNqzcpALYYSRkPCqHmOjsoY3pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761781471; x=1761788671; bh=3x5QrKJbAU5RZlYDSzt8Tpga/kvz
	XZxC49Muc/R7QZE=; b=FVJBB8kohSZHiLJIbGPXBDlmftX29JM9LBAqg79dTWqk
	yz1+x4bVzMixLyeUBD6UMAtReNbi/HZFEx46Wq6nfklVi17Cy2HK6aBAMR8ZX5NJ
	r7/Uf2cBjw48pz8C6vmTnu0Q/8zEPGqjc0doo38FNUGDuD3FfJh72Mu6sRMeVYQp
	Dv65nNKDg5/a2VSp3rxOwLbG3KmZl6lhfRoiCJkDROdMh7QUeHeeU6DWJRwt7UNn
	LoItIfP1jQ3FLUiMoV4dzXKGdNizDLgTl4FqI5Ll5IBSQIyTOHMZXZd9jUSvHBaP
	xpcmVAlz4RvT6v0XDGGxxzdoHjf9otwjESBsILdBQA==
X-ME-Sender: <xms:3aYCacW0EklVbBr52odzgwMIFadqVZiY_9E7tudg5vTOUlukGR89QQ>
    <xme:3aYCaTdYh1VR4XWnn3OEfjhVRMW9llb0r_xZdVgEPJBMwC0guDDC5CXJvsrDKgSU3
    O7sPHab5vsYfOwx2ifIrmOdATuza71bDXE5CgYxiEzhilZdiA>
X-ME-Received: <xmr:3aYCaROZCepQe3Hu21UI6QwqCD0nSkfSZsBAwHrWmKgYq6O-H3DBzXb5QvKORxj1yfDg4BDFbGwZ_wxSs6RKBleyvZEnJ0v1TFpLhCQQZgBx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedupdhmohguvgepshhmthhpohhu
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
X-ME-Proxy: <xmx:3aYCadIU3g7PRNyg0QpRBi516BNZpWSYBI7wNvYksLhLN5HboYbfKg>
    <xmx:3aYCaUi8yMV9Wi329iHBU0ZD5tJV3Inub4fLYJfrLtuvM8baE8Z65g>
    <xmx:3aYCaTfdaKHZTaBO_Bu6_k6dJq0TTIMOZXGLZvFcx2pwEZqLY08rbw>
    <xmx:3aYCaU7RSF_CkX0ckxw-AONs1hAD9ap10WIuJvbkwYEEi3Piz-5pGg>
    <xmx:36YCaR9pl7VkHXdYi10atgXk7DONC_H6TEfCcxqFVlKz7Swud_TD-zUd>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:44:19 -0400 (EDT)
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
	apparmor@lists.ubuntu.com,	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 00/14] Create and use APIs to centralise locking for directory ops.
Date: Thu, 30 Oct 2025 10:31:00 +1100
Message-ID: <20251029234353.1321957-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

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


 [PATCH v4 01/14] debugfs: rename end_creating() to
 [PATCH v4 02/14] VFS: introduce start_dirop() and end_dirop()
 [PATCH v4 03/14] VFS: tidy up do_unlinkat()
 [PATCH v4 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and
 [PATCH v4 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing()
 [PATCH v4 06/14] VFS: introduce start_creating_noperm() and
 [PATCH v4 07/14] VFS: introduce start_removing_dentry()
 [PATCH v4 08/14] VFS: add start_creating_killable() and
 [PATCH v4 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 [PATCH v4 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
 [PATCH v4 11/14] Add start_renaming_two_dentries()
 [PATCH v4 12/14] ecryptfs: use new start_creating/start_removing APIs
 [PATCH v4 13/14] VFS: change vfs_mkdir() to unlock on failure.
 [PATCH v4 14/14] VFS: introduce end_creating_keep()

