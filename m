Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE16A6EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCAOyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 09:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCAOye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:54:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2637730;
        Wed,  1 Mar 2023 06:54:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id t11so18021956lfr.1;
        Wed, 01 Mar 2023 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XelpH73Wlo+PcchMEWN6DkX2OQ+7tNP39REIEtZR3gA=;
        b=ldV7uSo+F9m2pHn6+dKPMriarQVSVqfCCg/7BTEuyk5SInOZr1EtbLHP4KKOz3EZXc
         wP0QoxCEyqtcVklir/r/KHb3lhAL5zienhZQLV/v55nG022ySe+S89DZ8/zM0hDgB7MW
         IZuDX/b8EIdCXws9+c5AdG52Wudck1ZrlMT3uI7w77qZrh5V51ZzlBj+pUkTbHKl2Bzn
         S7YTMVpERipYnTss9DC7/Xb9WoTs1vbn/xCvtdfSYPhk2EnIU04aX8xp3cfCLUYgWSP+
         axZIL4ja5c4hbqNm5ar19NEgxFd4kXiDsw/vCIefLkoBeob1hFM6R2tdPkkKIhw/BnJ1
         QCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XelpH73Wlo+PcchMEWN6DkX2OQ+7tNP39REIEtZR3gA=;
        b=MH+ItLEhA5NPhaPn0zHy0EAkmw6qxXTIPK8A9HY+5ELM7udIKEyBKqp1dvqe9HRYzN
         NImvFPEwDbxzxgXYGAmPQf/bJPbxky/R26CWBeu4GM/8xfY9zbE0Fnkr2stDeBYOyCG3
         WQvMEmVz+y3Iousdedj/SzVQWpkWkqiv5AP4bPOyUo9P/7M9B7gGZoWlYrRv821wig9j
         uuDku60NKpB2N+3dmkB5kzQoI+GnupR06x3YE0kFUU8Hl8qTCoTLTNl0u6wHq/EsHFAO
         e+3xZpXZtlQFDDG+H+/9bAm8MHD9sjn6ShlzNWhnjQ1TUVgeA338VbsTBoIi17iRsewn
         HJ0A==
X-Gm-Message-State: AO0yUKWP0U3hmA44ynPm0TPL5HF0MGsiJVMC3flYvET+meXYpF5HZARa
        UThdGOSb/JTw65SyE8S6YT9x0rvYtlgPGnqvhqCvVNj2
X-Google-Smtp-Source: AK7set/AeqLMRRI9SdDjmlD28g8b1QRcF+vhfO4YjK2H5N0wuaMVTxwFAfNVAKZBORvcX2vMUujZpJ4nngZw98AH7gc=
X-Received: by 2002:a05:6512:340f:b0:4d5:ca32:6ed6 with SMTP id
 i15-20020a056512340f00b004d5ca326ed6mr3480637lfr.4.1677682463387; Wed, 01 Mar
 2023 06:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20230228223838.3794807-1-dhowells@redhat.com> <20230228223838.3794807-2-dhowells@redhat.com>
In-Reply-To: <20230228223838.3794807-2-dhowells@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 1 Mar 2023 08:54:12 -0600
Message-ID: <CAH2r5muh5g=QOuqFRvNMLdiiHiJF-9AX0rAE_9M8zxvfW8i3bA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cifs: Fix memory leak in direct I/O
To:     David Howells <dhowells@redhat.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

merged into cifs-2.6.git for-next pending more testing

On Tue, Feb 28, 2023 at 4:38=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> When __cifs_readv() and __cifs_writev() extract pages from a user-backed
> iterator into a BVEC-type iterator, they set ->bv_need_unpin to note
> whether they need to unpin the pages later.  However, in both cases they
> examine the BVEC-type iterator and not the source iterator - and so
> bv_need_unpin doesn't get set and the pages are leaked.
>
> I think this may be responsible for the generic/208 xfstest failing
> occasionally with:
>
>         WARNING: CPU: 0 PID: 3064 at mm/gup.c:218 try_grab_page+0x65/0x10=
0
>         RIP: 0010:try_grab_page+0x65/0x100
>         follow_page_pte+0x1a7/0x570
>         __get_user_pages+0x1a2/0x650
>         __gup_longterm_locked+0xdc/0xb50
>         internal_get_user_pages_fast+0x17f/0x310
>         pin_user_pages_fast+0x46/0x60
>         iov_iter_extract_pages+0xc9/0x510
>         ? __kmalloc_large_node+0xb1/0x120
>         ? __kmalloc_node+0xbe/0x130
>         netfs_extract_user_iter+0xbf/0x200 [netfs]
>         __cifs_writev+0x150/0x330 [cifs]
>         vfs_write+0x2a8/0x3c0
>         ksys_pwrite64+0x65/0xa0
>
> with the page refcount going negative.  This is less unlikely than it see=
ms
> because the page is being pinned, not simply got, and so the refcount
> increased by 1024 each time, and so only needs to be called around ~20971=
52
> for the refcount to go negative.
>
> Further, the test program (aio-dio-invalidate-failure) uses a 32MiB stati=
c
> buffer and all the PTEs covering it refer to the same page because it's
> never written to.
>
> The warning in try_grab_page():
>
>         if (WARN_ON_ONCE(folio_ref_count(folio) <=3D 0))
>                 return -ENOMEM;
>
> then trips and prevents us ever using the page again for DIO at least.
>
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rathe=
r than a page list")
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Link: https://lore.kernel.org/r/CAH2r5mvaTsJ---n=3D265a4zqRA7pP+o4MJ36WCQ=
US6oPrOij8cw@mail.gmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Paulo Alcantara <pc@cjr.nz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/cifs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index ec0694a65c7b..4d4a2d82636d 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3612,7 +3612,7 @@ static ssize_t __cifs_writev(
>
>                 ctx->nr_pinned_pages =3D rc;
>                 ctx->bv =3D (void *)ctx->iter.bvec;
> -               ctx->bv_need_unpin =3D iov_iter_extract_will_pin(&ctx->it=
er);
> +               ctx->bv_need_unpin =3D iov_iter_extract_will_pin(from);
>         } else if ((iov_iter_is_bvec(from) || iov_iter_is_kvec(from)) &&
>                    !is_sync_kiocb(iocb)) {
>                 /*
> @@ -4148,7 +4148,7 @@ static ssize_t __cifs_readv(
>
>                 ctx->nr_pinned_pages =3D rc;
>                 ctx->bv =3D (void *)ctx->iter.bvec;
> -               ctx->bv_need_unpin =3D iov_iter_extract_will_pin(&ctx->it=
er);
> +               ctx->bv_need_unpin =3D iov_iter_extract_will_pin(to);
>                 ctx->should_dirty =3D true;
>         } else if ((iov_iter_is_bvec(to) || iov_iter_is_kvec(to)) &&
>                    !is_sync_kiocb(iocb)) {
>


--=20
Thanks,

Steve
