Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6834CCF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhC2JYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhC2JYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:24:42 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDF4C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 02:24:41 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f19so1236525vsl.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUqVYbOsgzJvFaHO534MA1Tdm9chX2nN9+FCc/y44XE=;
        b=Guw+BOMais6EakAu9RohwYoxmmtYPJnwLs/4rXBB+5UKeB5Yk2UrYiXEwnNnkllavH
         gR+Ayxy4vd3HWHJa9R982DXzyD662Iha+wtjn3IWiK37BiidxzCx7+ACDI+z1HXLucj4
         ajJUXlLUtrwguVPFucQuJIwHsRtyodYMdnz88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUqVYbOsgzJvFaHO534MA1Tdm9chX2nN9+FCc/y44XE=;
        b=gZCaHjhjP9RqGpLayj0mqdVDoQjZRqCmaKse8cVZOWKfo7VM33gKpYre+AgeteqYP1
         ZgMm39iNI9WwqddPcv6k9x7sb9siY48C7Xpunx0tQDVTFV/7oKD1XJGC0MoJmuT7rP6f
         2wH0u0mko1OjJ5AHbVqEZLESg7SynO/fmuZThcsvsgWEEqF6250gFx4XxJEVv1fi1oiE
         wy6eet4cHt9xzrObvGuzcIxDI1wVqmMS6aispIK957D3/nlfvmWy3mLZXZGuTpGC7Kou
         ciLwJwH51fyVh2zXwGNU05fD8nUVqJOIL1RGw2XOZO+0ys5ge8TKv0u/rhfQq4hOXpc7
         C2zg==
X-Gm-Message-State: AOAM530Dtc51b9rPqDTLFtVsYjqxWqYLBi6xSUhOr5bHxTa2OJqofy7V
        7phF/0IX22GQOKrROk8gFCrdfS2oWtLdGz+Y0VWqig==
X-Google-Smtp-Source: ABdhPJyZxxztIJkv/XIaxwQ8J2HG8Af2Yj5L8n64NOybPY5kHyelQ8Yf6zkuJ1gUrjuqCaWQkxiofplCj62NVVMbq+g=
X-Received: by 2002:a67:63c5:: with SMTP id x188mr1682420vsb.9.1617009880930;
 Mon, 29 Mar 2021 02:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210325193755.294925-1-mszeredi@redhat.com> <20210325193755.294925-4-mszeredi@redhat.com>
 <YGDGICWI6o+1zhPI@zeniv-ca.linux.org.uk>
In-Reply-To: <YGDGICWI6o+1zhPI@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 29 Mar 2021 11:24:30 +0200
Message-ID: <CAJfpegun3LHMZ9uVxbf5knZB6w1CnUHHXeYpn_ReCTdXKaFX0w@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] ovl: stack fileattr ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 28, 2021 at 8:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Mar 25, 2021 at 08:37:40PM +0100, Miklos Szeredi wrote:
> > Add stacking for the fileattr operations.
> >
> > Add hack for calling security_file_ioctl() for now.  Probably better to
> > have a pair of specific hooks for these operations.
>
> Umm...  Shouldn't you remove the old code from their ->ioctl() instance?

Will do, once fuse gets converted.

And fuse will get converted, when I manage to decide on the best way to do it:

1) keep a list of open files for each inode, pick random one for doing
the ioctl (really shouldn't matter which one)

2) do a sequence of open - [sg]et attr - release for each invocation

Thanks,
Miklos
