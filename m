Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52894141FD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAST4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 14:56:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41439 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAST4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:56:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so27429701wrw.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2020 11:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmwixtRBH7x1qvixh2xabvwY3fvytTqVpBbuNJcwmJ0=;
        b=bvuMbOKEO3nbRC9M5cYF+fRXIC4yY8g06Y3o0I3E9mjWThtGx2A4fj4LQg1V999y26
         I77eW2xPSTHRlifu/x97Vx3s+IgFsYgnSFAzbYczV1+MUv3c5b9tWauO5lXz1kraoOb2
         HhIxkzs3207ehLEM1oEx7hYoFV9t/bbCKxsC/Vwh7KCZ4isqkTzWpzsSWYhBlvJwCUhP
         gCPdf+GCmZSVeNieEkMJGastdzSVa93OycGLuq4Ca4GKJUhfV9g0qPM53a9hdJYQaM0H
         Pr3rDoPbE8rt02MckSbn8K93+rB+61XjpOHO1XtskFpv5zHJL3tGe3irf3afC8dTJYso
         E1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmwixtRBH7x1qvixh2xabvwY3fvytTqVpBbuNJcwmJ0=;
        b=SOMduGWdOErw11TkzYWpA3XL0rCM2lSU9j9d4iVXw+RgqCogB2vcIGrH1czvZXrEy/
         7EqgxZ+YvQfaIfkbipfGQsAY/ZHbSCHsUiIvua7hET2Qo0pu68zihwQju/XyY1G78xPo
         Cdi3C3DoZUj2pSMv9bl5aEmGIyfDCtNxajx0edB8A+WLLd2F2JvCsnmYuFRIyboyw6lr
         W7D150Y3dDWAdeddDfeHN09RbI3M/ATPK2JUOD5pxujq1cS+05DqEn18pSVt4i0pKrZv
         Paa0e1PCmp32eVDVEB60WufVmc6bgqj6AtRpLRG/mE7DHCWtRFsmqpDx8teN0uwu6cGF
         eMXw==
X-Gm-Message-State: APjAAAWRjq1Dlxd1/MzPSd6rQOsnngaRBXRfqFqOWz29eYBWNd5IhYRe
        PsuPEd5bzrzQ7r8pv7oXzP9zfpTPd3p5/0PXQZk=
X-Google-Smtp-Source: APXvYqxBRJrU03q7Wg1m2tT+QixEoJJJvHysL7DhFGQFbFw1O5cEDSK9kmdQoDt3YmBI8IpKQ51h9h8D1NrquEEo9PQ=
X-Received: by 2002:adf:ea42:: with SMTP id j2mr14072553wrn.270.1579463769965;
 Sun, 19 Jan 2020 11:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20191106091537.32480-1-s.hauer@pengutronix.de> <20191106091537.32480-4-s.hauer@pengutronix.de>
In-Reply-To: <20191106091537.32480-4-s.hauer@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 19 Jan 2020 20:55:59 +0100
Message-ID: <CAFLxGvxbcMF1S=Ghmi2rH4-ecEPRtVPAS7LrRq5eX=Q6S4PMHg@mail.gmail.com>
Subject: Re: [PATCH 3/7] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:16 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> The FS_IOC_FS[SG]ETXATTR ioctls are an alternative to FS_IOC_[GS]ETFLAGS
> with additional features. This patch adds support for these ioctls.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/ioctl.c | 103 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 98 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
> index 8230dba5fd74..533df56beab4 100644
> --- a/fs/ubifs/ioctl.c
> +++ b/fs/ubifs/ioctl.c
> @@ -95,9 +95,46 @@ static int ubifs2ioctl(int ubifs_flags)
>         return ioctl_flags;
>  }
>
> -static int setflags(struct file *file, int flags)
> +/* Transfer xflags flags to internal */
> +static inline unsigned long ubifs_xflags_to_iflags(__u32 xflags)

Why inline? gcc should be smart enough to inline the function automatically
if needed.

>  {
> -       int oldflags, err, release;
> +       unsigned long iflags = 0;
> +
> +       if (xflags & FS_XFLAG_SYNC)
> +               iflags |= UBIFS_APPEND_FL;

Shouldn't this be UBIFS_SYNC_FL?

> +       if (xflags & FS_XFLAG_IMMUTABLE)
> +               iflags |= UBIFS_IMMUTABLE_FL;
> +       if (xflags & FS_XFLAG_APPEND)
> +               iflags |= UBIFS_APPEND_FL;
> +
> +        return iflags;
> +}
> +
> +/* Transfer internal flags to xflags */
> +static inline __u32 ubifs_iflags_to_xflags(unsigned long flags)

Same.

> +{
> +       __u32 xflags = 0;
> +
> +       if (flags & UBIFS_APPEND_FL)
> +               xflags |= FS_XFLAG_SYNC;
> +       if (flags & UBIFS_IMMUTABLE_FL)
> +               xflags |= FS_XFLAG_IMMUTABLE;
> +       if (flags & UBIFS_APPEND_FL)
> +               xflags |= FS_XFLAG_APPEND;
> +
> +        return xflags;
> +}
> +
> +static void ubifs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
> +{
> +       struct ubifs_inode *ui = ubifs_inode(inode);
> +
> +       simple_fill_fsxattr(fa, ubifs_iflags_to_xflags(ui->flags));
> +}
> +
> +static int setflags(struct file *file, int flags, struct fsxattr *fa)
> +{
> +       int ubi_flags, oldflags, err, release;
>         struct inode *inode = file_inode(file);
>         struct ubifs_inode *ui = ubifs_inode(inode);
>         struct ubifs_info *c = inode->i_sb->s_fs_info;
> @@ -110,6 +147,11 @@ static int setflags(struct file *file, int flags)
>         if (!inode_owner_or_capable(inode))
>                 return -EACCES;
>
> +       if (fa)
> +               ubi_flags = ubifs_xflags_to_iflags(fa->fsx_xflags);
> +       else
> +               ubi_flags = ioctl2ubifs(flags);
> +

So having both flags and fa set is not allowed?
Can we please have an ubifs_assert() to catch this.

-- 
Thanks,
//richard
