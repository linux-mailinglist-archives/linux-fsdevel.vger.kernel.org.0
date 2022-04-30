Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6F515A4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 06:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiD3EUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 00:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382198AbiD3ET5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:19:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554C6582
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:16:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh6so18808455ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtkJA0IFegtZ7PUFeqlHnZaDoXo7hqrrLbGxWv7Taok=;
        b=ik8w5zOCuQB7BquEgUXw1x5VZNmDXk4tQN3F0PcJO1SnwuCc5DnwMhSdRkBR0lIyMA
         1/MBQlIAiZFAl4BhulKLHPBmQM/5k7lPHkqdY1kjLZgw34Dt8fkB5aI1vF9eeH0ATOta
         SC3zy0gdqwN3T+R+/58cZvwZElmgm6B/6aWwFeFYq/8h+Ih2oToQkhx8Aa0r/XsI6bJ+
         0P+g93tKga8ZMq5Ypz6NMVnHSNwkamU5Mbxu1zhWmn9aUsPhjDj2O0RlV5R39b2Q/JlL
         2Rp1QwZG41nyhB9WFyifLtQ86qXrwVs07/zaoulr8I+NY/8M4r3qU9tfr8GLUgMZvPmm
         y64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtkJA0IFegtZ7PUFeqlHnZaDoXo7hqrrLbGxWv7Taok=;
        b=wjwHbMtTnqMv1fXWp5mwOJDHadzJ66gJBJPc29CnK8IqVErkUkUzNB8jF4PSG3MjKf
         +4I34qGA4VafXclEuCqs8UXk5mgf77iz6TU8EkdOdrigoe7eeTUVlywmNu33cguKp9RX
         CwdhDrOagkHvGnU3rDIbeINmaNuJaQUNGuUeVRZwbrnD713Ehl2NrWdUTT/mC+vI9Hdw
         HxKBwEN27D1iYYQN/KCNEm7BbK2N5GFyI77SFfd/FqeiREcBUE3bGX5F4YD43fB4wpKj
         4tW4BHLUYkbylbepUNuHfgp6NWZcPJG//mKHYbpYaFWV7Lauy0pfrHz2sFqpdxNW9+ID
         LIkA==
X-Gm-Message-State: AOAM531/nWDczy6K2iS3Wn1nGJX4+8sqXLdK+kpo9nYvENHPZkK0tmR9
        mmwtf1kvI+/RZwQaXfIPnuE1T4xt2/xEdgXSck4=
X-Google-Smtp-Source: ABdhPJw/7q8ZL+xQ5iS7FbpslR/tp9YFCF1oK/ybRRZtqr4C7vjxI+nKbc1MYAfTmHQS4PP32duxTnupvIR3wootDSs=
X-Received: by 2002:a17:907:1b1f:b0:6f0:21ec:6051 with SMTP id
 mp31-20020a1709071b1f00b006f021ec6051mr2183701ejc.533.1651292168759; Fri, 29
 Apr 2022 21:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220423032348.1475539-1-cccheng@synology.com>
 <20220423032348.1475539-3-cccheng@synology.com> <87bkwmxvwt.fsf@mail.parknet.co.jp>
In-Reply-To: <87bkwmxvwt.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Sat, 30 Apr 2022 12:15:57 +0800
Message-ID: <CAHuHWtmj+-+w8w2DTw9mTNxkHAL1irrQNr1fCa6cZx0eN01z0w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fat: report creation time in statx
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:45 AM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
> Probably, above should be the follow line?
>
>         fat_truncate_crtime(MSDOS_SB(sb), &ts, &MSDOS_I(inode)->i_crtime);
>
> And furthermore, this is missing to add it to mkdir(2)? And another one,
> we would have to update vfat_build_slots() for crtime? I'm not checking
> fully though, this seems to need isvfat test
>
>         fat_time_unix2fat(sbi, ts, &time, &date, &time_cs);
>         de->time = de->ctime = time;
>         de->date = de->cdate = de->adate = date;
>         de->ctime_cs = time_cs;

Ah, you're right. I missed vfat_mkdir() in the previous patch. After
further study, I found that maybe we can remove fat_truncate_crtime()
in both vfat_create() and vfat_mkdir(). crtime will come from only these
two cases:

(1) read from disk
(2) generated in vfat_build_slots()

They are all in {cdate:16, ctime:16, ctime_cs:8} format, which ensures
crtime will be kept at the correct granularity (10 ms). The remaining
timestamps may be copied from the vfs inode, so we need to truncate them
to fit FAT's format. But crtime doesn't need to do that.

Thanks.
