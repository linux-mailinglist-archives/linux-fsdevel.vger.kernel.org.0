Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE642D42B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgLINHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbgLING4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:06:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3207FC0613CF;
        Wed,  9 Dec 2020 05:06:16 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1000])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 24A531F45318;
        Wed,  9 Dec 2020 13:06:12 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
Organization: Collabora
References: <20201208003117.342047-6-krisman@collabora.com>
        <20201208003117.342047-1-krisman@collabora.com>
        <952750.1607431868@warthog.procyon.org.uk>
        <87r1o05ua6.fsf@collabora.com> <20201208184123.GC106255@magnolia>
        <87lfe85c6b.fsf@collabora.com> <20201209032425.GD106255@magnolia>
Date:   Wed, 09 Dec 2020 10:06:07 -0300
In-Reply-To: <20201209032425.GD106255@magnolia> (Darrick J. Wong's message of
        "Tue, 8 Dec 2020 19:24:25 -0800")
Message-ID: <87h7ov5dts.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

> On Tue, Dec 08, 2020 at 04:29:32PM -0300, Gabriel Krisman Bertazi wrote:
>> "Darrick J. Wong" <darrick.wong@oracle.com> writes:
>> 
>> > On Tue, Dec 08, 2020 at 09:58:25AM -0300, Gabriel Krisman Bertazi wrote:
>> >> David Howells <dhowells@redhat.com> writes:
>> >> 
>> >> > Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>> >> >
>> >> >> @@ -130,6 +131,8 @@ struct superblock_error_notification {
>> >
>> > FWIW I wonder if this really should be inode_error_notification?
>> >
>> > If (for example) ext4 discovered an error in the blockgroup descriptor
>> > and wanted to report it, the inode and block numbers would be
>> > irrelevant, but the blockgroup number would be nice to have.
>> 
>> A previous RFC had superblock_error_notification and
>> superblock_inode_error_notification split, I think we can recover that.
>> 
>> >
>> >> >>  	__u32	error_cookie;
>> >> >>  	__u64	inode;
>> >> >>  	__u64	block;
>> >> >> +	char	function[SB_NOTIFICATION_FNAME_LEN];
>> >> >> +	__u16	line;
>> >> >>  	char	desc[0];
>> >> >>  };
>> >> >
>> >> > As Darrick said, this is a UAPI breaker, so you shouldn't do this (you can,
>> >> > however, merge this ahead a patch).  Also, I would put the __u16 before the
>> >> > char[].
>> >> >
>> >> > That said, I'm not sure whether it's useful to include the function name and
>> >> > line.  Both fields are liable to change over kernel commits, so it's not
>> >> > something userspace can actually interpret.  I think you're better off dumping
>> >> > those into dmesg.
>> >> >
>> >> > Further, this reduces the capacity of desc[] significantly - I don't know if
>> >> > that's a problem.
>> >> 
>> >> Yes, that is a big problem as desc is already quite limited.  I don't
>> >
>> > How limited?
>> 
>> The largest notification is 128 bytes, the one with the biggest header
>> is superblock_error_notification which leaves 56 bytes for description.
>> 
>> >
>> >> think it is a problem for them to change between kernel versions, as the
>> >> monitoring userspace can easily associate it with the running kernel.
>> >
>> > How do you make that association?  $majordistro's 4.18 kernel is not the
>> > same as the upstream 4.18.  Wouldn't you rather the notification message
>> > be entirely self-describing rather than depending on some external
>> > information about the sender?
>> 
>> True.  I was thinking on my use case where the customer controls their
>> infrastructure and would specialize their userspace tools, but that is
>> poor design on my part.  A self describing mechanism would be better.
>> 
>> >
>> >> The alternative would be generating something like unique IDs for each
>> >> error notification in the filesystem, no?
>> >> 
>> >> > And yet further, there's no room for addition of new fields with the desc[]
>> >> > buffer on the end.  Now maybe you're planning on making use of desc[] for
>> >> > text-encoding?
>> >> 
>> >> Yes.  I would like to be able to provide more details on the error,
>> >> without having a unique id.  For instance, desc would have the formatted
>> >> string below, describing the warning:
>> >> 
>> >> ext4_warning(inode->i_sb, "couldn't mark inode dirty (err %d)", err);
>> >
>> > Depending on the upper limit on the length of messages, I wonder if you
>> > could split the superblock notification and the description string into
>> > separate messages (with maybe the error cookie to tie them together) so
>> > that the struct isn't limited by having a VLA on the end, and the
>> > description can be more or less an arbitrary string?
>> >
>> > (That said I'm not familiar with the watch queue system so I have no
>> > idea if chained messages even make sense here, or are already
>> > implemented in some other way, or...)
>> 
>> I don't see any support for chaining messages in the current watch_queue
>> implementation, I'd need to extend the interface to support it.  I
>> considered this idea before, given the small description size, but I
>> thought it would be over-complicated, even though much more future
>> proof.  I will look into that.
>> 
>> What about the kernel exporting a per-filesystem table, as a build
>> target or in /sys/fs/<fs>/errors, that has descriptions strings for each
>> error?  Then the notification can have only the FS type, index to the
>> table and params.  This won't exactly be self-describing as you wanted
>> but, differently from function:line, it removes the need for the source
>> code, and allows localization.  The per-filesystem table would be
>> stable ABI, of course.
>
> Yikes.  I don't think people are going to be ok with a message table
> where we can never remove the strings.  I bet GregKH won't like that
> either (one value per sysfs file).

Indeed, sysfs seems out of question.  In fact the string format doesn't
even need to be in the kernel, and we don't need the strings to be sent
as part of the notifications.  What if we can have a bunch of
notification types, specific for each error message, and a library in
userspace that parses the notifications and understands the parameters
passed?  The library then displays the data as they wish.

> (Maybe I misread that and all you meant by stable ABI is the fact that
> the table exists at a given path and the notification message gives you
> a index into ... wherever we put it.)

The kernel could even export the table as a build-time target, that
get's installed into X. But even that is not necessary if a library can
make sense of a notification that uniquely identifies each error and
only includes the useful debug parameters without any string formatting?

-- 
Gabriel Krisman Bertazi
