Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387FF20F94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfEPUXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 16:23:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50168 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEPUXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 16:23:35 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A0DE572CCD5;
        Thu, 16 May 2019 23:23:31 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8D0A47CC6FF; Thu, 16 May 2019 23:23:31 +0300 (MSK)
Date:   Thu, 16 May 2019 23:23:31 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
Message-ID: <20190516202331.GA29908@altlinux.org>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <20190516162259.GB17978@ZenIV.linux.org.uk>
 <20190516163151.urrmrueugockxtdy@brauner.io>
 <20190516165021.GD17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516165021.GD17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[looks like linux-abi is a typo, Cc'ed linux-api instead]

On Thu, May 16, 2019 at 05:50:22PM +0100, Al Viro wrote:
> [linux-abi cc'd]
> 
> On Thu, May 16, 2019 at 06:31:52PM +0200, Christian Brauner wrote:
> > On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
> > > On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
> > > > 
> > > > Hi Linus, Al,
> > > > 
> > > > Here are some patches that make changes to the mount API UAPI and two of
> > > > them really need applying, before -rc1 - if they're going to be applied at
> > > > all.
> > > 
> > > I'm fine with 2--4, but I'm not convinced that cloexec-by-default crusade
> > > makes any sense.  Could somebody give coherent arguments in favour of
> > > abandoning the existing conventions?
> > 
> > So as I said in the commit message. From a userspace perspective it's
> > more of an issue if one accidently leaks an fd to a task during exec.
> > 
> > Also, most of the time one does not want to inherit an fd during an
> > exec. It is a hazzle to always have to specify an extra flag.
> > 
> > As Al pointed out to me open() semantics are not going anywhere. Sure,
> > no argument there at all.
> > But the idea of making fds cloexec by default is only targeted at fds
> > that come from separate syscalls. fsopen(), open_tree_clone(), etc. they
> > all return fds independent of open() so it's really easy to have them
> > cloexec by default without regressing anyone and we also remove the need
> > for a bunch of separate flags for each syscall to turn them into
> > cloexec-fds. I mean, those for syscalls came with 4 separate flags to be
> > able to specify that the returned fd should be made cloexec. The other
> > way around, cloexec by default, fcntl() to remove the cloexec bit is way
> > saner imho.
> 
> Re separate flags - it is, in principle, a valid argument.  OTOH, I'm not
> sure if they need to be separate - they all have the same value and
> I don't see any reason for that to change...
> 
> Only tangentially related, but I wonder if something like close_range(from, to)
> would be a more useful approach...  That kind of open-coded loops is not
> rare in userland and kernel-side code can do them much cheaper.  Something
> like
> 	/* that exec is sensitive */
> 	unshare(CLONE_FILES);
> 	/* we don't want anything past stderr here */
> 	close_range(3, ~0U);
> 	execve(....);
> on the userland side of thing.  Comments?

glibc people need a syscall to implement closefrom properly, see
https://sourceware.org/bugzilla/show_bug.cgi?id=10353#c14


-- 
ldv
