Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9805216EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbiEJNWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbiEJNVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 09:21:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5AD2C334E
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 06:15:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ba17so19974770edb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEMXxfbHgL5k8G+nQx9Id44d10sZKLXr0DUGje9AXRs=;
        b=ANNKvFreFEu9sBWYzQhnMMLOHwEQYbyIk1iuCaMTgX4k9jEZW/e7PzAnlL8A7orHrh
         RGh9btUIUpjvRB4tNDpYgwJlTjOL5w6g2oROzijDZBuwqgiqXjt3dJQfSWysmAukJE3W
         6fviCca3i7WKiW/KEEtORZFD0aDK8BvFwa/DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEMXxfbHgL5k8G+nQx9Id44d10sZKLXr0DUGje9AXRs=;
        b=jeQk+jLUBUXt6T3fTQyaBlqsXsIkpf6RGzoN0Q2sSK3Y0z3bboc7Yfa4CFWZSKtYOb
         EVZBV/VlTvwlQxNL3cV6TCG7GSzXKZhChXO5kOGrdBRv23ELwG8+85c5gSmjgXHmLHNs
         2Pf3q1TWqnHJ798e6Rtk/XcXlyLv8syG7LuDdTcyCn2z0fN6L6LokfqWja9eGba/wsxr
         LNQUOt39BXz/xkvve9HkBtaid23kL5msaWF6/yh5JHDrnbF6b205DBDAVPMzAyxzCQuI
         4Su+O8WELyhCuR46ZxrXM9v0PM32BlixHD0FmCsI2BqU8RaX2ezVYyRwPbaK0hNa6+FR
         ffSQ==
X-Gm-Message-State: AOAM531IAmMQItVjJVdXwPRebhUto33aUZoJxqSpWqkC0Dar5pyHnGg3
        BnjHsyWl0ZtwJeCc00Auf4fHrbE/97hv23NRX5XFdw==
X-Google-Smtp-Source: ABdhPJy1yn2joxH0jRtB4tUrT8rXWVf3r823UovFXFhuulv4RgusZBMQed96S+gfdxujGTV1zzS0kjw+DY7epPFTe4Y=
X-Received: by 2002:a05:6402:50d1:b0:428:1473:d173 with SMTP id
 h17-20020a05640250d100b004281473d173mr22738467edb.37.1652188517024; Tue, 10
 May 2022 06:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com> <20220510115316.acr6gl5ayqszada6@wittgenstein>
In-Reply-To: <20220510115316.acr6gl5ayqszada6@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 15:15:05 +0200
Message-ID: <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 May 2022 at 13:53, Christian Brauner <brauner@kernel.org> wrote:

> > What exactly are the attributes that systemd requires?
>
> We keep a repo with ideas for (kernel) extensions - we should probably
> publish that somewhere - but the list we used for a prototype roughly
> contains:
>
> * mount flags MOUNT_ATTR_RDONLY etc.
> * time flags MOUNT_ATTR_RELATIME etc. (could probably be combined with
>   mount flags. We missed the opportunity to make them proper enums
>   separate from other mount flags imho.)
> * propagation "flags" (MS_SHARED)
> * peer group
> * mnt_id of the mount
> * mnt_id of the mount's parent
> * owning userns

Sounds good thus far.   And hey, we don't even need a new syscall:
statx(2) could handle these fine.

> There's a bit more advanced stuff systemd would really want but which I
> think is misplaced in a mountinfo system call including:
> * list of primary and auxiliary block device major/minor

It's when you need to return variable size arrays or list of strings
that the statx kind of interface falls down.

For that a hierarchical namespace is a much better choice, as it can
represent arbitrary levels of arrays, while doing that with a
specialized syscall is going to be cumbersome.

> I just have a really hard time understanding how this belongs into the
> (f)getxattr() system call family and why it would be a big deal to just
> make this a separate system call.

Fragmenting syntactically equivalent interfaces is bad, unifying them
is good.  Dave's example of adding a new syscall for retrieving
multiple xattrs  is a prime example.

Thanks,
Miklos
