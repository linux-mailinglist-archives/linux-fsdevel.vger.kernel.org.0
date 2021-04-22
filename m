Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230A236842D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhDVPsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhDVPsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:48:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D19C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UdV/xsRrw93wPeJQm6RKQW5H8PJQYFUytR36G8I3Ovs=; b=GInvtbQpV+q1DfmdVS3oUS6+UZ
        oJOQpNnMhVadvMnLboc/BgbyGoaS2y/02q4Dvr5qx00RrWraMLUi6FpXwt/Qdeon62s0vQIQDJOaF
        j1fHHu/tF67JR3OMAf0DukLYxweRgxgMIHTjK3xuPYX5oy/Knhm5wQaG8Mplvv6MjpnEwQZFRxjrg
        ffTLs1D2KBaCfaWOTp0rv5HjkS3k+Jo7LxPAneC6YHV7+OjjNQ/aRxi7XbDLSsc0GWStnE1m78AXN
        Lh8jH79P0t+0OQCsRvHUf0n2RhSrHFvtbjBosTi7TuuejFtDisiTxJMBlpTjhoufpLKH20HcozL2M
        uVuyaThw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZbXl-000Tl5-4W; Thu, 22 Apr 2021 15:47:29 +0000
Date:   Thu, 22 Apr 2021 16:47:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net
Subject: [RFC] Reclaiming PG_private
Message-ID: <20210422154705.GO3596236@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We're perenially short of page flags, and I don't really see the need
for PG_private to exist.  We have 32/64 bits available in page->private,
and we don't seem to need the extra bit.

Most users store a pointer in page->private, and so PagePrivate() being
implemented as page->private != 0 is appropriate.

Some users simply SetPagePrivate() and don't touch page->private.
Those users could instead set page->private to 1.

Do we have any users which want to SetPagePrivate() and want to put a
meaningful zero value in page->private?

AFS stores a pair of integers in page->private, but the second integer
must be greater than the first one, so they can't both be zero.  btrfs
stores a real or fake pointer.  buffer_head filesystems generally store
a buffer_head pointer.  fscrypt stores a pointer.  erofs stores a real or
fake pointer.  f2fs does set PagePrivate and also set the pointer to NULL,
but it's not clear whether that's intentional.  iomap stores a pointer.
jfs stores a pointer.  nfs stores a pointer.  ntfs stores a pointer.
orangefs stores a pointer.

So ... what's going on with f2fs?  Does it need to distinguish between
a page which has f2fs_set_page_private(page, 0) called on it, and a page
which has had f2fs_clear_page_private() called on it?
