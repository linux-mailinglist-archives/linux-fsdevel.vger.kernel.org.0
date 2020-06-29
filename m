Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0F20E369
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbgF2VNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgF2S5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9ECC030791
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=B5KtamRoDLMzqg8FBJ8UDiXbyCRvboqrbqBovPLTjTY=; b=nGZFIs2MwmfVuSlVZWU5oGjWFF
        +0LWnq6wxXdk9tTo2w3/dbt8GQTWSsiWt8dFi1MMQ26Eja7P5GypHy3XUwj5gHnT4e/Y01ueEqmyL
        toF+18EnIY5G2dp3iFLPg5LqImxea2hlilEW5ci2FW+1mEGatziWSN8dtba5j2pMt88URRTdK3Snx
        83mXDKQNLpHHB+o5FzvL/ESZa4/JHfHHF8jGxxdy/3jHfq9XdpysPuJIyzJnJudu1/isXkWeQBA6+
        QNtjFFV5n5GOTFVq4XL2PQPKu9+r+PXStMliHxKF7ZWrEd1vtyfhTpsdi06nvq3a7xNMQIzWSC7WM
        WpNmEiVA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvaF-0004Et-Q8; Mon, 29 Jun 2020 15:20:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 0/2] Use multi-index entries in the page cache
Date:   Mon, 29 Jun 2020 16:20:31 +0100
Message-Id: <20200629152033.16175-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following Hugh's advice at LSFMM 2019, I was trying to avoid doing this,
but it turns out to be hard to support range writeback with the pagecache
using multiple single entries.  Of course, this isn't a problem for
shmem because it doesn't have a real backing device (only swap), but
real filesystems need to start writeback at arbitrary file offsets and
have problems if we don't notice that the first (huge) page in the range
is dirty.

Hugh, I would love it if you could test this.  It didn't introduce any new
regressions to the xfstests, but shmem does exercise different paths and
of course I don't have a clean xfstests run yet, so there could easily
still be bugs.

I'd like this to be included in mmotm, but it is less urgent than the
previous patch series that I've sent.  As far as risk, I think it only
affects shmem/tmpfs.

Matthew Wilcox (Oracle) (2):
  XArray: Add xas_split
  mm: Use multi-index entries in the page cache

 Documentation/core-api/xarray.rst |  16 ++--
 include/linux/xarray.h            |   2 +
 lib/test_xarray.c                 |  41 ++++++++
 lib/xarray.c                      | 153 ++++++++++++++++++++++++++++--
 mm/filemap.c                      |  42 ++++----
 mm/huge_memory.c                  |  21 +++-
 mm/khugepaged.c                   |  12 ++-
 mm/shmem.c                        |  11 +--
 8 files changed, 245 insertions(+), 53 deletions(-)

-- 
2.27.0

