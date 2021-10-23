Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB139438146
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 03:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJWBjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 21:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhJWBjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 21:39:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0624C061764;
        Fri, 22 Oct 2021 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N8vjDyk1bwArRt+U/J/1L+rb0qPO+QdxEyVFcfOb5ZM=; b=C89e0Ni4RhWnYqoxny+ZQjzdNq
        qWRwIQr7JAL4AnkHgb7FRxpDInRcMv0vztF7Sp15xSjd1kxN5OSGCtYZ9cz7T2N4SJksQ5mjTbk+J
        Vh5Knm+Za+LU+BQC1LTjd1kBcNHfNYGj6W4usqh9fyaxITzU3qFEDkyYR75Ti2NqiCRYHGvXiua0D
        Ggp6t9vEUw6/S1FL8NO2hFVjS3GhooQ0ZIfz/4QPU9bYLNcBfLkKW7T9quy9f0DpEc7P0TRK9uI71
        Fr+DHKAO91B5BMjlSalrIBIwJuvBXMcmF19y4msn0vObrshpr+JXuN5EhYfPSPc0zDoS8SdLmeJ7x
        NbDZCBzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me5x8-00EJcr-CZ; Sat, 23 Oct 2021 01:36:29 +0000
Date:   Sat, 23 Oct 2021 02:36:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [RFC PATCH 2/5] mm: Switch mapping to device mapping
Message-ID: <YXNnBvPYAOfvQ/YH@casper.infradead.org>
References: <cover.1634933121.git.rgoldwyn@suse.com>
 <98a26b87716dd6eec5214ee0dc2eac10eb47439d.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a26b87716dd6eec5214ee0dc2eac10eb47439d.1634933121.git.rgoldwyn@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 03:15:02PM -0500, Goldwyn Rodrigues wrote:
> Get the device offset and last_index from the filesystem and read it
> from the device directly. If the device page(s) have been read before,
> it can be picked up directly for reads. If not the page is read from the
> device. The page would be added to device's mapping instead of the file.

I really don't like this way of doing it.

Why doesn't the filesystem choose where it's going to cache the data and
call filemap_readpage on that inode, instead of having the generic code
call back into the filesystem to decide where to cache the data?

You know that it's a shared extent before you call into filemap_read(),
so you know it shouldn't be cached in the local inode.
