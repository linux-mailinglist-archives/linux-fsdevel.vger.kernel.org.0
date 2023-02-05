Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6472868B0FC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBEQiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 11:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBEQiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:38:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF413D50;
        Sun,  5 Feb 2023 08:38:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ba1so4372397wrb.5;
        Sun, 05 Feb 2023 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBS8lQUszEWIyGd6gPYkFsOUKg2VkgciQ57XWIO2J8E=;
        b=I8DRSWVUk/f1dBE0yr4oIeL9bgoDOSOwPaDEu7lepjK11nMbo6hA418QZX49F1wXFD
         vJsqD3JO81C2KxCHAH6hoY10fjW9t0q5ja9x6LI9HSfCPJSYJji2beTGBul1+HhcBMI4
         zSU+igY3lY5afMrZm7OzSJjzImga+bqgLBY2wPvoe32yz0fbVZDviGojgyyYCxYSkF2j
         OysD2B5eytZZ2Q0A2PO/6TNNYQlnA+qShZQKOyJayOcvv24yyQZ4ZN3/HIEg18G1oM+K
         MGjYBgi1lOErJQZfMHDGzA2c+hV+rYNybf828jw3Gn3Fw/U+XFC5WmoIFvuizMrON2fW
         kr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBS8lQUszEWIyGd6gPYkFsOUKg2VkgciQ57XWIO2J8E=;
        b=5BRZQwL/Pw6rc+QrwYfpbU0J4dj5PnZxK/lLyFF86XAUJjiCDygsP4ZTCNG9iZ5suw
         6IaIwhcQ8ig4wPyr70H+m9xP0vpqeLmIItFhyOWaPU/g0Q+Enysxdz80IBq56McvkPN2
         my6GNYgaHRjGG1wEOag501vXV7Gaa3R94O6o4Je87xU8Walqwv8mVXYlYyWtCoMpq1CU
         NJ0TFcer85JEIlBrSaBQfQCVp0QcFgLW/a8b3+NPntdibVLqU21YwBypnDATVoNy0HoY
         lBoYuGnjEf4uKFqucY9GXQuOBgDfh345it2YpYypVnCScWANFCzo/H8bYiUPVVqqS0/8
         aS8w==
X-Gm-Message-State: AO0yUKWjmg94V+ewWc1hSiNGDogdDCXeghtfwn1dYumo+SgZIQ/3V1UV
        s6aa2bzyBuF9uK8yIDdfeA4QYIEjlx/7Ivh8Osw=
X-Google-Smtp-Source: AK7set8Thtz9rQI4xrmg28H6KUW+kz/AJjlna344wYct7keepOQaeTmRV6+F1Eybr7fLhrTaR2ZGDEwFSPEJHiMNJp0=
X-Received: by 2002:a05:6000:18a:b0:2bf:b294:52f8 with SMTP id
 p10-20020a056000018a00b002bfb29452f8mr358051wrx.269.1675615084719; Sun, 05
 Feb 2023 08:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20230124023834.106339-1-ericvh@kernel.org> <2302787.WOG5zRkYfl@silver>
In-Reply-To: <2302787.WOG5zRkYfl@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sun, 5 Feb 2023 10:37:53 -0600
Message-ID: <CAFkjPT=nxuG5rSuJ1seFV9eWvWNkyzw2f45yWqyEQV3+M91MPg@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Performance fixes for 9p filesystem
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Thu, Feb 2, 2023 at 5:27 AM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> Looks like this needs more work.
>
> I only had a glimpse on your patches yet, but made some tests by doing
> compilations on guest on top of a 9p root fs [1], msize=500k. Under that
> scenario:
>
> * loose: this is suprisingly the only mode where I can see some performance
> increase, over "loose" on master it compiled ~5% faster, but I also got some
> misbehaviours on guest.
>

I was so focused on the bugs that I forgot to respond to the
performance concerns -- just to be clear, readahead and writeback
aren't meant to be more performant than loose, they are meant to have
stronger guarantees of consistency with the server file system.  Loose
is inclusive of readahead and writeback, and it keeps the caches
around for longer, and it does some dir caching as well -- so its
always going to win, but it does so with risk of being more
inconsistent with the server file system and should only be done when
the guest/client has exclusive access or the filesystem itself is
read-only.  I've a design for a "tight" cache, which will also not be
as performant as loose but will add consistent dir-caching on top of
readahead and writeback -- once we've properly vetted that it should
likely be the default cache option and any fscache should be built on
top of it.  I was also thinking of augmenting "tight" and "loose" with
a "temporal" cache that works more like NFS and bounds consistency to
a particular time quanta.  Loose was always a bit of a "hack" for some
particular use cases and has always been a bit problematic in my mind.

So, to make sure we are on the same page, was your performance
uplifts/penalties versus cache=none or versus legacy cache=loose?  The
10x perf improvement in the patch series was in streaming reads over
cache=none.  I'll add the cache=loose datapoints to my performance
notebook (on github) for the future as points of reference, but I'd
always expect cache=loose to be the upper bound (although I have seen
some things in the code to do with directory reads/etc. that could be
improved there and should benefit from some of the changes I have
planned once I get to the dir caching).

          -eric
