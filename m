Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80E3D4499
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 05:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhGXDE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 23:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhGXDEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:04:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B68C061575;
        Fri, 23 Jul 2021 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7YaStI1FvzN6rpEWJEqQUaqj9kjMuC7H7ej++bfp29c=; b=V6zP8t0jJDab9lRjdHTXjhreYy
        0U307BiOW2jYElVaxn0pXxDUWSaIvZ5uityE4Cb5Udmxyhkqc17z2fihvZjnvxv/vPv6pjUDdVkdp
        7SIAjGqyOsY8mPFMoMje3oiopvRCc/ZtQu1yfnGcdh+iLsqGtpcJ+H6eL9/FWN4OoL48wt23nfiME
        35COeGGnSwlCuEWz9L72hrbHFX0ykwc2eIpELXE855iwSweRAmQhZ/HmJmPPru5CFVEdaFy4iupP8
        NYRScPs7rx4VTezJkBjGpeYgVAeo4v5PbLIvay1rfXSxqlrzcZRbdOM0NxzT4KPoA5az03ZN/GfFv
        Yyz2gGsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m78ab-00ByXl-DT; Sat, 24 Jul 2021 03:44:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/2] iomap: make inline data support more flexible
Date:   Sat, 24 Jul 2021 04:44:33 +0100
Message-Id: <20210724034435.2854295-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first patch seems to be where Gao Xiang, Christoph and I have
settled for immediate support of EROFS tails.  The second is a prequel
to the folio work.  Because folios are variable size, if we have, eg,
an 8.1KiB file, we must support reading the first two pages of the folio
from blocks and then the last 100 bytes from the tailpack.  That means
effectively supporting block size < page size.  I thought it cleaner to
separate it out, and maybe that can go in this round.

The folio patches are rebased on top of all this; if you're hungry to
see them, they can be found at
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
as usual.  I haven't applied all the R-b yet (and I should probably
figure out which ones still apply since I did some substantial changes
to a couple of the patches).

Gao Xiang (1):
  iomap: Support file tail packing

Matthew Wilcox (Oracle) (1):
  iomap: Support inline data with block size < page size

 fs/iomap/buffered-io.c | 46 +++++++++++++++++++++++++-----------------
 fs/iomap/direct-io.c   | 10 +++++----
 include/linux/iomap.h  | 14 +++++++++++++
 3 files changed, 47 insertions(+), 23 deletions(-)

-- 
2.30.2

