Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5A3D7280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhG0KDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 06:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236170AbhG0KCn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:02:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9205D61220;
        Tue, 27 Jul 2021 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627380163;
        bh=MsMayYRx4rdKjycC9Cn2M4QS2CiYgnOqhSGXE5/Tias=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFEx9PxzfT6IBlvp0bqYM1g29NmTfJktSOcqJLhgonliTCaEwBDCMIHayEjzp2G/t
         Y4ajBxrXXaPvbqP+W5obj6yZWF+l2lOvS3nLuLQEs46GOeDiBt1cGJfoktu208q0B3
         hhVsPSfSd4HdQgQsyg8tjvbsEXfuqiu258n/UL+k=
Date:   Tue, 27 Jul 2021 12:02:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/5] kernfs: proposed locking and concurrency
 improvement
Message-ID: <YP/ZwYrtx+h/a/Ez@kroah.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 05:28:13PM +0800, Ian Kent wrote:
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
> Changes since v7:
> - remove extra tab in helper kernfs_dir_changed.
> - fix thinko adding an unnecessary kernfs_inc_rev() in kernfs_rename_ns().

Thanks for sticking with this, I've applied this to my testing branch
and let's see how 0-day does with it :)

greg k-h
