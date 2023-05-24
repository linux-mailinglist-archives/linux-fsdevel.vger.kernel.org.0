Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1D70F134
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbjEXIkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbjEXIkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 04:40:05 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641791BD5;
        Wed, 24 May 2023 01:38:57 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4572fc80fe2so507097e0c.1;
        Wed, 24 May 2023 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684917508; x=1687509508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfarnodxQu2uVifQlwyFWQBlKRRu34cl2qnKn/jHsVk=;
        b=DqQa3/3cv/yETeS+tnJXyueNRkd6494IjWgKyztrzD2dU3E9eeaebzKLmvSG4wdzpy
         QYGiITCSFHc7jLBkhP/AdlT9H5ZOSpDq33HfmvXaq8Us2mBX9w9CWMJ5gt8PhebWq9vn
         8ZHHNYGHmd7O1DxZ+EREkLoRZjeSmR+q2vJTlG6sLPnfUNm2rQpaAt1gUgcQdyADOoIE
         fq4QjJ60Ms85nLvLeNeFiWFsHdWt9F7GmLzjkgkxuNY8loiif0XPL4QWUkgCLiGlrzyH
         YWKEo+LmuiVR7yajpa9M3AQmU2yBm+VV4M1kiyqpeFNc18N5iyHIVgb9p+ZaOJs5Xpsa
         BoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917508; x=1687509508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfarnodxQu2uVifQlwyFWQBlKRRu34cl2qnKn/jHsVk=;
        b=YWrGMSbFO4u7B2N4tm0L2Y7qPhqcIwFg70Zg6oYXfB16FcE3oZWhQTNN0pkIsyyloi
         iUYTi3qK2DP9Ozi/p344CS5P5eg9eGKIOPIa2KhGUQk4VXHtUgVU5NGKTP5sJykfkQrc
         aziJ2aKihDvHHjZAU22ATTY5tEozZGcIkW81Wjk8yGEjhemfN2PSRqJXZAwZ5Ji+EpVD
         401hcdEZtAeyhzY0FLPKFZd3dEJl+DymOux0t47keyo5+gspUWxjC8uG8uPeH81lE8or
         16+Cj9qpRJ2RXctOFRUp5o/jrxY77+7lYyO92GBPBxanC6TcdhotDfvCO9dIOVIqSySz
         Lz4w==
X-Gm-Message-State: AC+VfDyP4Q68AkoFLyXtPbcyuOLuuXSr1YxIBuJ7DGAdH+TKqeY/gi8Q
        WDaKxJomNkEmmhwTIgURiuXUkzzncn7/aE2XEwhxaFkWq7w=
X-Google-Smtp-Source: ACHHUZ5xQRUy4pMOWZxpLLW/9i1uu+tK709ow3UcPYu8kFXzlb77oIdNVsh6fQO2qPmE9ogKKz+uaTpE5r+5AY8wz4M=
X-Received: by 2002:a67:eb48:0:b0:439:4c9c:1f00 with SMTP id
 x8-20020a67eb48000000b004394c9c1f00mr2878336vso.30.1684917508396; Wed, 24 May
 2023 01:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
In-Reply-To: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 May 2023 11:38:17 +0300
Message-ID: <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file handles
To:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 9:34=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Amir Goldstein,
>
> The patch 7ba39960c7f3: "fanotify: support reporting non-decodeable
> file handles" from May 2, 2023, leads to the following Smatch static
> checker warning:
>
>         fs/notify/fanotify/fanotify.c:451 fanotify_encode_fh()
>         warn: assigning signed to unsigned: 'fh->type =3D type' 's32min-(=
-1),1-254,256-s32max'
>
> (unpublished garbage Smatch check).
>
> fs/notify/fanotify/fanotify.c
>     403 static int fanotify_encode_fh(struct fanotify_fh *fh, struct inod=
e *inode,
>     404                               unsigned int fh_len, unsigned int *=
hash,
>     405                               gfp_t gfp)
>     406 {
>     407         int dwords, type =3D 0;
>     408         char *ext_buf =3D NULL;
>     409         void *buf =3D fh->buf;
>     410         int err;
>     411
>     412         fh->type =3D FILEID_ROOT;
>     413         fh->len =3D 0;
>     414         fh->flags =3D 0;
>     415
>     416         /*
>     417          * Invalid FHs are used by FAN_FS_ERROR for errors not
>     418          * linked to any inode. The f_handle won't be reported
>     419          * back to userspace.
>     420          */
>     421         if (!inode)
>     422                 goto out;
>     423
>     424         /*
>     425          * !gpf means preallocated variable size fh, but fh_len c=
ould
>     426          * be zero in that case if encoding fh len failed.
>     427          */
>     428         err =3D -ENOENT;
>     429         if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4) || fh_len > MA=
X_HANDLE_SZ)
>     430                 goto out_err;
>     431
>     432         /* No external buffer in a variable size allocated fh */
>     433         if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
>     434                 /* Treat failure to allocate fh as failure to enc=
ode fh */
>     435                 err =3D -ENOMEM;
>     436                 ext_buf =3D kmalloc(fh_len, gfp);
>     437                 if (!ext_buf)
>     438                         goto out_err;
>     439
>     440                 *fanotify_fh_ext_buf_ptr(fh) =3D ext_buf;
>     441                 buf =3D ext_buf;
>     442                 fh->flags |=3D FANOTIFY_FH_FLAG_EXT_BUF;
>     443         }
>     444
>     445         dwords =3D fh_len >> 2;
>     446         type =3D exportfs_encode_fid(inode, buf, &dwords);
>     447         err =3D -EINVAL;
>     448         if (!type || type =3D=3D FILEID_INVALID || fh_len !=3D dw=
ords << 2)
>
> exportfs_encode_fid() can return negative errors.  Do we need to check
> if (!type etc?

Well, it is true that exportfs_encode_fid() can return a negative value
in principle, as did exportfs_encode_fh() before it, if there was a filesys=
tem
implementation of ->encode_fh() that returned a negative value.
AFAIK, there currently is no such implementation in-tree, otherwise current
upstream code would have been buggy.

Patch 2/4 adds a new possible -EOPNOTSUPP return value from
exportfs_encode_inode_fh() and even goes further to add a kerndoc:
 * Returns an enum fid_type or a negative errno.
But this new return value is not possible from exportfs_encode_fid()
that is used here and in {fa,i}notify_fdinfo().

All the rest of the callers (nfsd, overlayfs, name_to_hanle_at) already
check this same EOPNOTSUPP condition before calling, but there is
no guarantee that this will not change in the future.

All the callers mentioned above check the unexpected return value different=
ly:
nfsd: only type =3D=3D FILEID_INVALID
fdinfo: type < 0 || type =3D=3D FILEID_INVALID
fanotify: !type || type =3D=3D FILEID_INVALID
overlayfs: type < 0 || type =3D=3D FILEID_INVALID
name_to_hanle_at: (retval =3D=3D FILEID_INVALID) || (retval =3D=3D -ENOSPC)=
)
                /* As per old exportfs_encode_fh documentation
                 * we could return ENOSPC to indicate overflow
                 * But file system returned 255 always. So handle
                 * both the values
                 */

So he have a bit of a mess.
How should we clean it up?

Option #1: Change encode_fh to return unsigned and replace that new
                  EOPNOTSUPP with FILEID_INVALID
Option #2: change all callers to check negative return value

I am in favor of option #2.
Shall I send a patch?

Thanks,
Amir.
