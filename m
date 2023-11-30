Return-Path: <linux-fsdevel+bounces-4362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D317FEF41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8247AB209D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55CD39845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aVNu1BwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7610D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:54:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00b01955acso110261166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701341691; x=1701946491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XR+8gmLSge88d7ltQNeWVsM7hJthxDwuclCE1+JMykY=;
        b=aVNu1BwFr5byo3AtgdAC0b9vqLdwFrf7remEgGA29tzUf4H4WQuljv79cK7Mwwz7L+
         CxNTCv9aNu3puo536sPNwqp1QP+Av2Zk9MQoPmOY6S8fQxfIYqeZwCfR5apH8Afv+smv
         Y/kNkt3g5GriW1jzt/VakJFOHJoCNPLc305Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341691; x=1701946491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR+8gmLSge88d7ltQNeWVsM7hJthxDwuclCE1+JMykY=;
        b=mdqbqTq9CwrB83fhYsdtO5DLc5Nh9hrIs17Q8soSUkaUCao1fjfgBSee5FOZ+ePZTC
         Ku2Z8N16CNthjxn5is4lPZZdo+uZULzBZzhHvs+0uvZEKY5WzySDuVyhPKqpdv0l2bTd
         TRVwEX8cKkTrnngiZpWgu1pLCTbiGJdvMaeVdxQJv411Sm/YxnRZY1Q0t/SSQ6niuBzv
         RcI2JyFY5iKXzMQoUVho/mWxREA80FMkaXBxaxO+fVQxknlbQH8VUKhEOhFWzTn8ni8P
         tjDDAKh7velc8lCqfpUvnIzd6z/GOoJnm7iPYwc3YDGrJoD2rTrpdLmfD3OKs6cqFu/q
         shVw==
X-Gm-Message-State: AOJu0Yw8plL18EMaSOmG8DiEyLSE3GPp5e1K980DYyXrkqmtc2L+XGrD
	LsSjYAnfvVM4+Jtx9VqdpBHOFgLvLscStfcHCpMJYA==
X-Google-Smtp-Source: AGHT+IFAvEDD+XKsyvhQVBhDBApbFr7Fee0HYIPNqifh12zYTGl2jNJ0IpOVKoIozrPs4OrqAUaKTcws8RGb7cmEtQE=
X-Received: by 2002:a17:906:cec7:b0:a10:8db4:bcf3 with SMTP id
 si7-20020a170906cec700b00a108db4bcf3mr8968339ejb.9.1701341691027; Thu, 30 Nov
 2023 02:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116075726.28634-1-hbh25y@gmail.com>
In-Reply-To: <20231116075726.28634-1-hbh25y@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Nov 2023 11:54:39 +0100
Message-ID: <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
To: Hangyu Hua <hbh25y@gmail.com>
Cc: vgoyal@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 08:57, Hangyu Hua <hbh25y@gmail.com> wrote:
>
> fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
> after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
> virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
> superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
> resulting in a possible double free.
>
> Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  fs/fuse/dax.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 23904a6a9a96..12ef91d170bb 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
>         if (fc->dax) {
>                 fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
>                 kfree(fc->dax);
> +               fc->dax = NULL;

Is there a reason not to simply remove the fuse_dax_conn_free() call
from the cleanup path in fuse_fill_super_common()?

Thanks,
Miklos


>         }
>  }
>
> --
> 2.34.1
>

