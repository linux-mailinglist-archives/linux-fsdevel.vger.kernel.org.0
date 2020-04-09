Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D21A34C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 15:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDINWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 09:22:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36823 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgDINWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:22:49 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so10163610ilp.3;
        Thu, 09 Apr 2020 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UI/hdw9L/EtadFnpRAH+lSsEEcGuj9UA8ITbxu7mZq8=;
        b=eMVZ2RTfhkxdL1Oca25VgLMEnU6ttfOQjhA8YSWKKsCsAP0X3ghVEhrWTOyiL5lDNf
         TmuVGr5zl2HgjX+VqThJfwADC3jT3Qp6PVmw52pRE+iPlO95bjfY5pPWjwc0DZo2GPJD
         i5zRqdxYRJzFxuZ5jQ3xfcbef7NXeVQLe5bqOVwLObwnmEep5wiPX1+aKATv7QrG1W++
         5gOZvRWJiHI+WxF3ntXHS1wt7XgpvpUkV+KR0bK+0N0Vr7RdHXiNThFlYp2mqFNAwoKF
         ecP0TJDqtYE03Tlvwa7eqwsQd+kPmga1YCvUIuwaJ9cLgrZmSOkRMP41+eqw7/YjgImq
         1LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI/hdw9L/EtadFnpRAH+lSsEEcGuj9UA8ITbxu7mZq8=;
        b=rwJkpt9FlbLQpzzvD5CbInsExK89FJx+XPB72/NdVJogwh0+50FV9+h1Xh+ZhteyD4
         3Tzo1S8b6GkYlED0VjIn+AZhY5tf9+aR3nu4Sy+aL3rP2WPw17JHWEQhsyG5o6EWVwI6
         TwHeydlBbK7tqAORSgMCnRr2uWIWjMRFdFWgxChOjTrji+HekCA+Wjtyh/An4iP4WRZb
         yAK8Q8wwQ3CTy3ZzefMnzlx03MapXaWxZnbcd/UQwJ5Tcez+tUAUWtkpbB0jY+S7C2oQ
         rOBiYlqFle/jhNc57vetEItC6qi/aIODGZB0X+6nYunxTeN76zVSteKGF9gnOIqK7piX
         6odw==
X-Gm-Message-State: AGi0PuZLIqNp1l0oBpEdl1ttn4MwOznJ8netSGFfq7QpSv4L7qlsCOzW
        /9kKHL3gJKDTpoP2wD6YxvmSynm2La0vYH8U94U=
X-Google-Smtp-Source: APiQypKI2Ole0cnTO37YLRWq4xrZa3vPlVGaSws9tGvaibcgtxxUJjE0UJqBQyCcqv+/Jq8zlnMwSJ16XEzSxnaqtLA=
X-Received: by 2002:a92:7303:: with SMTP id o3mr13156038ilc.275.1586438569209;
 Thu, 09 Apr 2020 06:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <158642098777.5635.10501704178160375549.stgit@buzz>
 <CAOQ4uxgTtbb-vDQNnY1_7EzQ=p5p2MqkfyZo2zkFQ1Wv29uqCA@mail.gmail.com>
 <67bdead3-a29f-a8af-5e7b-193a72cd4b86@yandex-team.ru> <CAOQ4uxgeCc=_b1FG3vfMWF50qCousXxEWa63Wn3iCHmLXDNCNA@mail.gmail.com>
 <6af394f4-7cfd-5303-0042-9e37e43cf346@yandex-team.ru>
In-Reply-To: <6af394f4-7cfd-5303-0042-9e37e43cf346@yandex-team.ru>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Apr 2020 16:22:38 +0300
Message-ID: <CAOQ4uxiqSuvxyW-C8L9A4AV-cTrEgdpspwWkpq1RWuoZq0FM+Q@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 3:04 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
>
>
> On 09/04/2020 14.48, Amir Goldstein wrote:
> > On Thu, Apr 9, 2020 at 2:28 PM Konstantin Khlebnikov
> > <khlebnikov@yandex-team.ru> wrote:
> >>
> >> On 09/04/2020 13.23, Amir Goldstein wrote:
> >>> On Thu, Apr 9, 2020 at 11:30 AM Konstantin Khlebnikov
> >>> <khlebnikov@yandex-team.ru> wrote:
> >>>>
> >>>> Stacked filesystems like overlayfs has no own writeback, but they have to
> >>>> forward syncfs() requests to backend for keeping data integrity.
> >>>>
> >>>> During global sync() each overlayfs instance calls method ->sync_fs()
> >>>> for backend although it itself is in global list of superblocks too.
> >>>> As a result one syscall sync() could write one superblock several times
> >>>> and send multiple disk barriers.
> >>>>
> >>>> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
> >>>>
> >>>> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> >>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> >>>> ---
> >>>
> >>> Seems reasonable.
> >>> You may add:
> >>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >>>
> >>> +CC: containers list
> >>
> >> Thanks
> >>
> >>>
> >>> This bring up old memories.
> >>> I posted this way back to fix handling of emergency_remount() in the
> >>> presence of loop mounted fs:
> >>> https://lore.kernel.org/linux-ext4/CAA2m6vfatWKS1CQFpaRbii2AXiZFvQUjVvYhGxWTSpz+2rxDyg@mail.gmail.com/
> >>>
> >>> But seems to me that emergency_sync() and sync(2) are equally broken
> >>> for this use case.
> >>>
> >>> I wonder if anyone cares enough about resilience of loop mounted fs to try
> >>> and change the iterate_* functions to iterate supers/bdevs in reverse order...
> >>
> >> Now I see reason behind "sync; sync; sync; reboot" =)
> >>
> >> Order old -> new allows to not miss new items if list modifies.
> >> Might be important for some users.
> >>
> >
> > That's not the reason I suggested reverse order.
> > The reason is that with loop mounted fs, the correct order of flushing is:
> > 1. sync loop mounted fs inodes => writes to loop image file
> > 2. sync loop mounted fs sb => fsyncs the loop image file
> > 3. sync the loop image host fs sb
> >
> > With forward sb iteration order, #3 happens before #1, so the
> > loop mounted fs changes are not really being made durable by
> > a single sync(2) call.
>
> If fs in loop mounted with barriers then sync_fs will issue
> REQ_OP_FLUSH to loop device and trigger fsync() for image file.
> Sync() might write something twice but data should be safe.
> Without barriers this scenario is broken for sure.
>
> Emergency remount R/O is other thing. It really needs reverse order.
>

Correct. There is no problem with durability.
Although for some filesystems it would be more efficient to first
write and fsync the loop images and then sync_fs().
I can potentially result in less overall disk barriers.

Thanks,
Amir.
