Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9C17A51EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIRSUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRSUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:20:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B2FB;
        Mon, 18 Sep 2023 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YtFZ4aIMH+wK5gxLvaFez4GPeCFUiImPTsyXwfH5C7Y=; b=xP8ctjwJh6nbn8EmKDuPATY+1P
        bebaZJXtSL6UspdqmjCpgGWN7G4EFwZl4o8h8y0gFUPPGp9L8nFi+3VaH0gOf7kX+whvSsQRjV1or
        1u1KVmuArHYxagGNl7R9/xWe3FEjATP2Rf5uVeFt7Vr6y21uk3O9IzWk0eb7Qm5JaXG6PHClEqu91
        8vw4ZCb6P3fRhMRzfM9OkcYS72jaD2p9s6Q+keZZEVtUFeddKHtVfHyhxq+c7vo2rm5SeV16avKib
        EmjyxF3KYOAIVWGBeeyJjjOiVkmeGaa0W7G6Zf6Su7hGbq284xw8f66CI3ZBDx/+/D3lXbXo6Pu1j
        mmCMH6Cw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiIrD-00G4Zw-0J;
        Mon, 18 Sep 2023 18:20:27 +0000
Date:   Mon, 18 Sep 2023 11:20:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com
Subject: Re: [RFC 04/23] filemap: set the order of the index in
 page_cache_delete_batch()
Message-ID: <ZQiU61S3fMjrirNe@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-5-kernel@pankajraghav.com>
 <ZQSz4JttC/uTZwGw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSz4JttC/uTZwGw@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:43:28PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:29PM +0200, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Similar to page_cache_delete(), call xas_set_order for non-hugetlb pages
> > while deleting an entry from the page cache.
> 
> Is this necessary?  As I read xas_store(), if you're storing NULL, it
> will wipe out all sibling entries.  Was this based on "oops, no, it
> doesn't" or "here is a gratuitous difference, change it"?

Based on code inspection, I saw page_cache_delete() did it. The xarray
docs and xarray selftest was not clear about the advanced API about this
case and the usage of the set order on page_cache_delete() gave me
concerns we needed it here.

We do have some enhancements to xarray self tests to use the advanced
API which we could extend with this particular case before posting, so
to prove disprove if this is really needed.

Why would it be needed on page_cache_delete() but needed here?

  Luis
