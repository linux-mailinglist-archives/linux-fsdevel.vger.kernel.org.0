Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB597ABA28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjIVTi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:38:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC934AF;
        Fri, 22 Sep 2023 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TwghE0UWvedzbS9x4AhHOtwKLQCqsKJyy8dRVBG0BLM=; b=J+2aR6VVMtP3vyHszk4csseJuH
        cHY42l/HKolxgTYY1E1HcC6ojrTdLFolrI31cdR/vAFPJq3sYRWZ8odsSrTte74EyWyjpaq8ro1gY
        AqnjXNxiPbMV/Z7/4xU17R8I4yXrdHd0w54moXRI+LrEq1SJEVXPDCBOajVnyQyLFdw0ujB0remek
        l/oGsO8Gke0LF7eHik74oK+w314N7cqkDf9a6hIdyDCzDJWnkqGb9pDflISC2vW8t8jICY4fjfbAf
        Eh3DKfCJd8PMRQyZqo03OKf+6v6/PUahX0ytz3bluv7VVVKc6qO3HTaH/ZOd8an84LQPNFbQriI5c
        Tv5T5aMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjlyZ-002Tkn-BO; Fri, 22 Sep 2023 19:38:07 +0000
Date:   Fri, 22 Sep 2023 20:38:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, djwong@kernel.org,
        linux-mm@kvack.org, chandan.babu@oracle.com, gost.dev@samsung.com,
        riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQ3tH61w+2Sf7AL2@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
 <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
 <ZQvczBjY4vTLJFBp@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQvczBjY4vTLJFBp@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

lOn Thu, Sep 21, 2023 at 04:03:56PM +1000, Dave Chinner wrote:
> So there's clearly something wrong here - it's likely that the
> filesystem IO alignment parameters pulled from the underlying block
> device (4k physical, 512 byte logical sector sizes) are improperly
> interpreted.  i.e. for a filesystem with a sector size of 4kB,
> direct IO with an alignment of 512 bytes should be rejected......

I wonder if it's something in the truncation code that's splitting folios
that ought not to be split.  Does this test possibly keep folios in
cache that maybe get invalidated?

truncate_inode_partial_folio() is the one i'm most concernd about.
but i'm also severely jetlagged.
