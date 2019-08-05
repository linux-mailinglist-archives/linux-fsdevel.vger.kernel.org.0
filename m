Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5927481F52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfHEOks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 10:40:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40441 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfHEOks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:40:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so60253023qke.7;
        Mon, 05 Aug 2019 07:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRGlfvIBEGnhMOSaUFrH+SBTE1znMskWY0KJq2yKr84=;
        b=APuble2BpXARG4jU2DYGB4NSX8yam4ci9ypYe5T8eO3mED1q+6uNR/K1PVpes5zpfz
         QCwOCOYGsyGKslsSgoSZ5LPoBDiW4WXm4lxNHFQAOYUE4rWyj/cJwu3Z6mYlkTSIKPRy
         0upin2VVKOR7Ur6ZEdadeZQrc51LrVUti/zo2c+mbub84+rYiTUs4J9TbH2SZNYWiGVp
         QzXsahOGGJKy2tdbHFrgoT90odsC12RSozVFL95Zqayano7/QvpcMRUWuodaILd4fsZ4
         GwFQIMOnFQBk29uM82b5ozXjSiXrkABX8dnsqRQRjiv7I9faMLa0nHaa7ICFTCfBa7cj
         IspQ==
X-Gm-Message-State: APjAAAWGoHaLxCPVAGh2feIEfY39f/6tW3a42bC4R6fKCoKJJgvmN6Tk
        XynbPE3EqxCPO1qgOrzqbfNQv9dXLYG+Se0VYpQ=
X-Google-Smtp-Source: APXvYqwXqRGhG17IavERVcPoGwtZvnFSRNz3XsmJ1I/UDszwO/ygv4rz7O1F3vn/+nsBTx+KYhsS4l9y4SQRsLMtA4w=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr102886994qkb.286.1565016047182;
 Mon, 05 Aug 2019 07:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-5-deepa.kernel@gmail.com>
 <eb2027cdccc0a0ff0a9d061fa8dd04a927c63819.camel@codethink.co.uk>
In-Reply-To: <eb2027cdccc0a0ff0a9d061fa8dd04a927c63819.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Aug 2019 16:40:30 +0200
Message-ID: <CAK8P3a0a0ZvwagKa00Q-SCK=6mMcD0dv=wzbOk8D7B9pj4eWrg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 5, 2019 at 4:12 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > The warning reuses the uptime max of 30 years used by the
> > setitimeofday().
> >
> > Note that the warning is only added for new filesystem mounts
> > through the mount syscall. Automounts do not have the same warning.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> >  fs/namespace.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index b26778bdc236..5314fac8035e 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2739,6 +2739,17 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
> >       error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
> >       if (error < 0)
> >               mntput(mnt);
> > +
> > +     if (!error && sb->s_time_max &&
>
> I don't know why you are testing sb->s_time_max here - it should always
> be non-zero since alloc_super() sets it to TIME64_MAX.

I think we support some writable file systems that have no timestamps
at all, so both the minimum and maximum default to 0 (1970-01-01).

For these, there is no point in printing a warning, they just work
as designed, even though the maximum is expired.

       Arnd
