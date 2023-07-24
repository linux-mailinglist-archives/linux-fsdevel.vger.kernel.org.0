Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203DC75F60E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGXMSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjGXMSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AB1BCB;
        Mon, 24 Jul 2023 05:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3973C6113D;
        Mon, 24 Jul 2023 12:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7639DC433C7;
        Mon, 24 Jul 2023 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690201076;
        bh=SgqvEHTSsoLx88OM4JQmZh6whPE6BGZ/uEOL9QxuZhc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HeauOjdE48WDStWMcmbZe0QJCu1PZbrw2jnOfPPp5Y0n0Q1TK60SYgINluh0tVUHu
         HMa9pGy9YrA2Xid5ZQCkD41aahatrfHq9vVHLjbuzLzQBP/bIUW5s/kQBvStLkPbEr
         52wVvvm4TuW1EIIyQppWxFYEv7SoUq895jOWh1zWA+5Bhuu0CwPKUfnKQ6aPaR+FNu
         w4bgci3LfqcgT2vztkyr4DzF2/4Hyf1LGlp6Z0shJe1d8GJLzPQbDhc3dh09sCIq3l
         N9zzfqaN5HsWy8Vmt4P1E7EQFqQrkFrxcJ7/1W6yEYc3GiEERam+zZN0XSQm/ELIIc
         3urjqaifuO8iw==
Message-ID: <d79d3ef43b3a61be99e53a77fa9eb19af7fc550f.camel@kernel.org>
Subject: Re: [PATCH v2 35/47] nfsd: dynamically allocate the nfsd-reply
 shrinker
From:   Jeff Layton <jlayton@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 24 Jul 2023 08:17:52 -0400
In-Reply-To: <20230724094354.90817-36-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
         <20230724094354.90817-36-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-07-24 at 17:43 +0800, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the nfsd-reply shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct nfsd_net.
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  fs/nfsd/netns.h    |  2 +-
>  fs/nfsd/nfscache.c | 31 ++++++++++++++++---------------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index f669444d5336..ab303a8b77d5 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -177,7 +177,7 @@ struct nfsd_net {
>  	/* size of cache when we saw the longest hash chain */
>  	unsigned int             longest_chain_cachesize;
> =20
> -	struct shrinker		nfsd_reply_cache_shrinker;
> +	struct shrinker		*nfsd_reply_cache_shrinker;
> =20
>  	/* tracking server-to-server copy mounts */
>  	spinlock_t              nfsd_ssc_lock;
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 6eb3d7bdfaf3..9f0ab65e4125 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -200,26 +200,29 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
>  {
>  	unsigned int hashsize;
>  	unsigned int i;
> -	int status =3D 0;
> =20
>  	nn->max_drc_entries =3D nfsd_cache_size_limit();
>  	atomic_set(&nn->num_drc_entries, 0);
>  	hashsize =3D nfsd_hashsize(nn->max_drc_entries);
>  	nn->maskbits =3D ilog2(hashsize);
> =20
> -	nn->nfsd_reply_cache_shrinker.scan_objects =3D nfsd_reply_cache_scan;
> -	nn->nfsd_reply_cache_shrinker.count_objects =3D nfsd_reply_cache_count;
> -	nn->nfsd_reply_cache_shrinker.seeks =3D 1;
> -	status =3D register_shrinker(&nn->nfsd_reply_cache_shrinker,
> -				   "nfsd-reply:%s", nn->nfsd_name);
> -	if (status)
> -		return status;
> -
>  	nn->drc_hashtbl =3D kvzalloc(array_size(hashsize,
>  				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
>  	if (!nn->drc_hashtbl)
> +		return -ENOMEM;
> +
> +	nn->nfsd_reply_cache_shrinker =3D shrinker_alloc(0, "nfsd-reply:%s",
> +						       nn->nfsd_name);
> +	if (!nn->nfsd_reply_cache_shrinker)
>  		goto out_shrinker;
> =20
> +	nn->nfsd_reply_cache_shrinker->scan_objects =3D nfsd_reply_cache_scan;
> +	nn->nfsd_reply_cache_shrinker->count_objects =3D nfsd_reply_cache_count=
;
> +	nn->nfsd_reply_cache_shrinker->seeks =3D 1;
> +	nn->nfsd_reply_cache_shrinker->private_data =3D nn;
> +
> +	shrinker_register(nn->nfsd_reply_cache_shrinker);
> +
>  	for (i =3D 0; i < hashsize; i++) {
>  		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);
>  		spin_lock_init(&nn->drc_hashtbl[i].cache_lock);
> @@ -228,7 +231,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
> =20
>  	return 0;
>  out_shrinker:
> -	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
> +	kvfree(nn->drc_hashtbl);
>  	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
>  	return -ENOMEM;
>  }
> @@ -238,7 +241,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
>  	struct nfsd_cacherep *rp;
>  	unsigned int i;
> =20
> -	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
> +	shrinker_unregister(nn->nfsd_reply_cache_shrinker);
> =20
>  	for (i =3D 0; i < nn->drc_hashsize; i++) {
>  		struct list_head *head =3D &nn->drc_hashtbl[i].lru_head;
> @@ -322,8 +325,7 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct =
nfsd_drc_bucket *b,
>  static unsigned long
>  nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *s=
c)
>  {
> -	struct nfsd_net *nn =3D container_of(shrink,
> -				struct nfsd_net, nfsd_reply_cache_shrinker);
> +	struct nfsd_net *nn =3D shrink->private_data;
> =20
>  	return atomic_read(&nn->num_drc_entries);
>  }
> @@ -342,8 +344,7 @@ nfsd_reply_cache_count(struct shrinker *shrink, struc=
t shrink_control *sc)
>  static unsigned long
>  nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc=
)
>  {
> -	struct nfsd_net *nn =3D container_of(shrink,
> -				struct nfsd_net, nfsd_reply_cache_shrinker);
> +	struct nfsd_net *nn =3D shrink->private_data;
>  	unsigned long freed =3D 0;
>  	LIST_HEAD(dispose);
>  	unsigned int i;

Acked-by: Jeff Layton <jlayton@kernel.org>
