Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86441A326F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIKXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 06:23:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32904 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIKXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:23:42 -0400
Received: by mail-io1-f68.google.com with SMTP id o127so3342199iof.0;
        Thu, 09 Apr 2020 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJLiW5mwEGPTi6pkYRQAy9hXrnGoQ2ECL0bAS7nqimg=;
        b=HCcFEF8lXmUB+44m25FTNHj4XumqyGxi9RD4xE9z7T6cmSBJ6KImKTT1QGXuk8jXtD
         DQXl60cL66/38QbYGNkBXn+l/cXbX68u3mhG1vmlrxnRGxWjwRf6502Jwwq5rhHfBvWN
         t90A3jYX9x576eardv46lpzdJu8spssZNNzMAM9EaIL/m2iLjBmjDOWenUgwJOKvGXPZ
         j2Iv/gzXlwtaTiM+F6ik2cwUNHlZent0PSqr0Po+JTTnITx+77onE6byNNcCYNldxp1C
         /unQtnCViuHDR+3ef7QIyTocxZQGV8z4r93j84e/zhTFcON89x4L85KR5IU61FSgw+ER
         nH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJLiW5mwEGPTi6pkYRQAy9hXrnGoQ2ECL0bAS7nqimg=;
        b=e2SX2IHTx1JzTT5COwXNjU1938MDxqGN2YT/zwxUSoBKRtk9pio4Y/IlP8qw11QFx2
         UnE/kUqlH26k7v33lm03A1a5y8IUjYJsjhrk51uzmYiYwTGYdyek51xWBLubhWjRaeeb
         59qUYMKU0i8qA4+9N/B4wVdKYG1/5zmmhqs7W5EOJfNWzRF0MAAAQS/hvFwtqiufjgwT
         n0NaseuIi7ALxsUJ+ZdJFxbypX33JPn0cDGuhRmo2F0Z8OFxjuNXi/n+y/CqhS4N+Zgo
         c1yftQ+si4mo/1v7dPeBBx8eXCw1hGUraOpCoI81Mg+Bqvcysh/uIKz8ec6HfJJ76NHp
         apHw==
X-Gm-Message-State: AGi0Puait+LzFISYNuhNx7ocm3TFYqLDzIgEjM8NOb0Q8HC33445beVv
        7nfs+WIt5vE3tNlRVKuoUCTtqtWj1l3subUWwSnVRWOX
X-Google-Smtp-Source: APiQypI9tmoPp7LoCfi62I9O7Y8PoJuwZLhTt08z2L6jr6HL6Yd5OUdQxwZIAfY5glQcofqecq5VZJUfLw6rGitc6vs=
X-Received: by 2002:a6b:8b4b:: with SMTP id n72mr11404095iod.72.1586427819995;
 Thu, 09 Apr 2020 03:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <158642098777.5635.10501704178160375549.stgit@buzz>
In-Reply-To: <158642098777.5635.10501704178160375549.stgit@buzz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Apr 2020 13:23:29 +0300
Message-ID: <CAOQ4uxgTtbb-vDQNnY1_7EzQ=p5p2MqkfyZo2zkFQ1Wv29uqCA@mail.gmail.com>
Subject: Re: [PATCH] ovl: skip overlayfs superblocks at global sync
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 9, 2020 at 11:30 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> Stacked filesystems like overlayfs has no own writeback, but they have to
> forward syncfs() requests to backend for keeping data integrity.
>
> During global sync() each overlayfs instance calls method ->sync_fs()
> for backend although it itself is in global list of superblocks too.
> As a result one syscall sync() could write one superblock several times
> and send multiple disk barriers.
>
> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
>
> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---

Seems reasonable.
You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

+CC: containers list

This bring up old memories.
I posted this way back to fix handling of emergency_remount() in the
presence of loop mounted fs:
https://lore.kernel.org/linux-ext4/CAA2m6vfatWKS1CQFpaRbii2AXiZFvQUjVvYhGxWTSpz+2rxDyg@mail.gmail.com/

But seems to me that emergency_sync() and sync(2) are equally broken
for this use case.

I wonder if anyone cares enough about resilience of loop mounted fs to try
and change the iterate_* functions to iterate supers/bdevs in reverse order...

Thanks,
Amir.
