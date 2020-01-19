Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD97141FE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 20:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAST6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 14:58:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36018 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgAST6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:58:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so12645031wma.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2020 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW1WqBa2Pd1nHdQF9V69UKEneBTY6UUFwViYZyCsdIo=;
        b=Qi6yIF9ihCAXogvjG7zLjx2PHFF2Fvm+Wf2OOnyJDXahcAIxD/ce5jgCDKznHJGhgx
         UFHhV3Zyuzc56b0g+hEPnJ785F+P7ufCVuKeVjWWbMIL6FC/45apgsHT0LzDhkGXwJ69
         8LRvbdccuSIGw4e20KPS0AQI8gfyE0Y0Q/uX+GIJqJ/Yd4GCFSEEQAs+E+fFDj6cCAp/
         aMprb4uo4/jQpqSS0/ST4cl781CwRTWOPr1tchZ+lrzaj6e4xIAnhFVc1ZjLRzOg/WUc
         Q3BxyhsAg1Potze/bAso5cFZl9Je/7JrihLjseM78LEvfZqxYgSTTcxsabWQXH0mLLbW
         sk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW1WqBa2Pd1nHdQF9V69UKEneBTY6UUFwViYZyCsdIo=;
        b=uYj+Yb4xq/kGcSKsxwYVxNWm6O/A2g4F8sf9BrTuZE4ac69sQNbuprVPlPKnM3Uexo
         Vm/QAljz4YTSUVIBclSHvGLf4akAxl6g3ou/Cq/rwUi467+9cdaqOmvCYYckB9joaUR8
         joSkol7mtcHitRxzZ4VFBEHN6RFDUG5TsFKXn8uja5K6vbqU4OJE3KByn4ohWQ6BbbAf
         Ev2Q+d1Pho65cQTXp0jWVqzSwOAIgAqHKaQIuPdR5Ttmh97A8uIM4CF2vPvpqKNPZ7qW
         2+1tDzuRhqbAWKIjPdliUKSOwNfUgkye2sixInd7Dgg79HGEO7wG0Knxrfoq9w9qDWSo
         sNpQ==
X-Gm-Message-State: APjAAAUI5Yi5ubyIiCF+u0TsGXeRZJHlqrVv1DTM1LWwTT28RDvZXb7z
        j2WYKmiEKqag3rW4Ejld3MijpAKT9R2Ysz/wgTqDuw==
X-Google-Smtp-Source: APXvYqwdpYzIraIH0lO/a2rfcH+81gWesTWNn8jSPopjS6XZ624Yolt9JxQFEAbBF4GS14eNyzBiXOGSArCXOKWsou8=
X-Received: by 2002:a7b:c949:: with SMTP id i9mr15837917wml.131.1579463920233;
 Sun, 19 Jan 2020 11:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20191106091537.32480-1-s.hauer@pengutronix.de> <20191106091537.32480-5-s.hauer@pengutronix.de>
In-Reply-To: <20191106091537.32480-5-s.hauer@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 19 Jan 2020 20:58:29 +0100
Message-ID: <CAFLxGvyX50_b6Ejh0eCCA82AF6TRsgT43BDqdAjTQY+KiyfuWw@mail.gmail.com>
Subject: Re: [PATCH 4/7] ubifs: do not ubifs_inode() on potentially NULL pointer
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

On Wed, Nov 6, 2019 at 10:17 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> new_inode() may return NULL, so only derefence the return inode when
> non NULL. This is merely a cleanup as calling ubifs_inode() on a NULL
> pointer doesn't do any harm, only using the return value would.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 0b98e3c8b461..cfce5fee9262 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -95,10 +95,10 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
>         }
>
>         inode = new_inode(c->vfs_sb);
> -       ui = ubifs_inode(inode);
>         if (!inode)
>                 return ERR_PTR(-ENOMEM);
>
> +       ui = ubifs_inode(inode);
>         /*
>          * Set 'S_NOCMTIME' to prevent VFS form updating [mc]time of inodes and
>          * marking them dirty in file write path (see 'file_update_time()').

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
