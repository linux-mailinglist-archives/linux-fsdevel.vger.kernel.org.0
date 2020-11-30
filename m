Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9602C8DD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbgK3TQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 14:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388020AbgK3TQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606763713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yG/N1QYbCe2Gv2DEXk2bQ+9lwnJX4uGO5t7uHFM1aMk=;
        b=TtnZpck/Cnx6mycbkYSdi6PbOmjNI4GgPeGRZS/5E0fWpisAhB5O6GoHAtQvklCYKt0+0s
        wiqdIzjzIm0+F2hWE9WXL1vWEltR0gLRlQBXBfsGFmDftw3Wzi1gENNuhqtdd9QwjytOzV
        2+YIZZmpKBPKPqloHjAo6hS6oW47UtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-jGTEpHE7OViaf8TStxy5kg-1; Mon, 30 Nov 2020 14:15:11 -0500
X-MC-Unique: jGTEpHE7OViaf8TStxy5kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7B8E1842146;
        Mon, 30 Nov 2020 19:15:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-55.rdu2.redhat.com [10.10.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA4606086F;
        Mon, 30 Nov 2020 19:15:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2CFDB22054F; Mon, 30 Nov 2020 14:15:09 -0500 (EST)
Date:   Mon, 30 Nov 2020 14:15:09 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 4/4] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
Message-ID: <20201130191509.GC14328@redhat.com>
References: <20201127092058.15117-1-sargun@sargun.me>
 <20201127092058.15117-5-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127092058.15117-5-sargun@sargun.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 01:20:58AM -0800, Sargun Dhillon wrote:
> Volatile remounts validate the following at the moment:
>  * Has the module been reloaded / the system rebooted
>  * Has the workdir been remounted
> 
> This adds a new check for errors detected via the superblock's
> errseq_t. At mount time, the errseq_t is snapshotted to disk,
> and upon remount it's re-verified. This allows for kernel-level
> detection of errors without forcing userspace to perform a
> sync and allows for the hidden detection of writeback errors.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/overlayfs/overlayfs.h | 1 +
>  fs/overlayfs/readdir.c   | 6 ++++++
>  fs/overlayfs/super.c     | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index de694ee99d7c..e8a711953b64 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -85,6 +85,7 @@ struct ovl_volatile_info {
>  	 */
>  	uuid_t		ovl_boot_id;	/* Must stay first member */
>  	u64		s_instance_id;
> +	errseq_t	errseq;	/* Implemented as a u32 */
>  } __packed;
>  
>  /*
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 7b66fbb20261..5795b28bb4cf 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1117,6 +1117,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
>  		return -EINVAL;
>  	}
>  
> +	err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> +	if (err) {
> +		pr_debug("Workdir filesystem reports errors: %d\n", err);
> +		return -EINVAL;
> +	}
> +
>  	return 1;
>  }
>  
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a8ee3ba4ebbd..2e473f8c75dd 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
>  	int err;
>  	struct ovl_volatile_info info = {
>  		.s_instance_id = volatiledir->d_sb->s_instance_id,
> +		.errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),

errse_sample() seems to return 0 if nobody has seen the error yet. That
means on remount we will fail. It is a false failure from our perspective
and we are not interested in knowing if somebody else has seen the
failure or not. 

Maybe we need a flag in errseq_sample() to get us current value
irrespective of the fact whether anybody has seen the error or not?

If we end up making this change, then we probably will have to somehow
mask ERRSEQ_SEEN bit in errseq_check() comparison. Because if we
sampled ->s_wb_err when nobody saw it and later by the remount time
say ERRSEQ_SEEN is set, we don't want remount to fail.

Thanks
Vivek
>  	};
>  
>  	uuid_copy(&info.ovl_boot_id, &ovl_boot_id);
> -- 
> 2.25.1
> 

