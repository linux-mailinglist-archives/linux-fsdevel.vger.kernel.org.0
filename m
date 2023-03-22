Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260F6C4E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCVOwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCVOvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:51:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BEA1C7FE
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ww/5XbmINktx5j0xX2V+J4URQWhf/qm+QW2sxniwVd4=; b=XxcjGTiFEaCz+sKa18fvU3EsWe
        rSU5FBi5m9Ph2fglSIPH9YSRCeREu3U2PE1mRLqLIc6WV0c904cMxBvv8F6BB3PZeIP3NabFvg4UV
        AjVN6/Tium24YbRU9/6xuieceQGX8O7NigrVhSgoIQ4xAm1fCVpqHdTGUX3SDRRzzvHh3oCqTDAHy
        8euIXPvGZs/Nhx5qkbo/vHl4Kt56khlLbu/OLQ7CtnmdAOTVHgxVEYMYWB0O9Kub00LeeJ/tH1SeI
        xoMwj71zGcA9rEBkHjKOfLUNg6XQXYpvSmYc6OY9o8RWca8J/Tp8CEpkohkDLzmmZW0pQjDI28Qe3
        RTduE4Zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pezmv-0035h2-I8; Wed, 22 Mar 2023 14:50:05 +0000
Date:   Wed, 22 Mar 2023 14:50:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amol Dixit <amoldd@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: inotify on mmap writes
Message-ID: <ZBsVnQatzjB9QgnF@casper.infradead.org>
References: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 06:50:14PM -0700, Amol Dixit wrote:
> The lack of file modification notification events (inotify, fanotify)
> for mmap() regions is a big hole to anybody watching file changes from
> userspace. I can imagine atleast 2 reasons why that support may be
> lacking, perhaps there are more:
> 
> 1. mmap() writeback is async (unless msync/fsync triggered) driven by
> file IO and page cache writeback mechanims, unlike write system calls
> that get funneled via the vfs layer, whih is a convenient common place
> to issue notifications. Now mm code would have to find a common ground
> with filesystem/vfs, which is messy.
> 
> 2. writepages, being an address-space op is treated by each file
> system independently. If mm did not want to get involved, onus would
> be on each filesystem to make their .writepages handlers notification
> aware. This is probably also considered not worth the trouble.
> 
> So my question is, notwithstanding minor hurdles (like lost events,
> hardlinks etc.), would the community like to extend inotify support
> for mmap'ed writes to files? Under configs options, would a fix on a
> per filesystem basis be an acceptable solution (I can start with say
> ext4 writepages linking back to inode/dentry and firing a
> notification)?

I don't understand why you think writepages is the right place for
monitoring.  That tells you when data is leaving the page cache, not
when the file is modified.  If you want to know when the file is
modified, you need to hook into the page_mkwrite path.
