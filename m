Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C02ADB73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgKJQSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 11:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgKJQSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:18:47 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71940C0613D1;
        Tue, 10 Nov 2020 08:18:47 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x7so12701974ili.5;
        Tue, 10 Nov 2020 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUlP7T4EkRDeCbZhT86ipVfmSTNz6CRQ66gl9t5yhVk=;
        b=Iu5Zxz04IcYz7Bx8uJlItucJtkRKTdWeBPRjQOt9bTMAqO5OjtP20wYohWLwLidAce
         EHpRwOT5Ql1XJPX5DX5pWtVEA33DuPFP1ieDbE/reeLbD+2vZgo5WIDPkF1ioK05tslq
         ncOe0tsTp5j7nQh6t1rzvdkVe/+V9YkQy5Z75nqL1HEn6Umf7udZFW6ANp3ZFDWfx+W/
         a+YEKuWnDEBcAFNAN2j4y1YzYUaBs+/WFv3FuA8vyv5ZXTJkoCrkUo4DffJqofkWVWYp
         9eUl/gHAIr/IeWx7gulfqJoxbHONAzX6JyG9T0OnwlWTZoQJmEUyQ4fk/RYBCOuNzc0A
         qrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUlP7T4EkRDeCbZhT86ipVfmSTNz6CRQ66gl9t5yhVk=;
        b=PByXhN6eZpHMa//HXG1gBl1Jv7gZD67/nQZVFFIbLJPgRLOBMH/gsOg21fkpTZqBVB
         x15JuuW5/i5ITjz/2813dP93hpaDFhUeZdb8urbMeq4AEoav0MOB2p70DswfCaoXPvhw
         RQLKgePf6ETPSxt23ZLlfNEiG4O7myK/1OqSjUloxi9vwK2zqP/nl8xQOnXM9AIQ/bQB
         yi+3vr6ZT1UXOiGae1xSbBTwdyqyXmj3MHBKD5QeCiMLFcUg6TBWBf2DlMqPDOyo7HuR
         Ja/M+r8fFQ31XVCuYAto9oBDMvC42pJP2TTDZMo0GQvAlz38g78rcSh22rsKYls7Yk8z
         h9hQ==
X-Gm-Message-State: AOAM5327wCBKco/f7zdav2G1m1gkf5652WS66kJQ0g1t3MqBq4KOhl0q
        dJ39PHTiZ7Hb+1wxnqzUc//o/l6um92YLM1MPYw=
X-Google-Smtp-Source: ABdhPJyerdL0gaHAoqy7U3+lytf7cvPEBJgAIvvvzRt90uzr9RLPg55qxmFIijSfExwghwBE35qz6B3tHOMUCAnvono=
X-Received: by 2002:a92:6403:: with SMTP id y3mr14751503ilb.72.1605025126806;
 Tue, 10 Nov 2020 08:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-8-cgxu519@mykernel.net> <20201110134551.GA28132@quack2.suse.cz>
In-Reply-To: <20201110134551.GA28132@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Nov 2020 18:18:35 +0200
Message-ID: <CAOQ4uxgacry9pYVJeS6832G=MZVBCbamFvJULGPjk1aSBJbLxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/10] ovl: implement overlayfs' ->write_inode operation
To:     Jan Kara <jack@suse.cz>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:45 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 08-11-20 22:03:04, Chengguang Xu wrote:
> > +static int ovl_write_inode(struct inode *inode,
> > +                        struct writeback_control *wbc)
> > +{
> > +     struct ovl_fs *ofs = inode->i_sb->s_fs_info;
> > +     struct inode *upper = ovl_inode_upper(inode);
> > +     unsigned long iflag = 0;
> > +     int ret = 0;
> > +
> > +     if (!upper)
> > +             return 0;
> > +
> > +     if (!ovl_should_sync(ofs))
> > +             return 0;
> > +
> > +     if (upper->i_sb->s_op->write_inode)
> > +             ret = upper->i_sb->s_op->write_inode(inode, wbc);
> > +
> > +     iflag |= upper->i_state & I_DIRTY_ALL;
> > +
> > +     if (mapping_writably_mapped(upper->i_mapping) ||
> > +         mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
> > +             iflag |= I_DIRTY_PAGES;
> > +
> > +     if (iflag)
> > +             ovl_mark_inode_dirty(inode);
>
> I think you didn't incorporate feedback we were speaking about in the last
> version of the series. May comment in [1] still applies - you can miss
> inodes dirtied through mmap when you decide to clean the inode here. So
> IMHO you need something like:
>
>         if (inode_is_open_for_write(inode))
>                 ovl_mark_inode_dirty(inode);
>
> here to keep inode dirty while it is open for write (and not based on upper
> inode state which is unreliable).
>

Just to be clear, as long as the ovl inode is open for write, the upper inode
is also open for write via the realfile reference, but not the other
way around -
after open(); mmap(); close() of the overlay file, the ovl inode is not
open for write, but the upper inode is, because ovl_mmap() maps the
realfile and upper inode without taking any reference on the ovl file/inode.

Hence the check for mapping_writably_mapped(upper->i_mapping)
above.

Thanks,
Amir.
