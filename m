Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DFA436F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhJVBUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:20:10 -0400
Received: from vps.thesusis.net ([34.202.238.73]:54388 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhJVBUJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:20:09 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2021 21:20:09 EDT
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 42E3C6148D; Thu, 21 Oct 2021 21:09:01 -0400 (EDT)
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: Readahead for compressed data
Date:   Thu, 21 Oct 2021 21:04:45 -0400
In-reply-to: <YXHK5HrQpJu9oy8w@casper.infradead.org>
Message-ID: <87tuh9n9w2.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> As far as I can tell, the following filesystems support compressed data:
>
> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>
> I'd like to make it easier and more efficient for filesystems to
> implement compressed data.  There are a lot of approaches in use today,
> but none of them seem quite right to me.  I'm going to lay out a few
> design considerations next and then propose a solution.  Feel free to
> tell me I've got the constraints wrong, or suggest alternative solutions.
>
> When we call ->readahead from the VFS, the VFS has decided which pages
> are going to be the most useful to bring in, but it doesn't know how
> pages are bundled together into blocks.  As I've learned from talking to
> Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> something we can teach the VFS.
>
> We (David) added readahead_expand() recently to let the filesystem
> opportunistically add pages to the page cache "around" the area requested
> by the VFS.  That reduces the number of times the filesystem has to
> decompress the same block.  But it can fail (due to memory allocation
> failures or pages already being present in the cache).  So filesystems
> still have to implement some kind of fallback.

Wouldn't it be better to keep the *compressed* data in the cache and
decompress it multiple times if needed rather than decompress it once
and cache the decompressed data?  You would use more CPU time
decompressing multiple times, but be able to cache more data and avoid
more disk IO, which is generally far slower than the CPU can decompress
the data.



