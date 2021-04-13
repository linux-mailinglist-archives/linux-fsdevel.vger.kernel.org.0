Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7235DFB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbhDMNGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbhDMNGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:06:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F70C061756;
        Tue, 13 Apr 2021 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zavtS5uBcTO3wBSpyw7PZCTHGGenOm3xew/p3SPWJJ4=; b=VAtxrdOqFVgGXiDA0AjN5fMunw
        Edk/B9PFCOa/wUgdZ3XK1l9QxvWzPGAzDActkucDV5y3DgtYV4Ef6ukFWfJFtrbNvFWbTArtgoZNC
        PvkBPvSf0vT/Wi/w2eGWbRQ3dIIlvaflPMml3TctKrfBujrJ1BXAPDm5yWGIpTZbusNzxEbF2+kcK
        IJsRrJdLHQSTpL7F1VtZcq49fNmtXJh88Qaewuu2pu54Jr1oP2OeYc9+galCcHBM+N+CAyrL5ZPr1
        AD0D9vtu9hXUdgohVs/oXwhPgcb8ID/qDskcELtZCGMRp20WSY7+vT+X8yblDQ2HT1gCgizklbjkD
        pVxY4b4A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWIjA-005lSi-0m; Tue, 13 Apr 2021 13:05:23 +0000
Date:   Tue, 13 Apr 2021 14:05:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/7] xfs: Convert to use i_mapping_sem
Message-ID: <20210413130512.GC1366579@infradead.org>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413112859.32249-5-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 01:28:49PM +0200, Jan Kara wrote:
> Use i_mapping_sem instead of XFS internal i_mmap_lock. The intended
> purpose of i_mapping_sem is exactly the same.

Might be worth mentioning here that the locking in __xfs_filemap_fault
changes because filemap_fault already takes i_mapping_sem?

>   * mmap_lock (MM)
>   *   sb_start_pagefault(vfs, freeze)
> - *     i_mmaplock (XFS - truncate serialisation)
> + *     i_mapping_sem (XFS - truncate serialisation)

This is sort of VFS now, isn't it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
