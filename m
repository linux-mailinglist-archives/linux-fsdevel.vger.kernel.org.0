Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB113DB030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 02:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhG3ASO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 20:18:14 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42500 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbhG3ASO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:18:14 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9G9b-0052l3-6o; Fri, 30 Jul 2021 00:13:31 +0000
Date:   Fri, 30 Jul 2021 00:13:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <YQNEK48+GLDvOx8t@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728193536.GD3152@fieldses.org>
 <e75ccfd2-e09f-99b3-b132-3bd69f3c734c@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75ccfd2-e09f-99b3-b132-3bd69f3c734c@toxicpanda.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 05:30:04PM -0400, Josef Bacik wrote:

> I don't think anybody has that many file systems.  For btrfs it's a single
> file system.  Think of syncfs, it's going to walk through all of the super
> blocks on the system calling ->sync_fs on each subvol superblock.  Now this
> isn't a huge deal, we could just have some flag that says "I'm not real" or
> even just have anonymous superblocks that don't get added to the global
> super_blocks list, and that would address my main pain points.

Umm...  Aren't the snapshots read-only by definition?

> The second part is inode reclaim.  Again this particular problem could be
> avoided if we had an anonymous superblock that wasn't actually used, but the
> inode lru is per superblock.  Now with reclaim instead of walking all the
> inodes, you're walking a bunch of super blocks and then walking the list of
> inodes within those super blocks.  You're burning CPU cycles because now
> instead of getting big chunks of inodes to dispose, it's spread out across
> many super blocks.
> 
> The other weird thing is the way we apply pressure to shrinker systems.  We
> essentially say "try to evict X objects from your list", which means in this
> case with lots of subvolumes we'd be evicting waaaaay more inodes than you
> were before, likely impacting performance where you have workloads that have
> lots of files open across many subvolumes (which is what FB does with it's
> containers).
> 
> If we want a anonymous superblock per subvolume then the only way it'll work
> is if it's not actually tied into anything, and we still use the primary
> super block for the whole file system.  And if that's what we're going to do
> what's the point of the super block exactly?  This approach that Neil's come
> up with seems like a reasonable solution to me.  Christoph gets his
> separation and /proc/self/mountinfo, and we avoid the scalability headache
> of a billion super blocks.  Thanks,

AFAICS, we also get arseloads of weird corner cases - in particular, Neil's
suggestions re visibility in /proc/mounts look rather arbitrary.

Al, really disliking the entire series...
