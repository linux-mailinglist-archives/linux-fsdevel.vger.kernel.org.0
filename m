Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA12B18C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 11:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMKJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 05:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:09:04 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9AC0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 02:09:02 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 128so4916276vso.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntJe58JJvWUwV49DymZs6DEQBF+HekWSlI2Qfd/lNA8=;
        b=gpnnYUZwKVoTQr7avPNwzOBnUZYfBOmfAi1/KSoiKz68LoF0HwqufyKDj0vtCz0PeC
         SGCqhq5FPV9syHwfoFY/MjXzgsEkf1gPkJp1Mz63B0BtDVrIY5dOSsXJvcZs/AAB8xds
         x9dvvybf1kKULN9tYhS5fjXDpa5JWx58DPlGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntJe58JJvWUwV49DymZs6DEQBF+HekWSlI2Qfd/lNA8=;
        b=G+Qt8v6zvUbljpOSnl07bcpUIxIKbI2FnTI3kv7VvoMQa8VnCyp5I3qhgI4jUjKpFB
         plN5r1UvohVQ5aGfxbLpITMWC1yiUlVJQHX6wWyQ2ltiilQ+42hTvmTrWlOKFkHwG5IW
         FriPMBeHAcawo+QpY/PcNPL5bOIyk7jEjehsfW0J4TviRJXWcaVODr1cJLTOit4VXtyh
         BIyYTHzZsVtfq1y0CcxrrfQTl6pUL4IUrf3kBnRD7MrmmZ/QPX4g9gp6GAWiwmkilUdx
         pc00Vac3IJAEUKRPlP+MNDvulikmema3qnAFc9Sw5cydRNKSHRL+3NVntUEY/vt74akr
         OSyA==
X-Gm-Message-State: AOAM531bAdsH1CT7wgo9md6mIzeDfR2/xjROJuv/3iNKvSufNpt/+Foa
        4OHmpOjAhAWSodzChmP/jb/QN+dUd0KvfPg52rlAlg==
X-Google-Smtp-Source: ABdhPJyTTUE8PuIBDA22incmVg5+G+gqu5E9atoOP67k989x9DWi7XsfPK3q1FQ/z1DfPdoUaT3LhLMs2knx2GVOOX8=
X-Received: by 2002:a67:ce1a:: with SMTP id s26mr572304vsl.0.1605262141462;
 Fri, 13 Nov 2020 02:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20201113090049.GA95467@mwanda>
In-Reply-To: <20201113090049.GA95467@mwanda>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Nov 2020 11:08:50 +0100
Message-ID: <CAJfpegsBOQmAiKWPPOb+DLFwmATBjoZfkXJSTw45zuGQb+ZDNA@mail.gmail.com>
Subject: Re: [bug report] fuse: get rid of fuse_mount refcount
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:01 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Miklos Szeredi,
>
> The patch 514b5e3ff45e: "fuse: get rid of fuse_mount refcount" from
> Nov 11, 2020, leads to the following static checker warning:
>
>     fs/fuse/virtio_fs.c:1451 virtio_fs_get_tree()
>     error: double free of 'fm'
>
> fs/fuse/virtio_fs.c
>   1418          if (!fs) {
>   1419                  pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
>   1420                  return -EINVAL;
>   1421          }
>   1422
>   1423          err = -ENOMEM;
>   1424          fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
>   1425          if (!fc)
>   1426                  goto out_err;
>   1427
>   1428          fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
>   1429          if (!fm)
>   1430                  goto out_err;
>   1431
>   1432          fuse_conn_init(fc, fm, get_user_ns(current_user_ns()),
>   1433                         &virtio_fs_fiq_ops, fs);
>   1434          fc->release = fuse_free_conn;
>   1435          fc->delete_stale = true;
>   1436          fc->auto_submounts = true;
>   1437
>   1438          fsc->s_fs_info = fm;
>   1439          sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
>   1440          if (fsc->s_fs_info) {
>   1441                  fuse_conn_put(fc);
>   1442                  kfree(fm);
>                         ^^^^^^^^^
> Freed here
>
>   1443          }
>   1444          if (IS_ERR(sb))
>   1445                  return PTR_ERR(sb);
>   1446
>   1447          if (!sb->s_root) {
>   1448                  err = virtio_fs_fill_super(sb, fsc);
>   1449                  if (err) {
>   1450                          fuse_conn_put(fc);
>   1451                          kfree(fm);
>                                 ^^^^^^^^^
> Double free

The code is correct but tricky to prove.  So here it goes:

We set fsc->s_fs_info to non-NULL before calling sget_fc().

sget_fc() will set fsc->s_fs_info to NULL only if we return a newly
allocated superblock (i.e. sb->s_root is NULL).

In case sget_fc() returns an old superblock, then that means
sb->s_root is non-NULL.  To prove this look at grab_super() which
checks SB_BORN.  SB_BORN is set in vfs_get_tree() after a successful
call to fsc->ops->get_tree() (i.e. virtio_fs_get_tree()), which in
turn will return success only if sb->s_root has been set to non-NULL
(see virtio_fs_fill_super() and fuse_fill_super_common()).

Now we know that sget_fc() will return with

  (a negative fsc->s_fs_info AND a negative sb->s_root) OR
  (a positive fsc->s_fs_info AND a (positive sb->s_root OR an error))

So the double free can never happen.  I wouldn't expect the static
checker to figure that out.

>
>   1452                          sb->s_fs_info = NULL;
>
> I'm sort of surprised this is setting "sb->" instead of "fsc->".

The reason is that deactivate_locked_super() will call ->kill_sb (i.e.
virtio_kill_sb()) and we don't want that function to mess with the
destruction of a half baked fuse_mount structure.  So we just free it
by hand and set sb->s_fs_info to NULL.

Thanks,
Miklos
