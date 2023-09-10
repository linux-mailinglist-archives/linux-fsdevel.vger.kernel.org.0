Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82204799D07
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbjIJITy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJITx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 04:19:53 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A35187
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 01:19:47 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d7eed15ad69so3243230276.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 01:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694333986; x=1694938786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQDVEYR0NkrDO5D5DNG/VELdAd044MCaEh/R0RnIJkc=;
        b=dnPCBZXDgUjtJpXgEJPhElUO/kYF8VpBGG8RbzUXSuwfd479y8m9VyKFp021BrEu16
         4mfF1LSzuAgumAbtYeU7ylrly9SXXMrulw9hSa20plSl6daMs7Ep/3Af+fFvKMRzF/ct
         cEgUp3sTp+bn4LD867GQaATugOIzxJnQ9WCujlieTL7wRiv7jrfQCc7+CBOD+/uk7yFl
         hCSZNwqXx3rc60+axh8PCn73xke6ete+PUNvpfwM68H52PLL5YUmXvX7kMuQyONXszoU
         aO/EBh8tA6blelxlTeWLBHvFnAv7hnqddNu2OKA7fjotFpBctKxIep1n5hY2SRpv4RtJ
         EFvg==
X-Gm-Message-State: AOJu0YwqHHFy0JorAjtb/8MvICE3GV+Q/v0YcXt6XlG6D3OBI7sXGwG8
        X79wjYREo2vyBIlFRw23P9BFZ21SOA7xjQ==
X-Google-Smtp-Source: AGHT+IG5fYcghJ2SPRokn2ExRddpwjFzFOVRZ5/h/MtsrEPGjxLvaj9AUds4E00axYc9k8HimSfDZA==
X-Received: by 2002:a5b:191:0:b0:d78:7e1:a715 with SMTP id r17-20020a5b0191000000b00d7807e1a715mr5892322ybl.18.1694333986534;
        Sun, 10 Sep 2023 01:19:46 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id l7-20020a252507000000b00d7badcab84esm1156781ybl.9.2023.09.10.01.19.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 01:19:45 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d78328bc2abso3241023276.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 01:19:45 -0700 (PDT)
X-Received: by 2002:a25:ab8d:0:b0:d53:f98f:8018 with SMTP id
 v13-20020a25ab8d000000b00d53f98f8018mr6592647ybi.65.1694333985224; Sun, 10
 Sep 2023 01:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org> <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
In-Reply-To: <20230909224230.3hm4rqln33qspmma@moria.home.lan>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 10 Sep 2023 10:19:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3waT489ZyUPn-Qp_Nvq_E-N0uimV=iw5Nex+=Tc++xA@mail.gmail.com>
Message-ID: <CAMuHMdW3waT489ZyUPn-Qp_Nvq_E-N0uimV=iw5Nex+=Tc++xA@mail.gmail.com>
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

Hi Kent,

On Sun, Sep 10, 2023 at 12:42 AM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > So why can't we figure out that easier way? What's wrong with trying to
> > figure out if we can do some sort of helper or library set that assists
> > supporting and porting older filesystems. If we can do that it will not
> > only make the job of an old fs maintainer a lot easier, but it might
> > just provide the stepping stones we need to encourage more people climb
> > up into the modern VFS world.
>
> What if we could run our existing filesystem code in userspace?
>
> bcachefs has a shim layer (like xfs, but more extensive) to run nearly
> the entire filesystem - about 90% by loc - in userspace.
>
> Right now this is used for e.g. userspace fsck, but one of my goals is
> to have the entire filesystem available as a FUSE filesystem. I'd been
> planning on doing the fuse port as a straight fuse implementation, but
> OTOH if we attempted a sh vfs iops/aops/etc. -> fuse shim, then we would
> have pretty much everything we need to run any existing fs (e.g.
> reiserfs) as a fuse filesystem.
>
> It'd be a nontrivial project with some open questions (e.g. do we have
> to lift all of bufferheads to userspace?) but it seems worth
> investigating.

  1. https://xkcd.com/1200/ (not an exact match, but you should get the idea),
  2. Once a file system is removed from the kernel, would the user space
     implementation be maintained better?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
