Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F32429B2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 03:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJLByX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 21:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJLByX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:54:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56651C061570;
        Mon, 11 Oct 2021 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dd8fiic3/qE9q03XuQ9MOapfyT7FLJ6jvivOZB26mnA=; b=Oz2gjdInsPkhTAMX25u5a08HFk
        pDYQ8i04D79tm/NhINUzjbgIuZ9avdlFhJpU3BaS+EXIDQWAR+ejPr1RjkBuVynLWBTZL0rimm5Fg
        Q8JUDnD3kPS5pbKpDIyHunSoE/FWXwMKT8X3jHg653Lh6ow1tVe61ywM3+fkQE9evU3OanzSWBgXq
        /iwk459XpM6hKeaSv88wEcacpr1Ffbmz99wF+ITlARN4Py09pBkzOG4z5AsWN6VeLhyGLrYZ0DszP
        1G5boyDk6Uu6AXoRxXPi5iBShlxilCuBWTcKtpP0SqwP8emmnd+FuvBZq1pCXzpyyLK8WC8Qx50u4
        KAeO5BUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma6wB-0068Pi-5j; Tue, 12 Oct 2021 01:51:00 +0000
Date:   Tue, 12 Oct 2021 02:50:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        song@kernel.org, william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
Subject: Re: [PATCH 0/3] mm, thp: introduce a new sysfs interface to
 facilitate file THP for .text
Message-ID: <YWTp7yjaN8W//Zrf@casper.infradead.org>
References: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
 <YWPwjTEfeFFrJttQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWPwjTEfeFFrJttQ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 09:06:37AM +0100, Christoph Hellwig wrote:
> Can we please just get proper pagecache THP (through folios) merged
> instead of piling hacks over hacks here?  The whole readonly THP already
> was more than painful enough due to all the hacks involved.

This was my initial reaction too.

But read the patches.  They're nothing to do with the implementation of
THP / folios in the page cache.  They're all to make sure that mappings
are PMD aligned.

I think there's a lot to criticise in the patches (eg, a system-wide
setting is probably a bad idea.  and a lot of this stuff seems to
be fixing userspace bugs in the kernel).  But let's criticise what's
actually in the patches, because these are problems that exist regardless
of RO_THP vs folios.
