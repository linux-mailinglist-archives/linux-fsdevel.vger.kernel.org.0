Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866057A6E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 00:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjISW2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISW2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8AFBE
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695162443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ji3zY74AAdaK/amC610EHUTsu6YY14D+u0Ic8yX0wF0=;
        b=JIKpQWfA49zpIKNtrg5Aph4lwwQGKJyFRgdwxUCJ0InrRAD5FWx1T+ciJE1C8hKiRHPv3P
        N4I9EzBRdj1TpDKuIhQtdk3XTLExEikRFq8LiUw3hM3kL2ErxwOpVSdhFTxsy736+LLqjC
        uqBPqkyvq/H6WeXWITbuZLE5MbqQvm4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-7mbb9mfVPX6qyIkDII4ccw-1; Tue, 19 Sep 2023 18:27:21 -0400
X-MC-Unique: 7mbb9mfVPX6qyIkDII4ccw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-57769a3c0c7so4593627a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 15:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695162441; x=1695767241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji3zY74AAdaK/amC610EHUTsu6YY14D+u0Ic8yX0wF0=;
        b=bwMnbZQXhpI2hvKsiwTJ5aaOLHYlV7gKSmFWaq4vXs+3LHtddeDwHWa3dVkW5pvfmc
         2eph0z0yF2bqJHV4vlvwyJWiYsRru9i4sB6ctZr+R2bsdmMsOm+B04tIj2bQK5fqHQH7
         TyRQbje0eHKlBzhsZpkBbPhRVq469bJzydf7ur3shEV/UQe7BkhQpOVHkcEjDtyVIsqU
         nRv2oDCkYYlVmm+KdNulqR4/Zi09viG+f8vcjZ/vrBUoP8IFvyO5wiPrUG38wECf6UGy
         0i6ScIBkWe8OGE8Me1mLJ9hcH6ZPpDM7T6Z5ayc9gG1HEWSOpOEIujQMLnaBW6KS29ic
         5HJw==
X-Gm-Message-State: AOJu0YwAo1KVHcF1Y7zn18OmWJo9PvxHlzm8AlJui3T+b5Vz3BPAJqaZ
        L3+hB/y7r5RvnB4ygH93yb/opJY2kArEvPwRcm1SN2bZbUGc+KElwRw4qPnF1Wzrvuagj9m7vQR
        Qc/qid9TF467ha/Oh6JmdPoc80F63PsDiK4Gte9QVRw==
X-Received: by 2002:a05:6a21:7895:b0:13d:5b8e:db83 with SMTP id bf21-20020a056a21789500b0013d5b8edb83mr970431pzc.9.1695162440764;
        Tue, 19 Sep 2023 15:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvdFAMQ3u88UkWAe1LyDTaTZ9DZaFRmPuZojxyrc2071D47l1IiQLEM8pi3uRxKzn4ewwGY98liyEB7kMo1sI=
X-Received: by 2002:a05:6a21:7895:b0:13d:5b8e:db83 with SMTP id
 bf21-20020a056a21789500b0013d5b8edb83mr970415pzc.9.1695162440533; Tue, 19 Sep
 2023 15:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-8-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-8-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 20 Sep 2023 00:27:08 +0200
Message-ID: <CAHc6FU4-RSAsc-LWw2OuLDecofapd30OZhxyjVKLXzJNwh-ZoA@mail.gmail.com>
Subject: Re: [PATCH 07/26] gfs2; Convert gfs2_getjdatabuf to use a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks,

but this patch has an unwanted semicolon in the subject.

On Tue, Sep 19, 2023 at 7:00=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Use the folio APIs, saving four hidden calls to compound_head().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/meta_io.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index f1fac1b45059..b28196015543 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -400,26 +400,20 @@ static struct buffer_head *gfs2_getjdatabuf(struct =
gfs2_inode *ip, u64 blkno)
>  {
>         struct address_space *mapping =3D ip->i_inode.i_mapping;
>         struct gfs2_sbd *sdp =3D GFS2_SB(&ip->i_inode);
> -       struct page *page;
> +       struct folio *folio;
>         struct buffer_head *bh;
>         unsigned int shift =3D PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
>         unsigned long index =3D blkno >> shift; /* convert block to page =
*/
>         unsigned int bufnum =3D blkno - (index << shift);
>
> -       page =3D find_get_page_flags(mapping, index, FGP_LOCK|FGP_ACCESSE=
D);
> -       if (!page)
> -               return NULL;
> -       if (!page_has_buffers(page)) {
> -               unlock_page(page);
> -               put_page(page);
> +       folio =3D __filemap_get_folio(mapping, index, FGP_LOCK | FGP_ACCE=
SSED, 0);
> +       if (IS_ERR(folio))
>                 return NULL;
> -       }
> -       /* Locate header for our buffer within our page */
> -       for (bh =3D page_buffers(page); bufnum--; bh =3D bh->b_this_page)
> -               /* Do nothing */;
> -       get_bh(bh);
> -       unlock_page(page);
> -       put_page(page);
> +       bh =3D folio_buffers(folio);
> +       if (bh)
> +               get_nth_bh(bh, bufnum);

And we need this here:

    bh =3D get_nth_bh(bh, bufnum);

> +       folio_unlock(folio);
> +       folio_put(folio);
>         return bh;
>  }
>
> --
> 2.40.1
>
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

