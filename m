Return-Path: <linux-fsdevel+bounces-56077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37493B12AF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60314545F49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3508276023;
	Sat, 26 Jul 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0w7ON/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D9610D;
	Sat, 26 Jul 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540322; cv=none; b=Xs3FzgucKg2hURtsZ9UqApXtaFuyZ5jCeQAB5KVW08wQfOt0vpyMrloKFyyb8m2mJDgF7ZmQJtd7tPjjHTkLSANDDFlnHvddgLiRiqWYFEPuhTZqNHuy6Fs3AKHaJXgVAJoYM2O/sUhKmQWtyJd6LiX10MzVp6e+8fUIviRrp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540322; c=relaxed/simple;
	bh=S3UhcMyky6rKeP7+SYXs7IoFku4acxPQ61133EdSJ18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JWteTbO7IZDqv01aNb5SLkykO1StmxT+a97CUw+gXOMEMw1Fzz4F0YnzqzKbKTLBf/6Erk9PLxPEjc+sigFgID9nMMNAWTQI/PzVvxZ7Qz/BQG+4PoX4a6+gEXZcn4XGimzskNMfexv92g454qsRA1AZLHlZmqIEE5/CTvB9UJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0w7ON/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A72AC4CEED;
	Sat, 26 Jul 2025 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540321;
	bh=S3UhcMyky6rKeP7+SYXs7IoFku4acxPQ61133EdSJ18=;
	h=From:Subject:Date:To:Cc:From;
	b=I0w7ON/I4DmSrcZ+plVTQCVhQ8czPcuD4yp8Atpb1ja9382IeeZBHP98luC3714VL
	 36iHT/dNf/FvDkl1E1PrqOvIziqR9Ol2O08gnfmruTeRIZU2lf/Z9t88tXZ5lR+6rd
	 jVIlavAHOl1KcFBh8SkFKeyhTWJAJ1nIMnLBKxMMiBSE4hL0GtUlaaEWpeW4AHdi+g
	 UR53jIMq+w5w7PXlZHfLABvFrMzY2vA3d2DdLj3pQxrR3SCEK60Ji0SMmqhgeIPCls
	 z48O8hk/O1xSDqnsLq9n7ACV7AV094pLswWeWY7AJcn8bC6yXn/QqQI/TErcKwbqyJ
	 CiyrwD9lwov5g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/7] nfsd/vfs: fix handling of delegated timestamp
 updates
Date: Sat, 26 Jul 2025 10:31:54 -0400
Message-Id: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrmhGgC/3XMQQ7CIBCF4as0sxYDQyrqynuYLggd6ERDDRCia
 bi72L3L/yXv2yBTYspwHTZIVDnzGnvgYQC32BhI8NwbUOIoDaKIPs+iUC4cgxjpfFJWO6+thH5
 5JfL83rn71HvhXNb02fWqfusfqCohhVYalTPeXYy/PShFeh7XFGBqrX0BeQG3iKkAAAA=
X-Change-ID: 20250722-nfsd-testing-5e861a3cf3a0
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=S3UhcMyky6rKeP7+SYXs7IoFku4acxPQ61133EdSJ18=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObeAyOo84RRJBeynJ7d4lu9yfiAxkv694zog
 gYQQAz0rLeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3gAKCRAADmhBGVaC
 FWUAD/9fecWlsbhoipjkJZ05akI6773V9Ccxza7Jik/UhKAABsQzhkylfyForekAIhoO4QYfl8i
 zw5aXt/0ocKR4lF/ZFn9KJEga7Mbenbckoexg/Jl53xhZnEjsVJ4tntBpQ7/mGI+5X3qTZSdZ3f
 tA28nz40Llmi7PS1Owp8IZcXH0gjbCmgbi6T1c5zTjc9/tdHoZ/2p2UvYzCabRuVzKK/Ehvt3Hl
 P70+47NOJ0vn/6ceH47bW1qDv9Wby83L7E4hbn4XQDFpgrTheLdGH5HDJ8B74YKHu3Felulri+N
 1enlYaSmbT2pffm7v0Cnm0cmJWuJJQ3PBQo/TGTVbR5L/MmHsF+xnJXiMlMQq10d5JwXceykNjJ
 bBnQWJM5n3xsoffKEsZreUjxVL6P/6b+S/s/AYVZUKPLDRNaLFiZMCCvPla+Kz1vTjGFBrCseaf
 MimBTEUniFXwDVRNutEDfzOyF22nIf9nYa1C0P+3ndWfGZqEFQcJDu2CeSgOUwYJJmL3OMP7WCA
 9XhQ8c/2YSq6Yzb8HzPMF1NNqoGedUboQSBwdILdxdg3NEJTv1ofqKCocs+sj/ehI1Qyup2SKki
 usulax95VfOndJ4GDTH6ts7fe63+zjWCTEQBsTy7adqHug9yo1YMGpBH69Hul3lpbrzeBR0bZUd
 AjaeUH0EoQLaE/w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

After my last posting, Trond pointed out that my interpretation of RFC
9754 was wrong. The "original time" as mentioned in the spec is the time
of the grant of the delegation, and not the current timestamp in the
inode before the update.

Given that, there is no longer a need to do any sort of complicated
handling of delegated timestamps at the VFS layer, so this set removes
inode_set_ctime_deleg(). We do however need a way to set a ctime that
isn't current_time() via notify_change(). This patchset adds an
ATTR_CTIME_SET flag, which mirrors ATTR_ATIME_SET and ATTR_MTIME_SET
semantics. The rest of the patchset reworks nfsd to properly vet
timestamp updates on its own and just call down into the OS to do a
normal notify_change().

With this patchset in place I haven't seen any git regression suite
failures yet (4 passes so far under kdevops in the "stress"
configuration).

I should point out that there is at least one potential problem with
this implementation:

The kernel does not block getattr operations when there is a delegation
outstanding. When the client issues read and write ops to the server,
while holding the delegation, the timestamps on the file get updated to
the server's time as usual. Later, the client will send a SETATTR (or a
CB_GETTTR reply) that may have times that are earlier than the
timestamps currently on the inode.

This means that userland applications running on the NFS server can
observe timestamps going backward. This applies even for the ctime. NFS
clients should be fine, as the server will do a CB_GETATTR to satisfy
them. Server-side applications can't do much else with the inode without
recalling the delegation, so my thinking is that the effect should be
"mostly harmless".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add ATTR_CTIME_SET and remove inode_set_ctime_deleg()
- track original timestamps in struct nfs4_delegation
- fix delegated timestamp updates to respect saved timestamps
- Link to v1: https://lore.kernel.org/r/20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org

---
Jeff Layton (7):
      vfs: add ATTR_CTIME_SET flag
      nfsd: ignore ATTR_DELEG when checking ia_valid before notify_change()
      nfsd: use ATTR_CTIME_SET for delegated ctime updates
      nfsd: track original timestamps in nfs4_delegation
      nfsd: fix SETATTR updates for delegated timestamps
      nfsd: fix timestamp updates in CB_GETATTR
      vfs: remove inode_set_ctime_deleg()

 fs/attr.c           | 34 ++++++++++---------------
 fs/inode.c          | 73 -----------------------------------------------------
 fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++-
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   |  5 ++--
 fs/nfsd/state.h     |  8 ++++++
 fs/nfsd/vfs.c       |  2 +-
 include/linux/fs.h  |  3 +--
 8 files changed, 79 insertions(+), 121 deletions(-)
---
base-commit: b05f077b59098b4760e3f675b00a4e6a1ad4b0ad
change-id: 20250722-nfsd-testing-5e861a3cf3a0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


