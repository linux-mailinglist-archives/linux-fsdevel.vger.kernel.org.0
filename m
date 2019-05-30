Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11C2F75F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 08:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE3GGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 02:06:35 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33952 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3GGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 02:06:34 -0400
Received: by mail-yb1-f193.google.com with SMTP id x32so1755965ybh.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 23:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAf8SH7b3stuTdNYPUq639K5r4H3CO1j4iU/DKt0eNw=;
        b=ewpu1A6CXzK5A4J3dvQ/CPsIXW73BMT1v11jmo2f8MwMvb+FQs8pJAUFflw7MkygrV
         xS9OoxFgCE+U/cfMSNE/k2Ld/kBsvmHAV7N2CE8phyfoFIll1j03LnN1bFy3F09+z3Ks
         Nx31MQ6jxLryakjiAFfjz5CTXyVxHQQvyM5/q0pb1tRx4DizUiXCFVhEbshRQsU9b3h1
         yuDmDCH3ziMdfQVBBDJSn4trybp6HMLlakmTCupVp7vkHYw+n4GvxhFVpucjEF7sg5Bq
         NKgwA/evl5zkiViVv8jkgB9mEBE7zzvsNZBNGTyD0TiJ9cLDPxA+uOJ1mkymY8+EL8yg
         KH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAf8SH7b3stuTdNYPUq639K5r4H3CO1j4iU/DKt0eNw=;
        b=FncU/aS5XrsVF1ccAET+MbQDhfno3myoad12MkD0baOcO2fWPizE6Te6F8bHOSy3FH
         6a+Q+h6BQRxKrDg2k3GEfWuutRBfBBLdquKsGlczTSZ8B9GOvVlaNAabGGctz4Y62WFI
         Oc6B75veEIyvqVJ5kJWSYl6zD3565nCW4Dfh5RmvoDsx29BdH/+YpW/dPN7K1GQ14BUx
         VhF29UL2feujcC2+2thYJ7IsNLck5AVlKah46ZuywwVV9sgy+wWJnqWbBAEHRxwo7sij
         PoRIGJqtN/vNAPv5eS+L3E9qszbFI0dEEtljyKgcx/1c278fZ4Qt+RW/16JdYe/PYALK
         DGAg==
X-Gm-Message-State: APjAAAVDHWuLa0/f8rmUrQpQMi6yWyOanODNi77sUUbyxrXETi8e84i2
        9Dvd75QXdpuJI/yWrYrfOInZAIqu451X5sAQBwE=
X-Google-Smtp-Source: APXvYqwWNbXDTf7sRGu6CKqQm3sUdruEg8gUmPIzHPwRmPsAAOM9RBuAEtMWepFEp80ynVnMZ84VNXvMKj/nNvGfMBI=
X-Received: by 2002:a25:4489:: with SMTP id r131mr732253yba.14.1559196394022;
 Wed, 29 May 2019 23:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190526143411.11244-9-amir73il@gmail.com>
In-Reply-To: <20190526143411.11244-9-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 May 2019 09:06:22 +0300
Message-ID: <CAOQ4uxi+1xQW5eoH7r18DHjvQQyKeMGq2Qtbe1hcxtcmqA_hAg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] configfs: call fsnotify_rmdir() hook
To:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>
Cc:     David Sterba <dsterba@suse.com>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
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

On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> This will allow generating fsnotify delete events on unregister
> of group/subsystem after the fsnotify_nameremove() hook is removed
> from d_delete().
>
> The rest of the d_delete() calls from this filesystem are either
> called recursively from within debugfs_unregister_{group,subsystem},
> called from a vfs function that already has delete hooks or are
> called from shutdown/cleanup code.
>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>

Hi Christoph and Joel,

Per Christoph's request, I cc'ed you guys on the entire patch series
for context,
so my discussion with Greg [1] about the special status of configfs in
this patch set
should already be somewhere in your mailboxes...

Could I ask you to provide an ACK on this patch and on the chosen
policy. To recap:
Before patch set:
1. User gets create/delete events when files/dirs created/removed via vfs_*()
2. User does *not* get create events when files/dirs created via
debugfs_register_*()
3. User *does* get delete events when files/dirs removed via
debugfs_unregister_*()

After patch set:
1. No change
2. No change
3. User will get delete events only on the root group/subsystem dir
when tree is removed via debugfs_unregister_*()

For symmetry, we could also add create events for  root group/subsystem dir
when tree is created via debugfs_unregister_*(), but that would be a
followup patch.
For users though, it may be that delete events are more important than
create events
(i.e. for user cleanup tasks).

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjyg5AVPrcR4bPm4zMY9BKmgV8g7TAuH--cfKNJv8pRYQ@mail.gmail.com/

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/configfs/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 5e7932d668ab..ba17881a8d84 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -27,6 +27,7 @@
>  #undef DEBUG
>
>  #include <linux/fs.h>
> +#include <linux/fsnotify.h>
>  #include <linux/mount.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -1804,6 +1805,7 @@ void configfs_unregister_group(struct config_group *group)
>         configfs_detach_group(&group->cg_item);
>         d_inode(dentry)->i_flags |= S_DEAD;
>         dont_mount(dentry);
> +       fsnotify_rmdir(d_inode(parent), dentry);
>         d_delete(dentry);
>         inode_unlock(d_inode(parent));
>
> @@ -1932,6 +1934,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>         configfs_detach_group(&group->cg_item);
>         d_inode(dentry)->i_flags |= S_DEAD;
>         dont_mount(dentry);
> +       fsnotify_rmdir(d_inode(root), dentry);
>         inode_unlock(d_inode(dentry));
>
>         d_delete(dentry);
> --
> 2.17.1
>
