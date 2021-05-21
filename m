Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9B38C32E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhEUJd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhEUJd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:33:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9BC061574;
        Fri, 21 May 2021 02:32:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a8so11383054ioa.12;
        Fri, 21 May 2021 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7LkhPpEORqK/nnRA8Qix7JZmmdruW/Bq5UIaWgpnIs=;
        b=vAECmQkceUjYnJoPXBXnAWbWwhJUqMABVVFatFF4f4mU+rLF+td6UrL098kuLjToSm
         XvQ2ObZl2ckM3ZNetI+357BsZO7npFJ05fMTQ134VlH0CbDizcHIKcVKnTMLX1fHApsB
         roVVIU76/ECBnXRFe/IPr8osYbiZOc7eat0KgYcYLQB2J/S84uiMTWCoMBNAA3/CiTgH
         rcNrS9BLTRvsb+cbjXaGId9Hx3h1QRS2qpZADoEf5s2FtXEjilyDpF+TXTQvlwX77YSM
         i712aiD0AKz7l02ic7aoqwI4KGNZPMgVeo28SsdnNvK+y94xOK43ARbQSsR2QOzTGT0F
         QUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7LkhPpEORqK/nnRA8Qix7JZmmdruW/Bq5UIaWgpnIs=;
        b=MvwG6JAsxso+NQVITYOZW3KRXKpVu8ICVKiUcvMLrssXagoTqdNfh6vYlssF4qsfwe
         nF6bUq5iVH/cV+lPKrcP4Yo11R/IrSU+vAKvPds7ZBkYGnCkgjAaj2CR94U/mQ+WIwkw
         FdGlgAf/MjnF1xvs3nDOMUP0AA/wLHhyayGZNUi0BuliyucY6yw9/crZnR9Ft1lKvMaC
         8EXSZWP/ioYaVB8NvTABnHoZYjwbpgTROvLJB/4T+Iqt1Hg2GN0eu3LOoAxYCd3HOUgM
         dHX19MtMUrnmZ214SxPtMGnCHqf8R10XAWIg4jNM5aeOJh9ZSNx9B7bg/wur0qKQGlPn
         VHUw==
X-Gm-Message-State: AOAM531xnIPiKruY36MjV2U5ODUiVz7qBXZRejQWiHbrQuMpdObt3YF7
        cDwXr2jfugH3CU2pWvtSgq2nvlmNak/I/XkK3Dg=
X-Google-Smtp-Source: ABdhPJyyuH0dGzJzjXOJzGf54P6Ie0Jo+R4PtQ2hv3GfnMS061EvMT1QS0VSMQ5pibySTQucV4b5xZoyD8TSlipAePo=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr9502151ioa.64.1621589553300;
 Fri, 21 May 2021 02:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-8-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-8-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:32:22 +0300
Message-ID: <CAOQ4uxi+xE7Obh8k=hpcf4eJcPrY2DKw1x-2+xe+ta7rvm5zZQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] fsnotify: Introduce helpers to send error_events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>

Some maintainers are very strict about empty commit description...

> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v2:
>   - Use the inode argument (Amir)
> ---
>  include/linux/fsnotify.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..458e4feb5fe1 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -317,4 +317,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>                 fsnotify_dentry(dentry, mask);
>  }
>
> +static inline void fsnotify_error_event(struct super_block *sb, struct inode *inode,
> +                                       int error)

The _event in the helper name is inconsistent with the rest of the helpers.
I would go with fsnotify_sb_error(), especially if you agree with me about
allowing FAN_ERROR only on sb marks.
I would also consider FAN_FS_ERROR (?) to reduce ambiguity in the future
with FAN_WB_ERROR.

> +{
> +       if (sb->s_fsnotify_marks) {
> +               struct fs_error_report report = {
> +                       .error = error,
> +                       .inode = inode,
> +               };
> +               fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR, NULL, NULL,
> +                        sb->s_root->d_inode, 0);

This is a bit hacky.
It *may* be acceptable if we allow FAN_ERROR only for sb marks, but if we
allow to set them on inode marks, this is wrong, because it will only report
events for all inodes only to an inode mark that was set on the root inode.

If you want a clean solution:
1) Take this cleanup patch from [1]
    "fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info"
2) Add sb field to fsnotify_event_info
3) In fsnotify() do not assume that inode is non-NULL:
-       struct super_block *sb;
+       struct inode *inode = event_info->inode;
+       struct super_block *sb = event_info->sb ?: inode->i_sb;

There are too many args to fsnotify() already, so the cleanup patch
is due anyway.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_idmapped
