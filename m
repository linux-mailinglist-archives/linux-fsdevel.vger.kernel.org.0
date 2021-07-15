Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A093C9D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbhGOLTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbhGOLTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:19:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91832C06175F;
        Thu, 15 Jul 2021 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jHHWPYXI8/YaTeNgH04Z3Eb0UrI7Jdot4WJDAmytkTs=; b=pb4vsdRNxJnvLKou11FGvbxXeN
        Y791P5KQeZzLgfkDApxMhnktEXTA1gf/umPWs0kRDwS/lq+rLpUg0ASEH7UI+/hJNpaaCS22tJqcJ
        mWhXfX7bDiXhBykW3cx6pOqxg1tDlkoiUvXwYqYDGHOfhIdklGcKyiuuiBkFAVD98sP8EuJSh/Sn2
        gxmnfabphkpO/5YVgJg3C4NzL7C7km6lAynR1KUcV+f8MWq3NtI+mGoVzFD+sy6FBwSzZR408Wy15
        GVtQ1ringKFzfE/1a7T1MsNMZIoP+vupUl03b377JV891BMdTKL5YmMY2PktOIHkjs4h6Jq9lOkYY
        CIK12kJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3zLC-003HTE-8l; Thu, 15 Jul 2021 11:15:54 +0000
Date:   Thu, 15 Jul 2021 12:15:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 031/138] fs/netfs: Add folio fscache functions
Message-ID: <YPAY3kgLAWa6ni2N@casper.infradead.org>
References: <20210715033704.692967-32-willy@infradead.org>
 <202107151736.FcPr80d7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107151736.FcPr80d7-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 05:51:26PM +0800, kernel test robot wrote:
>    include/linux/netfs.h: In function 'folio_start_fscache':
> >> include/linux/netfs.h:43:2: error: implicit declaration of function 'folio_set_private_2_flag'; did you mean 'folio_set_private_2'? [-Werror=implicit-function-declaration]
>       43 |  folio_set_private_2_flag(folio);
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~
>          |  folio_set_private_2
>    cc1: some warnings being treated as errors

I'll be folding in this patch:

+++ b/include/linux/netfs.h
@@ -40,7 +40,7 @@ static inline void folio_start_fscache(struct folio *folio)
 {
        VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
        folio_get(folio);
-       folio_set_private_2_flag(folio);
+       folio_set_private_2(folio);
 }

 /**



