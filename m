Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E69116032
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLHDE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 22:04:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56580 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLHDE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 22:04:27 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idmrg-00078U-Lw; Sun, 08 Dec 2019 03:04:09 +0000
Date:   Sun, 8 Dec 2019 03:04:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jeff Layton <jlayton@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v2 0/6] Delete timespec64_trunc()
Message-ID: <20191208030407.GO4203@ZenIV.linux.org.uk>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
 <CABeXuvpkYQbsvGTuktEAR8ptr478peet3EH=RD0v+nK5o2Wmjg@mail.gmail.com>
 <20191207060201.GN4203@ZenIV.linux.org.uk>
 <CABeXuvrvATrw9QfVpi1s80Duen6jf5sw+pU91yN_0f3N1xWJQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvrvATrw9QfVpi1s80Duen6jf5sw+pU91yN_0f3N1xWJQQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 07, 2019 at 06:04:38PM -0800, Deepa Dinamani wrote:
> On Fri, Dec 6, 2019 at 10:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Dec 05, 2019 at 06:43:26PM -0800, Deepa Dinamani wrote:
> > > On Mon, Dec 2, 2019 at 9:20 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > > > This series aims at deleting timespec64_trunc().
> > > > There is a new api: timestamp_truncate() that is the
> > > > replacement api. The api additionally does a limits
> > > > check on the filesystem timestamps.
> > >
> > > Al/Andrew, can one of you help merge these patches?
> >
> > Looks sane.  Could you check if #misc.timestamp looks sane to you?
> 
> Yes, that looks sane to me.
> 
> > One thing that leaves me scratching head is kernfs - surely we
> > are _not_ limited by any external layouts there, so why do we
> > need to bother with truncation?
> 
> I think I was more pedantic then, and was explicitly truncating times
> before assignment to inode timestamps. But, Arnd has since coached me
> that we should not introduce things to safe guard against all
> possibilities, but only what is needed currently. So this kernfs
> truncate is redundant, given the limits and the granularity match vfs
> timestamp representation limits.

OK...  I've tossed a followup removing the truncation from kernfs;
the whole series looks reasonably safe, but I don't think it's urgent
enough to even try getting it merged before -rc1.  So here's what
I'm going to do: immediately after -rc1 it gets renamed[*] to #imm.timestamp,
which will be in the never-modified mode, in #for-next from the very
begining and safe for other trees to pull.  Current shortlog:

Al Viro (1):
      kernfs: don't bother with timestamp truncation

Amir Goldstein (1):
      utimes: Clamp the timestamps in notify_change()

Deepa Dinamani (6):
      fs: fat: Eliminate timespec64_trunc() usage
      fs: cifs: Delete usage of timespec64_trunc
      fs: ceph: Delete timespec64_trunc() usage
      fs: ubifs: Eliminate timespec64_trunc() usage
      fs: Delete timespec64_trunc()
      fs: Do not overload update_time

Diffstat:
 fs/attr.c            | 23 +++++++++++------------
 fs/ceph/mds_client.c |  4 +---
 fs/cifs/inode.c      | 13 +++++++------
 fs/configfs/inode.c  |  9 +++------
 fs/f2fs/file.c       | 18 ++++++------------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 33 +++------------------------------
 fs/kernfs/inode.c    |  6 +++---
 fs/ntfs/inode.c      | 18 ++++++------------
 fs/ubifs/file.c      | 18 ++++++------------
 fs/ubifs/sb.c        | 11 ++++-------
 fs/utimes.c          |  4 ++--
 include/linux/fs.h   |  1 -
 13 files changed, 61 insertions(+), 107 deletions(-)

[*] right now it's based on v5.4; I don't see anything that would
warrant rebasing it to -rc1 at the moment, but if anything of that
sort shows up tomorrow, s/renamed/rebased to -rc1 and renamed/.
