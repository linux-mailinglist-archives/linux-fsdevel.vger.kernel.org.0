Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0CD393F05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhE1I5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 04:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhE1I5i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 04:57:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16644610A5;
        Fri, 28 May 2021 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622192164;
        bh=m+ComzkrlyF52OQE+pnXGUScIGVYh7O2OuH8zdu9W74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDCCRU5HFWiz+I3jUPSeKwM8DfVdll0IHMSxpxtu9/3CHWKUx/w1NKrkpwpYDCOZL
         XlKFtAI2v/esjIyh4yIwqP3Kf8aBb5GOzyX1n0InYFGg7ZToYVIs92djaRa4E83dVb
         JbSEi0+Leh9G1OWnbUSImA2WKLA15p6FSzpDlIho=
Date:   Fri, 28 May 2021 10:56:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>, Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST PATCH v4 0/5] kernfs: proposed locking and concurrency
 improvement
Message-ID: <YLCwIfYxM7jYKQxe@kroah.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 28, 2021 at 02:33:42PM +0800, Ian Kent wrote:
> There have been a few instances of contention on the kernfs_mutex during
> path walks, a case on very large IBM systems seen by myself, a report by
> Brice Goglin and followed up by Fox Chen, and I've since seen a couple
> of other reports by CoreOS users.
> 
> The common thread is a large number of kernfs path walks leading to
> slowness of path walks due to kernfs_mutex contention.
> 
> The problem being that changes to the VFS over some time have increased
> it's concurrency capabilities to an extent that kernfs's use of a mutex
> is no longer appropriate. There's also an issue of walks for non-existent
> paths causing contention if there are quite a few of them which is a less
> common problem.
> 
> This patch series is relatively straight forward.
> 
> All it does is add the ability to take advantage of VFS negative dentry
> caching to avoid needless dentry alloc/free cycles for lookups of paths
> that don't exit and change the kernfs_mutex to a read/write semaphore.
> 
> The patch that tried to stay in VFS rcu-walk mode during path walks has
> been dropped for two reasons. First, it doesn't actually give very much
> improvement and, second, if there's a place where mistakes could go
> unnoticed it would be in that path. This makes the patch series simpler
> to review and reduces the likelihood of problems going unnoticed and
> popping up later.
> 
> The patch to use a revision to identify if a directory has changed has
> also been dropped. If the directory has changed the dentry revision
> needs to be updated to avoid subsequent rb tree searches and after
> changing to use a read/write semaphore the update also requires a lock.
> But the d_lock is the only lock available at this point which might
> itself be contended.

Fox, can you take some time and test these to verify it all still works
properly with your benchmarks?

thanks,

greg k-h
