Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB930DD0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 15:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhBCOkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 09:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhBCOjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:39:47 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55AAC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 06:39:06 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v19so13183258vsf.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW5gHlZvvZ0E3mwnAn4SmU4riSNDauzI8Ays9OXlQLA=;
        b=cKQP+2s3Ps2xDgPvQCH4c6d1cBbDj1uCyjJiVKAXpqtl0+ifzBpAtKIAu43a1Jb5s2
         49FblmdIPmGV+d+l7SaOtx3l9YGbntQ4uyENhDzvwreNxnW4gW8AajHrgsaaYn+EfaJs
         7rW7QsH4DOpZaz9UXWN511uJQi1zwvcmwvbg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW5gHlZvvZ0E3mwnAn4SmU4riSNDauzI8Ays9OXlQLA=;
        b=I8fnXNn6fxcDDvcKmDUmJEflZrF4wESb+sFOOe4mcvWCvXifrjcwdjYdY2UqdzuCND
         g4qK/nFtFmaTsJO51LW2cPd8qqklNhXNVWrR/0W08vzEh6H73xCP9envSsRU8tzjPbc2
         UEKEmLWVgk7NliS5lkUpzZJBsTLNDr1pbR1AWb9iqOB1hX2jgKOUuI7l5NAFIGIFRmF/
         323bJmWBKX8tyo2xfr1hfqFowYx+tKVxbQcIiMSr44QyTTS9gAxj9vF0OE26mKIQPtyP
         H27UjyJOOFq9+lPxkT2C3OaQi3ervp9hWGQnlMIjJkyUE+b7oJgeqTisa/KlKqCvklpK
         Cdtw==
X-Gm-Message-State: AOAM531goL8y/zdoaNoekqXYFEgA8wdPUT4kNzW+zIkf1kCi4tg22lud
        XxM4bGpFno1dkstnPFAYkFOKYeaxQVaMq5vpabJtps8wDj4=
X-Google-Smtp-Source: ABdhPJxeBKgQ8q/ylDJnkRSBHqJWzJR7TD2pH2ekp4FHA4uRIeaHALvEX9m7BkqbdlqQUQs4UY5fIpQeKlNJUfKgma0=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr1707706vso.47.1612363146079;
 Wed, 03 Feb 2021 06:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org> <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
 <20210203142802.GA308988@casper.infradead.org>
In-Reply-To: <20210203142802.GA308988@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Feb 2021 15:38:54 +0100
Message-ID: <CAJfpegtW5-XObARX87A8siTJNxTCkzXG=QY5tTRXVUvHXXZn3g@mail.gmail.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:28 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 03, 2021 at 03:13:29PM +0100, Miklos Szeredi wrote:
> > On Wed, Feb 3, 2021 at 2:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > Network filesystems frequently need to use the credentials attached to
> > > a struct file in order to communicate with the server.  There's no point
> > > fighting this reality.
> >
> > IDGI.  Credentials can be taken from the file and from the task.  In
> > this case every filesystem except cifs looks at task creds. Why are
> > network filesystem special in this respect?
>
> I don't necessarily mean 'struct cred'.  I mean "the authentication
> that the client has performed to the server".  Which is not a per-task
> thing, it's stored in the struct file, which is why we have things like
>
>         int (*write_begin)(struct file *, struct address_space *mapping,
>                                 loff_t pos, unsigned len, unsigned flags,
>                                 struct page **pagep, void **fsdata);
>
> disk filesystems ignore the struct file argument, but network filesystems
> very much use it.

Fine for file I/O.  That's authorized at open time for all
filesystems, not just network ones.

Not fine for metadata operations (IMO).   I.e. ->[gs]etattr() don't
take a file argument either, even though on the uAPI there are plenty
of open file based variants.

Thanks,
Miklos
