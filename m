Return-Path: <linux-fsdevel+bounces-34680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD99C7A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFBB1F27330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B99203715;
	Wed, 13 Nov 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="iLeSKBRZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJs47M14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824AA202631;
	Wed, 13 Nov 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520530; cv=none; b=HlgnuVeoDaxKgMrb0hbxuIYpPAGIVnsWc8sowzJ64PELDM5Xpzv9YyuFs7jP9RkV8KOmNO22sEYDjppc3bV1sgm1f4SsAz6rzlRew+adlQKpEWThzwcvzX7PXNe0elOzsbGN5OWd4VoRYGFiA0h9kI4IXE/3RWn2D6zFBsXTf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520530; c=relaxed/simple;
	bh=XLCgkugxoZSSyiBJBlWzTJCyuPH0w0UrxYD4l3kLGZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=tYfiFdvdQ2hXbhePi1Y4tSw6H3dBC9O+7ZEa7pYPZ4H6UpGFFPScXaJNUiQDjZ8HtGhybuh2fWJl+6UUJCrs6GfPUMfyV3jgefBs+4g75qTKbneALF0e0T+DtGdhhCQdsWSwq9mmAH/hJTBnL9qFmCC3+bF2pYy/Zj/UDGzKt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=iLeSKBRZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJs47M14; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A7F725401E8;
	Wed, 13 Nov 2024 12:55:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731520527;
	 x=1731606927; bh=5+pcf0JiyUAkdw2ovA0fIXiVm1vdTpSQXam3QUG2Avo=; b=
	iLeSKBRZqddEUqE8+XbqrcoGRX0RwiVEunts4skahKl3xPJXBKWv9bpwmWgMNdNI
	HV+oPgOMcN2xfhxH4rXD/8bElhLhsHSV2zca+Sgu/9HH/Q4Qbk45tpveEng+wv8f
	1UnKBauBbTZWFqIsYHrYSxWGA2f+f9dWwQl6g25KnQ0SoQbkNqTnXFZGTZxERkHR
	P6eweX8TYTKbM7KSZtplIn6GuSAO+dUkhfPg9r3chQti72Wq4ggvt3407dV00fDy
	FP/HO94hIFvv/ZEZnDLHf9ruh8T3ajf1BxYTFNOlnkuFKIciYrRw5GE7KTQLpLbq
	827snyEJJsnzs+6QyBOOiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731520527; x=
	1731606927; bh=5+pcf0JiyUAkdw2ovA0fIXiVm1vdTpSQXam3QUG2Avo=; b=O
	Js47M14hd7wjKTWfLlwQqhPuFONqYAu7EVMm57OMdArmQCLwTRlt2e29nzrV/xfV
	5aiuJjiRuekUoPw2AqXyn0oEjLyxTYm4gEFANQOOLbtk15gIk84i7TPgkvL9VHFh
	sWNQTUcJABMmm9C13XXC2gloKekHFqHJjgUYdX+BMvuNQ6ubNJjgIZPa/rRDGRWx
	nkQrO8Z/DJpqUKA5LqIKnsivaXzy6ZpKalsFSpeOSdIfDSH5AzX1JGxhPPhDGLaG
	HYH7RRbp5phc0Ut9gfnFze7PItrRlNRc1PnbAe/EeCu1zpm7/glUNm6bfLGVggmx
	yA/edcLZyqzzkpThU+C3Q==
X-ME-Sender: <xms:Dug0Z60LAV3Ejgf-ubArjJLRwnlb4B9SC97JB6VbpMdOTwVBWCYVig>
    <xme:Dug0Z9GCYZsTtxrqrzGQP_E9s_dokjVAF0ydQobhuEVsDhgGdPihueizZPC_J4qDE
    XTpIac0_eqqdNRYMgY>
X-ME-Received: <xmr:Dug0Zy7RGJJGz_rGBA0CZD2e1J9ycmJkDcx0Nq_83cHqmfyirLLsA1xX7K5FbXuwKeXZGb942Qft6vh9mzDAnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefgrhhinhcuufhhvghphhgvrhguuceovghrihhnrdhshhgvphhhvghrug
    esvgegfedrvghuqeenucggtffrrghtthgvrhhnpeekvdeigeehfefhgedthfelteelleeh
    vdetgefgteekfedtfffgfeelueeffeeigeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvghr
    ihhnrdhshhgvphhhvghrugesvgegfedrvghupdhnsggprhgtphhtthhopedutddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhr
    ohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepvghrihhnrdhshh
    gvphhhvghrugesvgegfedrvghupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtii
X-ME-Proxy: <xmx:Dug0Z73Qy39-k1r4QLL6OcFvl783H2RGjOmiyxURfVYN13P7JttflQ>
    <xmx:Dug0Z9Fy0RdzQf9oCwGNs-D40QWcZf-2S3V1eKpquZdjk9D5yJp8hw>
    <xmx:Dug0Z09F6OipMPPFBw29Hajwsh5KIE-DtcLzTv5lcjctbqLVtcf-YA>
    <xmx:Dug0ZykOnLIIIUVH5tb0pzVzfMg5bTpkt7B-68inj66nKjF7xxfiRw>
    <xmx:D-g0Z19bLqbUCXpmqauBCacoSWnz2cI7EOeMw6bk2uWcYTJKpNZDh5ac>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 12:55:26 -0500 (EST)
From: Erin Shepherd <erin.shepherd@e43.eu>
Subject: [PATCH v2 0/3] pidfs: implement file handle support
Date: Wed, 13 Nov 2024 17:55:22 +0000
Message-Id: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAroNGcC/x3Myw6CQAyF4VchXTtmWipeVr6HIaYDHekGyYwSD
 eHdHVl+Jyf/AlmTaYZLtUDS2bI9xwLaVdANMj7UWV8M5IkRkdxkfcz3OLgYgueA/iQUoNynpNE
 +W+rWFg+WX8/03coz/lcgkTMfsXYdkjiumZ3woXPiMVKj2Ijvr8r1Xt/Qruv6A7yLI+eeAAAA
X-Change-ID: 20241112-pidfs_fh-fbb04b108a2b
In-Reply-To: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
References: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 linux-nfs@vger.kernel.org, Erin Shepherd <erin.shepherd@e43.eu>
X-Mailer: b4 0.14.2

Since the introduction of pidfs, we have had 64-bit process identifiers
that will not be reused for the entire uptime of the system. This greatly
facilitates process tracking in userspace.

There are two limitations at present:

 * These identifiers are currently only exposed to processes on 64-bit
   systems. On 32-bit systems, inode space is also limited to 32 bits and
   therefore is subject to the same reuse issues.
 * There is no way to go from one of these unique identifiers to a pid or
   pidfd.

This patch implements fh_export and fh_to_dentry which enables userspace to
convert PIDs to and from PID file handles. A process can convert a pidfd into
a file handle using name_to_handle_at, store it (in memory, on disk, or 
elsewhere) and then convert it back into a pidfd suing open_by_handle_at.

To support us going from a file handle to a pidfd, we have to store a pid
inside the file handle. To ensure file handles are invariant and can move
between pid namespaces, we stash a pid from the initial namespace inside
the file handle.
	
  (There has been some discussion as to whether or not it is OK to include
  the PID in the initial pid namespace, but so far there hasn't been any
  conclusive reason given as to why this would be a bad idea)	

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
Changes in v2:
- Permit filesystems to opt out of CAP_DAC_READ_SEARCH
- Inline find_pid_ns/get_pid logic; remove unnecessary put_pid
- Squash fh_export & fh_to_dentry into one commit
- Link to v1: https://lore.kernel.org/r/2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu

Remaining: To address the PIDFD_THREAD question
 - Do we want to stash it in file handles (IMO no but there may be merits to
   doing so)
 - If not do we want PIDFD_THREAD/O_EXCL to open_by_handle_at to work or do we
   do something else?

   (Perhaps we could just add an ioctl which lets an app change the PIDFD_THREAD flag?)

If PIDFD_SELF lands <https://lore.kernel.org/r/cover.1727644404.git.lorenzo.stoakes@oracle.com>:
 - Support for PIDFD_SELF(_THREAD) as reference fd in open_by_handle_at?
   (We can even detect that special case early there and bypass most of the file handle logic)

---
Erin Shepherd (3):
      pseudofs: add support for export_ops
      exportfs: allow fs to disable CAP_DAC_READ_SEARCH check
      pidfs: implement file handle support

 fs/fhandle.c              | 36 +++++++++++++++------------
 fs/libfs.c                |  1 +
 fs/pidfs.c                | 62 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/exportfs.h  |  3 +++
 include/linux/pseudo_fs.h |  1 +
 5 files changed, 87 insertions(+), 16 deletions(-)
---
base-commit: 14b6320953a3f856a3f93bf9a0e423395baa593d
change-id: 20241112-pidfs_fh-fbb04b108a2b

Best regards,
-- 
Erin Shepherd <erin.shepherd@e43.eu>


