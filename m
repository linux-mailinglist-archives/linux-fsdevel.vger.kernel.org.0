Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A02609A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 06:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIHEn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 00:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgIHEn6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:43:58 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D63021532;
        Tue,  8 Sep 2020 04:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599540238;
        bh=YlrbRRJjo9+DiL15NLQOku8CoFU0kva2s6Tp0xDVGNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnXhU478I0Pe8kFUz5he8hbJIdujaxDuD542Wxf6bt9E9UQYgUwf0DpcMMkXF0m6R
         RyVPJ4xy8yCUtlEpXQkr2M4kc1vx4ZkaeljLU0no7JGdIHIWD8Mb5MQUrWdz48G7at
         65Vo7ux6/Jf96Y0lGKBVmZsIPUehQcxrKI6omz+s=
Date:   Mon, 7 Sep 2020 21:43:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/18] ceph: add routine to create context prior
 to RPC
Message-ID: <20200908044356.GJ68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-12-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-12-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:30PM -0400, Jeff Layton wrote:
> After pre-creating a new inode, do an fscrypt prepare on it, fetch a
> new encryption context and then marshal that into the security context
> to be sent along with the RPC.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/crypto.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/crypto.h |  8 ++++++
>  fs/ceph/inode.c  | 10 ++++++--
>  fs/ceph/super.h  |  3 +++
>  4 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 22a09d422b72..f4849f8b32df 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -67,3 +67,66 @@ int ceph_fscrypt_set_ops(struct super_block *sb)
>  	}
>  	return 0;
>  }
> +
> +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> +				 struct ceph_acl_sec_ctx *as)
> +{
> +	int ret, ctxsize;
> +	size_t name_len;
> +	char *name;
> +	struct ceph_pagelist *pagelist = as->pagelist;
> +	bool encrypted = false;
> +
> +	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
> +	if (ret)
> +		return ret;
> +	if (!encrypted)
> +		return 0;
> +
> +	inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);

This is a new inode, so 'inode->i_flags |= S_ENCRYPTED' would be sufficient.

> +
> +	/* No need to set context for dummy encryption */
> +	if (fscrypt_get_dummy_context(inode->i_sb))
> +		return 0;

This isn't correct.  When test_dummy_encryption causes a new inode to be
automatically encrypted, the inode's encryption context is still supposed to be
saved to disk.

Also, when the filesystem is mounted with test_dummy_encryption, there may
already be existing encrypted directories that were created via the regular path
(not via test_dummy_encryption).  Those should keep working as expected.  That
likewise requires saving new encryption contexts to disk.

- Eric
