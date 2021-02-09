Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6020315270
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhBIPOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 10:14:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhBIPN6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:13:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7473B207;
        Tue,  9 Feb 2021 15:13:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 94CEDDA7C8; Tue,  9 Feb 2021 16:11:23 +0100 (CET)
Date:   Tue, 9 Feb 2021 16:11:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-ID: <20210209151123.GT1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210205232304.1670522-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205232304.1670522-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:23:00PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> There are many places where kmap/<operation>/kunmap patterns occur.  We lift
> these various patterns to core common functions and use them in the btrfs file
> system.  At the same time we convert those core functions to use
> kmap_local_page() which is more efficient in those calls.
> 
> I think this is best accepted through Andrew's tree as it has the mem*_page
> functions in it.  But I'd like to get an ack from David or one of the other
> btrfs maintainers before the btrfs patches go through.

I'd rather take the non-mm patches through my tree so it gets tested
the same way as other btrfs changes, straightforward cleanups or not.

This brings the question how to do that as the first patch should go
through the MM tree. One option is to posptpone the actual cleanups
after the 1st patch is merged but this could take a long delay.

I'd suggest to take the 1st patch within MM tree in the upcoming merge
window and then I can prepare a separate pull with just the cleanups.
Removing an inter-tree patch dependency was a sufficient reason for
Linus in the past for such pull requests.

> There are a lot more kmap->kmap_local_page() conversions but kmap_local_page()
> requires some care with the unmapping order and so I'm still reviewing those
> changes because btrfs uses a lot of loops for it's kmaps.

It sounds to me that converting the kmaps will take some time anyway so
exporting the helpers first and then converting the subsystems might be
a good option. In case you'd like to get rid of the simple cases in
btrfs code now we can do the 2 pull requests.
