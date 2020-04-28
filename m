Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30431BB8B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgD1IVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726621AbgD1IVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:21:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97606C03C1AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 01:21:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so16561817ejx.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Beulz3eYiXK9znAwwrzxGHeGgQMNh0d9KO0tZVeerX0=;
        b=YyCEijthLzJZij4FLuBKEi61PR7+UjBRJUNcyg0wveaxpD8Oy97R7wgwiswXEE8ia1
         fN5LofI4unGwslLYIZkU7Ttq6FjzFORAQYor/X6kg8vojtUt4w36+Zo26NKcImelM/9S
         btjww7Ng3YfaJfvOjrXl7g7eAmJThl2tM7MIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Beulz3eYiXK9znAwwrzxGHeGgQMNh0d9KO0tZVeerX0=;
        b=a3NU8t9dKRsRyvI9pZHLUVdizvwm0pWKhu3YIxDKHVzI+e/h4haMRN8MbqDLEIaev0
         QweTn/dAEgyZjiqgX1Qzoe9IgI8Yk+9CygvUkR9Jptzp5FSvsmUT8EQVTsrewoiUP7mM
         30ztGmN+NhbVMSSCp+3NM9qzCHsLBGhN5iarw5P0WlURBjgsHRB9K0/IghrY8sYMaOPk
         4cgVi5XD9XpfjRRSEnMdmXQMElwzS0bTLDUZLvIyjuDZBpIOVBc8h5hR2F2LopD9lm+s
         ZkENOhRMhmxQIS/FVqx4dClpN0aCQYKZgpWRVPuK9zSyo9j+qshFJP5JTXM1DTVDIGJB
         BzCQ==
X-Gm-Message-State: AGi0PuYjM6jMR52T3a6Eq+P2VNxA8N7d8v5oNEX45jviRmS5fT9hCXWE
        koXj2MBe2XKl4ob3ea70RJTAi+93QhjQR+p2YEXmoA==
X-Google-Smtp-Source: APiQypKS4m63MMNLMCzgc5Bn4XQvr4p1Bar3QttoueFGAN8X/bLOQmYRG4AMwQn5fZ30hczEAu6wGEgHC93FQnOiMlw=
X-Received: by 2002:a17:906:8549:: with SMTP id h9mr22753079ejy.145.1588062072243;
 Tue, 28 Apr 2020 01:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
 <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
 <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com> <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com>
In-Reply-To: <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 28 Apr 2020 10:21:01 +0200
Message-ID: <CAJfpegvWBHootLiE_zsw35G6Ee387V=Da_wCzaV9NhZQVDKYGg@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 3:46 PM Chakra Divi <chakragithub@gmail.com> wrote:
>
> On Tue, Apr 21, 2020 at 4:21 PM Chakra Divi <chakragithub@gmail.com> wrote:
> >
> > On Mon, Apr 20, 2020 at 4:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
> > > >
> > > > In current code, for exec we are checking mode bits
> > > > for x bit set even though the fuse_perm_getattr returns
> > > > success. Changes in this patch avoids mode bit explicit
> > > > check, leaves the exec checking to fuse file system
> > > > in uspace.
> > >
> > > Why is this needed?
> >
> > Thanks for responding Miklos. We have an use case with our remote file
> > system mounted on fuse , where permissions checks will happen remotely
> > without the need of mode bits. In case of read, write it worked
> > without issues. But for executable files, we found that fuse kernel is
> > explicitly checking 'x' mode bit set on the file. We want this
> > checking also to be pushed to remote instead of kernel doing it - so
> > modified the kernel code to send getattr op to usespace in exec case
> > too.
>
> Any help on this Miklos....

I still don't understand what you are requesting.  What your patch
does is unconditionally allow execution, even without any 'x' bits in
the mode.  What does that achieve?

Thanks,
Miklos
