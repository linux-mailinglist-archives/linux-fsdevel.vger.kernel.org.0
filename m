Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2503773F0B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 04:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjF0CFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 22:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF0CFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:05:35 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861571716
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 19:05:32 -0700 (PDT)
Date:   Mon, 26 Jun 2023 22:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687831531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ef/1Ge/WuT0yMB7GlpTDrBAisnbBZbpCd6yjqL4VLqE=;
        b=XFnLuxIFjl5nqv8Oy7Cwz1p9J4iYFBhJKYOstR7A/K9rYQ7yvPiUFmuWfTKsm0Jt9xpVVZ
        AuVpzyqS1H0p5V2Aw2J7dGu1dfH3tZE8HA701vT9daeAxm/liOAbYXM1opJe7VbP1rQkcy
        xljGuupJzuJ4mzMH2ywkrK/gFqzWZJk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
> either:

It just popped for me on xfs, but it took half an hour or so of looping
vs. 30 seconds on bcachefs.

> ~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest/generic/388
> realpath: /home/axboe/git/ktest/tests/bcachefs/xfstests.ktest/generic/388: Not a directory
> Error 1 at /home/axboe/git/ktest/build-test-kernel 262 from: ktest_test=$(realpath "$1"), exiting
> 
> and I suspect that should've been a space, but:
> 
> ~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest generic/388
> Running test xfstests.ktest on m1max at /home/axboe/git/linux-block
> No tests found
> TEST FAILED

doh, this is because we just changed it to pick up the list of tests
from the test lists that fstests generated.

Go into ktest/tests/xfstests and run make and it'll work. (Doesn't
matter if make fails due to missing libraries, it'll re-run make inside
the VM where the dependencies will all be available).

> As a side note, I do get these when compiling:
> 
> fs/bcachefs/alloc_background.c: In function ‘bch2_check_alloc_info’:
> fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  1526 | }
>       | ^
> fs/bcachefs/reflink.c: In function ‘bch2_remap_range’:
> fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>   388 | }

yeah neither of those are super critical because they run top of the
stack, but they do need to be addressed. might be time to start heap
allocating btree_trans.
