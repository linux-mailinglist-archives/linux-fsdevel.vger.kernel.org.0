Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6177E104
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbjHPMCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244332AbjHPMCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CA2121;
        Wed, 16 Aug 2023 05:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7FE66516;
        Wed, 16 Aug 2023 12:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34A1C433C7;
        Wed, 16 Aug 2023 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692187326;
        bh=bPSe5IM/8M5PzJcNi04fRp5ZtHKMSMHf6BrSqbBj+hA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VUK+HdQpZJ3/zCd3JBfL8Qu+NKzuHY4lJvco3yGhvaIqqsrchCHvAsTf8ZjTMdJNg
         eRHEIFuUFAdFjBmY10chL3hDCQhWl1RAQonRmqzzp7zgQqIs6zz6UNLWbRu8zkVDJr
         xYbkkh16m0c3BQMyn1tG1Lz4e/N6aasjNlYzTB5uO97DRwTNmiw+ZkUo5f3+QU8p4E
         ChPtv/DNWStHjkRKGIwEIxxL1IJ+R0IAt/DocO4NjP2BFGplE1yUS/yIEkohZXWThM
         0KkCNWXPXv3DzvEngezcACammM+9XMt2JA6pTtZzoW2mfrYuAWGc02YVCgnWoNBx85
         A2xShQ0mY7LWA==
Message-ID: <527071b5b9620fee6b6c2cbf2efe8381e48f778d.camel@kernel.org>
Subject: Re: [RFCv2 5/7] dlm: use fl_owner from lockd
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Wed, 16 Aug 2023 08:02:04 -0400
In-Reply-To: <20230814211116.3224759-6-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-6-aahringo@redhat.com>
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

On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> This patch is changing the fl_owner value in case of an nfs lock request
> to not be the pid of lockd. Instead this patch changes it to be the
> owner value that nfs is giving us.
>=20
> Currently there exists proved problems with this behaviour. One nfsd
> server was created to export a gfs2 filesystem mount. Two nfs clients
> doing a nfs mount of this export. Those two clients should conflict each
> other operating on the same nfs file.
>=20
> A small test program was written:
>=20
> int main(int argc, const char *argv[])
> {
> 	struct flock fl =3D {
> 		.l_type =3D F_WRLCK,
> 		.l_whence =3D SEEK_SET,
> 		.l_start =3D 1L,
> 		.l_len =3D 1L,
> 	};
> 	int fd;
>=20
> 	fd =3D open("filename", O_RDWR | O_CREAT, 0700);
> 	printf("try to lock...\n");
> 	fcntl(fd, F_SETLKW, &fl);
> 	printf("locked!\n");
> 	getc(stdin);
>=20
> 	return 0;
> }
>=20
> Running on both clients at the same time and don't interrupting by
> pressing any key. It will show that both clients are able to acquire the
> lock which shouldn't be the case. The issue is here that the fl_owner
> value is the same and the lock context of both clients should be
> separated.
>=20
> This patch lets lockd define how to deal with lock contexts and chose
> hopefully the right fl_owner value. A test after this patch was made and
> the locks conflicts each other which should be the case.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 00e1d802a81c..0094fa4004cc 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -145,6 +145,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  	op->info.number		=3D number;
>  	op->info.start		=3D fl->fl_start;
>  	op->info.end		=3D fl->fl_end;
> +	op->info.owner =3D (__u64)(long)fl->fl_owner;
>  	/* async handling */
>  	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
>  		op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> @@ -154,9 +155,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  			goto out;
>  		}
> =20
> -		/* fl_owner is lockd which doesn't distinguish
> -		   processes on the nfs client */
> -		op->info.owner	=3D (__u64) fl->fl_pid;
>  		op_data->callback =3D fl->fl_lmops->lm_grant;
>  		locks_init_lock(&op_data->flc);
>  		locks_copy_lock(&op_data->flc, fl);
> @@ -168,8 +166,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  		send_op(op);
>  		rv =3D FILE_LOCK_DEFERRED;
>  		goto out;
> -	} else {
> -		op->info.owner	=3D (__u64)(long) fl->fl_owner;
>  	}
> =20
>  	send_op(op);
> @@ -326,10 +322,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64=
 number, struct file *file,
>  	op->info.number		=3D number;
>  	op->info.start		=3D fl->fl_start;
>  	op->info.end		=3D fl->fl_end;
> -	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
> -		op->info.owner	=3D (__u64) fl->fl_pid;
> -	else
> -		op->info.owner	=3D (__u64)(long) fl->fl_owner;
> +	op->info.owner =3D (__u64)(long)fl->fl_owner;
> =20
>  	if (fl->fl_flags & FL_CLOSE) {
>  		op->info.flags |=3D DLM_PLOCK_FL_CLOSE;
> @@ -389,7 +382,7 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 =
number, struct file *file,
>  	info.number =3D number;
>  	info.start =3D fl->fl_start;
>  	info.end =3D fl->fl_end;
> -	info.owner =3D (__u64)fl->fl_pid;
> +	info.owner =3D (__u64)(long)fl->fl_owner;
> =20
>  	rv =3D do_lock_cancel(&info);
>  	switch (rv) {
> @@ -450,10 +443,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  	op->info.number		=3D number;
>  	op->info.start		=3D fl->fl_start;
>  	op->info.end		=3D fl->fl_end;
> -	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
> -		op->info.owner	=3D (__u64) fl->fl_pid;
> -	else
> -		op->info.owner	=3D (__u64)(long) fl->fl_owner;
> +	op->info.owner =3D (__u64)(long)fl->fl_owner;
> =20
>  	send_op(op);
>  	wait_event(recv_wq, (op->done !=3D 0));

This is the way.

Acked-by: Jeff Layton <jlayton@kernel.org>
