Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44A813F51C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404263AbgAPSyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 13:54:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:23625 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbgAPSyV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:54:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 10:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="218642515"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2020 10:54:19 -0800
Date:   Thu, 16 Jan 2020 10:54:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 07/12] fs: Add locking for a dynamic inode 'mode'
Message-ID: <20200116185417.GF24522@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-8-ira.weiny@intel.com>
 <20200113221218.GM8247@magnolia>
 <20200114002005.GA29860@iweiny-DESK2.sc.intel.com>
 <20200114010322.GS8247@magnolia>
 <20200115190846.GE23311@iweiny-DESK2.sc.intel.com>
 <20200116054040.GC8235@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116054040.GC8235@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:40:40PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2020 at 11:08:46AM -0800, Ira Weiny wrote:
> > On Mon, Jan 13, 2020 at 05:03:22PM -0800, Darrick J. Wong wrote:
> > > On Mon, Jan 13, 2020 at 04:20:05PM -0800, Ira Weiny wrote:
> > > > On Mon, Jan 13, 2020 at 02:12:18PM -0800, Darrick J. Wong wrote:
> > > > > On Fri, Jan 10, 2020 at 11:29:37AM -0800, ira.weiny@intel.com wrote:
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > [snip]
> > 
> > > > > > +``lock_mode``
> > > > > > +	called to prevent operations which depend on the inode's mode from
> > > > > > +        proceeding should a mode change be in progress
> > > > > 
> > > > > "Inodes can't change mode, because files do not suddenly become
> > > > > directories". ;)
> > > > 
> > > > Yea sorry.
> > > > 
> > > > > 
> > > > > Oh, you meant "lock_XXXX is called to prevent a change in the pagecache
> > > > > mode from proceeding while there are address space operations in
> > > > > progress".  So these are really more aops get and put functions...
> > > > 
> > > > At first I actually did have aops get/put functions but this is really
> > > > protecting more than the aops vector because as Christoph said there are file
> > > > operations which need to be protected not just address space operations.
> > > > 
> > > > But I agree "mode" is a bad name...  Sorry...
> > > 
> > > inode_fops_{get,set}(), then?
> > > 
> > > inode_start_fileop()
> > > inode_end_fileop() ?
> > > 
> > > Trying to avoid sounding foppish <COUGH>
> > 
> > What about?
> > 
> > inode_[un]lock_state()?
> 
> Kinda vague -- which state?  inodes retain a lot of different state.
> 
> This locking primitive ensures that file operations pointers can't
> change while any operations are ongoing, right?

file ops
Address space ops
...

Whatever it needs...

With the current patch set we could be more specific and call it.

inode_[un]lock_dax_state()

Ira

> 
> --D
> 
> > Ira
> > 
