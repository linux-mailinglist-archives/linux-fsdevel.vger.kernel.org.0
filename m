Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89675778E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfG0NR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 09:17:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57436 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfG0NR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 09:17:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hrMZZ-0000Tv-SL; Sat, 27 Jul 2019 13:17:18 +0000
Date:   Sat, 27 Jul 2019 14:17:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
Message-ID: <20190727131717.GQ1131@ZenIV.linux.org.uk>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
 <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
 <20190726232220.GM1131@ZenIV.linux.org.uk>
 <878sskqp7p.fsf@xmission.com>
 <20190727022826.GO1131@ZenIV.linux.org.uk>
 <87h877pvv1.fsf@xmission.com>
 <20190727123705.GP1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727123705.GP1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 27, 2019 at 01:37:05PM +0100, Al Viro wrote:

> > So yes I agree the function of interest is always capable in some form,
> > we just need the filesystem specific logic to check to see if we will
> > have capable over the filesystem that will be mounted.
> > 
> > I don't doubt that the new mount api has added a few new complexities.
> 
> So far it looks like *in this particular case* complexities would be
> reduced - with one exception all your ->permission() instances become
> identical.
> 
> Moreover, even in that case we still get the right overall behaviour
> with the same instance...

PS: For the record

	* I obviously agree with your reasoning behind making those checks
fs-dependent (they have to) and with putting them (back then) into
->mount() instances (since that was the first method called)
	* I agree (violently) with not liking them done inside ->mount().
	* in principle I agree that the stuff like "can that thing
be mounted in non-initial userns" might better off as a method rather
than a flag.

However
	* these days filesystem *can* have "which userns should the
capabilities be checked for?" handled outside ->mount().  Setting
fc->user_ns in ->init_fs_context() does just that; the thing is
called first in all cases.
	* with that done we get the same logics for all FS_USERNS_MOUNT
filesystems.  IOW, all your ->permission() methods would either become
NULL (for !FS_USERNS_MOUNT) or, for all non-NULL, identical to each other.
All variability between them is already taken care of when we set fc->user_ns.

The last one is what makes me somewhat dubious re having that method -
it's literally one bit of information encoded into a function pointer.
Do you anticipate any cases where the thing would *NOT* be of the same
form?  I.e. when something is userns-mountable, but the check is not
ns_capable(some userns, CAP_SYS_ADMIN)?

While we are at it, kobj_ns_...() look like preparations to something
that has never fully materialized.  What would sysfs mount checks be
supposed to do if we'd ever grown more than one struct kobj_ns_type_operations
instance?  Because that looks like the most plausible case of "we might
need trickier ->permission()"...
