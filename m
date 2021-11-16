Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E297D45324B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhKPMj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 07:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhKPMjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:39:10 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A446C061204
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 04:36:07 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id y5so24076989ual.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNmSVnxPetdA0L3V4GkasCFzJmUbdsvVFKb52Nomjig=;
        b=g4US1ExxJigUReu0nCm6t7eenv87wdEvhvIC9IPkm5AUhqVQCYDiktBcoWD0ZZ25Xl
         AxOl19gDUJhflVAcMIDol8Msye7P9p12QxCgqu48YcxwK4It+3cELtjGCt7B+rET5OQU
         0QH8DhxxbMcTJUwdW5NuzCXgNoS+StGwY3EAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNmSVnxPetdA0L3V4GkasCFzJmUbdsvVFKb52Nomjig=;
        b=WdnWLmr5a9HxV7cD9iTyD8vYzPDbVpo+7Xa2L7qxhpcRnvErrDrS3YDt3rd5LB2OzD
         6zBz2Pxk0wja82N06hQUhVqr7BkyEcnVQ0SK5GdaMUe6yhRXSCzGZcqh1zVWE1yeBaUy
         1TFEbbfIywAe559yk5YdFWOpJKU30HHLliP6aGzDj+jENtFEdfyPEFozpqMO/22UoYN4
         56TbSE/+0cmdJhKArw39jvNHpF7smWxApbU0t57esDRmQ3nKCMJw6JwimfXwIFq9WOL3
         vXUTNjeOiOnoXQwCSNQiX52cupIqHcRGUr1gISAobSbs6qLEegq2eQvGCTWw2MNCfxFw
         gHrA==
X-Gm-Message-State: AOAM530UNuzjv1truKcQE7ldZiioZ3Z5D86uV4JBDCQpVO702f7nNrMG
        P2iAdrSCLzi2AqAxny3zWkmDRzt0v64H2vPWXA7DNA==
X-Google-Smtp-Source: ABdhPJzHYyzPvcxM6korW49fJ4HfL4hi+nMo6aC6cPBOiY6HTGLaUERL/do/oqHiPu5HovfkCuQ7/ow/7kyvew2ELZw=
X-Received: by 2002:ab0:25da:: with SMTP id y26mr10449936uan.72.1637066166488;
 Tue, 16 Nov 2021 04:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com> <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
In-Reply-To: <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Nov 2021 13:35:55 +0100
Message-ID: <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 21:34:19 Miklos S=
zeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
>  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrot=
e:
>  > >  > However that wasn't what I was asking about.  AFAICS ->write_inod=
e()
>  > >  > won't start write back for dirty pages.   Maybe I'm missing somet=
hing,
>  > >  > but there it looks as if nothing will actually trigger writeback =
for
>  > >  > dirty pages in upper inode.
>  > >  >
>  > >
>  > > Actually, page writeback on upper inode will be triggered by overlay=
fs ->writepages and
>  > > overlayfs' ->writepages will be called by vfs writeback function (i.=
e writeback_sb_inodes).
>  >
>  > Right.
>  >
>  > But wouldn't it be simpler to do this from ->write_inode()?
>  >
>  > I.e. call write_inode_now() as suggested by Jan.
>  >
>  > Also could just call mark_inode_dirty() on the overlay inode
>  > regardless of the dirty flags on the upper inode since it shouldn't
>  > matter and results in simpler logic.
>  >
>
> Hi Miklos=EF=BC=8C
>
> Sorry for delayed response for this, I've been busy with another project.
>
> I agree with your suggesion above and further more how about just mark ov=
erlay inode dirty
> when it has upper inode? This approach will make marking dirtiness simple=
 enough.

Are you suggesting that all non-lower overlay inodes should always be dirty=
?

The logic would be simple, no doubt, but there's the cost to walking
those overlay inodes which don't have a dirty upper inode, right?  Can
you quantify this cost with a benchmark?  Can be totally synthetic,
e.g. lookup a million upper files without modifying them, then call
syncfs.

Thanks,
Miklos
