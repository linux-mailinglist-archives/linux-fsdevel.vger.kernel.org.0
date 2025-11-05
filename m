Return-Path: <linux-fsdevel+bounces-67031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6142C3385D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E01F3AC7BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705523BCF7;
	Wed,  5 Nov 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj8MlGQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3F34D396;
	Wed,  5 Nov 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303831; cv=none; b=b0LcjtKIx3K9L0fTgFgfQ08vIVyv7NVVm4B3nzEttGQPyD+oVaW9eOLlrNLnTYEbielZrt2YGetInHQkhagzCUw1kPvfPj6xtxanDpJ0BPJSefNjPd9qc8Qj9ez1rJgZXw7klosOMS/qXBtLIf6MzZCzIkhKivy7V3zkvHLtyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303831; c=relaxed/simple;
	bh=TH1ZRO7yXGY1yj6R1NEyrIYQpWGJbuL5BgwDSvR6Ix8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG0e2I5JIkbyUDqcpuowLYNIfa5IAOQdL7DQ3RGxBe1q53l4rMKmcTZpKysiDAJRYHh23/iyEq8Uv5L999ChNpiIVW880IhpM7+NMQ/FpMgRWl7UEk633hSu70kSIrVTNoZqpNHE9i6LljjKlAcO6VfxefIVGCsKqwKg1Hfq7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj8MlGQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B9AC4CEF7;
	Wed,  5 Nov 2025 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303831;
	bh=TH1ZRO7yXGY1yj6R1NEyrIYQpWGJbuL5BgwDSvR6Ix8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jj8MlGQ/I70TJbaVGeZrpf2jHYt47Iw74qtmtqeFCiYE9hzmXyS7Y9fuNP8jife6n
	 i12OKJuntcT3O7OFOHUJO7f17g+okUaZG2oSbOqmaJa+LvTyzrTj2Yerb1cjtclZCQ
	 UGBe4XfkAM4d3vWW0lEeGdAg5JjGgjreOu2GDaF8wm0TOtjR+bzzlvJPcyQ9ocPMCt
	 IdmkA/cZL3ISj5GAD4GWxK1BMVzCUSZsAqC3Jd+ISgoltYUhUcWKbgTCNtnvAwoSDw
	 YAVs4vs43gYZ0YD2+ZAtUW49OeOiTpSm/wcCf28XZcVYghBKX/Mqt/+cdBt2fEG50f
	 MJVbUB0Xn548Q==
Date: Tue, 04 Nov 2025 16:50:30 -0800
Subject: [PATCH 08/22] iomap: report directio read and write errors to callers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365863.1647136.7668519414999318083.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
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


