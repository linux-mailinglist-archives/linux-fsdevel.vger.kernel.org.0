Return-Path: <linux-fsdevel+bounces-26387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C26958D62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7921F2579A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BF1C7B75;
	Tue, 20 Aug 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7NvEF/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA01BE242;
	Tue, 20 Aug 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174933; cv=none; b=nM4AyuD7CQNaSk3AF0eTPfMNb1OQMC7nUz0MscRrhbjZSu8zPzQ66Wg07Fmo6dJzpaWVrZDNKWzvyjATZJ/AwXodDhK1vy2DNcRS4hzoO9PZKMNhkjg2y7375FckOY86rD1oWbQhkCCg84tyC/PAMk0ZGfOumuLiSKyOlfeIXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174933; c=relaxed/simple;
	bh=QDiQZYx6M6RaBNbILBpKMDVTjxGNMVHSJSW+1HFcYDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyXVX/hJJW/RQsYfTLfY3zmGweblZyKzpMFso5m0hlctCIxvU4IP07NcnD32z1Ilw8ybmm71qMV++9ezHpKVizAGCSNz1v4S8hRe2YkfVZaf83flBZzlWf1G+HlVZb/mx1pdpjuFR00ggZ/YMygIPAkEKAXkP8sDSAbBK+aj19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7NvEF/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD48C4AF13;
	Tue, 20 Aug 2024 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724174932;
	bh=QDiQZYx6M6RaBNbILBpKMDVTjxGNMVHSJSW+1HFcYDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7NvEF/gF7TsWhkR5KjL7b8J21f9YKr00uC2trvh8kAlqPRQHqFyPB8l+3K+yKQzN
	 Ya+/RNzhKyhtknhJ4NTtUEPB5q5NA/cqernX41jMYUgFDCVG+D9kYZFaj7O6m9fNW2
	 6MfBaPcyRQFwpB92lvlQ+Hqbtdx3JemGZvtDqKEI8EDO6S0KIGsP4I+N1yEvvFeNrR
	 yeVGeb7O2i6TA+upylc8XNoCeMG+ecdtwAE7OX81kwbAW8TkrWv+NMOEVsSuWYM/gK
	 11ZSsgOqyRX+3LpbzMMet8EsdE6a0U7hdgtIOlw5vscwdJfmkeI+UGRB6q4yGUAhqN
	 Y7wi2GAgoavoA==
Date: Tue, 20 Aug 2024 10:28:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 2/7] fs: Export generic_atomic_write_valid()
Message-ID: <20240820172852.GH6082@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-3-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:47:55AM +0000, John Garry wrote:
> The XFS code will need this.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/read_write.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index d8af6f2f1c9a..babc3673c22c 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1752,3 +1752,4 @@ bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(generic_atomic_write_valid);

Looks great,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> -- 
> 2.31.1
> 

