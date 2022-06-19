Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C5550C0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiFSQUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiFSQUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:20:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836559FEC
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GN+vC8Toz1SOOOzidLEHmGs77EZL5qSlfIhSbbTGiag=; b=fGYg23wcEeSkqCtD97UH4pUX4w
        gzdae3u1Nhy0aXZ6LWixLu9a9YIXtJ8t7ord/gI1g20Qj2MNirobohFCN+3YfMqiRB/I40d5oXyCm
        UY2DPsRh7Zhkj12WBwSIjEwSMIGrM8IQhXls5sqqGyo7xyxvkgyczKShxnKOASqlg2egIQ/JyW3dd
        iP/pDqsarbomav/7O0invC8O++MBSPodvYJQCfJeFEmd/kXpnfVdqElAMqrqHOn4HAtbx8XVjiHPi
        fcT8StaGAUZKsXgkRvV3WvPJYUOhv89PXjy5pKK0O8R/EXbTNcOu/tT+KK7lbB1wonPrYoCQTk9/D
        zrQXkilQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2xeZ-0026f4-SY;
        Sun, 19 Jun 2022 16:20:00 +0000
Date:   Sun, 19 Jun 2022 17:19:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.iov_iter_get_pages 24/33] lib/iov_iter.c:1295
 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.
Message-ID: <Yq9Mrw8tTKrKgqPd@ZenIV>
References: <202206192306.POJg04ej-lkp@intel.com>
 <Yq9FZnyna9BiwzDK@ZenIV>
 <Yq9G0ROCWfCg+Don@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq9G0ROCWfCg+Don@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 19, 2022 at 04:54:57PM +0100, Matthew Wilcox wrote:
> On Sun, Jun 19, 2022 at 04:48:54PM +0100, Al Viro wrote:
> > On Sun, Jun 19, 2022 at 11:40:37PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
> > > head:   fe8e2809c7db0ec65403b31b50906f3f481a9b10
> > > commit: e64d637d648390e4ac0643747ae174c3be15f243 [24/33] iov_iter: saner helper for page array allocation
> > > config: mips-randconfig-m031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206192306.POJg04ej-lkp@intel.com/config)
> > > compiler: mips-linux-gcc (GCC) 11.3.0
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > smatch warnings:
> > > lib/iov_iter.c:1295 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.
> > 
> > Joy...  Should've been int all along, obviously (pgoff_t for number of array
> > elements?)
> 
> I've been using 'long' for that just because I don't want the drama of
> "we need to support 16GB pages" to have anything to do with me.

That's "kvmalloc a flat array with that many pointers to pages in it and
and pin those suckers"...
