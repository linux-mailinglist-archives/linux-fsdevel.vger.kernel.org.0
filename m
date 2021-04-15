Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD9360C09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhDOOle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDOOld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:41:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E60C061574;
        Thu, 15 Apr 2021 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bbfZklVxjG+sWHi7IiCs1kyn3HMRY6bVgv2EJsEJ5Q0=; b=FsWwvY9DiyAIM9LkMiiSC8gHTF
        clmO8r4JI8HX3LQRyiXll+URewuSvxx2bzSwNC+zmwyn9IkIypbw8Ecl8eoRtn4tLJa2Q0YRAopgH
        tPDlKW1Ltz0yFblr6gUZaTSy1W0ReJ6w3ksfGmRJUrGUsM6FgcLh4WxTh0xl9vQXFuHfbv9ypQ4Xw
        x4E58Too2oru1gKxBIISQSV5GErEvCIfLSk5lhH01LKyDZo3RzAeJi8nm7G+z1EsQqNkbUDY5+C3S
        i4bMgITsrh2y3/9HlEj5uxbDtlv5KaamhMp7ccBNRDhuZBpkJzkMVxqwkRoQQoraRAP3kVpy+oN9t
        aoSu8YTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lX3Au-008gTJ-8q; Thu, 15 Apr 2021 14:40:59 +0000
Date:   Thu, 15 Apr 2021 15:40:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 6/7] fs: introduce a usage count into the
 superblock
Message-ID: <20210415144056.GA2069063@infradead.org>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-7-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134737.2366971-7-yi.zhang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:47:36PM +0800, Zhang Yi wrote:
> Commit <87d8fe1ee6b8> ("add releasepage hooks to block devices which can
> be used by file systems") introduce a hook that used by ext4 filesystem
> to release journal buffers, but it doesn't add corresponding concurrency
> protection that ->bdev_try_to_free_page() could be raced by umount
> filesystem concurrently. This patch add a usage count on superblock that
> filesystem can use it to prevent above race and make invoke
> ->bdev_try_to_free_page() safe.

We already have two refcounts in the superblock: s_active which counts
the active refernce, and s_count which prevents the data structures
from beeing freed.  I don't think we need yet another one.
