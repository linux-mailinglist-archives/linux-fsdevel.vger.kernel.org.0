Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F456E2C3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDNWCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNWCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:02:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B505B93
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d4LLdtCbAfw9YQ6by9LlMzTldJncfrxe84dy4muBFqo=; b=mTTlpcydzh26dzVHsdq2U0EztW
        WVOIgKciOK3Vqv29SfpJQmpCnV+hHq7f3InhTfcl+dWtRThgULry0Btg4f0UB7tkTsY50bsu6TYZ1
        bzLdABCVsstCGSr81XdsvQBBHxm5Kf/1x11Gc1Fjz7hYNcDCHPxvoYvElh9Ylfv+PzEfoECMeQIEt
        rYjiSG6HRXXjzxdfETxbinQPby1lpIDED4+f9Vra/Qh/ITzEYeEBuIfifglX2nzbmwPGhrDUfqEhy
        gRNy4SIrtZnyv2ESjA7Bi8RSBMC6LMk8/R6E692tF09bH7yD/faBnD9ldJVM2Im/mxMo1baPY+Ivf
        T8rk4cFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnRV2-0097aB-37; Fri, 14 Apr 2023 22:02:32 +0000
Date:   Fri, 14 Apr 2023 23:02:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: sequential 1MB mmap read ends in 1 page sync read-ahead
Message-ID: <ZDnNeKt1bPWb2PzC@casper.infradead.org>
References: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
 <df5c4698-46e1-cbfe-b1f6-cc054b12f6fe@fastmail.fm>
 <ZDjRayNGU1zYn1pw@casper.infradead.org>
 <1e88b8ed-5f17-c42e-9646-6a97efd9f99c@fastmail.fm>
 <b8afbfba-a58d-807d-1bbc-3be4b5b08710@fastmail.fm>
 <c59e54f9-6eae-3c35-bce8-ac03af84b3ed@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59e54f9-6eae-3c35-bce8-ac03af84b3ed@fastmail.fm>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 10:47:39PM +0200, Bernd Schubert wrote:
> > Up to bs=512K it works fine, 1M (and for what it matters
> > already 768K) introduce the order=0 issue.
> 
> Hmm, I replaced memcpy with dumb version, that copies byte by byte - problem
> gone. Is it possible that the optimized memcpy causes caused kind of random
> memory access and confuses mm / readahead?
> And somehow your memcpy or system is not doing that?

Oh, that would make sense!  If the memcpy() works high-to-low, then
you'd see exactly the behaviour you're reporting.  Whereas low-to-high
results in the behaviour I'm seeing.

Hm.  I don't know what to do about that.  Maybe a "sufficiently large"
memcpy should call posix_madvise(src, n, POSIX_MADV_WILLNEED)
