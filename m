Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C908790F2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 01:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349557AbjICXNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 19:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 19:13:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F0A4;
        Sun,  3 Sep 2023 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5kFxnNNm8+gjbZJh6ydJs8AQ0+l1yYrVwQkOkmwR0aE=; b=JQiYogy2D3O0pnE88F2CdkBOu3
        5B3DgWzn19KZmt4NLY/XQ87ydrJRSgtySIJhIhKpOZIdSx/tyLkew7zVUHacLs4ucj3LUlBOPWqv/
        +AIZ/XSrE50uO9WMqdH51Su0GtMx3Ym3fOG11koQPBN2jnV3Pdx5J3aAAA5FsK+EuQgr/VxlNGsZj
        73+O1vCII2J2ys3du6l0Wal8cdAm/cqHsCRs8Baxhw84GcxwGZItvdfMWQMxEWWxbvbmVYSxyYYCQ
        p1gYn56xAKCKNYYnI6qjn5uk0rZ9RvBJmyIFWiBSAuarsr9nv2W1nOS/hlco6crRYSGdZq9Pi2276
        VXZSnfZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qcwHi-003Ag2-2Y;
        Sun, 03 Sep 2023 23:13:38 +0000
Date:   Mon, 4 Sep 2023 00:13:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230903231338.GN3390869@ZenIV>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPUIQzsCSNlnBFHB@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:27:15AM +1000, Dave Chinner wrote:

> It already is (sysrq-t), but I'm not sure that will help - if it is
> a leaked unlock then nothing will show up at all.

Unlikely; grep and you'll see - very few callers, and for all of them
there's an fdput_pos() downstream of any fdget_pos() that had picked
non-NULL file reference.

In theory, it's not impossible that something had stripped FDPUT_POS_UNLOCK
from the flags, but that's basically "something might've corrupted the
local variables" scenario.  There are 12 functions total where we might
be calling fdget_pos() and all of them are pretty small (1 in alpha
osf_sys.c, 6 in read_write.c and 5 in readdir.c); none of those takes
an address of struct fd, none of them has assignments to it after fdget_pos()
and the only accesses to its members are those to fd.file - all fetches.
Control flow is also easy to check - they are all short.

IMO it's much more likely that we'll find something like

thread A:
	grabs some fs lock
	gets stuck on something
thread B: write()
	finds file
	grabs ->f_pos_lock
	calls into filesystem
	blocks on fs lock held by A
thread C: read()/write()/lseek() on the same file
	blocks on ->f_pos_lock
