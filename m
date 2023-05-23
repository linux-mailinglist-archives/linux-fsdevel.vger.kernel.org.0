Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E134970DCDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjEWMrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEWMrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B98DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684845989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7u/znGyiabjVxMxzRvNLd3S88rx1+Ha0iKEs973f0I=;
        b=GkyBMbW4cw2c2IShFWkjT1grGeZ27czqzSdBGgiqnSQJY+oZ7rrqbfP0KD5OFWdr4VWqJX
        3K5904odsl3MFRzL9Db/+pZrkunb6aaZcGUNdBvMiK2BQdZcPQX6OljhKoWQ/gEmN7P73S
        8LNYQRGM1yRFgk9CTdVtQcrV2RHXIkY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-ZT-AJ859Ptynhiy66EHWYw-1; Tue, 23 May 2023 08:46:20 -0400
X-MC-Unique: ZT-AJ859Ptynhiy66EHWYw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ae763f9bdaso50320195ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684845980; x=1687437980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7u/znGyiabjVxMxzRvNLd3S88rx1+Ha0iKEs973f0I=;
        b=ONYCKfmgZpsH9pMZ6qkcHsbggZ7CEruKjlgCb7fgdfJMsdnkR+cZqIGMyGIkHqfBPA
         xspeDoFeDYvKIhUaJCN3rCUWnEyXVZ1dv3b0jN2jqOz7Fi4n0XVd+4F7eklPxOOWpHC1
         wfWUyDkLxBWgLmY24/N6GRD3p2PPZ2qLgQlRzAWyt2hcjoaojk18v1hL8nihX8D2D43O
         1lDH21TzNdYYMHH5xV97csU0aOZlbkpimsPnm8urwUEt1G2JTlsp3HLaJBq3CSZrwjHv
         BwD1VJRNw0M+28uheS99rAQk4n30rQdfG77pfY96Dyt5xLJkmD0M1g1KQptRvPPwvptn
         gEqg==
X-Gm-Message-State: AC+VfDxhnydfDFoKBfO3QBVhaQDooa2eXfx2V2lEUTdBcVWSS42voCmX
        AG32UTBusoXX4b5/EM1hDEGf3azSq4UUIL1+FO/p1F5WcxiYWf4N4K2cyG8xUXYCpERsIW75QjJ
        j1dF/L5ZoLSjiDvTjwSFfdDU7BB/KjSlpSQgSh38jQg==
X-Received: by 2002:a17:902:d50f:b0:19f:188c:3e34 with SMTP id b15-20020a170902d50f00b0019f188c3e34mr18581660plg.53.1684845979764;
        Tue, 23 May 2023 05:46:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7N6fKanmEa3wCjNdE4efUSeOJJfpKV6/MLDN/+XR06nDpu5lEwxuKA4KfSw+kLUXDSGFJTJAT0kooBFqNhnNg=
X-Received: by 2002:a17:902:d50f:b0:19f:188c:3e34 with SMTP id
 b15-20020a170902d50f00b0019f188c3e34mr18581630plg.53.1684845979448; Tue, 23
 May 2023 05:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230517032442.1135379-1-willy@infradead.org> <20230517032442.1135379-6-willy@infradead.org>
In-Reply-To: <20230517032442.1135379-6-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 23 May 2023 14:46:07 +0200
Message-ID: <CAHc6FU6GowpTfX-MgRiqqwZZJ0r-85C9exc2pNkBkySCGUT0FA@mail.gmail.com>
Subject: Re: [PATCH 5/6] gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 5:24=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> We may someday support folios larger than 4GB, so use a size_t for
> the byte count within a folio to prevent unpleasant truncations.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c | 2 +-
>  fs/gfs2/aops.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index e97462a5302e..8da4397aafc6 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -38,7 +38,7 @@
>
>
>  void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
> -                            unsigned int from, unsigned int len)
> +                            size_t from, size_t len)
>  {
>         struct buffer_head *head =3D folio_buffers(folio);
>         unsigned int bsize =3D head->b_size;

This only makes sense if the to, start, and end variables in
gfs2_trans_add_databufs() are changed from unsigned int to size_t as
well.

> diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
> index 09db1914425e..f08322ef41cf 100644
> --- a/fs/gfs2/aops.h
> +++ b/fs/gfs2/aops.h
> @@ -10,6 +10,6 @@
>
>  extern void adjust_fs_space(struct inode *inode);
>  extern void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio =
*folio,
> -                                   unsigned int from, unsigned int len);
> +                                   size_t from, size_t len);
>
>  #endif /* __AOPS_DOT_H__ */
> --
> 2.39.2
>

Thanks,
Andreas

