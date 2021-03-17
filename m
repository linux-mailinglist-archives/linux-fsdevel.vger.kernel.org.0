Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABC433ECF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhCQJ0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCQJ0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:26:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB62C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 02:26:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n132so40219284iod.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vEzpbGKP6zTNanKU4x1/Nr2Ja/sGTWgtdcWKuv0CVw=;
        b=nC5SPwOtwpdpcj/P5i3KAHcTOKPOo1a19unOW+Asvg06q8jlJrWAuX62cpJXzcG05p
         eb1loYV1rY2yo3WgnYLaLyKcnp0h9bRkQrPHUoY9wANGfJnx0HthJCp9jyHbfdr02xDq
         NNPeajWVHrDdsWp/FRBOp/vrQcMlKzqi5iXfukYA5XkRXMmGmISHyLgzTXkkatfdARtk
         5JgyMU1kOs6YtgXi31M2m/8BvEHcKLSKIl5idrUsr80j+t7YP0u8fUSSpFAeKLxdR99d
         jhotmogqQ49ieXfyIMdhVMrLfVVOTYDU+mcEyeANWfdoWJNulVYKS49lwv/Fy34E8j7G
         pmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vEzpbGKP6zTNanKU4x1/Nr2Ja/sGTWgtdcWKuv0CVw=;
        b=oQoRgJvcaRIc0j3upABeokh9Ej2lD6v+mtmRUWmq2Af3rpeOUfxIMbd66hmIWLlGeu
         5Y5SnvsKPXC1DGqNwHcgIxkxzwYpBRgMjjwKu/m+qRDIFan86W5OfVEElCm/LVW4D6F0
         lfPJact/fIl1ahrl5IIfZxhnT9t4wVazjjdS7Lsz4nyZfM0+qFMGNruCqe4TOEz28pED
         UCgOnDQTezT5U3w/fBLxzZZU2J1yk+7+RvTjYZK35O8J63lqm+wmMFMUW3xTbuT+BJN7
         ynoL5ZjPDMNHEObxQ3MznRELdjTbdYuSrXYjj5tfU8ZsL4cDIdUxkMWq3yMz45npxtNe
         KfiA==
X-Gm-Message-State: AOAM532FXWPVvazo2HeLzLd3QgS3ijtnAMg5t4BS72CVSAxYQ9lMsHCN
        F0+m8zU8FIPCupC26Z4J7G79UCu+YtP/dwlUEAgAiBH3am8=
X-Google-Smtp-Source: ABdhPJzdHHJY+D8n3Y6yEF0eYc0T44AxbW5JmIMMdXdzXaUVBSo0V/NnH9x9JwEpTRwIKGridExGt3iHSRIq23F3XtM=
X-Received: by 2002:a02:605d:: with SMTP id d29mr2034100jaf.81.1615973207390;
 Wed, 17 Mar 2021 02:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210304104826.3993892-1-amir73il@gmail.com> <20210304104826.3993892-4-amir73il@gmail.com>
 <20210316151807.GB23532@quack2.suse.cz>
In-Reply-To: <20210316151807.GB23532@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Mar 2021 11:26:36 +0200
Message-ID: <CAOQ4uxizm9KdM+82MGni=fUkCzUvU2pt1q+0ynGLkDX47hJm3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] fanotify: mix event info and pid into merge key hash
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:18 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 04-03-21 12:48:24, Amir Goldstein wrote:
> > Improve the merge key hash by mixing more values relevant for merge.
> >
> > For example, all FAN_CREATE name events in the same dir used to have the
> > same merge key based on the dir inode.  With this change the created
> > file name is mixed into the merge key.
> >
> > The object id that was used as merge key is redundant to the event info
> > so it is no longer mixed into the hash.
> >
> > Permission events are not hashed, so no need to hash their info.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > @@ -530,6 +568,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >       struct inode *child = NULL;
> >       bool name_event = false;
> >       unsigned int hash = 0;
> > +     unsigned long ondir = (mask & FAN_ONDIR) ? 1UL : 0;
> > +     struct pid *pid;
>
> I've made a tiny change here and changed 'ondir' to bool since I don't see
> a strong reason to play games like this. Otherwise I took the patch as is.
>

OK, so you kept this arithmetics with a bool:

(unsigned long)pid | ondir

I suppose there's no harm.

Thanks,
Amir.
