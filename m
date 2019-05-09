Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA1183D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEICg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 22:36:28 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39249 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbfEICg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 22:36:28 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3C40818D479;
        Thu,  9 May 2019 12:36:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hOYv1-00070X-7j; Thu, 09 May 2019 12:36:23 +1000
Date:   Thu, 9 May 2019 12:36:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190509023623.GU1454@dread.disaster.area>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <CAOQ4uxjM+ivnn-oU482GmRqOF6bYY5j89NdyHnfH++f49qB4yw@mail.gmail.com>
 <20190503095846.GE23724@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503095846.GE23724@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=qRPuldxxXAtwgtSaULYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 03, 2019 at 05:58:46AM -0400, Theodore Ts'o wrote:
> On Fri, May 03, 2019 at 12:16:32AM -0400, Amir Goldstein wrote:
> > OK. we can leave that one for later.
> > Although I am not sure what the concern is.
> > If we are able to agree  and document a LINK_ATOMIC flag,
> > what would be the down side of documenting a RENAME_ATOMIC
> > flag with same semantics? After all, as I said, this is what many users
> > already expect when renaming a temp file (as ext4 heuristics prove).
> 
> The problem is if the "temp file" has been hardlinked to 1000
> different directories, does the rename() have to guarantee that we
> have to make sure that the changes to all 1000 directories have been
> persisted to disk?

No.

Dependency creation is directional.

If the parent directory modifies an entry that points to an inode,
then the dependency (via inode link count modification) is created.
Modifying an inode does not create a dependency on the parent
directory, because the parent directory is not modified by inode
specific changes.

Yes, sometimes the dependency graph will resolve to fsync other
directories. e.g. because hardlinks to the same inode were created
and this is the first fsync on the inode that stabilises the link
count. Because the link count is being stabilised, all the current
depedencies on that link count (i.e. all the directories with
uncommitted dirent modifications that modified the link count in
that inode) /may/ be included in the fsync.

However, if the filesystem tracks every change to the inode link
count as separate modifications, it only need commit the directory
modifications that occurred /before/ the one being fsync'd. i.e.
SOMC doesn't require "sync the world" behaviour, it's just that we
have filesysetms that currently behave that way because it's a
simple and efficient way of tracking and resolving ordering
dependencies.

IOWs, SOMC is all about cross-object depedencies and how they are
resolved. If you have no cross-object dependencies or your
operations are isolated to a non-shared set of objects, then SOMC
allows them to operate in 100% isolation to everything else and the
filesystem can optimise this in whatever way it wants.

SOMC is not the end of the world, Ted. It's just a consistency model
that has been proposed that could allow substantial optimisation of
application operations and filesystem behaviour. You're free to go
in other directions if you want - diversity is good. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
