Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178249F7B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 11:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347954AbiA1K6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 05:58:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49924 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbiA1K6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:58:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FCF561DFF;
        Fri, 28 Jan 2022 10:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF14CC340E0;
        Fri, 28 Jan 2022 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643367502;
        bh=+zWMkFDrZZM+qbNwpezGJFJ66XZ2aI38VXsj6i5zjVc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n2GH3c7VO+JatCdg0jYNo1RcnnnE6Tof8QDipRbmPk+HfcvlbFNLW3SMyMW3v9xDR
         XvcyPjQ+zoBMaFiIKbF/tqUDjVspc1G6LJwMKY4DtoSJ2KXnm/6PcxgIbMDlaMVZXi
         pb2+obmFd/8+yM0m5/GQrVyAKczJMz9xx29t4vVYf6gfmpiVY+kpqH13W7lmOVz5VY
         VW19GXitDz+VslMV9LqEoIE2wjWWnUmWV9G550P5RpLY/K7VmgePVtnpx7ceTzmX/J
         pQfwOpWyooISOPvAVxAcrCNdf/ZYURJx1w+rki4YAv7LBw6X1mzp5ceEXPFVJWonmp
         lNnYMldKZd+6A==
Message-ID: <e5bee4a3e8a7c860d447fe74d5cf2d1846e8600d.camel@kernel.org>
Subject: Re: [PATCH 0/4] cifs: Use fscache I/O again after the rewrite
 disabled it
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 05:58:20 -0500
In-Reply-To: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
References: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-01-27 at 16:01 +0000, David Howells wrote:
> Hi Steve,
> 
> Here are some patches to make cifs actually do I/O to the cache after it
> got disabled in the fscache rewrite[1] plus a warning fix that you might
> want to detach and take separately:
> 
>  (1) Fix a kernel doc warning.
> 
>  (2) Change cifs from using ->readpages() to using ->readahead().
> 
>  (3) Provide a netfs cache op to query for the presence of data in the
>      cache.[*]
> 
>  (4) Make ->readahead() call
> 
> The patches can be found here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite
> 
> David
> 
> [*] Ideally, we would use the netfslib read helpers, but it's probably better
>     to roll iterators down into cifs's I/O layer before doing that[2].
> 
> Link: https://lore.kernel.org/r/164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk/ [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-experimental [2]
> 
> ---
> David Howells (4):
>       Fix a warning about a malformed kernel doc comment in cifs by removing the
>       cifs: Transition from ->readpages() to ->readahead()
>       netfs, cachefiles: Add a method to query presence of data in the cache
>       cifs: Implement cache I/O by accessing the cache directly
> 
> 
>  Documentation/filesystems/netfs_library.rst |  16 ++
>  fs/cachefiles/io.c                          |  59 ++++++
>  fs/cifs/connect.c                           |   2 +-
>  fs/cifs/file.c                              | 221 ++++++++------------
>  fs/cifs/fscache.c                           | 126 +++++++++--
>  fs/cifs/fscache.h                           |  79 ++++---
>  include/linux/netfs.h                       |   7 +
>  7 files changed, 322 insertions(+), 188 deletions(-)
> 
> 

Acked-by: Jeff Layton <jlayton@kernel.org>
