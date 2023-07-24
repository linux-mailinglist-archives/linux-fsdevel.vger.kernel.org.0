Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0775F607
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGXMST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXMSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FCA170D;
        Mon, 24 Jul 2023 05:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A55C61124;
        Mon, 24 Jul 2023 12:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE84DC433C7;
        Mon, 24 Jul 2023 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690201064;
        bh=QrEpSq7cPtZ3cWIhHPElPK38cx6jwtPbdBU+j7U7fKM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lFo5/uyfnIZhAXSNnfYH/zs0wLPvsdGmMHFPu1gPwZUyuOP10nfFnm2e23E9mVHox
         RPTdsfQNauiU49m1hBahLSzV9+gtG/J7umAiMCAj2AameE5Kr8rrBCOJ9W6HPjIMkc
         lBp1NfEAIBufJmTKwy4+ZdRStOdLezK2HhFQXgRbYXDnNec/zH0oZOEiZUwOk3URR0
         CwbOA3I9uES6cdgV2JXRUz8O/MvIwDzgSFlH2Jg5PAfwuqtmwK87bHc16vNtVYlbJG
         hfzmJLudml4J90E2WDeTwJcjuLZaZewiSQ45z8+KBeEkpGI5axaDFLzZmilBUDvalQ
         cGU58i/dTyQGA==
Message-ID: <01e8445d033314b6d9cd67bece74ca1c3ce89945.camel@kernel.org>
Subject: Re: [PATCH v2 34/47] nfsd: dynamically allocate the nfsd-client
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
Date:   Mon, 24 Jul 2023 08:17:39 -0400
In-Reply-To: <20230724094354.90817-35-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
         <20230724094354.90817-35-zhengqi.arch@bytedance.com>
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
> dynamically allocate the nfsd-client shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct nfsd_net.
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  fs/nfsd/netns.h     |  2 +-
>  fs/nfsd/nfs4state.c | 20 ++++++++++++--------
>  2 files changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ec49b200b797..f669444d5336 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -195,7 +195,7 @@ struct nfsd_net {
>  	int			nfs4_max_clients;
> =20
>  	atomic_t		nfsd_courtesy_clients;
> -	struct shrinker		nfsd_client_shrinker;
> +	struct shrinker		*nfsd_client_shrinker;
>  	struct work_struct	nfsd_shrinker_work;
>  };
> =20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3339177f8e2f..c7a4616cd866 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4388,8 +4388,7 @@ static unsigned long
>  nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
>  {
>  	int count;
> -	struct nfsd_net *nn =3D container_of(shrink,
> -			struct nfsd_net, nfsd_client_shrinker);
> +	struct nfsd_net *nn =3D shrink->private_data;
> =20
>  	count =3D atomic_read(&nn->nfsd_courtesy_clients);
>  	if (!count)
> @@ -8125,12 +8124,17 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>  	get_net(net);
> =20
> -	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> -	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> -	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> -
> -	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
> +	nn->nfsd_client_shrinker =3D shrinker_alloc(0, "nfsd-client");
> +	if (!nn->nfsd_client_shrinker)
>  		goto err_shrinker;
> +
> +	nn->nfsd_client_shrinker->scan_objects =3D nfsd4_state_shrinker_scan;
> +	nn->nfsd_client_shrinker->count_objects =3D nfsd4_state_shrinker_count;
> +	nn->nfsd_client_shrinker->seeks =3D DEFAULT_SEEKS;
> +	nn->nfsd_client_shrinker->private_data =3D nn;
> +
> +	shrinker_register(nn->nfsd_client_shrinker);
> +
>  	return 0;
> =20
>  err_shrinker:
> @@ -8228,7 +8232,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	struct list_head *pos, *next, reaplist;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	unregister_shrinker(&nn->nfsd_client_shrinker);
> +	shrinker_unregister(nn->nfsd_client_shrinker);
>  	cancel_work(&nn->nfsd_shrinker_work);
>  	cancel_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);

Acked-by: Jeff Layton <jlayton@kernel.org>
