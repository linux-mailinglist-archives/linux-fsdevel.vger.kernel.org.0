Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8558DABD21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394991AbfIFP7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:59:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfIFP7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=22s3suVEwybuDGOmnl63bE4bs9K3fxHohFliCUIcsdI=; b=bo2NORtcqX+pna5uqNLOVaY3lP
        GcjxJLygzVcRUR9QCu2ryEqYBNUsSitjTcyCcA73nnV6tftFfy573yMV/iR0JmPi1m9YtArvHdF50
        1NnKeUwaQCOqb/Bk9eGmrlHkHcWIKJpwi7GmjHBZytCSrxdxWSKbMxjAJvnhgwNjHMAzKrmWTB22K
        5sOCIH2N5bXeUNHWif3K4FEerULx2MpVhdIhMT0MPeGAD8X4C7H5hBFFCoumISrpMw8JpqNypN7gs
        SKVKbigK6tOH3wRKQ+zIGt2NsYILncqRydAEp1DJAIijZLRKVO3JaXcCBfqMA02pCd29ccfSBi3Sb
        yU4ueQpg==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6Gda-0004lW-9k; Fri, 06 Sep 2019 15:59:02 +0000
Date:   Fri, 6 Sep 2019 17:56:50 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs fixes for 5.3
Message-ID: <20190906155650.GA32004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

please pull these late configfs fixe from Al that fix pretty nasty
removal vs attribute access races.

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.3

for you to fetch changes up to b0841eefd9693827afb9888235e26ddd098f9cef:

  configfs: provide exclusion between IO and removals (2019-09-04 22:33:51 +0200)

----------------------------------------------------------------
configfs fixes for 5.3

 - fix removal vs attribute read/write races (Al Viro)

----------------------------------------------------------------
Al Viro (4):
      configfs: stash the data we need into configfs_buffer at open time
      configfs_register_group() shouldn't be (and isn't) called in rmdirable parts
      configfs: new object reprsenting tree fragments
      configfs: provide exclusion between IO and removals

 fs/configfs/configfs_internal.h |  15 ++-
 fs/configfs/dir.c               | 137 +++++++++++++++-----
 fs/configfs/file.c              | 280 ++++++++++++++++++++--------------------
 3 files changed, 257 insertions(+), 175 deletions(-)
