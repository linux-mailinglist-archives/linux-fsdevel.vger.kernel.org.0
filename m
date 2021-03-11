Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCED337CA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCKS0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 13:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhCKS0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:26:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B90C061574;
        Thu, 11 Mar 2021 10:26:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so3093867wrr.10;
        Thu, 11 Mar 2021 10:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HxhUMCrD9+ZkWt0mUL/2aXvr5b+kfJE63kRa41DPx8=;
        b=or1WPs5X/Hhu/p+m4i7ddPsadUVhJRZ5nJEJIDAXfN3T/3PDcPyaofRXIhY2Yrh1/i
         1V/xhJzEZbIxRhDS/ZhxkHQZeqhiYGJ6aQSiZSjq0TYGYj+IrWls82kW1dxcEXTvqshz
         /usHFkaZhW4D74FBIi3tAkzGZ2Vj+NMlvmkxE5sPuYM6RN5mjOG8+Js1BBeHh1256N4D
         SSFnEvCEMfujVAP4Qhe4sDqZcZrax/kTDnp90C0LrfgK6yCCT4NKnNu1Bdq8ehsgu86Z
         rDG3UQ3Tqw//DQwceJROnQju5VLWBZmwQ4hRiQtvWvXTKpPgKe6kj+vDpQtsivD+D/Bk
         VX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HxhUMCrD9+ZkWt0mUL/2aXvr5b+kfJE63kRa41DPx8=;
        b=T1Wunoj6CCxYBbbAM4PbXvQbZ0lXfBu3JMmnEHME8xftgjCWWEzd3K8lQxRAxxr0fr
         p+Yi3jQbka7Dios0Au8Glryu+mGyD7daJrs0+54YfqejL/JTqLrjcBTvJcCweZHcAWGX
         4q0cG/kxfrLh+ut9xvv6gAgfBgToOkSRhowDwyeX6qh4LsqnaaQCw0yAq+mqV3o3Vlyz
         5OyLWFkbfUZEnVmbnJ172KN9pRwYmufSF6heQPbUPrmrKzixGbhu5Kz5dqWe8AoK3C92
         p8dlQviMPsoM+rUKLbmu692V7++0N7c533IISTcybixBCmWd44zYEL0wpVL6BvXnNuX8
         SmzA==
X-Gm-Message-State: AOAM533m0wieFO8VdDv/MUao2NM3JtVQgMHNR9DuKfjDJVLuni6qLgIN
        EjKvIKSfEjSAU0h6hHZ3X1+ClCY6oIJzMoe/GYA=
X-Google-Smtp-Source: ABdhPJxQFpuouVwrgD1i7fKZ5jDwC1G5xPeoqqHPRXd4m3/czr+/IYlrzmUQZuSvZ8ur3WQxLQVdoFVQEqjx1zfDNW8=
X-Received: by 2002:adf:fb8a:: with SMTP id a10mr9970966wrr.365.1615487193211;
 Thu, 11 Mar 2021 10:26:33 -0800 (PST)
MIME-Version: 1.0
References: <161547181530.1868820.12933722592029066752.stgit@warthog.procyon.org.uk>
 <161547182293.1868820.9860274141056722598.stgit@warthog.procyon.org.uk>
In-Reply-To: <161547182293.1868820.9860274141056722598.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Thu, 11 Mar 2021 14:26:22 -0400
Message-ID: <CAB9dFdtq9S04CjuBeUW8g9=59mtGFQducO-HTu-CLNNPnCWt4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] afs: Fix accessing YFS xattrs on a non-YFS server
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:10 AM David Howells <dhowells@redhat.com> wrote:
>
> If someone attempts to access YFS-related xattrs (e.g. afs.yfs.acl) on a
> file on a non-YFS AFS server (such as OpenAFS), then the kernel will jump
> to a NULL function pointer because the afs_fetch_acl_operation descriptor
> doesn't point to a function for issuing an operation on a non-YFS
> server[1].
>
> Fix this by making afs_wait_for_operation() check that the issue_afs_rpc
> method is set before jumping to it and setting -ENOTSUPP if not.  This fix
> also covers other potential operations that also only exist on YFS servers.
>
> afs_xattr_get/set_yfs() then need to translate -ENOTSUPP to -ENODATA as the
> former error is internal to the kernel.
>
> The bug shows up as an oops like the following:
>
>         BUG: kernel NULL pointer dereference, address: 0000000000000000
>         [...]
>         Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
>         [...]
>         Call Trace:
>          afs_wait_for_operation+0x83/0x1b0 [kafs]
>          afs_xattr_get_yfs+0xe6/0x270 [kafs]
>          __vfs_getxattr+0x59/0x80
>          vfs_getxattr+0x11c/0x140
>          getxattr+0x181/0x250
>          ? __check_object_size+0x13f/0x150
>          ? __fput+0x16d/0x250
>          __x64_sys_fgetxattr+0x64/0xb0
>          do_syscall_64+0x49/0xc0
>          entry_SYSCALL_64_after_hwframe+0x44/0xa9
>         RIP: 0033:0x7fb120a9defe
>
> This was triggered with "cp -a" which attempts to copy xattrs, including
> afs ones, but is easier to reproduce with getfattr, e.g.:
>
>         getfattr -d -m ".*" /afs/openafs.org/
>
> Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
> Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
> cc: linux-afs@lists.infradead.org
> Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003498.html [1]
> ---
>
>  fs/afs/fs_operation.c |    7 +++++--
>  fs/afs/xattr.c        |    8 +++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
> index 97cab12b0a6c..71c58723763d 100644
> --- a/fs/afs/fs_operation.c
> +++ b/fs/afs/fs_operation.c
> @@ -181,10 +181,13 @@ void afs_wait_for_operation(struct afs_operation *op)
>                 if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags) &&
>                     op->ops->issue_yfs_rpc)
>                         op->ops->issue_yfs_rpc(op);
> -               else
> +               else if (op->ops->issue_afs_rpc)
>                         op->ops->issue_afs_rpc(op);
> +               else
> +                       op->ac.error = -ENOTSUPP;
>
> -               op->error = afs_wait_for_call_to_complete(op->call, &op->ac);
> +               if (op->call)
> +                       op->error = afs_wait_for_call_to_complete(op->call, &op->ac);
>         }
>
>         switch (op->error) {
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> index c629caae5002..4934e325a14a 100644
> --- a/fs/afs/xattr.c
> +++ b/fs/afs/xattr.c
> @@ -231,6 +231,8 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
>                         else
>                                 ret = -ERANGE;
>                 }
> +       } else if (ret == -ENOTSUPP) {
> +               ret = -ENODATA;
>         }
>
>  error_yacl:
> @@ -256,6 +258,7 @@ static int afs_xattr_set_yfs(const struct xattr_handler *handler,
>  {
>         struct afs_operation *op;
>         struct afs_vnode *vnode = AFS_FS_I(inode);
> +       int ret;
>
>         if (flags == XATTR_CREATE ||
>             strcmp(name, "acl") != 0)
> @@ -270,7 +273,10 @@ static int afs_xattr_set_yfs(const struct xattr_handler *handler,
>                 return afs_put_operation(op);
>
>         op->ops = &yfs_store_opaque_acl2_operation;
> -       return afs_do_sync_operation(op);
> +       ret = afs_do_sync_operation(op);
> +       if (ret == -ENOTSUPP)
> +               ret = -ENODATA;
> +       return ret;
>  }
>
>  static const struct xattr_handler afs_xattr_yfs_handler = {

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
