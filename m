Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104A577ED8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiGRJmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiGRJl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:41:56 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEE19C1C;
        Mon, 18 Jul 2022 02:41:56 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 125so9862712vsx.7;
        Mon, 18 Jul 2022 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uw96p5rg9bMjde+tQ6Y+RJreM2+o6oDSBazbHt0Gpe4=;
        b=ZMcgYemoS6vhtGV+wZTepAv0v7yYdmq3PKJVRg8DujBUwUrtzrBTIQtVGghklIuZsp
         pMH+ZEbCBITkHbGhkhnJVzLS/JRkvLlB3L1msVvqVDzqH0IaOlwS7HrlrywJufHp7a/1
         Y46jotEQTTbMuP32ne5lLIti/hegrnYiBGCwT9XX/WeYE/yteviq9WPcw27r1wC+V43l
         k0cNHGA09ys6nFRf+Q+HEeguCh75hz+/+d0OO1JmuJI4xeKUV4wP92OHwULfEI+pWMhI
         Z4OSmv1RwcrOKfyQYWrW1I0zb/bFVGMMxpd7U5luCglHL8fYp3ncTlDbS6pHHk/YYaZL
         R/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uw96p5rg9bMjde+tQ6Y+RJreM2+o6oDSBazbHt0Gpe4=;
        b=RwJSp5cZsXPC/5yy8LmbKTRNz/6JtGRbZaZ3e2m06SB7Iia0UtTo1tKI/64IAzMh5R
         8Av1hD0kQ4o6freVqSPjbfquzZtZmkNsEfFGToFqaj2M8REJIUeq73jg/ylakb21xJDy
         GYervOLjU7U+KEJME7Qmir+os8T8iHAnzc5gMur1RJcL7dQVVPRyB/fTjbV0VIJHvmek
         Hz9Ff7wpFjvjQLqFMlVqcKq9lysLyDHKFDsw+qz6tj5cXwrUZGWf1TsvdGQfOO8pmNQS
         N26utQ1WR/laTo5yu5zaXyp/DAvYwMrRpXM1H0KMroO3Uo2fDWivLvFluzKGIhuigiqA
         jewQ==
X-Gm-Message-State: AJIora/vBhm8fIEeMagtZj1HCbs/lAS3VLaVuKU4jMS8VBA8ZTiovfBj
        wen71xosbbhrypooGSW8zo9JzIO956DoDdhs0YcWJpAs7oJK7w==
X-Google-Smtp-Source: AGRyM1uwPymo7DRuHzRKWZ13dPYMPZ/am7w4EtUZor/81WS5GgLWhgdwQXs2hG/1EIRU7O70pBwq+X5JnU9nktk2d/M=
X-Received: by 2002:a05:6102:834:b0:357:e3b9:56d5 with SMTP id
 k20-20020a056102083400b00357e3b956d5mr190138vsb.72.1658137315176; Mon, 18 Jul
 2022 02:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <YtTM8GYn0/HkSoet@squish.home.loc>
In-Reply-To: <YtTM8GYn0/HkSoet@squish.home.loc>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Jul 2022 11:41:43 +0200
Message-ID: <CAOQ4uxgya2-H9=qNZkRBO1exr=GRqyn=PFfGgAf0Px0VkH4bjQ@mail.gmail.com>
Subject: Re: [REGRESSION] recent changes to copy_file_range behavior breakage
To:     Paul Thompson <paul.a.thompson@zohomail.com>
Cc:     regressions@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        mat h <isolation.principle@gmail.com>,
        arvidn <arvid@libtorrent.org>,
        Luis Henriques <lhenriques@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
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

On Mon, Jul 18, 2022 at 5:01 AM Paul Thompson
<paul.a.thompson@zohomail.com> wrote:
>
>         Something that worked in 5.18.9 no longer does in 5.18.1[01] and 5.19-rc6.
>
>         Using the example code in the man page for copy_file_range:
>
> # ./copy-file-range testfile-on-ext4 /path-to-another-ext4/testfile (or symlink thereto)
>
> Works in 5.18.9, fails with:
>
> # copy_file_range: Invalid cross-device link
>
> And produces garbage file at destination on newer (5.18.10+) kernels.
>
>         This breaks eg. qbittorrent (moving a distro image across ext4
> filesystems, or following such a symlink) So potentially other real world
> applications. I do not know if the reason for the commit overrides this
> breakage, but it caused me a bit of a headache.
>

Hi Paul,

I apologize for the headache this change has caused you.
FWIW, Arvidn has already fixed the problem in libtorrent 2.0.7 release yesterday
following a report by Mat [1].

The story here is that cross-fs copy_file_range() was not allowed pre
kernel v5.3.
When we started allowing it in v5.3, we did not and we could not test
all possible
combinations of src and dst fs, so it took a few years, but regression reports
started to surface [2].

We decided to try and revert the behavior to pre kernel v5.3 to fix those
regressions.

The first attempt was around v5.12 release, but sadly, the patch got ignored
and it wasn't before v5.19-rc5 that we managed to get the patch merged.

In the meanwhile, libtorrent 2.0.0 was released with code that assumes
that cross-fs copy_file_range() failure is a fatal error. This was
fixed is 2.0.7
released yesterday and I hope this fix will be packaged soon for distros.

There is no easy way to find if other userspace tools have made the same
assumptions except for getting regression reports like yours.
It is encouraging to me that I got two regression reports from you and Mat
shortly after the kernel patch was merged, which suggests that if there are
other userspace tools out there making the same assumption, we will hear
about them in the near future.

If we find out that is it too late to revert to pre v5.3 behavior,
then there are
a few other options that were discussed on [2], but none of them are pretty
and there was no consensus on either solution, so I'd rather wait a bit to
see if other workloads rely on cross-fs copy_file_range() from any src fs to
any dst fs, before taking further action.

Thanks,
Amir.

[1] https://github.com/qbittorrent/qBittorrent/issues/17352
[2] https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
