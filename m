Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57387618A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 02:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfGHACN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 20:02:13 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36838 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbfGHACM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 20:02:12 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A9A4643B878;
        Mon,  8 Jul 2019 10:02:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hkH5b-0006vw-J9; Mon, 08 Jul 2019 10:01:03 +1000
Date:   Mon, 8 Jul 2019 10:01:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: RFC: use the iomap writepage path in gfs2
Message-ID: <20190708000103.GH7689@dread.disaster.area>
References: <20190701215439.19162-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=BIJwB3zSu3MTrXN99fEA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:54:24PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> in this straight from the jetplane edition I present the series to
> convert gfs2 to full iomap usage for the ordered and writeback mode,
> that is we use iomap_page everywhere and entirely get rid of
> buffer_heads in the data path.  This has only seen basic testing
> which ensured neither 4k or 1k blocksize in ordered mode regressed
> vs the xfstests baseline, although that baseline tends to look
> pretty bleak.
> 
> The series is to be applied on top of my "lift the xfs writepage code
> into iomap v2" series.

Ok, this doesn't look too bad from the iomap perspective, though it
does raise more questions. :)

gfs2 now has two iopaths, right? One that uses bufferheads for
journalled data, and the other that uses iomap? That seems like it's
only a partial conversion - what needs to be done to iomap and gfs2
to support the journalled data path so there's a single data IO
path?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
