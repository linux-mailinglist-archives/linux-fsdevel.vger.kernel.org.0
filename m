Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9DE6EFACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 21:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDZTON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjDZTOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:14:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E4133
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VIUqXVtUe4bZ8NtmE8a1FAauCd96j6BzSVHyawTA+ZM=; b=aUChelqXkih9JMCYHBk2D9U1QZ
        Z7T9OPKLurxiEsYYr7SWLOPxQH4UVPXEB1oB/76X9BtQyrlNPXoYXi8tNxnqlz3fDz95XQG0C/nf1
        OTug4u9SYK+SsT+18PQy+ZBdOcvLkxIVSYY7ZW7JxTKGTD8pWSX5P7UF3ug7bXHfmvvaEpl6lpjWx
        x18U1NNXj48FCRMX+8hvY1gQ2U4l2BDvPP2LHolKkC1z+mKFFSSiBt4HqST+lUyMgebuJJfN9utwq
        7riZ4uyXqsXGtuHCLwUnR0rlNIFjd718Vw0mnVAfIa4ejzJUZaCnEP1qEawmWv6v4eU9v968ZTvqj
        xAjnWJ/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prka9-002lnw-H6; Wed, 26 Apr 2023 19:13:37 +0000
Date:   Wed, 26 Apr 2023 20:13:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kernel.org Bugbot" <bugbot@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, bugs@lists.linux.dev
Subject: Re: large pause when opening file descriptor which is power of 2
Message-ID: <ZEl34WthS8UNJnNd@casper.infradead.org>
References: <20230426-b217366c0-53b6841a1f9a@bugzilla.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426-b217366c0-53b6841a1f9a@bugzilla.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:58:06PM +0000, Kernel.org Bugbot wrote:
> When running a threaded program, and opening a file descriptor that
> is a power of 2 (starting at 64), the call takes a very long time to
> complete. Normally such a call takes less than 2us. However with this
> issue, I've seen the call take up to around 50ms. Additionally this only
> happens the first time, and not subsequent times that file descriptor is
> used. I'm guessing there might be some expansion of some internal data
> structures going on. But I cannot see why this process would take so long.

Because we allocate a new block of memory and then memcpy() the old
block of memory into it.  This isn't surprising behaviour to me.
I don't think there's much we can do to change it (Allocating a
segmented array of file descriptors has previously been vetoed by
people who have programs with a million file descriptors).  Is it
causing you problems?
