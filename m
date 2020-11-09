Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83E12AB468
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgKIKHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 05:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgKIKHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:07:31 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC059C0613D4;
        Mon,  9 Nov 2020 02:07:30 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u21so9148356iol.12;
        Mon, 09 Nov 2020 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ym0oIMv33/iMuLrAJ/9zIGez9P0YX8+hd5KLokB0ljM=;
        b=eMZ8v3JaFAr60niNqW5VMWhrMhYpFIi+6Z89T67ZVJ6OYWN4ZqdUDyVmkhlZcNBXT+
         rJ01cRbU/61lH3yglNxms2olcbm2cL6zqkNKkyGE9vWg6QmhaZSHTWgP7F1sQ7Ona0os
         xal070DHZQfzPXvTxXtMO+vD9SgfebXLnRlANfhek6zsuGoHpAyYlJOQ5HrYXPTnoyyW
         QURut8M6L7ZZB3FHwfiZd3z83mhKrKrHWgzTZKO0MJlVqSWIHiT1EGn5tluN7J+pCXk1
         Lx33yTClTKAPZBoNqK/BBThNOqGcek4h3KoULXUDwBRpSaNvD2mnwNRBcd7yJfC/6l4C
         m5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ym0oIMv33/iMuLrAJ/9zIGez9P0YX8+hd5KLokB0ljM=;
        b=ZOYve20+4yKyn8qGY/t1vFQAvbf9TFl+OpXkjEfdJ3IE49nYzjRwq2BtVRBDeCeEg8
         ZhN529XkyhtHahTPzoeoezLJAI3rpbT4j9m06/ecnSPIwFJ588oc7dmRhwqEWHJc6Dja
         JFKMuayYT/DKf3WBJqvHb8CRBgwCWYr4NDlOa11vZlXpE4kFsIeL9Ja3XDEWLyeACu+m
         aQIhYl/G6VK8s8488Wpt6kmNoK82bI/1k8he3jSfvJMoEBWbL2lR3uw2rjxOoJ3ZdCh5
         H4oWGLZZ1d5vVZMRt+pASBZBv8bKakjKxTCyJ7JGXE7taK983A4nExpBb0sPZXc7RK2x
         JXCg==
X-Gm-Message-State: AOAM532xljM7E15eDacdNVMJOOIH53zTP5VMakOE6Rn6Rk2lP+lSMs3L
        hqR14kwjIOhON5sPc+0YhMVdUSlRwdK9eq7Eots=
X-Google-Smtp-Source: ABdhPJwhvA/k7LHodxyloYJ9hKXhU73nK/Jwpk8sz2Evr7giMt7pSIRN7vUPQOdn4VIJbfi1C7a/qLUYiEp8UFkq3yY=
X-Received: by 2002:a05:6602:5de:: with SMTP id w30mr5726971iox.64.1604916450141;
 Mon, 09 Nov 2020 02:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-10-cgxu519@mykernel.net> <175ab1145ed.108462b5a912.9181293177019474923@mykernel.net>
 <CAOQ4uxhVQC_PDPaYvO9KTSJ6Vrnds-yHmsyt631TSkBq6kqQ5g@mail.gmail.com> <175ac242078.1287a39451704.7442694321257329129@mykernel.net>
In-Reply-To: <175ac242078.1287a39451704.7442694321257329129@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Nov 2020 12:07:18 +0200
Message-ID: <CAOQ4uxgfi26HDp6YWx3Tgc1tY_EMrfcW_hz5FMG8vXeHLdycBw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/10] ovl: introduce helper of syncfs writeback
 inode waiting
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos <miklos@szeredi.hu>, jack <jack@suse.cz>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 10:34 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-11-09 15:07:18 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Mon, Nov 9, 2020 at 5:34 AM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
>  > >
>  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:06 Che=
ngguang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
>  > >  > Introduce a helper ovl_wait_wb_inodes() to wait until all
>  > >  > target upper inodes finish writeback.
>  > >  >
>  > >  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > >  > ---
>  > >  >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
>  > >  >  1 file changed, 30 insertions(+)
>  > >  >
>  > >  > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>  > >  > index e5607a908d82..9a535fc11221 100644
>  > >  > --- a/fs/overlayfs/super.c
>  > >  > +++ b/fs/overlayfs/super.c
>  > >  > @@ -255,6 +255,36 @@ static void ovl_put_super(struct super_block=
 *sb)
>  > >  >      ovl_free_fs(ofs);
>  > >  >  }
>  > >  >
>  > >  > +void ovl_wait_wb_inodes(struct ovl_fs *ofs)
>  > >  > +{
>  > >  > +    LIST_HEAD(tmp_list);
>  > >  > +    struct ovl_inode *oi;
>  > >  > +    struct inode *upper;
>  > >  > +
>  > >  > +    spin_lock(&ofs->syncfs_wait_list_lock);
>  > >  > +    list_splice_init(&ofs->syncfs_wait_list, &tmp_list);
>  > >  > +
>  > >  > +    while (!list_empty(&tmp_list)) {
>  > >  > +        oi =3D list_first_entry(&tmp_list, struct ovl_inode, wai=
t_list);
>  > >  > +        list_del_init(&oi->wait_list);
>  > >  > +        ihold(&oi->vfs_inode);
>  > >
>  > > Maybe I overlooked race condition with inode eviction, so still need=
 to introduce
>  > > OVL_EVICT_PENDING flag just like we did in old syncfs efficiency pat=
ch series.
>  > >
>  >
>  > I am not sure why you added the ovl wait list.
>  >
>  > I think you misunderstood Jan's suggestion.
>  > I think what Jan meant is that ovl_sync_fs() should call
>  > wait_sb_inodes(upper_sb)
>  > to wait for writeback of ALL upper inodes after sync_filesystem()
>  > started writeback
>  > only on this ovl instance upper inodes.
>  >
>
>
> Maybe you are right, the wait list is just for accuracy that can complete=
ly
> avoid interferes between ovl instances, otherwise we may need to face
> waiting interferes  in high density environment.
>
>
>  > I am not sure if this is acceptable or not - it is certainly an improv=
ement over
>  > current situation, but I have a feeling that on a large scale (many
>  > containers) it
>  > won't be enough.
>  >
>
> The same as your thought.
>
>
>  > The idea was to keep it simple without over optimizing, since anyway
>  > you are going for the "correct" solution long term (ovl inode aops),
>  > so I wouldn't
>  > add the wait list.
>  >
>
> Maybe, I think it depends on how to implement ovl page-cache, so at curre=
nt
> stage I have no idea for the wait list.
>
>
>  > As long as the upper inode is still dirty, we can keep the ovl inode i=
n cache,
>  > so the worst outcome is that drop_caches needs to get called twice bef=
ore the
>  > ovl inode can be evicted, no?
>  >
>
> IIUC, since currently ovl does not have it's own page-cache, so there is =
no affect to page-cache reclaim,
> also  there is no ovl shrinker to reclaim slab because we drop ovl inode =
directly after final iput.
> So should we add a shrinker in this series?
>

Would that add a lot of complexity?
Thinking out loud: maybe we follow Jan's suggestion and fix remaining
performance with followup series?

Thanks,
Amir.
