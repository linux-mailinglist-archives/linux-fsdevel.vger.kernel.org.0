Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62F52C6D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 00:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiERW46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 18:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiERWz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD28230239
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 15:55:25 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fedd26615cso39997247b3.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/rm2MRI5aLb2MmNxgz+kjwRgqyFx3fvvNWWrAiR8q8=;
        b=kUiYDk2lMsrPYOhv2kA28Sl9FTbu4rOMn2S5SqcHbaxziz3PuZ0PNlYnXDyE4VWOJc
         NnF4XespAeSACBuJNjZ0nzAjwjyOu6Z4mUMRaFH73XPDoO1m93wgGPDaAM3E+G/hMFTr
         FwILD0T3dWkQ5ecSBPJrkz7WG3QJuvp0IWxxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/rm2MRI5aLb2MmNxgz+kjwRgqyFx3fvvNWWrAiR8q8=;
        b=WKAoI5oJaeDCUH0yEQIi+YS1oyrScjMbKCjb8aknARi6QPo1h1gjJBUY341jKWUYLr
         6ZkITL45N814ILUyH4CAlDZzG8nAjVtTONu4wFLNTXE4PXCfipeUhbsyeegGXwdEMZX3
         jcOJJ55HEezhbjgQUXbLPzM5vN/eW8/PFnaLU/7A9SJP0CWIgargs8xA6PqgRGayPL0E
         VrLhxvLqr2Wt64+aj1b/4tSec7AGo8nRr1FLEuTzNriOL2UXRiIHIf6NPphUU80DesIx
         CzZ4gzb58Ln4g1zNl5ogFs5LWVhTPGYdSbR090rLYvE0wsshwrVVyyqM1sqtA+/wt49R
         RAAw==
X-Gm-Message-State: AOAM532HO5vgqou7T3abDyE/vZBcEF+y9/w625w1Dox19PCgNX8h5o+z
        5tgvoZOe8rqSOjUgWWeqch/6GHgmY/2/AFS+p5W1KCfuipA=
X-Google-Smtp-Source: ABdhPJxQ8almf8LqT1X5OeWRJQH+8DaWIpAWbuYo4jXba9Mn0DewpDlZNJqHEwPWKRkkiRgzZhrCVYmKYpzwTQwRQ78=
X-Received: by 2002:a81:5645:0:b0:2f4:df9b:80f2 with SMTP id
 k66-20020a815645000000b002f4df9b80f2mr1755666ywb.296.1652914524973; Wed, 18
 May 2022 15:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
 <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com>
In-Reply-To: <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 19 May 2022 08:55:14 +1000
Message-ID: <CAONX=-do9yvxW2gTak0WGbFVPiLbkM2xH5LReMZkvC-upOUVxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Yep, messing with the bdi doesn't look good.  Fuse always uses a
> private bdi, so it's not even necessary.

The reason I needed to remove the bdi is name collision - fuse
generates a fixed name for its bdi based on the underlying block
device. However, those collisions of mine were conducted on a
version prior to the private bdi introduction, I am not sure if that
is supposed to fix the collision issue. Need to check

Thanks,
Daniil
