Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3139B6619E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjAHVTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 16:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAHVTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:19:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D11DEAB;
        Sun,  8 Jan 2023 13:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=smtf3b6c0YiLyegeGcE2QFdIpMIIUxY2QjH9VIZPeqs=; b=LwRCSfg4lurhfJplbjaoasx+AK
        i9NeK9Itn6mhZyaQBDGH8TsyNknvvOz6OzxmWVVH2jlqc/3k/698PgjVLLVYaPEjFaZdELofoEm8c
        w4wtquN4FxNlPO/Tyk44scz4/CWeWCVw2QzvSZmJwjvQ76VjjJJkcBRdiiH/CGf5OOsRAAp5NVqPF
        KodMj3MQOePSeDYwwAhqMQA7DCoBX9hicB1aN6THIdKISHSSVBQVgxGVetK6Oy18dlTXXLTtq7xk7
        wQSlhxVeURFfEUK6vyKbQgKfXUvkaRIuXkjROCzDp83BpM0eSnokETYF8b+nY1OpbJXqWeD3RaIoF
        zcJMPD6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEd4c-001khF-Q6; Sun, 08 Jan 2023 21:19:22 +0000
Date:   Sun, 8 Jan 2023 21:19:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/7] sysv: don't flush page immediately for DIRSYNC
 directories
Message-ID: <Y7szWmUKSwcxsaMu@casper.infradead.org>
References: <20230108165645.381077-1-hch@lst.de>
 <20230108165645.381077-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108165645.381077-5-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 05:56:42PM +0100, Christoph Hellwig wrote:
> We do not need to writeout modified directory blocks immediately when
> modifying them while the page is locked. It is enough to do the flush
> somewhat later which has the added benefit that inode times can be
> flushed as well. It also allows us to stop depending on
> write_one_page() function.

Similar concerns to the minix patch here ... missing assignments to
'err'.
