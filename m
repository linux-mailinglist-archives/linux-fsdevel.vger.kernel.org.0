Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F902625F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 05:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIIDpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 23:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIIDpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:45:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F8C061573;
        Tue,  8 Sep 2020 20:45:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so1703323ioe.5;
        Tue, 08 Sep 2020 20:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKVyM7ut9ZZjQs7h3wiCaFahe4SYFhTWRIRyTVbYRzw=;
        b=KKc+Xzhwi01RS4qb73Ah5QZ8WwZyUORdSb6CWV7MquaLStuyGYfxTw+2zsY5+xC/Fv
         Bqf4uPpoXzilurb5FcC9PKSLqV6SWUuIlRE6BduZRxex3xrzM4QtVrD8MG5UXPNyFbnq
         iwmM8yKMOjZRB5VGpzeNVnt6RCCExkPWMpP05lUDCe5n7+z0g971MerxbUHoRrmikVD0
         W41R21celyvs5AGqixt8bUXIZ9Cs+zyyF4LufR6DLeUfgYFoW+GG4NpSt408PHqLsnhh
         /x9q7wT9oH5aorFZa/rbmSCNJOGxzuVsIc2ueYhbWhvUv26w5FqFg3FZ1xmdDmhZG8hL
         xC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKVyM7ut9ZZjQs7h3wiCaFahe4SYFhTWRIRyTVbYRzw=;
        b=JNUD+7enZtmcrwi7Z+batnBJDZXxDbnvWdq+9ynSnRVYsGHspDUJoN8sbFC3VYmTqx
         fHDXsZviIZ2ib24/ceLZraM+NlfVjkGVIBnP5fgurObosRPm21BnhqeVY/UN1zJFc7Jp
         tI+o0vPk7RMkytWpmH1SuFAwj/cVs9WZtskFdxtVnr9F8yRvjDWXjyyUgK2WuUEItCXp
         jrCvTWSXVKAY4G6J+O+SBAkOVKOe+C0eo4YZJjMnIecP16pg+JPE84WsB4/soKF+1EQ5
         LfcHfGs35fl5ZClSIRVkKXXf0Bu/58UrnGzMpH3FxrJTJ4HYZPMUAjmDcW+kJZr9DZzZ
         3ltw==
X-Gm-Message-State: AOAM533PF1FVmsdJD4COVzzltSAu8GxGiTGgXMnxI+sh10ZW+oVzXxpA
        KZZ3c4AOw6F1HrUwsrCjZdUELNG/9W6KD+vaM3U=
X-Google-Smtp-Source: ABdhPJwgPstjLD3CyT6yPsr+bwYObuvj6GM+FLH76/hQ1inYWHlvW1S14g/UIRSrt8FUl0QaBxNk23q68jb7R+4Dymo=
X-Received: by 2002:a02:734f:: with SMTP id a15mr2280833jae.120.1599623100911;
 Tue, 08 Sep 2020 20:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
 <CAOQ4uxhejJzjKLZCt=b87KAX0sC3RAZ2FHEZbu4188Ar-bkmOg@mail.gmail.com>
 <e399cd17-e95e-def4-e03b-5cc2ae1f9708@huawei.com> <CAOQ4uxgvodepq2ZhmGEpkZYj017tH_pk2AgV=pUhWiONnxOQjw@mail.gmail.com>
 <20200908171859.GA29953@casper.infradead.org>
In-Reply-To: <20200908171859.GA29953@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 9 Sep 2020 06:44:49 +0300
Message-ID: <CAOQ4uxjX2GAJhD70=6SmwdXPH6TuOzGugtdYupDjLLywC2H5Ag@mail.gmail.com>
Subject: Re: Question: Why is there no notification when a file is opened
 using filp_open()?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangle6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:19 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Sep 08, 2020 at 04:18:29PM +0300, Amir Goldstein wrote:
> > On Tue, Sep 8, 2020 at 3:53 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > > For example, in fs/coredump.c, do_coredump() calls filp_open() to
> > > generate core files.
> > > In this scenario, the fsnotify_open() notification is missing.
> >
> > I am not convinced that we should generate an event.
> > You will have to explain in what is the real world use case that requires this
> > event to be generated.
>
> Take the typical usage for fsnotify of a graphical file manager.
> It would be nice if the file manager showed a corefile as soon as it
> appeared in a directory rather than waiting until some other operation
> in that directory caused those directory contents to be refreshed.

fsnotify_open() is not the correct notification for file managers IMO.
fsnotify_create() is and it will be called in this case.

If the reason you are interested in open events is because you want
to monitor the entire filesystem then welcome to the future -
FAN_CREATE is supported since kernel v5.1.

Is there another real life case you have in mind where you think users
should be able to get an open fd for a file that the kernel has opened?
Because that is what FAN_OPEN will do.

Thanks,
Amir.
