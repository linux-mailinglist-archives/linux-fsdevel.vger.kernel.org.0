Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC3736333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 07:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFTFeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 01:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFTFd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:33:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CF10D5;
        Mon, 19 Jun 2023 22:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tv/KxUiDyInx1PDIV4kKpPvm49qY+WbJYdAJ6sLDhoI=; b=R/t46TzhdTxke4UZWex1PeqvLr
        IRfKCDDZTIim72lwJr8JnaG7z7w7yqd4Q3ncT9V6yosKeD8/lu7DDIHSW8OL3CzY79OHW7H4shFFR
        HBy2XN3Tcx1JqfgZzSthwJGEKqDEdvxCOmRJ5qxKXNmxU9Up20N32mjZUcgGKmf1I3ORDTAxoequ3
        UYP8qjGwFBHujcKbmWuPWmmPzmbHN3K8/IvlialHYgfWAikGSoNh2o7pby7XzpUv/rE9pP2IVR8sB
        0DzWdX/8NwU4WW/g+MMRofhK4dQ2jPuNL4tnXylJUipBM81fPkPkUlbRlQD71cETnHVAdCf3AvFdr
        JaGyFSIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBTzp-00Chre-QP; Tue, 20 Jun 2023 05:33:42 +0000
Date:   Tue, 20 Jun 2023 06:33:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v2 1/5] fs/buffer: clean up block_commit_write
Message-ID: <ZJE6Nf6XmeHIlFJI@casper.infradead.org>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
 <20230619211827.707054-2-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619211827.707054-2-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:18:23PM +0200, Bean Huo wrote:
> +++ b/fs/buffer.c
> @@ -2116,8 +2116,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
>  }
>  EXPORT_SYMBOL(__block_write_begin);
>  
> -static int __block_commit_write(struct inode *inode, struct page *page,
> -		unsigned from, unsigned to)
> +int block_commit_write(struct page *page, unsigned int from, unsigned int to)
>  {
>  	unsigned block_start, block_end;
>  	int partial = 0;

You're going to need to redo these patches, I'm afraid.  A series of
patches I wrote just went in that convert __block_commit_write (but
not block_commit_write) to take a folio instead of a page.

