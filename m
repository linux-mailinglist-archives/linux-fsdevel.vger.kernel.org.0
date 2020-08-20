Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0FF24C833
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 01:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHTXLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 19:11:45 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:50583 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728368AbgHTXLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:11:45 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 12B711A96D6;
        Fri, 21 Aug 2020 09:11:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k8tie-0007W7-9n; Fri, 21 Aug 2020 09:11:40 +1000
Date:   Fri, 21 Aug 2020 09:11:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200820231140.GE7941@dread.disaster.area>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
        a=QKTNYlJRi8Dho5xtcI0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> __bio_try_merge_page() may return same_page = 1 and merged = 0. 
> This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 

Ummm, silly question, but exactly how are we getting a bio that
large in ->writepages getting built? Even with 64kB pages, that's a
bio with 2^16 pages attached to it. We shouldn't be building single
bios in writeback that large - what storage hardware is allowing
such huge bios to be built? (i.e. can you dump all the values in
/sys/block/<dev>/queue/* for that device for us?)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
