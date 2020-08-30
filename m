Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD28256FF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 21:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgH3TFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 15:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgH3TFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:05:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E46C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 12:05:52 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q67so131678vsd.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7R5Y1+hdW9X8/AT/D4QfTIG13sCo0lYiN0og0zlS0w=;
        b=PuQMiK2lRKOn7UPl2mHVYdMKUV+3RIjFWpWyx8svsWphZyjl5I64Y55WcmFN5cQmY+
         hxfjY/EZeI4hvlsw6KWAqPEKQ703SCsSZShz9rgwROFYCWEzQhljgP/pWSuORu3VYW9W
         oOHakbryssutHKMbP/rly5DTGTjcPYFBzpY4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7R5Y1+hdW9X8/AT/D4QfTIG13sCo0lYiN0og0zlS0w=;
        b=HyTw77R0IsaBCCKH9pXwD8iq0GnSocXLfkKzGk+uN0EP+D6MQ7jR3EvgawhRlIMe4e
         LMz26KdfDe822t0ab818MYTe22d1c2FcXLqhDLhsT5CjwHeNi/i83t5KQVkAZV7DSJuu
         qPomcVsKDIXGkmi8f9yxBUV8FuKDybDU2zrMihkCV7xAU+DlWBoi/6LiX9CdsZ00yxnQ
         l8KaZXXRHK4V04Oj8J03awfjyuaaQ9PugdX/geb/emc8iQMRgjlbJGVd57GYEP0siy3r
         73GcpgMq1KYcVBAt6yRrAOgN2IDgumqBEI9mQ38FMl29S3czSXUbN3qZ87+6BDN/uuoc
         h24w==
X-Gm-Message-State: AOAM5339ojcfIB6zTMQcV98orBT+tG35JJ6p9bv+VbGkXcIbkJFZ5ACL
        0q5cdC/BTNzYHLcrJpinAN0YBnMfS+WG+a2P71+8ag==
X-Google-Smtp-Source: ABdhPJzQLvLuMmN5wbmEN7npG3SoCLzjZupQv0CWs/e9AcS+5H0TWuuSU73fL9RZeNsWqqXyGzNsLzvJbDvjswhpYxw=
X-Received: by 2002:a67:edd8:: with SMTP id e24mr3997806vsp.150.1598814351492;
 Sun, 30 Aug 2020 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200816225620.GA28218@dread.disaster.area> <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area> <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area> <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk> <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk> <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200829192522.GS1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 30 Aug 2020 21:05:40 +0200
Message-ID: <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 9:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Aug 29, 2020 at 09:13:24PM +0200, Miklos Szeredi wrote:
>
> > > d_path() is the least of the problems, actually.  Directory tree structure on
> > > those, OTOH, is a serious problem.  If you want to have getdents(2) on that
> > > shite, you want an opened descriptor that looks like a directory.  And _that_
> > > opens a large can of worms.  Because now you have fchdir(2) to cope with,
> > > lookups going through /proc/self/fd/<n>/..., etc., etc.
> >
> > Seriously, nobody wants fchdir().  And getdents() does not imply fchdir().
>
> Yes, it does.  If it's a directory, fchdir(2) gets to deal with it.
> If it's not, no getdents(2).  Unless you special-case the damn thing in
> said fchdir(2).

Huh?  f_op->iterate() needed for getdents(2) and i_op->lookup() needed
for fchdir(2).

Yes, open(..., O_ALT) would be special.  Let's call it open_alt(2) to
avoid confusion with normal open on a normal filesystem.   No special
casing anywhere at all.   It's a completely new interface that returns
a file which either has ->read/write() or ->iterate() and which points
to an inode with empty i_ops.

Thanks,
Miklos
