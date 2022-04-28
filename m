Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4CA513033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiD1JuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348282AbiD1Jhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4C95486;
        Thu, 28 Apr 2022 02:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E537260E06;
        Thu, 28 Apr 2022 09:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E0BC385A0;
        Thu, 28 Apr 2022 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651138480;
        bh=luhrz9r9PkXIPr7EQBPjoqFpOJw5lvxqAOITtpyxxwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzVWy6q9t87OUC3QzNKP10BsjhcXkz7XhDNJ3ULl8dzsqv8/vgQKekhOY/en2oqTn
         vqS+C9/W7RjkzewBSbggCyE6DPIKpA0gRtz3r5hNEsSv1GshR79aFbXdfUdgIpkwSt
         +WxuseiWlHPAPzJxJ5LZQSIE9fpUSm42s7Xx/firTIfkghKcpK6LRTf1ZVCFREtpRV
         R32OLR9Tq3UyHZ6N7seWXo06iw6I4Vy6JnTBCfqtvVHt+QCd4VZ3MFj+WQmzKUlQj8
         VqVuX0QGPdrl4ZxJPoDmnaK0hARHbGrQSKkvuh3OmBUmyd53EMjQ2MorttWFSN5gUq
         JV+HnE3z92sOQ==
Date:   Thu, 28 Apr 2022 11:34:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <20220428093434.yc7hjjplvicugfqs@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
 <626A08DA.3060802@fujitsu.com>
 <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
 <YmoGHrNVtfXsl6vM@zeniv-ca.linux.org.uk>
 <YmoOMz+3ul5uHclV@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmoOMz+3ul5uHclV@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:46:59AM +0000, Al Viro wrote:
> On Thu, Apr 28, 2022 at 03:12:30AM +0000, Al Viro wrote:
> 
> > > Note, BTW, that while XFS has inode_fsuid_set() on the non-inode_init_owner()
> > > path, it doesn't have inode_fsgid_set() there.  Same goes for ext4, while
> > > ext2 doesn't bother with either in such case...
> > > 
> > > Let's try to separate the issues here.  Jann, could you explain what makes
> > > empty sgid files dangerous?
> > 
> > Found the original thread in old mailbox, and the method of avoiding the
> > SGID removal on modification is usable.  Which answers the question above...
> 
> OK, what do we want for grpid mounts?  Aside of "don't forget inode_fsuid_set(),
> please", that is.  We don't want inode_fsgid_set() there (whatever went for
> the parent directory should be the right value for the child).  Same "strip

Exactly. You sounded puzzled why we don't call that in an earlier mail.

> SGID from non-directory child, unless we are in the resulting group"?

Honestly, I think we should try and see if we can't use the same setgid
inheritance enforcement of the new mode_strip_sgid() helper for the
grpid mount option as well. Iow, just don't give the grpid mount option
a separate setgid treatment and try it with the current approach.

It'll allow us to move things into vfs proper which I think is a robust
solution with clear semantics. It also gives us a uniform ordering wrt
to umask stripping and POSIX ACLs.

Yes, as we've pointed out in the thread this carries a non-zero
regression risk. But so does the whole patch series. But this might end
up being a big win security wise and makes maintenance way easier going
forward.

The current setgid situation is thoroughly messy though and we keep
plugging holes. Even writing tests for the current situation is an
almost herculean task let alone reviewing it.
