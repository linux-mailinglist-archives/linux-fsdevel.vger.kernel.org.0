Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D1260900
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 05:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgIHDiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 23:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHDiV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:38:21 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1158B2075A;
        Tue,  8 Sep 2020 03:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599536301;
        bh=BanmiEvbGMWVIhkeYXUdmPe/vH8P2n26h9sXyKtB4E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Y3vXWeVFofFzu+GH1t0rVmNIMeav5M/KvIEqsAOXfrQ4y6Qmvi+uwQpNRjKER/lj
         +tG4kb+LIZgfYCWoDI4majUE1eoNE/Y6ahIKRFDNR9AzH7+GUUCGA3m0MMGFklomVn
         bOBl4FWNCKdfiOWw3r5HbyCbPIuAaFzuiCrXGeBw=
Date:   Mon, 7 Sep 2020 20:38:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
Message-ID: <20200908033819.GD68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-2-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:20PM -0400, Jeff Layton wrote:
> Ceph needs to be able to allocate inodes ahead of a create that might
> involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> but it puts the inode on the sb->s_inodes list, and we don't want to
> do that until we're ready to insert it into the hash.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c347afb7..61554c2477ab 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -935,6 +935,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
>  	}
>  	return inode;
>  }
> +EXPORT_SYMBOL(new_inode_pseudo);
>  

What's the problem with putting the new inode on sb->s_inodes already?
That's what all the other filesystems do.

- Eric
