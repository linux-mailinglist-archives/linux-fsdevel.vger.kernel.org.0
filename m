Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110F231B334
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 00:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBNXK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 18:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBNXK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 18:10:27 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F89C061756;
        Sun, 14 Feb 2021 15:09:46 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBQVi-00E2wA-6b; Sun, 14 Feb 2021 23:09:02 +0000
Date:   Sun, 14 Feb 2021 23:09:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add generated flag to filesystem struct to block
 copy_file_range
Message-ID: <YCmtjup3KtzxGX/s@zeniv-ca.linux.org.uk>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:43:59PM +0800, Nicolas Boichat wrote:
> We hit an issue when upgrading Go compiler from 1.13 to 1.15 [1],
> as we use Go's `io.Copy` to copy the content of
> `/sys/kernel/debug/tracing/trace` to a temporary file.
> 
> Under the hood, Go 1.15 uses `copy_file_range` syscall to
> optimize the copy operation. However, that fails to copy any
> content when the input file is from tracefs, with an apparent
> size of 0 (but there is still content when you `cat` it, of
> course).
> 
> >From discussions in [2][3], it is clear that copy_file_range
> cannot be properly implemented on filesystems where the content
> is generated at runtime: the file size is incorrect (because it
> is unknown before the content is generated), and seeking in such
> files (as required by partial writes) is unlikely to work
> correctly.
> 
> With this patch, Go's `io.Copy` gracefully falls back to a normal
> read/write file copy.
> 
> I'm not 100% sure which stable tree this should go in, I'd say
> at least >=5.3 since this is what introduced support for
> cross-filesystem copy_file_range (and where most users are
> somewhat likely to hit this issue). But let's discuss the patch
> series first.

No.  This is *NOT* an fs-wide flag.  Decision regarding the
usability of copy_file_range() is on per-file basis.

The real constraint is "can freely seek back and expect to
find consistent data".  That is what's violated for seq_file.
And frankly, I would rather add a flag and have seq_open()
(and other suckers, if any) clear it.  With check being
"has both FMODE_PREAD and this new flag".
