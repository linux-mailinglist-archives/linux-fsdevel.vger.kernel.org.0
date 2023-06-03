Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A03720F00
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjFCJfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjFCJfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BECE49
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685784868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x58XsbDwgcPZPjys9OtSeiXoYr20YcCQo3VJQaPcuFI=;
        b=DD6Q9vBvzqARQYjQy3thJ38Cr30Jz440XeQ+qtUI2z6xqB0hV968eBKTWjyAmm4pLA8jtQ
        grMQ2X4PvJ1x/lBqtSqMnZe+oMKX3FyhWdDXhRK2SBzVCIh4tLDGwpasXk7wjlB5fnzin5
        6PwOsTvDuMmOXrWG7mb2AJPQ2ogGbC0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-8kDwraGONOy1F3lsAnQnpw-1; Sat, 03 Jun 2023 05:34:27 -0400
X-MC-Unique: 8kDwraGONOy1F3lsAnQnpw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3981eed0385so2958765b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jun 2023 02:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685784866; x=1688376866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x58XsbDwgcPZPjys9OtSeiXoYr20YcCQo3VJQaPcuFI=;
        b=PYRJit435ZnaZIfXQbz3L8MXY0DbWkku9Ihych/45klwNDIJWohAILhQU27NpFPzaV
         WLbxQ7dcsUxGkKfSQ5GoIrJElsRU/vzHV+WeTYaARka0bnkmAnSI6L6PMu8DwWZdK2+7
         hnGg1lBNh2ch4ILBd1r+FsB6WQ3+tG75AT7aIrWB4wrRCdekYKzJ+92m6bQiTb3ISecy
         m5fbrM7yxF3mwvT3vJhKiKCBRA/eK/Fy2HPL01iKgahhelVb/wDb3UdcSgTS8j4YBzU0
         IrlBB1bxwpY7OJ1BJ7GdofnMp8zBKIUUqnGXbR+hirw+2eNpweLKwM0pmbpZpgR9/run
         WQeg==
X-Gm-Message-State: AC+VfDzEWLbA0FY8smCCrqGuBQo+FhB0h3oRsauS3eU4sAhsPRrrRX+B
        x3pLiYjkfGOY+u0xNRJ9CILX7fMXkDIJHt8Tj44iQw2KqisvVLNs+gIJeSFnGdMQb65MMN3rA2U
        SOBnXRNY2b6uDgFh+k5p88nRKjy2DeV3CxKNAoC2p7tdQf4LkfQ==
X-Received: by 2002:a54:4487:0:b0:39a:5ea3:6b16 with SMTP id v7-20020a544487000000b0039a5ea36b16mr2727983oiv.41.1685784866303;
        Sat, 03 Jun 2023 02:34:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VKD+1A8NW7aigs8q2tndWPjsJKaJckriKXAwfdCOfkVQHaGIQbHD54PPd5XPRs6HbQzGCoJl71+k5dnqQr9I=
X-Received: by 2002:a54:4487:0:b0:39a:5ea3:6b16 with SMTP id
 v7-20020a544487000000b0039a5ea36b16mr2727969oiv.41.1685784865940; Sat, 03 Jun
 2023 02:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230517032442.1135379-1-willy@infradead.org> <20230517032442.1135379-4-willy@infradead.org>
In-Reply-To: <20230517032442.1135379-4-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 3 Jun 2023 11:34:14 +0200
Message-ID: <CAHc6FU4G1F1OXC233hT7_Vog9F8GNZyeLwsi+01USSXhFBNc_A@mail.gmail.com>
Subject: Re: [PATCH 3/6] gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

thanks for these patches. This particular one looks problematic:

On Wed, May 17, 2023 at 5:24=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> This function now supports large folios, even if nothing around it does.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 749135252d52..0f92e3e117da 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -82,33 +82,34 @@ static int gfs2_get_block_noalloc(struct inode *inode=
, sector_t lblock,
>  }
>
>  /**
> - * gfs2_write_jdata_page - gfs2 jdata-specific version of block_write_fu=
ll_page
> - * @page: The page to write
> + * gfs2_write_jdata_folio - gfs2 jdata-specific version of block_write_f=
ull_page
> + * @folio: The folio to write
>   * @wbc: The writeback control
>   *
>   * This is the same as calling block_write_full_page, but it also
>   * writes pages outside of i_size
>   */
> -static int gfs2_write_jdata_page(struct page *page,
> +static int gfs2_write_jdata_folio(struct folio *folio,
>                                  struct writeback_control *wbc)
>  {
> -       struct inode * const inode =3D page->mapping->host;
> +       struct inode * const inode =3D folio->mapping->host;
>         loff_t i_size =3D i_size_read(inode);
> -       const pgoff_t end_index =3D i_size >> PAGE_SHIFT;
> -       unsigned offset;
>
> +       if (folio_pos(folio) >=3D i_size)
> +               return 0;

Function gfs2_write_jdata_page was originally introduced as
gfs2_write_full_page in commit fd4c5748b8d3 ("gfs2: writeout truncated
pages") to allow writing pages even when they are beyond EOF, as the
function description documents.

This hack was added because simply skipping journaled pages isn't
enough on gfs2; before a journaled page can be freed, it needs to be
marked as "revoked" in the journal. Journal recovery will then skip
the revoked blocks, which allows them to be reused for regular,
non-journaled data. We can end up here in contexts in which we cannot
"revoke" pages, so instead, we write the original pages even when they
are beyond EOF. This hack could be revisited, but it's pretty nasty
code to pick apart.

So at least the above if needs to go for now.

>         /*
> -        * The page straddles i_size.  It must be zeroed out on each and =
every
> +        * The folio straddles i_size.  It must be zeroed out on each and=
 every
>          * writepage invocation because it may be mmapped.  "A file is ma=
pped
>          * in multiples of the page size.  For a file that is not a multi=
ple of
> -        * the  page size, the remaining memory is zeroed when mapped, an=
d
> +        * the page size, the remaining memory is zeroed when mapped, and
>          * writes to that region are not written out to the file."
>          */
> -       offset =3D i_size & (PAGE_SIZE - 1);
> -       if (page->index =3D=3D end_index && offset)
> -               zero_user_segment(page, offset, PAGE_SIZE);
> +       if (i_size < folio_pos(folio) + folio_size(folio))
> +               folio_zero_segment(folio, offset_in_folio(folio, i_size),
> +                               folio_size(folio));
>
> -       return __block_write_full_page(inode, page, gfs2_get_block_noallo=
c, wbc,
> +       return __block_write_full_page(inode, &folio->page,
> +                                      gfs2_get_block_noalloc, wbc,
>                                        end_buffer_async_write);
>  }
>
> @@ -137,7 +138,7 @@ static int __gfs2_jdata_write_folio(struct folio *fol=
io,
>                 }
>                 gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
>         }
> -       return gfs2_write_jdata_page(&folio->page, wbc);
> +       return gfs2_write_jdata_folio(folio, wbc);
>  }
>
>  /**
> --
> 2.39.2
>

Thanks,
Andreas

