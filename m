Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67067993A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjAXNZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjAXNZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:25:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3231110DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N8fL8XcyNPAEoXmkg0wGh+2iqCtRh+4o3YVK+a3X7iE=; b=pKpQ/MVxyzOBjFstn8ti+CoNHz
        0mQvZnw9j7MsRCx/YlqUPHSLwxHDvT8/jQ0vE7r3qpeTugeEujc6wuQIo8P3nyZ6vAruIpXyOfAF5
        5z/1ufjMR2HP4HZi7HMQj4Sfc5ErOXaMsnAB3ky/P1HM5uDpgwqmT06dooDhtChLiIKhAcLe+sZyd
        VOkobBfQOVZp0o7mKh4W/Ywunkc4xVE0OrSpOPN3uduraHqLu4BlD5DX4cWMJkCmNMuqAL9KALB8q
        6jcTjXlBmAlMH3Y7n/DlTQwGoXRwwptCxhCbhYVgEW/I1SaKoHTOAMJiEyvq7axCM5dD9haRBWll6
        pqe58LWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJIT-003yCZ-Hj; Tue, 24 Jan 2023 13:25:09 +0000
Date:   Tue, 24 Jan 2023 05:25:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/10] udf: Convert in-ICB files to use udf_writepages()
Message-ID: <Y8/cNRNSazn58MXL@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a pure mechanical move this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But some comments:

> +	struct inode *inode = page->mapping->host;
> +	char *kaddr;
> +	struct udf_inode_info *iinfo = UDF_I(inode);
> +
> +	BUG_ON(!PageLocked(page));
> +
> +	kaddr = kmap_atomic(page);
> +	memcpy(iinfo->i_data + iinfo->i_lenEAttr, kaddr, i_size_read(inode));
> +	SetPageUptodate(page);
> +	kunmap_atomic(kaddr);
> +	unlock_page(page);

This really should be using memcpy_to_page.  And the SetPageUptodate
here in ->writepages loos a little odd as well.
