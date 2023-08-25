Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE0788E77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHYSSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjHYSSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00EF26A8;
        Fri, 25 Aug 2023 11:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E2A665FED;
        Fri, 25 Aug 2023 18:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3ECC433C7;
        Fri, 25 Aug 2023 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692987461;
        bh=ZFSONFbkamNWx1s5e5rARFbzmgi/AUlcH7KDB7vG0Lo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GfsZBQqSkGzDuMU+iC17jwkPUe9K+rFqW0i1d0RlonASBJXKsh4HcAIbww1EqSSqt
         24jOnmZJEu4iBeK7GsptKDTuKpIyEwltpmy87Jyk/R8nzrlXB6n1yYX12kt9rTrEEh
         SM1UWx9imY6hyeHj9ROuFMbqw0+e2+8iuq48ToSlCF6HL7DdW8L20zcMInmGhaezYu
         GlScfwNIWFzBZHAa8VPT6dQKe71mJQWj7wPVnpN40U6ba/7RlfwVZpo48OXhcZQsNh
         FWa+/hDuj7nJYp0A2wou4cQ1oIizuLlFPXBzt24h0v/96CAFsBlJtU9LYitzw0hmdW
         CJGuWLOh0JhpQ==
Message-ID: <66276fa17fbe7c9db536b636f5316b6b3a6d9829.camel@kernel.org>
Subject: Re: [PATCH 4/7] lockd: add doc to enable EXPORT_OP_SAFE_ASYNC_LOCK
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Fri, 25 Aug 2023 14:17:38 -0400
In-Reply-To: <20230823213352.1971009-5-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
         <20230823213352.1971009-5-aahringo@redhat.com>
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

On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> This patch adds a note to enable EXPORT_OP_SAFE_ASYNC_LOCK for
> asynchronous lock request handling.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/locks.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index df8b26a42524..edee02d1ca93 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2255,11 +2255,13 @@ int fcntl_getlk(struct file *filp, unsigned int c=
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
> + * lm_grant is set. Additionally EXPORT_OP_SAFE_ASYNC_LOCK in export_ope=
rations
> + * flags need to be set.
> + *
> + * Callers expecting ->lock() to return asynchronously will only use F_S=
ETLK,
> + * not F_SETLKW; they will set FL_SLEEP if (and only if) the request is =
for a
> + * blocking lock. When ->lock() does return asynchronously, it must retu=
rn
> + * FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock request compl=
etes.
>   * If the request is for non-blocking lock the file system should return
>   * FILE_LOCK_DEFERRED then try to get the lock and call the callback rou=
tine
>   * with the result. If the request timed out the callback routine will r=
eturn a

Reviewed-by: Jeff Layton <jlayton@kernel.org>
