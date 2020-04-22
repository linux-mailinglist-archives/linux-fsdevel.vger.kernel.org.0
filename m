Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2321B35B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 05:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgDVDqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 23:46:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:52549 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgDVDqK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:10 -0400
IronPort-SDR: 6Ut0L7yFzfrB6TRQQ5x4/0IbWFB4BtN6O3EFQjNrdYJ8FMKv8+rFCoA3QIUrfyVyO8gw2I7+gB
 DI+XOCQDS56A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 20:46:10 -0700
IronPort-SDR: /eKAMA4Z+MGLgmc7pg47zfyleZZfStf928BZ4SShuUGk9rZzdCpDBrU1XUAGBDYUIyMNfIvWzv
 f+akZuFVWrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="402401206"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2020 20:46:09 -0700
Date:   Tue, 21 Apr 2020 20:46:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200422034609.GH3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-10-ira.weiny@intel.com>
 <20200421202519.GC6742@magnolia>
 <20200422023407.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422023407.GH23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:34:07AM +0100, Al Viro wrote:
> On Tue, Apr 21, 2020 at 01:25:19PM -0700, Darrick J. Wong wrote:
> 
> > > DCACHE_DONTCACHE indicates a dentry should not be cached on final
> > > dput().
> > > 
> > > Also add a helper function to mark DCACHE_DONTCACHE on all dentries
> > > pointing to a specific inode when that inode is being set I_DONTCACHE.
> > > 
> > > This facilitates dropping dentry references to inodes sooner which
> > > require eviction to swap S_DAX mode.
> 
> Explain, please.  Questions:
> 
> 1) does that ever happen to directories?

Directories never get S_DAX set.  So the eviction only needs to happen on
inodes.  But that can't happen without dentries also dropping their references.

> 2) how much trouble do we get if such inode is *NOT* evicted for, say, several
> days?

No trouble at all.  Users understand that changing the FS_XFLAG_DAX setting
does _not_ immediately result in S_DAX changing.

It is intended that applications requiring a change of mode would flip the
FS_XFLAG_DAX close the file and wait for the eviction (or force it through a
drop cache if they have permission).

Ira

