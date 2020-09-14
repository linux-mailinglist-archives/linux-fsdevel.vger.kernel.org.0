Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1912699BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 01:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgINXd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 19:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgINXd1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:33:27 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729A220735;
        Mon, 14 Sep 2020 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600126407;
        bh=pa4MhoNm/allYsc8zxU7EzLJRPmBPmP07DiZTOhidlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQcpoqxrhWwnEoZKJ3Hma0m3gD/1P7roqZxrOkccwe0gsITpyWY53oRJN2yCDk60d
         rtyC0jf0FomFN/4NZ1ewP7lBQrszZ1wj3WwZAXYEYg60ipMVMOwxreBU1p56/jyIlY
         NC5aYSEj5p7ow8bcUKjQtRddpdjQi9Smqu6Hgxhw=
Date:   Mon, 14 Sep 2020 16:33:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 01/16] vfs: export new_inode_pseudo
Message-ID: <20200914233326.GA899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-2-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:52PM -0400, Jeff Layton wrote:
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

I'd still like to see an explanation for why ilookup5() shouldn't be fixed
instead.

- Eric
