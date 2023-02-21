Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA969DA24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 05:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjBUEjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 23:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjBUEjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:39:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21CBBBA;
        Mon, 20 Feb 2023 20:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676954370; x=1708490370;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=H6rTIPIOCt+UY2zyHDEnqkD8A6gukmrfa7VgPX8asaA=;
  b=MgIXr+ayVX5a6ALytxY27bVlp4btEtJuNY/hyfBI+SoT3ZmBg4Lcea0U
   DC0OMGRqunKdB2Jk58OxlnIyaZuWejWX18ZuaHPGqdQ6o8al9GZiI0c7H
   O2Q1uucQydWtZmOdvSexiWQ2R6/SrHvvIbwQi+gII25CZjvLFP9RbWlSp
   WhAs+8x9C2ZydU1f7PRWbnxrCXlBOQmCJCV8QflTp7gjd+WtJ1eI1lN7S
   799PaKAn0QHyi/e9cFnDxzpzJbL5B7Y4NeLhpyOCpzjMSssxDJjaHIYBv
   Kwje6w6cyI4oRAN7mjMm+RRRKMyKJcmk26oUVC2NrBES1kA4cQ/x3niSE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312914257"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="312914257"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 20:39:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="1000461185"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="1000461185"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 20:39:25 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
References: <20230213123444.155149-1-ying.huang@intel.com>
        <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com>
        <874jrg7kke.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2ab4b33e-f570-a6ff-6315-7d5a4614a7bd@google.com>
        <Y/RI4s45PZ6Bv2ZR@casper.infradead.org>
Date:   Tue, 21 Feb 2023 12:38:28 +0800
In-Reply-To: <Y/RI4s45PZ6Bv2ZR@casper.infradead.org> (Matthew Wilcox's message
        of "Tue, 21 Feb 2023 04:30:26 +0000")
Message-ID: <875ybveipn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Feb 20, 2023 at 06:48:38PM -0800, Hugh Dickins wrote:
>> Yes, that's a good principle, that we should avoid to lock/wait
>> synchronously once we have locked one folio (hmm, above you say
>> "more than one": I think we mean the same thing, we're just
>> stating it differently, given how the code runs at present).
>
> I suspect the migrate page code is disobeying the locking ordering
> rules for multiple folios.  if two folios belong to the same file,
> they must be locked by folio->index order, low to high.  If two folios
> belong to different files, they must be ordered by folio->mapping, the
> mapping lowest in memory first.  You can see this locking rule embedded
> in vfs_lock_two_folios() in fs/remap_range.c.
>
> I don't know what the locking rules are for two folios which are not file
> folios, or for two folios when one is anonymous and the other belongs
> to a file.  Maybe it's the same; you can lock them ordered by ->mapping
> first, then by ->index.
>
> Or you can just trylock multiple folios and skip the ones that don't work.

Yes.  We will only trylock when we have locked some folios (including
one).  And retry locking only after having processed and unlocked the
already locked folios.

Best Regards,
Huang, Ying
