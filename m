Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B681F4BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 04:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgFJC7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 22:59:09 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38302 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbgFJC7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:59:08 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 25BD5821015;
        Wed, 10 Jun 2020 12:59:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jiqxA-0002Vq-P3; Wed, 10 Jun 2020 12:59:00 +1000
Date:   Wed, 10 Jun 2020 12:59:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     darrick.wong@oracle.com, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Transient errors in Direct I/O
Message-ID: <20200610025900.GA2005@dread.disaster.area>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605204838.10765-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=5PYHEG6Ngi7WJpX9KO8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Please cc the XFS list on XFS and iomap infrastructure changes.]

On Fri, Jun 05, 2020 at 03:48:35PM -0500, Goldwyn Rodrigues wrote:
> In current scenarios, for XFS, it would mean that a page invalidation
> would end up being a writeback error. So, if iomap returns zero, fall
> back to biffered I/O. XFS has never supported fallback to buffered I/O.
> I hope it is not "never will" ;)

I wouldn't say "never", but we are not going to change XFS behaviour
because btrfs has a page invalidation vs DIO bug in it...

If you want to make a specific filesystem fall back to buffered IO
in this case, pass a new flag into iomap_dio_rw() to conditionally
abort the DIO on invalidation failure and let filesystem
implementations opt-in to use that flag.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
