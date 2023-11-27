Return-Path: <linux-fsdevel+bounces-3898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8BC7F9A13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1986D280CE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4209D304;
	Mon, 27 Nov 2023 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC93MTqX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C0113;
	Sun, 26 Nov 2023 22:39:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce3084c2d1so31100255ad.3;
        Sun, 26 Nov 2023 22:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701067153; x=1701671953; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Emb7yr/CfdKXDeC8RveE9SxUhC/ki+8sv07LsVNRr5w=;
        b=mC93MTqXMiS++5bT2Y8j8IVsSGFZusyVNx/0o2IkLRFMRVOxDZroqtUn/cEGZMJD1w
         pgZHzprOJgiexzJ5Al/VkxYTuCxdX9jmMpq/4As65xD2KbUdedKDD44JZeXGATsQoStw
         DhckKQ9WbQxxQGX2zXaK3IDQg9JskPlWeP8/ELVHOS5c6NCwL1g4+zh5N5mioMPSwAX1
         gwZugClHHp5gcx3rfNYSeB07CuAMYUF2Qp/1gRJFH0+6YTtJ1kwMnO8ptC2o7nR6p5zC
         4u24Y1Yx1zki80vciUrTUcXdtKZ4yoxY/UE4wTHZ2/82jJuDGAIpAP5tiIeYv87VrQxG
         CkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701067153; x=1701671953;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Emb7yr/CfdKXDeC8RveE9SxUhC/ki+8sv07LsVNRr5w=;
        b=jln+nkw7ZItv28yTHeg3i8WoHRJv9Dxgt2EGCHQ/gy91oGuP8dcenhdNJjOppwI/fi
         j5qi64Y9KzOzpNqxNF0tCC6mR8udlHqroSq7yK0H1j+rae9WtjkXgjUf5eq/zqq5NXaT
         qaaqgQhQ+QCv0qEn1vBSkftrncJG83NMz54LSI5pdFFIFGe5wuBqogKlhFHjGLQ1zT90
         eiptEQhGHEmY0R2pU4A+CibTdollfPQDJEnaPtkNywAI57n8Hj76P29hrxeO9g0fAvVR
         yRSQ9mI+QlGvfqYfh3QIive99/uYLasUaiMJVp1IcufepM7N9azIhaw8XkMwuZIWtxNn
         llcw==
X-Gm-Message-State: AOJu0YxxRpx4RlHCM4PQYpxBibzrn9EaV/E6LD4wLpAZaNqkLq5sgKK9
	U4pzwEmoEUOw3GRSDMLG3AnqAYdlSoQ=
X-Google-Smtp-Source: AGHT+IG7I9Ep2bIoKdXmWjDpD4SwBL9VupC7XIUEyNb2yw8GsQf4S9/DipK7EWOV0xjqubIFlSuqmw==
X-Received: by 2002:a17:902:d303:b0:1cf:876e:aa41 with SMTP id b3-20020a170902d30300b001cf876eaa41mr12199820plc.30.1701067153233;
        Sun, 26 Nov 2023 22:39:13 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id jc2-20020a17090325c200b001b7cbc5871csm7419633plb.53.2023.11.26.22.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 22:39:12 -0800 (PST)
Date: Mon, 27 Nov 2023 12:09:08 +0530
Message-Id: <875y1nsnsj.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] iomap: drop the obsolete PF_MEMALLOC check in iomap_do_writepage
In-Reply-To: <20231126124720.1249310-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> The iomap writepage implementation has been removed in commit
> 478af190cb6c ("iomap: remove iomap_writepage") and this code is now only
> called through ->writepages which never happens from memory reclaim.
> Remove the canary in the coal mine now that the coal mine has been shut
> down.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Nice cleanup. As you explained, iomap_do_writepage() never gets called
from memory reclaim context. So it is unused code which can be removed. 

However, there was an instance when this WARN was hit by wrong
usage of PF_MEMALLOC flag [1], which was caught due to WARN_ON_ONCE.

[1]: https://lore.kernel.org/linux-xfs/20200309185714.42850-1-ebiggers@kernel.org/

Maybe we can just have a WARN_ON_ONCE() and update the comments?
We anyway don't require "goto redirty" anymore since we will never
actually get called from reclaim context.

Thoughts?

-ritesh


>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b28c57f8603303..8148e4c9765dac 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1910,20 +1910,6 @@ static int iomap_do_writepage(struct folio *folio,
>  
>  	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
>  
> -	/*
> -	 * Refuse to write the folio out if we're called from reclaim context.
> -	 *
> -	 * This avoids stack overflows when called from deeply used stacks in
> -	 * random callers for direct reclaim or memcg reclaim.  We explicitly
> -	 * allow reclaim from kswapd as the stack usage there is relatively low.
> -	 *
> -	 * This should never happen except in the case of a VM regression so
> -	 * warn about it.
> -	 */
> -	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> -			PF_MEMALLOC))
> -		goto redirty;
> -
>  	/*
>  	 * Is this folio beyond the end of the file?
>  	 *
> @@ -1989,8 +1975,6 @@ static int iomap_do_writepage(struct folio *folio,
>  
>  	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
>  
> -redirty:
> -	folio_redirty_for_writepage(wbc, folio);
>  unlock:
>  	folio_unlock(folio);
>  	return 0;
> -- 
> 2.39.2

