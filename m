Return-Path: <linux-fsdevel+bounces-48141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B82AAA2E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 01:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73B91882DD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E63239E80;
	Mon,  5 May 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgxUlCll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772A239E94;
	Mon,  5 May 2025 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483769; cv=none; b=ZDcpsGmIX9mY01GBtj5FCpvTyPZWT66EowqmH5cvHo5rrE4EhIbJRqmfx+5FHn6UUsYh8/r1/DZfSrlB6Vt0pjbG2CIedmQPdZmUsLlKTZn8eDEiZ0EUi98moPD07km5rpY0fmuvn6q+p5Sk4rN2aVAF6oYzy45P1/Oa996pGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483769; c=relaxed/simple;
	bh=ycvk+H1KxYfMb7VHiTqNUnb4KmM9XXIPCrNftqumk5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al/8EOXQ7akigNWDG/5EC6QArt8F0IkTfC00DV9I0EwgX7woqLZxjLE3xLFXQNAuUtvGal9pNmgWmfMo2L0MbW5UPB3Pzgtn7DhF3JMMGgtSgKvE6oCozZUonyXDVHPq2DFqOaEKVjEjmEeOE7qKDqEuGTZLqQ/kB8ebJx7Vr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgxUlCll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E79C4CEE4;
	Mon,  5 May 2025 22:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483769;
	bh=ycvk+H1KxYfMb7VHiTqNUnb4KmM9XXIPCrNftqumk5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgxUlCll2MjprlOwzB7QbZfp5yYq6KexpZDS614dDFhKZJZE2WDva1huV1gU0GGW6
	 deXlM5mWn8r1c8XVcvZ/CGsSIAyOs9LKHMRJKDI2qlv7+sq6ax7El+pVoy66NnDvgk
	 0cRIpAJJkXNvloMmn8ss49xuVGzzPwZNt4cHfaUOLbJDnDm7qp8SfqC+hG6UT9fhv8
	 hvPM/QHiHWUof4SjYWjGNbkl9iGSRmIqcJkKNqEBaExppyYMgHoYtREC93dx7FiTJo
	 nBg4U8R2slQhiWLvzOHM9KltaLyhSYO57lmh8jvxj1lILBly3bQ3GaLlds/6i87eup
	 pgj5oJh/f/SeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 209/642] fs/pipe: Limit the slots in pipe_resize_ring()
Date: Mon,  5 May 2025 18:07:05 -0400
Message-Id: <20250505221419.2672473-209-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: K Prateek Nayak <kprateek.nayak@amd.com>

[ Upstream commit cf3d0c54b21c4a351d4f94cf188e9715dbd1ef5b ]

Limit the number of slots in pipe_resize_ring() to the maximum value
representable by pipe->{head,tail}. Values beyond the max limit can
lead to incorrect pipe occupancy related calculations where the pipe
will never appear full.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250307052919.34542-2-kprateek.nayak@amd.com
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pipe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4d0799e4e7196..88e81f84e3eaf 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1271,6 +1271,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	struct pipe_buffer *bufs;
 	unsigned int head, tail, mask, n;
 
+	/* nr_slots larger than limits of pipe->{head,tail} */
+	if (unlikely(nr_slots > (pipe_index_t)-1u))
+		return -EINVAL;
+
 	bufs = kcalloc(nr_slots, sizeof(*bufs),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!bufs))
-- 
2.39.5


