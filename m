Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8B4BCE64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 13:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbiBTMN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 07:13:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbiBTMN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:13:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967842A14;
        Sun, 20 Feb 2022 04:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5WMwUY/lejbGy9budx04ZQZ9mYcj4RUjgOOK6LRIrfw=; b=DyHQ+Kv0tpLuE5sDcAwYJGhVUR
        qAt8z1eS7hx7Y8jIl/rg1raXyiw1G6RRwa1gCQk81UQm36X5bYhkRhqBPdlMGW7I6dWArPn9/7PDs
        PqBRMWIKpY27/5lHsG6hN3GjIm4+0w1sGoMtcCdb4Utx0P/D6+mokcArWE/B1I7itpylQlvF8heoP
        CQixsqj80JBYJAsMGEWDILoWC+a9xsAW/6n0yO8Ii5hG2KB5pPr2lHFgjkIqoLWxncHuIRxKTbs86
        Bt5UPKXYbfBwjG9aJq8RCbxeAMb7ut+29GIOLwCKuHrOozACXG/DkhQGupWcYJfR+FbPPT38Ydcwn
        HFIVJm1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLl5M-000pjI-GH; Sun, 20 Feb 2022 12:13:04 +0000
Date:   Sun, 20 Feb 2022 12:13:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Is it time to remove reiserfs?
Message-ID: <YhIwUEpymVzmytdp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keeping reiserfs in the tree has certain costs.  For example, I would
very much like to remove the 'flags' argument to ->write_begin.  We have
the infrastructure in place to handle AOP_FLAG_NOFS differently, but
AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.

Looking over the patches to reiserfs over the past couple of years, there
are fixes for a few syzbot reports and treewide changes.  There don't
seem to be any fixes for user-spotted bugs since 2019.  Does reiserfs
still have a large install base that is just very happy with an old
stable filesystem?  Or have all its users migrated to new and exciting
filesystems with active feature development?

We've removed support for senescent filesystems before (ext, xiafs), so
it's not unprecedented.  But while I have a clear idea of the benefits to
other developers of removing reiserfs, I don't have enough information to
weigh the costs to users.  Maybe they're happy with having 5.15 support
for their reiserfs filesystems and can migrate to another filesystem
before they upgrade their kernel after 5.15.

Another possibility beyond outright removal would be to trim the kernel
code down to read-only support for reiserfs.  Most of the quirks of
reiserfs have to do with write support, so this could be a useful way
forward.  Again, I don't have a clear picture of how people actually
use reiserfs, so I don't know whether it is useful or not.

NB: Please don't discuss the personalities involved.  This is purely a
"we have old code using old APIs" discussion.

