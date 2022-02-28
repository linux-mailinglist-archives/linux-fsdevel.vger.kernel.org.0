Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDB4C7045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiB1PHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiB1PHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:07:30 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8D76E0F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 07:06:50 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id j12so5332962vkr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiqKta+C/bUAijQgVs2pIwZxEquJxCrRrkx40wt5xeU=;
        b=jrZ7QG8cvbuAWbySWWqcPRl1HzBxXrPIQi88Qwxn9KEns4B4V6BG/WCFVt2TODG2Ek
         mVVcRUWT7BUAL5BAyusW6Vh4apN5Ewv3KR/Aq+pMkgfcel1DXFU8JWDqrvlCEpRo5wt5
         tALdoK1ujT5pztZcBl+qe2p7Xd+6FhJuFYLw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiqKta+C/bUAijQgVs2pIwZxEquJxCrRrkx40wt5xeU=;
        b=Ls7M+xsqHhE/z5QBfmBVfjRO9/oTyqlV5Hs+pwinudXFj3hfLWQK0KoBlRQQlfTOmH
         zR7XoWxAij5gaFgSpwAlz3nhh6X9id27gXBzcdyog7EQrrs2NBYoTGsVVZfz8xUYNRIf
         5yGf7AL2Mr2E94qNBkzxWnBlzF9Pye5KSjI/E8QNKKwOjmn6+xX6t1J/P5fYzkALro3H
         6iJ60+GgIk2AmipV+rTwcnleBJzX30HhsG1SaXy2gaR4bKjIS+EwcdtMqTQK0wW75GC/
         hqAN1rsE0FxFYQoTUC+3cCGIwtOwceOLAstSQkSjMIwiU7HxI5RHLNu88aziYFGRy48P
         WH0g==
X-Gm-Message-State: AOAM5325qHAHf/p9UQh+NLjf9/06UDob6J5jWBFmlbYQlOOxze4+miVZ
        ICU8Nvsg/XMZTxKd+TOhnWZKPl09WcLDUkkyHQYt7V8Cj7c=
X-Google-Smtp-Source: ABdhPJwG4oeunZtfTAqFSdPSvXQ/EGO74OOSjPwKybQKY955Q+Lm+yXaJNDZXx6QkmGxjo5MfMxF2Uv2x7n3YyUuw60=
X-Received: by 2002:a05:6122:2213:b0:31b:76c3:16df with SMTP id
 bb19-20020a056122221300b0031b76c316dfmr7894044vkb.31.1646060809331; Mon, 28
 Feb 2022 07:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20220228113910.1727819-1-amir73il@gmail.com> <20220228113910.1727819-5-amir73il@gmail.com>
In-Reply-To: <20220228113910.1727819-5-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Feb 2022 16:06:38 +0100
Message-ID: <CAJfpegvZefGp9NChm_69Km0FgpxwUs+og-uc2mpMAbH6mZ2azQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fs: report per-mount io stats
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        containers@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022 at 12:39, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Show optional collected per-mount io stats in /proc/<pid>/mountstats
> for filesystems that do not implement their own show_stats() method
> and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.

This would allow some filesystems to report per-mount I/O stats, while
leaving CIFS and NFS reporting a different set of per-sb stats.  This
doesn't sound very clean.

There was an effort to create saner and more efficient interfaces for
per-mount info.  IMO this should be part of that effort instead of
overloading the old interface.

Thanks,
Miklos
