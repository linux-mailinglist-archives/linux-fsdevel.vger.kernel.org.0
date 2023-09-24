Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F67AC6F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjIXHLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXHLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:11:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599DFF
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R+a0RE8eTAFxhE2dopTl5FhkjWjpLrPy1U0ZCYgluyU=; b=r/ndLEpE6RkGGAf9Da8mmNdjke
        HJ2W0MrdECTdhVvi2ngt+RSTukvSkIkoMFbotTkdLdwn2K7/hY6gNZSIqXjIuNK3MvAhPq8b9WkhT
        jC8xIhXazwpiEhqudlQ8jfjUTjLqXA7IlwF6STRXqI1I3B59N3au3nqdJJydjv5/6uybhO6q7pF7S
        kI4wC8JtWBjLhLnCLNbSuALwmqiowWhFvFvKriw8gdZlFv9jig7bDZqwrjse2voLB/j9gQiHVmPBV
        TGqaCcduL+Z61hkSRjEd214TTnXlmzJqQ+nyb7o3JCnUeF+3ae0Z7NQKPcO7A5cTJdA1HdGop4hub
        n8u/Q1WA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkJH0-00BfKg-Vz; Sun, 24 Sep 2023 07:11:23 +0000
Date:   Sun, 24 Sep 2023 08:11:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     amir73il@gmail.com, chrubis@suse.cz, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com, viro@zeniv.linux.org.uk,
        oe-lkp@lists.linux.dev, ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] vfs: fix readahead(2) on block devices
Message-ID: <ZQ/hGr+o61X1mik9@casper.infradead.org>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924050846.2263-1-reubenhwk@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 12:08:46AM -0500, Reuben Hawkins wrote:
> Readahead was factored to call generic_fadvise.  That refactor added an S_ISREG
> restriction which broke readahead on block devices.
> 
> This change swaps out the existing restrictions with an FMODE_LSEEK check to
> fix block device readahead.
> 
> The readahead01.c and readahead02.c tests pass in ltp/testcases/...

I realise we could add new test cases _basically_ forever, but I'd like
to see a little more coverage in test_invalid_fd().  It currently tests
both pipes and sockets, but we have so many more fd types.  Maybe there
are good abstractions inside LTP already for creating these?  I'd
like to see tests that the following also return -EINVAL:

 - an io_uring fd
 - /dev/zero
 - /proc/self/maps (or something else in /proc we can get unprivileged
   access to)
 - a directory (debatable!  maybe we should allow prefetching a
   directory!)

This ad-hoc approach to testing syscalls is probably not the best idea.
Have the LTP considered a more thorough approach where we have a central
iterator that returns a file descriptor of various types (the ones listed
above, plus block devices, and regular files), and individual syscall
testcases can express whether this syscall should pass/fail for each type
of fd?  That would give us one central place to add new fd types, and we
wouldn't be relying on syzbot to try fds at random until something fails.

Or something.  I'm not an expert on the LTP or testing in general; it
just feels like we could do better here.
