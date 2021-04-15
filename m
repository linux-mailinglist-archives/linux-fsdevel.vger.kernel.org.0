Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18B7360CE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhDOOzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhDOOx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:53:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85925C06134D;
        Thu, 15 Apr 2021 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C3gAoqVJbNHaFnVpwiCtlJm6hLmAHtP5KFU8HTA8ghw=; b=iGHVKQkMSm0+27XKnHvlajsJCv
        4kR0v8sl5YK50iM2k3eZUSfbThB7vL3XjfdE6fQ4eMSfSMS52q4eVr5Gr8Sb/kwFT2jJNbHKmECRw
        CCJEgp5Y0XiWPpIJiPDakzGWLfXO7tckZcBgy256Te8tHLdaoODdKQOHMDxMTJipVsUB+q4FlSmGC
        a1bVml7oIJ2sGyjHyoC4hC4qAZbwTkNzcn1VgswgXUDWl6zuUZGDhO6o1PI/xe+iEOqx07XkNhTiq
        MXCcTwnwPXUxSktS25GWcknDlCl2XdinvaMQCoaMN2/jBtZM8LFSAkhVzl5l+TeW4x9UnvGSoSluN
        m3VoPtng==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX3MB-008hIz-HL; Thu, 15 Apr 2021 14:52:44 +0000
Date:   Thu, 15 Apr 2021 15:52:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
Message-ID: <20210415145235.GD2069063@infradead.org>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134737.2366971-8-yi.zhang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:47:37PM +0800, Zhang Yi wrote:
> There still exist a use after free issue when accessing the journal
> structure and ext4_sb_info structure on freeing bdev buffers in
> bdev_try_to_free_page(). The problem is bdev_try_to_free_page() could be
> raced by ext4_put_super(), it dose freeing sb->s_fs_info and
> sbi->s_journal while release page progress are still accessing them.
> So it could end up trigger use-after-free or NULL pointer dereference.

I think the right fix is to not even call into ->bdev_try_to_free_page
unless the superblock is active.
