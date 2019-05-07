Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37B016A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEGSiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 14:38:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfEGSiD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 14:38:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CABF3AD04;
        Tue,  7 May 2019 18:38:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1052D1E3C5A; Tue,  7 May 2019 20:38:00 +0200 (CEST)
Date:   Tue, 7 May 2019 20:38:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Vijay Chidambaram <vijay@cs.utexas.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190507183800.GG4635@quack2.suse.cz>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <CAHWVdUV115x8spvAd3p-6iDRE--yZULbF6DDc+Hapt2s+pJgbA@mail.gmail.com>
 <20190503094543.GD23724@mit.edu>
 <CAHWVdUWrKigH8g-Jhi404y+XvuhXAx4b+PBW8_hLF4110etSLg@mail.gmail.com>
 <20190504014307.GA4058@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190504014307.GA4058@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 03-05-19 21:43:07, Theodore Ts'o wrote:
> On Fri, May 03, 2019 at 07:17:54PM -0500, Vijay Chidambaram wrote:
> > 
> > I think there might be a mis-understanding about the example
> > (reproduced below) and about SOMC. The relationship that matters is
> > not whether X happens before Y. The relationship between X and Y is
> > that they are in the same directory, so fsync(new file X) implies
> > fsync(X's parent directory) which contains Y.  In the example, X is
> > A/foo and Y is A/bar. For truly un-related files such as A/foo and
> > B/bar, SOMC does indeed allow fsync(A/foo) to not persist B/bar.
> 
> When you say "X and Y are in the same directory", how does this apply
> in the face of hard links?  Remember, file X might be in a 100
> different directories.  Does that mean if changes to file X is visible
> after a crash, all files Y in any of X's 100 containing directories
> that were modified before X must have their changes be visible after
> the crash?
> 
> I suspect that the SOMC as articulated by Dave does make such global
> guarantees.  Certainly without Park and Shin's incremental fsync,
> unrelated files will have the property that if A/foo is modified after
> B/bar, and B/bar's metadata changes are visible after a crash, A/foo's
> metadata will also be visible.  This is true for ext4, and xfs.
> 
> Even if we ignore the hard link problem, and assume that it only
> applies for files foo and bar with st_nlinks == 1, the crash
> consistency guarantees you've described will *still* rule out Park and
> Shin's increment fsync.  So depending on whether ext4 has fast fsync's
> enabled, we might or might not have behavior consistency with your
> proposed crash consistency rules.
> 
> But at this point, even if we promulgate these "guarantees" in a
> kernel documentation file, applications won't be able to depend on
> them.  If they do, they will be unreliable depending on which file
> system they use; so they won't be particularly useful for application
> authors care about portability.  (Or worse, for users who are under
> the delusion that the application authors care about portability, and
> who will be subject to data corruption after a crash.)  Do we *really*
> want to be promulgating these semantics to application authors?

I agree that having fs specific promises for crash consistency is bad.
The application would have to detect what filesystem it is running on and
based on that issue fsync or not. I don't think many applications will get
this right so IMO it would result in more problems in case crash, not less.

> Finally, I'll note that generic/342 is much more specific, and your
> proposed crash consistency rule is more general.
> 
> # Test that if we rename a file, create a new file that has the old name of the
> # other file and is a child of the same parent directory, fsync the new inode,
> # power fail and mount the filesystem, we do not lose the first file and that
> # file has the name it was renamed to.
> 
> > touch A/foo
> > echo “hello” >  A/foo
> > sync
> > mv A/foo A/bar
> > echo “world” > A/foo
> > fsync A/foo
> > CRASH
> 
> Sure, that's one that fast commit will honor.

Hum, but will this be also honored in case of hardlinks? E.g.

echo "hello" >A/foo
ln A/foo B/foo
sync
mv A/foo A/bar
mv B/foo B/bar
echo "world" >A/foo
fsync A/foo

Will you also persist changes to B? If not, will you persist them if we
do 'ln A/foo B/foo' before 'fsync A/foo'? I'm just wondering where you draw
the borderline if you actually do care about namespace changes in addition
to inode + its metadata...

> But what about:
> 
> echo "world" > A/foo
> echo "hello" > A/bar
> chmod 755 A/bar
> sync
> chmod 750 A/bar
> echo "new world" >> A/foo
> fsync A/foo
> CRASH
> 
> .... will your crash consistency rules guarantee that the permissions
> change for A/bar is visible after the fsync of A/foo?
> 
> Or if A/foo and A/bar exists, and we do:
> 
> echo "world" > A/foo
> echo "hello" > A/bar
> sync
> mv A/bar A/quux
> echo "new world" >> A/foo
> fsync A/foo
> CRASH
> 
> ... is the rename of A/bar and A/quux guaranteed to be visible after
> the crash?

And I agree that guaranteeing ordering of operations in the same
directory but for unrelated names to operations on inode in that directory
does not seem very useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
