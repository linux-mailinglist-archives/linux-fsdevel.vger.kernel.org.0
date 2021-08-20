Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA743F2525
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 05:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbhHTDI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 23:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbhHTDI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:08:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9164C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 20:08:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso12796785pjh.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=th+3o8zziVHjvxzUP987Ww05j4TcgD1JnSG4koxybv0=;
        b=q6wVy4gsAMeGwkQk1GUOlCv3RL83jjFdSVgzVK6FKAVlTxnluo0nxdXMv090oS+6v5
         g/bsuD3TnVs6GjejENx6Ypc13QJi/TkgLHU9+HcG4DHRHbsowvEEqntPZXYalrUu+j31
         syDAnCHyvx3HduCFB+iILfPCIv+IleAOlCNuCLhbaR1BW+2UQ0tOrUKFxEdC+UO92K1/
         4QLTyL7EAEUhfv9vEPkShzVSM6rjyvX4GxezOP/i3Yoj+vduXuzI5RGoQbgTNemm6050
         3oyP1/6v7jPKCnfIP9AKLiBGwOOTQxTStdJIfOldCpt5V13LoApTXFCa0YTEXgvKOvuY
         g4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th+3o8zziVHjvxzUP987Ww05j4TcgD1JnSG4koxybv0=;
        b=F4+uhquyX6b4aaw1yu0hJ9VR0eez/yPsIkkWpHcgSd6u1yvd06CDzMfEhpV5ymYnxB
         RrbiJO+2YrSM7qPhJMD6FF4L8xD5yhNDzeF0OnUulPzi1chqgu3IAfuffPu/+t1AEU2E
         yhvP2GIQYl0Op6YSUHy4xNIithtDrIQ3zkUfjD7lFwpl2kSZrVSejME7Nd/CkxkMgvEC
         qxdKSevkCc0Wb1Nu1zOv+LqYPBSmVlcltrOgldEfbSCRUIg9H7AVhZsbXZwleIMV7BZh
         9livphjOdFeXV/WBSmW0sNzVkpUQWNwRnNSataiNzgljVaw2d87RKnzHS++hwAufrs8X
         DWHg==
X-Gm-Message-State: AOAM531x+0yNyWxvl7RX1+TeoR1WimJAUEhw2dQX0pyPvghPQz3PLp1A
        a5HgYNVICGEyxiq7wmtLxNJi48dIbfpFsXBQrFwlPQ==
X-Google-Smtp-Source: ABdhPJzbHC0+k8uuKZo5a6LFCnA40ZeG97Zg4M+zrZCKnhkWtnjKBCnLq4cagjtK6xI7c9K//8I6Ath0AByLrXcFmCU=
X-Received: by 2002:a17:902:e54e:b0:12d:cca1:2c1f with SMTP id
 n14-20020a170902e54e00b0012dcca12c1fmr14381234plf.79.1629428900343; Thu, 19
 Aug 2021 20:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com> <20210816060359.1442450-9-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210816060359.1442450-9-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 20:08:09 -0700
Message-ID: <CAPcyv4gsak1B3Y0xFvNn+oFBCM2DonsyHQj=ASE2_95n6yfpWQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] fs/xfs: Add dax dedupe support
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 15, 2021 at 11:05 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
> who are going to be deduped.  After that, call compare range function
> only when files are both DAX or not.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_file.c    |  2 +-
>  fs/xfs/xfs_inode.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_inode.h   |  1 +
>  fs/xfs/xfs_reflink.c |  4 ++--
>  4 files changed, 61 insertions(+), 3 deletions(-)
[..]
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 13e461cf2055..86c737c2baeb 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1327,8 +1327,8 @@ xfs_reflink_remap_prep(
>         if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
>                 goto out_unlock;
>
> -       /* Don't share DAX file data for now. */
> -       if (IS_DAX(inode_in) || IS_DAX(inode_out))
> +       /* Don't share DAX file data with non-DAX file. */
> +       if (IS_DAX(inode_in) != IS_DAX(inode_out))
>                 goto out_unlock;

What if you have 2 DAX inodes sharing data and one is flipped to
non-DAX? Does that operation need to first go undo all sharing?
