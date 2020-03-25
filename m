Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC41926F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCYLUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 07:20:14 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42052 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCYLUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:20:14 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so1446293ilj.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rR4xNt2k6k2Y4W/2DM6BrcOKVsemPNYbjCMjGKwzivs=;
        b=tmunX6WRa/ZsWAgH+2rSKmdMIlzD6UES7xgWs3A4Q12lBr8KfXxrBWPIwMMsPlEnT6
         W5fJTrCMHgBmdjdJ9gVyiP4L9wasPMM8VLOXZaW0ABe+GU7iCBdr3S+84At/5jvRXNe0
         qjDyC5zaLk+1HaBQbYFD/mUmOwODloEQmG1xcdfBv691DCOgRDydG+pdLqTERidXvyDY
         Z/XlTNucW9VxUm1w6VmcDzBesitkNes8bOFoJeJeJeoRhp4AK3AIhi/gXRlBsA2JBaCd
         +kPAJGTcHlCK4fl5XWikE7aokzkJ4dIBp0QPQ6dR48GlmgbQp/JhtVT9MawWytBMm3oN
         +GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rR4xNt2k6k2Y4W/2DM6BrcOKVsemPNYbjCMjGKwzivs=;
        b=QM0X8RJ15ukXoxVYfCXRBsf1JOGZRvm0uDKdJ9xWzs96tHsF8JQCP6wUoEy7rhJCMP
         P+8N6O6wtriCOf/zpreYCC8JIylvq7l/HB/7lPSeF+n6R2hXZSm9CgSOXEH1DEQGb8O+
         0RJLlgvChitBFsllPx3rAa8XVb9SjFjSetDrBNaC8AYgmwbqCytH5YVHvZMc7kanPR3q
         yQs5bynNQw+ode0Do4C2mBBotbfFA3ZrRlIx7dEocFiyMAxNkFfEkocxF33FExGeHXae
         Fah/Hj+lbiI3iRrV7c5u4iZ/Qtpxa9cXoWrKZW8kS7GJB3TN7Fj6iWp3nExFyFLXZ3tn
         Nn4w==
X-Gm-Message-State: ANhLgQ06t4uI3ie2A9nPp9gORub+4upvNm2hh5bNMuPmWNJkkwNDBbB6
        m+xV+IsdsKWOVFT+PixtpS25BYxS6tE1BTzcvPw=
X-Google-Smtp-Source: ADFU+vscNFSZEziZHyLbUkl6kaoTpobcSoE0/mDIYB67trUXE0oVRxO6UCIc3G2jEEx93IRHXwKnJXQJqKvyoEEbD7Q=
X-Received: by 2002:a05:6e02:68a:: with SMTP id o10mr1850939ils.72.1585135213385;
 Wed, 25 Mar 2020 04:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151022.31456-1-amir73il@gmail.com> <20200319151022.31456-7-amir73il@gmail.com>
 <20200325102257.GH28951@quack2.suse.cz>
In-Reply-To: <20200325102257.GH28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Mar 2020 13:20:02 +0200
Message-ID: <CAOQ4uxg9bEX_2wOVJ10TxuorQJdj_YFj+bsSf3c84rTFJ2jdBw@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] fsnotify: pass dentry instead of inode for
 events possible on child
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:22 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-03-20 17:10:14, Amir Goldstein wrote:
> > Most events that can be reported to watching parent pass
> > FSNOTIFY_EVENT_PATH as event data, except for FS_ARRTIB and FS_MODIFY
> > as a result of truncate.
> >
> > Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY
> > and use it to pass the dentry instead of it's ->d_inode for those events.
> >
> > Soon, we are going to use the dentry data type to report events
> > with name info in fanotify backend.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I've skipped this patch because FSNOTIFY_EVENT_DENTRY is not used by
> anything in this series... Just that you don't wonder when rebasing later.
>

No problem.
I had my series ordered fsnotify then fanotify, that's why it was there.
It really belongs to the FAN_REPORT_NAME patches.

Thanks,
Amir.
