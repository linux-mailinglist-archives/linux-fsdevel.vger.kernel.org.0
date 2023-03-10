Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC06B521C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 21:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjCJUog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 15:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjCJUoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:44:34 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40111BB2E;
        Fri, 10 Mar 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tz+vuGIwfHd+fip08fefzwZeUYEctg8otTI+9qKtVOo=; b=OfPox7GKIkzUc4oPqsEOPEms4S
        ++uYfrL+7iM4H5jcH20OvQA0iEdFQMGprSb2uBWPYc75SJ6Jm/mNNTRzUlpixjbMFuqJt1DzVqUSB
        TMa0FbIS0DoQQxNuobZov9Xzy4Y277IfBczQkfdXStgCfME6bt02IZIlCukptIZBt+FWxOKbpObKB
        K27MnPu/kSR0dM5xrtAsnQWBqA6Hy2YYdbiEN85HQjaIxYPyOxRnldq+6TPr2oComzd+5pY0+ko7N
        rAewdSBu/57AAGKmRaCkUIXR1rODXYNf7T/lorukvJdimpYTqZludwFjzwE1DszUKBFwEjbF9I31/
        kuDDpPcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pajbL-00FQ86-0f;
        Fri, 10 Mar 2023 20:44:31 +0000
Date:   Fri, 10 Mar 2023 20:44:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] common helper for kmap_local_page() users in local
 filesystems
Message-ID: <20230310204431.GW3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	kmap_local_page() conversions in local filesystems keep running into
kunmap_local_page()+put_page() combinations; we can keep inventing names
for identical inline helpers, but it's getting rather inconvenient.  I've added
a trivial helper to linux/highmem.h instead.

	I would've held that back until the merge window, if not for the
mess it causes in tree topology - I've several branches merging from that
one, and it's only going to get worse if e.g. ext2 stuff gets picked by
Jan.

	The helper is trivial and it's early in the cycle.  It would simplify
the things if you could pull it - then I'd simply rebase the affected branches
to -rc2...

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-highmem

for you to fetch changes up to 849ad04cf562ac63b0371a825eed473d84de9c6d:

  new helper: put_and_unmap_page() (2023-03-07 01:50:53 -0500)

----------------------------------------------------------------
put_and_unmap_page() helper

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      new helper: put_and_unmap_page()

 include/linux/highmem.h | 6 ++++++
 1 file changed, 6 insertions(+)
