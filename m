Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE534D2DC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiCILPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 06:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCILPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:15:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41F13CA2B;
        Wed,  9 Mar 2022 03:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 900B9B82023;
        Wed,  9 Mar 2022 11:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5476CC340EE;
        Wed,  9 Mar 2022 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646824488;
        bh=k62VYnEAja+A8m7m/Ypa0GboSWV+2bBhbEgOgQIQVR4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ra455ULILUulZFobV379nzboqFYi3ADAbkEj4B9+/CzI/43yRfkwPIo+Z8h7C+BOX
         n30vrJFpQF8OJ40Xlnp6jzeVzgMH+mg8pXx1IJQuOVaCunqMhcqlw9F0ISv1D1CUMg
         dC9WRDkvN6X/0CGRKQ366APg3kv/sJtuYsyPxjclha11pA7YWrdZ2OW8ojm6qLZISn
         6lTmlE+YPuUIItTJqxzYYv/tGAk+yPcNJtGgmaBEceyfCG6zaHvaC4g+HdHnKP057c
         KG+uC9ssTeeYJNT273ofFgIgQJTrBEjbr8pdJzapwK9q4hzY0rE/6WTGO93pEXhNHE
         XpuRYY3RcGDdQ==
Received: by mail-wr1-f48.google.com with SMTP id q14so2477025wrc.4;
        Wed, 09 Mar 2022 03:14:48 -0800 (PST)
X-Gm-Message-State: AOAM5323QugK2H0HUaUycwEcOSPEiY6KeEldVDaE6Pmu9ODEuAL5Iq1V
        +HdGQZOpN9CLLKGWnA/6JYOAYqUq/oBZJ6P7L5Q=
X-Google-Smtp-Source: ABdhPJy6hfL3Lomm6LHCjFT02ifY5Z2dI7dos7tZhxKknO38FbpSc3bNemFJ7dwu98T+AWRaPXffZcT0e/onc5UvZKA=
X-Received: by 2002:a5d:4387:0:b0:1ed:a13a:ef0c with SMTP id
 i7-20020a5d4387000000b001eda13aef0cmr15722930wrq.62.1646824486677; Wed, 09
 Mar 2022 03:14:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1d93:0:0:0:0 with HTTP; Wed, 9 Mar 2022 03:14:45
 -0800 (PST)
In-Reply-To: <HK2PR04MB38910EE3467822EBAB4CC79681099@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <CAKYAXd_hF+xYXNiawCZLYmnha+wSUSUCEJTVBw8v6UDYfjPiUg@mail.gmail.com> <HK2PR04MB38910EE3467822EBAB4CC79681099@HK2PR04MB3891.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 9 Mar 2022 20:14:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8c+qTqa_ymymFeZmcar+35_CYMjwP41GpbbiMeGUYxjw@mail.gmail.com>
Message-ID: <CAKYAXd8c+qTqa_ymymFeZmcar+35_CYMjwP41GpbbiMeGUYxjw@mail.gmail.com>
Subject: Re: [PATCH] exfat: do not clear VolumeDirty in writeback
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-08 19:55 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Hi Namjae Jeon,
>
>> > +int exfat_clear_volume_dirty(struct super_block *sb) {
>> > +	if (sb->s_flags & (SB_SYNCHRONOUS | SB_DIRSYNC))
>> How about moving exfat_clear_volume_dirty() to IS_DIRSYNC() check in each
>> operations instead of this check?
>
> I found that VolumeDirty keeps VOL_DIRTY until sync or umount regardless of
> sync or dirsync enabled,
> because there is no paired call to
> exfat_set_volume_dirty()/exfat_clear_volume_dirty() in
> __exfat_write_inode().
>
> If exfat_set_volume_dirty()/exfat_clear_volume_dirty() is called in pairs in
> __exfat_write_inode(),
> it will cause frequent writing of bootsector.
>
> So, how about removing exfat_clear_volume_dirty() from each operations,
> except in exfat_sync_fs()?
Okay. Please send the patch for this.

Thanks!
>
>
> Best Regards,
> Yuezhang Mo
>
