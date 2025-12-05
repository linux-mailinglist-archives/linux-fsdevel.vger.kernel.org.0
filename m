Return-Path: <linux-fsdevel+bounces-70806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3278CA6EF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34BD3252A21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42D2FFFB9;
	Fri,  5 Dec 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q80/dBWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712B304BAF;
	Fri,  5 Dec 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927038; cv=none; b=A5m+USdOjw/tPdtqFjTi1jqDhD302FesL1X28ja0i6G3wgXLmBhGuZ710kl5QGZkTmiVHouSwIPzJj5sjs4g2PxPDNzM1zcZ3rUf3moF5sIG+cCUu+rEtLhaIRM9apVfvnmXjDhnbLNRtO5I1IjNxv30izPZNXJsCsYobfXZf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927038; c=relaxed/simple;
	bh=WForFrKAM9FTcFfxo8CUD6y3WzFLyBPc7XifEvrQnec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd0vx7JpE92JdtEh7Gqbzd8L3mJCW44jjbJO1x5avA9lxS7jz2vLTqK6pf1UJt9XfOtg6VArNgcECKEYaEifwDOiSYGv+iyywx+PuKbyqW+oeLJkp/HM8xj9XOIT6NaMTgFZN6nl5Hanafs3BrcxQor/idxjFEx9VvpHgx8YscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q80/dBWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FD7C4CEF1;
	Fri,  5 Dec 2025 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764927037;
	bh=WForFrKAM9FTcFfxo8CUD6y3WzFLyBPc7XifEvrQnec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q80/dBWEd3ah20HLJCNujchul860U1NcjoOoCzU+z7v4vVzFR0l5TwQKy+Bgs/169
	 k4mdTbpLB2kLAwdyQiqVlVRJ2KS5ljmI3BBbuNsMMR143u+AxqLB4HqG+te4j23K6y
	 7DkCxXhwjXLhib7j1bXd/xYWeDQes8kKhjVAlUYjZo9gg/+b2fSPNh5vIAOmV3rVZ8
	 HE3CSMlK1IJ7LWVe35vR7X9x1GOAtBVM1W4ubYVfT0++HAOUP8nAz+ioL77KeR+I+u
	 Ol7FCgnT+oi2JNUrW+3pz79yvX83+1/eoRXhQ9LCWS77LWejTm+YQ/PWq7vK1DP+gS
	 xv07gSvHoaQ2Q==
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
Date: Fri,  5 Dec 2025 10:30:18 +0100
Message-ID: <20251205-implantat-kapelle-06d70e53e229@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1764259052.git.bcodding@hammerspace.com>
References: <cover.1764259052.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=brauner@kernel.org; h=from:subject:message-id; bh=WForFrKAM9FTcFfxo8CUD6y3WzFLyBPc7XifEvrQnec=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQaLTMuDapYP1Whv+iKn3K3i8Sk+sn1wnnJQqrLSltYA gMUyo51lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATITrLsM/HaFAk+uZHDd3PvD+ zXhkX2bn0ZNzom6sW2u1JXXpfIFriYwMB1Q+7txnfzd0dffnL2rH0zReHRW41bXgYEl8RPP9ibu iWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Nov 2025 11:02:02 -0500, Benjamin Coddington wrote:
> We have workloads that will benefit from allowing knfsd to use atomic_open()
> in the open/create path.  There are two benefits; the first is the original
> matter of correctness: when knfsd must perform both vfs_create() and
> vfs_open() in series there can be races or error results that cause the
> caller to receive unexpected results.  The second benefit is that for some
> network filesystems, we can reduce the number of remote round-trip
> operations by using a single atomic_open() path which provides a performance
> benefit.
> 
> [...]

Applied to the vfs-6.20.atomic_open branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.atomic_open branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.atomic_open

[1/3] VFS: move dentry_create() from fs/open.c to fs/namei.c
      https://git.kernel.org/vfs/vfs/c/a79d83bd9f03
[2/3] VFS: Prepare atomic_open() for dentry_create()
      https://git.kernel.org/vfs/vfs/c/d52955ba68d6
[3/3] VFS/knfsd: Teach dentry_create() to use atomic_open()
      https://git.kernel.org/vfs/vfs/c/01584c2bcb06

