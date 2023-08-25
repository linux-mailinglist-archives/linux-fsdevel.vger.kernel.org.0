Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98163788E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjHYSKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjHYSKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99C2685;
        Fri, 25 Aug 2023 11:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B09612A4;
        Fri, 25 Aug 2023 18:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F13C433C7;
        Fri, 25 Aug 2023 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692987033;
        bh=Ecc5LQmwxrnoqI0nQwKZwEUDx8WMKVZsbyFyi1TKItw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gffbYCsI4KQb9MMOrOcTfT4x9IivzcLsyVEzojNa/Z+uDnJQWwlSWRjJ2B1qqun2l
         4LFKx95d7AghNQCb8QJYRnogm1jK/8/18zcjpcvfZJQCPS8d4+H2/BUCnMDsyp/wH+
         qudI/azPK+y6apMrM2EwPdXTeL+SqBalf0og0Dwql4cTZXbXjrhbmaYsCUxDbBW/er
         oiGmEBnzZn74rpLsf64f1NWprTJ1w2D2mKMVXY4gmFr5jc9THh7TdimJNTAq7L2fEj
         1Iweg50bt9vg/gyiTSI814zT18JHq5aTbNspWmBUYiTmtlPv+Nr1knde4xjDbueujf
         z2ks7uXpUyEMA==
Message-ID: <ae36349af354dcf40c29ff1c6bf7d930f08e7115.camel@kernel.org>
Subject: Re: [PATCH 2/7] lockd: don't call vfs_lock_file() for pending
 requests
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Fri, 25 Aug 2023 14:10:30 -0400
In-Reply-To: <20230823213352.1971009-3-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
         <20230823213352.1971009-3-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> This patch returns nlm_lck_blocked in nlmsvc_lock() when an asynchronous
> lock request is pending. During testing I ran into the case with the
> side-effects that lockd is waiting for only one lm_grant() callback
> because it's already part of the nlm_blocked list. If another
> asynchronous for the same nlm_block is triggered two lm_grant()
> callbacks will occur but lockd was only waiting for one.
>=20
> To avoid any change of existing users this handling will only being made
> when export_op_support_safe_async_lock() returns true.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 6e3b230e8317..aa4174fbaf5b 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -531,6 +531,23 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  		goto out;
>  	}
> =20
> +	spin_lock(&nlm_blocked_lock);
> +	/*
> +	 * If this is a lock request for an already pending
> +	 * lock request we return nlm_lck_blocked without calling
> +	 * vfs_lock_file() again. Otherwise we have two pending
> +	 * requests on the underlaying ->lock() implementation but
> +	 * only one nlm_block to being granted by lm_grant().
> +	 */
> +	if (export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> +					      nlmsvc_file_file(file)->f_op) &&
> +	    !list_empty(&block->b_list)) {
> +		spin_unlock(&nlm_blocked_lock);
> +		ret =3D nlm_lck_blocked;
> +		goto out;
> +	}

Looks reasonable. The block->b_list check is subtle, but the comment
helps.

> +	spin_unlock(&nlm_blocked_lock);
> +
>  	if (!wait)
>  		lock->fl.fl_flags &=3D ~FL_SLEEP;
>  	mode =3D lock_to_openmode(&lock->fl);
> @@ -543,13 +560,6 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>  			ret =3D nlm_granted;
>  			goto out;
>  		case -EAGAIN:
> -			/*
> -			 * If this is a blocking request for an
> -			 * already pending lock request then we need
> -			 * to put it back on lockd's block list
> -			 */
> -			if (wait)
> -				break;
>  			ret =3D async_block ? nlm_lck_blocked : nlm_lck_denied;
>  			goto out;
>  		case FILE_LOCK_DEFERRED:


Reviewed-by: Jeff Layton <jlayton@kernel.org>
