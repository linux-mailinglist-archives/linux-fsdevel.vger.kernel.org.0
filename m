Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE34E2DA576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 02:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgLOBNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 20:13:25 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:41141 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbgLOBNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:13:24 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 502E87668A5;
        Tue, 15 Dec 2020 12:12:41 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1koytM-0043LY-Pw; Tue, 15 Dec 2020 12:12:40 +1100
Date:   Tue, 15 Dec 2020 12:12:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201215011240.GJ632069@dread.disaster.area>
References: <20201209131146.67289-1-laoar.shao@gmail.com>
 <20201209131146.67289-4-laoar.shao@gmail.com>
 <20201209195235.GN1943235@magnolia>
 <CALOAHbD_DK9w=s9RDsVBNaYwgeRi4UUEGDHFb3zEsqh_V8gLMA@mail.gmail.com>
 <20201214210833.GE632069@dread.disaster.area>
 <CALOAHbAK=OB1NQKwNYHttBuM=QZjc04cjU=YRw5MoTWT34HXvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAK=OB1NQKwNYHttBuM=QZjc04cjU=YRw5MoTWT34HXvg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8 a=yPCof4ZbAAAA:8
        a=U7ryOahPNW6b4qIbDJ8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:42:08AM +0800, Yafang Shao wrote:
> On Tue, Dec 15, 2020 at 5:08 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Sun, Dec 13, 2020 at 05:09:02PM +0800, Yafang Shao wrote:
> > > On Thu, Dec 10, 2020 at 3:52 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > On Wed, Dec 09, 2020 at 09:11:45PM +0800, Yafang Shao wrote:
> > static inline void
> > xfs_trans_context_clear(struct xfs_trans *tp)
> > {
> >         /*
> >          * If xfs_trans_context_swap() handed the NOFS context to a
> >          * new transaction we do not clear the context here.
> >          */
> >         if (current->journal_info != tp)
> 
> current->journal_info hasn't been used in patch #3, that will make
> patch #3 a little more complex.
> We have to do some workaround in patch #3. I will think about it.

What I wrote is how the function should look at the end of the patch
series.  Do not add the current->journal_info parts of it until the
patch that introduces the current->journal_info tracking.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
