Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4E1B2F48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDUSlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 14:41:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:18744 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUSlo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:41:44 -0400
IronPort-SDR: PTS5lSis9Qt1jcgpVsovZUVlq9tuDb5w1WAIklpW8/WycJl9kUkYLfiY4f0EBG0XfYInt7Pxon
 l+ti4t5Jdrog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 11:41:43 -0700
IronPort-SDR: wxusfE3TwKkqUex+ckbUR0PXgl6jp5AVs0GAuZF2Yz11Cf+4DqLyaVx0NvE14wZ+R9dSrr7+R9
 Si+SLKcEFIRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="429625590"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2020 11:41:43 -0700
Date:   Tue, 21 Apr 2020 11:41:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200421184143.GA3004764@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-4-ira.weiny@intel.com>
 <20200415160307.GJ90651@mit.edu>
 <20200415195433.GC2305801@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415195433.GC2305801@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:54:34PM -0700, 'Ira Weiny' wrote:
> On Wed, Apr 15, 2020 at 12:03:07PM -0400, Theodore Y. Ts'o wrote:
> > On Mon, Apr 13, 2020 at 09:00:25PM -0700, ira.weiny@intel.com wrote:
 
[snip]

> > 
> > Also note that encrypted files are read/write so we must never allow
> > the combination of ENCRPYT_FL and DAX_FL.  So that may be something
> > where we should teach __ext4_iget() to check for this, and declare the
> > file system as corrupted if it sees this combination.
> 
> ok...

After thinking about this...

Do we really want to declare the FS corrupted?

If so, I think we need to return errors when such a configuration is attempted.
If in the future we have an encrypted mode which can co-exist with DAX (such as
Dan mentioned) we can change this.

FWIW I think we should return errors when such a configuration is attempted but
_not_ declare the FS corrupted.  That allows users to enable this configuration
later if we can figure out how to support it.

> 
> > (For VERITY_FL
> > && DAX_FL that is a combo that we might want to support in the future,
> > so that's probably a case where arguably, we should just ignore the
> > DAX_FL for now.)
> 
> ok...

I think this should work the same.

It looks like VERITY_FL and ENCRYPT_FL are _not_ user modifiable?  Is that
correct?

You said that ENCRPYT_FL is set from the parent directory?  But I'm not seeing
where that occurs?

Similarly I don't see where VERITY_FL is being set either?  :-/

I think to make this work correctly we should restrict setting those flags if
DAX_FL is set and vice versa.  But I'm not finding where to do that.  :-/

Ira

> 
> Ira
> 
