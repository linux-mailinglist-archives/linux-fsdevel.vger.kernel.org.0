Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2426F6E9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjEDPH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjEDPHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:07:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394110D8;
        Thu,  4 May 2023 08:07:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so18305342a12.0;
        Thu, 04 May 2023 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683212842; x=1685804842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WFS1x47blclBXskP77nCF58D51Rpg9+wJAmzlYQmRk=;
        b=iOENyJgHIcqMP2+ca+2v80DT2ibR3iO9OVec9sAfKp7iLNAEq9mujvSiuMFX0BeHxf
         FXeeGNJEllsKwvy5a7JoPvL5PkZDu7W3NmC/C+73rZwfW4xKcrl2OUlXbzgVBx9jb5s5
         3zmGR16y/wilEY8jd7r7+vccxMYIjQq9Gr8pKGIXxn+nE11U6nj5XCsdwj97PPQkmqYt
         F8RnwS5MsdoCAwdzSCN2vL5FoakB8av51upu1FZinjJDEwDrPYO0+Wzm/oJWGSjScrVQ
         QptWn+fjuB0LzpTlL4bdxjJ9Vm9todUZ0BCPONAUOiMTsuJBDn82A34/N137dRuh+b6F
         Mawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212842; x=1685804842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WFS1x47blclBXskP77nCF58D51Rpg9+wJAmzlYQmRk=;
        b=fZ65Y5OEbsFJMwzGVqWwsyFY5M/I5F/dQ4DT2AktfFu3BVmH6M2+Kt2jp0cUNMbXY7
         /2xl/maGhb49/Yyjm2le/6V3eFLxr7L+HPdlSvdx8Z014j6AtkoX4vJN6ZWbQ3VJOb/5
         62ZC6BqxwGcKdX6DoYNQbbTUDTG8Z3AW7bcfmeB2I4unBbGYFnXzeg43uuqjlK1N2hiq
         8aCmBzt9gUVv65R4RU11hObHnm+D6Vuou6PQSE1uNTxCpDEPifgMtdrA3UP9TZZOcJ/v
         fHTDZ7U16h6BHegsn3H43G+UI0BUNWT6GRlPj94edLiQw31yfCsHbI85SkW+vk+ADlJP
         2kDw==
X-Gm-Message-State: AC+VfDxxiqgA0PxKKrRqpuMUaLLCVRadcrhrHmy6WY3PrCT9CdYI6K+i
        oaf3OQ2OPS9pH9ovj8oUaTtQcUZ5dIK76Kg8q5U=
X-Google-Smtp-Source: ACHHUZ4EZmZqjOJWc+m9y3XiZVF1YH6IrfUtVWGSTRu5Mvda+qI8kMR4AtvmrTycSugn84PacQcC4fD2dgIHHkhmutU=
X-Received: by 2002:a17:906:9746:b0:960:ddba:e5bf with SMTP id
 o6-20020a170906974600b00960ddbae5bfmr5322943ejy.0.1683212842404; Thu, 04 May
 2023 08:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230504105624.9789-1-idryomov@gmail.com> <20230504135515.GA17048@lst.de>
 <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
In-Reply-To: <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 4 May 2023 17:07:10 +0200
Message-ID: <CAOi1vP_sEab6A3hsdZbVjvOXzWgFBJzrBZ4o9zNr7TT6fivTQg@mail.gmail.com>
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block device
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
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

On Thu, May 4, 2023 at 4:16=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, May 04, 2023 at 03:55:15PM +0200, Christoph Hellwig wrote:
> > On Thu, May 04, 2023 at 12:56:24PM +0200, Ilya Dryomov wrote:
> > > Commit 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue
> > > and a sb flag") introduced a regression for the raw block device use
> > > case.  Capturing QUEUE_FLAG_STABLE_WRITES flag in set_bdev_super() ha=
s
> > > the effect of respecting it only when there is a filesystem mounted o=
n
> > > top of the block device.  If a filesystem is not mounted, block devic=
es
> > > that do integrity checking return sporadic checksum errors.
> >
> > With "If a file system is not mounted" you want to say "when accessing
> > a block device directly" here, right?  The two are not exclusive..
> >
> > > Additionally, this commit made the corresponding sysfs knob writeable
> > > for debugging purposes.  However, because QUEUE_FLAG_STABLE_WRITES fl=
ag
> > > is captured when the filesystem is mounted and isn't consulted after
> > > that anywhere outside of swap code, changing it doesn't take immediat=
e
> > > effect even though dumping the knob shows the new value.  With no way
> > > to dump SB_I_STABLE_WRITES flag, this is needlessly confusing.
> >
> > But very much intentional.  s_bdev often is not the only device
> > in a file system, and we should never reference if from core
> > helpers.
> >
> > So I think we should go with something like this:
> >
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index db794399900734..aa36cc2a4530c1 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -3129,7 +3129,11 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable)=
;
> >   */
> >  void folio_wait_stable(struct folio *folio)
> >  {
> > -     if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
> > +     struct inode *inode =3D folio_inode(folio);
> > +     struct super_block *sb =3D inode->i_sb;
> > +
> > +     if ((sb->s_iflags & SB_I_STABLE_WRITES) ||
> > +         (sb_is_blkdev_sb(sb) && bdev_stable_writes(I_BDEV(inode))))
> >               folio_wait_writeback(folio);
> >  }
> >  EXPORT_SYMBOL_GPL(folio_wait_stable);
>
> I hate both of these patches ;-)  What we should do is add
> AS_STABLE_WRITES, have the appropriate places call
> mapping_set_stable_writes() and then folio_wait_stable() becomes
>
>         if (mapping_test_stable_writes(folio->mapping))
>                 folio_wait_writeback(folio);
>
> and we remove all the dereferences (mapping->host->i_sb->s_iflags, plus
> whatever else is going on there)

Hi Matthew,

We would still need something resembling Christoph's suggestion for
5.10 and 5.15 (at least).  Since this fixes a regression, would you
support merging the "ugly" version to facilitate backports or would
you rather see the AS/mapping-based refactor first?

Thanks,

                Ilya
