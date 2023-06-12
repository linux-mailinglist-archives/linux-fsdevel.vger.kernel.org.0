Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB372C533
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbjFLM4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjFLM43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C193C0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686574455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fz9whUJtpEY98j2Cwj5MhqkEs9MDaC4WXItYB7JCfUE=;
        b=Hgp7xfDuOIVXI28qxWVFxIaaWwv2LrkV/mDe1PGgl+bA2n1+naQjRej//zniLD+V9bUgDI
        RQuaW4nMYSdEc5fi29Iegvkk/asnUxJH78hx5RkMOba8aWZus2VH2gD+1jdcwpdH+0vzJE
        XIeVYEAFcSXNehTtVo8FtYkgxfF4NSU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-7zfpzOjnP-aa30FqC0fUBA-1; Mon, 12 Jun 2023 08:54:13 -0400
X-MC-Unique: 7zfpzOjnP-aa30FqC0fUBA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b3be4189b4so7461365ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574453; x=1689166453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz9whUJtpEY98j2Cwj5MhqkEs9MDaC4WXItYB7JCfUE=;
        b=Z4lvymo5Fv13YN7oak9Uc3NS98oT6UyliLeNKgAef9szrNYrku5xl93KUMtoP7NRLr
         kiF73NmZib6jpvwi7QXc+2kDP3Q3zLP1RYLpD2b5g+ZjwG4ZQ6/g/FCKoEbKRHXsaWmC
         K+V+hZ1BTpoFKZNDSVn7D+ETSyM3TpfEQHLAsbltwklrKFLJKfNFN142hBgBpUbko4ao
         ucehasAzP62y+wxzQUfuQn0ieUedVVuzc7UT0r6GcA5FD/zSmeD2WI5A8CnWnlQMDt1k
         IBD09gWZRr2UOtZ8W6N01qHiyYcrUUjXojoSLh2xQwm20bh7g1SLi6UnwFBsSa2lLJjs
         RRiA==
X-Gm-Message-State: AC+VfDzIioL4IKTptp9pquacvdnh98XSkmSqXSw7BNxAEjmrK9T7+2y4
        OKvtmk0QyLH8BS4mcqca3DcHprUgF7NvKyuP0IS5tQmHf21mm+QpPRQUaDfWWcSkYtwQX6F4Qph
        Q1DZS48Jj8d4z8aMbE+g7na1Cz/5h4K1ucBmKs0ICjg==
X-Received: by 2002:a17:902:d4c2:b0:1b2:5ade:9ebb with SMTP id o2-20020a170902d4c200b001b25ade9ebbmr6912403plg.2.1686574452876;
        Mon, 12 Jun 2023 05:54:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xN/2g6GJ+QxqHMvmL8Vs4i0rNTTLHb/2VRjjZXB3sAPZjZomoBxDOJKDPLadM3sAR3eMiX8hCHG5JLuLN13Y=
X-Received: by 2002:a17:902:d4c2:b0:1b2:5ade:9ebb with SMTP id
 o2-20020a170902d4c200b001b25ade9ebbmr6912392plg.2.1686574452592; Mon, 12 Jun
 2023 05:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686395560.git.ritesh.list@gmail.com> <606c3279db7cc189dd3cd94d162a056c23b67514.1686395560.git.ritesh.list@gmail.com>
 <ZIa6WLknzuxoDDT8@infradead.org>
In-Reply-To: <ZIa6WLknzuxoDDT8@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 12 Jun 2023 14:54:00 +0200
Message-ID: <CAHc6FU5xMQfGPuTBDChS=w2+t4KAbu9po7yE+7qGaLTzV-+AFw@mail.gmail.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for
 ifs state bitmap
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Sat, Jun 10, 2023 at 05:09:04PM +0530, Ritesh Harjani (IBM) wrote:
> > This patch adds two of the helper routines iomap_ifs_is_fully_uptodate(=
)
> > and iomap_ifs_is_block_uptodate() for managing uptodate state of
> > ifs state bitmap.
> >
> > In later patches ifs state bitmap array will also handle dirty state of=
 all
> > blocks of a folio. Hence this patch adds some helper routines for handl=
ing
> > uptodate state of the ifs state bitmap.
> >
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index e237f2b786bc..206808f6e818 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_if=
s(struct folio *folio)
> >
> >  static struct bio_set iomap_ioend_bioset;
> >
> > +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
> > +                                            struct iomap_folio_state *=
ifs)
> > +{
> > +     struct inode *inode =3D folio->mapping->host;
> > +
> > +     return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
> > +}
> > +
> > +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_stat=
e *ifs,
> > +                                            unsigned int block)
> > +{
> > +     return test_bit(block, ifs->state);

"block_is_uptodate" instead of "is_block_uptodate" here as well, please.

Also see by previous mail about iomap_ifs_is_block_uptodate().

> > +}
>
> A little nitpicky, but do the _ifs_ name compenents here really add
> value?

Since we're at the nitpicking, I don't find those names very useful,
either. How about the following instead?

iomap_ifs_alloc -> iomap_folio_state_alloc
iomap_ifs_free -> iomap_folio_state_free
iomap_ifs_calc_range -> iomap_folio_state_calc_range

iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
iomap_ifs_is_block_dirty -> iomap_block_is_dirty

iomap_ifs_set_range_uptodate -> __iomap_set_range_uptodate
iomap_ifs_clear_range_dirty -> __iomap_clear_range_dirty
iomap_ifs_set_range_dirty -> __iomap_set_range_dirty

Thanks,
Andreas

