Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238691652D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBSWzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 17:55:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33338 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:55:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id w6so1879144otk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4pOGEBUjTtqd1425lEJ8AZDsqGk65dcG0XF2iUnuZ0=;
        b=pK9rUipZqQOPARO7LczvhgkQkHVdIcojVlbeVEqCc4LywBbyRFuTf0XQeRFfxeA8A7
         YgLLnAyRPKZYwq5GGaLTv2BGYJXDzhGb11qSZ2DuJJrpeYrEr3paFgrsY9UrlsPiF9c2
         8vifQ5TsuaGG+QfY7d5N9EilBkHvAI41BXtbadGpyvOLCs6ZQ56k+cTPe0h0t1vJtvI0
         yndWkPgn/MbGTeZG6uDweCpHnmQaPsFOqI1Ct/9YZOFA8PDHoLTNuskE5Cr1krWKiyUg
         WMiOuy63YPKLzaKT2WH0J2M0w3njBEAiJvv0pKZvg3OxZjOF9QLVebnSCKLUEIMwh9iC
         Iinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4pOGEBUjTtqd1425lEJ8AZDsqGk65dcG0XF2iUnuZ0=;
        b=PjkOwLbbik6N6xdYxAyOazsl/3Defu7kVuNeFIZ6tcsoUmRFi7TTHBgDRDUS0vitp0
         DdOiWqnylwIJxbN54B9Sie+wEH48EOVUBnowbQSNr73hjdHkMgVIsIytaxvvQSZ356bZ
         dm37wzbEmwm1vj0nRDWUDSigP2ZglPCd/ewW72BO7zSbvL/evME22pJOdHVhMNAVc+b7
         1XerrNYbnfpnQGpuCp4i0wP7SCKTIyUuaM1lH+KkxwOqJhU3v7j3CFrioJACQX4tfbsJ
         4NeLkvatjLL3SFpDC8eWWrFJTvpj0cuzzCnW2zBvaJMO6SVaakctZc5G29MwotsaBN9Y
         NGIg==
X-Gm-Message-State: APjAAAX13UzNakTwuoBerdfzQ0xJJvlJPqfm9oMeepwSi8sseCdd/+/u
        iWUpjEhyY7LLKCcGSnvyvKYB7asXL3ctNujlYx+wGg==
X-Google-Smtp-Source: APXvYqxFr4OdUJ4dtTKSPQSfpsU7Ak5Fa+iiLAH7z+yqdI1Wm5Y2Fe2ZTmFIMFqqBX5wAVUgtihE13w2zyyS0CYCBJg=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr20810623oti.32.1582152952170;
 Wed, 19 Feb 2020 14:55:52 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk> <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com>
In-Reply-To: <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 23:55:26 +0100
Message-ID: <CAG48ez3gtZPn9hC565J4L0yyjW521T8Pg7FX+7R1B3mAcmXfyA@mail.gmail.com>
Subject: Re: [PATCH 13/19] vfs: Add a mount-notification facility [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:40 PM Jann Horn <jannh@google.com> wrote:
> On Tue, Feb 18, 2020 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
[...]
> > +                       watch = NULL;
> > +               }
> > +               up_write(&m->mnt.mnt_sb->s_umount);
> > +       } else {
> > +               ret = -EBADSLT;
> > +               if (m->mnt_watchers) {
> > +                       down_write(&m->mnt.mnt_sb->s_umount);
> > +                       ret = remove_watch_from_object(m->mnt_watchers, wqueue,
> > +                                                      (unsigned long)path.dentry,
> > +                                                      false);
>
> What exactly is the implication of only using the dentry as key here
> (and not the mount)? Does this mean that if you watch install watches
> on two bind mounts of the same underlying filesystem, the notification
> mechanism gets confused?

Ah, nevermind, I understand this one now... this operation only
removes watches on this mount with that dentry, and so together, that
means it effectively removes watches by the full path.
