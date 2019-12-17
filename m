Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DAE12230E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLQES2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:18:28 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35567 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfLQES1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:18:27 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so8511729iol.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 20:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jb9M+rbRjnA9WExGlqoiB6hucEgbZvrJ0pX83Vp94eg=;
        b=DvTbOKYI8phw0PI0t2+8p4vSY+wjq7KSoWrGlyfFeM5oI+1Bg4N3oZAMUsoQJNl0gI
         sgc8wFV1ynwzqBQ/PTWd2kU+xELxWE4mYEldSPvMWVEXpkiINQMxcDTNPRDpZCtBwVue
         Q1YdrI14QoDWEnRAekWwpKGIMKe/7VcGzsTrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jb9M+rbRjnA9WExGlqoiB6hucEgbZvrJ0pX83Vp94eg=;
        b=X+iMQhnyySf5uuBE9sEwWi+suXD41YBv48tuajFo9fIzzYKX7RAsjs4nriy70RhY98
         QxFvyHPMfybsp9Kij2yk6onmu0rwGq+SBEGFmjlPe/isMoV+/+qmcZQRNtUq2IXDiROw
         Ag/TY17JamOHzuFkcBKeApNapezzvYgHDsvbseRgRLGnKH8z01CId3ygNXKHp1dUakeB
         OWhlnKrxca2c1YhYke+PFAahrziL526OPyzLy2SM3X5sgC6wUFP0Ls3uEe8F5Ji4IJ/I
         4ctccW/GicC+jFYCbdqynhY74tcK06zFb1TSUgifqAkH/PLgZLmkadyEPVdPUOQdTvCq
         OngA==
X-Gm-Message-State: APjAAAUNZgJSy5jwD/5A+Ro6EQEPpBJSYGr+MqRqNULpqj4M4q6AuAT4
        XPttNX8+RA5/MJSHKCCnkABU9rdp4Dcg2vERRtR19g==
X-Google-Smtp-Source: APXvYqyivWqHpq34LL112ySk4nWx9NJjR+yoiXLQHbvhymFpkotIDQ4B0u6OLe3cOqHTQkNVLLbEOP+wCw9CM3cOrK4=
X-Received: by 2002:a6b:f404:: with SMTP id i4mr2181275iog.252.1576556307220;
 Mon, 16 Dec 2019 20:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-12-mszeredi@redhat.com>
 <20191217034252.GT4203@ZenIV.linux.org.uk>
In-Reply-To: <20191217034252.GT4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 05:18:16 +0100
Message-ID: <CAJfpegs73zMDonGo+SmxHUqQMsXp6p8kOWj6+jdjJtJiMUgonw@mail.gmail.com>
Subject: Re: [PATCH 11/12] vfs: don't parse "posixacl" option
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 4:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Nov 28, 2019 at 04:59:39PM +0100, Miklos Szeredi wrote:
> > Unlike the others, this is _not_ a standard option accepted by mount(8).
> >
> > In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
> > mount(2) interface is possibly a bug.
> >
> > The only filesystem that apparently wants to handle the "posixacl" option
> > is 9p, but it has special handling of that option besides setting
> > SB_POSIXACL.
>
> Huh?  For e.g. ceph having -o posixacl and -o acl are currently equivalent;
> your patch would seem to break that, wouldn't it?

Yet again, this has nothing to do with mount(2) behavior.  Also note
that mount(8) does *not* handle "posixacl" and does *not* ever set
MS_POSIXACL.

So this has exactly zero chance of breaking anything.

Thanks,
Miklos
