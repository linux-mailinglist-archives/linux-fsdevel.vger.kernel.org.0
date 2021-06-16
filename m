Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22A3AA093
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhFPP7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:59:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbhFPP7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:59:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D62F21A32;
        Wed, 16 Jun 2021 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623859034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzEXeyUJtYhb/jhKtsstzQNYPYyugeSQ7deyI5/x/eg=;
        b=QluPc+xaSD6lMsYHFrTXOo9S19BGMh1dPOZCU9V9lAjMlVkbzEPC76NIYkzAlyHL6z0G2X
        6V1D7RAO4dKfvHWXp9WKGolBz/Xim2qqndj/0aTBqw4NNJ/W710NpTjVSzVtUU+bCo6ztK
        HR1Cd37auJvcp2UU0GST9EsPQ8ys2k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623859034;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzEXeyUJtYhb/jhKtsstzQNYPYyugeSQ7deyI5/x/eg=;
        b=jHTUUdWi2cy0yZq6g8W0CohAQJWdKoqUkM3WbwT5QWy5M/vj4YqpLcOCdoKxgHFiAm+6jn
        h8dOe0bJlFuiCtAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 638F1A3BAE;
        Wed, 16 Jun 2021 15:57:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4FE0F1F2C68; Wed, 16 Jun 2021 17:57:12 +0200 (CEST)
Date:   Wed, 16 Jun 2021 17:57:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20210616155712.GC28250@quack2.suse.cz>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
 <YMmOCK4wHc9lerEc@infradead.org>
 <20210616085304.GA28250@quack2.suse.cz>
 <20210616154705.GE158209@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616154705.GE158209@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-06-21 08:47:05, Darrick J. Wong wrote:
> On Wed, Jun 16, 2021 at 10:53:04AM +0200, Jan Kara wrote:
> > On Wed 16-06-21 06:37:12, Christoph Hellwig wrote:
> > > On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> > > > From: Pavel Reichl <preichl@redhat.com>
> > > > 
> > > > Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> > > > __xfs_rwsem_islocked() is a helper function which encapsulates checking
> > > > state of rw_semaphores hold by inode.
> > > 
> > > __xfs_rwsem_islocked doesn't seem to actually existing in any tree I
> > > checked yet?
> > 
> > __xfs_rwsem_islocked is introduced by this patch so I'm not sure what are
> > you asking about... :)
> 
> The sentence structure implies that __xfs_rwsem_islocked was previously
> introduced.  You might change the commit message to read:
> 
> "Introduce a new __xfs_rwsem_islocked predicate to encapsulate checking
> the state of a rw_semaphore, then refactor xfs_isilocked to use it."
> 
> Since it's not quite a straight copy-paste of the old code.

Ah, ok. Sure, I can rephrase the changelog (or we can just update it on
commit if that's the only problem with this series...). Oh, now I've
remembered I've promised you a branch to pull :) Here it is with this
change and Christoph's Reviewed-by tags:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_fixes

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
