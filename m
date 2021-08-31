Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335753FC807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhHaNSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 09:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhHaNSb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B286103D
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630415856;
        bh=YpUpqCuOohxfPsLHspRxSylzqsTHmbEuqsRw0UPozEE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YGIyXTNrU60/C42NxmrMORKd178HBch/izIFMt3Iiat8t0Br0bgvCPLdM1F7CrFGK
         Y1pm0i4LUh7yjJBahRR4KXM+5u2Q4hEKuwE/wsViT6VVfjuegxT2Y1174O+DCAZyIQ
         o7HnBLZ1PJlWNNlT69UISxeaB2uW3gsCbINpVWSr5YIFs7bqn0Nm3U8D4Tf/CHSPTX
         1gB650ClUap/7RyQAQWgFJJ1vjy6rEDR5WBim3gCfu08Ct9vnhDl1OARJzAkJ57dNb
         s8JmXHSfwyQYa6CtaZgHr7ZPpd4JhofkRiTc3hBpqXZWRUi509gDtVtiwBpJCVDadk
         g+dHYXjtzfUWA==
Received: by mail-ot1-f46.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso12426172otu.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Aug 2021 06:17:36 -0700 (PDT)
X-Gm-Message-State: AOAM5336L7I47t+dripORLw5q0wREbhwbagHPDy6vAw2C8k7UmITW1nD
        RxgTUdAwIhy1Wg6t81Qh378thKtJO6DSwhdis3g=
X-Google-Smtp-Source: ABdhPJxTW1s9TJARu2SdPEgd2SBapTf2ARsBSjmo4rRZaLgfuYADUVOkjo4uCWcCpIldCyURFoxIjoc+eb7gWzhBmw0=
X-Received: by 2002:a9d:3e09:: with SMTP id a9mr2950861otd.87.1630415855767;
 Tue, 31 Aug 2021 06:17:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1bc6:0:0:0:0:0 with HTTP; Tue, 31 Aug 2021 06:17:35
 -0700 (PDT)
In-Reply-To: <20210831114358.GA26132@kili>
References: <20210831114358.GA26132@kili>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 31 Aug 2021 22:17:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9a+62SHSt9diCYnA7Gb+vEwH3AsKva4cbWa-02oFOj=w@mail.gmail.com>
Message-ID: <CAKYAXd9a+62SHSt9diCYnA7Gb+vEwH3AsKva4cbWa-02oFOj=w@mail.gmail.com>
Subject: Re: [bug report] cifsd: add file operations
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     namjae.jeon@samsung.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-08-31 20:43 GMT+09:00, Dan Carpenter <dan.carpenter@oracle.com>:
> Hello Namjae Jeon,
Hi Dan,

I will fix it.
Thanks for your report!
>
> The patch f44158485826: "cifsd: add file operations" from Mar 16,
> 2021, leads to the following
> Smatch static checker warning:
>
> 	fs/xattr.c:524 vfs_removexattr()
> 	warn: sleeping in atomic context
>
> fs/xattr.c
>     514
>     515 int
>     516 vfs_removexattr(struct user_namespace *mnt_userns, struct dentry
> *dentry,
>     517                 const char *name)
>     518 {
>     519         struct inode *inode = dentry->d_inode;
>     520         struct inode *delegated_inode = NULL;
>     521         int error;
>     522
>     523 retry_deleg:
> --> 524         inode_lock(inode);
>     525         error = __vfs_removexattr_locked(mnt_userns, dentry,
>     526                                          name, &delegated_inode);
>     527         inode_unlock(inode);
>     528
>     529         if (delegated_inode) {
>     530                 error = break_deleg_wait(&delegated_inode);
>     531                 if (!error)
>     532                         goto retry_deleg;
>     533         }
>     534
>     535         return error;
>     536 }
>
> The call tree is (slight edited).
>
> ksmbd_file_table_flush() <- disables preempt
> -> ksmbd_vfs_fsync()
>    -> ksmbd_fd_put()
>       -> __put_fd_final()
>          -> __ksmbd_close_fd()
>             -> __ksmbd_inode_close()
>                -> ksmbd_vfs_remove_xattr()
>                   -> vfs_removexattr()
>
> fs/ksmbd/vfs_cache.c
>    669  int ksmbd_file_table_flush(struct ksmbd_work *work)
>    670  {
>    671          struct ksmbd_file       *fp = NULL;
>    672          unsigned int            id;
>    673          int                     ret;
>    674
>    675          read_lock(&work->sess->file_table.lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Disables preemption.
>
>    676          idr_for_each_entry(work->sess->file_table.idr, fp, id) {
>    677                  ret = ksmbd_vfs_fsync(work, fp->volatile_id,
> KSMBD_NO_FID);
>    678                  if (ret)
>    679                          break;
>    680          }
>    681          read_unlock(&work->sess->file_table.lock);
>    682          return ret;
>    683  }
>
> Hopefully this bug report is clear why Smatch is complaining.  Let me
> know if you have any questions.
>
> regards,
> dan carpenter
>
