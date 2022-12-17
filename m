Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCE64FC42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLQUnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 15:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLQUnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:43:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB9DFA6;
        Sat, 17 Dec 2022 12:43:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so3971108wms.2;
        Sat, 17 Dec 2022 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU2IHu9IHMCR1i1u9LEoX9i/onRwkHb2knf00zrEks4=;
        b=GCR5sXlcaFKQMc4NLH4mTaeumKn6omx6zF4b3X1iJAolWtsv6akZkBhaS/+8e2U5gp
         kDsdkyIc6DN2OXHSpjMhKMFaBrzxyvm1vj9wVrghsu5aUWshsN2sx7zYLXWQofplaROy
         m6WZqjRom1vzLPgb1MdZj6RBVjo8m1mpQ/RKvbgqac+FcMXF0VJETpqox6Frw1oVp+rk
         AU3xddx/oB0e9Y2kqkdiXKKGm7Dd9wWeAuppLjUef7dmFaWrvI/ERqYqjdhPr+deM4K6
         bHEgsePwoYWpNkXCt3yFGTjqt4EGs+REeXIMvTRakv7zCLwuGXxNS9OECyob4Q6grnK4
         H3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AU2IHu9IHMCR1i1u9LEoX9i/onRwkHb2knf00zrEks4=;
        b=Ft4hmL7wikNhxG+zYd6UpuFxkmFEBti5RVisSy/bCDBg32UxKn2QjnjTAdAJmi8o1d
         r3OhKi/831BVlqjiUxbSvTV3pw/QxgfEIwHXt3rBxxGD6zQxOPLq35L0g7s0XJBMEIpU
         MnLQVHeAFoatQTAfhd362O97TpugXrFyz8M/Nz9IFAC5pMfTcxWEB0I3eYkA/1YCQo63
         SEB5OqQFp4XsAGBe6W7b81Mp61Nreu55riOr5CPMyQDdOq4AbFJvGSwK7rbFFzvbMD1Y
         eBi2/OGkUiAOWXS+4xvSSCsvHcpLYdOk96MqSQP9Eolsswo0asFlQU1qw1kFV72okfGI
         H1bg==
X-Gm-Message-State: ANoB5pm6uui/JM9lC8sNtUCjgyvd/y4NnjiJpC/vHH2zqidG/lGSPHpM
        8y2fEt+D+MA/htPpJniwHP8=
X-Google-Smtp-Source: AA0mqf4S/dvHuUmCg3kSnrkkcO/8DeKZcm42AwqZF0hQk75EgVLlPo4DZ3nFXuI1aPwi97gMqpdtXw==
X-Received: by 2002:a7b:c30e:0:b0:3cf:ab98:2245 with SMTP id k14-20020a7bc30e000000b003cfab982245mr28604634wmj.28.1671309793586;
        Sat, 17 Dec 2022 12:43:13 -0800 (PST)
Received: from suse.localnet (host-79-17-30-229.retail.telecomitalia.it. [79.17.30.229])
        by smtp.gmail.com with ESMTPSA id g2-20020a056000118200b0025e86026866sm1493210wrx.0.2022.12.17.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 12:43:12 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/8] Convert reiserfs from b_page to b_folio
Date:   Sat, 17 Dec 2022 21:43:11 +0100
Message-ID: <11295613.F0gNSz5aLb@suse>
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On venerd=EC 16 dicembre 2022 21:53:39 CET Matthew Wilcox (Oracle) wrote:
> These patches apply on top of
> https://lore.kernel.org/linux-fsdevel/20221215214402.3522366-1-willy@infr=
adead
> .org/
>=20
> The non-trivial ones mostly revolve around uses of kmap()/kmap_atomic(),
> so review from the experts on those would be welcome.

I took a quick look at your conversions and they made me recall that months=
=20
ago you converted to kmap_local_folio() a previous conversion from kmap() t=
o=20
kmap_local_page() in ext2_get_page(): commit 37ce0b319b287 ("ext2: Use a fo=
lio=20
in ext2_get_page()").

So I just saw kmap_local_folio again. Unfortunately, because of my=20
inexperience,  I'm not able to see why we should prefer the use of this=20
function instead of kmap_local_page().

Can you please tell me why and when we should prefer kmap_local_folio() in=
=20
those cases too where kmap_local_page() can work properly? I'm asking becau=
se=20
these days I'm converting other *_get_page() from kmap() (including the ser=
ies=20
to fs/ufs that I sent today).

> If these all look
> good to people, I can pass them off to Andrew for the 6.3 merge window.
>=20
> Running xfstests against reiserfs gives me 313/701 failures before and
> after this set of patches.

It has happened several times to me too. Some patches of mine have failures=
=20
from xfstests whose amounts and types don't change with or without my chang=
es.

Several of them have already been merged. I guess that if they don't add=20
further failures everything is alright.

However, something is broken for sure... xfstests or the filesystems? :-/=20

Thanks,

=46abio

> I don't have a huge amount of confidence
> that we're really getting good coverage from that test run!
>=20
> Matthew Wilcox (Oracle) (8):
>   reiserfs: use b_folio instead of b_page in some obvious cases
>   reiserfs: use kmap_local_folio() in _get_block_create_0()
>   reiserfs: Convert direct2indirect() to call folio_zero_range()
>   reiserfs: Convert reiserfs_delete_item() to use kmap_local_folio()
>   reiserfs: Convert do_journal_end() to use kmap_local_folio()
>   reiserfs: Convert map_block_for_writepage() to use kmap_local_folio()
>   reiserfs: Convert convert_tail_for_hole() to use folios
>   reiserfs: Use flush_dcache_folio() in reiserfs_quota_write()
>=20
>  fs/reiserfs/inode.c           | 73 +++++++++++++++++------------------
>  fs/reiserfs/journal.c         | 12 +++---
>  fs/reiserfs/prints.c          |  4 +-
>  fs/reiserfs/stree.c           |  9 +++--
>  fs/reiserfs/super.c           |  2 +-
>  fs/reiserfs/tail_conversion.c | 19 ++++-----
>  6 files changed, 59 insertions(+), 60 deletions(-)
>=20
> --
> 2.35.1




