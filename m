Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C7A2C670A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 14:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgK0Nl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 08:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgK0Nl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:41:27 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1159C0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 05:41:26 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so3552281wme.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHhjZBnN3z+3VsZkWuXYAabXbjj+P9rLGt94s7fOAdE=;
        b=ikght7tYkECfMn6+P7TQQwmVNKLHoNl6eXVnWD2C9Z9lbvCgExRuIhfhxtYfjLY6Nb
         pxmLCfgOdbfWNbleeDtMopz7SyVmgIBFu22cNo8/jG8tTXPDIS4Q/VK/clahboEMaSNy
         7ndsMYxe/JDu9ogG7m2eHFBBIoFr2WL7psjYqoSWN54+sHjauRwknulfN4RBM4Qcn1yU
         X09CwYgIXQWRwqRV7jGrGu/SHDt5eoWJ2Y0eNksm66va949Z6PmMcxDMgCkXhvICIsBn
         +DWvC5kA3hRqXWUJnDXxqlI67DMHWYQzhXC3D5BrmqJNYWoDNHDMSmuMPa1pZS+vI3HC
         7ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHhjZBnN3z+3VsZkWuXYAabXbjj+P9rLGt94s7fOAdE=;
        b=ZCZbimhijyb9WXlF9WdjAM9FMjTwLilu04uIIpaCzuB844ivLZOuwOCSU/m7TLe9SH
         8LTx8JXdNyYnlLcoA85LhR+fNmLUwQO1UAQJiqoZGBJbbS0RJQ50GrAT40Eh1/4USJiM
         7szRA/xNM++vbSh35fYR01AJwG2n0sfyJUkUGgqh7eg4s6CVLHIP8z/EegzcbfafFL+A
         xiBAm4wrE++CcRkIvGYb9CW1/R6xLrQvhrFK8pVQE0TdyTHNbyDMeTljKiSAkTM8VcpE
         Be8qlNkhk6wgx5p/O5h8563ZSZvCfi2S2WRx1JNz8dg6p+/f/yw17MZ0+ZgvFW5qTmaw
         Um8g==
X-Gm-Message-State: AOAM5335VVPb1zbdCt3LpDaV9yUKjkE7jdJLtQzrDw4xljuAiDISZMTs
        /7+vGjVRijzd35dZ9lmr6gcp6A==
X-Google-Smtp-Source: ABdhPJwp9xhLWYyvuEjhN38qd9ChbF/34s78mW+mZupp6vCKzJi1O+WlOWnhEkJpxsD5KqWJYhcQRQ==
X-Received: by 2002:a05:600c:256:: with SMTP id 22mr9203669wmj.120.1606484485585;
        Fri, 27 Nov 2020 05:41:25 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id v189sm14287638wmg.14.2020.11.27.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:41:24 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:41:23 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 2/5] fuse: Passthrough initialization and release
Message-ID: <20201127134123.GA569154@google.com>
References: <20201026125016.1905945-1-balsini@android.com>
 <20201026125016.1905945-3-balsini@android.com>
 <CA+a=Yy4bhC-432h8shxbsrY5vjTcRZopS-Ojo0924L49+Be3Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+a=Yy4bhC-432h8shxbsrY5vjTcRZopS-Ojo0924L49+Be3Cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peng,

Thanks for the heads up!

On Thu, Nov 26, 2020 at 09:33:34PM +0800, Peng Tao wrote:
> On Tue, Oct 27, 2020 at 12:19 AM Alessio Balsini <balsini@android.com> wrote:
> > [...]
> >  int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
> >                            struct fuse_open_out *openarg)
> >  {
> > -       return -EINVAL;
> > +       struct inode *passthrough_inode;
> > +       struct super_block *passthrough_sb;
> > +       struct fuse_passthrough *passthrough;
> > +       int passthrough_fh = openarg->passthrough_fh;
> > +
> > +       if (!fc->passthrough)
> > +               return -EPERM;
> > +
> > +       /* Default case, passthrough is not requested */
> > +       if (passthrough_fh <= 0)
> > +               return -EINVAL;
> > +
> > +       spin_lock(&fc->passthrough_req_lock);
> > +       passthrough = idr_remove(&fc->passthrough_req, passthrough_fh);
> > +       spin_unlock(&fc->passthrough_req_lock);
> > +
> > +       if (!passthrough)
> > +               return -EINVAL;
> > +
> > +       passthrough_inode = file_inode(passthrough->filp);
> > +       passthrough_sb = passthrough_inode->i_sb;
> > +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
> Hi Alessio,
> 
> passthrough_sb is the underlying filesystem superblock, right? It
> seems to prevent fuse passthrough fs from stacking on another fully
> stacked file system, instead of preventing other file systems from
> stacking on this fuse passthrough file system. Am I misunderstanding
> it?

Correct, this checks the stacking depth on the lower filesystem.
This is an intended behavior to avoid the stacking of multiple FUSE
passthrough filesystems, and works because when a FUSE connection has
the passthrough feature activated, the file system updates its
s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH in process_init_reply()
(PATCH 1/5), avoiding further stacking.

Do you see issues with that?

What I'm now thinking is that fuse_passthrough_open would probably be a
better place for this check, so that the ioctl() would fail and the user
space daemon may decide to skip passthrough and use legacy FUSE access
for that file (or, at least, be aware that something went wrong).

A more aggressive approach would be instead to move the stacking depth
check to fuse_fill_super_common, where we can update s_stack_depth to
lower-fs depth+1 and fail if passthrough is active and s_stack_depth is
greater than FILESYSTEM_MAX_STACK_DEPTH.

What do you think?

Thanks,
Alessio

