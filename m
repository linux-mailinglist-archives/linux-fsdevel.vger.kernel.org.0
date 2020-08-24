Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB124FE06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHXMsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXMsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:48:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87EDC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 05:48:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so11699516eje.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2IPXzmn+OKMcrQgf/hKHvn8I9Z5eUqBH1sKWLhEHkw=;
        b=BfRVfTBXcVbti1Hpi5XfJ9bPtCpd/H+Yoa8sWOaAvxUonJ76O0Lea7kGjVAGJmOCJ5
         Jtzcdpw5goa/kbBky0td2syRYGONm0uqruHTKboQap+xTpY+GFD2x+Dni+qkmvc+Wwsm
         4pkeX4wFxnnIeItQwxZPhFji88v7JFVl0CoGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2IPXzmn+OKMcrQgf/hKHvn8I9Z5eUqBH1sKWLhEHkw=;
        b=c3PzR3eiqvRScJ1KRHz6Kx6BVcyvyASDGrIOo0UayBzb+75TKVu61VfGGrCm5biiW4
         FVbeLX6HtcXH4+sBnS4IKBtnsML68jbEPwdNuZ9skCQnNjGe4fBn1VzBhb4N4aOxi+LJ
         VO4TrYukC94Zs11VokHyHGd4NdEuTsEdTJ77zmuomM1+KzJ5HsdpNhk+Zl/HW5eR5p+h
         g69YkNC/fnmX/PK+UdJ7ysd+hKbt4dNwCcvKlKfL37aOYQWH42ce3BRoYQ6IDqChdKFh
         osdUv9AkoA363y8m0i1rjVBJsPYLz8CO7PCfrndSRio4qFZMDsn1jjwLU5ZTaSUKTdcz
         Ss5Q==
X-Gm-Message-State: AOAM5303tfVeNSySTfnvB7nLDdJbHRR29YiRIM2uDoaIkbp/i2CJX0fF
        NlecBge2o3dGisH8AtmTPAUKpUK8RFA5V7cqpIxzYg==
X-Google-Smtp-Source: ABdhPJyFg7kN9mhul11wEbcYUGJAB7HYhA8U9EnjCXIxa2cNqHKznAI3idzFu6PpASOAq35nSzcCZMhWbHxQmvz1enI=
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr5328702ejc.110.1598273292348;
 Mon, 24 Aug 2020 05:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200812161452.3086303-1-balsini@android.com> <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com> <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
 <20200818135313.GA3074431@google.com> <877dtvb2db.fsf@vostro.rath.org> <CAOQ4uxhRzkpg2_JA2MCXe6Hjc1XaA=s3L_4Q298dW3OxxE2nFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhRzkpg2_JA2MCXe6Hjc1XaA=s3L_4Q298dW3OxxE2nFg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Aug 2020 14:48:01 +0200
Message-ID: <CAJfpegs2LHv4xfb5KPzSRPSAVg3eZEvZKk46SjgwGcgq==qNzw@mail.gmail.com>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:25 AM Amir Goldstein <amir73il@gmail.com> wrote:

> > What I have in mind is things like not coupling the setup of the
> > passthrough fds to open(), but having a separate notification message for
> > this (like what we use for invalidation of cache), and adding not just
> > an "fd" field but also "offset" and "length" fields (which would
> > currently be required to be both zero to get the "full file" semantics).
> >
>
> You mean like this?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=fuse2

Look specifically at fuse_file_map_iter():

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/tree/fs/fuse2/file.c?h=fuse2#n582

and fudev_map_ioctl():

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/tree/fs/fuse2/fudev.c?h=fuse2#n601

This avoids the security issue Jann mentioned as well as allowing
arbitrary mapping of file ranges.  E.g. it could also  be used by a
block based filesystem to map I/O directly into the block device.

What the implementation lacks is any kind of caching.  Since your
usecase involves just one map extent per file, special casing that
would be trivial.  We can revisit general caching later.

Thanks,
Miklos
