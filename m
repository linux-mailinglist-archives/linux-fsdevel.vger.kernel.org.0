Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5053AB9C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFQQeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhFQQeK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:34:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 004F760C40;
        Thu, 17 Jun 2021 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623947523;
        bh=Y9MAkFl/jnxhmbGYvknaytrWo1sMhzoDXlpyvDJDLcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1laN/brbSgTDibxAQsTLRdkRN1MnOew8tSgdgKlVCVI1MlEEp0L2hf9ikKetvaC4
         uAgyrjowzm3LPxP/J+eYqNIucqkz0C/S3fiHpcih0eSCHg6B11tohcBFVkMZHtKhTm
         l6BPc1pt3LwR2/XCYAVMVdMD/rgSdXONuFnWdar8RvHsBC5EXWSMBQ3a8FJSsm+lj/
         E0OJ3YtI8D4CVDXkemlPhdYj3nnnWMruPPmhm0sKGiemcFZo/CPWeA8a+MqOgVJovq
         a2w24VN/WMnn2gVQgd9XAl+SCK74GV7QGWtqz0qQwCZ5ENt0n3IvCmmHSGIt9zYbjZ
         X+UHvUa1UU8aw==
Date:   Thu, 17 Jun 2021 09:32:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Message-ID: <20210617163202.GR158209@locust>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
 <YMmOCK4wHc9lerEc@infradead.org>
 <20210616085304.GA28250@quack2.suse.cz>
 <20210616154705.GE158209@locust>
 <20210616155712.GC28250@quack2.suse.cz>
 <20210617162920.GQ158209@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617162920.GQ158209@locust>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:29:20AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 16, 2021 at 05:57:12PM +0200, Jan Kara wrote:
> > On Wed 16-06-21 08:47:05, Darrick J. Wong wrote:
> > > On Wed, Jun 16, 2021 at 10:53:04AM +0200, Jan Kara wrote:
> > > > On Wed 16-06-21 06:37:12, Christoph Hellwig wrote:
> > > > > On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> > > > > > From: Pavel Reichl <preichl@redhat.com>
> > > > > > 
> > > > > > Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> > > > > > __xfs_rwsem_islocked() is a helper function which encapsulates checking
> > > > > > state of rw_semaphores hold by inode.
> > > > > 
> > > > > __xfs_rwsem_islocked doesn't seem to actually existing in any tree I
> > > > > checked yet?
> > > > 
> > > > __xfs_rwsem_islocked is introduced by this patch so I'm not sure what are
> > > > you asking about... :)
> > > 
> > > The sentence structure implies that __xfs_rwsem_islocked was previously
> > > introduced.  You might change the commit message to read:
> > > 
> > > "Introduce a new __xfs_rwsem_islocked predicate to encapsulate checking
> > > the state of a rw_semaphore, then refactor xfs_isilocked to use it."
> > > 
> > > Since it's not quite a straight copy-paste of the old code.
> > 
> > Ah, ok. Sure, I can rephrase the changelog (or we can just update it on
> > commit if that's the only problem with this series...). Oh, now I've
> > remembered I've promised you a branch to pull :) Here it is with this
> > change and Christoph's Reviewed-by tags:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_fixes
> 
> To catch-up the list with the ext4 concall:
> 
> Dave Chinner and I have been experimenting with accepting tagged pull
> requests, where the tag message is the most recent cover letter so that
> the git history can capture the broader justification for the series and
> the development revision history.  Signed tags would be ideal too,
> though given the impossibility of meeting in person to exchange gnupg
> keys (and the fact that one has to verify that the patches in the branch
> more or less match what's on the list) I don't consider that an
> impediment.
> 
> Also, if you want me to take this through the xfs tree then it would
> make things much easier if you could base this branch off 5.13-rc4, or
> something that won't cause a merge request to pull in a bunch of
> unrelated upstream changes.

Oh, and also: Please send pull requests as a new thread tagged '[GIT
PULL]' so the requests don't get buried in a patch reply thread.

--D

> --D
> 
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
