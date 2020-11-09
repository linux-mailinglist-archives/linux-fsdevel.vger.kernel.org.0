Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1491E2AB191
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 08:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgKIHHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 02:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:07:30 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA34C0613CF;
        Sun,  8 Nov 2020 23:07:30 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id p10so7349436ile.3;
        Sun, 08 Nov 2020 23:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eG6PDRMgdaOWDPjMSdECrbgLcwRxlu8sWLc5eLe8ooU=;
        b=nR1h6okH0FZy0FJMqTzsjcvKHYUdxin3H9YC3hVW2J51w8JXkHT9L9MXQmIqhXP7hw
         A8EB+U8fug9n3vEourwmcM2qM2pwqPwHyJphYF2vE65y+iGddYdV6lMUmxuwb4WxbRIH
         dSZb5exGUVIvD5Cjg1ymiu58DB4tjiKJn3ZGnHOZ6E/ZOro5JGQiL3zEP1YjCXplfp+b
         eJhsJyMf44GD1xkR9ELv4lpePuMT7N0fXlD7FSVo2ZbxIqx9j4Vh7dFJvrJh196rZXIR
         2soDO4KeC2S0K5thnxVDOZNtLbS7xtSeTsewwfJvi6GbvPaDHYdG6hiPer7vhxd56Zmo
         sZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eG6PDRMgdaOWDPjMSdECrbgLcwRxlu8sWLc5eLe8ooU=;
        b=Bff1aF+p2D1SZz/FO3jyexD1VuzgjlquC6cIR7YjXX2vWp0uNNhzfi+hk2OEby7B8f
         tEXqV4tU7gotFbD1cEyPwu3yXBhWqjfzXbeix82XlKVLiLy9wqSnooeZ6UJWhKNCnBC1
         UnfPsrB5lWJND3oODT6k0gkgjQFKFYbpfYPb+fPSEc42uWTUm4/F5rFgmVwHno7UxYYL
         G79m2U/IWKlEHVp7zHdJ1dZ3z+X7f16zSNgQWIHWyCISFs3SaLKCzfu2KIdLdObLn02N
         13I/7V33rwpmNIy3RFMOLeZTDHB0cMbGb3r5I33TtRQSirRNnYyTpnxUDIbVJ6KVraWU
         Ik+g==
X-Gm-Message-State: AOAM531Q2g6VtGB2IWeeqDYW274Ye8WUvYxEJqRuz0lSoYXTTQI+ArvC
        6BsnrJYlX+cUdXWMrh8Gb0QPRPM/j3gdBm2tNi4=
X-Google-Smtp-Source: ABdhPJyjWPxQoWh4VHWQCbd4B9J8TZHQXm9xTCxugxDrEU65MgJbTHCOWThtrdaBuFKDa/WTklht4eiQhojGnOLyDx4=
X-Received: by 2002:a05:6e02:c1:: with SMTP id r1mr9312773ilq.250.1604905649940;
 Sun, 08 Nov 2020 23:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-10-cgxu519@mykernel.net> <175ab1145ed.108462b5a912.9181293177019474923@mykernel.net>
In-Reply-To: <175ab1145ed.108462b5a912.9181293177019474923@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Nov 2020 09:07:18 +0200
Message-ID: <CAOQ4uxhVQC_PDPaYvO9KTSJ6Vrnds-yHmsyt631TSkBq6kqQ5g@mail.gmail.com>
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

On Mon, Nov 9, 2020 at 5:34 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:06 Chenggua=
ng Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
>  > Introduce a helper ovl_wait_wb_inodes() to wait until all
>  > target upper inodes finish writeback.
>  >
>  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > ---
>  >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
>  >  1 file changed, 30 insertions(+)
>  >
>  > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>  > index e5607a908d82..9a535fc11221 100644
>  > --- a/fs/overlayfs/super.c
>  > +++ b/fs/overlayfs/super.c
>  > @@ -255,6 +255,36 @@ static void ovl_put_super(struct super_block *sb)
>  >      ovl_free_fs(ofs);
>  >  }
>  >
>  > +void ovl_wait_wb_inodes(struct ovl_fs *ofs)
>  > +{
>  > +    LIST_HEAD(tmp_list);
>  > +    struct ovl_inode *oi;
>  > +    struct inode *upper;
>  > +
>  > +    spin_lock(&ofs->syncfs_wait_list_lock);
>  > +    list_splice_init(&ofs->syncfs_wait_list, &tmp_list);
>  > +
>  > +    while (!list_empty(&tmp_list)) {
>  > +        oi =3D list_first_entry(&tmp_list, struct ovl_inode, wait_lis=
t);
>  > +        list_del_init(&oi->wait_list);
>  > +        ihold(&oi->vfs_inode);
>
> Maybe I overlooked race condition with inode eviction, so still need to i=
ntroduce
> OVL_EVICT_PENDING flag just like we did in old syncfs efficiency patch se=
ries.
>

I am not sure why you added the ovl wait list.

I think you misunderstood Jan's suggestion.
I think what Jan meant is that ovl_sync_fs() should call
wait_sb_inodes(upper_sb)
to wait for writeback of ALL upper inodes after sync_filesystem()
started writeback
only on this ovl instance upper inodes.

I am not sure if this is acceptable or not - it is certainly an improvement=
 over
current situation, but I have a feeling that on a large scale (many
containers) it
won't be enough.

The idea was to keep it simple without over optimizing, since anyway
you are going for the "correct" solution long term (ovl inode aops),
so I wouldn't
add the wait list.

As long as the upper inode is still dirty, we can keep the ovl inode in cac=
he,
so the worst outcome is that drop_caches needs to get called twice before t=
he
ovl inode can be evicted, no?

Thanks,
Amir.
