Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A22235794F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 03:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhDHBIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 21:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDHBIw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EA0F6120E;
        Thu,  8 Apr 2021 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617844122;
        bh=QjkFY+l5wn3GUhVqJI0anCYKLcqIOd0bnNKDsilicic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lp0VFICpNh3zEQ+6/iGFNgHlh1oIOHXk06str6pYnqJtA6Vl0ZSCF5Fqk+IBlnfg0
         yoImgC7/lVqaFS48uKP7CPQf2++3xLftFNWni0j+qSAW871Xz6IvQLja7REEIXJzT/
         R/Dw+pq5UN3ynA7MqtGTpxvvgURpDa0vmx6N2mFpc2Yh4LPkGnKbiDMhuZuSmtWZRv
         qR0yDR+VopVAZioKzCN4sNEWIwvMOwTnca+V4eV3ppfcEpJFmNPIJgseJqedfWCV6w
         wqFmy/nU9JY6AiBT9aE9NJ3T1NkSz+uKj+ZamOfz5S9xc1oWBeEMPS8ZYbl3BzOMXb
         Kg6XoLPmyDOpw==
Date:   Wed, 7 Apr 2021 18:08:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v5 01/19] vfs: export new_inode_pseudo
Message-ID: <YG5XmL9+ofqnOuzg@gmail.com>
References: <20210326173227.96363-1-jlayton@kernel.org>
 <20210326173227.96363-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326173227.96363-2-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:32:09PM -0400, Jeff Layton wrote:
> Ceph needs to be able to allocate inodes ahead of a create that might
> involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> but it puts the inode on the sb->s_inodes list and when we go to hash
> it, that might be done again.
> 
> We could work around that by setting I_CREATING on the new inode, but
> that causes ilookup5 to return -ESTALE if something tries to find it
> before I_NEW is cleared. To work around all of this, just use
> new_inode_pseudo which doesn't add it to the list.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

IIRC, this looked like a bug in ilookup5().  Did you come to the conclusion that
it's not actually a bug?

- Eric
