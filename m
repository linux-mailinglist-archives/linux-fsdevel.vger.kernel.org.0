Return-Path: <linux-fsdevel+bounces-3873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3F7F9800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 04:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975C9280E18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652846B1;
	Mon, 27 Nov 2023 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed5Zyh0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA16127;
	Sun, 26 Nov 2023 19:47:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfaaa79766so17367325ad.3;
        Sun, 26 Nov 2023 19:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701056836; x=1701661636; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZ6BuCZCsznk2mCgUhldWvedcdSYmlICdH/YifDTnOs=;
        b=ed5Zyh0jhTZAladHaS27YFftewQv6J33vBzmbvirSc0yEAH7gwpu6U/9aDDCb0pzmB
         CqcKRgTyM5EuSxANGPxvc0YT78wpN/guydzQhC64EPfgLzUYEQnRINE7WRcRa8JQCP7Z
         H/r2Kky5Pm89N8tltCh8JcFAK/wHrxGA8+fwHB7Rok1QBmjAKo9fzg2bUa9YxK48NHhH
         251UVCuq58qn7U0CwrGFcigUohIDZnZNhT546jnpSyrWiLXlk2dKaUUkns+Bs53yCYXg
         YqHMAgRfEDzZpQoEQDfY5YBKYHaj+fVbWH6Mtoep4x2ofbtPiX2K6mrxbiuOuRFuaT54
         dHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701056836; x=1701661636;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ6BuCZCsznk2mCgUhldWvedcdSYmlICdH/YifDTnOs=;
        b=S8JT+d87lF/YqIoEyd2pMnlU4J5sRf1p6ImDpXIxOcr2MkCwsvVyx5Vwn7SkuxMynK
         B76DrAtbbV7WiOagvm0fWx8s1jRtG2mJUYdRWt3ugSQ80NwDSPCO2PHXV6QGrheLEQUe
         2KNtbjimvdlN9y66BaUZ7wD7FGY4caGg876o/e6K3EPaW4D1l8aqm/rX/Nl92Y3NcChk
         7NlP5mZoKSoz+5QPjuRikjr9UChnUdvej6C+87obNcQS8tod+7qtA+2LlQHM+iQqglWe
         ofd30eGF2b0oVZrKK5ScEKSEB9BUZp0DSrB/kvY3/cS2SnZBPnxDVqQzGNQsIAvmwKQm
         4SUw==
X-Gm-Message-State: AOJu0Yyg6Lat4Ks0lxj6U8qdIkohVcRe9hTVZctWuMjyvR55ib7Ke37U
	8Z71GZ7LkDUjriHpYusjIfQUr+oZAl8=
X-Google-Smtp-Source: AGHT+IH5OMs5yatJ9OW6GyeU6lhnxC73MUtYz/WNmbbq/i58BP7tfhhM2xqCMJSHS722ijdG20OStQ==
X-Received: by 2002:a17:902:ec8f:b0:1cf:d9c7:3b1c with SMTP id x15-20020a170902ec8f00b001cfd9c73b1cmr18526plg.45.1701056835830;
        Sun, 26 Nov 2023 19:47:15 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf8a4882absm7147835pld.196.2023.11.26.19.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 19:47:15 -0800 (PST)
Date: Mon, 27 Nov 2023 09:17:07 +0530
Message-Id: <87edgbsvr8.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/13] iomap: clear the per-folio dirty bits on all writeback failures
In-Reply-To: <20231126124720.1249310-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> write_cache_pages always clear the page dirty bit before calling into the
> file systems, and leaves folios with a writeback failure without the
> dirty bit after return.  We also clear the per-block writeback bits for

you mean per-block dirty bits, right?

> writeback failures unless no I/O has submitted, which will leave the
> folio in an inconsistent state where it doesn't have the folio dirty,
> but one or more per-block dirty bits.  This seems to be due the place
> where the iomap_clear_range_dirty call was inserted into the existing
> not very clearly structured code when adding per-block dirty bit support
> and not actually intentional.  Switch to always clearing the dirty on
> writeback failure.
>
> Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improve performance")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Thanks for catching it. Small nit.

>  fs/iomap/buffered-io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f72df2babe561a..98d52feb220f0a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1849,10 +1849,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 */

		/*
		 * Let the filesystem know what portion of the current page
		 * failed to map. If the page hasn't been added to ioend, it
		 * won't be affected by I/O completion and we must unlock it
		 * now.
		 */
The comment to unlock it now becomes stale here.

>  		if (wpc->ops->discard_folio)
>  			wpc->ops->discard_folio(folio, pos);
> -		if (!count) {
> -			folio_unlock(folio);
> -			goto done;
> -		}
>  	}
>  
>  	/*
> @@ -1861,6 +1857,12 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * all the dirty bits in the folio here.
>  	 */
>  	iomap_clear_range_dirty(folio, 0, folio_size(folio));

Maybe why not move iomap_clear_range_dirty() before?

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 200c26f95893..c875ba632dd8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1842,6 +1842,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
        if (count)
                wpc->ioend->io_folios++;

+       /*
+        * We can have dirty bits set past end of file in page_mkwrite path
+        * while mapping the last partial folio. Hence it's better to clear
+        * all the dirty bits in the folio here.
+        */
+       iomap_clear_range_dirty(folio, 0, folio_size(folio));
+
        WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
        WARN_ON_ONCE(!folio_test_locked(folio));
        WARN_ON_ONCE(folio_test_writeback(folio));
@@ -1867,13 +1874,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
                        goto done;
                }
        }
-
-       /*
-        * We can have dirty bits set past end of file in page_mkwrite path
-        * while mapping the last partial folio. Hence it's better to clear
-        * all the dirty bits in the folio here.
-        */
-       iomap_clear_range_dirty(folio, 0, folio_size(folio));
        folio_start_writeback(folio);
        folio_unlock(folio);

> +
> +	if (error && !count) {
> +		folio_unlock(folio);
> +		goto done;
> +	}
> +
>  	folio_start_writeback(folio);
>  	folio_unlock(folio);
>  

-ritesh

