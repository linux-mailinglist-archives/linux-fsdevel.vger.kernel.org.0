Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF77764FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjG0Jah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjG0JaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:30:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBB9AA1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:20:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-682ae5d4184so182996b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690449603; x=1691054403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cb79b5va6gFfSJneJi5lY4rGeRwgOukMupryAUVW6kI=;
        b=YCWSTu9U7oWMIxlz666y2QG523oA3QX5qQv7ZytrRVu6fJw8dRHyUfgDIT1gU69FG8
         THUguZfsi1KeJApNPmw0jxmv7f8KFlV4UTxlH9XbeulHxoa/ldWA269gxLsqPd7fsDUL
         3wrs7fjkTjLEvVIuFKVgIWoEr+OE7ZGV4f2QptD03saCT0x1g+4lQFRHQ9ruqft2Rhft
         lQsKff8YPeqYMpcr6auHVhvyZ4A0b6O2v3t87pxn8FkR9lCy8v/ntqGuUNKm9Zf3rtD1
         Pt/WGCyBPHzJX+fw7G8Ac9jWyGkR4LQhg8QoLvoZwbFMr8CqGaDCh/cUGTEJkXif0gLU
         NqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449603; x=1691054403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb79b5va6gFfSJneJi5lY4rGeRwgOukMupryAUVW6kI=;
        b=cFZBt7Is/ZgiuDNRSw+xJiNZjfj6BTH49ecS6vM1DSTi5NsZ8ZvIRJNYGZ+WywzkjL
         FG7m67M78LF5EmbGs4OXPvqotdAB7aMBjpb9EpQ9okbKonlCcFE9iYxK6BGmtpc2/twz
         kZjPOJ4zh1NPJeaCEWT5ckL+DiUPb/LbjXVJi/cKnkKzAKNEq8YGjCRUwljTgIewWSaq
         Oq2ITeYD/hvw03EIpLDrheRztM+5Te6CRaGobw6FFfxRKvVTyvZYuo1E3epW58/P88dI
         CzI2VtemAVjCoUTv0ODgEa/VZkSPoytmbdRwdSax9owIQhRl7//IXZPNAQXWC1+BoUrh
         EGMQ==
X-Gm-Message-State: ABy/qLZGE8n3nYuVPAXy75oC9R+WwnFXMV1oAiAdC4xCuic0B0iGL5+I
        g4ycfCFcMLg0024VJcMnzpprqg==
X-Google-Smtp-Source: APBJJlH+dm0mCsob/js+yZXnXAfwEH4KDToex0aS0MQ56gbjyJxo+xxDZzOa2lZ9gy3mjvwdmWQa2g==
X-Received: by 2002:a17:902:da82:b0:1b8:811:b079 with SMTP id j2-20020a170902da8200b001b80811b079mr5785873plx.0.1690449602958;
        Thu, 27 Jul 2023 02:20:02 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001bbb7d8fff2sm1109046plg.116.2023.07.27.02.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:20:02 -0700 (PDT)
Message-ID: <5f1b85b8-3655-1700-4d16-fa056b31ceeb@bytedance.com>
Date:   Thu, 27 Jul 2023 17:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 40/49] xfs: dynamically allocate the xfs-qm shrinker
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
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
        Muchun Song <songmuchun@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-41-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-41-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/27 16:04, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the xfs-qm shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct xfs_quotainfo.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   fs/xfs/xfs_qm.c | 26 +++++++++++++-------------
>   fs/xfs/xfs_qm.h |  2 +-
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 6abcc34fafd8..032f0a208bd2 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -504,8 +504,7 @@ xfs_qm_shrink_scan(
>   	struct shrinker		*shrink,
>   	struct shrink_control	*sc)
>   {
> -	struct xfs_quotainfo	*qi = container_of(shrink,
> -					struct xfs_quotainfo, qi_shrinker);
> +	struct xfs_quotainfo	*qi = shrink->private_data;
>   	struct xfs_qm_isolate	isol;
>   	unsigned long		freed;
>   	int			error;
> @@ -539,8 +538,7 @@ xfs_qm_shrink_count(
>   	struct shrinker		*shrink,
>   	struct shrink_control	*sc)
>   {
> -	struct xfs_quotainfo	*qi = container_of(shrink,
> -					struct xfs_quotainfo, qi_shrinker);
> +	struct xfs_quotainfo	*qi = shrink->private_data;
>   
>   	return list_lru_shrink_count(&qi->qi_lru, sc);
>   }
> @@ -680,16 +678,18 @@ xfs_qm_init_quotainfo(
>   	if (XFS_IS_PQUOTA_ON(mp))
>   		xfs_qm_set_defquota(mp, XFS_DQTYPE_PROJ, qinf);
>   
> -	qinf->qi_shrinker.count_objects = xfs_qm_shrink_count;
> -	qinf->qi_shrinker.scan_objects = xfs_qm_shrink_scan;
> -	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
> -	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
> -
> -	error = register_shrinker(&qinf->qi_shrinker, "xfs-qm:%s",
> -				  mp->m_super->s_id);
> -	if (error)
> +	qinf->qi_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "xfs-qm:%s",
> +					   mp->m_super->s_id);
> +	if (!qinf->qi_shrinker)

Here should set error to -ENOMEM, will fix.

>   		goto out_free_inos;
>   
> +	qinf->qi_shrinker->count_objects = xfs_qm_shrink_count;
> +	qinf->qi_shrinker->scan_objects = xfs_qm_shrink_scan;
> +	qinf->qi_shrinker->seeks = DEFAULT_SEEKS;
> +	qinf->qi_shrinker->private_data = qinf;
> +
> +	shrinker_register(qinf->qi_shrinker);
> +
>   	return 0;
>   
>   out_free_inos:
> @@ -718,7 +718,7 @@ xfs_qm_destroy_quotainfo(
>   	qi = mp->m_quotainfo;
>   	ASSERT(qi != NULL);
>   
> -	unregister_shrinker(&qi->qi_shrinker);
> +	shrinker_free(qi->qi_shrinker);
>   	list_lru_destroy(&qi->qi_lru);
>   	xfs_qm_destroy_quotainos(qi);
>   	mutex_destroy(&qi->qi_tree_lock);
> diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
> index 9683f0457d19..d5c9fc4ba591 100644
> --- a/fs/xfs/xfs_qm.h
> +++ b/fs/xfs/xfs_qm.h
> @@ -63,7 +63,7 @@ struct xfs_quotainfo {
>   	struct xfs_def_quota	qi_usr_default;
>   	struct xfs_def_quota	qi_grp_default;
>   	struct xfs_def_quota	qi_prj_default;
> -	struct shrinker		qi_shrinker;
> +	struct shrinker		*qi_shrinker;
>   
>   	/* Minimum and maximum quota expiration timestamp values. */
>   	time64_t		qi_expiry_min;
