Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC7339769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 20:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhCLT25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 14:28:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:59680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhCLT2f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:28:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E268AF4D;
        Fri, 12 Mar 2021 19:28:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D393DA81D; Fri, 12 Mar 2021 20:26:34 +0100 (CET)
Date:   Fri, 12 Mar 2021 20:26:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/btrfs: Convert raid5/6 kmaps to kmap_local_page()
Message-ID: <20210312192634.GS7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210217024826.3466046-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217024826.3466046-3-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:48:24PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> These kmaps are thread local and don't need to be atomic.  So they can use
> the more efficient kmap_local_page().  However, the mapping of pages in
> the stripes and the additional parity and qstripe pages are a bit
> trickier because the unmapping must occur in the opposite order from the
> mapping.  Furthermore, the pointer array in __raid_recover_end_io() may
> get reordered.
> 
> Convert these calls to kmap_local_page() taking care to reverse the
> unmappings of any page arrays as well as being careful with the mappings
> of any special pages such as the parity and qstripe pages.

Though there's one more allocation for the additional array, I don't see
a simpler way to avoid it and track the array reordering at a lower
memory cost. At least it's not in a performance critical code and the
array size is reasonably small.
