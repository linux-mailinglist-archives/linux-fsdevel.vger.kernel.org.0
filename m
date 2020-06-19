Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD928200A89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbgFSNpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732785AbgFSNpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:45:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F15C06174E;
        Fri, 19 Jun 2020 06:45:21 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s18so11288463ioe.2;
        Fri, 19 Jun 2020 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KbCMnQ3fWd4OCh5WOjleAHLA7RE7+a68TWER+fluSg=;
        b=RYAsabp67D/InlnPAiumJVkynZbAgsyRWv4Mx9DAozwizFjB3/C+cwmRYwLobjEppu
         XWfoPExMMTISzF0JO3JD+Ar/qKt30A38vOuCNYiYFKuO4K2shOkdLphM76VKwsZP278/
         bROUHjsEyd0yjTjSyaVI3QU56PW/2eYV7tmVCkJCQjxTVAQ1N84j4K8YB+ZWQM0rZLT1
         wvBmz/1UCukS4r5gRZbxtEN5sTHsQSNXjQES5a4B0wQbYgJgctrL9230vCWGdveOI8Bu
         UKvPuIrQAgTrxQJD7iv8fDot778pxeU8OXTeUgc+VmUpWieYaCHFtIKngEKGHKEbdG9O
         h6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KbCMnQ3fWd4OCh5WOjleAHLA7RE7+a68TWER+fluSg=;
        b=YJWUX0GTI7id8TgxSszwUVXnvv5QG8a12TRBpXDCYxSAY5PMSE7nAkenDtw6R4WLox
         I0lRpKexGHXYsmnmDGWzmbhdoZl/7BzrzZpiYex7S85DPzv7FOlz2wq4IvK0iGK9C+xQ
         QL55FyB42xPK4X/1uGt8Koiudr65Taah5gxB9osSoqVdV9LPxXXElIX88iwDwTpt+1ny
         ReNZhawkCZvdj3whsER0S91vgFESbfVB+kyK+ttw0j+HVsqDxqWQj9Usoa/iMHGoi/8K
         YlMPfw4HTHoI+I0r40nCcjUZqv//As0WXROE0UAJo2mIuCjNeGXsF5bVrpvpesyPpr/p
         o08w==
X-Gm-Message-State: AOAM532KhZePrV8JPeqHHquQPtwlGtkwr3Ino4yYrq1QSWK8bJe50viI
        f7JbptEBwhFhi65RZW/nRvhfNtVyaIZeshJv8/s=
X-Google-Smtp-Source: ABdhPJymf9lkb/99ztlOPnVqmjfseQ5wZThn/cprANDQ+siUR8wjgIkqr7UjfS+nJJstOGBrPuLNfd2PIePPHzrSZU8=
X-Received: by 2002:a05:6602:2e87:: with SMTP id m7mr4397605iow.203.1592574320698;
 Fri, 19 Jun 2020 06:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200617145310.GK3183@techsingularity.net>
In-Reply-To: <20200617145310.GK3183@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Jun 2020 16:45:09 +0300
Message-ID: <CAOQ4uxjdTUnA2ACQtyZ95QkTtH_zaKZEYLyok73yjrhuUyXmtg@mail.gmail.com>
Subject: Re: [PATCH] fs, pseudo: Do not update atime for pseudo inodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 5:53 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The kernel uses internal mounts created by kern_mount() and populated
> with files with no lookup path by alloc_file_pseudo() for a variety of
> reasons. An relevant example is anonymous pipes because every vfs_write
> also checks if atime needs to be updated even though it is unnecessary.
> Most of the relevant users for alloc_file_pseudo() either have no statfs
> helper or use simple_statfs which does not return st_atime. The closest

st_atime is returned by simple_getattr()

> proxy measure is the proc fd representations of such inodes which do not
> appear to change once they are created. This patch sets the S_NOATIME
> on inode->i_flags for inodes created by new_inode_pseudo() so that atime
> will not be updated.
>

new_inode() calls new_inode_pseudo() ...
You need to factor out a new helper.

Either you can provide callers analysis of all new_inode_pseudo() users
or use a new helper to set S_NOATIME and call it from the relevant users
(pipe, socket).

How about S_NOCMTIME while you are at it?
Doesn't file_update_time() show in profiling?
Is there a valid use case for updating c/mtime of anonymous socket/pipe?

Thanks,
Amir.
