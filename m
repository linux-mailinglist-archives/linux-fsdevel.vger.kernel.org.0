Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B621D7063
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgERFcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 01:32:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:46275 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERFcJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 01:32:09 -0400
IronPort-SDR: t0drqDhrAzvgctAUMj7WXYBl0b5h+AxtllxUbFufHP+JU4Uv0swHI3ZSS99eniFEyctclbK9AT
 qSAOiCnmyMVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 22:32:08 -0700
IronPort-SDR: 3FYr8W0oCV4c/oQ+sOt5p5Nh3NtHqVgXkB8CfcYLE9vAyq++sGDiWLe0tRVzXtw154rDbxCydD
 QzVc++4Nsl2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="342686939"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2020 22:32:07 -0700
Date:   Sun, 17 May 2020 22:32:07 -0700
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
Subject: Re: [PATCH 2/9] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200518053207.GB3025231@iweiny-DESK2.sc.intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-3-ira.weiny@intel.com>
 <20200516014916.GF1009@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516014916.GF1009@sol.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:49:16PM -0700, Eric Biggers wrote:
> On Tue, May 12, 2020 at 10:43:17PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> > flag change is wrong without a corresponding address_space_operations
> > update.
> > 
> > Make the 2 options mutually exclusive by returning an error if DAX was
> > set first.
> > 
> > (Setting DAX is already disabled if Verity is set first.)
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes:
> > 	remove WARN_ON_ONCE
> > 	Add documentation for DAX/Verity exclusivity
> > ---
> >  Documentation/filesystems/ext4/verity.rst | 7 +++++++
> >  fs/ext4/verity.c                          | 3 +++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
> > index 3e4c0ee0e068..51ab1aa17e59 100644
> > --- a/Documentation/filesystems/ext4/verity.rst
> > +++ b/Documentation/filesystems/ext4/verity.rst
> > @@ -39,3 +39,10 @@ is encrypted as well as the data itself.
> >  
> >  Verity files cannot have blocks allocated past the end of the verity
> >  metadata.
> > +
> > +Verity and DAX
> > +--------------
> > +
> > +Verity and DAX are not compatible and attempts to set both of these flags on a
> > +file will fail.
> > +
> 
> If you build the documentation, this shows up as its own subsection
> "2.13. Verity and DAX" alongside "2.12. Verity files", which looks odd.
> I think you should delete this new subsection header so that this paragraph goes
> in the existing "Verity files" subsection.

Ok...  I'll fix it up...

> 
> Also, Documentation/filesystems/fsverity.rst already mentions DAX (similar to
> fscrypt.rst).  Is it intentional that you added this to the ext4-specific
> documentation instead?

I proposed this text[1] and there were no objections...  I was looking at ext4
because only ext4 supports verity and DAX.  I think having this in both the
ext4 docs and the verity docs helps.

Ira

[1] https://lore.kernel.org/lkml/20200415191451.GA2305801@iweiny-DESK2.sc.intel.com/

> 
> - Eric
