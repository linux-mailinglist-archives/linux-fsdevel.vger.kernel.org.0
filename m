Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C301AD510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgDQEJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 00:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgDQEJf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 00:09:35 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF70922250;
        Fri, 17 Apr 2020 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587096575;
        bh=/aAOMVOP3MZQGTBFo0xdiu+n9iKYVv70X4AkPfYDRUY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gyt0aCIAKdLM3LASetND1QH5Wfx32kCgTTnBxG2zuGNZrZ5A+Uuyt+EWvqojWwS5D
         zo4tgkaCD0hTcasyZJ7j/nTI6TtMjrTbvxEv3IIfeepWgrn5l7XiWcWDXVNXOJm1L+
         +zIEAsvTYvKFPhvJ4etnosn3KdqzsUfe3B4cENx8=
Received: by mail-ej1-f45.google.com with SMTP id s9so562727eju.1;
        Thu, 16 Apr 2020 21:09:34 -0700 (PDT)
X-Gm-Message-State: AGi0PuZNPhNoQAkTKyBDr33jnGgVBB9DN5jxGH+ZDHjahcuPmUK5fbz/
        JuKsLUQp6g23YwDG/75hsDcrkp5qhVRaUNb6Zp4=
X-Google-Smtp-Source: APiQypIdKCMgMXNdIoKxA+hJgxlg7THMOt/IQ9RE95/qKc1hrmrQknmbKq/g59E4lMJ6Zg4qLEjnmgHh/BtY8F2Saqg=
X-Received: by 2002:a17:906:7c2:: with SMTP id m2mr1049847ejc.339.1587096573102;
 Thu, 16 Apr 2020 21:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200414041902.16769-1-mcgrof@kernel.org> <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590> <20200416052524.GH11244@42.do-not-panic.com>
 <20200416054750.GA2723777@T590> <20200416062054.GL11244@42.do-not-panic.com> <20200416062856.GD2723777@T590>
In-Reply-To: <20200416062856.GD2723777@T590>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 16 Apr 2020 22:09:24 -0600
X-Gmail-Original-Message-ID: <CAB=NE6VFj4w_o+NA57iBzGaXCGF0afeHy1N_2C9awGcFz5pnQw@mail.gmail.com>
Message-ID: <CAB=NE6VFj4w_o+NA57iBzGaXCGF0afeHy1N_2C9awGcFz5pnQw@mail.gmail.com>
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, yu kuai <yukuai3@huawei.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:29 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Thu, Apr 16, 2020 at 06:20:54AM +0000, Luis Chamberlain wrote:
> > On Thu, Apr 16, 2020 at 01:47:50PM +0800, Ming Lei wrote:
> > > On Thu, Apr 16, 2020 at 05:25:24AM +0000, Luis Chamberlain wrote:
> > > > On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> > > > > In theory, multiple partitions can be traced concurrently, but looks
> > > > > it never works, so it won't cause trouble for multiple partition trace.
> > > > >
> > > > > One userspace visible change is that blktrace debugfs dir name is switched
> > > > > to disk name from partition name in case of partition trace, will it
> > > > > break some utilities?
> > > >
> > > > How is this possible, its not clear to me, we go from:
> > > >
> > > > - q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > > -                                     blk_debugfs_root);
> > > >
> > > > To this:
> > > >
> > > > + q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > > +                                     blk_debugfs_root);
> > > >
> > > >
> > > > Maybe I am overlooking something.
> > >
> > > Your patch removes the blktrace debugfs dir:
> > >
> > > do_blk_trace_setup()
> > >
> > > -       dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > > -       if (!dir)
> > > -               bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > > -
> > >
> > > Then create blktrace attributes under the dir of q->debugfs_dir.
> > >
> > > However, buts->name could be one partition device name, but
> >
> > I can see how buts->name is set to bdevname() which expands to
> > disk_name(bdev->bd_disk, bdev->bd_part->partno, buf).
> >
> > > q->debugfs_dir has to be disk name.
> >
> > I can't see this, can you point me to where it is clear the
> > request_queue kobject's parent is sure to be the disk name?
>
> blk_register_queue():
>         ...
>         ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
>         ...

Alright, I have a fix for this now, and I do have also a further
explanation as to *why* the debugfs_lookup() doesn't help us here.
I'll follow up with more patches.

  Luis
