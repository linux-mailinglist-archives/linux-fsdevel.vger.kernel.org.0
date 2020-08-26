Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E881825384E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZTbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgHZTbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:31:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37711C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/KVBDiY8YHzsLv2yVa4q4qMt+zYerqkGrqgCBXLrdFI=; b=qrwYyCUnsnL+iJV0cRMo81tsBQ
        TJ+ZVjCJPJdNoQBNXEdjqUv2wNVOEXDAvcJ0qnBk/QCbHpxTFRkJZeXZ33OoUQM/3fT/SYH4MnxQv
        NRmSv1RWswei66XdWm8z0fj2Ct+BY47mddSYxmCM+11E7CHDlecOQEn5w9YXz9U3oz+0J6My0rGUh
        VS2LT6ogoViUn3csm6aP/3TxG8R6zxehUT7Gywi12pvPkmWENQn7MS96UjXzKd1x4JKgKZdSt6KoH
        OVuSsSgLVk+Qywa3cchGOcf+V9NVVTfNGxUJXC8+85B0ZTFfvKz5K5nl08bGoJMyJkVm/gUZZAXwE
        vvG91aPw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kB18e-0002sJ-HE; Wed, 26 Aug 2020 19:31:16 +0000
Date:   Wed, 26 Aug 2020 20:31:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>
Subject: The future of readahead
Message-ID: <20200826193116.GU17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both Kent and David have had conversations with me about improving the
readahead filesystem interface this last week, and as I don't have time
to write the code, here's the design.

1. Kent doesn't like it that we do an XArray lookup for each page.
The proposed solution adds a (small) array of page pointers (or a
pagevec) to the struct readahead_control.  It may make sense to move
__readahead_batch() and readahead_page() out of line at that point.
This should be backed up with performance numbers.

2. David wants to be sure that readahead is aligned to a granule
size (eg 256kB) to support fscache.  When we last talked about it,
I suggested encoding the granule size in the struct address_space.
I no longer think this approach should be pursued, since ...

3. Kent wants to be able to expand readahead to encompass an entire fs
extent (if, eg, that extent is compressed or encrypted).  We don't know
that at the right point; the filesystem can't pass that information
through the generic_file_buffered_read() or filemap_fault() interface
to the readahead code.  So the right approach here is for the filesystem
to ask the readahead code to expand the readahead batch.

So solving #2 and #3 looks like a new interface for filesystems to call:

void readahead_expand(struct readahead_control *rac, loff_t start, u64 len);
or possibly
void readahead_expand(struct readahead_control *rac, pgoff_t start,
		unsigned int count);

It might not actually expand the readahead attempt at all -- for example,
if there's already a page in the page cache, or if it can't allocate
memory.  But this puts the responsibility for allocating pages in the VFS,
where it belongs.

4. Mike wants to be able to do 4MB I/Os [1].  That should be covered by
the solution above.  Mike, just to clarify.  Do you need 4MB pages, or can
you work with some mixture of page sizes going as far as 1024 x 4kB pages?

5. I'm allocating larger pages in the readahead code (part of the THP
patch set [2])

[1] https://lore.kernel.org/linux-fsdevel/CAOg9mSSrJp2dqQTNDgucLoeQcE_E_aYPxnRe5xphhdSPYw7QtQ@mail.gmail.com/
[2] http://git.infradead.org/users/willy/pagecache.git/commitdiff/c00bd4082c7bc32a17b0baa29af6974286978e1f
