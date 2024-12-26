Return-Path: <linux-fsdevel+bounces-38150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D89FCE77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C0B18832B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149FA1684B4;
	Thu, 26 Dec 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZJY2D6kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE015146A66;
	Thu, 26 Dec 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251451; cv=none; b=AJrpUdU5+Ar1eDRhICtjTdLeY+T6mZLAXWdH1KzPFpqlOkwWgWrvdr+voN3kTiO8TdHLsTmj9lYU5mPQf8S5Ok9FJvMSmpsZXHz4EK80gI960Ncg5uuu9Uq2HwK6SrrFfD10lICShzQPhNN0O5o+U5BsYRGwUa7uEbaIbO9mZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251451; c=relaxed/simple;
	bh=poIqwxLeYmSZecOI9YUbgM8plRd9MAIn3PmsCQR5NYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUzZk+m++RdylXcEff43k3icUPGy07be1ai1XzIuB4MEk+PG9mJzAhhtnynYzge91CEQVpk1l9rD1/KgI71OD0qSC+0G+T/rORxes6mn6DpCN+T58Zq3enILlQX8ioucdqYsQgiW9e2uBZGND9x5w8f4tdO7EJzApLeoD6BKCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZJY2D6kd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w/RGq4RNgf8/Vgt1WEsW2ab6QivmnVIkvf/OGGQSyBU=; b=ZJY2D6kdlvy7475nEH5WfZR2ZL
	j5mtvTtOxYnU4ZPG6ADlBMGYhXeNftr4UrVD3h+XEpZmL1XY+MTA5VDtAaYNaNEGr5C5sg3ZYe6df
	q1XN0gwLgdq/tdpF8mU6J7BPnAm0pO1qnZ0Bm1ISPDkQWxgJsf8aIDsmuP44XasJ+rbTIL1lpeL0g
	3Ll1oZRHTzXR0RM120RlDd5wsgr4Tw8nCpjoIm6Z1PevSKsNS1+UpdM9WOywcG+HTeMgHk4UwpNeY
	9PFNIieNYCTaageT7PIvTqJrLhh14LhbhkS24vJdzw1gZVQLbieq+2XFwu7TZILth7AEtDVdJ08iR
	O2zybd7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQwAY-0000000Cd7O-1vjH;
	Thu, 26 Dec 2024 22:17:26 +0000
Date: Thu, 26 Dec 2024 22:17:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [CFT][PATCH] fix descriptor uses in sound/core/compress_offload.c
Message-ID: <20241226221726.GW1977892@ZenIV>
References: <20241226182959.GU1977892@ZenIV>
 <d01e06bf-9cbc-4c0e-bcce-2b10b1d04971@perex.cz>
 <20241226213122.GV1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226213122.GV1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 26, 2024 at 09:31:22PM +0000, Al Viro wrote:
> On Thu, Dec 26, 2024 at 08:00:18PM +0100, Jaroslav Kysela wrote:
> 
> >   I already made almost similar patch:
> > 
> > https://lore.kernel.org/linux-sound/20241217100726.732863-1-perex@perex.cz/
> 
> Umm...  The only problem with your variant is that dma_buf_get()
> is wrong here - it should be get_dma_buf() on actual objects,
> and it should be done before fd_install().

Incremental on top of what just got merged into mainline:

Grab the references to dmabuf before moving them into descriptor
table - trying to do that by descriptor afterwards might end up getting
a different object, with a dangling reference left in task->{input,output}

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index edf5aadf38e5..543c7f525f84 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1053,13 +1053,13 @@ static int snd_compr_task_new(struct snd_compr_stream *stream, struct snd_compr_
 		put_unused_fd(fd_i);
 		goto cleanup;
 	}
+	/* keep dmabuf reference until freed with task free ioctl */
+	get_dma_buf(task->input);
+	get_dma_buf(task->output);
 	fd_install(fd_i, task->input->file);
 	fd_install(fd_o, task->output->file);
 	utask->input_fd = fd_i;
 	utask->output_fd = fd_o;
-	/* keep dmabuf reference until freed with task free ioctl */
-	dma_buf_get(utask->input_fd);
-	dma_buf_get(utask->output_fd);
 	list_add_tail(&task->list, &stream->runtime->tasks);
 	stream->runtime->total_tasks++;
 	return 0;

