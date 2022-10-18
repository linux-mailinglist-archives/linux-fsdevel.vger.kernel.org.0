Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5C602EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJROs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJROsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:48:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8455D8EEE
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xIxk1ZJXHiq+L/K5Scay6tItIt3SSciUv3926kxIpBo=; b=ixIhGjGVgflEaaE8r7777QDZ5A
        VrDUvR/pWbIv8fFDXyIWUT3KWF343f/h3b+nv4ujJnJw+6vNd1rsvxPae3Tzu6CDRiBUs32KMiKwB
        bHtkvxDpKSCWH5XgUzpOUL7BGHfL4wQFwombXV9F+ha9zWyF27L6tfne035VgNB5W4DS15XZ1hQlC
        4MvQ4NLDzYMsPQ8v2rgZobHss9UQEzo9nX/YDPo0qB/QMmjpXinlqG6ygeU6TGSjKplPX/R/6fH2S
        5xcZVkNSTebZpgqEVam1oRPWiGySAlc0kAmZzrjgey4bFnSZmz50pFQQvT0APFh5rbVTELWQoJenA
        lErID+YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okntb-007NJM-GF; Tue, 18 Oct 2022 14:48:43 +0000
Date:   Tue, 18 Oct 2022 07:48:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, jlayton@redhat.com,
        smfrench@gmail.com, hch@infradead.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add extraction functions
Message-ID: <Y068y8iHwL8Q9Qdk@infradead.org>
References: <Yy5pzHiQ4GRCOoXV@ZenIV>
 <3750754.1662765490@warthog.procyon.org.uk>
 <281330.1666103382@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281330.1666103382@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:29:42PM +0100, David Howells wrote:
> Note that iov_iter_get_pages2() doesn't handle KVEC-class iterators, which
> this code does - for kmalloc'd, vmalloc'd and vmap'd memory and for global and
> stack variables.  What I've written gets the physical addresses but
> doesn't/can't pin it (which probably means I can't just move my code into
> iov_iter_get_pages2()).

Please look at the long discussion on Ira's patches for
iov_iter_pin_pages where we went through this over and over again.
We need to handle all of these in the common helper.

> Further, my code also treats multipage folios as single units which
> iov_iter_get_pages2() also doesn't - at least from XARRAY-class iterators.
> 
> The UBUF-/IOVEC-extraction code doesn't handle multipage folios because
> get_user_pages_fast() doesn't - though perhaps it will need to at some point.

Yes, we need to be smarter about folios.  But that is nothing magic
about network file systems.  I have old patches that added a (barely
working) variant of get_user_pages_fast that exported bio_vecs and I
think willy planned to look into a folio based version of get/pin
user pages.  But one thing at a time.  I think the work from Ira to
switch to proper pinning and sort out the weirdnesses for non-users
buffer types is the first priority.  After that proper folio or large
contiguous range support is another item.  But none of that is helped
by parallel infrastructure.
