Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08F41BEEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbhI2GGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 02:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243377AbhI2GGv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:06:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AB87613A7;
        Wed, 29 Sep 2021 06:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632895511;
        bh=FND3wJXVv27Y/fHE3N5rucqPfHmjLIp1dM+zsmoLBz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naJVuz7CN/ctGc6J0IajQZP01oeKqqDs8qhyrqU++/Py5Bh25arwf/VTz1sXEgWMA
         HQienZaeqnbNwwIpHE+20+sWxOiHhVSo0vFQtKDtr4+yUny2rvTg3ptRrhTs6yGTyN
         9UC5JdA+XtE8f6NtiL4CBIJpdx1gqTykU61trG/4=
Date:   Wed, 29 Sep 2021 08:05:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Hou Tao <houtao1@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernfs: don't create a negative dentry if inactive node
 exists
Message-ID: <YVQCE3vhK8z33Na2@kroah.com>
References: <163288467430.30015.16308604689059471602.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163288467430.30015.16308604689059471602.stgit@mickey.themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:04:34AM +0800, Ian Kent wrote:
> In kernfs_iop_lookup() a negative dentry is created if there's no kernfs
> node associated with the dentry or the node is inactive.
> 
> But inactive kernfs nodes are meant to be invisible to the VFS and
> creating a negative dentry for these can have unexpected side effects
> when the node transitions to an active state.
> 
> The point of creating negative dentries is to avoid the expensive
> alloc/free cycle that occurs if there are frequent lookups for kernfs
> attributes that don't exist. So kernfs nodes that are not yet active
> should not result in a negative dentry being created so when they
> transition to an active state VFS lookups can create an associated
> dentry is a natural way.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Does this fix a specific commit and need a "Fixes:" tag?

thanks,

greg k-h
