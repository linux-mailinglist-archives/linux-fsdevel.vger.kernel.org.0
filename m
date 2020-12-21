Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2382DFD53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgLUPQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 10:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgLUPQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608563685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHZPyK5TS8GB/u7xWSyEj67OXjNbSfYTy52LBjFejFE=;
        b=YN/6LgPY286JqbjtXrmxOQ5Pa+EsFW3GdyMTqn/bcR4KSKL5w+rdh92Stz1/2ccGOJ1LS0
        wd4HmZi/3dhnF4vZ6nfOp9rsro+SAUrA82cRNK9dap0wk7uoXcvq2Bwfz9Oik/76ZJyBPL
        wj9uLpns8Kd0eaaTbgWrKGhf4UzP/Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-q_cckAZjNlCvElC5aEyrpg-1; Mon, 21 Dec 2020 10:14:40 -0500
X-MC-Unique: q_cckAZjNlCvElC5aEyrpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AB2B107ACE4;
        Mon, 21 Dec 2020 15:14:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-244.rdu2.redhat.com [10.10.114.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8375D6D1;
        Mon, 21 Dec 2020 15:14:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 08ECD220BCF; Mon, 21 Dec 2020 10:14:38 -0500 (EST)
Date:   Mon, 21 Dec 2020 10:14:37 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
Message-ID: <20201221151437.GB3122@redhat.com>
References: <20201217150037.468787-1-jlayton@kernel.org>
 <20201219061331.GQ15600@casper.infradead.org>
 <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 07:53:12AM -0500, Jeff Layton wrote:
> On Sat, 2020-12-19 at 06:13 +0000, Matthew Wilcox wrote:
> > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > own purposes, without preventing a later opener from potentially seeing
> > > the error.
> > 
> > umm ... can't they just copy the errseq_t they're interested in, followed
> > by calling errseq_check() later?
> > 
> 
> They don't want the sampling for the volatile mount to prevent later
> openers from seeing an error that hasn't yet been reported.
> 
> If they copy the errseq_t (or just do an errseq_sample), and then follow
> it with a errseq_check_and_advance then the SEEN bit will end up being
> set and a later opener wouldn't see the error.
> 
> Aside from that though, I think this patch clarifies things a bit since
> the SEEN flag currently means two different things:
> 
> 1/ do I need to increment the counter when recording another error?
> 
> 2/ do I need to report this error to new samplers (at open time)
> 
> That was ok before, since we those conditions were always changed
> together, but with the overlayfs volatile mount use-case, it no longer
> does.
> 
> > actually, isn't errseq_check() buggy in the face of multiple
> > watchers?  consider this:
> > 
> > worker.es starts at 0
> > t2.es = errseq_sample(&worker.es)
> > errseq_set(&worker.es, -EIO)
> > t1.es = errseq_sample(&worker.es)
> > t2.err = errseq_check_and_advance(&es, t2.es)
> > 	** this sets ERRSEQ_SEEN **
> > t1.err = errseq_check(&worker.es, t1.es)
> > 	** reports an error, even though the only change is that
> > 	   ERRSEQ_SEEN moved **.
> > 
> > i think errseq_check() should be:
> > 
> > 	if (likely(cur | ERRSEQ_SEEN) == (since | ERRSEQ_SEEN))
> > 		return 0;
> > 
> > i'm not yet convinced other changes are needed to errseq.  but i am
> > having great trouble understanding exactly what overlayfs is trying to do.
> 
> I think you're right on errseq_check. I'll plan to do a patch to fix
> that up as well.
> 
> I too am having a bit of trouble understanding all of the nuances here.
> My current understanding is that it depends on the "volatility" of the
> mount:
> 
> normal (non-volatile): they basically want to be able to track errors as
> if the files were being opened on the upper layer. For this case I think
> they should aim to just do all of the error checking against the upper
> sb and ignore the overlayfs s_wb_err field. This does mean pushing the
> errseq_check_and_advance down into the individual filesystems in some
> fashion though.
> 
> volatile: they want to sample at mount time and always return an error
> to syncfs if there has been another error since the original sample
> point. This sampling should also not affect later openers on the upper
> layer (or on other overlayfs mounts).

I think syncfs() for both volatile and non-volatile mounts should
probably be treated same way and existing erreseq API should be
good enough for that.

So say overlayfs installs file->f_sb_err at file open time. 

ovl_file->f_sb_err = errseq_sample(&upper_sb->s_wb_err)

And at syncfs() time either file system specific ->sync_fs routine
or a separate ->sb_errseq_check() routine does following

ret = errseq_check_and_advance(&upper_sb->s_wb_err, &ovl_file->f_sb_err);

And syncfs() will return error to user space. 

So both volatile and non-volatile mount see similar to me. There is
one key difference.

- non-volatile mount does not actually sync the file to disk. So it
  it only return error if some other writeback error has been recorded
  on upper_sb since file was opened.

So what are the use cases for new errseq API? I think there are
two.

- Sargun has been trying to remount volatile mounts without every calling
  syncfs on upper. And he wants to detect if there has been an error
  since volatile mount was last mounted/unmounted. In this case he
  wants to take a snapshot of current state of upper_sb->s_wb_err
  and check this again at remount time to make sure there are not
  any new errors since he took snapshot.

  He does not want to consume the UNSEEN error in this process because
  it can potentially lead to complaints from normal syncfs users
  saying that sheer act of mounting an overlayfs consumed UNSEEN
  error on upper sb. They would expect it to be consumed when one
  of the callers does syncfs() either on upper->sb directly or
  indirectly through overlay mount.

  So IMHO, that's the core reason behind the new errseq API.

- Once we have it, I think we can potentialy use it at other places
  in overlayfs to check for errors. For example, at overlay read()
  routines might want to check if there has been an error recorded
  on upper since volatile overlay was mounted. If yes, fail read
  with -EIO and fail the filesystem so all the future reads
  return -EIO.

  That's one thing different with volatile overlayfs. Typically
  if applications write something to a file, they can do.

  write(fd)
  fsync(fd)
  read(fd)

  And this should make sure apps are protected against writeback
  errors.

  But with volatile mounts, we actually don't do any fsync(). So it
  is possible that fysnc() returns success and when read() happens
  we either read data we wrote or we read old data from disk (because
  writeback failed and pagecache page was reclaimed).

  To avoid this situation with volatile overlay mounts, we thought
  that we will fail overlay volatile mount as soon as first writeback
  error is detected.

  Now syncfs() is just only one of the sample points. We should be able
  to check for writeback errors in other paths like mount/read/write
  etc and fail volatile fs. And in all these paths, we don't want
  to mark error as SEEN otherwise user space might complain.

  In summary, with volatile overlay use case, there is a need to
  check for errors outside the syncfs() (mount/read/write/...). If
  we check for errors in these paths we have two alternatives.

  - Either mark unseen error on upper_sb as SEEN. And then user space
    can complain that an unseen error was consumed without anybody
    ever calling syncfs.

  - Or we introduce new errseq API which allows checking for errors
    without marking it SEEN. That way we can detect errors at the
    same time unseen error will be reported to user space through
    syncfs().

And second option seems to be safer choice, that's why errseq_peek()
patches.

> I'm not 100% clear on whether I understand both use-cases correctly
> though.

I hope, above is a decent summary of various discussions we have had
so far.

Vivek

