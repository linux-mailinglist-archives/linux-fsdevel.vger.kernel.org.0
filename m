Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F04CCC9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 05:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiCDEjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 23:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiCDEjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:39:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D95DE4F;
        Thu,  3 Mar 2022 20:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=czx5ybB1xeuMipycQ6XWyQQmkQUgRPLvyVJhMpxXE4E=; b=loLarWJ4WtSnJ57hlqBMBpXGsu
        8tNCU9LveNsYNvRsA4XQ5gxSfVXEPgvLLnKS6zcq2KB4HB7Tr3OvpU/KEoxOieOWs72IDV/5BJMGZ
        6igzmrH8i/YDHa0I6JZMSVnLSJpwQkG8PKiiGCtNxaohx7CJsDP9bHWYzYPNsGGG41ki9XWnxotPx
        IxNcIqSz4UoKGO2G80xn9VgZ+wcegYC2AYauAtItwc2/qQhWKqpvh7B95R3FezT9hZVyp6+oWjTQ5
        WdkyZcbc2VbPAfYGPXq3UCBsTeadCio+69T874A6M8ra25JPEqTceVRQtUepQFomkg1lASSOFOlgH
        1LXiMO9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPziN-00CIGg-0l; Fri, 04 Mar 2022 04:38:51 +0000
Date:   Fri, 4 Mar 2022 04:38:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: warn on deleting redirtied only if accounted
Message-ID: <YiGX2prSQEFoFOdL@casper.infradead.org>
References: <b5a1106c-7226-a5c6-ad41-ad4832cae1f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a1106c-7226-a5c6-ad41-ad4832cae1f@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 08:25:50PM -0800, Hugh Dickins wrote:
> filemap_unaccount_folio() has a WARN_ON_ONCE(folio_test_dirty(folio)).
> It is good to warn of late dirtying on a persistent filesystem, but late
> dirtying on tmpfs can only lose data which is expected to be thrown away;
> and it's a pity if that warning comes ONCE on tmpfs, then hides others
> which really matter.  Make it conditional on mapping_cap_writeback().
> 
> Cleanup: then folio_account_cleaned() no longer needs to check that
> for itself, and so no longer needs to know the mapping.

At first blush, I like this a lot.  Will look more in the morning.
