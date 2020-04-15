Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C31AB216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441908AbgDOTyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 15:54:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:63487 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441903AbgDOTyf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:54:35 -0400
IronPort-SDR: DytPXnRqkWwAOMaiIWyKsPd9ovHzwxlojwTUIV/Is+2XGqOSVPTJy5YUOC9UeRJpc3Y+K+NyeK
 qy3ityAsM/wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:54:34 -0700
IronPort-SDR: UYnRfjVorTkLlQYMLokFH4wd30kYLHIexetLQi98g7aKH3mQdcDdbo1EAyafNUj3AJiXpN1pGb
 hKLytQ2zJ6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="274255875"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2020 12:54:34 -0700
Date:   Wed, 15 Apr 2020 12:54:34 -0700
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
Message-ID: <20200415195433.GC2305801@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-4-ira.weiny@intel.com>
 <20200415160307.GJ90651@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415160307.GJ90651@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:03:07PM -0400, Theodore Y. Ts'o wrote:
> On Mon, Apr 13, 2020 at 09:00:25PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Encryption and DAX are incompatible.  Changing the DAX mode due to a
> > change in Encryption mode is wrong without a corresponding
> > address_space_operations update.
> > 
> > Make the 2 options mutually exclusive by returning an error if DAX was
> > set first.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> The encryption flag is inherited from the containing directory, and
> directories can't have the DAX flag set,

But they can have FS_XFLAG_DAX set.

> so anything we do in
> ext4_set_context() will be safety belt / sanity checking in nature.
> 
> But we *do* need to figure out what we do with mount -o dax=always
> when the file system might have encrypted files.  My previous comments
> about the verity flag and dax flag applies here.

:-( agreed.

FWIW without these patches an inode which has encrypt or verity set is already
turning off DAX...  So we already have a '-o dax' flag which is not "always".

:-(

Unfortunately the 'always' designation kind of breaks semantically but it is
equal to the current mount option.

> 
> Also note that encrypted files are read/write so we must never allow
> the combination of ENCRPYT_FL and DAX_FL.  So that may be something
> where we should teach __ext4_iget() to check for this, and declare the
> file system as corrupted if it sees this combination.

ok...

> (For VERITY_FL
> && DAX_FL that is a combo that we might want to support in the future,
> so that's probably a case where arguably, we should just ignore the
> DAX_FL for now.)

ok...

Ira

