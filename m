Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602AC76B0A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 12:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjHAKPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjHAKPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:15:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3111B6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 03:15:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so43274685ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690884918; x=1691489718;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnXnzK5CtQeWqRxx6QzS0c0NRYdTpKQSWUsO2xIBVxA=;
        b=cXV7901i6AWgCTWP2K2yTKFUDRUecy/Tb6Cqa1bcmEZjyj1NLvcDXuvS+rKF/sBuJ2
         2h6vUeoayMq5TEW9Q7uYxuK3Y/dm8JRQemM46OFjF18tL8xqbfPrOIZYNMYfy6Ef4jvq
         SBdjD/9vvneWZFzFmQgLoQ7oW6OW7kt673AljusUKoWoiA/3haR6QQ1BWrpphs+zcisx
         ICihA/hfJ7cxpmXDZQYVLep53TUzR8xT9GTzic3rRH3w3xdfHQj58/3Dh2BuyqbkY2/c
         RQdutTVVt4M7EeJEQjE15FkHAFNwJr1fvuDhskI/4mQPT4ti5/lmx1ex4E0s6x4yw7Ym
         /r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884918; x=1691489718;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnXnzK5CtQeWqRxx6QzS0c0NRYdTpKQSWUsO2xIBVxA=;
        b=EvWB2IgqWRtA3pnicmspQswODb0AEbKv0nuryXl71fEStjlpe1wdmNaURJ6LSfAqVl
         Ptw67DqjDwpU9BAXbRP9jyxE+gJHUxYyijOR/xuVoozRmpWFgD5ARzdmbF8HYMw5Oe7M
         HR5rAYbC7N+oXs87Mo4CPFQGNPBZkl5NkbzGGaM3IdivckWYxKm4BxxrCPVPu48a24Mi
         PuUgDSLDDJUYF27C0uLJOD6y6Os2ppEI1OlT2qzskGlMCybD2JO0q5Z6bYUu0VBWaHD7
         1ME0UGbPgSzDqmrNsnwe2IIouXMhR5icNI4+xQmuuM00c+yVdZIhHwUq1ltZqQeicoZu
         R2dA==
X-Gm-Message-State: ABy/qLY6nUQY8P3UftOvwRmAhwSKVUl38JGFmdI+EpS7bS6MTyilg6bm
        yFlu3M9knCNeGsreJcetmDk=
X-Google-Smtp-Source: APBJJlGPFn4jdfN8GQfS3aUi8fKqGQnBrrrwGpniEikEqTm90XPEXDJhTxUZbK13/kWpT1iB7FgkNw==
X-Received: by 2002:a17:903:18f:b0:1b8:10a:d925 with SMTP id z15-20020a170903018f00b001b8010ad925mr14154474plg.5.1690884918162;
        Tue, 01 Aug 2023 03:15:18 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001bb1f0605b2sm10065106plx.214.2023.08.01.03.15.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2023 03:15:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 1/3] fuse: invalidate page cache pages before direct write
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20230801080647.357381-2-hao.xu@linux.dev>
Date:   Tue, 1 Aug 2023 18:14:59 +0800
Cc:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B98453E7-ABF1-426E-A752-553476D390C5@gmail.com>
References: <20230801080647.357381-1-hao.xu@linux.dev>
 <20230801080647.357381-2-hao.xu@linux.dev>
To:     Hao Xu <hao.xu@linux.dev>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 2023=E5=B9=B48=E6=9C=881=E6=97=A5 16:06=EF=BC=8CHao Xu =
<hao.xu@linux.dev> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Hao Xu <howeyxu@tencent.com>
>=20
> In FOPEN_DIRECT_IO, page cache may still be there for a file since
> private mmap is allowed. Direct write should respect that and =
invalidate
> the corresponding pages so that page cache readers don't get stale =
data.

Do other filesystems also invalidate page cache in this case?

>=20
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
> fs/fuse/file.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bc4115288eec..3d320fc99859 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1465,7 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, =
struct iov_iter *iter,
> int write =3D flags & FUSE_DIO_WRITE;
> int cuse =3D flags & FUSE_DIO_CUSE;
> struct file *file =3D io->iocb->ki_filp;
> - struct inode *inode =3D file->f_mapping->host;
> + struct address_space *mapping =3D file->f_mapping;
> + struct inode *inode =3D mapping->host;
> struct fuse_file *ff =3D file->private_data;
> struct fuse_conn *fc =3D ff->fm->fc;
> size_t nmax =3D write ? fc->max_write : fc->max_read;
> @@ -1477,6 +1478,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, =
struct iov_iter *iter,
> int err =3D 0;
> struct fuse_io_args *ia;
> unsigned int max_pages;
> + bool fopen_direct_io =3D ff->open_flags & FOPEN_DIRECT_IO;
>=20
> max_pages =3D iov_iter_npages(iter, fc->max_pages);
> ia =3D fuse_io_alloc(io, max_pages);
> @@ -1491,6 +1493,14 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, =
struct iov_iter *iter,
> inode_unlock(inode);
> }
>=20
> + if (fopen_direct_io && write) {
> + res =3D invalidate_inode_pages2_range(mapping, idx_from, idx_to);
> + if (res) {
> + fuse_io_free(ia);
> + return res;
> + }
> + }
> +
> io->should_dirty =3D !write && user_backed_iter(iter);
> while (count) {
> ssize_t nres;
> --=20
> 2.25.1
>=20

