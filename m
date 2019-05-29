Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5042F2D69F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfE2HnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 03:43:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54997 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfE2HnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 03:43:01 -0400
Received: by mail-it1-f193.google.com with SMTP id h20so2110607itk.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 00:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqFyk47sSJVRHLsfxDt9uxstj8u1M1gZeotStw/KYzw=;
        b=id5wu9BvoNG48+Ck6s8h94PZq86QUHxdJHUYxEOU8jSAxFsa+1A4HOIk2KNNGCHNYc
         OwBytSNRzvO8aYb8lITay3X7zkUGradhD9vfX1R53KWAnrSkr37AzcJ0yZUZVC+Trdhy
         bprSeX3NyZpk8vHx5k5/l7d+PI9MlT+Ld0xEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqFyk47sSJVRHLsfxDt9uxstj8u1M1gZeotStw/KYzw=;
        b=Npj+JNHShm48RxRGZ60I4AANjjUaLYOo3Vhg0kM0AgmgbU8kLKNOHwcSm0404pab4W
         9RxyiOZvUZ18NlHy7WyznUe8JsxozYT6+ImXVitZq2SqqtlF9JoGqzGtls6Mty1wOQHz
         5MSpxUlL2TPW7pEeeshEz93uBWbzHELfQO1qvzgX1UVxg8KSjwYSJigOG/I+YcmvFPdn
         0PLcYw3IM7ao1Uu12BYphbO0G++ay4PXdQPUsCTwwzUAqE2lTxvao3YST4P+c+OK1ONn
         XS87kEhmIx3oYv5+BNkbBmbJF5/yA4GvDr+33aCj7WGlsyBsJslKtg0qvM84kOQ2yKCl
         qykw==
X-Gm-Message-State: APjAAAXxuuYfgfs97qWkIQPV/jKhp4n9H/Y621VRBPK8XYRp+k1gN5fK
        4O55tVmKkfVxUrM7qrzO1Pt/12hD6KUylN4cWyapSA==
X-Google-Smtp-Source: APXvYqwAlJ+88fBjLtyGuaqudPy4+GEXvEcXAfTVL7Bhrhnm6RhxFQ9ymvOB6HhajvGltquJ5SQcGvLqHvz3kY11lns=
X-Received: by 2002:a24:2846:: with SMTP id h67mr6510467ith.94.1559115780417;
 Wed, 29 May 2019 00:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905627049.1662.17033721577309385838.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905627049.1662.17033721577309385838.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 09:42:49 +0200
Message-ID: <CAJfpegtkpNNOOWQ3TnLPGSm=bwL2otQp1--GjNNFiXO7imMxEQ@mail.gmail.com>
Subject: Re: [PATCH 01/25] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 5:11 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
>

[...]

> +static u32 calc_sb_flags(u32 s_flags)
> +{
> +       u32 flags = 0;
> +
> +       if (s_flags & SB_RDONLY)        flags |= MS_RDONLY;
> +       if (s_flags & SB_SYNCHRONOUS)   flags |= MS_SYNCHRONOUS;
> +       if (s_flags & SB_MANDLOCK)      flags |= MS_MANDLOCK;
> +       if (s_flags & SB_DIRSYNC)       flags |= MS_DIRSYNC;
> +       if (s_flags & SB_SILENT)        flags |= MS_SILENT;
> +       if (s_flags & SB_POSIXACL)      flags |= MS_POSIXACL;
> +       if (s_flags & SB_LAZYTIME)      flags |= MS_LAZYTIME;
> +       if (s_flags & SB_I_VERSION)     flags |= MS_I_VERSION;

Please don't resurrect MS_ flags.  They are from the old API and
shouldn't be used in the new one.  Some of them (e.g. MS_POSIXACL,
MS_I_VERSION) are actually internal flags despite being exported on
the old API.  And there's SB_SILENT which is simply not a superblock
flag and we might be better getting rid of it entirely.

The proper way to query mount options should be analogous to the way
they are set on the new API: list of {key, type, value, aux} tuples.

Thanks,
Miklos
