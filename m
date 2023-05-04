Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B456F6E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjEDPD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjEDPDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:03:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63802212D;
        Thu,  4 May 2023 08:03:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965cc5170bdso15742466b.2;
        Thu, 04 May 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683212632; x=1685804632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZPwucIW5GqDao1eoawq4R9XIujOBKLVJb6Au+5ZDSc=;
        b=gMEnOLVhFevCkTaFlzLDRn9DF2WZ755pRUNhY+AQ3DVxSPSeHj3FKAHKoLHcEX9u51
         npPKzWX1r3ElINBDxyLofVS37AKuZgSA6P77vFZSjLiEOGOUZ9fGPFBRGUcRTDXBe5ex
         kjKs9i5zQvyy96wdlgTg2cgU3egROci/oom5qnaScJavK92TfjiK1bsEYn79zr8nBu64
         PJj8dAYaFLE3LtxEleo2p++bg5zr3kCnTx4u3/YcQRlYMG9IeOD2RXsgpjklKs+uTXXk
         aMgLrwfdU/j1PPMHV/cKKvchslR3O6D3g7+fQiIB+M5hNGgnMvUujt3nIF6CmbKGF4gJ
         ZB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212632; x=1685804632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZPwucIW5GqDao1eoawq4R9XIujOBKLVJb6Au+5ZDSc=;
        b=XADHHZXDOnwOoZ2EJTU7P2RfEJ6+GkO2151ROcFT9E9L34bvVFLyDl/PPcwhZb8rDp
         Yab05SMB6xxQ+ZgHsKNXE0JOtNI/xT+TtUI/xnXHciUwn+f2a9EsT9EBPbn5er1YnHb7
         G3kT9uOS76Lg4ZeTMkFFZfr57fxYTXi4dULHPAgmki02DzvhEjj8Gmoz/X8jEx8+HnVP
         c0GIosJ/2XnyE1IQJLzLDgwhr7YI6MDuz08yXNV45s2N4/P4rVafa3t4ScCeOm8r1Ml0
         FUvUT6h6/6RTyp+Kx4tlZtZzaQ0Glc5SinOZnmXP5ttyt1JVfgZ87POEAdSgCtFMfdSS
         5weQ==
X-Gm-Message-State: AC+VfDwZ+IVRluW8vvAxPhhPmfOzAzzj6fmA8IPiLM+OqmLKaUd7DfBA
        IhTArYechL/OxM+BFMQoyfpRdehhs5zq9BSUtNXer+KGqDc=
X-Google-Smtp-Source: ACHHUZ6+pFPSVk8eLdnfGAvJL57sEpRld3od1iv76xPflK+h+u0BJpwACepLkSUNo9C5c6y1Hgi4AkoWAVSpfuLaeSQ=
X-Received: by 2002:a17:907:60d3:b0:956:f4f8:23b6 with SMTP id
 hv19-20020a17090760d300b00956f4f823b6mr8070180ejc.43.1683212631746; Thu, 04
 May 2023 08:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230504105624.9789-1-idryomov@gmail.com> <20230504135515.GA17048@lst.de>
In-Reply-To: <20230504135515.GA17048@lst.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 4 May 2023 17:03:39 +0200
Message-ID: <CAOi1vP9Zit-A9rRk9jy+d1itaBzUSBzFBuhXE+EDfBtF-Mf0og@mail.gmail.com>
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block device
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, May 4, 2023 at 3:55=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Thu, May 04, 2023 at 12:56:24PM +0200, Ilya Dryomov wrote:
> > Commit 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue
> > and a sb flag") introduced a regression for the raw block device use
> > case.  Capturing QUEUE_FLAG_STABLE_WRITES flag in set_bdev_super() has
> > the effect of respecting it only when there is a filesystem mounted on
> > top of the block device.  If a filesystem is not mounted, block devices
> > that do integrity checking return sporadic checksum errors.
>
> With "If a file system is not mounted" you want to say "when accessing
> a block device directly" here, right?  The two are not exclusive..

Hi Christoph,

Right, I meant to say "when accessing a block device directly".

>
> > Additionally, this commit made the corresponding sysfs knob writeable
> > for debugging purposes.  However, because QUEUE_FLAG_STABLE_WRITES flag
> > is captured when the filesystem is mounted and isn't consulted after
> > that anywhere outside of swap code, changing it doesn't take immediate
> > effect even though dumping the knob shows the new value.  With no way
> > to dump SB_I_STABLE_WRITES flag, this is needlessly confusing.
>
> But very much intentional.  s_bdev often is not the only device
> in a file system, and we should never reference if from core
> helpers.
>
> So I think we should go with something like this:
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index db794399900734..aa36cc2a4530c1 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -3129,7 +3129,11 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
>   */
>  void folio_wait_stable(struct folio *folio)
>  {
> -       if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
> +       struct inode *inode =3D folio_inode(folio);
> +       struct super_block *sb =3D inode->i_sb;
> +
> +       if ((sb->s_iflags & SB_I_STABLE_WRITES) ||
> +           (sb_is_blkdev_sb(sb) && bdev_stable_writes(I_BDEV(inode))))
>                 folio_wait_writeback(folio);

Heh, this is almost exactly what I came up with initially (|| arms were
swapped in that version), but decided to improve upon after noticing the
writeable thing.

Thanks,

                Ilya
