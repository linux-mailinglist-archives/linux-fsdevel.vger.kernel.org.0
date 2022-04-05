Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0C4F40C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiDEPCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386556AbiDEOTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:19:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0EA4FC45
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 06:09:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j21so10913676qta.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg4DQ3va+ggIZindYuMztZOEkUohuYdcL763OAj5dyA=;
        b=QseR1eWbjhfToacS4jsrZPizfTRCdl2Q3N93XIEW2GAXZKP0MTuZbCwZ6FuUBoqjm6
         un4B11bIQP2xSfINWgUBOPCBhfLjgh/FLqWoHF4OVDtQUX2LSXtDl/QKJJlQgcx0Btt5
         +FrclakWfSVdRoMZykEYNvjROZAwV9sozJ3Nqyvw5ytrgdu1zUx+VoQfYEAk6A3l6v+P
         a+fx/c3hl3LUNkeHlL/K0yWYFOXt+kMu2BLx63milgTsScRLHCsUe2e3+TU4NSVUDhaO
         NUHc1LMX5vnYkMmXBw3mr7po4gtzUfgk7pqbpht17HBCXv7nxdMIAKg+Le67GP2tTnFv
         tHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg4DQ3va+ggIZindYuMztZOEkUohuYdcL763OAj5dyA=;
        b=1QL7bV0DpxjA08BD7EGbnkHEMg54G2DuHOiNedPbMTvGcVNKcNomChJMfg2K0vVDB8
         bkKv/jekqSggij/CUsrS2Te1uczBiucklMag9ILme7NSRa6FAojSAKxNleEVGWV2fmnI
         ZK7oum64gOKMbqTviC9lBmhE4mbQBF1qh4F3cyCozgqS0OrxtHFA4yBlaB+1n2OCXvIN
         aNrgXFd44TcTxhZYqMNHT4K/EmZ3gvkxgTfVNIRwtiUF98MM4Nt1QC9DQvBSiehDb0kJ
         rjbpWPJ7RXb9NA0dvaSaOuCSq/V3kyiYNMs50fdRudifBbRLjrUEtwSc9IeSnmzQsvis
         +zHQ==
X-Gm-Message-State: AOAM533pqz7fmsrLU25VIplvlTULr6JLE6kY0mPkkEKsOv1o/C1aEs+S
        vQeyYIb5OAzS/DcZq79iGzEb3Hnd5LRUsM8Gp74=
X-Google-Smtp-Source: ABdhPJwAoALQMxxG4xpm31afhMZPYUn67OIIwLNkeS+WXeHp+jpQjYHhSBAwZ/sF3zKVRtYXQH7DAe4+x3mLOP3hqG8=
X-Received: by 2002:a05:620a:170c:b0:680:48e4:1b1b with SMTP id
 az12-20020a05620a170c00b0068048e41b1bmr2060831qkb.258.1649164151449; Tue, 05
 Apr 2022 06:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-5-amir73il@gmail.com>
 <20220405125407.qn6ac5e3bpr5is6h@quack3.lan>
In-Reply-To: <20220405125407.qn6ac5e3bpr5is6h@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Apr 2022 16:09:00 +0300
Message-ID: <CAOQ4uxh3XvBnXs0d71Uk_6Df3_d4kP97sdLqpkHUu2AP32of2A@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] fsnotify: remove unneeded refcounts of s_fsnotify_connectors
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 5, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-03-22 10:48:52, Amir Goldstein wrote:
> > s_fsnotify_connectors is elevated for every inode mark in addition to
> > the refcount already taken by the inode connector.
> >
> > This is a relic from s_fsnotify_inode_refs pre connector era.
> > Remove those unneeded recounts.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I disagree it is a relict. fsnotify_sb_delete() relies on
> s_fsnotify_connectors to wait for all connectors to be properly torn down
> on unmount so that we don't get "Busy inodes after unmount" error messages
> (and use-after-free issues). Am I missing something?
>

I meant it is a relic from the time before s_fsnotify_inode_refs became
s_fsnotify_connectors.

Nowadays, one s_fsnotify_connectors refcount per connector is enough.
No need for one refcount per inode.

Open code the the sequence:
    if (inode)
        fsnotify_put_inode_ref(inode);
    fsnotify_put_sb_connectors(conn);

To see how silly it is.

Thanks,
Amir.
