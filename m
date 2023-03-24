Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164556C777A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCXFpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCXFpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:45:04 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B47412CD1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 22:45:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 610C01003CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 16:39:14 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cg8DMMRRbKRP for <linux-fsdevel@vger.kernel.org>;
        Fri, 24 Mar 2023 16:39:14 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 452D71003D5; Fri, 24 Mar 2023 16:39:14 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 559FA100058;
        Fri, 24 Mar 2023 16:39:10 +1100 (AEDT)
Subject: [RFC PATCH] Legacy mount option "sloppy" support
From:   Ian Kent <raven@themaw.net>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>, Karel Zak <kzak@redhat.com>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>
Date:   Fri, 24 Mar 2023 13:39:09 +0800
Message-ID: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's been some recent discussion about support of the "sloppy"
mount option.

It's an option that people want to get rid of from time to time and
when we do we get complaints and end up having to re-instate it.

I think the (fairly) recent mount API changes are the best way to
eliminate the need for this option over time.

That's because this option doesn't quite make sense for fsconfig() and
the knowledge of how to handle invalid options for some file systems
needs be included in the user space logic when using the mount API.
At the very least there's no way to order the options since that's
determined by the order of fsconfig() calls.

Karel Zak is in the process of adding support for the mount API to
util-linux.

Karel do you find what I'm saying is accurate?
Do you think we will be able to get rid of the sloppy option over
time with the move to use the mount API?

Assuming I am correct, we need only implement handling of the sloppy
option in the monolithic option parser which is what the attached
patch does.

If it's decided we really do need to retain this option for fsconfig()
then we could remove LEGACY from the fs_flags bit field name and add
the handling to the parameter parsing code. In this case user space
code calling fsconfig() would still need to be mindful of option order.

At this stage I've not removed the sloppy option definition from
the file systems that allow it but with the file system type flag
that should be possible too, since this is more about handling the
parse return than an actual file system option.

I'm keen to hear what people think about how we should handle this
so any comments are welcome.
---

Ian Kent (1):
      vfs: handle sloppy option in fs context monolithic parser


 fs/cifs/fs_context.c |  2 +-
 fs/fs_context.c      | 31 ++++++++++++++++++++++++++++++-
 fs/nfs/fs_context.c  |  2 +-
 include/linux/fs.h   |  1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

--
Ian

