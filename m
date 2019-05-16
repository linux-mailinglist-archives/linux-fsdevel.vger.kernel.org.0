Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205691FF36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfEPFyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 01:54:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41358 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEPFyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 01:54:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id o65so901746ywd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2019 22:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+CECfO4kbQLi1hXZDhM/0GuN9+svjP/RrfEb8KL4TU=;
        b=cdwYkqsjMQnVY1EoBpGllUPOmp+BVOpl+zpgJHxMPXK986MSdco3scOFcJh7H4ZNd8
         GvsGlt/Jdr5xNXQJCpVGg/COlMrK4RbDRqBlgIDnUvVu5j6kf3KBAkT4J4DE5/hzOPW/
         570p2TsdpSsGWvaO6BYsUw35vRBZXbz+6mw/bgeZtUds7c4fiqR2ny8xQJBP1eTt21dO
         uFajQ+cF1OeJ0BmSa5wwoRC0EF9ANU3poGZGGqIBaZGAnlkrT4kbFAgHMoU4/jroWcT1
         A8ibJHVltTTkblplGXPKorhRvSy4MlmuJrRAFKnR1Qs3cu7PE09GVnSCyyKOGHtJ0i5m
         E1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+CECfO4kbQLi1hXZDhM/0GuN9+svjP/RrfEb8KL4TU=;
        b=H6AWJ4lKY7jgZTQJ4hk9C3hW0mj8LWnrfpUIwD97UCdvqx43YrVJS/w/WlSy5TBvF3
         7aJkFIzH1rszevnsR46mrnFXETJz1qwxXnLW+XF7ULW+JOciE48bNh7dqQW6UDfAOjAI
         cY7r3X8uicM/RRiQzWK5W3v+WUXwhNRe61TUrn6dsni3pCFrCD8KpVN2er8rz4Wgyd15
         PgKbkM8k9O6g/bNSK7PpoadbdxQOpKZ80SxNM/FBR9Rnk7nRuPMdX6bYF+qrxjNItECM
         +NJI/38fks9+azzMOAXU4R4pi+JdqASZzLvJc2vwNZvMdX1KqQgPUadj2t9T5z36d2Zo
         PhWQ==
X-Gm-Message-State: APjAAAWJdQA9TzFzb78ApLwqwM/SOWCtsq9zNrQtjLvfZWqOuGF0KCA1
        rZjQmGaV/AXcxN2nmXwiCDpN/Ozw4I6vJWYL35q6yyZG
X-Google-Smtp-Source: APXvYqxF+CF3mYXdlcrdGJR1DTgSPs8Tj/Xix35EBr6PDZxtoMuc9MUBqo+S8dDrd7yjkhU5aDGqJKy423+hDBAGub8=
X-Received: by 2002:a81:7003:: with SMTP id l3mr6748364ywc.409.1557986088220;
 Wed, 15 May 2019 22:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190515193337.11167-1-jack@suse.cz>
In-Reply-To: <20190515193337.11167-1-jack@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 08:54:37 +0300
Message-ID: <CAOQ4uxhKV9qXGDA6PuCKrbBjM_f2ed_XScY3KkWVX8PXzwCwCA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Disallow permission events for proc filesystem
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 15, 2019 at 10:33 PM Jan Kara <jack@suse.cz> wrote:
>
> Proc filesystem has special locking rules for various files. Thus
> fanotify which opens files on event delivery can easily deadlock
> against another process that waits for fanotify permission event to be
> handled. Since permission events on /proc have doubtful value anyway,
> just disallow them.
>

Let's add context:
Link: https://lore.kernel.org/linux-fsdevel/20190320131642.GE9485@quack2.suse.cz/
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fanotify/fanotify_user.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a90bb19dcfa2..73719949faa6 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -920,6 +920,20 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>         return 0;
>  }
>
> +static int fanotify_events_supported(struct path *path, __u64 mask)
> +{
> +       /*
> +        * Proc is special and various files have special locking rules so
> +        * fanotify permission events have high chances of deadlocking the
> +        * system. Just disallow them.
> +        */
> +       if (mask & FANOTIFY_PERM_EVENTS &&
> +           !strcmp(path->mnt->mnt_sb->s_type->name, "proc")) {

Better use an SB_I_ flag to forbid permission events on fs?

> +               return -EOPNOTSUPP;

I would go with EINVAL following precedent of per filesystem flags
check on rename(2), but not insisting.

Anyway, following Matthew's man page update for FAN_REPORT_FID,
we should also add this as reason for EOPNOTSUPP/EINVAL.

Thanks,
Amir.
