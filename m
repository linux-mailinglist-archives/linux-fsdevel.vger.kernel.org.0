Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C86220580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgGOGyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgGOGyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59281C061755;
        Tue, 14 Jul 2020 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=m5ZuSlWoPk8IHJ8rMAHWiVJpEk2rW/bZkOwkNvU9eg8=; b=gFvXBEXY2Jb2aUCtFOUB8jezQc
        lOOXaFWy7KMIyKz95DfU9gnD45yKzN8/TDWKSfo0ejmnl+fd1CvJmOhBfv+NMuTTcHzr+s28zA9nX
        OZQve/e5p5T8JuS13QtmS+5eIk/nOtSWndDdLOoZ9euwj3aFQSI9DRYvsTYqjqGQgfWzn4zVQonX6
        MKdbzPZHhJgksVm9diElD36/Zg6c5LXn4DENBL3x8csJk0+kWcEXgJvNFF1qiFd2WWju10qBW6g95
        M0721ycH6CAmNclB43ski06+D2gJLJ9QSyxp5vQAI6HMN3dP74vv9/VEt82bRRiYKQZ98Fi9VjV1P
        7VaHe7EQ==;
Received: from [2001:4bb8:105:4a81:1c8f:d581:a5f2:bdb7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbJL-0001jv-U8; Wed, 15 Jul 2020 06:54:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: clean up utimes and use path based utimes in initrams
Date:   Wed, 15 Jul 2020 08:54:30 +0200
Message-Id: <20200715065434.2550-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al and Linus,

here is the requested series to add a vfs_utimes and use that in
initramfs, plus assorted cleanups that makes this easier.

 fs/utimes.c        |  107 ++++++++++++++++++++++++++++-------------------------
 include/linux/fs.h |    1 
 init/initramfs.c   |   11 +++--
 3 files changed, 65 insertions(+), 54 deletions(-)
