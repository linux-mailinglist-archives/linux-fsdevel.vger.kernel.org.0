Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72774F0CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376677AbiDCXkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 19:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiDCXkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:40:42 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048C81081;
        Sun,  3 Apr 2022 16:38:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 37CFE10E55CE;
        Mon,  4 Apr 2022 09:38:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nb9nx-00DS7U-6x; Mon, 04 Apr 2022 09:38:45 +1000
Date:   Mon, 4 Apr 2022 09:38:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 3/4] generic/678: Add a new shutdown recovery test
Message-ID: <20220403233845.GT1609613@dread.disaster.area>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <2df6ee0680b5d2a6fad945e4936749f22abe72dd.1648730443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df6ee0680b5d2a6fad945e4936749f22abe72dd.1648730443.git.ritesh.list@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624a3007
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VnNF1IyMAAAA:8 a=968KyxNXAAAA:8
        a=7-415B0cAAAA:8 a=RT4zI6-5qFfLA4DtXGQA:9 a=CjuIK1q_8ugA:10
        a=i3p7wj428ZMNU9vUUNTn:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:24:22PM +0530, Ritesh Harjani wrote:
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> In certain cases (it is noted with ext4 fast_commit feature) that, replay phase
> may not delete the right range of blocks (after sudden FS shutdown)
> due to some operations which depends on inode->i_size (which during replay of
> an inode with fast_commit could be 0 for sometime).
> This fstest is added to test for such scenarios for all generic fs.
> 
> This test case is based on the test case shared via Xin Yin.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/678     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/678.out |  7 +++++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/678
>  create mode 100644 tests/generic/678.out
> 
> diff --git a/tests/generic/678 b/tests/generic/678
> new file mode 100755
> index 00000000..46a7be6c
> --- /dev/null
> +++ b/tests/generic/678
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 678
> +#
> +# This test with ext4 fast_commit feature w/o below patch missed to delete the right
> +# range during replay phase, since it depends upon inode->i_size (which might not be
> +# stable during replay phase, at least for ext4).
> +# 0b5b5a62b945a141: ext4: use ext4_ext_remove_space() for fast commit replay delete range
> +# (Based on test case shared by Xin Yin <yinxin.x@bytedance.com>)
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto shutdown quick log recoveryloop
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}

It's the same as the default cleanup function.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
