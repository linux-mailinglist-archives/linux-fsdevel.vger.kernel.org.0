Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104A230CF20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 23:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhBBWgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 17:36:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48406 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234855AbhBBWfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:35:34 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 112MYZjn032109
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Feb 2021 17:34:35 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EE56F15C39E2; Tue,  2 Feb 2021 17:34:34 -0500 (EST)
Date:   Tue, 2 Feb 2021 17:34:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, david@fromorbit.com, darrick.wong@oracle.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <YBnTekVOQipGKXQc@mit.edu>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rdydxms.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 03:26:35PM -0500, Gabriel Krisman Bertazi wrote:
> 
> Thanks for the explanation.  That makes sense to me.  For corruptions
> where it is impossible to map to a mountpoint, I thought they could be
> considered global filesystem errors, being exposed only to someone
> watching the entire filesystem (like FAN_MARK_FILESYSTEM).

At least for ext4, there are only 3 ext4_error_*() that we could map
to a subtree without having to make changes to the call points:

% grep -i ext4_error_file\( fs/ext4/*.c  | wc -l
3
% grep -i ext4_error_inode\( fs/ext4/*.c  | wc -l
79
% grep -i ext4_error\( fs/ext4/*.c  | wc -l
42

So in practice, unless we want to make a lot of changes to ext4, most
of them will be global file system errors....

> But, as you mentioned regarding the google use case, the entire idea of
> watching a subtree is a bit beyond the scope of my use-case, and was
> only added given the feedback on the previous proposal of this feature.
> While nice to have, I don't have the need to watch different mountpoints
> for errors, only the entire filesystem.

I suspect that for most use cases, the most interesting thing is the
first error.  We already record this in the ext4 superblock, because
unfortunately, I can't guarantee that system administrators have
correctly configured their system logs, so when handling upstream bug
reports, I can just ask them to run dumpe2fs -h on the file system:

FS Error count:           2
First error time:         Tue Feb  2 16:27:42 2021
First error function:     ext4_lookup
First error line #:       1704
First error inode #:      12
First error err:          EFSCORRUPTED
Last error time:          Tue Feb  2 16:27:59 2021
Last error function:      ext4_lookup
Last error line #:        1704
Last error inode #:       12
Last error err:           EFSCORRUPTED

So it's not just the Google case.  I'd argue for most system
administrator, one of the most useful things is when the file system
was first found to be corrupted, so they can try correlating file
system corruptions, with, say, reports of I/O errors, or OOM kils,
etc.  This can also be useful for correlating the start of file system
problems with problems at the application layer --- say, MongoDB,
MySQL, etc.

The reason why a notification system useful is because if you are
using database some kind of high-availability replication system, and
if there are problems detected in the file system of the primary MySQL
server, you'd want to have the system fail over to the secondary MySQL
server.  Sure, you *could* do this by polling the superblock, but
that's not the most efficient way to do things.

> There was a concern raised against my original submission which did
> superblock watching, due to the fact that a superblock is an internal
> kernel structure that must not be visible to the userspace.  It was
> suggested we should be speaking in terms of paths and mountpoint.  But,
> considering the existence of FAN_MARK_FILESYSTEM, I think it is the exact
> same object I was looking for when proposing the watch_sb syscall.

Sure, using the owner of the root directory (the mountpoint), might be
one way of doing things.  I think CAP_SYS_ADMIN is also fine, since
for many of the use cases, such as shutting down the file system so
the database server can fail over to the secondary service, you're
going to need root anyway.  (Especially for ext4, the vast majority of
the errors are going to be FAN_MARK_FILESYSTEM anyway.)

> The main use case is, as you said, corruption detection with enough
> information to allow us to trigger automatic recovery and data rebuilding
> tools.  I understand now I can drop most of the debug info, as you
> mentioned.  In this sense, the feature looks more like netoops.

Things like the bad block number, and the more structured information
is a nice to have.  It might also be that using the structured
information might be a more efficient way to get the information to
userspace.  So one could imagine using, say, an 32 character error
text code, sasy, "ext4_bad_dir_block_csum", followed by a 64-bit inode
number, a 64-bit containing directory inode number, a 64-bit block
number, and 8-bits of filename length, followed the first 7 characters
of the filename, followed by the last 8 characters of the filename.
That's 72 bytes, which is quite compact.  Adding something like 16
bytes of function names and 2 bytes of line number would net 90 bytes.

> But there are other uses that interests us, like pattern analysis of
> error locations, such that we can detect and perhaps predict errors.
> One idea that was mentioned is if an error occurs frequently enough
> in a specific function, there might be a bug in that function.  This is
> one of the reasons we are pushing to include function:line in the error
> message.

I agree.  But if this is causing too much resistance, we can just
encode some the error information as a file system specific text or
byte string.  Even we are restricted to, say, 96 or 80 bytes, there's
a lot we can do, even if we can't do notification continuations.

Cheers,

						- Ted
