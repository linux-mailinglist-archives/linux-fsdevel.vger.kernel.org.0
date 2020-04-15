Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7671AACD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410134AbgDOQDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 12:03:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32983 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2410121AbgDOQD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:03:27 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03FG374v005145
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 12:03:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C73242013D; Wed, 15 Apr 2020 12:03:07 -0400 (EDT)
Date:   Wed, 15 Apr 2020 12:03:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200415160307.GJ90651@mit.edu>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-4-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:00:25PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Encryption and DAX are incompatible.  Changing the DAX mode due to a
> change in Encryption mode is wrong without a corresponding
> address_space_operations update.
> 
> Make the 2 options mutually exclusive by returning an error if DAX was
> set first.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

The encryption flag is inherited from the containing directory, and
directories can't have the DAX flag set, so anything we do in
ext4_set_context() will be safety belt / sanity checking in nature.

But we *do* need to figure out what we do with mount -o dax=always
when the file system might have encrypted files.  My previous comments
about the verity flag and dax flag applies here.

Also note that encrypted files are read/write so we must never allow
the combination of ENCRPYT_FL and DAX_FL.  So that may be something
where we should teach __ext4_iget() to check for this, and declare the
file system as corrupted if it sees this combination.  (For VERITY_FL
&& DAX_FL that is a combo that we might want to support in the future,
so that's probably a case where arguably, we should just ignore the
DAX_FL for now.)

					- Ted
