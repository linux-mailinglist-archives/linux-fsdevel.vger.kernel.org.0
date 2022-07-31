Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CE5861ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 00:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiGaW7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 18:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiGaW7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:59:07 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87579DF3B;
        Sun, 31 Jul 2022 15:59:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 27E3710C8BBC;
        Mon,  1 Aug 2022 08:59:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oIHtl-007fFO-Bv; Mon, 01 Aug 2022 08:59:01 +1000
Date:   Mon, 1 Aug 2022 08:59:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: generic/471 failing on linux-next -- KI?
Message-ID: <20220731225901.GY3600936@dread.disaster.area>
References: <YubHAqTCPvNj10Mx@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YubHAqTCPvNj10Mx@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62e70937
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=cIk7g4KtTNeGpiLFBgIA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 31, 2022 at 02:16:34PM -0400, Theodore Ts'o wrote:
> I was just doing a last test of ext4 merged with linux-next before the
> merge window opened, and I noticed generic/471 is now failing.  After
> some more investigation it's failing for xfs and ext4, with the same
> problem:
> 
>     --- tests/generic/471.out   2022-07-31 00:02:23.000000000 -0400
>     +++ /results/xfs/results-4k/generic/471.out.bad     2022-07-31 14:11:47.045330411 0
>     @@ -2,12 +2,10 @@
>      pwrite: Resource temporarily unavailable
>      wrote 8388608/8388608 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -RWF_NOWAIT time is within limits.
>     +pwrite: Resource temporarily unavailable
>     +(standard_in) 1: syntax error
>     +RWF_NOWAIT took  seconds
>     ...
> 
> I haven't had a chance to bisect this yet, and for a day or two --- so
> I figured I would ask --- is this a known issue?

Might have something to do with this set of changes:

https://lore.kernel.org/io-uring/c737af00-e879-fe01-380c-ba95b555f423@kernel.dk/

as it adds new places in the VFS that check for IOCB_NOWAIT.  Pretty
sure it triggers -EAGAIN on timestamp updates now (in
file_modified() calls), which is probably what is happening here....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
