Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0283C3E2B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGKRF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKRF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:05:27 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEDC0613DD
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jul 2021 10:02:40 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y6so15651069ilj.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jul 2021 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ycphfoQKCsCAdoOFrkRu7loWS/EG+Tels9jdvoZAcm0=;
        b=iwQpnAFMmZthF6SUcUCtCm1vs3ZtyJLuhIaSWpLKqwnWz5IzhdzGBgcv57xzU9VZAR
         8n4GlMKnD9qem41+ZhC0mSVDmlrifgk03trCzHCI/B5M4KALIn310fEMJKEClqhvYb7D
         fum7YGVwc2X5EAvRLBuyKC1pV5OwZ+wW0UOpgu03ljt58pyGkEKZykiWC5QpHdGAlGQw
         e93xwwv175jDjWUlfdZdXIUXTKqaMDItSJm/xhnAwP5JEiQ4Do+YQ0/7fthS7s3FHaFt
         2vkY1D8yAT575BjTH9o3tXn4Gn5q+e7gs43JubBcpA2abuQjCcr0rCbFcs5bBnzcT2fM
         wHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ycphfoQKCsCAdoOFrkRu7loWS/EG+Tels9jdvoZAcm0=;
        b=PdrF366F0aJL6j8nu6Hrvjfxwsu+IGzrAU/pUxeDIvyQukjdZQuJ/VKWdxA1C2Tj/L
         6RokxDT/R1Lx9e7Pzr1o8U5ZeH+SBHXLwMCKk0PAIhCnBEvMYBzDDM4s/JvYKHaEhYdZ
         GqWuRddezslHGgYL8Yzs3K5iyuEFeWaFM5RZlwY1v4I4qEr7+fSvvivYDvgbU1aICbU4
         VmiPvjEESGfSFKfG5szSRiWIQxi/qs8eF0OWC2RhjHL/Zd8E+vqXG3lv1B0ZYUXHm/eQ
         wn9Yd1pJmjvcUyXHxzwaqHLna+RvpapwY8p4RWE8mQl7G5fXhdcFD5v3IOEBn8BMQUT4
         4gJw==
X-Gm-Message-State: AOAM531urc6jFk4iK2wsNxgo64mH141k+Z+fWxSAyDYcsI0J8jaxZuy/
        75wrxD/X9h7uou1n3lXszlxseLcL6BnAnCirjC9TQn9KtT0=
X-Google-Smtp-Source: ABdhPJybapWHP9OyLAl6IhJ90C84BU/WXdEWlMf49CUnJQsmbpbhzqa8WWMs9bcI5TpBXVQge5JNzUFDjCht8+QKQes=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr1385721ilh.137.1626022960202;
 Sun, 11 Jul 2021 10:02:40 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Jul 2021 20:02:29 +0300
Message-ID: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
Subject: FAN_REPORT_CHILD_FID
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

I am struggling with an attempt to extend the fanotify API and
I wanted to ask your opinion before I go too far in the wrong direction.

I am working with an application that used to use inotify rename
cookies to match MOVED_FROM/MOVED_TO events.
The application was converted to use fanotify name events, but
the rename cookie functionality was missing, so I am carrying
a small patch for FAN_REPORT_COOKIE.

I do not want to propose this patch for upstream, because I do
not like this API.

What I thought was that instead of a "cookie" I would like to
use the child fid as a way to pair up move events.
This requires that the move events will never be merged and
therefore not re-ordered (as is the case with inotify move events).

My thinking was to generalize this concept and introduce
FAN_REPORT_CHILD_FID flag. With that flag, dirent events
will report additional FID records, like events on a non-dir child
(but also for dirent events on subdirs).

Either FAN_REPORT_CHILD_FID would also prevent dirent events
from being merged or we could use another flag for that purpose,
but I wasn't able to come up with an idea for a name for this flag :-/

I sketched this patch [1] to implement the flag and to document
the desired semantics. It's only build tested and I did not even
implement the merge rules listed in the commit message.

[1] https://github.com/amir73il/linux/commits/fanotify_child_fid

There are other benefits from FAN_REPORT_CHILD_FID which are
not related to matching move event pairs, such as the case described
in this discussion [2], where I believe you suggested something along
the lines of FAN_REPORT_CHILD_FID.

[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/

Thoughts?

Amir.
