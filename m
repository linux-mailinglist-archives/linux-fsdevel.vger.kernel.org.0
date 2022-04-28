Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C351512A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 05:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbiD1DuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiD1DuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:50:14 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644FD69732;
        Wed, 27 Apr 2022 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P/uz8ta+13HZWHILS7f4BQxL19IC6pJ1aULcVE/Ha/E=; b=ANud95FinHJMJ9hsSUOmhnyDOm
        VMjJH39MltWx3HAPVmaRpTwBehdzUWQNQqeyeegCDStJS47ixJ/BBmguAVZo4gyAa/KXt6ZrZAy9F
        RhKCgc2mtDBczdZQz8Dw6npDjpGS15XYfPZ8La354xQuTN8AInJiZSks213AqdUF5EUBdOzK2NKlN
        Yp7o4yfqpT8HcEFkHG5pJlCerNFvPtqnDebCYZWXBTBAFtgwTzKSMkTfanz5aKnbTWMHZ/nOINRY7
        uBKfPnrX3qe8hqm/bfmklfSLmSOjbIq3NlQBLITvBwRPIyCOAx1ZcbRxOsEdj13MxVXH7MWD1nN0w
        ztivyEvg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njv7L-00A7Fp-Ur; Thu, 28 Apr 2022 03:47:00 +0000
Date:   Thu, 28 Apr 2022 03:46:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <YmoOMz+3ul5uHclV@zeniv-ca.linux.org.uk>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
 <626A08DA.3060802@fujitsu.com>
 <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
 <YmoGHrNVtfXsl6vM@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmoGHrNVtfXsl6vM@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:12:30AM +0000, Al Viro wrote:

> > Note, BTW, that while XFS has inode_fsuid_set() on the non-inode_init_owner()
> > path, it doesn't have inode_fsgid_set() there.  Same goes for ext4, while
> > ext2 doesn't bother with either in such case...
> > 
> > Let's try to separate the issues here.  Jann, could you explain what makes
> > empty sgid files dangerous?
> 
> Found the original thread in old mailbox, and the method of avoiding the
> SGID removal on modification is usable.  Which answers the question above...

OK, what do we want for grpid mounts?  Aside of "don't forget inode_fsuid_set(),
please", that is.  We don't want inode_fsgid_set() there (whatever went for
the parent directory should be the right value for the child).  Same "strip
SGID from non-directory child, unless we are in the resulting group"?
