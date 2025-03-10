Return-Path: <linux-fsdevel+bounces-43569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE95EA58D73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 08:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C939188CE09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2D222578;
	Mon, 10 Mar 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNuDWlUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FA1BD9D8;
	Mon, 10 Mar 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593564; cv=none; b=nhw1jYQhMEOgyTZTcmzph57881UkSJ1NH6DKbJjrQToGvwR1Xgl2c9Dp3jHePBDLiayZ3GzvXccDE0lfIQT9f3Q12TyqGy9tMpFpKKRZcdtAGdHW0a0XnL6ny1o8XihA8R2ZiyhIBc+fwPXZJEQc4zoztm7tw4jQgEgVApDmGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593564; c=relaxed/simple;
	bh=eMU0GKu8VPtAYkQC+pg7TLxoNi76KtBrJ390scyFzTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDWWE5b/bPZgXAH8PxMlKRyE5fY1vQzwB0+CvEuiamo7I/3I7RoXxZZ1XmFEFMKOZLY6E7PglOidwBKe5Y4LHcFXOGvuA7HgKYg8Zj7rz+ikuimfmrf7zjVBVBW3ExIY7vUGlotWGG4J5CVGYJhFtrvhcWh8dbqe//b8w5qkPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNuDWlUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E7AC4CEEC;
	Mon, 10 Mar 2025 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593563;
	bh=eMU0GKu8VPtAYkQC+pg7TLxoNi76KtBrJ390scyFzTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNuDWlUC0sk/EdR2wP2T4bmgod502Kz7MBFM2yVjaLV6DY2fgtBVXtqMHllb4jxSH
	 PsTyTljAhD/qQau6fjV/nn4nqyybw2cKOFhSEtTxi+h8IH2EsZzQVz5fucJxhPM1/6
	 zm8ye6Tvsfc2gHDrjmQDhok8+i2jDo0fnKF9WqW52jeaqDm67XA4nPWYUA8JvvsO90
	 AXFvh3EImtdx57SXI4KutX8ig92YLZZrCg2AOutY0ddXThPjVc9YmxNDSfcttQK78n
	 lIwQqHOhHAqmof1PogoFy9BSZcDij8Nk6SznvA2gmhtc2j907VDEeXqJisYWtrUZ6h
	 fZTa5bTyEVHxw==
From: Christian Brauner <brauner@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com,
	Ananth.narayan@amd.com,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] pipe: Trivial cleanups
Date: Mon, 10 Mar 2025 08:59:15 +0100
Message-ID: <20250310-zunimmt-kosenamen-fcbd85148deb@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307052919.34542-1-kprateek.nayak@amd.com>
References: <20250307052919.34542-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=brauner@kernel.org; h=from:subject:message-id; bh=eMU0GKu8VPtAYkQC+pg7TLxoNi76KtBrJ390scyFzTg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfm335kmvsdYukHxrnLAz6d/Funyfykc9cba6kbCHXW UfuA3zLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbin8PwTz0v7Lz472mKDpt2 TLl0uXOHrEPAgpmPVr2PYREo3Os//SHDHz7bwz98oovb7zxhuLXpx4I1nLHiGzg559xpcIiMPy4 kxwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 05:29:15 +0000, K Prateek Nayak wrote:
> Based on the suggestion on the RFC, the treewide conversion of
> references to pipe->{head,tail} from unsigned int to pipe_index_t has
> been dropped for now. The series contains trivial cleanup suggested to
> limit the nr_slots in pipe_resize_ring() to be covered between
> pipe_index_t limits of pipe->{head,tail} and using pipe_buf() to remove
> the open-coded usage of masks to access pipe buffer building on Linus'
> cleanup of fs/fuse/dev.c in commit ebb0f38bb47f ("fs/pipe: fix pipe
> buffer index use in FUSE")
> 
> [...]

Applied to the vfs-6.15.pipe branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.pipe branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.pipe

[1/4] fs/pipe: Limit the slots in pipe_resize_ring()
      https://git.kernel.org/vfs/vfs/c/cf3d0c54b21c
[2/4] kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer
      https://git.kernel.org/vfs/vfs/c/547476063e12
[3/4] fs/pipe: Use pipe_buf() helper to retrieve pipe buffer
      https://git.kernel.org/vfs/vfs/c/ba0822021c3c
[4/4] fs/splice: Use pipe_buf() helper to retrieve pipe buffer
      https://git.kernel.org/vfs/vfs/c/d5c6cb01b69c

