Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF78E1A3B9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 22:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDIU7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 16:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDIU7p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:59:45 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F4F32082D;
        Thu,  9 Apr 2020 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586465984;
        bh=/zoh9Bel3OVki0JgUa51ErfZPh3PKGwN0xm71H6gVlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bJAJpPoprDQK92N85fpzG0cgNvz0uW5e2GuCCkn3PP348hQvPcVPLpsxEGBwIDmOe
         1QFW0xWU0pO2wsvNKS4EEfebkJ6KlsEo0+gmu78w3ZBZtXz+apwLu8pyuGYs1Ec2EH
         nWr6NEKRZpWA7DcYfEQAtGmxuemkzAn03uShNjvQ=
Received: by mail-ua1-f51.google.com with SMTP id c7so504528uap.12;
        Thu, 09 Apr 2020 13:59:44 -0700 (PDT)
X-Gm-Message-State: AGi0PuYgbkSjEZ1xaIwkV5+Rx1MebEdjXUnUff0lar/+AkG6xiJjPKuD
        DDqo9ts1XwqTwxEmXdS1D5o6Vvt8vQ34jgeghwQ=
X-Google-Smtp-Source: APiQypLTqSBtxs7bQ0LuVti900RTFBk5ZczjHXpDHPi1M3iHr7okU6jbk0ejw87EuNLYNl/1repOvHUGiSiDx2g6XJ8=
X-Received: by 2002:ab0:1e89:: with SMTP id o9mr829993uak.93.1586465983383;
 Thu, 09 Apr 2020 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200402000002.7442-1-mcgrof@kernel.org> <20200403081929.GC6887@ming.t460p>
 <0e753195-72fb-ce83-16a1-176f2c3cea6a@huawei.com> <20200407190004.GG11244@42.do-not-panic.com>
In-Reply-To: <20200407190004.GG11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 9 Apr 2020 14:59:36 -0600
X-Gmail-Original-Message-ID: <CAB=NE6VV1yCOHJC__qAXNmxfe45DB=JaUksLeXV=dp-VAa6jnA@mail.gmail.com>
Message-ID: <CAB=NE6VV1yCOHJC__qAXNmxfe45DB=JaUksLeXV=dp-VAa6jnA@mail.gmail.com>
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Michal Hocko <mhocko@suse.com>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:00 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Apr 07, 2020 at 10:47:01AM +0800, yukuai (C) wrote:
> > On 2020/4/3 16:19, Ming Lei wrote:
> >
> > > BTW, Yu Kuai posted one patch for this issue, looks that approach
> > > is simpler:
> > >
> > > https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@hu=
awei.com/
> > >
> > >
> >
> > I think the issue might not be fixed with the patch seires.
> >
> > At first, I think there are two key points for the issure:
> > 1. The final release of queue is delayed in a workqueue
> > 2. The creation of 'q->debugfs_dir' might failed(only if 1 exist)
> > And if we can fix any of the above problem, the UAF issue will be fixed=
.
> > (BTW, I did not come up with a good idea for problem 1, and my approach
> > is for problem 2.)
> >
> > The third patch "block: avoid deferral of blk_release_queue() work" is
> > not enough to fix problem 1:
> > a. if CONFIG_DEBUG_KOBJECT_RELEASE is enable:
> > static void kobject_release(struct kref *kref)
> > {
> >         struct kobject *kobj =3D container_of(kref, struct kobject, kre=
f);
> > #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> >         unsigned long delay =3D HZ + HZ * (get_random_int() & 0x3);
> >         pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
> >                 =E2=94=8Akobject_name(kobj), kobj, __func__, kobj->pare=
nt, delay);
> >         INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
> >
> >         schedule_delayed_work(&kobj->release, delay);
> > #else
> >         kobject_cleanup(kobj);
> > #endif
> > }
> > b. when 'kobject_put' is called from blk_cleanup_queue, can we make sur=
e
> > it is the last reference?
>
> You are right, I think I know the fix for this now. Will run some more
> tests.

Yeap, we were just not refcounting during blktrace. I'll send a fix as
part of the series.

  Luis
