Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC36A7A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 05:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCBEEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 23:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCBEEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:04:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757F36092;
        Wed,  1 Mar 2023 20:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Dhd6767pQ9B4fmJY8pvrA4c98sBJmkeXewyhhMbkQ4s=; b=DArjITYvSyRA8hwykvEP9WXJRS
        FSstE4CI5Ao7wGT9SJo36E6PhD6WNQa49UM1tm092RTfZu2MHxwIMgDPo27mGW738B4WIWUIUjMge
        coMcxOzsZWBKfu7QrsLzkcuvoVM63BWJacq/jlGmEofbGS9RbxbB6/h4DG102NaW+7JlxE7zi84VL
        bAK0QmzKkH0mpxWMLdyN4FTQ+dV2YVs+NKbpzPqPBjMm3IcC04Ykiw6k9NhYTwR+6Hkia+tBU7g5L
        jIVux/M9owfywhctB/45gHDCIc4rM23sLyHKd9EGRhR9moE45oN82DBoyyKRoRMRygPLH4l8rRBjy
        0iZtDAYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXaAb-002A0I-Vi; Thu, 02 Mar 2023 04:03:54 +0000
Date:   Thu, 2 Mar 2023 04:03:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZAAgKTWpwCE1fruV@casper.infradead.org>
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org>
 <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:50:24PM -0500, Pasha Tatashin wrote:
> On Tue, Feb 21, 2023 at 2:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> > My goal for 2023 is to get to a point where we (a) have struct page
> > reduced to:
> >
> > struct page {
> >         unsigned long flags;
> >         struct list_head lru;
> >         struct address_space *mapping;
> >         pgoff_t index;
> >         unsigned long private;
> >         atomic_t _mapcount;
> >         atomic_t _refcount;
> >         unsigned long memcg_data;
> > #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> >         int _last_cpupid;
> > #endif
> > };
> 
> This looks clean, but it is still 64-bytes. I wonder if we could
> potentially reduce it down to 56 bytes by removing memcg_data.

We need struct page to be 16-byte aligned to make slab work.  We also need
it to divide PAGE_SIZE evenly to make CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
work.  I don't think it's worth nibbling around the edges like this
anyway; convert everything from page to folio and then we can do the
big bang conversion where struct page shrinks from 64 bytes to 8.
