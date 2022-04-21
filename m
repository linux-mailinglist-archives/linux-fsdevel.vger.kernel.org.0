Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF18850949D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 03:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383611AbiDUBXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDUBXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:23:37 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F379313F4A;
        Wed, 20 Apr 2022 18:20:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A59B8534640;
        Thu, 21 Apr 2022 11:20:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nhLUz-002b2q-G6; Thu, 21 Apr 2022 11:20:45 +1000
Date:   Thu, 21 Apr 2022 11:20:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
Message-ID: <20220421012045.GR1544202@dread.disaster.area>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6260b170
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=7EZY2-qYyHQqCbfsKPUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ruan,

On Tue, Apr 19, 2022 at 12:50:38PM +0800, Shiyang Ruan wrote:
> This patchset is aimed to support shared pages tracking for fsdax.

Now that this is largely reviewed, it's time to work out the
logistics of merging it.

> Changes since V12:
>   - Rebased onto next-20220414

What does this depend on that is in the linux-next kernel?

i.e. can this be applied successfully to a v5.18-rc2 kernel without
needing to drag in any other patchsets/commits/trees?

What are your plans for the followup patches that enable
reflink+fsdax in XFS? AFAICT that patchset hasn't been posted for
while so I don't know what it's status is. Is that patchset anywhere
near ready for merge in this cycle?

If that patchset is not a candidate for this cycle, then it largely
doesn't matter what tree this is merged through as there shouldn't
be any major XFS or dax dependencies being built on top of it during
this cycle. The filesystem side changes are isolated and won't
conflict with other work in XFS, either, so this could easily go
through Dan's tree.

However, if the reflink enablement is ready to go, then this all
needs to be in the XFS tree so that we can run it through filesystem
level DAX+reflink testing. That will mean we need this in a stable
shared topic branch and tighter co-ordination between the trees.

So before we go any further we need to know if the dax+reflink
enablement patchset is near being ready to merge....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
