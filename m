Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A88122307
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLQERK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:17:10 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45870 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQERJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:17:09 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so7263507iln.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 20:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7O10rl7kJQ2ahW8XNMmevOgzx7a7j7fHGspkTr6vCQ=;
        b=EUvHVje6bA42GtKJPlIjuLXgC5vsULCqdbLwZz28T6ClDF+sP2VyB33JVl3a1sJU08
         M1kKK3oY+bX1al403jSp5cBl6clabcReSgXWhJVYOBe6OBQJueA5HTjzO9qAvK7OixbZ
         oPAx40uIx++TZoM63wTACSIQxeBEMAEMxLSm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7O10rl7kJQ2ahW8XNMmevOgzx7a7j7fHGspkTr6vCQ=;
        b=qFS1P+InT/5Y+OPeazjS7t05LzmOq3uPYFNxl4G8tcfm5I1m8tmF8uChX/JUiR1ljp
         xvej9W6uvur3f4jU2Mz0ALS2mG/KlTzI3lUDTXSL5tgOUlA/x5XbLQOSjYl5VK6hRQ++
         sZc0g9ox7YGh7siPSktnWdkPdo37V6eq6B77z75Uw0yxZPoOYHg+AUFz4FfWMOC26OYv
         WQJZ3aMbMVUt1DYurgTEP+FT65fqYkVmjRfDtwurR1BxAvcHLadtfp5dfAiI0Z/dhWgh
         GiayYMzdEDYm9MYi5H57MYss4yo+hXmKpSFDBvEWKFhgQ6Wq2BOJBocdqNvEEIlFpW3j
         KyAw==
X-Gm-Message-State: APjAAAUG3jQwLlH3nfDAg+V28i4qlKuRp2m12k/uqD/7N2QPGltm2x/i
        ezx2sYr6uGRedB//x7eibAEled1gbZ+1qpTMcPLTEw==
X-Google-Smtp-Source: APXvYqyc5IuFpA5rZBYO1BDa2BqoyGrF3Q9ReE/kKbAP5jsKeJsEziK1hw6LCKdNIncFZsfklXlbI018pqwD6juTV0s=
X-Received: by 2002:a92:3bd3:: with SMTP id n80mr15577366ilh.174.1576556229166;
 Mon, 16 Dec 2019 20:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-13-mszeredi@redhat.com>
 <20191217033721.GS4203@ZenIV.linux.org.uk> <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
In-Reply-To: <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 05:16:58 +0100
Message-ID: <CAJfpegt=QugsQWW7NXGiOpYVSjMVfZRLhJLyq8KTsE47H_tRZg@mail.gmail.com>
Subject: Re: [PATCH 12/12] vfs: don't parse "silent" option
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:12 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Dec 17, 2019 at 4:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Nov 28, 2019 at 04:59:40PM +0100, Miklos Szeredi wrote:
> > > While this is a standard option as documented in mount(8), it is ignored by
> > > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > > it.
> > >
> > > The exception is unconverted filesystems, where it is unknown if the
> > > filesystem handles this or not.
> > >
> > > Any implementation, such as mount(8), that needs to parse this option
> > > without failing can simply ignore the return value from fsconfig().
> >
> > Unless I'm missing something, that will mean that having it in /etc/fstab
> > for a converted filesystem (xfs, for example) will fail when booting
> > new kernel with existing /sbin/mount.  Doesn't sound like a good idea...
>
> Nope, the mount(2) case is not changed (see second hunk).

Wrong, this has nothing to do with mount(2).  The second hunk is about
unconverted filesystems...

When a filesystem that really needs to handle "silent" is converted,
it can handle that option itself.

Thanks,
Miklos
