Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30421DA7A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 04:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgETCCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 22:02:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:11305 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgETCCe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 22:02:34 -0400
IronPort-SDR: KXF6qd43oAx8/UnDSaK4asVuHJ+/bSNwS+SENonGqW++3WS/7MnzVhNci1siOL6aCqWtPKxamD
 w17MzyKZycIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 19:02:34 -0700
IronPort-SDR: m/fhxx6jPbq7qZ0zgedcE0xpHxfN3zP7A9oZnB302QnVzCHxMgMIzOf8NbcKm47m7FnUyO55hO
 +uQHaEVufyJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="282519935"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2020 19:02:33 -0700
Date:   Tue, 19 May 2020 19:02:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200520020232.GA3470571@iweiny-DESK2.sc.intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-4-ira.weiny@intel.com>
 <20200516020253.GG1009@sol.localdomain>
 <20200518050315.GA3025231@iweiny-DESK2.sc.intel.com>
 <20200518162447.GA954@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518162447.GA954@sol.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 09:24:47AM -0700, Eric Biggers wrote:
> On Sun, May 17, 2020 at 10:03:15PM -0700, Ira Weiny wrote:

First off...  OMG...

I'm seeing some possible user pitfalls which are complicating things IMO.  It
probably does not matter because most users don't care and have either enabled
DAX on _every_ mount or _not_ enabled DAX on _every_ mount.  And have _not_
used verity nor encryption while using DAX.

Verity is a bit easier because verity is not inherited and we only need to
protect against setting it if DAX is on.

However, it can be weird for the user thusly:

1) mount _without_ DAX
2) enable verity on individual inodes
3) unmount/mount _with_ DAX

Now the verity files are not enabled for DAX without any indication...  <sigh>
This is still true with my patch.  But at least it closes the hole of trying to
change the DAX flag after the fact (because verity was set).

Also both this check and the verity need to be maintained to keep the mount
option working as it was before...

For encryption it is more complicated because encryption can be set on
directories and inherited so the IS_DAX() check does nothing while '-o dax' is
used.  Therefore users can:

1) mount _with_ DAX
2) enable encryption on a directory
3) files created in that directory will not have DAX set

And I now understand why the WARN_ON() was there...  To tell users about this
craziness.

...

> > This is, AFAICS, not going to affect correctness.  It will only be confusing
> > because the user will be able to set both DAX and encryption on the directory
> > but files there will only see encryption being used...  :-(
> > 
> > Assuming you are correct about this call path only being valid on directories.
> > It seems this IS_DAX() needs to be changed to check for EXT4_DAX_FL in
> > "fs/ext4: Introduce DAX inode flag"?  Then at that point we can prevent DAX and
> > encryption on a directory.  ...  and at this point IS_DAX() could be removed at
> > this point in the series???
> 
> I haven't read the whole series, but if you are indeed trying to prevent a
> directory with EXT4_DAX_FL from being encrypted, then it does look like you'd
> need to check EXT4_DAX_FL, not S_DAX.
> 
> The other question is what should happen when a file is created in an encrypted
> directory when the filesystem is mounted with -o dax.  Actually, I think I
> missed something there.  Currently (based on reading the code) the DAX flag will
> get set first, and then ext4_set_context() will see IS_DAX() && i_size == 0 and
> clear the DAX flag when setting the encrypt flag.

I think you are correct.

>
> So, the i_size == 0 check is actually needed.
> Your patch (AFAICS) just makes creating an encrypted file fail
> when '-o dax'.  Is that intended?

Yes that is what I intended but it is more complicated I see now.

The intent is that IS_DAX() should _never_ be true on an encrypted or verity
file...  even if -o dax is specified.  Because IS_DAX() should be a result of
the inode flags being checked.  The order of the setting of those flags is a
bit odd for the encrypted case.  I don't really like that DAX is set then
un-set.  It is convoluted but I'm not clear right now how to fix it.

> If not, maybe you should change it to check
> S_NEW instead of i_size == 0 to make it clearer?

The patch is completely unnecessary.

It is much easier to make (EXT4_ENCRYPT_FL | EXT4_VERITY_FL) incompatible with
EXT4_DAX_FL when it is introduced later in the series.  Furthermore this mutual
exclusion can be done on directories in the encrypt case.  Which I think will
be nicer for the user if they get an error when trying to set one when the other
is set.

Ira

