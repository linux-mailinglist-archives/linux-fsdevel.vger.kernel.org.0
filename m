Return-Path: <linux-fsdevel+bounces-3875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2B7F9881
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FCDB20B2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7B53B8;
	Mon, 27 Nov 2023 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jciNYYpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0253F12F;
	Sun, 26 Nov 2023 21:01:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so4952635ad.1;
        Sun, 26 Nov 2023 21:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701061296; x=1701666096; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0LGWhMOdJ9kEgvG9PE0ksbBVphAsskS0KLGQgZ0nnow=;
        b=jciNYYpaVXZd0kXntc8SRgZ1qG4OeB16LlAAo/uhnbglAUZU0Oo5qfjEafAEv2O0Db
         RXxVnTAg2xKV8Ya9jUNKM7P64FvAiaaweN8N5yzuY5BIFa1omKGjxvVSsd4jOZZymHBa
         yuUVdPdR6cvEx4+jJh8xRLW0Tq108/vWq+G24T6rmX+ZxBePHyH+rMnWRZfYqi3ZjdFM
         5YcJrWRoNcU58fxrOobsJx/SAMYoygUHNxoRfdUm3MekaNIiDPsmuRzJnHY3HIQv4PcJ
         OYJzTMTfgzi3CAwKMHI8dcAhf1N7Ep+kovwLanDb09IZbbtC5ZTFHm+uk87gNPL0L2Rw
         UmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701061296; x=1701666096;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LGWhMOdJ9kEgvG9PE0ksbBVphAsskS0KLGQgZ0nnow=;
        b=hz9OlabZgKJuZbmi5r5GBfh3EO2npHoc7TAra6SZrjnhjRhLrXqgnnykidp39fwz/g
         bvfUMcqN4VsGRXy0dAmea3pFpHI43qjJaIRiAE7t+DXzMUctvqJPFx1ozGBq8AvX9+MU
         wzswn3LLRKuRJFCSnOyjo2Z3jsCn/lR6TXnJq9WnL9RnT6tIj/60N46GCnROmjYHyAkm
         wkLmPN+X5N+KyZj63yxLtRSkttnHM8bNHe+Cp8jkCeU5WIM5kvvAL92laPQCH3T2NjmQ
         Gi9Z6QciMf/oP7DP9WG4lvh6eTTLnmR0G2ki97B8tV+4IO6NgcR7PkLlaP2Ibjn74DFD
         xTJA==
X-Gm-Message-State: AOJu0YzR7zmFFvz/79DmhHYN4zZMpJOd9m+BAAWQOSP0+hPBI+Y82Y/2
	8LujG7PX784QdQ82zxvbcOOiCydMf0g=
X-Google-Smtp-Source: AGHT+IHKa4SduOKsqzkUj52RxHRbPhr9y4uhhDweSW+e9raPF4aSMXQq0BFFLMf/DhWzlfCDB7Uw2Q==
X-Received: by 2002:a17:902:ed41:b0:1cf:cbec:ead5 with SMTP id y1-20020a170902ed4100b001cfcbecead5mr2370817plb.26.1701061295871;
        Sun, 26 Nov 2023 21:01:35 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b001cc0e3a29a8sm5808541plg.89.2023.11.26.21.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 21:01:35 -0800 (PST)
Date: Mon, 27 Nov 2023 10:31:31 +0530
Message-Id: <87bkbfssb8.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/13] iomap: treat inline data in iomap_writepage_map as an I/O error
In-Reply-To: <20231126124720.1249310-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> iomap_writepage_map aready warns about inline data, but then just ignores
> it.  Treat it as an error and return -EIO.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

The code change looks very obvious. But sorry that I have some queries
which I would like to clarify - 

The dirty page we are trying to write can always belong to the dirty
inode with inline data in it right? 
So it is then the FS responsibility to un-inline the inode in the
->map_blocks call is it?

Looking at the gfs2 code, it might as well return iomap->type as
IOMAP_INLINE for IOMAP_WRITE request in it's iomap_writeback_ops no?
    iomap_writeback_ops -> gfs2_map_blocks -> __gfs2_iomap_get

>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 98d52feb220f0a..b1bcc43baf0caf 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1818,8 +1818,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		if (error)
>  			break;
>  		trace_iomap_writepage_map(inode, &wpc->iomap);
> -		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
> -			continue;
> +		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE)) {
> +			error = -EIO;
> +			break;
> +		}
>  		if (wpc->iomap.type == IOMAP_HOLE)
>  			continue;
>  		iomap_add_to_ioend(inode, pos, folio, ifs, wpc, wbc,
> -- 
> 2.39.2

-ritesh

