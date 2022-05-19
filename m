Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCC52CA00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 05:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiESDHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 23:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiESDHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 23:07:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D08FD410B;
        Wed, 18 May 2022 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ucU2ycwR/3vbing5KlGnmp6Xzs7PQTT5XGfqvZ+d7l4=; b=1Sh30bhcNyvFY5B5eD1Ueq4AHQ
        IzEfAlCFMNRbh0FijzOilVJEwAhL8JUxcnYiO3MxsM8PhEt0KXNWGObbiaSW6DQ7I5Fb0+ddDDHsD
        3z3wx5TJWw79GtBq7nX72xPPWe2zjkXEAsG7gkgIy7w1ajqlnRDwAUlcZD+fM0VzUeyZJ7Sj1eRom
        KtD7haft5MShpQhmEGSDIgwUf4bQYySXhneRj67Sv+AAcLBppX0fjHXEFBnxAa6JTNcL9xO599FBC
        6p02EVZXfjaacXcDECWV3rRYhV2+dU9JoU9SCjlCiq94EzwSBYMuRwPwu7IAAG8iPxUgwU/T+Sq54
        2O6ZZ26g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrWVQ-004lFn-Bo; Thu, 19 May 2022 03:07:16 +0000
Date:   Wed, 18 May 2022 20:07:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     amir73il@gmail.com, pankydev8@gmail.com, tytso@mit.edu,
        josef@toxicpanda.com, jmeneghi@redhat.com, Jan Kara <jack@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>
Subject: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been promoting the idea that running fstests once is nice,
but things get interesting if you try to run fstests multiple
times until a failure is found. It turns out at least kdevops has
found tests which fail with a failure rate of typically 1/2 to
1/30 average failure rate. That is 1/2 means a failure can happen
50% of the time, whereas 1/30 means it takes 30 runs to find the
failure.

I have tried my best to annotate failure rates when I know what
they might be on the test expunge list, as an example:

workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d

The term "failure rate 1/15" is 16 characters long, so I'd like
to propose to standardize a way to represent this. How about

generic/530 # F:1/15

Then we could extend the definition. F being current estimate, and this
can be just how long it took to find the first failure. A more valuable
figure would be failure rate avarage, so running the test multiple
times, say 10, to see what the failure rate is and then averaging the
failure out. So this could be a more accurate representation. For this
how about:

generic/530 # FA:1/15

This would mean on average there failure rate has been found to be about
1/15, and this was determined based on 10 runs.

We should also go extend check for fstests/blktests to run a test
until a failure is found and report back the number of successes.

Thoughts?

Note: yes failure rates lower than 1/100 do exist but they are rare
creatures. I love them though as my experience shows so far that they
uncover hidden bones in the closet, and they they make take months and
a lot of eyeballs to resolve.

  Luis
