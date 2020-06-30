Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93520FA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbgF3RJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbgF3RJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:09:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC327C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=leSTDW7f9bC0IBZuDJDhYDrb/Bwt22T3vmgs89G8kWU=; b=n47CiORvKJxT1xEVBb9TCpG5ic
        NdzLTX2tOK1wnfDaqGRrP/wtpCGnIqIvmQEUozICzBdOdAzZApaJuUGJEd2155j8WuKl9yBuTz4Bc
        xDYhHWb8FyAsl1X4ROILkUCiGJM873FzZvjsc21NJpjfufgF8pSbgKNWvmes4rdSuSv+ayWUDtRS7
        UtLU91WC2xYoBYQM24Az8TQzscWc4wEbFxuQzX/IJp8eKoO2ivWem/sb/2O5tELa2nvsLp8rqhXaD
        asU5qVPovgWNvncxGZyeo54RwrZhbLhNQ44PhF3X/FBh32MJsSCsA3XcdVO5Os02soKX8xtaxBF0c
        ioIa3IOw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqJl9-0003Kx-Dq; Tue, 30 Jun 2020 17:09:28 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] f2fs: always expose label 'next_page'
Message-ID: <020937f3-2947-ca41-c18a-026782216711@infradead.org>
Date:   Tue, 30 Jun 2020 10:09:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when F2FS_FS_COMPRESSION is not set/enabled.
This label is needed in either case.

../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
     goto next_page;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/data.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20200630.orig/fs/f2fs/data.c
+++ linux-next-20200630/fs/f2fs/data.c
@@ -2366,9 +2366,7 @@ set_error_page:
 			zero_user_segment(page, 0, PAGE_SIZE);
 			unlock_page(page);
 		}
-#ifdef CONFIG_F2FS_FS_COMPRESSION
 next_page:
-#endif
 		if (rac)
 			put_page(page);
 

