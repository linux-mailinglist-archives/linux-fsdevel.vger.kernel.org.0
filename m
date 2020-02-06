Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25F7154A09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBFRJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 12:09:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58442 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFRJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:09:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izkej-008Nko-FW; Thu, 06 Feb 2020 17:09:33 +0000
Date:   Thu, 6 Feb 2020 17:09:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@lists.orangefs.org
Subject: Re: [confused] can orangefs ACLs be removed at all?
Message-ID: <20200206170933.GA23230@ZenIV.linux.org.uk>
References: <20200201005639.GG23230@ZenIV.linux.org.uk>
 <CAOg9mSSBG7tWQ2+yZDwixCHe5GayyCgZO26D2CCrPCRHxjp4mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSSBG7tWQ2+yZDwixCHe5GayyCgZO26D2CCrPCRHxjp4mg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:35:12AM -0500, Mike Marshall wrote:

> I looked at my code while thinking about your questions, and
> they seem like good ones. I have a couple of questions that will
> help me when I return to this in a few days:
> 
> >> it used to be possible to do
> >> orangefs_set_acl(inode, NULL, ACL_TYPE_ACCESS)
> 
> The way I tested (which maybe misses important stuff?) usually
> caused posix_acl_xattr_set -> set_posix_acl -> orangefs_set_acl ...
> Is there a simple userspace command that would send a NULL? When
> would there be a NULL?

setfattr -x system.posix_acl_access <filename>

works on ext4 and I don't see any way for it to work with current
orangefs_set_acl().

> I don't remember having trouble before, but now when I try to set
> an acl (on orangefs or ext4) that I think is expressible in pure mode,
> the mode doesn't change, rather the acl is still set... can you
> suggest a simple setfacl (or other) example I can use to test?

setfacl -b <filename>

works on ext4, goes by setxattr() with non-NULL acl that gets folded
into NULL by  posix_acl_update_mode().  Sure, you call __orangefs_setattr()
there, so mode does get updated.  What you don't do is telling the
server to get rid of xattr on that file.  And I don't see where the
cached acl is dropped, but I might be missing something.

Note that e.g. ext4 does this:
        if ((type == ACL_TYPE_ACCESS) && acl) {
                error = posix_acl_update_mode(inode, &mode, &acl);
                if (error)
                        goto out_stop;
                if (mode != inode->i_mode)
                        update_mode = 1;
        }

        error = __ext4_set_acl(handle, inode, type, acl, 0 /* xattr_flags */);
        if (!error && update_mode) {
                inode->i_mode = mode;
                inode->i_ctime = current_time(inode);
                ext4_mark_inode_dirty(handle, inode);
        }
the first part is more or less what your commit tries to do, but
note that __ext4_set_acl() is called in all cases; changing i_mode
is done after it, not instead of it.  And __ext4_set_acl() does
set_cached_acl() in the end (on success, that is).  So does
__orangefs_set_acl(), but you don't can it in that case; _maybe_
something else deals with that, but I don't see any plausible
candidates in there.

Sorry for the lack of direct orangefs testcases - I don't have
orangefs testbed set up right now, and IIRC setting it up had been
an interesting exercise...
