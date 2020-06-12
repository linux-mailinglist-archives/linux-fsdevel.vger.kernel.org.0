Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED5C1F76B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 12:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFLKZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFLKZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:25:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA4DC03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 03:25:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i25so9709479iog.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgfb9/APGf2+Oie6MjGGkgG6uoI2dSd2lpbzjHkf+iw=;
        b=EkOQ07z+Efpy121uU3t/6VqNLEevWU4CNjWNjJzytrg4NEc8E0s5RhN007zb/V3knq
         9DtEDEFSgn0Sm7OA3ym6EkbtTu1048TZjbMfNv3k8eB/qehCYj4+9kcIX/eaIHGrKCS4
         MqSroomDpQV0DXIjWEyzSxDqNi+Ije3QcJVW5Uk1rKpmFMFdSKWJVE01JRzjNaKRPxMi
         5SvzWKNR4jzsfjz9nNtTxTOl291N+fXk5jiqG/N4XuQEhZkDO/WeT8e+8/2B9i2MA0jp
         JZTBVdI/u8bEW5CKN76zkXUVGetAhjQO23Iommo48ooaLF8F3+VmrSDYLaJAQQFB2lJC
         4nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgfb9/APGf2+Oie6MjGGkgG6uoI2dSd2lpbzjHkf+iw=;
        b=t2FzLiDSSMb0vr9xYGcdLIq6nK54+fM4rjs20YOuliYyWExHF6m8uqI04ZfNTIBSdQ
         RWPt127xMbMdNqtuVOGeCTGisqGyGnziqf0rSfg5D1J9M9B3lMPxT9v2WQd5UtsdD+KI
         pNHaT5oNK7R5TlCDptp7h6sDx4pJ/iOxAT7VAhtJUCS6OoqBGJumzZqFYLibvIBEnNRO
         CWQwI4z417S157j2X/m5gOrYyy1YjhVeYFyhxhnyhc+/WSzunFjq4U16UjgvY5HSNbfl
         jOrGd7RVeQhqeZBm2sZx94w9mdbYDlTUpmIHJ388fGEz5lac5Be2OV78BhBgYxVQL2jw
         Y5VQ==
X-Gm-Message-State: AOAM530o73/F7RQlbIjcwcS3W4x+veHa4KwEf/5rYGp1buznVMnnE7ao
        88w72Gpo2BrMJRFAwl1lyf3A9fafIqwOQH2OEV4=
X-Google-Smtp-Source: ABdhPJxL8SeOA0WDxIlUkLbQ8mg531AE0nJyV2T/T1rf4Dr0kaRmkCXJK/8Hy+/jGRuos7Qn7WMueupM/HLaeqxMXVM=
X-Received: by 2002:a05:6602:5c8:: with SMTP id w8mr12896264iox.64.1591957535789;
 Fri, 12 Jun 2020 03:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200612093343.5669-1-amir73il@gmail.com> <20200612093343.5669-5-amir73il@gmail.com>
In-Reply-To: <20200612093343.5669-5-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Jun 2020 13:25:24 +0300
Message-ID: <CAOQ4uxjBP9f0beYi_UpHC-1k5dQSEcdaiF3aAfHzeoeZ0=GYdA@mail.gmail.com>
Subject: Re: [PATCH 04/20] nfsd: use fsnotify_data_inode() to get the unlinked inode
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> The inode argument to handle_event() is about to become obsolete.


> Return non const inode pointer from fsnotify_data_inode(), fsnotify
> hooks do not pass const inode pointer as data.

Sorry, this sentence is leftover from before I split this patch.

>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/filecache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 82198d747c4c..ace8e5c30952 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -599,11 +599,13 @@ static struct notifier_block nfsd_file_lease_notifier = {
>
>  static int
>  nfsd_file_fsnotify_handle_event(struct fsnotify_group *group,
> -                               struct inode *inode,
> +                               struct inode *to_tell,
>                                 u32 mask, const void *data, int data_type,
>                                 const struct qstr *file_name, u32 cookie,
>                                 struct fsnotify_iter_info *iter_info)
>  {
> +       struct inode *inode = fsnotify_data_inode(data, data_type);
> +
>         trace_nfsd_file_fsnotify_handle_event(inode, mask);
>
>         /* Should be no marks on non-regular files */
> --
> 2.17.1
>
