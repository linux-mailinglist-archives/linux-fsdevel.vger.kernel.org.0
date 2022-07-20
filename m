Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD657AE3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 05:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiGTDDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 23:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiGTDDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:03:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06A6433;
        Tue, 19 Jul 2022 20:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YW9vZ0DFmjEUcrU3kVkIJzmwjJ6l61hPGiZtfLK4BoM=; b=NAFWsobF+Pu6BHXFPXmayLBdzj
        xRgKGEDrNxOylkaL24UcgMTm5X7LleQLZ0h7gaOU4qPoQChCKUuI4VSBVv3gDyaDnTYQ2AxMMsZW3
        mxjV1cgUYT+wGU2JJiDal5KUDbI8+Mo5EHAv3RHRdt2FzcXtDepe9716G2kkOK0cTU8ilOuaiuEIz
        f4HRTtWYSLHWlDL0GwkM8AkNqfeEjqIhGkiunFn/ICh6didUrQ//71KDAdzncRgGD66bVrvvBEsu+
        GKgTmuSjzyZ3O3Vk93wrfA1raDI4RDLdPcBwxfghAScD/FjerrmzQi9LasfJlJUHbhfycik36y19Q
        ydpd9dAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDzyy-00E6Vz-QC; Wed, 20 Jul 2022 03:02:40 +0000
Date:   Wed, 20 Jul 2022 04:02:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, hch@infradead.org,
        hsiangkao@linux.alibaba.com, yang.yang29@zte.com.cn,
        axboe@kernel.dk, yangerkun@huawei.com, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] fs: drop_caches: skip dropping pagecache which is always
 dirty
Message-ID: <YtdwULpWfSR3JI/u@casper.infradead.org>
References: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 02:21:19AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Pagecache of some kind of fs has PG_dirty bit set once it was
> allocated, so it can't be dropped. These fs include ramfs and
> tmpfs. This can make drop_pagecache_sb() more efficient.

Why do we want to make drop_pagecache_sb() more efficient?
