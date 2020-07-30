Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D317D2338EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgG3TZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 15:25:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3TZj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:25:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 977A3AFC0;
        Thu, 30 Jul 2020 19:25:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD50F1E12CB; Thu, 30 Jul 2020 21:25:37 +0200 (CEST)
Date:   Thu, 30 Jul 2020 21:25:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [bug report] fsnotify: pass dir and inode arguments to fsnotify()
Message-ID: <20200730192537.GB13525@quack2.suse.cz>
References: <20200730111339.GA54272@mwanda>
 <CAOQ4uxgEG9PNtdoMXw52_C4oaUQpi2DVx34_QEHeV195e3kYdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgEG9PNtdoMXw52_C4oaUQpi2DVx34_QEHeV195e3kYdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 30-07-20 14:55:11, Amir Goldstein wrote:
> On Thu, Jul 30, 2020 at 2:13 PM <dan.carpenter@oracle.com> wrote:
> >
> > Hello Amir Goldstein,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > The patch 40a100d3adc1: "fsnotify: pass dir and inode arguments to
> > fsnotify()" from Jul 22, 2020, leads to the following Smatch
> > complaint:
> 
> That's an odd report, because...
> 
> >
> >     fs/notify/fsnotify.c:460 fsnotify()
> >     warn: variable dereferenced before check 'inode' (see line 449)

Yeah, I've noticed a similar report from Coverity.

> > fs/notify/fsnotify.c
> >    448          }
> >    449          sb = inode->i_sb;
> >                      ^^^^^^^^^^^
> > New dreference.
> 
> First of all, two lines above we have
> if (!inode) inode = dir;
> 
> This function does not assert (inode || dir), but must it??
> This is even documented:
> 
>  * @inode:      optional inode associated with event -
>  *              either @dir or @inode must be non-NULL.
> 
> Second,
> The line above was indeed added by:
> 40a100d3adc1: "fsnotify: pass dir and inode arguments to fsnotify()"
> 
> However...
> 
> >
> >    450
> >    451          /*
> >    452           * Optimization: srcu_read_lock() has a memory barrier which can
> >    453           * be expensive.  It protects walking the *_fsnotify_marks lists.
> >    454           * However, if we do not walk the lists, we do not have to do
> >    455           * SRCU because we have no references to any objects and do not
> >    456           * need SRCU to keep them "alive".
> >    457           */
> >    458          if (!sb->s_fsnotify_marks &&
> >    459              (!mnt || !mnt->mnt_fsnotify_marks) &&
> >    460              (!inode || !inode->i_fsnotify_marks) &&
> >                      ^^^^^^
> > Check too late.  Presumably this check can be removed?
> 
> But this line was only added later by:
> 9b93f33105f5 fsnotify: send event with parent/name info to
> sb/mount/non-dir marks
> 
> So, yes, the check could be removed.
> It is a leftover from a previous revision, but even though it is a leftover
> I kind of like the code better this way.

And after looking at it my conclusion was the same. I like the symmetry of
the code despite some checks are actually unnecessary...

> In principle, an event on sb/mnt that is not associated with any inode
> (for example
> FS_UNMOUNT) could be added in the future.
> And then we will have to fix documentation and the inode dereference above.
> 
> In any case, thank you for the report, but I don't see a reason to make any
> changes right now.

Agreed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
