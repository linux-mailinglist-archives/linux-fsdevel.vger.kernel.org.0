Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CD3C3FD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 01:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhGKXCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 19:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhGKXCv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 19:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B89D61008;
        Sun, 11 Jul 2021 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626044404;
        bh=I4vAZy8a2LCjua+472w8/bDPFLa2CFeyXjUriI/0zpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOzRq3/1n3vBV4sO/ggfFiqjHD5maYQ4mooLBTvSu6gkZExbZ6RDrHUaSBBcXfnIE
         bstUqhdvmgO0azplMElWlxHxQCT6XzqeUFSUkivc1cXL95tM30gGrLxOZbGY34W6jd
         3WBLZkZqfRBioBDUo/JzH0hx47dnEIYJy0H8KWNe2ot+Ku9mo0CHMFLpd0QiP5vAtO
         Nv/LhixmFguiaxVA+ULBoe0jdudxi0uALbr6FXSrSGu2XUcBSG0z+djYaPsizWdVB4
         8Vl//mQNaX0Zz5ytQSrswlItmSDJ+o1EHLq0VHJ2UukXkYw4++zrTbZ9tdWhdRgbu5
         xbUASkCT9AVJQ==
Date:   Sun, 11 Jul 2021 18:00:01 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 07/24] ceph: add fscrypt_* handling to caps.c
Message-ID: <YOt38ayEMpECKQeP@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625135834.12934-8-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:58:17AM -0400, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/caps.c | 62 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 038f59cc4250..1be6c5148700 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -13,6 +13,7 @@
>  #include "super.h"
>  #include "mds_client.h"
>  #include "cache.h"
> +#include "crypto.h"
>  #include <linux/ceph/decode.h>
>  #include <linux/ceph/messenger.h>
>  
> @@ -1229,15 +1230,12 @@ struct cap_msg_args {
>  	umode_t			mode;
>  	bool			inline_data;
>  	bool			wake;
> +	u32			fscrypt_auth_len;
> +	u32			fscrypt_file_len;
> +	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
> +	u8			fscrypt_file[sizeof(u64)]; // for size
>  };

The naming of these is confusing to me.  If these are the fscrypt context and
the original file size, why aren't they called something like fscrypt_context
and fscrypt_file_size?

Also does the file size really need to be variable-length, or could it just be a
64-bit integer?

- Eric
