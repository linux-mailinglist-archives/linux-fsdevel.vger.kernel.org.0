Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5A1313E09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhBHSvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 13:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhBHSug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:50:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26477C061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 10:49:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C06721F44B10
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     jack@suse.com, viro@zeniv.linux.org.uk, amir73il@gmail.com,
        dhowells@redhat.com, david@fromorbit.com, darrick.wong@oracle.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Organization: Collabora
References: <87lfcne59g.fsf@collabora.com> <YAoDz6ODFV2roDIj@mit.edu>
        <87pn1xdclo.fsf@collabora.com> <YBM6gAB5c2zZZsx1@mit.edu>
        <871rdydxms.fsf@collabora.com> <YBnTekVOQipGKXQc@mit.edu>
Date:   Mon, 08 Feb 2021 13:49:41 -0500
In-Reply-To: <YBnTekVOQipGKXQc@mit.edu> (Theodore Ts'o's message of "Tue, 2
        Feb 2021 17:34:34 -0500")
Message-ID: <87wnvi8ke2.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Tue, Feb 02, 2021 at 03:26:35PM -0500, Gabriel Krisman Bertazi wrote:
>> 
>> Thanks for the explanation.  That makes sense to me.  For corruptions
>> where it is impossible to map to a mountpoint, I thought they could be
>> considered global filesystem errors, being exposed only to someone
>> watching the entire filesystem (like FAN_MARK_FILESYSTEM).
>
> At least for ext4, there are only 3 ext4_error_*() that we could map
> to a subtree without having to make changes to the call points:
>
> % grep -i ext4_error_file\( fs/ext4/*.c  | wc -l
> 3
> % grep -i ext4_error_inode\( fs/ext4/*.c  | wc -l
> 79
> % grep -i ext4_error\( fs/ext4/*.c  | wc -l
> 42
>
> So in practice, unless we want to make a lot of changes to ext4, most
> of them will be global file system errors....
>
>> But, as you mentioned regarding the google use case, the entire idea of
>> watching a subtree is a bit beyond the scope of my use-case, and was
>> only added given the feedback on the previous proposal of this feature.
>> While nice to have, I don't have the need to watch different mountpoints
>> for errors, only the entire filesystem.
>
> I suspect that for most use cases, the most interesting thing is the
> first error.  We already record this in the ext4 superblock, because
> unfortunately, I can't guarantee that system administrators have
> correctly configured their system logs, so when handling upstream bug
> reports, I can just ask them to run dumpe2fs -h on the file system:
>
> FS Error count:           2
> First error time:         Tue Feb  2 16:27:42 2021
> First error function:     ext4_lookup
> First error line #:       1704
> First error inode #:      12
> First error err:          EFSCORRUPTED
> Last error time:          Tue Feb  2 16:27:59 2021
> Last error function:      ext4_lookup
> Last error line #:        1704
> Last error inode #:       12
> Last error err:           EFSCORRUPTED
>
> So it's not just the Google case.  I'd argue for most system
> administrator, one of the most useful things is when the file system
> was first found to be corrupted, so they can try correlating file
> system corruptions, with, say, reports of I/O errors, or OOM kils,
> etc.  This can also be useful for correlating the start of file system
> problems with problems at the application layer --- say, MongoDB,
> MySQL, etc.
>
> The reason why a notification system useful is because if you are
> using database some kind of high-availability replication system, and
> if there are problems detected in the file system of the primary MySQL
> server, you'd want to have the system fail over to the secondary MySQL
> server.  Sure, you *could* do this by polling the superblock, but
> that's not the most efficient way to do things.

Hi Ted,

I think this closes a full circle back to my original proposal.  It
doesn't have the complexities of objects other than superblock
notifications, doesn't require allocations.  I sent an RFC for that a
while ago [1] which resulted in this discussion and the current
implementation.

For the sake of a having a proposal and a way to move forward, I'm not
sure what would be the next step here.  I could revive the previous
implementation, addressing some issues like avoiding the superblock
name, the way we refer to blocks and using CAP_SYS_ADMIN.  I think that
implementation solves the usecase you explained with more simplicity.
But I'm not sure Darrick and Dave (all in cc) will be convinced by this
approach of global pipe where we send messages for the entire
filesystem, as Dave described it in the previous implementation.

Are you familiar with that implementation?

[1] https://www.spinics.net/lists/linux-ext4/msg75742.html


-- 
Gabriel Krisman Bertazi
