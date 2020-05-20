Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642141DB4A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgETNLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 09:11:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETNLa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 09:11:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9140AF26;
        Wed, 20 May 2020 13:11:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F00F21E126B; Wed, 20 May 2020 15:11:26 +0200 (CEST)
Date:   Wed, 20 May 2020 15:11:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200520131126.GA30597@quack2.suse.cz>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-4-ira.weiny@intel.com>
 <20200516020253.GG1009@sol.localdomain>
 <20200518050315.GA3025231@iweiny-DESK2.sc.intel.com>
 <20200518162447.GA954@sol.localdomain>
 <20200520020232.GA3470571@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520020232.GA3470571@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-05-20 19:02:33, Ira Weiny wrote:
> On Mon, May 18, 2020 at 09:24:47AM -0700, Eric Biggers wrote:
> > On Sun, May 17, 2020 at 10:03:15PM -0700, Ira Weiny wrote:
> 
> First off...  OMG...
> 
> I'm seeing some possible user pitfalls which are complicating things IMO.  It
> probably does not matter because most users don't care and have either enabled
> DAX on _every_ mount or _not_ enabled DAX on _every_ mount.  And have _not_
> used verity nor encryption while using DAX.
> 
> Verity is a bit easier because verity is not inherited and we only need to
> protect against setting it if DAX is on.
> 
> However, it can be weird for the user thusly:
> 
> 1) mount _without_ DAX
> 2) enable verity on individual inodes
> 3) unmount/mount _with_ DAX
> 
> Now the verity files are not enabled for DAX without any indication...
> <sigh> This is still true with my patch.  But at least it closes the hole
> of trying to change the DAX flag after the fact (because verity was set).
> 
> Also both this check and the verity need to be maintained to keep the mount
> option working as it was before...
> 
> For encryption it is more complicated because encryption can be set on
> directories and inherited so the IS_DAX() check does nothing while '-o
> dax' is used.  Therefore users can:
> 
> 1) mount _with_ DAX
> 2) enable encryption on a directory
> 3) files created in that directory will not have DAX set
> 
> And I now understand why the WARN_ON() was there...  To tell users about this
> craziness.

Thanks for digging into this! I agree that just not setting S_DAX where
other inode features disallow that is probably the best.

> > > This is, AFAICS, not going to affect correctness.  It will only be confusing
> > > because the user will be able to set both DAX and encryption on the directory
> > > but files there will only see encryption being used...  :-(
> > > 
> > > Assuming you are correct about this call path only being valid on directories.
> > > It seems this IS_DAX() needs to be changed to check for EXT4_DAX_FL in
> > > "fs/ext4: Introduce DAX inode flag"?  Then at that point we can prevent DAX and
> > > encryption on a directory.  ...  and at this point IS_DAX() could be removed at
> > > this point in the series???
> > 
> > I haven't read the whole series, but if you are indeed trying to prevent a
> > directory with EXT4_DAX_FL from being encrypted, then it does look like you'd
> > need to check EXT4_DAX_FL, not S_DAX.
> > 
> > The other question is what should happen when a file is created in an encrypted
> > directory when the filesystem is mounted with -o dax.  Actually, I think I
> > missed something there.  Currently (based on reading the code) the DAX flag will
> > get set first, and then ext4_set_context() will see IS_DAX() && i_size == 0 and
> > clear the DAX flag when setting the encrypt flag.
> 
> I think you are correct.
> 
> >
> > So, the i_size == 0 check is actually needed.
> > Your patch (AFAICS) just makes creating an encrypted file fail
> > when '-o dax'.  Is that intended?
> 
> Yes that is what I intended but it is more complicated I see now.
> 
> The intent is that IS_DAX() should _never_ be true on an encrypted or verity
> file...  even if -o dax is specified.  Because IS_DAX() should be a result of
> the inode flags being checked.  The order of the setting of those flags is a
> bit odd for the encrypted case.  I don't really like that DAX is set then
> un-set.  It is convoluted but I'm not clear right now how to fix it.
> 
> > If not, maybe you should change it to check
> > S_NEW instead of i_size == 0 to make it clearer?
> 
> The patch is completely unnecessary.
> 
> It is much easier to make (EXT4_ENCRYPT_FL | EXT4_VERITY_FL) incompatible
> with EXT4_DAX_FL when it is introduced later in the series.  Furthermore
> this mutual exclusion can be done on directories in the encrypt case.
> Which I think will be nicer for the user if they get an error when trying
> to set one when the other is set.

Agreed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
