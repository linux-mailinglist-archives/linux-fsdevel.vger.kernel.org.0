Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F176CD826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC2LFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjC2LFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:05:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F346BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 04:05:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ew6so61483885edb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112; t=1680087904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eluqVp/C/SwzC5R2Fc8/dT0cOBOV0ilcuPpFzkl8Nsk=;
        b=O+BQFFE2soMEyKFu3dL/kjPoEykjSvECx/PMDaNype85WmJ0Boe4PFjO+RLVt2gwRZ
         IvS6Lu7z5Sv0uv/7x7cOeD0egu0vuuu/HL3YlUsLxMgHV5SY/QY49fMqBKcwJYFhKa8H
         RfClc0I/laLhJrVARgZbY5FL2TiCwAjZ5SCxwnBq/FhfztaWP6UfyE2mU3Q9V2GXQKMF
         e3rpBosKzw+pkS1TRX25+9NfGS53IFyaaPeoY3VpO7u7zXlRpfCqsTXTzGv7a3HNvnTX
         TVbn5MZGG88FkuHJMtAlMomLAweg1SGU39ZoVxYlrnfoXnE/yXSFayU9mN6K0gRPsKKU
         tHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680087904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eluqVp/C/SwzC5R2Fc8/dT0cOBOV0ilcuPpFzkl8Nsk=;
        b=5DI754dN++asFeDzlJdMrscBPWboTIPUD2in2LuwbeCVkW9kE8MyMYxv3RCnSvEj0d
         vMMu0ypVq9jRY1thczP1xiLgxK4g1lIKHNlFLeQEKVUPwnp+6C1ndWm2SsxdXZvPkEdb
         3DUfG8PEZk3gMs/FBf8P7z5rONqkspbDeW1V8h3TJV8xPus/960kqzN4AQ+JxHjXrDlB
         HUoEc11eCEeBYH8AxsVNTrZZJGCW5MWmCykFR8ZcWxNe0oeR2N70BHf8oDivw1v/tXVx
         oxDiWH4Qk+ZT0BUqSTTTFyzxjV68Pota50GgaM2EcIxlK1ZsEzJ+01grcSHX9LpxXJ6u
         fHtA==
X-Gm-Message-State: AAQBX9f8BhKPg7LG0PO5wEJkxM1LQaP1BYPC+MEjtzAF1W8BMWVekCXh
        duoLKXVh5S0PedadcX3EAKkM/iaIN2HPktM6wdCXcFA0GjPEWfK0NSJelA==
X-Google-Smtp-Source: AKy350Y2mvc9UVCx3qgDGFwKx/yuGoBPeQjsRqBWVVxV5vQo867clW32fUi6BrA8hmND4AQF68wmbGP2xq/TmhZDH4Y=
X-Received: by 2002:a17:906:2416:b0:932:4d97:a370 with SMTP id
 z22-20020a170906241600b009324d97a370mr9135098eja.14.1680087904342; Wed, 29
 Mar 2023 04:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 29 Mar 2023 13:04:53 +0200
Message-ID: <CANr-nt1WuiZD2thrfQpzRqJjWRgC9DbeKzuhVb7GV2kd+O_xog@mail.gmail.com>
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Applied the patch on top of 6.3.0-rc4 and it solves the corruption issue I =
saw,
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>

Cheers!

On Wed, Mar 29, 2023 at 7:58=E2=80=AFAM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> When a direct append write is executed, the append offset may correspond
> to the last page of an inode which might have been cached already by
> buffered reads, page faults with mmap-read or non-direct readahead.
> To ensure that the on-disk and cached data is consistant for such last
> cached page, make sure to always invalidate it in
> zonefs_file_dio_append(). This invalidation will always be a no-op when
> the device block size is equal to the page size (e.g. 4K).
>
> Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>
> Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  fs/zonefs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 617e4f9db42e..eeab8b93493b 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -390,6 +390,18 @@ static ssize_t zonefs_file_dio_append(struct kiocb *=
iocb, struct iov_iter *from)
>         max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize)=
;
>         iov_iter_truncate(from, max);
>
> +       /*
> +        * If the inode block size (sector size) is smaller than the
> +        * page size, we may be appending data belonging to an already
> +        * cached last page of the inode. So make sure to invalidate that
> +        * last cached page. This will always be a no-op for the case whe=
re
> +        * the block size is equal to the page size.
> +        */
> +       ret =3D invalidate_inode_pages2_range(inode->i_mapping,
> +                                           iocb->ki_pos >> PAGE_SHIFT, -=
1);
> +       if (ret)
> +               return ret;
> +
>         nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
>         if (!nr_pages)
>                 return 0;
> --
> 2.39.2
>
