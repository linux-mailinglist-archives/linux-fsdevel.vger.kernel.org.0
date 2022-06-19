Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD43550BFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiFSPzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSPzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:55:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A1632E
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tFK8BkPX1y0OaWfu/nXjgwGxca4PbjUF+bgEaA6sgf8=; b=fvd04MXQMnrtgrRxhxAeOl4l7H
        5nDaOtlUGtBSw5CZc/CbKej1stOp6Acb+LGgUAweJXNf9c8Yu6KFkWuyVfk8zol9DyahA+Mx9Sg5z
        FFjm19szOoZ+36XxrbK2zRbOETRJfDLgAd82Bnw3Xydo/K/wapSTCDK+8Zq6vN/qIrEpZ3Lm/aGfh
        VdQSruRd8O2YrqaQ3woXNBzjNy3NdTVnxW6JprWEklcEGP/s5dZffoQxvbWjchhPrN9KKVlbZSLZ9
        +eeSlzFUmZghZlGQL0VGUQs1E9YfR0GtCDcK1ujyBSL3fLHYdlSL9b4WJvhcQWS9U5gSacn27i9tg
        8eSFSndw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2xGL-004SRN-Uj; Sun, 19 Jun 2022 15:54:57 +0000
Date:   Sun, 19 Jun 2022 16:54:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.iov_iter_get_pages 24/33] lib/iov_iter.c:1295
 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.
Message-ID: <Yq9G0ROCWfCg+Don@casper.infradead.org>
References: <202206192306.POJg04ej-lkp@intel.com>
 <Yq9FZnyna9BiwzDK@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq9FZnyna9BiwzDK@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 19, 2022 at 04:48:54PM +0100, Al Viro wrote:
> On Sun, Jun 19, 2022 at 11:40:37PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
> > head:   fe8e2809c7db0ec65403b31b50906f3f481a9b10
> > commit: e64d637d648390e4ac0643747ae174c3be15f243 [24/33] iov_iter: saner helper for page array allocation
> > config: mips-randconfig-m031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206192306.POJg04ej-lkp@intel.com/config)
> > compiler: mips-linux-gcc (GCC) 11.3.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > smatch warnings:
> > lib/iov_iter.c:1295 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.
> 
> Joy...  Should've been int all along, obviously (pgoff_t for number of array
> elements?)

I've been using 'long' for that just because I don't want the drama of
"we need to support 16GB pages" to have anything to do with me.
