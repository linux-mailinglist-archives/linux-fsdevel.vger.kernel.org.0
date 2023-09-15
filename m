Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA27A2279
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjIOPfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjIOPfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:35:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95746F3;
        Fri, 15 Sep 2023 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BiPqqbuCoCJwT7cml3FIg1dZt/5325CvLgUU6B8VZPI=; b=WnqCDQbwPSmkZQOH3XpBhxlOB4
        Hf8TM/ShP+TANJO0GVAK3VYfdj33ab9xx/LVhg422oglIHaMJlu//v5xlqpc5FidCjldVxm5F5HCt
        RsMIx7xUQHGI8xA1mvs2nvLOiVryITICXLBFkakSxO9YiJHTheLXp2chiBFvPbbY/lS4/TMqwdLC0
        V6eY01zys5j9cSxLIyTFOei2USk/mipe17dMsrFjr0JvKVPRnc/SVxUBIL4TtoGVARdhern+1WRxa
        oHksp7hZoCLOB+UK4mg0+oUkJl5cvKo++ELseTENIW9FXic6yq21wesS02/L5b/yY1t1UtuFC+aFs
        JlRbGrcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhAqM-00AWs4-Oi; Fri, 15 Sep 2023 15:34:54 +0000
Date:   Fri, 15 Sep 2023 16:34:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
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
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Message-ID: <ZQR5nq7mKBJKEFHL@casper.infradead.org>
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
 <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:29:51PM +0200, David Hildenbrand wrote:
> On 15.09.23 11:51, Daniel Gomez wrote:
> > This series add support for high order folios in shmem write
> > path.
> > There are at least 2 cases/topics to handle that I'd appreciate
> > feedback.
> > 1. With the new strategy, you might end up with a folio order matching
> > HPAGE_PMD_ORDER. However, we won't respect the 'huge' flag anymore if
> > THP is enabled.
> > 2. When the above (1.) occurs, the code skips the huge path, so
> > xa_find with hindex is skipped.
> 
> Similar to large anon folios (but different to large non-shmem folios in the
> pagecache), this can result in memory waste.

No, it can't.  This patchset triggers only on write, not on read or page
fault, and it's conservative, so it will only allocate folios which are
entirely covered by the write.  IOW this is memory we must allocate in
order to satisfy the write; we're just allocating it in larger chunks
when we can.
