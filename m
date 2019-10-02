Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3DC9287
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfJBTiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 15:38:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46314 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBTiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:38:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFkSW-0000sh-9p; Wed, 02 Oct 2019 19:38:48 +0000
Date:   Wed, 2 Oct 2019 20:38:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daegyu Han <dgswsk@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: How can I completely evict(remove) the inode from memory and
 access the disk next time?
Message-ID: <20191002193848.GE26530@ZenIV.linux.org.uk>
References: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:30:21PM +0900, Daegyu Han wrote:
> Hi linux file system experts,
> 
> I'm so sorry that I've asked again the general question about Linux
> file systems.
> 
> For example, if there is a file a.txt in the path /foo/ bar,
> what should I do to completely evict(remove) the inode of bar
> directory from memory and read the inode via disk access?
> 
> A few weeks ago. I asked a question about dentry and Ted told me that
> there is a negative dentry on Linux.
> 
> I tried to completely evict(remove) the dentry cache using FS API in
> include/fs.h and dcache.h, and also evict the inode from memory, but I
> failed.
> 
> The FS API I used is:
> dput() // to drop usage count and remove from dentry cache
> iput() // to drop usage count and remove from inode cache.
> 
> To be honest, I'm confused about which API to cope with my question.
> 
> As far as I know, even though metadata is released from the file
> system cache, it is managed as an LRU list.
> 
> I also saw some code related to CPU cacheline.
> When I look at the superblock structure, there are also inodes, dcache
> lists, and LRUs.
> 
> How can I completely evict the inode from memory and make disk access
> as mentioned above?

In general you simply can't.  Not if there is anyone who'd opened the file
in question.  As long as the sucker is opened, struct inode *WILL* remain
in memory.

What are you trying to achieve?
