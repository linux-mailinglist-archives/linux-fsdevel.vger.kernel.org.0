Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC1F3A42B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 15:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFKNKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 09:10:19 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:44782 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKNKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:10:17 -0400
Received: by mail-ua1-f49.google.com with SMTP id 68so2537751uao.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dx7GSd7iO7rvrKTCA9ogAPIg0Js8UGiEJvwjK+2gj2E=;
        b=NUltRQ+kEMueiFZrkAI1RyPxI037UoOyBgAWAd6gcdZ2j+K8v9cJlDMq+yS9UtwnJ3
         EAKCrAyHcVmEhH+75eyUO4RHk2+ONa9gGNpdTWoeNrtGbHE+L/swWqbccaSUbagssJUz
         yb3lco4g4ZRvwZK117eTEPuYhtCR/vWKec8pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dx7GSd7iO7rvrKTCA9ogAPIg0Js8UGiEJvwjK+2gj2E=;
        b=OMVbzXY+kVQb26rAjSa2jp9pJbi4ueyFyOY8I0IpFoKCB6QWQFzYNkHwsAeclMPfcE
         807J9zQwj6ADzdxapLw1iw1O1SxCvjwJGYF4053Z+UHlY+8ebEIsYb8aJn5/ORGiv3wz
         y4ljif/LiW3tf7AhEcj6szrodpIvu0fjpz1eYLh6NqQY3fdobA8BfaTQEzSlMu8K6beA
         OoWPXwqbmXCEf2UfPwRaEji3E/IjOu33XUw59M+Ugpzlf1I3OAqY+ULHB1dtqoHjVohu
         IDBlgC5agq7LxkdwfnnGzE1O7zJXDDfirfh3Vewz4c/XpNVkPwI7oF2UkT3OAxxkuyuY
         P7MQ==
X-Gm-Message-State: AOAM530lreVHFAOYkJsyAqk4p/vjv8c/9HwaisFoVSO+re4dd9oVpPX+
        S3CwQjvo4t6o0etJrbQoBi5UkHefjwtKbXa8GqQYTg==
X-Google-Smtp-Source: ABdhPJxxzILXhrd0KRKpv9gqkYrgqyWPjvEPh6iwM/jASpg6T1gwwSF3HH0OmG0kQdbqBdbVNiqfYEeyEb49pBnO/gM=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr2871941uap.13.1623416839332;
 Fri, 11 Jun 2021 06:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
In-Reply-To: <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 15:07:08 +0200
Message-ID: <CAJfpegunvr-0b1SW2FDNRdaExr=A9OFH1K-g7d0+UiS+9j5V_w@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 10:50, Ian Kent <raven@themaw.net> wrote:
>
> If there are many lookups for non-existent paths these negative lookups
> can lead to a lot of overhead during path walks.
>
> The VFS allows dentries to be created as negative and hashed, and caches
> them so they can be used to reduce the fairly high overhead alloc/free
> cycle that occurs during these lookups.
>
> Use the kernfs node parent revision to identify if a change has been
> made to the containing directory so that the negative dentry can be
> discarded and the lookup redone.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |   52 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index b3d1bc0f317d0..4f037456a8e17 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1039,9 +1039,28 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> -       /* Always perform fresh lookup for negatives */
> -       if (d_really_is_negative(dentry))
> -               goto out_bad_unlocked;
> +       /* Negative hashed dentry? */
> +       if (d_really_is_negative(dentry)) {
> +               struct dentry *d_parent = dget_parent(dentry);
> +               struct kernfs_node *parent;
> +
> +               /* If the kernfs parent node has changed discard and
> +                * proceed to ->lookup.
> +                */
> +               parent = kernfs_dentry_node(d_parent);
> +               if (parent) {
> +                       if (kernfs_dir_changed(parent, dentry)) {

Perhaps add a note about this being dependent on parent of a negative
dentry never changing.

If this was backported to a kernel where this assumption doesn't hold,
there would be a mathematical chance of a false negative.

Thanks,
Miklos
