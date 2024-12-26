Return-Path: <linux-fsdevel+bounces-38140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECE9FCD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 19:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF1A1883BD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA091D63CC;
	Thu, 26 Dec 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o1r7d+/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464581D63DB;
	Thu, 26 Dec 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735237805; cv=none; b=qhps3f+ExltydPpog5KlzI6j9tQWY5P6MYtHEwXA07ZJgxglpKnrwCgUTufoOWlGDDXZ/281teEnkbTm9DB2dihuxaydCOE2uHf0nkWPH9ZSNu6DmMcQNH2h8cbUjvFAyHVI/QPQqpm3sajnHDjWkVa9MnM9rLtvuACtMbhbfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735237805; c=relaxed/simple;
	bh=aCT5eoT7KOMM2wNg8xY0LOgj0MgakoLOzgvZihq2OkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IQ081gy5WDsCUrRIjkWDBSwa2Gcc11v/O9zctEIkTK6sbuCYCW+gVCCagwgiN/UUCOEejccH0v3JPT2wHWV5WMn0KtaT6F7j4nDQjDxWvqxv1Dg2AHGJo3owLdS8/mIxJSLhpze8YiIKjFTA/J+TGRXwKLq9xEhoyWr7rAp0j5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o1r7d+/F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Z7d9dM30Bx+zWFRMyHO5BkNJcujujSmvmFRqGt+BFww=; b=o1r7d+/FtYGIw6FGtGvq6XFUZt
	nIGLjBmU0Y0WUyK3UuiHsvLoJBXbzq50uYX7pJxgbEnL+9t/JXrE4ZXvccAEXWnQnJnqzk/7jUrk2
	uIVquDeGUOcSDuMMwl6nchoV/NCkGDim4FVQl3mvql8A32dhMtbM+Z9LNIsvmEHyVVJ+5ocCK2EwN
	Hcxatc+OSG2abljkVudykV2A7QcObWB0qiPI+k+MmvHHK9puvnH7xfmB48rfwIPPjsGunZPrm4rAM
	nH8YH/6hSAnUZaUjfRyMPPxomLsP7v1TSZnjhXnFPxBO87MbEH/B0NHJTcclNNilt/fA+UEEiyE07
	mby5a7Xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQscR-0000000CaGL-1u8P;
	Thu, 26 Dec 2024 18:29:59 +0000
Date: Thu, 26 Dec 2024 18:29:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: [CFT][PATCH] fix descriptor uses in sound/core/compress_offload.c
Message-ID: <20241226182959.GU1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[please, review and test]

1) uses of dma_buf_get() are racy - as soon as a reference has been inserted
into descriptor table, it's fair game for dup2(), etc.; we can no longer
count upon that descriptor resolving to the same file.  get_dma_buf() should
be used instead (and before the insertions into table, lest we get hit with
use-after-free).

2) there's no cleanup possible past the successful dma_buf_fd() - again,
once it's in descriptor table, that's it.  Just do fd_install() when
we are past all failure exits.  As it is, failure in the second
dma_buf_fd() leads to task->input->file reference moved into
descriptor table *and* dropped by dma_buf_put() from snd_compr_task_free()
after goto cleanup.  I.e. a dangling pointer left in descriptor table.

Frankly, dma_buf_fd() is an attractive nuisance - it's very easy to get
wrong.

Fixes: 04177158cf98 "ALSA: compress_offload: introduce accel operation mode"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 86ed2fbee0c8..97526957d629 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1026,6 +1026,7 @@ static int snd_compr_task_new(struct snd_compr_stream *stream, struct snd_compr_
 {
 	struct snd_compr_task_runtime *task;
 	int retval;
+	int fd[2];
 
 	if (stream->runtime->total_tasks >= stream->runtime->fragments)
 		return -EBUSY;
@@ -1039,19 +1040,31 @@ static int snd_compr_task_new(struct snd_compr_stream *stream, struct snd_compr_
 	retval = stream->ops->task_create(stream, task);
 	if (retval < 0)
 		goto cleanup;
-	utask->input_fd = dma_buf_fd(task->input, O_WRONLY|O_CLOEXEC);
-	if (utask->input_fd < 0) {
-		retval = utask->input_fd;
+	if (!task->input || !task->input->file ||
+	    !task->output || !task->output->file) {
+		retval = -EINVAL;
 		goto cleanup;
 	}
-	utask->output_fd = dma_buf_fd(task->output, O_RDONLY|O_CLOEXEC);
-	if (utask->output_fd < 0) {
-		retval = utask->output_fd;
+
+	fd[0] = get_unused_fd_flags(O_CLOEXEC);
+	if (unlikely(fd[0] < 0)) {
+		retval = fd[0];
+		goto cleanup;
+	}
+	fd[1] = get_unused_fd_flags(O_CLOEXEC);
+	if (unlikely(fd[1] < 0)) {
+		put_unused_fd(fd[0]);
+		retval = fd[1];
 		goto cleanup;
 	}
+
 	/* keep dmabuf reference until freed with task free ioctl */
-	dma_buf_get(utask->input_fd);
-	dma_buf_get(utask->output_fd);
+	get_dma_buf(task->input);
+	get_dma_buf(task->output);
+
+	fd_install(fd[0], task->input->file);
+	fd_install(fd[1], task->output->file);
+
 	list_add_tail(&task->list, &stream->runtime->tasks);
 	stream->runtime->total_tasks++;
 	return 0;

