Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17F4205AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 08:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhJDGFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 02:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhJDGFs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 829AC61354;
        Mon,  4 Oct 2021 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633327440;
        bh=lN5kqJ93Mwy7/KpRmTNMH+tJ48+UEfZCHLiuMZDw+SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3tOaxh4rLcgm+CfjO18CGeHdJuSFXClynyxz7LR4JubVC8erzI6ck1++s4rE6b0S
         F482NpimHL77sncT39FY6ZhZgNB94k1vMAoFNOYQ2F/TKC0JBu8yZP0VbgQ7qB3DZP
         rzD5I7l3N/FTB7x6aZksH0ZKTW71gBAuzDM7CIEc=
Date:   Mon, 4 Oct 2021 08:03:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, Tejun Heo <tj@kernel.org>,
        Hou Tao <houtao1@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST,UPDATED PATCH] kernfs: don't create a negative dentry if
 inactive node exists
Message-ID: <YVqZSz3d60IVjpTh@kroah.com>
References: <163330943316.19450.15056895533949392922.stgit@mickey.themaw.net>
 <YVpT4siUyaWcbfQA@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVpT4siUyaWcbfQA@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:07:46AM +0000, Al Viro wrote:
> On Mon, Oct 04, 2021 at 09:03:53AM +0800, Ian Kent wrote:
> > It's been reported that doing stress test for module insertion and
> > removal can result in an ENOENT from libkmod for a valid module.
> > 
> > In kernfs_iop_lookup() a negative dentry is created if there's no kernfs
> > node associated with the dentry or the node is inactive.
> > 
> > But inactive kernfs nodes are meant to be invisible to the VFS and
> > creating a negative dentry for these can have unexpected side effects
> > when the node transitions to an active state.
> > 
> > The point of creating negative dentries is to avoid the expensive
> > alloc/free cycle that occurs if there are frequent lookups for kernfs
> > attributes that don't exist. So kernfs nodes that are not yet active
> > should not result in a negative dentry being created so when they
> > transition to an active state VFS lookups can create an associated
> > dentry is a natural way.
> > 
> > It's also been reported that https://github.com/osandov/blktests.git
> > test block/001 hangs during the test. It was suggested that recent
> > changes to blktests might have caused it but applying this patch
> > resolved the problem without change to blktests.
> 
> Looks sane, but which tree should it go through?  I can pick it, but I've
> no idea if anybody already has kernfs work in their trees...

I can take it, kernfs patches normally go through my tree, can I get an
acked-by?

thanks,

greg k-h
