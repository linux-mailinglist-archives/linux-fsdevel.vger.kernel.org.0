Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093372610DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgIHLiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 07:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgIHL17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:27:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5708C061573
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7WZu8yEPToxwOxOhhBePKSmAHVZZ0k0hi3wlwa3S1c8=; b=TUnKGV3AHfrtbyC2uFQIrltWeY
        W5sw26FTblwDAB0xh/RXDkA0G7fQcuC2kFM/qiEKDdX5/arBNFFtiWhb194x1MgwJsj0gtoipXZhk
        X76nfSTZ+u6CYn/lJUwobmlEkqShS90Uu542t5wsScgKgvE9EPgLgEFlpCj8r+QVRkyROwSJ4O6VP
        j9fULbzUctK7pMPy/nIyi/vu5jtw2WrHTSWRVecE5Wgflca1asRRNnL62wtdIWCjjVqJX13uJYYO/
        vH5RfWLa3Xwq5cgFnsMER51iYz6tIBUNyUjrbs2KDO80iiMNmvt3P4KTDVoIvjLD7y+706+rnvrXX
        MIsV++Yg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFbmz-0000Yg-VF; Tue, 08 Sep 2020 11:27:54 +0000
Date:   Tue, 8 Sep 2020 12:27:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pradeep P V K <pragalla@qti.qualcomm.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
Message-ID: <20200908112753.GD27537@casper.infradead.org>
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:47:06PM +0530, Pradeep P V K wrote:
> Changes since V3:
> - Fix smatch warnings.
> 
> Changes since V2:
> - Moved the spin lock from fuse_copy_pages() to fuse_ref_page().
> 
> Changes since V1:
> - Modified the logic as per kernel v5.9-rc1.
> - Added Reported by tag.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Umm, the way this is written, it looks like Dan reported the original
bug rather than a bug in v3.  The usual way is to credit Dan in the
'Changes since' rather than putting in a 'Reported-by'.

>  static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
> -			 unsigned offset, unsigned count)
> +			 unsigned offset, unsigned count, struct fuse_conn *fc)

I'm no expert on fuse, but it looks to me like you should put a pointer
to the fuse_conn in struct fuse_copy_state rather than passing it down
through all these callers.

