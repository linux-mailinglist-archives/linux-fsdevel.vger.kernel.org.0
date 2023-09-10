Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10171799F14
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjIJR0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIJR0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 13:26:49 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB646133
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 10:26:44 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-591ba8bd094so34104887b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 10:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694366803; x=1694971603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d/Au1fHXa75PgVco+gMMH+imp/hCis9khLj99DfGd4=;
        b=sVV+vNME0o3eZKETQWhkcIo8JhSYAteCJ0ntjTOojQDumSCWpe7xm9eby3u3Ntdfi/
         fe/K0XtnR32A+lX41G6iSRVl9Xv/2GFWgjeH5CXks1TmHlMzdmFhnHgDpndgZBB7F3uI
         RnWB9SMmtFNVFdltaar61uONuWIlAWCxQLZtS1LK2JInzMRO43wLjX6M9Y03KjwfKyuS
         4p3RXA2MWHur36cCYSUDJfBF/XooY6hky12P+Oo51UdL+kK12bC2lfarjnhsdYPWZ+Yo
         qn8qG3jqItj+BwbF0TmJaifIUFOQ7THCgCFtgcVEBhuyblbT6tJZgurpKEEpPAV3Sdi2
         F8tg==
X-Gm-Message-State: AOJu0YzA8FQeg1Ao4Fk+94rMYQl871y8Gjk43rAS9USu0/Mo0dI+UcpL
        nkSxa3ruafdBAQSJUIggm1kXTYShqiShSg==
X-Google-Smtp-Source: AGHT+IGGoYn8f2mKQB5pHlX5X2BiVnbxFWb6ZqiZE9Y+p6ufdsRkTjGNtUKQTYKb1gMMtIe420r9gQ==
X-Received: by 2002:a0d:d48c:0:b0:578:1937:868b with SMTP id w134-20020a0dd48c000000b005781937868bmr7298968ywd.11.1694366803473;
        Sun, 10 Sep 2023 10:26:43 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id h6-20020a0df706000000b0058c55d40765sm1496260ywf.106.2023.09.10.10.26.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 10:26:42 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d7eed15ad69so3471086276.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 10:26:42 -0700 (PDT)
X-Received: by 2002:a25:2488:0:b0:d74:6c9f:e734 with SMTP id
 k130-20020a252488000000b00d746c9fe734mr7321441ybk.47.1694366801859; Sun, 10
 Sep 2023 10:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org> <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan> <CAMuHMdW3waT489ZyUPn-Qp_Nvq_E-N0uimV=iw5Nex+=Tc++xA@mail.gmail.com>
 <20230910163533.ysbcztauujywrbk4@moria.home.lan>
In-Reply-To: <20230910163533.ysbcztauujywrbk4@moria.home.lan>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 10 Sep 2023 19:26:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0VLMKdZbZnWbs8CrO_h-1bx6HW25bnN6Agq+N3PYatQ@mail.gmail.com>
Message-ID: <CAMuHMdV0VLMKdZbZnWbs8CrO_h-1bx6HW25bnN6Agq+N3PYatQ@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 10, 2023 at 6:35 PM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Sun, Sep 10, 2023 at 10:19:30AM +0200, Geert Uytterhoeven wrote:
> > On Sun, Sep 10, 2023 at 12:42 AM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > > > So why can't we figure out that easier way? What's wrong with trying to
> > > > figure out if we can do some sort of helper or library set that assists
> > > > supporting and porting older filesystems. If we can do that it will not
> > > > only make the job of an old fs maintainer a lot easier, but it might
> > > > just provide the stepping stones we need to encourage more people climb
> > > > up into the modern VFS world.
> > >
> > > What if we could run our existing filesystem code in userspace?
> > >
> > > bcachefs has a shim layer (like xfs, but more extensive) to run nearly
> > > the entire filesystem - about 90% by loc - in userspace.
> > >
> > > Right now this is used for e.g. userspace fsck, but one of my goals is
> > > to have the entire filesystem available as a FUSE filesystem. I'd been
> > > planning on doing the fuse port as a straight fuse implementation, but
> > > OTOH if we attempted a sh vfs iops/aops/etc. -> fuse shim, then we would
> > > have pretty much everything we need to run any existing fs (e.g.
> > > reiserfs) as a fuse filesystem.
> > >
> > > It'd be a nontrivial project with some open questions (e.g. do we have
> > > to lift all of bufferheads to userspace?) but it seems worth
> > > investigating.
> >
> >   1. https://xkcd.com/1200/ (not an exact match, but you should get the idea),
> >   2. Once a file system is removed from the kernel, would the user space
> >      implementation be maintained better?
>
> This would be for the filesystems that aren't getting maintained and
> tested, to eliminate accidental breakage from in-kernel refactoring and
> changing of APIs.
>
> Getting that code out of the kernel would also greatly help with
> security concerns.

OK, xkcd 1200 it is...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
