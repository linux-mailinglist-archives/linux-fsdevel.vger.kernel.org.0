Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D3FAA94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 08:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfKMHBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 02:01:49 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38681 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMHBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:01:49 -0500
Received: by mail-yw1-f68.google.com with SMTP id m196so380603ywd.5;
        Tue, 12 Nov 2019 23:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjvWzi5zAYDzWCzMMij4/zfnC+NCGyH/qKPEJGtsxFA=;
        b=SiksfhJAN1W/uAeCuU4qY1s9ABOuCtBmJRiK+lb7NzZQRYuk0uO5tTA9KwN+GH+A0z
         9OZ2PalvM9Nsd2P+QfroLRUCmQittDRndNaTPSbOawYIX0uLlNh3Kw7abLGTP5LRCgM7
         NY3juym5/hTRXqlIn0G3OyvYokefg1pySjfNXhDzBdBMspQ23eIfhgqeyj9VD0eX5iqj
         aGJn0vg/bHFzS7GUPVGz3xCDDGTc50XuGHa7p9aX/drh/0ISHp6UkXcV1QnZEEwjSK5l
         ylZfR+5/s+h+CLsY0X/H46pFMBHhkVhPI+LIFj/UlbwsDSE2zT+4Aiyw/OIJWUyH4hYa
         T4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjvWzi5zAYDzWCzMMij4/zfnC+NCGyH/qKPEJGtsxFA=;
        b=Me9MTDA9al9UL3sM/HcfZkOR/mKZny40Q8+7KO0FKw8ad2hSHGMM38vZWrnsDu8f3Q
         w8QjT8UBZ+rzKsp4QAl0FwW5Nca9gfI/QoZ2TaOj33Rz64JcVyg7LNtktvV2vcd0taay
         VW0rvj6i1hdK2J2cP1sdf4XnvWsn7yxqQRgYYVF20WT5YKG3TPxGfTsRVGui5o1lZJf3
         8cE4i84Dm48khn/W8S5DiLIu1NzpS9DDp8WYpodi81LRnFkwz1acN+Ftw1UzCYHxBQqb
         A0cRNbSRWtgn2JA6Fez9BNJhSdn0XaYRVweSz8O6GK740WeTWdtwUYO6VT/M7PJ3QzQq
         l/Fw==
X-Gm-Message-State: APjAAAVmoVzeLLww1AYveq/NhsqSq4LB25MfyiJgFHtR9k3h4M8316ij
        uu8a7suHOJ8plqBWVq881GKnZu8l7a4Ngtx0gXw=
X-Google-Smtp-Source: APXvYqytmTgUznWrkZNaCm0wGchaTdWq2lIA2CGsbtK9nqE383blgmwrbwRQ5AdkDaQoV4z9HoievrtIxfwEhmytANY=
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr1186047ywv.183.1573628508049;
 Tue, 12 Nov 2019 23:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com> <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk> <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk> <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk> <20191103163524.GO26530@ZenIV.linux.org.uk>
 <20191103182058.GQ26530@ZenIV.linux.org.uk> <20191103185133.GR26530@ZenIV.linux.org.uk>
In-Reply-To: <20191103185133.GR26530@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Nov 2019 09:01:36 +0200
Message-ID: <CAOQ4uxiHH=e=Y5Xb3bkv+USxE0AftHiP935GGQEKkv54E17oDA@mail.gmail.com>
Subject: Re: [PATCH][RFC] ecryptfs_lookup_interpose(): lower_dentry->d_inode
 is not stable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, wugyuan@cn.ibm.com,
        Jeff Layton <jlayton@kernel.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ecryptfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 3, 2019 at 8:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> lower_dentry can't go from positive to negative (we have it pinned),
> but it *can* go from negative to positive.  So fetching ->d_inode
> into a local variable, doing a blocking allocation, checking that
> now ->d_inode is non-NULL and feeding the value we'd fetched
> earlier to a function that won't accept NULL is not a good idea.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index a905d5f4f3b0..3c2298721359 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -319,7 +319,7 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
>  static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
>                                      struct dentry *lower_dentry)
>  {
> -       struct inode *inode, *lower_inode = d_inode(lower_dentry);
> +       struct inode *inode, *lower_inode;
>         struct ecryptfs_dentry_info *dentry_info;
>         struct vfsmount *lower_mnt;
>         int rc = 0;
> @@ -339,7 +339,15 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
>         dentry_info->lower_path.mnt = lower_mnt;
>         dentry_info->lower_path.dentry = lower_dentry;
>
> -       if (d_really_is_negative(lower_dentry)) {
> +       /*
> +        * negative dentry can go positive under us here - its parent is not
> +        * locked.  That's OK and that could happen just as we return from
> +        * ecryptfs_lookup() anyway.  Just need to be careful and fetch
> +        * ->d_inode only once - it's not stable here.
> +        */
> +       lower_inode = READ_ONCE(lower_dentry->d_inode);
> +
> +       if (!lower_inode) {
>                 /* We want to add because we couldn't find in lower */
>                 d_add(dentry, NULL);
>                 return NULL;

Sigh!

Open coding a human readable macro to solve a subtle lookup race.
That doesn't sound like a scalable solution.
I have a feeling this is not the last patch we will be seeing along
those lines.

Seeing that developers already confused about when they should use
d_really_is_negative() over d_is_negative() [1] and we probably
don't want to add d_really_really_is_negative(), how about
applying that READ_ONCE into d_really_is_negative() and
re-purpose it as a macro to be used when races with lookup are
a concern?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190903135803.GA25692@hsiangkao-HP-ZHAN-66-Pro-G1/
