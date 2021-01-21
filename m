Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9F2FF829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 23:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAUWpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 17:45:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34101 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbhAUWpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:45:33 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LMiWVA013879
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 17:44:32 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D414415C35F5; Thu, 21 Jan 2021 17:44:31 -0500 (EST)
Date:   Thu, 21 Jan 2021 17:44:31 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, david@fromorbit.com, darrick.wong@oracle.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <YAoDz6ODFV2roDIj@mit.edu>
References: <87lfcne59g.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfcne59g.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:13:15PM -0300, Gabriel Krisman Bertazi wrote:
> 
>   I submitted a first set of patches, based on David Howells' original
>   superblock notifications patchset, that I expanded into error
>   reporting and had an example implementation for ext4.  Upstream review
>   has revealed a few design problems:
> 
>   - Including the "function:line" tuple in the notification allows the
>     uniquely identification of the error origin but it also ties the
>     decodification of the error to the source code, i.e. <function:line>
>     is expected to change between releases.

That's true, but it's better than printing the EIP, which is even
harder to decode.  Having the line number is better than the
alternative, which is either (a) nothing, or (b) the EIP.

>   - Useful debug data (inode number, block group) have formats specific
>     to the filesystems, and my design wouldn't be expansible to
>     filesystems other than ext4.

Inode numbers are fairly universal; block groups are certainly
ext2/3/4 specific.  I'll note that in the original ext4_error messages
to syslog and the internal-to-Google netlink notification system, they
were sent as an text string.  We don't necessarily need to send them
to userspace.

>   - The implementation allowed an error string description (equivalent
>     to what would be thrown in dmesg) that is too short, as it needs to
>     fit in a single notification.

... or we need to have some kind of contnuation system where the text
string is broken across multiple notification, with some kind of
notification id umber.

>   - Visibility of objects.  A bind mount of a subtree shouldn't receive
>     notifications of objects outside of that bind mount.

So this is scope creep beyond the original goals of the project.  I
understand that there is a desire by folks in the community to support
various containerization use cases where only only a portion of file
system is visible in a container due to a bind mount.

However, we need to recall that ext4_error messages can originate in
fairly deep inside the ext4 file system.  They indicate major problems
with the file system --- the kind that might require drastic system
administration reaction.  As such, at the point where we discover a
problem with an inode, that part of the ext4 code might not have
access to the pathname that was used to originally access the inode.

We might be inside a workqueue handler, for example, so we might not
even running in the same process that had been containerized.  We
might be holding various file system mutexes or even in some cases a
spinlock.

What follows from that is that it's not really going to be possible to
filter notifications to a subtree.  Furthermore, if fanotify requires
memory allocation, that's going to be problematic, we may not be in a
context where memory allocation is possible.  So for that reason, it's
not clear to me that fanotify is going to be a good match for this use
case.

Cheers,

						- Ted
