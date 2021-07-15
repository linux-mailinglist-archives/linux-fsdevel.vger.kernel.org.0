Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CC3C9BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhGOJe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:34:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49880 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhGOJeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:34:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1AB1222924;
        Thu, 15 Jul 2021 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626341478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BiEOXaAhNfaK+uoOQNX0TiOjwvYsZy9v/7XAXayxtXM=;
        b=zHm4wEiRUKs7r2kBC9pzE9X6GlNhgY8lfeiD99Ek1ENKlMzm23v4gBuKt7p23JiJDYM29f
        a54SqohiFj+CwHbD7dTsF8MPRrWLxI+ibZF0d9DIrlA+ctarqi+dG6IcvEoIMFvVFuLBSD
        kYnlyRaS4XbEPkihhDML50mtfypRj7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626341478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BiEOXaAhNfaK+uoOQNX0TiOjwvYsZy9v/7XAXayxtXM=;
        b=sdrUrIgfRX1lxObijjKWQ56g67OntJNXZjI1CwT9CJwppTiY3JGCwo85yB66M8pFbbo1zD
        SvBlisbZnEyqIyBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 0BE6AA3B9C;
        Thu, 15 Jul 2021 09:31:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF8451E0BF2; Thu, 15 Jul 2021 11:31:17 +0200 (CEST)
Date:   Thu, 15 Jul 2021 11:31:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Boyang Xue <bxue@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <20210715093117.GD9457@quack2.suse.cz>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO93VTcLDNisdHRf@carbon.dhcp.thefacebook.com>
 <CAHLe9YaNtmJ8xx=A+6Ki+Fc2Kx=5jL745NJ8PL+w95-WhJrG3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YaNtmJ8xx=A+6Ki+Fc2Kx=5jL745NJ8PL+w95-WhJrG3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-07-21 09:42:06, Boyang Xue wrote:
> On Thu, Jul 15, 2021 at 7:46 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > Hi Jan,
> > >
> > > On Wed, Jul 14, 2021 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> > > > > Hi Roman,
> > > > >
> > > > > On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > I'm not sure if this is the right place to report this bug, please
> > > > > > > correct me if I'm wrong.
> > > > > > >
> > > > > > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > > > > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > > > > > it looks like the bug had been introduced by the commit
> > > > > > >
> > > > > > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > > > > > >
> > > > > > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > > > > > was performed with the latest xfstests, and the bug can be reproduced
> > > > > > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> > > > > >
> > > > > > Hello Boyang,
> > > > > >
> > > > > > thank you for the report!
> > > > > >
> > > > > > Do you know on which line the oops happens?
> > > > >
> > > > > I was trying to inspect the vmcore with crash utility, but
> > > > > unfortunately it doesn't work.
> > > >
> > > > Thanks for report!  Have you tried addr2line utility? Looking at the oops I
> > > > can see:
> > >
> > > Thanks for the tips!
> > >
> > > It's unclear to me that where to find the required address in the
> > > addr2line command line, i.e.
> > >
> > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > <what address here?>
> >
> > You can use $nm <vmlinux> to get an address of cleanup_offline_cgwbs_workfn()
> > and then add 0x320.
> 
> Thanks! Hope the following helps:

Thanks for the data! 

> static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> {
>         struct bdi_writeback *wb;
>         LIST_HEAD(processed);
> 
>         spin_lock_irq(&cgwb_lock);
> 
>         while (!list_empty(&offline_cgwbs)) {
>                 wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
>                                       offline_node);
>                 list_move(&wb->offline_node, &processed);
> 
>                 /*
>                  * If wb is dirty, cleaning up the writeback by switching
>                  * attached inodes will result in an effective removal of any
>                  * bandwidth restrictions, which isn't the goal.  Instead,
>                  * it can be postponed until the next time, when all io
>                  * will be likely completed.  If in the meantime some inodes
>                  * will get re-dirtied, they should be eventually switched to
>                  * a new cgwb.
>                  */
>                 if (wb_has_dirty_io(wb))
>                         continue;
> 
>                 if (!wb_tryget(wb))  <=== line#679
>                         continue;

Aha, interesting. So it seems we crashed trying to dereference
wb->refcnt->data. So it looks like cgwb_release_workfn() raced with
cleanup_offline_cgwbs_workfn() and percpu_ref_exit() got called from
cgwb_release_workfn() and then cleanup_offline_cgwbs_workfn() called
wb_tryget(). I think the proper fix is to move:

        spin_lock_irq(&cgwb_lock);
        list_del(&wb->offline_node);
        spin_unlock_irq(&cgwb_lock);

in cgwb_release_workfn() to the beginning of that function so that we are
sure even cleanup_offline_cgwbs_workfn() cannot be working with the wb when
it is being released. Roman?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
