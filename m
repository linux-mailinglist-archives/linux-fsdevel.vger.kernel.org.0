Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0882172F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 04:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgB1DCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 22:02:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52602 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgB1DCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:02:02 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Vua-002Boa-UI; Fri, 28 Feb 2020 03:02:01 +0000
Date:   Fri, 28 Feb 2020 03:02:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v2)
Message-ID: <20200228030200.GH23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200225012457.GA138294@ZenIV.linux.org.uk>
 <20200228012451.upnq5r7fdctrk7pv@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228012451.upnq5r7fdctrk7pv@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 12:24:51PM +1100, Aleksa Sarai wrote:

> > Another one is about LOOKUP_NO_XDEV again: suppose you have process'
> > root directly overmounted and cwd in the root of whatever's overmounting
> > it.  Resolution of .. will stay in cwd - we have no parent within the
> > chroot jail we are in, so we move to whatever's overmounting that root.
> > Which is the original location.  Should we fail on LOOKUP_NO_XDEV here?
> > Plain .. in the root of chroot jail (not overmounted by anything) does
> > *not*...
> 
> I think LOOKUP_NO_XDEV should block that since you end up crossing a
> mountpoint.

You are not.  Your process' root is overmounted and your current directory
is on that overmount.  You attempt to resolve ".." there.

# cd /
# unshare -m
# stat .
  File: .
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 801h/2049d      Inode: 2           Links: 25
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-02-26 20:51:06.623409892 -0500
Modify: 2020-02-26 20:43:51.284020000 -0500
Change: 2020-02-26 20:43:51.284020000 -0500
 Birth: -
# mkdir /tmp/foo
# mount -t tmpfs none /tmp/foo/
# for i in *; do test -d $i && mkdir /tmp/foo/$i && mount --rbind $i /tmp/foo/$i; done
# cd /tmp/foo/
# mount --move . /
# /bin/pwd
/
# ls
bin   dev  home  lib32  libx32      ltp    mnt  proc  run   srv  tmp  var
boot  etc  lib   lib64  lost+found  media  opt  root  sbin  sys  usr
# ls /
253_metadump  etc             lib32       media  run   usr
315.full      home            lib64       mnt    sbin  var
bin           initrd.img      libx32      opt    srv   vmlinuz
boot          initrd.img.old  lost+found  proc   sys   vmlinuz.old
dev           lib             ltp         root   tmp
# stat ..
  File: ..
  Size: 500             Blocks: 0          IO Block: 4096   directory
Device: 19h/25d Inode: 1875746     Links: 25
Access: (1777/drwxrwxrwt)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-02-27 21:48:45.649705410 -0500
Modify: 2020-02-27 21:46:40.829607188 -0500
Change: 2020-02-27 21:46:40.829607188 -0500
 Birth: -
# stat .
  File: .
  Size: 500             Blocks: 0          IO Block: 4096   directory
Device: 19h/25d Inode: 1875746     Links: 25
Access: (1777/drwxrwxrwt)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-02-27 21:48:45.649705410 -0500
Modify: 2020-02-27 21:46:40.829607188 -0500
Change: 2020-02-27 21:46:40.829607188 -0500
 Birth: -


See what's going on?  We have a tmpfs overmounting root; current directory
is the root of tmpfs; process root is on ext3.  Lookups for . and .. yield
exactly the same result here - we stay in the root of tmpfs.

Anyway, see #work.dotdot in vfs.git
