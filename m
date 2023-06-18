Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95B73448D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 02:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjFRAfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 20:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFRAfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:35:06 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08F1719
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 17:35:04 -0700 (PDT)
Date:   Sat, 17 Jun 2023 20:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687048134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OOjkajun4dxe+Sm2jzscvKafBxL9d5FNJxJpEh6FjCI=;
        b=GvbijSvNk4Dk/sudsB4B17sXAIsSfpfdNrzwmqtWLv7KZkGJqFRfwGfrlApa49d4i/bloL
        GWiMp8At8w8iMtpC2o7WJEOOrfRAYv439nr55dWbZ3lWixrNAUwX9AjIGTbnELaIp0+THF
        0NniQrw18iG9wWqwavWTPaK1ZlFwLa8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     oberpar@linux.ibm.com
Subject: bcachefs code coverage analysis
Message-ID: <ZI5PwpmuGUdWg9Db@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just got automated gcov analysis going - integrated with the CI. Thanks
Peter for supplying a missing bit of make magic :)

I'll be writing a longer post about ktest/ktestci soon... been doing a
lot of bugfixing and scalability work, it's humming along nicely now.

For now I just wanted to show off the coverage results. ktest now has
gcov variants of our existing tests, we only run these on the most
recent commit of the master branch (vs. the most recent 50 commits for
the other tests), and commits that have gcov results now give you a nice
link to the lcov output, like so:

https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs&commit=26ed392c9add057a503077ad87492d1ab1475407&test=^gcov
https://evilpiepirate.org/~testdashboard/c/26ed392c9add057a503077ad87492d1ab1475407/lcov/fs/bcachefs/index.html

82% line coverage is not too shabby :)

Next up we need to get new-and-improved dynamic fault injection merged:
the code is written, I'm just waiting on memory allocation profiling to
be merged to post it (which has the necessary infrastructure). That will
make it dead easy to add fault injection points for code that isn't
being tested and hook them up to new tests.
