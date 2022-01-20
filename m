Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C01494AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 10:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359533AbiATJ2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 04:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359532AbiATJ2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:28:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72DC061574;
        Thu, 20 Jan 2022 01:28:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z22so25820609edd.12;
        Thu, 20 Jan 2022 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xI2hjvF9QTy4qeUkVgaLn/r0k38qP5qMUW5kFpgn8cU=;
        b=aI2x5RhX2hh/tGP+a92b/dfubNDO5fhTRlSNlwpOyyT1umGfCiPQePIxdF0Op14ug0
         XSAmli/b4t6S6U4Mf5GXRVU3E+KuSCtJPdoHejK64AmYFtw8K5GMM/MeEUiSKFc9srAl
         SlGFM0zxQthDSCoKwtC4f5vTyQ9dVvrCzVti6aLJ93dkm0Hpn1ek3mtpkKuN+G/7+Tyb
         eWp5luyPOAcDlLl36glvvsYm79qfhlVe/3UX10Gho1q0uubNQ3AfUhwAzUCRRtO8+EL3
         YF8uwflxnpMQ6plfkdAa+eI4RrvJhR4LEMlCH8aC2TA7htHd/wUmsRHn/V/ln57c7dOW
         4t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xI2hjvF9QTy4qeUkVgaLn/r0k38qP5qMUW5kFpgn8cU=;
        b=IwNmcWW34k9OswqCZTv5b/3ESewFL9ifhlSVPlpV8lpNWcqHSUJVv7aJVdPk02Ljty
         Vw6v3zJDSkeElLW/7Lg7MUIEsSQmbg30h7Fg7AE9/VsLiQZPVlgEQhHMxjHt1pP0V0VL
         yq/g8Yf7paSb2JR+ChYxd83GkKhKrGFJaxt7AYCTXIoiQGc+BW2qxSNT07+SJ8U7iXLv
         XndblhVxHlXlKQwP2jOdZwyV+HgeqQV5Ag5SKGnoR5iar1pvyqi5XRY+BT4MNrxIoyCT
         IbUEGC0d6ttGxsJazoZr2eiSRWkwOns4GF4qVTQ5pHxCxScXZ+UrVb4/ZMXTB6IGOsQ8
         rMNg==
X-Gm-Message-State: AOAM532nqO7wT/+Mr1M0s6Z9SsCu+8D0KjxB/3mwuQFLJ/gmVCTxOWqZ
        b1dMa7iw425k39xvSdJ4exqjT+K9xNrBZtMjWCIuNK8Svy4Uxw==
X-Google-Smtp-Source: ABdhPJwuxrqyAkpBzpTeZzlfnn6LGo2LitiLvI7m8TfC8LkdCV8tI2az6AWpg4xCckCJbPz3b27c8Cb00O0A31YVGKA=
X-Received: by 2002:a17:906:2b8a:: with SMTP id m10mr27831650ejg.479.1642670929710;
 Thu, 20 Jan 2022 01:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20211011030956.2459172-1-mudongliangabcd@gmail.com>
In-Reply-To: <20211011030956.2459172-1-mudongliangabcd@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 20 Jan 2022 17:28:23 +0800
Message-ID: <CAD-N9QXHwzt9Dui3i6sFF-4d-8Z41LoOJydPykdQQh_jWh+_SA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix GPF in nilfs_mdt_destroy
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:10 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> In alloc_inode, inode_init_always could return -NOMEM if
> security_inode_alloc fails. In its error handling, i_callback and
> nilfs_free_inode will be called. However, because inode->i_private is
> not initialized due to the failure of security_inode_alloc, the function
> nilfs_is_metadata_file_inode can return true and nilfs_mdt_destroy will
> be executed to lead to GPF bug.
>
> Fix this bug by moving the assignment of inode->i_private before
> security_inode_alloc.
>

ping?

> BTW, this bug is triggered by fault injection in the syzkaller.
>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index ed0cab8a32db..f6fce84bf550 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -160,6 +160,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>         inode->i_dir_seq = 0;
>         inode->i_rdev = 0;
>         inode->dirtied_when = 0;
> +       inode->i_private = NULL;
>
>  #ifdef CONFIG_CGROUP_WRITEBACK
>         inode->i_wb_frn_winner = 0;
> @@ -194,7 +195,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>         lockdep_set_class_and_name(&mapping->invalidate_lock,
>                                    &sb->s_type->invalidate_lock_key,
>                                    "mapping.invalidate_lock");
> -       inode->i_private = NULL;
>         inode->i_mapping = mapping;
>         INIT_HLIST_HEAD(&inode->i_dentry);      /* buggered by rcu freeing */
>  #ifdef CONFIG_FS_POSIX_ACL
> --
> 2.25.1
>
