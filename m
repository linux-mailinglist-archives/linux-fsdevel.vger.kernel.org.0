Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2408269D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEVS3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:29:50 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44402 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVS3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:29:50 -0400
Received: by mail-yb1-f195.google.com with SMTP id x187so1223935ybc.11;
        Wed, 22 May 2019 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNNHt7Z7ll37muKTAxbqGIESLdms47B625sz6OwZ88M=;
        b=gS+RIag0j1EGY4wDhlTvibyOVNteJNKXBPtsOrOJesByGKR2Fuq4X6RhDbSo7QH9G7
         KRnjke+GG3lc/4hxqh+KFtbvDMsLtpoByk3G9G8bwzcCfXJ2oCg77JRACh+DJK9pNMMk
         RLYATRv8sU5DYSau9IUY3RI9CJ39VKRVdaLY2VsFEK9DBxvGidv7KL+DMtB/ZMPcVk9s
         QZYPOM95xYbSo4RUkc8DpcXZ0tMFqnwQA5omAqkTeBvxW1wUTSS36oS6w8xdvbIVtv6u
         Wc/2FDQqA02lI2Q288EkKNN1QjLX2K/gxQu326Gp+Fytagqqoe7JZko5HPTqeKZYUrrY
         SMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNNHt7Z7ll37muKTAxbqGIESLdms47B625sz6OwZ88M=;
        b=ZZ1EVHgKZ71q2KiuMpLGemlyUCyWWhD1k6/7Y/kVr5GDR0aLcaAA4yK8/x/Z5uHzO+
         70emQQWl0ALBLev/Hf5LIHHbLKmWO2SSs2s28JKpu7p3akkcpIOI4IT88n9yghpEraBO
         VQpDXBm1h0Z3VkDRxEuf+zp4XorBA0QkQup73XftlfoeGywy3GSetm0V0Y1OyLR2HKMq
         exlChj6YmSLcY7RpCIUJWyjrL9BaDrYn9shGkb9Z6/GMxmZGucDl00MrWeuzFLQgJUky
         qXAY+kKhsRJzQDECHdeg3eKa/9UyQt5qGyJazV9AWyxViqPROQPNEw7offO15NuYckII
         4XqQ==
X-Gm-Message-State: APjAAAXsvPeEorRiNQNx9fUynwoM+y1nvTeuHa0g2CQXD7Flfq9hwKRP
        0hnYaWtdJwNjPDUD0OUt7kIbDt+wC0/aQPc3XvkpPCfx
X-Google-Smtp-Source: APXvYqwsTkDSAsunnEIlGONN4y6SZSOWtqPzl+D0bsrRFAxyHTFt36u4qhuOcQFbp+BFEDxOaiKXidJf8gQKIuEp7oM=
X-Received: by 2002:a25:a081:: with SMTP id y1mr15975318ybh.428.1558549789253;
 Wed, 22 May 2019 11:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190522163150.16849-1-christian@brauner.io>
In-Reply-To: <20190522163150.16849-1-christian@brauner.io>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 May 2019 21:29:37 +0300
Message-ID: <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
To:     Christian Brauner <christian@brauner.io>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 7:32 PM Christian Brauner <christian@brauner.io> wrote:
>
> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> fanotify_init().
> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN) at the
> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not needed.

It's intentional:

commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
Author: Eric Paris <eparis@redhat.com>
Date:   Thu Oct 28 17:21:57 2010 -0400

    fanotify: limit the number of marks in a single fanotify group

    There is currently no limit on the number of marks a given fanotify group
    can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen as
    a serious DoS threat.  This patch implements a default of 8192, the same as
    inotify to work towards removing the CAP_SYS_ADMIN gating and eliminating
    the default DoS'able status.

    Signed-off-by: Eric Paris <eparis@redhat.com>

There idea is to eventually remove the gated CAP_SYS_ADMIN.
There is no reason that fanotify could not be used by unprivileged users
to setup inotify style watch on an inode or directories children, see:
https://patchwork.kernel.org/patch/10668299/

>
> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue depth")
> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max marks")

Fixes is used to tag bug fixes for stable.
There is no bug.

Thanks,
Amir.
