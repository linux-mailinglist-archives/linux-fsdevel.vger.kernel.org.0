Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2062F72A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 07:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE3Fn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 01:43:56 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39853 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfE3Fnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 01:43:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id w21so2135698ywd.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHi6K0/D6gGGvCWty+sf/RE6xkq6uZZjkfV+dKyM0aY=;
        b=DuQ6E1wpoyTD8foRIZci8Dq/bE5M1GrbMJpRbEp0ErFTE4yDeP3n7Okf47vz9IVsf6
         SbVMjmWbMPA0h5d0CTdU318LoP4kI6uT1sMcRw5E01tDShaf0MOYpWb+7pxQhKCY1bNo
         0rOjd1JR1Uk4pAmbhDEzEy61LLbTVkZb6DCq7jl4ffUSGMD503HwfoAMKkg/tFMt6t3a
         cmiQvDOgBO6ZxkLwNQoVliRde/FWbVbQyHRDDe8WJEVYC2rVTwbvHaRTG17/YV1RF8Fe
         ZA2Qq9Zyp7g5qEPlGU0ZmvFtywX09dsV8Ra/tMYYbIf1Z5crWKFFoyhvIES9ESoQ5uH2
         90kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHi6K0/D6gGGvCWty+sf/RE6xkq6uZZjkfV+dKyM0aY=;
        b=kolwRTaOx7JppWO6BbsiqEfcyX1Arl6ZDF+RWecR2E5oPDdQpW9Ia3A+jTv8TMREqu
         xsLTFJA01l2ky0OA/g5KfABGLJGxiTwT0M+H/gDiHJ92/GdMa3Bvav+ASCSKtxX8rB/o
         2QPxZ82ia6cRFWfpTKpHOkAAPohjEKKtAihmDnMJOO6FUUGhKEYNUoUYgofs/p5GQyGa
         pAYCLpbcFVvY0CF8bNM8NGnKNCVVDIic5nNDPadCZDbA5tZ09rm+TdNiW7/36juBLSHA
         mOSrEdYkXCei8rccN2l0+WwNNpipoMuBHSxgpcOTi+HGr7V6bScceIZ4gpiI6PCkmosk
         EfMA==
X-Gm-Message-State: APjAAAVRlIXBO/wgslLDBqCOTyedFpAPNqle6ZnTOiDV9UMTegWyYOsJ
        51U1nCPC+DVCLl8BiDZaygJZu1nzt5aqfEn7lXo=
X-Google-Smtp-Source: APXvYqxT4a1EYRpUgw+1sO6F//RzhEyHMr+tS2mztWmDgtbtYs8F1kZuaN3hXIYna+5R9XVmjxWCkBOM3hxAsmcNiX8=
X-Received: by 2002:a81:4f06:: with SMTP id d6mr920935ywb.379.1559195034938;
 Wed, 29 May 2019 22:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190526143411.11244-4-amir73il@gmail.com>
In-Reply-To: <20190526143411.11244-4-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 May 2019 08:43:43 +0300
Message-ID: <CAOQ4uxh4q_ArSROkdUxFW9oezEYc4qqJNFS8oOULsVhx6-1Lig@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Trond,Anna,Bruce,

Seems that rpc_pipefs is co-maintained by client and server trees, so
not sure who is the best to ask for an ack.
We need to add those explicit fsnotify hooks to match the existing
fsnotify_create/mkdir hooks, because
the hook embedded inside d_delete() is going away [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190526143411.11244-1-amir73il@gmail.com/

On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().
>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  net/sunrpc/rpc_pipe.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 979d23646e33..917c85f15a0b 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -597,6 +597,8 @@ static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
>
>         dget(dentry);
>         ret = simple_rmdir(dir, dentry);
> +       if (!ret)
> +               fsnotify_rmdir(dir, dentry);
>         d_delete(dentry);
>         dput(dentry);
>         return ret;
> @@ -608,6 +610,8 @@ static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
>
>         dget(dentry);
>         ret = simple_unlink(dir, dentry);
> +       if (!ret)
> +               fsnotify_unlink(dir, dentry);
>         d_delete(dentry);
>         dput(dentry);
>         return ret;
> --
> 2.17.1
>
