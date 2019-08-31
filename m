Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39453A42CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHaGe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 02:34:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45005 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfHaGe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 02:34:59 -0400
Received: by mail-yw1-f68.google.com with SMTP id l79so3145934ywe.11;
        Fri, 30 Aug 2019 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5dRQc/V85HUSdK58SOuqLdOPIPqHI76KYRXadjhW1Q=;
        b=cG4yS7h+dHwCqC7+1d/JcKh3/NJvSD6CdeEW76fj6dxOuSvT9LSkJ8Nw3jmjC0bhZ4
         Sqx+lrDHzXK1l3xs8fjelflWht3rUg9LcY/+nBUGiZep0IuzstbMDRGUXyjzoHG7DxD/
         FpLTH8v7U7hprKh92RiJ0SQhkoJWM2DpwrNuUDnbZXfWbVuLIira7NywHRNsESJFm/vM
         vs/lvXv9Jn61eYBI4hYDyFFou9UMyxS8NTMnjWc4K+2gGiTsaYN980N8H6QvMgMYgx/R
         FNMz2TizJuR2z4eFxtNyFMXeMJJNbhab1gIRpoX9peerBAO98/FPCgrsZ/v87KPz/xsk
         mAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5dRQc/V85HUSdK58SOuqLdOPIPqHI76KYRXadjhW1Q=;
        b=SAhACyWTsrEuC5zlLLgg3V9zGlziqLFjeyFkmcfef7RqNvOjWhUnO4m9qG2Aqwvohr
         4nMiK+2CT4vvaIDJGPiSCxi2qg3sYpoOxcKYi5rQaC+icfbwZ9X3uhmClbziiqmnqhG3
         a4fkgtfbzOiwlrjCWCvCkzuYJ80Tg0E69Uz8kgQYFUl4cXYPbQO+sdNMF36VfWfNHZan
         EAzw/9UunA8h4QpXyI2RsmRwHxxVDeQkA7aicA8GJsEAr576zTiHNcryVBGeDIoTG0hU
         7eBGxglZXgaITVoXw3vjwbYyJCAeKIzTIZEauD32EYDYqDU/dLcXSqVWDgjX147Y8ntW
         kQuw==
X-Gm-Message-State: APjAAAUC/+O2Bker0m3vb52ULUoIVpuzqNKBDP//jx7EfW+UHe0/DsTL
        4n4ruG+8grPvRn1ckev2f4laF+1MmuxoTHAj030=
X-Google-Smtp-Source: APXvYqxA5jrG+aw5cnWfvi5zFi4WHO9+wZCHT7+Yz6m0t7DUrxcUd6HDfyHU+ofMYTrsXauHYejNEsuIL56i7wezFkE=
X-Received: by 2002:a81:6c8:: with SMTP id 191mr11928917ywg.181.1567233298135;
 Fri, 30 Aug 2019 23:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com> <20190829101545.GC20598@infradead.org>
 <20190829105048.GB64893@architecture4> <20190830163910.GB29603@infradead.org> <20190830171510.GC107220@architecture4>
In-Reply-To: <20190830171510.GC107220@architecture4>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 31 Aug 2019 09:34:44 +0300
Message-ID: <CAOQ4uxichLUsPyg5Fqg-pSL85oqoDFcQHZbzdrkXX_-kK=CjDQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:16 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Hi Christoph,
>
> On Fri, Aug 30, 2019 at 09:39:10AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 29, 2019 at 06:50:48PM +0800, Gao Xiang wrote:
> > > > Please use an erofs_ prefix for all your functions.
> > >
> > > It is already a static function, I have no idea what is wrong here.
> >
> > Which part of all wasn't clear?  Have you looked at the prefixes for
> > most functions in the various other big filesystems?
>
> I will add erofs prefix to free_inode as you said.
>
> At least, all non-prefix functions in erofs are all static functions,
> it won't pollute namespace... I will add "erofs_" to other meaningful
> callbacks...And as you can see...
>
> cifs/cifsfs.c
> 1303:cifs_init_inodecache(void)
> 1509:   rc = cifs_init_inodecache();
>
> hpfs/super.c
> 254:static int init_inodecache(void)
> 771:    int err = init_inodecache();
>
> minix/inode.c
> 84:static int __init init_inodecache(void)
> 665:    int err = init_inodecache();
>

Hi Gao,

"They did it first" is never a good reply for code review comments.
Nobody cares if you copy&paste code with init_inodecache().
I understand why you thought static function names do not pollute
the (linker) namespace, but they do pollute the global namespace.

free_inode() as a local function name is one of the worst examples
for VFS namespace pollution.

VFS code uses function names like those a lot in the global namespace, e.g.:
clear_inode(),new_inode().

For example from recent history of namespace collision caused by your line
of thinking, see:
e6fd2093a85d md: namespace private helper names

Besides, you really have nothing to loose from prefixing everything
with erofs_, do you? It's better for review, for debugging...

Thanks,
Amir.
