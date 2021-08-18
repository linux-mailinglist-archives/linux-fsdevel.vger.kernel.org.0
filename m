Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4223F05C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhHROIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbhHROIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:08:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22198C061764;
        Wed, 18 Aug 2021 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yEmhhB1jvlMk+IflLK9WtV0XYHIRBCbvIeJT+MHfw7Q=; b=kHUyFU9CA0Xl6U+YsBAlotnqUJ
        1yiunrwv7cuTCljhB7Ve416gZI2Yhc/e4tPtQ2XfRtrhFbE3AbBGiuotCFcz5W6nPAOjJP8Lo1lcg
        8gp+Z9zlPuxhrdTatJB+EAdXYDxqUKO+ORemikDZqnTO42gqXk8xovg0jDnhV35iJGagPJKw1S91j
        d84dOB7ZvekX156f0v+Tr2KhX24uOFbP0NErrYKfxktyuA5fRD9jCVuj1/Jqw+SADEnXv57Lcl55F
        BDtwpmzdAzYJ85ti4buBG6OYxiCiJuG/6VL/CmzFIiKt82kzEEP/EZcd4JLr4Dh2u+FUeEG38vJsx
        UUe8js9w==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMDU-003uDx-SF; Wed, 18 Aug 2021 14:07:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: unicode cleanups, and split the data table into a separate module
Date:   Wed, 18 Aug 2021 16:06:40 +0200
Message-Id: <20210818140651.17181-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series is an alternate idea to split the utf8 table into a separate
module.  It comes with a whole lot of cleanups preloaded.

Diffstat:
 fs/ext4/super.c               |   31 +---
 fs/f2fs/super.c               |   30 +---
 fs/f2fs/sysfs.c               |    3 
 fs/unicode/Kconfig            |   13 +-
 fs/unicode/Makefile           |   13 +-
 fs/unicode/mkutf8data.c       |   24 +++
 fs/unicode/utf8-core.c        |  105 ++++++----------
 fs/unicode/utf8-norm.c        |  262 +++++-------------------------------------
 fs/unicode/utf8-selftest.c    |   94 +++++++--------
 fs/unicode/utf8data.c_shipped |   22 ++-
 fs/unicode/utf8n.h            |   81 ++++--------
 include/linux/unicode.h       |   35 +++++
 12 files changed, 260 insertions(+), 453 deletions(-)
