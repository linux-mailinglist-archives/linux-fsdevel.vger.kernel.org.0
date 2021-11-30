Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74428462CD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 07:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhK3Gj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 01:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhK3Gj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:39:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88753C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:36:07 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w22so24749066ioa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcHar7fUcopRHKvodGdFYSkk7hdGc0gT9Jead6iyqW4=;
        b=hFlw95Dp4fe5BYxWmiszBkCGUKIvRCqOHYhtMvb+kgSrX/CVfUza26yIC4jPOcOubN
         Xbv1q6Qrs1WAokVsVw0JKMNy/Xfl/Z98Cg8XaIYNAiBgyK+bEPAAJ44P29haYCVMAc3J
         +T2t24P0YOg0X7tUtn0HoaU/TljX20hqt+U5eJ9KaZUdqCOk3+Hw4c7USLagltoaVltT
         hJxYPm6VD08RnOyeV5qHBcDLIQmVd17b6QxKonq9U+EFtQOAhC4ChzGIsfSbmkEvjZXb
         CoTE+3FtPjQe9Fm3dYaziTBAxitSunmttc0wbCaAC0vjPOKfiJ4paT+Qq457kVSVObo3
         etbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcHar7fUcopRHKvodGdFYSkk7hdGc0gT9Jead6iyqW4=;
        b=TEKbL9SOcVCa6VVNW05Ji0WRl1Cyw/0q/9rMROz4UV6HaQkdl3wsSKX3vopHwd5t8t
         ap3arHESMdNz10cqinXOunlza0FUAJrBphUJ2OLXtoj8YVl/n999/VyVuolTOu/SrexX
         rzhLR81jqwStWSZRmjaQXxTUG+FAFlu+mpNVLt9c5+N9gA/fIJNf+Us7wXRN6p+sVvcu
         HtPrhbd4X4AWjbnSV/skU4Dnk85SgvleUMk2Yc2W/s52RCAW3cFxFkb7Gqtn9W1Y8hxQ
         cWByKepZxhYRsd5oY6cTNN9emHV0GuBE0Q8HZutMVcIo+JrMmKNjxxuUQoNL2Lh/D5YU
         Z1qw==
X-Gm-Message-State: AOAM533Ow1CWAhPV5RvUPy68HIO5knBKvx9DRhQBbGDmlG9oSqisYV+a
        /q+2Q9ejbmmsfCKS7f3MkyyalaUfodbEjdwtZiTp9QRS
X-Google-Smtp-Source: ABdhPJw09ZfmgwT9Dn0moVdPa81u/bC6QBgwtq98eQuDf2rdWSOGNhOWsyxGppZDXfEvy9z+2oduSlklafs550gOjX4=
X-Received: by 2002:a05:6602:29c2:: with SMTP id z2mr58247941ioq.196.1638254166978;
 Mon, 29 Nov 2021 22:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org> <20211123114227.3124056-3-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-3-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 08:35:56 +0200
Message-ID: <CAOQ4uxi+3-OaZNrO2X3KawExE8PTvCkncDAsMQ8KL-UEhNwHLA@mail.gmail.com>
Subject: Re: [PATCH 02/10] fs: move mapping helpers
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 3:29 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> The low-level mapping helpers were so far crammed into fs.h. They are
> out of place there. The fs.h header should just contain the higher-level
> mapping helpers that interact directly with vfs objects such as struct
> super_block or struct inode and not the bare mapping helpers. Similarly,
> only vfs and specific fs code shall interact with low-level mapping
> helpers. And so they won't be made accessible automatically through
> regular {g,u}id helpers.
>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/linux/fs.h          |  91 +-------------------------------
>  include/linux/mnt_mapping.h | 101 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 90 deletions(-)
>  create mode 100644 include/linux/mnt_mapping.h
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 192242476b2b..eb69e8b035fa 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -41,6 +41,7 @@
>  #include <linux/stddef.h>
>  #include <linux/mount.h>
>  #include <linux/cred.h>
> +#include <linux/mnt_mapping.h>

If I grepped correctly, there are ~20 files that use these helpers.
Please put the include in those files, so changes to this header
will not compile the world.

And how about mnt_idmapping.h or idmapped_mnt.h?
Not sure if this naming issue was discussed already.

Thanks,
Amir.
