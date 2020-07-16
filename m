Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149BB222B29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGPSme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGPSmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:42:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C2C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 11:42:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so7101770ioh.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8V2h1SBvwKcqOUQP5/OlxR189iREiR2x1+r/r8UapQ=;
        b=TR0Exk7qmAwU1e4jBZ3pNzxYFhg9iD1FigBAYUcQIcHjZ1nYZHBhY4WPH/Q+iDZPs2
         tMPK8iihivGD2RqJuOqXRfRR4mJSzHnNgmX/k5aj5KnlMdBdxFhTe1gttgAhgB0BRtvk
         zvALiIO3quN7jVUbBXqWNR1bEvSbiTcVFjZtUCS3D+Var1JS8IRLWI5lbs2jy+QwmwF1
         tdbHA47DUQPm1VA08Ab7B0x06jEsxkG0f/TkQXkhk/PgYvCvk/SzihkezvjKv1YA61jU
         VPnnJXV70ZVBhcV8IoOvKnDnyr41aGtu18BmWMEV7q6Yg2uxNyP/Rea68tQ1t7hw+XGg
         0NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8V2h1SBvwKcqOUQP5/OlxR189iREiR2x1+r/r8UapQ=;
        b=D5MWuGXmpe0M3FkiyKoZFffMcb6i8uwQcTdcwsZB/g/YyqBPox2h6m8ji/qzvtNtIO
         2mfg6g2v2zk+lMSfFlfFTcrR00LOafgHZ5rxshjr8m+23FONcTpcDuA5isGNO26aD7mF
         vacNxiSn1NE1KWuSIsTXDiLYM5LdVzcHsGGoRlp1j79kVCjp63JV+68bRQdoDfHYHmWJ
         X1P9dHRh7ddAuA5v6vd1ts7eLtJNZXJcFKJsX73UsNYl3QifY7PHwrqUa1Z1D/SkqcRO
         DkZToERNZYPtNiOfNaoNZHYuCEj6WA+FDwSvM5d/IB3ub9sUP8J1A8duP4vjwE8j6xvl
         SuKA==
X-Gm-Message-State: AOAM530TSejZ1S5riIJQAgcV1xEATXXXrY+TxpWTdpBFw9woaRyUSGz1
        KZcX1NmkuwDlpfrCH0E/BVOCcdPbx+D76NvgUmtOh1Kv
X-Google-Smtp-Source: ABdhPJyufvxq4NiISzf6X5dRCW+RXAqAkrJAMrM6xcqsZrm652PfHUwsO2Fcd8NOnyXM/U8xTrb/zuw7sds+xTMfAaA=
X-Received: by 2002:a02:a986:: with SMTP id q6mr6309462jam.93.1594924952511;
 Thu, 16 Jul 2020 11:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-16-amir73il@gmail.com>
 <20200716170133.GJ5022@quack2.suse.cz> <CAOQ4uxhuMyOjcs=qct6Hz3OOonYAJ9qhnhCkf-yy4zvZxTgFfw@mail.gmail.com>
 <20200716175709.GM5022@quack2.suse.cz>
In-Reply-To: <20200716175709.GM5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 21:42:20 +0300
Message-ID: <CAOQ4uxiS2zNkVQZjcErmqq2OSXdfk2_H+gDyRWEAdjzbM+qipg@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 8:57 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 20:20:04, Amir Goldstein wrote:
> > On Thu, Jul 16, 2020 at 8:01 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 16-07-20 11:42:23, Amir Goldstein wrote:
> > > > Similar to events "on child" to watching directory, send event "on child"
> > > > with parent/name info if sb/mount/non-dir marks are interested in
> > > > parent/name info.
> > > >
> > > > The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> > > > interest in parent/name info for events on non-directory inodes.
> > > >
> > > > Events on "orphan" children (disconnected dentries) are sent without
> > > > parent/name info.
> > > >
> > > > Events on direcories are send with parent/name info only if the parent
> > > > directory is watching.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Hum, doesn't this break ignore mask handling in
> > > fanotify_group_event_mask()? Because parent's ignore mask will be included
> > > even though parent is added into the iter only to carry the parent info...
> > >
> >
> > Hmm, break ignore mask handling? or fix it?
> >
> > Man page said:
> > "Having these two types of masks permits a mount point or directory to be
> >  marked for receiving events, while at the  same time ignoring events for
> >  specific objects under that mount point or directory."
>
> Right, but presumably that speaks of the case of a mark where the parent
> has FS_EVENT_ON_CHILD set. For case of parent watching events of a child, I
> agree it makes sense to apply ignore masks of both the parent and the child.
>
> > The author did not say what to expect from marking a mount and ignoring
> > a directory.
>
> Yes and I'd expect to apply ignore mask on events for that directory but
> not for events on files in that directory... Even more so because this will
> be currently inconsistent wrt whether the child is dir (parent's ignore mask
> does not apply) or file (parent's ignore mask does apply).
>

Indeed. For that I used this trick in my POC:

        /* Set the mark mask, so fsnotify_parent() will find this mark */
        ovm->fsn_mark.mask = mask | FS_EVENT_ON_CHILD;
        ovm->fsn_mark.ignored_mask = mask;

It's not how users are expected to configure an ignored mask on children
but we can work the ignored mask information into the object mask, like
I already did w.r.t FS_MODIFY and get the same result without the hack.

Thanks,
Amir.

P.S. for whoever is interested, my POC is on ovl-fsnotify branch.
It seems to be working well. I am just trying to get those "ephemeral
exclude marks" to not pin the dir inodes to cache, so that those inodes
could be evicted.
