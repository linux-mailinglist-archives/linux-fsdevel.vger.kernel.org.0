Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6226619D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 22:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjAHVQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 16:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbjAHVNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:13:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E46565;
        Sun,  8 Jan 2023 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D7a/bf8y+hnf1vOEi6y8Co5HNDUBH87eZ629Edw7Kh0=; b=McX6ybvWrIyBCWgMTSn5LSbdcf
        7APZ7yKaIVqF9WLPgmBfFbu/wtlzNoBbY3ROyGkglp13HbeM8A3oRGzZ6+BMUEJAH9bUrRjg7h8j8
        jlnuRAO9JiYK8ahCVcAo0iRZvTw8+YYuRObTqFzqJfpZ5rtMal8H/6UlHDqwwJ9BjjWDY6MY8Um8Z
        RCcqyZQ3VCP8EXQQaWkalNAy69z09vzVgP8+buH64VUk2Ecs+reZ1w8LJ/kyj4Yx6OXcjCYXMg/bc
        tRcKu3lg1ysgOGu92TcqM9e5zmvEvQWgQzxW0kHHAQ0eTN+XvbnRUBtGnPKh92rTN4Dj7inDMKYkO
        KwSoeuvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEcyg-001kSO-Ug; Sun, 08 Jan 2023 21:13:15 +0000
Date:   Sun, 8 Jan 2023 21:13:14 +0000
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
Subject: Re: [PATCH 2/7] btrfs: stop using write_one_page in
 btrfs_scratch_superblock
Message-ID: <Y7sx6iJPeyfVfkYV@casper.infradead.org>
References: <20230108165645.381077-1-hch@lst.de>
 <20230108165645.381077-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108165645.381077-3-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 05:56:40PM +0100, Christoph Hellwig wrote:
> +	memset(&disk_super->magic, 0, len);
> +	set_page_dirty(virt_to_page(disk_super));

Could we make this:

	folio_mark_dirty(virt_to_folio(disk_super));

Other than that, looks good.
