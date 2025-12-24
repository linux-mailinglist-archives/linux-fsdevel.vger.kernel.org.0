Return-Path: <linux-fsdevel+bounces-72047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D37CDC2B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC9B830072A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C0330B32;
	Wed, 24 Dec 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY1b1b2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391F224F3;
	Wed, 24 Dec 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766577725; cv=none; b=rxUo1k/X+BB+QUosDt5vD0XiHSgDYhz+aVSNm9/DbD4guxS10X8DoOZPnNuh0zj6Fk6sq5NmRB2Of4gL+pPMCfpQcW9I6Uzt9It+iqSrZfNFBTKdCtxHkmflyX/TPNmzoJZn7UyU9zk1lS9hwVEL2OnpvZ/0xhwp+vKZgJpBGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766577725; c=relaxed/simple;
	bh=uBPqXxyHezu6KXMQBRpWZz+nm9zp7C2D106puhEjv7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASVQnk210MSjcq7rVntPNG5kGxoobTLECesk72B/SwrEfT652oxTnLBq9APU2wixkquA4cBKJzYHytv83mpApRtt4AmFj7kIopsys6rybxZ9kfO0vac7LFzY/1FFrTvWvGz6LpVp20xR/CxFXoemkqks9JRbqjB3vS6bPTqhZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY1b1b2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64201C4CEFB;
	Wed, 24 Dec 2025 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766577725;
	bh=uBPqXxyHezu6KXMQBRpWZz+nm9zp7C2D106puhEjv7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FY1b1b2utCFXPMdOoq8ndCNnjTuXNaW7HmED9XfyIybn9/6t4O9TBn6CrzTWmRCBf
	 DzV0uk8sNGWBHT0e0hIJUUGnFPYUjyDW438hnokF+br63eXJfp1opNni5v2uh3xMHn
	 EPuLx/iua/0vEldXwaiE1aTVrKqT+IgrWn5jCTM9EKb6e0Rb20IllUtj34SGr5zowJ
	 1AhUcBmkCZziavlIh6PfLNzEly5DYHo0poNTxs+al9f1yoz9Q4NyW58X7WsFXoqdjX
	 gof0rFbzXjx98ncanny1FHY1o5Vr/pKtrsxnQITJXnPcY6CRmzOnLvG8tGwfW8pkYV
	 gdXFNgVCx1agA==
Date: Wed, 24 Dec 2025 13:01:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, "Darrick J . Wong" <djwong@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf v3] lib/buildid: use __kernel_read() for sleepable
 context
Message-ID: <20251224-partner-eiszapfen-92104956caed@brauner>
References: <20251222205859.3968077-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222205859.3968077-1-shakeel.butt@linux.dev>

On Mon, Dec 22, 2025 at 12:58:59PM -0800, Shakeel Butt wrote:
> For the sleepable context, convert freader to use __kernel_read()
> instead of direct page cache access via read_cache_folio(). This
> simplifies the faultable code path by using the standard kernel file
> reading interface which handles all the complexity of reading file data.
> 
> At the moment we are not changing the code for non-sleepable context
> which uses filemap_get_folio() and only succeeds if the target folios
> are already in memory and up-to-date. The reason is to keep the patch
> simple and easier to backport to stable kernels.
> 
> Syzbot repro does not crash the kernel anymore and the selftests run
> successfully.
> 
> In the follow up we will make __kernel_read() with IOCB_NOWAIT work for
> non-sleepable contexts. In addition, I would like to replace the
> secretmem check with a more generic approach and will add fstest for the
> buildid code.
> 
> Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
> Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

