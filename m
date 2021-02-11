Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCF319341
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 20:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhBKTko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 14:40:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:55058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhBKTkj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:40:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA027AF21;
        Thu, 11 Feb 2021 19:39:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CEA55DA6E9; Thu, 11 Feb 2021 20:38:03 +0100 (CET)
Date:   Thu, 11 Feb 2021 20:38:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 0/8] btrfs: convert kmaps to core page calls
Message-ID: <20210211193803.GH1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:22:13PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Changes from V1:
> 	Rework commit messages because they were very weak
> 	Change 'fs/btrfs: X' to 'btrfs: x'
> 		https://lore.kernel.org/lkml/20210209151442.GU1993@suse.cz/
> 	Per Andrew
> 		Split out changes to highmem.h
> 			The addition memcpy, memmove, and memset page functions
> 			The change from kmap_atomic to kmap_local_page
> 			The addition of BUG_ON
> 			The conversion of memzero_page to zero_user in iov_iter
> 		Change BUG_ON to VM_BUG_ON
> 	While we are refactoring adjust the line length down per Chaitany
> 
> 
> There are many places where kmap/<operation>/kunmap patterns occur.  We lift a
> couple of these patterns to the core common functions and use them as well as
> existing core functions in the btrfs file system.  At the same time we convert
> those core functions to use kmap_local_page() which is more efficient in those
> calls.
> 
> Per the conversation on V1 it looks like Andrew would like this to go through
> the btrfs tree.  I think that is fine.  The other users of
> memcpy_[to|from]_page are probably not ready and I believe could be taken in an
> early rc after David submits.
> 
> Is that ok with you David?

Yes.

The branch is now in
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/log/?h=kmap-conversion
let me know if I've missed acked-by or reviewed-by, I added those sent
to the mailinglist and added mine to the btrfs ones and to the iov_iter
patch.

I'll add the patchset to my for-next so it gets picked by linux-next and
will keep testing it for at least a week.

Though this is less than the expected time before merge window, the
reasoning is that it's exporting helpers that are going to be used in
various subsystems. The changes in btrfs are simple and would allow to
focus on the other less trivial conversions. ETA for the pull request is
mid of the 2nd week of the merge window or after rc1.
