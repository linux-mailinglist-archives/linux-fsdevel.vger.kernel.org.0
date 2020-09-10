Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7741E264ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIJROz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:14:55 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:52456 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIJQf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:35:29 -0400
Date:   Thu, 10 Sep 2020 12:35:24 -0400
From:   Rich Felker <dalias@libc.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910163524.GI3265@brightrain.aerifal.cx>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
 <20200910161615.GA1180022@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910161615.GA1180022@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:16:15PM +0200, Greg KH wrote:
> On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> > POSIX defines fchmodat as having a 4th argument, flags, that can be
> > AT_SYMLINK_NOFOLLOW. Support for changing the access mode of symbolic
> > links is optional (EOPNOTSUPP allowed if not supported), but this flag
> > is important even on systems where symlinks do not have access modes,
> > since it's the only way to safely change the mode of a file which
> > might be asynchronously replaced with a symbolic link, without a race
> > condition whereby the link target is changed.
> > 
> > It's possible to emulate AT_SYMLINK_NOFOLLOW in userspace, and both
> > musl libc and glibc do this, by opening an O_PATH file descriptor and
> > performing chmod on the corresponding magic symlink in /proc/self/fd.
> > However, this requires procfs to be mounted and accessible.
> > 
> > It was determined (see glibc issue #14578 and commit a492b1e5ef) that,
> > on some filesystems, performing chmod on the link itself produces a
> > change in the inode's access mode, but returns an EOPNOTSUPP error.
> > This is non-conforming and wrong. Rather than try to fix all the
> > broken filesystem backends, block attempts to change the symlink
> > access mode via fchmodat2 at the frontend layer. This matches the
> > userspace emulation done in libc implementations. No change is made to
> > the underlying chmod_common(), so it's still possible to attempt
> > changes via procfs, if desired. If at some point all filesystems have
> > been fixed, this could be relaxed to allow filesystems to make their
> > own decision whether changing access mode of links is supported.
> 
> A new syscall just because we have broken filesystems seems really odd,
> why not just fix the filesystems instead?

The part about broken filesystems is just the justification for doing
the EOPNOTSUPP check at this layer rather than relying on the
filesystem to do it, not the purposse for the syscall.

The purpose of the syscall is fixing the deficiency in the original
one, which lacked the flags argument, making it so you have to do a
complicated emulation dance involving O_PATH and procfs magic symlinks
to implement the standard functionality.

Rich
