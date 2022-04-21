Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5252509992
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386157AbiDUHub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386246AbiDUHuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:50:12 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 822051CB29;
        Thu, 21 Apr 2022 00:46:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2C10310E5C0F;
        Thu, 21 Apr 2022 17:46:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nhRWf-002hck-5w; Thu, 21 Apr 2022 17:46:53 +1000
Date:   Thu, 21 Apr 2022 17:46:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
Message-ID: <20220421074653.GT1544202@dread.disaster.area>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220421012045.GR1544202@dread.disaster.area>
 <86cb0ada-208c-02de-dbc9-53c6014892c3@fujitsu.com>
 <CAPcyv4i0Noum8hqHtCpdM5HMVdmNHm3Aj2JCnZ+KZLgceiXYaA@mail.gmail.com>
 <20220421043502.GS1544202@dread.disaster.area>
 <YmDxs1Hj4H/cu2sd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmDxs1Hj4H/cu2sd@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62610bf2
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=Mb5XfCdAhjU6mY5isQ0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:54:59PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 02:35:02PM +1000, Dave Chinner wrote:
> > Sure, I'm not a maintainer and just the stand-in patch shepherd for
> > a single release. However, being unable to cleanly merge code we
> > need integrated into our local subsystem tree for integration
> > testing because a patch dependency with another subsystem won't gain
> > a stable commit ID until the next merge window is .... distinctly
> > suboptimal.
> 
> Yes.  Which is why we've taken a lot of mm patchs through other trees,
> sometimes specilly crafted for that.  So I guess in this case we'll
> just need to take non-trivial dependencies into the XFS tree, and just
> deal with small merge conflicts for the trivial ones.

OK. As Naoyo has pointed out, the first dependency/conflict Ruan has
listed looks trivial to resolve.

The second dependency, OTOH, is on a new function added in the patch
pointed to. That said, at first glance it looks to be independent of
the first two patches in that series so I might just be able to pull
that one patch in and have that leave us with a working
fsdax+reflink tree.

Regardless, I'll wait to see how much work the updated XFS/DAX
reflink enablement patchset still requires when Ruan posts it before
deciding what to do here.  If it isn't going to be a merge
candidate, what to do with this patchset is moot because there's
little to test without reflink enabled...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
