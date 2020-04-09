Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA61A3387
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDILsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 07:48:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45448 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDILsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:48:43 -0400
Received: by mail-io1-f67.google.com with SMTP id i19so3476184ioh.12;
        Thu, 09 Apr 2020 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOlvHl/QCsBwvft4LaTJNK728rPGD47CC5sTsHAjTkI=;
        b=ha8tTLiN1nWPhSdpUxRrPNrKqZ8H87enea/Zm1U7cxzYt6AuA3NlzQWOg6XXbCHvIO
         LE2O17Nt8RkJf2KIeChDaPo0GYIA/liE/hfhU0V83QjAT9eYDkay1qy6MLsln8lFDbZ+
         TaeYe9JPZJG+lPArQkzJ9GFTV3YMLKbfgGKK4BkDBtv0b1RPT+hvl23dkjjlUs8nO7kL
         I7XqCF3nNKSfMNKc9EwsZQeOI71r50wGcrrZE2AErIrivZsKdpz9zYV7YahSigzRFQig
         /jW+RILAk5aKSZWm4NJ5cHq0Pk46+bk2aOsx4jtFXp+pHFNapbTdHwBTmUP3ZbobWcMQ
         bSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOlvHl/QCsBwvft4LaTJNK728rPGD47CC5sTsHAjTkI=;
        b=lbs8OlJE5GEh7nW4IIX6Ry5o+AiO2SxXv+DvWDzFtKjcoAAg49s9JKN1B901ihlk0S
         cj2307DxhnL5FNgdNThjDeGAK8w0WIQMszS70GcbeOzxkTXfmr/OS2I5reGOhOITSrHx
         qu4k0uYZP5Cg1tRsxahMc4druD/xcgOnLfFdPnx0LKFNyGOHlrfT6kylI5rN1Ljhygz0
         XvKZGTgWeSi8uPb35U8wYKPCOPDnMcw6hJvijGmFN4J2cAH/rbecU0kbTtlNxwkOJ/Hs
         34sy+cPYP/4vyK3K04Ppl+WLXvrwDdwYenCg3F+ah9SW/c/r43b7B+f1cBk/cDzXUR7X
         Y8DQ==
X-Gm-Message-State: AGi0Pua+3LNAUsQ1vzCnFjBgMc8ANFMpXv1amawn//YgKcIFFaUsBfbS
        073UDJtPqhspUFeSItj8LJBpPwMqE/6K/FU92Kc=
X-Google-Smtp-Source: APiQypJopO6UWjOdF9QGXTJSRp18bsEQwMGxO021kEHxRmwH1fiitgdSAqVcsqA1ijwHIeuwwaO/EpQuHHgV6/23LQk=
X-Received: by 2002:a6b:cd4a:: with SMTP id d71mr11544464iog.5.1586432922571;
 Thu, 09 Apr 2020 04:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <158642098777.5635.10501704178160375549.stgit@buzz>
 <CAOQ4uxgTtbb-vDQNnY1_7EzQ=p5p2MqkfyZo2zkFQ1Wv29uqCA@mail.gmail.com> <67bdead3-a29f-a8af-5e7b-193a72cd4b86@yandex-team.ru>
In-Reply-To: <67bdead3-a29f-a8af-5e7b-193a72cd4b86@yandex-team.ru>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Apr 2020 14:48:31 +0300
Message-ID: <CAOQ4uxgeCc=_b1FG3vfMWF50qCousXxEWa63Wn3iCHmLXDNCNA@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 2:28 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> On 09/04/2020 13.23, Amir Goldstein wrote:
> > On Thu, Apr 9, 2020 at 11:30 AM Konstantin Khlebnikov
> > <khlebnikov@yandex-team.ru> wrote:
> >>
> >> Stacked filesystems like overlayfs has no own writeback, but they have to
> >> forward syncfs() requests to backend for keeping data integrity.
> >>
> >> During global sync() each overlayfs instance calls method ->sync_fs()
> >> for backend although it itself is in global list of superblocks too.
> >> As a result one syscall sync() could write one superblock several times
> >> and send multiple disk barriers.
> >>
> >> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
> >>
> >> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> >> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> >> ---
> >
> > Seems reasonable.
> > You may add:
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > +CC: containers list
>
> Thanks
>
> >
> > This bring up old memories.
> > I posted this way back to fix handling of emergency_remount() in the
> > presence of loop mounted fs:
> > https://lore.kernel.org/linux-ext4/CAA2m6vfatWKS1CQFpaRbii2AXiZFvQUjVvYhGxWTSpz+2rxDyg@mail.gmail.com/
> >
> > But seems to me that emergency_sync() and sync(2) are equally broken
> > for this use case.
> >
> > I wonder if anyone cares enough about resilience of loop mounted fs to try
> > and change the iterate_* functions to iterate supers/bdevs in reverse order...
>
> Now I see reason behind "sync; sync; sync; reboot" =)
>
> Order old -> new allows to not miss new items if list modifies.
> Might be important for some users.
>

That's not the reason I suggested reverse order.
The reason is that with loop mounted fs, the correct order of flushing is:
1. sync loop mounted fs inodes => writes to loop image file
2. sync loop mounted fs sb => fsyncs the loop image file
3. sync the loop image host fs sb

With forward sb iteration order, #3 happens before #1, so the
loop mounted fs changes are not really being made durable by
a single sync(2) call.

> bdev iteration seems already reversed: inode_sb_list_add adds to the head
>

I think bdev iteration order will not make a difference in this case.
flushing /dev/loopX will not be needed and it happens too late
anyway.

Thanks,
Amir.
