Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB660BC92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJXVyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiJXVyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:54:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1592F2732;
        Mon, 24 Oct 2022 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7MsR0R1NbSyB2Djzw/hFUhA/+5S6z5HyXDOZO3eVnQg=; b=Sz5j+RyAMJMG8UN49CI/nYQsRM
        4uctA+lYIXec8+kZbgkhU9sfzm2Y04hWo+tPCEQTJyx3zRaNr9Wd20f0mK3a2nGhmAnFPqvsQD/k1
        7mQnl5ZhzhFRoUDkH0U9c9iTvIWHP7suVXqBsD5AMkabioENS46bynM5C22QMostYhwbZ03GBCt64
        C6ho4ykMx3e35M96kmpJGQH3OjDWH4lKrS9MHkdnK3z0AT1XCBM64Ux2LafoYepJsAbGzL+W6zQpV
        iWZYCZcRkajtC2dbalkjT9RGPcA20dSCql/hbVwpp6dr8//HsLsLv88DwGLSugrvIDPH/UYXKAClR
        wLAo/S/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on3ir-00FiEx-R3; Mon, 24 Oct 2022 20:06:57 +0000
Date:   Mon, 24 Oct 2022 21:06:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 03/23] filemap: Convert __filemap_fdatawait_range() to
 use filemap_get_folios_tag()
Message-ID: <Y1bwYd7tz76/fb5n@casper.infradead.org>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017202451.4951-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:24:31PM -0700, Vishal Moola (Oracle) wrote:
> Converted function to use folios. This is in preparation for the removal
> of find_get_pages_range_tag().

Yes, it is, but this patch also has some nice advantages of its own:

 - Removes a call to wait_on_page_writeback(), which removes a call
   to compound_head()
 - Removes a call to ClearPageError(), which removes another call
   to compound_head()
 - Removes a call to pagevec_release(), which will eventually
   remove a third call to compound_head() (it doesn't today, but
   one day ...)

So you can definitely say that it removes 50 bytes of text and two
calls to compound_head().  And that way, this patch justifies its
existance by itself ;-)

> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
