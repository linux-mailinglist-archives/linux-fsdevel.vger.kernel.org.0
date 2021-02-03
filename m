Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29530DEF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhBCP7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 10:59:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:49982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234717AbhBCP7V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:59:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31385AC55;
        Wed,  3 Feb 2021 15:58:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90BD0DA6FC; Wed,  3 Feb 2021 16:56:48 +0100 (CET)
Date:   Wed, 3 Feb 2021 16:56:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Miao Xie <miaox@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix raid6 qstripe kmap'ing
Message-ID: <20210203155648.GE1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        Miao Xie <miaox@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210128061503.1496847-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128061503.1496847-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:15:03PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> When a qstripe is required an extra page is allocated and mapped.  There
> were 3 problems.
> 
> 1) There is no reason to map the qstripe page more than 1 time if the
>    number of bits set in rbio->dbitmap is greater than one.
> 2) There is no reason to map the parity page and unmap it each time
>    through the loop.
> 3) There is no corresponding call of kunmap() for the qstripe page.
> 
> The page memory can continue to be reused with a single mapping on each
> iteration by raid6_call.gen_syndrome() without remapping.  So map the
> page for the duration of the loop.
> 
> Similarly, improve the algorithm by mapping the parity page just 1 time.
> 
> Fixes: 5a6ac9eacb49 ("Btrfs, raid56: support parity scrub on raid56")
> To: Chris Mason <clm@fb.com>
> To: Josef Bacik <josef@toxicpanda.com>
> To: David Sterba <dsterba@suse.com>
> Cc: Miao Xie <miaox@cn.fujitsu.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> This was found while replacing kmap() with kmap_local_page().  After
> this patch unwinding all the mappings becomes pretty straight forward.
> 
> I'm not exactly sure I've worded this commit message intelligently.
> Please forgive me if there is a better way to word it.

Changelog is good, thanks. I've added stable tags as the missing unmap
is a potential problem.
