Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB22CD115
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbgLCIQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 03:16:40 -0500
Received: from verein.lst.de ([213.95.11.211]:57534 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgLCIQk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:16:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 018BA67373; Thu,  3 Dec 2020 09:15:56 +0100 (CET)
Date:   Thu, 3 Dec 2020 09:15:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Eric Sandeen <sandeen@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] common/rc: Fix _check_s_dax()
Message-ID: <20201203081556.GA15306@lst.de>
References: <20201202214145.1563433-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202214145.1563433-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 01:41:45PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> There is a conflict with the user visible statx bits 'mount root' and
> 'dax'.  The kernel is changing the dax bit to correct this conflict.[1]
> 
> Adjust _check_s_dax() to use the new bit.  Because DAX tests do not run
> on root mounts, STATX_ATTR_MOUNT_ROOT should always be 0, therefore we
> can allow either bit to indicate DAX and cover any kernel which may be
> running.
> 
> [1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> 
> I went ahead and used Christoph's suggestion regarding using both bits.

That wasn't my suggestion.  I think we should always error out when
the bit value shared with STATX_ATTR_MOUNT_ROOT is seen.  Because that
means the kernel is not using or fixed ABI we agreed to use going
forward.
