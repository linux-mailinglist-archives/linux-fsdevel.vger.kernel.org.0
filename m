Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C054F5287AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbiEPO4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244413AbiEPO4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 10:56:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C26657D;
        Mon, 16 May 2022 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MJNSji9MbA4mU8wcmtcJ3o3ldzb0L/uy4sdoyIz/WOk=; b=EzfL8y7RvExg8FUlQ5DoHoLmVS
        H+/87HLsdNVm9p5hf46qx5WZIRbVEZJMKMq0H28ppE2ZieBhnsmBeg71oDy+NpVdYlHtSctlPgVwb
        ZyfSsLo7nWhOGcHz1cOrauZ7O7+mZvkhMhhEJd12rHBi8yVNvn777/sAp5vJ8hP1ju4xtU6zcTNoF
        5N2pklqugJcDVGdoe66rlQmdXxRGVEpral4E8v1UWcxeRpQCppBBUC6/ywlt7DLllhdc2txMSrdPZ
        wRxogm7UzjWkVHmJKbTbeUTbvurCmIuRCa0AfAHltIlVV07z01nycZiBZmYI9rd9MNdNoeijixgi/
        RbmeZi3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqc8Y-009yKl-SS; Mon, 16 May 2022 14:55:54 +0000
Date:   Mon, 16 May 2022 15:55:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <YoJl+lh0QELbv/TL@casper.infradead.org>
References: <20220516101925.15272-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516101925.15272-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 12:19:25PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> The usage of kmap_local_page() in fs/ufs is pre-thread, therefore replace
> kmap() / kunmap() calls with kmap_local_page() / kunmap_local().
> 
> kunmap_local() requires the mapping address, so return that address from
> ufs_get_page() to be used in ufs_put_page().
> 
> These changes are essentially ported from fs/ext2 and are largely based on
> commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Have you done more than compile-tested this?  I'd like to know that it's
been tested on a machine with HIGHMEM enabled (in a VM, presumably).
UFS doesn't get a lot of testing, and it'd be annoying to put out a
patch that breaks the kmap_local() rules.
