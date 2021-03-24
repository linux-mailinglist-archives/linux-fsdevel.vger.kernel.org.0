Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AC3472E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 08:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCXHmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 03:42:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33645 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbhCXHmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:42:13 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOy9b-0002Qw-P0; Wed, 24 Mar 2021 07:42:11 +0000
Date:   Wed, 24 Mar 2021 08:42:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] cachefiles: do not yet allow on idmapped mounts
Message-ID: <20210324074211.tojlf25xrano2hps@wittgenstein>
References: <20210319114146.410329-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210319114146.410329-1-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:41:47PM +0100, Christian Brauner wrote:
> Based on discussions (e.g. in [1]) my understanding of cachefiles and
> the cachefiles userspace daemon is that it creates a cache on a local
> filesystem (e.g. ext4, xfs etc.) for a network filesystem. The way this
> is done is by writing "bind" to /dev/cachefiles and pointing it to the
> directory to use as the cache.
> Currently this directory can technically also be an idmapped mount but
> cachefiles aren't yet fully aware of such mounts and thus don't take the
> idmapping into account when creating cache entries. This could leave
> users confused as the ownership of the files wouldn't match to what they
> expressed in the idmapping. Block cache files on idmapped mounts until
> the fscache rework is done and we have ported it to support idmapped
> mounts.
> 
> [1]: https://lore.kernel.org/lkml/20210303161528.n3jzg66ou2wa43qb@wittgenstein
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cachefs@redhat.com
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---

Hey David,

Are you happy with this now, and could I possibly get your Ack on this,
please? And also, are you routing this to Linus (preferably before v5.12
is out) or do you want me to take it?

Christian

> /* v2 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Ensure that "root" is initialized when cleaning up.
> 
> /* v3 */
> - David Howells <dhowells@redhat.com>:
>   - Reformulate commit message to avoid paragraphs with duplicated
>     content.
>   - Add a pr_warn() when cachefiles are supposed to be created on
>     idmapped mounts.
> ---
>  fs/cachefiles/bind.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> index dfb14dbddf51..38bb7764b454 100644
> --- a/fs/cachefiles/bind.c
> +++ b/fs/cachefiles/bind.c
> @@ -118,6 +118,12 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
>  	cache->mnt = path.mnt;
>  	root = path.dentry;
>  
> +	ret = -EINVAL;
> +	if (mnt_user_ns(path.mnt) != &init_user_ns) {
> +		pr_warn("File cache on idmapped mounts not supported");
> +		goto error_unsupported;
> +	}
> +
>  	/* check parameters */
>  	ret = -EOPNOTSUPP;
>  	if (d_is_negative(root) ||
> 
> base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> -- 
> 2.27.0
> 
