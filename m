Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1E83B00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 23:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfHFVW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 17:22:57 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43626 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbfHFVW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:22:57 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7490B43C5F0;
        Wed,  7 Aug 2019 07:22:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv6tw-000533-Gl; Wed, 07 Aug 2019 07:21:48 +1000
Date:   Wed, 7 Aug 2019 07:21:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] xfs: eagerly free shadow buffers to reduce CIL
 footprint
Message-ID: <20190806212148.GH7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-16-david@fromorbit.com>
 <20190805180300.GE14760@bfoster>
 <20190805233326.GA7777@dread.disaster.area>
 <20190806125727.GD2979@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806125727.GD2979@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=b5DoXVf_MhzvH81YMsoA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:57:27AM -0400, Brian Foster wrote:
> On Tue, Aug 06, 2019 at 09:33:26AM +1000, Dave Chinner wrote:
> > I'll recheck this, but I'm pretty sure overwrite won't leave a
> > shadow buffer around.
> > 
> 
> But before that we have the following logic:
> 
> static void
> xlog_cil_alloc_shadow_bufs(
> 	...
> 
> 	if (!lip->li_lv_shadow ||
> 	    buf_size > lip->li_lv_shadow->lv_size) {
> 		...
> 		lv = kmem_alloc_large(buf_size, KM_SLEEP | KM_NOFS);
> 		...
> 		lip->li_lv_shadow = lv;
> 	} else {
> 		<reuse shadow>
> 	}
> 	...
> }
> 
> ... which always allocates a shadow buffer if one doesn't exist. We
> don't look at the currently used (lip->li_lv) buffer at all here. IIUC,
> that has to do with the TOCTOU race described in the big comment above
> the function.. hm?

You might be right there. I haven't had a chance to follow up on
this from yesterday yet, so I'll keep this in mind when I look at it
again.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
