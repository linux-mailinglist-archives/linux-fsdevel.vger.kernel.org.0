Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5021F7AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGNQuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgGNQuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:50:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1AC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 09:50:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so23711750ljn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dG7FA7iDSIWnXeiGt3K6ODixwTg6YeYMJpgbEySOgvU=;
        b=R5vk5y4+TZQXz2QtyjTQ5Zn8WHBr1gqVTWqRwg+UYo0TaI0LkhKP30WVBRyqDQJ1xD
         k3OlvwAEp6EL86KzHrE+CtDXddwMtGtzzsYvqDpHrAxh/3rVwXsrZikUvryvleK3pBC5
         KI9h8s006nwI9a2IBwYbbkxi8Uh4BVHh556TJ5YDceshyU8ht5Oejn40eSR8ptAQ/vhk
         0NFF19rMP/pmtQFBtTB7HaQLuQzcVUKsQ++Y7OSSFN0O3/Z3ta6avdJjD0EmB+lbSKMI
         TjA+49nqRBQSjSb6OG1fhA8hmgfIdz+Cd16VVDPQbTPw92hPeZKYYRmIQ+UJr7bonGSu
         SthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dG7FA7iDSIWnXeiGt3K6ODixwTg6YeYMJpgbEySOgvU=;
        b=G1O1hOcQZXrCuH7fUD7PJ5oZN7mJArsD6Cbt2LYvHj6xqCcGYRuaPwKOk/+ban4xTh
         n8YTn2j2ur+W3daiGB8PLPi5Ju2GI580rqRbHDs+wIXKDYU1mBWShefCwU7FexvTDM1r
         POKUjhAzXPG2fIJpWY74Z0RGD5t/j6XqDTYFbziKqMTFTD4tIJz0h7uFajofKIapgTAK
         Ms1OZKXES1rnpZR5rpDGMsFQjoBv93d9ZKg9yctNnC5B+YYTCJfA8AwvhBY1jls0sQBT
         pbeIaWwqdniYYiBK0cWcOEs9hzcZFOnTrIRS+vTaGGSQOaTl9ISP3rHHYyrvB46hkNLt
         rWLA==
X-Gm-Message-State: AOAM5319lsuZsZhHTiu0a3btZV3gOQkrVUxDjkfWz9g8+CcEQaTGsIW2
        7HbumwGYgXuY4mVaSN8GhzTSqg0EDvvlNezuN+2uVmvd
X-Google-Smtp-Source: ABdhPJx81doPrro1bqy5wsunMqncB7CNTiXI9D7TmBuGV1FhagfTlWt0NoFPA1DCBaWcOBbJzvhBR0vjJ2mBf5LMAY0=
X-Received: by 2002:a2e:9251:: with SMTP id v17mr2564999ljg.138.1594745408013;
 Tue, 14 Jul 2020 09:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com> <20200714161415.3886463-3-christian.brauner@ubuntu.com>
In-Reply-To: <20200714161415.3886463-3-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 14 Jul 2020 18:49:41 +0200
Message-ID: <CAG48ez3fTQMEU71C91pGOUbSnFkMsCXOM26kLHB7-0vG423tDw@mail.gmail.com>
Subject: Re: [PATCH 1/4] namespace: take lock_mount_hash() directly when
 changing flags
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 6:16 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Changing mount options always ends up taking lock_mount_hash() but when
> MNT_READONLY is requested and neither the mount nor the superblock are
> not already MNT_READONLY we end up taking the lock, dropping it, and
> retaking it to change the other mount attributes. Instead of this,
> acquire the lock once when changing mount properties. This simplifies
> the locking in these codepath, makes them easier to reason about and
> avoids having to reacquire the lock right after dropping it.
[...]
> diff --git a/fs/namespace.c b/fs/namespace.c
[...]
> @@ -463,7 +463,6 @@ static int mnt_make_readonly(struct mount *mnt)
>  {
>         int ret = 0;
>
> -       lock_mount_hash();
>         mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
>         /*
>          * After storing MNT_WRITE_HOLD, we'll read the counters. This store
> @@ -497,15 +496,12 @@ static int mnt_make_readonly(struct mount *mnt)
>          */
>         smp_wmb();
>         mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
> -       unlock_mount_hash();
>         return ret;
>  }

It might be a good idea, instead of completely removing the locking
calls here, to replace them with lockdep_assert_held(...).
(Currently that doesn't appear much in core VFS code though.)
