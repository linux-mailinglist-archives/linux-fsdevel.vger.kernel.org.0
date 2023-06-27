Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0A73EF8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 02:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjF0AG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 20:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0AGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:06:55 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE2D8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 17:06:45 -0700 (PDT)
Date:   Mon, 26 Jun 2023 20:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687824403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uw3yWAwfBaI2hHM3ExlD7wOVlLTFWVfIVemZ/ktRU7E=;
        b=mxXDNAolCCtLqyQdmQ+Nj+Pan+xNzczBpQGviZY4jvXxQPMlySEyIi8OPWHl0bxNinqutD
        thIo/TMEmFVqn9cScliS1rGXU+eTfv4Ch+SygcVE3obTKgXFgpnJSk3HNNA6vmRFtY5uWw
        p4Z0qTeq5ORhw5+Na57j1ed2xy51BWQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
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

On Mon, Jun 26, 2023 at 05:11:29PM -0600, Jens Axboe wrote:
> > (Worth noting the bug causing the most test failures by a wide margin is
> > actually an io_uring bug that causes random umount failures in shutdown
> > tests. Would be great to get that looked at, it doesn't just affect
> > bcachefs).
> 
> Maybe if you had told someone about that it could get looked at?

I'm more likely to report bugs to people who have a history of being
responsive...

> What is the test case and what is going wrong?

Example: https://evilpiepirate.org/~testdashboard/c/82973f03c0683f7ecebe14dfaa2c3c9989dd29fc/xfstests.generic.388/log.br

I haven't personally seen it on xfs - Darrick knew something about it
but he's on vacation. If I track down a reproducer on xfs I'll let you
know.

If you're wanting to dig into it on bcachefs, ktest is pretty easy to
get going: https://evilpiepirate.org/git/ktest.git

  $ ~/ktest/root_image create
  # from your kernel tree:
  $ ~/ktest/build-test-kernel run -ILP ~/ktest/tests/bcachefs/xfstests.ktest/generic/388

I have some debug code I can give you from when I was tracing it through
the mount path, I still have to find or recreate the part that tracked
it down to io_uring...
