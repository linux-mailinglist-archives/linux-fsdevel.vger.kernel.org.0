Return-Path: <linux-fsdevel+bounces-65254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4EBFEA69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59B1C4F1F68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC32C181;
	Thu, 23 Oct 2025 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLKMu/Fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42C1FDA;
	Thu, 23 Oct 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177761; cv=none; b=U2njoFipKdL8DZvObm9gEEl5chUuQC1q9KA8ZYNLkVK5kUXr/g8iAFs8dSrbXxLRxJgovm8/ThsyRI1rrnh0qRIl4y1eIngxciS7DoH7akVeXI7IqXyjfeRqZ+cPtQwcIOq7sbG80S4moJU5P/Z9RwFLqeAtphMBNZC1YnK2iuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177761; c=relaxed/simple;
	bh=TH1ZRO7yXGY1yj6R1NEyrIYQpWGJbuL5BgwDSvR6Ix8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHmwjU/lIOeiK0Y9WteavKqNpvWRphIm1gbHzqVSvyEmlWp2oPniV7XyS2rDwsZW32c///jNC9d6g6S0JE7cDLEXjZGv3uZOYs3nVd8IMYmbnjfqAXmAEsqYK03wWOlHPOFoAZ1LzlsSXY3j5C3DlXhcNNLjeQAGthAI+Y6a8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLKMu/Fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E5C4CEE7;
	Thu, 23 Oct 2025 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177761;
	bh=TH1ZRO7yXGY1yj6R1NEyrIYQpWGJbuL5BgwDSvR6Ix8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hLKMu/FbWCMVqz6QbtEaq0fnDHwC+bFiMASP/ZTs9GG/YGnrIeK0NS4eeJ4EvBP/p
	 imhBUWOtFiJ6HzNJO0jOxPRX9j12EnH9yEoU0iULrQi7ZMwF1MTsNjllrv4iKqsk33
	 GJd8Q4LhwylvNxZtCL89cDM4Ttvr5T2gUgwgRPm/fwOR4VhDHCRb6Q1r3uTPeOfTra
	 M+hk4r77k/5lNlJQ6mRGN10fR7hRHnn/1RESl6amrn91IL5olcXmvR6hvXcsUGPVGE
	 NMBsRto60i+qfI0O5i2trHev8FZmv0xTwFPP5SJYcnt2xW8GEF7uqih6Q8tJOmeS/W
	 CVuPuxa9XMaXQ==
Date: Wed, 22 Oct 2025 17:02:40 -0700
Subject: [PATCH 08/19] iomap: report directio read and write errors to callers
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744673.1025409.6771976557368790530.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add more hooks to report directio IO errors to the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/iomap.h |    2 ++
 fs/iomap/direct-io.c  |    4 ++++
 2 files changed, 6 insertions(+)


diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8c7..ca1590e5002342 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -486,6 +486,8 @@ struct iomap_dio_ops {
 		      unsigned flags);
 	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
 		          loff_t file_offset);
+	void (*ioerror)(struct inode *inode, int direction, loff_t pos,
+			u64 len, int error);
 
 	/*
 	 * Filesystems wishing to attach private information to a direct io bio
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd5767..1512d8dbb0d2e7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -95,6 +95,10 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 
 	if (dops && dops->end_io)
 		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
+	if (dio->error && dops && dops->ioerror)
+		dops->ioerror(file_inode(iocb->ki_filp),
+				(dio->flags & IOMAP_DIO_WRITE) ? WRITE : READ,
+				offset, dio->size, dio->error);
 
 	if (likely(!ret)) {
 		ret = dio->size;


