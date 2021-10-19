Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAB433CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhJSQ5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:57:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQ5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:57:19 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0DF1A1F43774;
        Tue, 19 Oct 2021 17:55:04 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 30/32] ext4: Send notifications on error
Organization: Collabora
References: <20211019000015.1666608-1-krisman@collabora.com>
        <20211019000015.1666608-31-krisman@collabora.com>
        <20211019154426.GR3255@quack2.suse.cz>
        <20211019160152.GT3255@quack2.suse.cz>
Date:   Tue, 19 Oct 2021 13:54:59 -0300
In-Reply-To: <20211019160152.GT3255@quack2.suse.cz> (Jan Kara's message of
        "Tue, 19 Oct 2021 18:01:52 +0200")
Message-ID: <87o87lnee4.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Tue 19-10-21 17:44:26, Jan Kara wrote:
>> On Mon 18-10-21 21:00:13, Gabriel Krisman Bertazi wrote:
>> > Send a FS_ERROR message via fsnotify to a userspace monitoring tool
>> > whenever a ext4 error condition is triggered.  This follows the existing
>> > error conditions in ext4, so it is hooked to the ext4_error* functions.
>> > 
>> > It also follows the current dmesg reporting in the format.  The
>> > filesystem message is composed mostly by the string that would be
>> > otherwise printed in dmesg.
>> > 
>> > A new ext4 specific record format is exposed in the uapi, such that a
>> > monitoring tool knows what to expect when listening errors of an ext4
>> > filesystem.
>> > 
>> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> > Reviewed-by: Theodore Ts'o <tytso@mit.edu>
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 
>> Looks good to me. Feel free to add:
>> 
>> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Hum, I actually retract this because the code doesn't match what is written
> in the documentation and I'm not 100% sure what is correct. In particular:
>
>> > @@ -759,6 +760,8 @@ void __ext4_error(struct super_block *sb, const char *function,
>> >  		       sb->s_id, function, line, current->comm, &vaf);
>> >  		va_end(args);
>> >  	}
>> > +	fsnotify_sb_error(sb, NULL, error);
>> > +
>
> E.g. here you pass the 'error' to fsnotify. This will be just standard
> 'errno' number, not ext4 error code as described in the documentation. Also
> note that frequently 'error' will be 0 which gets magically transformed to
> EFSCORRUPTED in save_error_info() in the ext4 error handling below. So
> there's clearly some more work to do...

Nice catch.

The many 0 returns were discussed before, around v3.  You can notice one
of my LTP tests is designed to catch that.  We agreed ext4 shouldn't be
returning 0, and that we would write a patch to fix it, but I didn't
think it belonged as part of this series.

You are also right about the EXT4_ vs. errno.  the documentation is
buggy, since it was brought from the fs-specific descriptor days, which
no longer exists.  Nevertheless, I think there is a case for always
returning file system specific errors here, since they are more
descriptive.

Should we agree to follow the documentation and return FS specific
errors instead of errno, then?

Either way, I'm dropping all r-by flags here.

-- 
Gabriel Krisman Bertazi
