Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6283A269B48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgIOBhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 21:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgIOBh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:37:26 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FC720731;
        Tue, 15 Sep 2020 01:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600133846;
        bh=aquA0ONaSO3MOJXHCF+s9Vfsa3mVU5Vn5warTyxSUG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdJuUCujC8Y+ZKRU/ZdDVArRdXk13apsWY7XnL6GhNaxfR9OyehmEV0QsdBsPQ55Y
         PU82Fmu6A8JONPDytniFS2QMhG4725S5CMFilKLX7JqPG+ib9X+Jxz4U3grjkALy7I
         0vtaQDWWeJ09bnBevN8CjMumffnyD9L2Za/Dvcxs=
Date:   Mon, 14 Sep 2020 18:37:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 10/16] ceph: add routine to create context prior
 to RPC
Message-ID: <20200915013724.GJ899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-11-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-11-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:17:01PM -0400, Jeff Layton wrote:
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index b5f38ee80553..c1b6ec4b2961 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -11,6 +11,8 @@
>  #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
>  
>  void ceph_fscrypt_set_ops(struct super_block *sb);
> +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> +				 struct ceph_acl_sec_ctx *as);
>  
>  #else /* CONFIG_FS_ENCRYPTION */
>  
> @@ -19,6 +21,12 @@ static inline int ceph_fscrypt_set_ops(struct super_block *sb)
>  	return 0;
>  }
>  
> +static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> +						struct ceph_acl_sec_ctx *as)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_FS_ENCRYPTION */

Seems there should at least be something that prevents you from creating a file
in an encrypted directory when !CONFIG_FS_ENCRYPTION.

The other filesystems use fscrypt_prepare_new_inode() for this; it returns
EOPNOTSUPP when IS_ENCRYPTED(dir).

- Eric
