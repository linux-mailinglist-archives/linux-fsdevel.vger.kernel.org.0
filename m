Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA041B661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 20:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhI1Sew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbhI1SeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:34:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40073C061746;
        Tue, 28 Sep 2021 11:32:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i4so47771lfv.4;
        Tue, 28 Sep 2021 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+CYfrIO1JCw1yxm6yg+/r1TsCdRkQWZWs7PCERtxoE=;
        b=NxxHSHEqx5cBCRtezWHHqmqIDBczPEzUFzqarhaQ7yDb9PcQXiK3pjqbgZII8wI/34
         fu006zFbJs1bfrRhChbg38ch4nSptHGRQobJ7gpR3Nf8MKdUBm1Ls0EP5J68I3jttFS5
         g88KyyqBWTs1fvTdgHOOXCnoNVWjIFgHBG40x5K+EwgOdMJNCuAdlpaiwrPskn0V9oov
         GOgA9aVyAT1ib22TcHjIYzqneT3hYbq7RHM/VwKHxckBoVIPr9vgJkbYAi84J2QQaFke
         XZpyBnr4fj9cuCcUhybTWojOBFxy+wJgkozCH+5Y/whW4hOvB2FXQiHvcbJH4pV1fEQg
         z3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+CYfrIO1JCw1yxm6yg+/r1TsCdRkQWZWs7PCERtxoE=;
        b=cuG52Y/jCoIFYvYwE2expFeSpTywLa0IBmqKzLdz03OGXe2Gkdo9NxDuU5bDXY1Axs
         Ov8PyMBQOFfiaG5Vmz6a6mUNHVXCpm+dwKEmeNbbXBocule28hWfiTg4JPHlnjSQB1s7
         6mmW5WV3wtcWcg+XLKdFndDZCHTPMmC5qo7eXAmpHkGiAmT6uJX9PtgNPxB8cTQJ1C50
         Fi5hJ/uxKQPZ2LZekrQ0rxaKaC6XXZHl4kUnUn24+ayWv/2YeT/00PaIThXacGhSUt6P
         AHh5aEYreytSqSsPAVdOhypYFSK+9Pd3DJg/OXBO4tz1DeWtkRFUee/I9y6QDktSlRjE
         AOLA==
X-Gm-Message-State: AOAM532LRtX5pMPYOojTaucNrE2JuhApw3Ltcn4f5lnu669SGdszQdmK
        EggwQVoO/ifDgX0u5F2zZlci+icRias=
X-Google-Smtp-Source: ABdhPJxI/hl8PMmYNQUW8K1GZjpDc+8DxBV5fxrptnA97ex+/ZC+hX89FNRKJ5SIB8Ui7ljOdI/FxQ==
X-Received: by 2002:a05:651c:988:: with SMTP id b8mr1385441ljq.187.1632853954646;
        Tue, 28 Sep 2021 11:32:34 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t12sm1988158lfc.55.2021.09.28.11.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 11:32:34 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:32:32 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Forbid FALLOC_FL_PUNCH_HOLE for normal files
Message-ID: <20210928183232.qi63jh2feknm3e7t@kari-VirtualBox>
References: <fad6f129-c53f-d751-be43-c403b1031449@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad6f129-c53f-d751-be43-c403b1031449@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:25:58PM +0300, Konstantin Komarov wrote:
> FALLOC_FL_PUNCH_HOLE isn't allowed with normal files.

But is this absolute or just for now it can't? In my mind this can be
done, but you are expert here. Please write about it here. This will
help who ever will implement this in future. Example why ntfs_zero_range
did not punch a hole for normal file. You did actually implement that
function for this purpose right?

> Fixes xfstest generic/016 021 022

Lot of grepping is done with these so use full format generic/xxx with
each of these.

Also this affects also to these, but I did not look if there is other
problems than punching.

  generic/012
  generic/177
  generic/255
  generic/316


Add fixes tag here.
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

> ---
>  fs/ntfs3/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 5fb3508e5422..02ca665baa5f 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -587,8 +587,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
>  		truncate_pagecache(inode, vbo_down);
>  
>  		if (!is_sparsed(ni) && !is_compressed(ni)) {
> -			/* Normal file. */
> -			err = ntfs_zero_range(inode, vbo, end);
> +			/* Normal file, can't make hole. */

If this is just for now plese write example
			/* TODO: Can't make hole to normal files yet. */

> +			err = -EOPNOTSUPP;
>  			goto out;
>  		}
>  
> -- 
> 2.33.0
> 
