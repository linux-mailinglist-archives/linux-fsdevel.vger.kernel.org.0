Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F071810B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 07:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgCKG34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 02:29:56 -0400
Received: from verein.lst.de ([213.95.11.211]:57474 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKG34 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:29:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADA7868C4E; Wed, 11 Mar 2020 07:29:52 +0100 (CET)
Date:   Wed, 11 Mar 2020 07:29:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations
 V5
Message-ID: <20200311062952.GA11519@lst.de>
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de> <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311033614.GQ1752567@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:36:14PM -0700, Darrick J. Wong wrote:
> 1) Leave the inode flag (FS_XFLAG_DAX) as it is, and export the S_DAX
> status via statx.  Document that changes to FS_XFLAG_DAX do not take
> effect immediately and that one must check statx to find out the real
> mode.  If we choose this, I would also deprecate the dax mount option;
> send in my mkfs.xfs patch to make it so that you can set FS_XFLAG_DAX on
> all files at mkfs time; and we can finally lay this whole thing to rest.
> This is the closest to what we have today.
> 
> 2) Withdraw FS_XFLAG_DAX entirely, and let the kernel choose based on
> usage patterns, hardware heuristics, or spiteful arbitrariness.

3) Only allow changing FS_XFLAG_DAX on directories or files that do
not have blocks allocated to them yet, and side step all the hard
problems.

Which of course still side steps the hard question of what it actually
is supposed to mean..
