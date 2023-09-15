Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1267A1E70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjIOMUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjIOMUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:20:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB774270E;
        Fri, 15 Sep 2023 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zcm9ZNAum/1OuCWgAEkVFo/U1hKtH0j593KfRJ82drQ=; b=KwvJgFZDEOT76rMuRHZbISa1sV
        RZE1VGxea/J7HxIU2mbnRkiki3wprSXcNf3J92Y/LvYxcBq47TmwVdEw7iYaypEAht1fBIi8d+ef4
        qQxWh3TeW1Uu6w4RqTElSTO6jpM1pOR/YcwV0A6ZrsozQ/XGy3hZoS7GPeRkExwMxBbZqdWrLoWtW
        CxiN+19fzF5gxam3lWayx1PHzl5WJ1gFM949cfpU8gZZYlmma3umCLK9UFJknwDElEjrnV25R/Yth
        F89C6Js6Isw/FXrMpUwpOFjvgcLAArVa3e64MuUIFvAkK4WPrqhVxvwiMJRxu33P0+/vMigoeAUHR
        lbMYxD7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh7ng-009cY9-Hn; Fri, 15 Sep 2023 12:19:56 +0000
Date:   Fri, 15 Sep 2023 13:19:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 4/6] shmem: add order parameter support to
 shmem_alloc_folio
Message-ID: <ZQRL7K0rXIzD54aq@casper.infradead.org>
References: <20230915095042.1320180-1-da.gomez@samsung.com>
 <CGME20230915095129eucas1p1383d75c6d62056afbb20b78a3ec15234@eucas1p1.samsung.com>
 <20230915095042.1320180-5-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095042.1320180-5-da.gomez@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:51:28AM +0000, Daniel Gomez wrote:
> In preparation for high order folio support for the write path, add
> order parameter when allocating a folio. This is on the write path
> when huge support is not enabled or when it is but the huge page
> allocation fails, the fallback will take advantage of this too.

>  static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
> -		pgoff_t index, bool huge)
> +		pgoff_t index, bool huge, unsigned int *order)

I don't understand why you keep the 'huge' parameter when you could just
pass PMD_ORDER.  And I don't understand why you're passing a pointer to
the order instead of just passing the order.

