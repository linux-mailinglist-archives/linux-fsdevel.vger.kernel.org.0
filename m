Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2724F6F03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 02:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiDGAQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDGAQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:16:53 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27291129;
        Wed,  6 Apr 2022 17:14:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EF2C510E56D1;
        Thu,  7 Apr 2022 10:14:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ncFnZ-00EeE5-KV; Thu, 07 Apr 2022 10:14:53 +1000
Date:   Thu, 7 Apr 2022 10:14:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: sporadic hangs on generic/186
Message-ID: <20220407001453.GE1609613@dread.disaster.area>
References: <20220406195424.GA1242@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406195424.GA1242@fieldses.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624e2cff
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=sKvHfXEZqrtYHvUw-VQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:54:24PM -0400, J. Bruce Fields wrote:
> In the last couple days I've started getting hangs on xfstests
> generic/186 on upstream.  I also notice the test completes after 10+
> hours (usually it takes about 5 minutes).  Sometimes this is accompanied
> by "nfs: RPC call returned error 12" on the client.

#define ENOMEM          12      /* Out of memory */

So either the client or the server is running out of memory
somewhere?

> Test description is:
> 
> # Ensuring that copy on write in buffered mode works when free space
> # is heavily fragmented.
> #   - Create two files
> #   - Reflink the odd blocks of the first file into a third file.
> #   - Reflink the even blocks of the second file into the third file.
> #   - Try to fragment the free space by allocating a huge file and
> #     punching out every other block.
> #   - CoW across the halfway mark.
> #   - Check that the files are now different where we say they're
> #   different.

It's using clone_file_range and hole punch, so I'm assuming that
this is nfsv4 client side testing? In which case, the behaviour is
going to be largely dependent on the server side implementation of
these functions? Does reverting the client or the server to an older
kernel resolve the issue?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
