Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8F77E101
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbjHPMB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244996AbjHPMBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B8212F;
        Wed, 16 Aug 2023 05:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 418E26462D;
        Wed, 16 Aug 2023 12:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D86C433C8;
        Wed, 16 Aug 2023 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692187266;
        bh=Pb0d/ohOr7ZsXWGoLDTywgG8gzReqdhiZyJIxKsg+sA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jzZTu9EhKV96gQHj5N/L+fmgty4Ibpjy5MPQYRMzbM3oBoGLyoAJoRcpOdQSA88jQ
         dqwsu6LfCpU9xhJeLBUqne9SXWvsRLMvHNj7zGgZ46SisUz7WhIFvM6DLk6XeMVGmq
         6C5poMz2enrXeNd/m/OdsxfI7F7Ywgjk3L+8OpGHRYZezUxIp5Ulz8FkrY/0+ZoRQP
         xEbB3uhA0mlz+UH/OMz4xyFhE+5/Qk1i0kjI3Z72P9F225eew1kDEJq/XET11UPGLq
         2G5TkEP55JuxgeJhEqFx4cj2+hKr1R2+SeixcVFZ/A0gnIENhgAUX/u2qaju1k+yvI
         m9fEkAXtdOIfw==
Message-ID: <ca18531b54306d27218daf8e90b72ef3a4b8e44f.camel@kernel.org>
Subject: Re: [RFCv2 4/7] locks: update lock callback documentation
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Wed, 16 Aug 2023 08:01:04 -0400
In-Reply-To: <20230814211116.3224759-5-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-5-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> This patch updates the existing documentation regarding recent changes
> to vfs_lock_file() and lm_grant() is set. In case of lm_grant() is set
> we only handle FILE_LOCK_DEFERRED in case of FL_SLEEP in fl_flags is not
> set. This is the case of an blocking lock request. Non-blocking lock
> requests, when FL_SLEEP is not set, are handled in a synchronized way.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/locks.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index df8b26a42524..a8e51f462b43 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2255,21 +2255,21 @@ int fcntl_getlk(struct file *filp, unsigned int c=
md, struct flock *flock)
>   * To avoid blocking kernel daemons, such as lockd, that need to acquire=
 POSIX
>   * locks, the ->lock() interface may return asynchronously, before the l=
ock has
>   * been granted or denied by the underlying filesystem, if (and only if)
> - * lm_grant is set. Callers expecting ->lock() to return asynchronously
> - * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and o=
nly if)
> - * the request is for a blocking lock. When ->lock() does return asynchr=
onously,
> - * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the loc=
k
> - * request completes.
> - * If the request is for non-blocking lock the file system should return
> - * FILE_LOCK_DEFERRED then try to get the lock and call the callback rou=
tine
> - * with the result. If the request timed out the callback routine will r=
eturn a
> + * lm_grant and FL_SLEEP in fl_flags is set. Callers expecting ->lock() =
to return
> + * asynchronously will only use F_SETLK, not F_SETLKW; When ->lock() doe=
s return

Isn't the above backward? Shouldn't it say "Callers expecting ->lock()
to return asynchronously will only use F_SETLKW, not F_SETLK" ?

> + * asynchronously, it must return FILE_LOCK_DEFERRED, and call ->lm_gran=
t() when
> + * the lock request completes. The lm_grant() callback must be called in=
 a
> + * sleepable context.
> + *
> + * If the request timed out the ->lm_grant() callback routine will retur=
n a
>   * nonzero return code and the file system should release the lock. The =
file
> - * system is also responsible to keep a corresponding posix lock when it
> - * grants a lock so the VFS can find out which locks are locally held an=
d do
> - * the correct lock cleanup when required.
> - * The underlying filesystem must not drop the kernel lock or call
> - * ->lm_grant() before returning to the caller with a FILE_LOCK_DEFERRED
> - * return code.
> + * system is also responsible to keep a corresponding posix lock when it=
 grants
> + * a lock so the VFS can find out which locks are locally held and do th=
e correct
> + * lock cleanup when required.
> + *
> + * If the request is for non-blocking lock (when F_SETLK and FL_SLEEP in=
 fl_flags is not set)
> + * the file system should return -EAGAIN if failed to acquire or zero if=
 acquiring was
> + * successfully without calling the ->lm_grant() callback routine.
>   */
>  int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock =
*fl, struct file_lock *conf)
>  {

--=20
Jeff Layton <jlayton@kernel.org>
