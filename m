Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5704F305136
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbhA0Ep5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389627AbhA0AG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:06:26 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F9C0698C6;
        Tue, 26 Jan 2021 15:51:15 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Y6o-006RKi-QP; Tue, 26 Jan 2021 23:50:55 +0000
Date:   Tue, 26 Jan 2021 23:50:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: generic_copy_file_checks: Do not adjust count based
 on file size
Message-ID: <20210126235054.GN740243@zeniv-ca>
References: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:50:22PM +0800, Nicolas Boichat wrote:
> copy_file_range (which calls generic_copy_file_checks) uses the
> inode file size to adjust the copy count parameter. This breaks
> with special filesystems like procfs/sysfs, where the file size
> appears to be zero, but content is actually returned when a read
> operation is performed.
> 
> This commit ignores the source file size, and makes copy_file_range
> match the end of file behaviour documented in POSIX's "read",
> where 0 is returned to mark EOF. This would allow "cp" and other
> standard tools to make use of copy_file_range with the exact same
> behaviour as they had in the past.

	Proper fix is _not_ to use copy_file_range(2) in cp(1) - it's
really not universal and its implementation will *NOT* do the right
thing for most of procfs files.  Sequential read(2) (or splice(2),
for that matter) will give you consistent output; copy_file_range(2)
will not.

	What copy_file_range() does is splice from input to internal pipe
+ splice from that internal pipe to output, done in a loop.  HOWEVER,
a short write to output will discard the contents of the internal pipe
and pretend we had a short _read_ instead.  With ->f_pos updated
accordingly, so that on the next call we'd start from the place
right after everything we'd copied.  However, that will result in
implicit seek on the next call of seq_read(), with no promise whatsoever
that you won't end up with consistent records in your copy.
Short copy on read(2) will leave the rest of the record in buffer,
so the next read(2) will pick that first.

	IOW, don't expect copy_file_range() to produce usable copies
for those.  Doesn't work.  splice to explicit pipe + splice from that
pipe (without flushing the sucker) works, and if you really want
zero-copy you could use that.

	Again, use of copy_file_range(2) in cp(1) is a userland bug.
Don't do it.
