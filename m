Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042391885B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 12:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEIKbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 06:31:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfEIKbu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 06:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90924ABF5;
        Thu,  9 May 2019 10:31:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 44F1C1E3C7F; Thu,  9 May 2019 12:31:47 +0200 (CEST)
Date:   Thu, 9 May 2019 12:31:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [PATCH v2] fsnotify: fix unlink performance regression
Message-ID: <20190509103147.GC23589@quack2.suse.cz>
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com>
 <20190507161928.GE4635@quack2.suse.cz>
 <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com>
 <CAOQ4uxhAyfhf2rzYxcQG_kLtiLPzihvnZymSOuzfJcY9L=QsNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhAyfhf2rzYxcQG_kLtiLPzihvnZymSOuzfJcY9L=QsNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-05-19 19:09:56, Amir Goldstein wrote:
> On Tue, May 7, 2019 at 10:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > Yes, I much prefer this solution myself and I will follow up with it,
> > but it would not be honest to suggest said solution as a stable fix
> > to the performance regression that was introduced in v5.1.
> > I think is it better if you choose between lesser evil:
> > v1 with ifdef CONFIG_FSNOTIFY to fix build issue
> > v2 as subtle as it is
> > OR another obviously safe stable fix that you can think of
> >
> > The change of cleansing d_delete() from fsnotify_nameremove()
> > requires more research and is anyway not stable tree material -
> > if not for the level of complexity, then because all the users of
> > FS_DELETE from pseudo and clustered filesystems need more time
> > to find regressions (we do not have test coverage for those in LTP).
> >
> 
> Something like this:
> https://github.com/amir73il/linux/commits/fsnotify_nameremove
> 
> Only partially tested. Obviously haven't tested all callers.

Not quite. I'd add the fsnotify_nameremove() call also to simple_rmdir()
and simple_unlink(). That takes care of:
arch/s390/hypfs/inode.c, drivers/infiniband/hw/qib/qib_fs.c,
fs/configfs/dir.c, fs/debugfs/inode.c, fs/tracefs/inode.c,
net/sunrpc/rpc_pipe.c

So you're left only with:
drivers/usb/gadget/function/f_fs.c, fs/btrfs/ioctl.c, fs/devpts/inode.c,
fs/reiserfs/xattr.c

Out of these drivers/usb/gadget/function/f_fs.c and fs/reiserfs/xattr.c
actually also don't want the notifications to be generated. They don't
generate events on file creation AFAICS and at least in case of reiserfs I
know that xattrs are handled in "hidden" system files so notification does
not make any sense. So we are left with exactly *two* places that need
explicit fsnotify_nameremove() call. Since both these callers already take
care of calling fsnotify_create() I think that having explicit
fsnotify_nameremove() calls there is clearer than the current state.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
