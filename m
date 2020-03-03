Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE56177734
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgCCNey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:34:54 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43237 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgCCNey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:34:54 -0500
Received: by mail-il1-f194.google.com with SMTP id o18so2724124ilg.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8UZDr3lZGFyJivNM6em5ybzB9qz5QGiZZazZdznXqk=;
        b=eEQq5fiMKdVd42vqfExJKz3i8PtBQaz26xc++cNx+VS/zkeI5e09ipMisnSMiHdrf5
         u+xmYZFz/xI0z/5+EySdWurVl96IIsUyghbPc5Vppji0ZZ9iQNhE7e1tgdNfKcxWAAes
         y80ESNGhn+KNkkn+eLigS588MUERmZAN3AgMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8UZDr3lZGFyJivNM6em5ybzB9qz5QGiZZazZdznXqk=;
        b=HUoXz8pRJzujbm0WLUOiQHxpRD+TN74EFHA00KItCB3o8ha4TmmUIvSCcbJJpe8Z5J
         N/OC5PieHdA5f0bxhVOfUK8oUssJEfOulxogbhPg0MXIqrqhiuBVUmYXiyGv8UlojrDc
         aYKofgrjCaeNWBwX4yvR9jIGzJX0CBRBzHu1rKS2+vsId1GGAiyDLp9ob5vxiqtVNjAF
         a+88ZAV7jcFeVNpAcxALQiJSV6WMNC1RwZ+odis2+czuBNjnuK0crxS0jEcG7/CpG9+g
         b3AeBbf8ulOM+uig5pL4TbfCI7xrrFW7lyM4JIpQD/RYYrNhugqfcAr5YGtPNgTNGmHL
         UPFA==
X-Gm-Message-State: ANhLgQ20G/dPNX8/98evCErzj7iirUckEMIjRw+jaSQj93L451J0kC2x
        CMXBEvR7luzcX3fV5ZhcJjvBVQVpspOWodu+MN+l3g==
X-Google-Smtp-Source: ADFU+vse5bB7gLvCvFy8XryGmsALFqGE4Oyf3LKEtJstP+x5Mc4KlKOxwSw8ylASXSSbsPp5ZHBKAyS4fw1aRsVzAO8=
X-Received: by 2002:a92:8847:: with SMTP id h68mr4667878ild.212.1583242493712;
 Tue, 03 Mar 2020 05:34:53 -0800 (PST)
MIME-Version: 1.0
References: <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
In-Reply-To: <20200303131434.GA2373427@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 14:34:42 +0100
Message-ID: <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> > Unlimited beers for a 21-line kernel patch?  Sign me up!
> >
> > Totally untested, barely compiled patch below.
>
> Ok, that didn't even build, let me try this for real now...

Some comments on the interface:

O_LARGEFILE can be unconditional, since offsets are not exposed to the caller.

Use the openat2 style arguments; limit the accepted flags to sane ones
(e.g. don't let this syscall create a file).

If buffer is too small to fit the whole file, return error.

Verify that the number of bytes read matches the file size, otherwise
return error (may need to loop?).

Thanks,
Miklos
