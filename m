Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6177E22D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbjHPNHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 09:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbjHPNHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CB226BB;
        Wed, 16 Aug 2023 06:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26610650CB;
        Wed, 16 Aug 2023 13:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A717C433C8;
        Wed, 16 Aug 2023 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692191251;
        bh=TcFs5d6rH94HoGFHxZ/mD1S+yBgNvkwL72WMLLiiWEk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IEzhoZf3sXjEIuN9AeqIHM+4ILl+0V6KmGu2Q6CH9UmtpTQH5/d9EuwtauFF9cPt0
         FrxlsyQ6Cqzb8Gt9tADd+AdNkSKefIj8tTGEIDuz2z64V6kTL/Uu3mxeM9yJzrkkgE
         qCNn/+PvogsvKLKlXYnA8yp8uz1eFLtO9fakcEM7IqUa3J5ty9HiC10nxR8uPtzSZT
         A8nY82Ui3j6DVJWA8C9O7buZXR4/iVJ9HZqOFO8WYplX86UVNtefFYtXe3+BKYhPUZ
         DxXQXzLWWajgBX2LMSm2+wFKpOsy91e3HTA/kD6Xw3/U1Htggpo1Bx7PMGV/QxzUKT
         Dsd/ZkH2Vhb/Q==
Message-ID: <bd76489a6b0d2f56f4a68d48b3736fcaf5b5119b.camel@kernel.org>
Subject: Re: [RFCv2 6/7] dlm: use FL_SLEEP to check if blocking request
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Wed, 16 Aug 2023 09:07:29 -0400
In-Reply-To: <20230814211116.3224759-7-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-7-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> This patch uses the FL_SLEEP flag in struct file_lock to check if it's a
> blocking request in case if the request coming from nfs lockd process
> indicated by lm_grant() is set.
>=20
> IF FL_SLEEP is set a asynchronous blocking request is being made and
> it's waiting for lm_grant() callback being called to signal the lock was
> granted. If it's not set a synchronous non-blocking request is being made=
.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 0094fa4004cc..524771002a2f 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -140,7 +140,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  	op->info.optype		=3D DLM_PLOCK_OP_LOCK;
>  	op->info.pid		=3D fl->fl_pid;
>  	op->info.ex		=3D (fl->fl_type =3D=3D F_WRLCK);
> -	op->info.wait		=3D IS_SETLKW(cmd);
>  	op->info.fsid		=3D ls->ls_global_id;
>  	op->info.number		=3D number;
>  	op->info.start		=3D fl->fl_start;
> @@ -148,24 +147,31 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 =
number, struct file *file,
>  	op->info.owner =3D (__u64)(long)fl->fl_owner;
>  	/* async handling */
>  	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
> -		op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> -		if (!op_data) {
> -			dlm_release_plock_op(op);
> -			rv =3D -ENOMEM;
> -			goto out;
> -		}
> +		if (fl->fl_flags & FL_SLEEP) {
> +			op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> +			if (!op_data) {
> +				dlm_release_plock_op(op);
> +				rv =3D -ENOMEM;
> +				goto out;
> +			}
> =20
> -		op_data->callback =3D fl->fl_lmops->lm_grant;
> -		locks_init_lock(&op_data->flc);
> -		locks_copy_lock(&op_data->flc, fl);
> -		op_data->fl		=3D fl;
> -		op_data->file	=3D file;
> +			op->info.wait =3D 1;
> +			op_data->callback =3D fl->fl_lmops->lm_grant;
> +			locks_init_lock(&op_data->flc);
> +			locks_copy_lock(&op_data->flc, fl);
> +			op_data->fl		=3D fl;
> +			op_data->file	=3D file;
> =20
> -		op->data =3D op_data;
> +			op->data =3D op_data;
> =20
> -		send_op(op);
> -		rv =3D FILE_LOCK_DEFERRED;
> -		goto out;
> +			send_op(op);
> +			rv =3D FILE_LOCK_DEFERRED;
> +			goto out;

A question...we're returning FILE_LOCK_DEFERRED after the DLM request is
sent. If it ends up being blocked, what happens? Does it do a lm_grant
downcall with -EAGAIN or something as the result?


> +		} else {
> +			op->info.wait =3D 0;
> +		}
> +	} else {
> +		op->info.wait =3D IS_SETLKW(cmd);
>  	}
> =20
>  	send_op(op);

Looks reasonable overall.

Now that I look, we have quite a number of places in the kernel that
seem to check for F_SETLKW, when what they really want is to check
FL_SLEEP.
--=20
Jeff Layton <jlayton@kernel.org>
