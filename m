Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC6358976
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhDHQST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHQSS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:18:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33B8A610CF;
        Thu,  8 Apr 2021 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617898686;
        bh=ou2UhD5Os/RRXcPf0NOI1ZbCPwmpM8WgP8WJMnC5BsM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DCCC9yDux2rr67KPYtodPYv2w+RSJOBDTke7s0QSEt0PxLK9I3+oz90OQzzMHgbE5
         ixbiEE98++wbGdz6MSS/VqdlgEeXsbT3QKoVrARXUwIu02ZRQwYTkbrYzlji7WjeEn
         C4f7j5zyat6OnBWTJEWPuA0fhcq+YqA9zQ2erGQ4fM0TbUA6UbcuNIZamHPp6PrkUh
         OOTNonI6kkGd1e4FEPKfm55ST34R7g74EXD8PfCYFKd7u5457wwbQty0LP7/4lBPnr
         SVdxtxSKJzrZYg10X4aCbnhVv0dZBOAqf5LCeU6FsjLkEbJsJTnSPt0ej2ceO8RnYo
         ylWOREfJUHJfw==
Message-ID: <a4188c2faa0789b0f04c34a184595d6e79353636.camel@kernel.org>
Subject: Re: [RFC PATCH v5 01/19] vfs: export new_inode_pseudo
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 08 Apr 2021 12:18:05 -0400
In-Reply-To: <YG5XmL9+ofqnOuzg@gmail.com>
References: <20210326173227.96363-1-jlayton@kernel.org>
         <20210326173227.96363-2-jlayton@kernel.org> <YG5XmL9+ofqnOuzg@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-07 at 18:08 -0700, Eric Biggers wrote:
> On Fri, Mar 26, 2021 at 01:32:09PM -0400, Jeff Layton wrote:
> > Ceph needs to be able to allocate inodes ahead of a create that might
> > involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> > but it puts the inode on the sb->s_inodes list and when we go to hash
> > it, that might be done again.
> > 
> > We could work around that by setting I_CREATING on the new inode, but
> > that causes ilookup5 to return -ESTALE if something tries to find it
> > before I_NEW is cleared. To work around all of this, just use
> > new_inode_pseudo which doesn't add it to the list.
> > 
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> IIRC, this looked like a bug in ilookup5().  Did you come to the conclusion that
> it's not actually a bug?
> 

Yes. Al pointed out that it's desirable behavior for most (simpler)
filesystems.

Basically, nothing should have presented the filehandle for this inode
to a client until after I_NEW has been cleared. So, any attempt to look
it up should give you back ESTALE at this point.

I'm not married to this approach however. If there's a better way to do
this, then I'm happy to consider it.
-- 
Jeff Layton <jlayton@kernel.org>

