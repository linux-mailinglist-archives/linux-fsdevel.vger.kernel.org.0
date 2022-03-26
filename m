Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E34E7E19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiCZAYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 20:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiCZAYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B0B25004A
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648254151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TaqVAZhHwYePXAlx8VX2R1s1xZM4U8mAR6j3BQ/H/U4=;
        b=DytmaY0jtqD1uRKRwwBetEpBUH6a4vXiP7bPMASgvD+sT4h89dnLk5DoWLpYKETxDKwosH
        qwC0oDhWY7/K43YxHIGGLJ+V00zDbbd0/Puj2qJ0r7PlmMC+l6Pe79eYHAZNH13UIiNUrp
        1KOZ6rnRpsEBCaWv2mbYnPAgjBAiTH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50--fufjTZeMKq-Qlt0304Jbg-1; Fri, 25 Mar 2022 20:22:29 -0400
X-MC-Unique: -fufjTZeMKq-Qlt0304Jbg-1
Received: by mail-wm1-f71.google.com with SMTP id 2-20020a1c0202000000b0038c71e8c49cso5830878wmc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 17:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaqVAZhHwYePXAlx8VX2R1s1xZM4U8mAR6j3BQ/H/U4=;
        b=beQpI+e64WaEzfew4XMCqM4KqueVTQ/rF/MFRNdkvv28UTEFD56UYutIvLVNPg95fg
         0/rFsXPlcrGcs2ijAHy9c/kSPKVC7PVlme3jV8fLoKVbLcJ5edWh8n4t9EtDp605ZWyq
         c3Q5Pfxd60LTstwt9tnIuzKkQeO550CeqFXpMCs9B4xvHSUU4Mf5tGvSk2PeRXcigmXq
         IQDCOrt5Kb2nNI0qy3+w1edWJQNaONzjE/khSnlXB3vtjREYHMGBXtrrVPaNHju1Hmz1
         yRV3njyK7Osg8mCm5n0a4l9K/bTScxGPSRviDhUo0SPv96qqLdzTXo9b2h6e5I7U1F+b
         peyA==
X-Gm-Message-State: AOAM5315zsy091nZJEn+JWQp8WM3CoROZpajIofuULEgx853ef2CSvfU
        0N54sSJVIvnSexZnyzCqJ8NDQQ2HU/9XDJvgwakNTBQFczIKMQehgXQKDGhZEzmdVNg3TwxH8SI
        NrOgeoThgPyEyr09Ur2Xviq5iu+V/ay6XdSjvW8vgMg==
X-Received: by 2002:a05:600c:154b:b0:38c:ca19:357d with SMTP id f11-20020a05600c154b00b0038cca19357dmr14517188wmg.51.1648254148630;
        Fri, 25 Mar 2022 17:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7fv050p0+dCduoo9IIz2j41oDw3e9pP6zuYTcPmxsfP6cTyo6B3HDfnR7Fww5eAw5mEwIUQk3CAJR/7itvTQ=
X-Received: by 2002:a05:600c:154b:b0:38c:ca19:357d with SMTP id
 f11-20020a05600c154b00b0038cca19357dmr14517177wmg.51.1648254148422; Fri, 25
 Mar 2022 17:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220325143701.144731-1-agruenba@redhat.com> <20220326000337.GD8182@magnolia>
In-Reply-To: <20220326000337.GD8182@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 26 Mar 2022 01:22:17 +0100
Message-ID: <CAHc6FU6ys6gQjqpT-p0b+9pRzQPGemvviAMJNgBvmXaM27k7jA@mail.gmail.com>
Subject: Re: [GIT PULL] fs/iomap: Fix buffered write page prefaulting
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 26, 2022 at 1:03 AM Darrick J. Wong <djwong@kernel.org> wrote:
> On Fri, Mar 25, 2022 at 03:37:01PM +0100, Andreas Gruenbacher wrote:
> > Hello Linus,
> >
> > please consider pulling the following fix, which I've forgotten to send
> > in the previous merge window.  I've only improved the patch description
> > since.
> >
> > Thank you very much,
> > Andreas
> >
> > The following changes since commit 42eb8fdac2fc5d62392dcfcf0253753e821a97b0:
> >
> >   Merge tag 'gfs2-v5.16-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-17 15:55:07 -0800)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/write-page-prefaulting
> >
> > for you to fetch changes up to 631f871f071746789e9242e514ab0f49067fa97a:
> >
> >   fs/iomap: Fix buffered write page prefaulting (2022-03-25 15:14:03 +0100)
>
> When was this sent to fsdevel for public consideration?  The last time I
> saw any patches related to prefaulting in iomap was November.

On November 23, exact same patch:

https://lore.kernel.org/linux-fsdevel/20211123151812.361624-1-agruenba@redhat.com/

Andreas

