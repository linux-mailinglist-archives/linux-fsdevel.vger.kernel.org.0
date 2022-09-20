Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F95BE091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiITIo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiITIoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:44:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E6DE58
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:44:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so4432407ejy.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vYIKLpyMYWCXxCxxTzLwfEopWLK9RUWBLjkEV2OAxIw=;
        b=G7uWEdiryAwABC9D7CwOcwx7mvIl5FCMgFQAQAclbimVjKSRq1qXHVMgkUmKDADpOn
         uY80Yx7RtxRmMfex1CL+CBJk3LMK4vjXANOKh5L5zOnHfvo+VhjTeOLuLqt84D8R6TRN
         WLnI9w33WHxUOcFuCAJTmlQsaapyMubi3KYaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vYIKLpyMYWCXxCxxTzLwfEopWLK9RUWBLjkEV2OAxIw=;
        b=3e4gdSQ7R1Y1plrtj1u0sJp/RtNsB98SJWD2WpZVfO76lO+TOdB6mM6LoHe6q+Mctz
         D+M6tmyul6hrs/GgV+4nl5lucyDNh02wYK1mqBiI2roRctkB9Pgp4qieOjLjIZa4cJZK
         /yiSrTgnDnDb1ENfYl3qe+qp5fDK9lXrwn1p3lnQZVbr+3iw1pnvuoj+lFsNI4SmAnL+
         SbYeIHBoowuIWEBTFRKKgA1Q0TxWvZ/6J2cyhmxhBbzrY/I1fadZWLwE8ROT0EJtuXHJ
         gzE/yKBDrGpG1CQeV1weBYpLiQ9Yt1m54J0TC3o1/t+O2H/qFk+syHA3e48697v/fLi4
         HS+A==
X-Gm-Message-State: ACrzQf2VFV5b36CYDxOQM8VhQxqRelj0tgLq48odlwLcpnf6rNNB6kfM
        oATtSBtpJnhZNfZi9EO/49asJUtI42XANkCOLXFgMw==
X-Google-Smtp-Source: AMsMyM68+MOzShF8DfaKSXasEhmBNNNuQi5txuvKws9TxWFiQ6KpAOgB8SRsLvCGsqZ97nzTtcknlSrbZzQJklLLYcE=
X-Received: by 2002:a17:907:97d1:b0:780:26c9:1499 with SMTP id
 js17-20020a17090797d100b0078026c91499mr15497250ejc.371.1663663464179; Tue, 20
 Sep 2022 01:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220919141031.1834447-1-mszeredi@redhat.com> <20220919141031.1834447-8-mszeredi@redhat.com>
 <YykcfkzECotV882O@ZenIV>
In-Reply-To: <YykcfkzECotV882O@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Sep 2022 10:44:13 +0200
Message-ID: <CAJfpegvaqOX_oYNrN10cARik6pGucAu4E_bia+0CjHwKMN8Jcg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] vfs: open inside ->tmpfile()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Sept 2022 at 03:51, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Sep 19, 2022 at 04:10:30PM +0200, Miklos Szeredi wrote:
> > This is in preparation for adding tmpfile support to fuse, which requires
> > that the tmpfile creation and opening are done as a single operation.
> >
> > Replace the 'struct dentry *' argument of i_op->tmpfile with
> > 'struct file *'.
> >
> > Call finish_open_simple() as the last thing in ->tmpfile() instances (may be
> > omitted in the error case).
> >
> > Change d_tmpfile() argument to 'struct file *' as well to make callers more
> > readable.
>
> It really needs to add to Documentation/filesystems/porting.

OK.  Also updated signature and description in locking.rst and vfs.rst.

> I would prefer to separate tmpfile from mknod in that one.  And to hell
> with the last argument in do_hugetlbfs_mknod().  Something like (completely
> untested) patch below as prereq:
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f7a5b5124d8a..0b458beb318c 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -885,33 +885,18 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>  /*
>   * File creation. Allocate an inode, and we're done..
>   */
> -static int do_hugetlbfs_mknod(struct inode *dir,
> -                       struct dentry *dentry,
> -                       umode_t mode,
> -                       dev_t dev,
> -                       bool tmpfile)
> +static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> +                          struct dentry *dentry, umode_t mode, dev_t dev)
>  {
>         struct inode *inode;
> -       int error = -ENOSPC;
>
>         inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
> -       if (inode) {
> -               dir->i_ctime = dir->i_mtime = current_time(dir);
> -               if (tmpfile) {
> -                       d_tmpfile(dentry, inode);
> -               } else {
> -                       d_instantiate(dentry, inode);
> -                       dget(dentry);/* Extra count - pin the dentry in core */
> -               }
> -               error = 0;
> -       }
> -       return error;
> -}
> -
> -static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> -                          struct dentry *dentry, umode_t mode, dev_t dev)
> -{
> -       return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
> +       if (!inode)
> +               return -ENOSPC;
> +       dir->i_ctime = dir->i_mtime = current_time(dir);
> +       d_instantiate(dentry, inode);
> +       dget(dentry);/* Extra count - pin the dentry in core */
> +       return 0;
>  }
>
>  static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> @@ -935,7 +920,14 @@ static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
>                              struct inode *dir, struct dentry *dentry,
>                              umode_t mode)
>  {
> -       return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
> +       struct inode *inode;
> +
> +       inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
> +       if (!inode)
> +               return -ENOSPC;
> +       dir->i_ctime = dir->i_mtime = current_time(dir);
> +       d_tmpfile(dentry, inode);
> +       return 0;
>  }
>
>  static int hugetlbfs_symlink(struct user_namespace *mnt_userns,

Added with your authorship and signoff.

Thanks,
Miklos
