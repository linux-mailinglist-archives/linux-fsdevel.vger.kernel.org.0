Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CCF50E15A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiDYNTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiDYNTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:19:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006201901F
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:16:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so6726267ejw.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc/dEr5pwPMLhoa+YKleCXQFYWS2sX/902+8X3X7DqI=;
        b=VBGcSS5BAXuONpYWkt67xGVOtQbYl6w2EnQBsZkFutRb2kqi4IzrZc9kaHQs5Dk+Z9
         nqI4eHhDRTf8d0EX7rHCmEvIGuJNLCI55gbZaTcpId1oqofcqB6Np6l3vsd1lWkjj8wc
         5AexgDjRnfkWZ0XoEuIeJEvOHkGLw8WeqKocU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc/dEr5pwPMLhoa+YKleCXQFYWS2sX/902+8X3X7DqI=;
        b=qWbZFTs3nquXCYWvURHRIPbpCxCI+/CN8zlCf2N5oYSDwpwkpyv7add7oI9b/Sz98Z
         VH+Ejps3JeWc/nuA9IjA3GYfLc19qCkDR7CPNXMTt/YMorQWQR53TPCImmSyA00Fl5+w
         nomreAU/pl6w4YVVHyLH3aDhlj/zuRwFnz1qyzZbNfYMNkOt93mcgUn9ZEP8DCvE5+dn
         WPW9N2wykRU5pvaCPsCqXFdzWNBQdeFxl0p1aKSPOWEBdUJ1kRPTeUVcEQ7Bd2ZfsrDF
         r/vBZplhI9CmE76ZDay+dzIRCvCUB1UV5CGS9XMQSjBo0L/TXcVRj6wLRK9zJFJy6oJv
         yM+Q==
X-Gm-Message-State: AOAM530zfkqLl8RS8td0fXfHK8UprQvIYwzMSD53Mj2VBrHsN38gG98D
        hkL/Fa0vMU8itfz9pivOi/xVjo/9HCdHfL+bQy3ucw==
X-Google-Smtp-Source: ABdhPJwNzf9snapdCoGQnnUDVd4WNGEHAAkVfUD+kFSan3W2X/sl+nAPQNQ8wSzU1xYyrNWL3lBjB1yB+FwDgxrkJ3Q=
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr4626275ejc.524.1650892564570; Mon, 25
 Apr 2022 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegsbORd5hDhnth5qY1aP-6AZDMe9f9+CyWVhvpEmHPnuwQ@mail.gmail.com>
 <20220310111026.684924-1-wu-yan@tcl.com>
In-Reply-To: <20220310111026.684924-1-wu-yan@tcl.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 15:15:53 +0200
Message-ID: <CAJfpegvR1khmFbQ99EHguBTQqG8cPgnQHSyoxEi6brf=+-U7QQ@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH] fuse: avoid deadlock when write fuse inode
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
        guoweichao@oppo.com, Huang Jianan <huangjianan@oppo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, zhangshiming@oppo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Mar 2022 at 12:11, Rokudo Yan <wu-yan@tcl.com> wrote:
>
> Hi, Miklos
>
> The similar issue occurs in our Android device(4G RAM + 3G zram + 8 arm cores + kernel-4.14) too.
> Under the monkey test, kswapd and fuse daemon thread deadlocked when free pages is extreme low
> (less than 1/2 of the min watermark), the backtrace of the 2 threads is as follows. kswapd
> try to evict inode to free some memory(blocked at inode_wait_for_writeback), and fuse daemon thread
> handle the fuse inode write request, which is throttled when do direct reclaim in page allocation
> slow path(blocked at throttle_direct_reclaim). As the __GFP_FS is set, the thread is throttled until
> kswapd free enough pages until watermark ok(check allow_direct_reclaim), which cause the deadlock.
> Although the kernel version is 4.14, the same issue exists in the upstream kernel too.
>
> kswapd0         D 26485194.538158 157 1287917 23577482 0x1a20840 0x0 157 438599862461462
> <ffffff8beec866b4> __switch_to+0x134/0x150
> <ffffff8befb838cc> __schedule+0xd5c/0x1100
> <ffffff8befb83ce0> schedule+0x70/0x90
> <ffffff8befb849b4> bit_wait+0x14/0x54
> <ffffff8befb84350> __wait_on_bit+0x74/0xe0
> <ffffff8beeeae0b4> inode_wait_for_writeback+0xa0/0xe4

This is the one I don't understand.  Fuse inodes must never be dirty
on eviction for the reason stated in my previous reply:

> > I don't see how it can happen on upstream kernels, since there's a
> >"write_inode_now(inode, 1)" call in fuse_release() and nothing can
> > dirty the inode after the file has been released.

If you could trace the source of this dirtyness I think that would
explain this deadlock.

Thanks,
Miklos
