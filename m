Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD6154437
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBFMpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:45:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:56445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBFMpa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580993110;
        bh=ez91WhxfUHyV706oiN55VIndog+MKdAnI5Q7j0A1lOU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XVi+LZ5VfAzeutldO07W0sTgFUJEUIY5Xr5iVKczBZ9JcYDGEmO0Q8+n+HlxrHhRW
         /hr6RkRmKAnx9ZM/sbTbWhaLRBsI1arWK1sLo6FrUH9kaItOygDvlZxnY+RToqOPI7
         f3wRFoKIGAwAnjrvLiO8tyzi75eQCDAX2rDbNIYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.111] ([34.80.175.37]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1jQnt022NO-00ijNA; Thu, 06
 Feb 2020 13:45:10 +0100
Subject: Re: [PATCH 12/20] btrfs: introduce clustered_alloc_info
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-13-naohiro.aota@wdc.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <c235054d-49b1-28b5-0f3b-d7bc1cecd766@gmx.com>
Date:   Thu, 6 Feb 2020 20:44:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-13-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a9s/XjWc9iTeAo8wFpl3mXPHY3p7UlIkaMuCA1nGK9IRibKlAAv
 YmXS9Gm5RyUMZpLewv6sfAyIc6xYbvrZbfL2p3NAh16I39Ml9yUxtcjfs2akj1IMgr3yns2
 GRt/dMeEhl7kR/i7pEydQi96Pp3oOLRovE2SBXIt9CcIFdG9eC/RZ7e5DgN1WpcOHS9LEOq
 WNAM7ekWtEv/Xy9/GHQCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g/JF3vsoD1A=:guJfHW5wvIWIgtKiqVHlF+
 YHVLhFjK5K13jeRpzriwLiVpyxTXX94WFi5ssPElPLXUKYlLQ8DuwTOz8RI0oVawT8TNqwfjW
 nsoSpfoUhC6HfprTbDz32bu/JRcH7NiXoiMVh7Kssxuxd/ukGdzxfS6jgZ6+qySMwrGZW2m7/
 H9cN3hZBhF2dPvT5HLRHYB43093UWtKqJ65ngSs1UAoAPHCvMqeAq5bsYqRkym33jWS/etIcc
 5AgLqpNSdeT8rRlIGYqMD+Rac82Dh7OQ6I+927iVa5SK7ArYh2gr1ZhPfM1YxK7GqlVNCBI4x
 42reyncfvGvsvAOQAG5n1Ky97L2fe8FQVOpVAeBc4e/S3inH5GDqTzu/eIch36WtILh5Qx7jp
 cHjJimZf+ZSTHH4XgmtZWf26B5QfGV/Q00PGgVf6Kn8aCEtkq/OLIlC/SEHBmin8Tanl+Nqyd
 p5MGSUsBFl75R9dFIAP/JCewbdLG3pGes5iyj69Of3e4r1txfQwSWMSsZGM9yL77/8PZyxKdh
 BSDvw3vD34U8Jco6eJSdqc+XhNTy+5iKnIz7ZdGegNolaNwBtGIJPYOs5cSoujHEht08ApBnk
 TqLA7gyFWZ0hFzMJKCKYbC1M+9u1AwNAs8Z7CQ8zbHjheYkh2/8zyKddUw8/vnPkg1WHokaVD
 TM7Z8Uf0K06jFxPdC8NIQOi7RhrnTHR36B9frwUFLsUAXtxyDPf2ougjQG0obhB3O21SaB3uo
 rWGU2fvdLMexBqu5qmhJOjQrDt+ishSUCll4Ka8R5sS+P7HCu/7du4AtUSz4stSRXFsWnK6Pk
 7HetBNBmK6ULcD4CBH4h4BYGGqm4wlHd+oG543EqD5VHuJkAF5ZNslQO0a1Qu7eahOEBL9drP
 /U/YPrJg0BI+HWtSRQLXhQOXIbFajgjRXmpNblK8pqduHfLVKaPCo0VceC3/kI/hub6K9ClXu
 Pm5Uq2tBTC3O2g9xcG/RH/fZAbsIEMNi0NYTkg/pntLSJNE3rOLi7zmLJNE2PCeo4T+jmWP/C
 9SnoIAELEfX+X2vPSErr0dKqFrBsX75uWHOpWatRJ3PV/2h86r9x8oFAW1RRwrus16UPBag5H
 RPPjmxJijv1PaF4fyJ6UwfQf0FUHlH8SfiZVgGvb1+oIEKW3iakSyszV2EaCK5F47Crb0KBdk
 CQKZsHqT8K2YGEVSR9OBdONHdJ+o8VXnFCY70Wc1xRXe6iz6XjSnwxsLOUs0C0Ub6MWmyBvD6
 8ES69hSWF+13lcl7/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/2/6 6:42 PM, Naohiro Aota wrote:
> Introduce struct clustered_alloc_info to manage parameters related to
> clustered allocation. By separating clustered_alloc_info and
> find_free_extent_ctl, we can introduce other allocation policy. One can
> access per-allocation policy private information from "alloc_info" of
> struct find_free_extent_ctl.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent-tree.c | 99 +++++++++++++++++++++++++-----------------
>   1 file changed, 59 insertions(+), 40 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b1f52eee24fe..8124a6461043 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3456,9 +3456,6 @@ struct find_free_extent_ctl {
>   	/* Where to start the search inside the bg */
>   	u64 search_start;
>
> -	/* For clustered allocation */
> -	u64 empty_cluster;
> -
>   	bool have_caching_bg;
>   	bool orig_have_caching_bg;
>
> @@ -3470,18 +3467,6 @@ struct find_free_extent_ctl {
>   	 */
>   	int loop;
>
> -	/*
> -	 * Whether we're refilling a cluster, if true we need to re-search
> -	 * current block group but don't try to refill the cluster again.
> -	 */
> -	bool retry_clustered;
> -
> -	/*
> -	 * Whether we're updating free space cache, if true we need to re-sear=
ch
> -	 * current block group but don't try updating free space cache again.
> -	 */
> -	bool retry_unclustered;
> -
>   	/* If current block group is cached */
>   	int cached;
>
> @@ -3499,8 +3484,28 @@ struct find_free_extent_ctl {
>
>   	/* Allocation policy */
>   	enum btrfs_extent_allocation_policy policy;
> +	void *alloc_info;
>   };
>
> +struct clustered_alloc_info {
> +	/* For clustered allocation */
> +	u64 empty_cluster;
> +
> +	/*
> +	 * Whether we're refilling a cluster, if true we need to re-search
> +	 * current block group but don't try to refill the cluster again.
> +	 */
> +	bool retry_clustered;
> +
> +	/*
> +	 * Whether we're updating free space cache, if true we need to re-sear=
ch
> +	 * current block group but don't try updating free space cache again.
> +	 */
> +	bool retry_unclustered;
> +
> +	struct btrfs_free_cluster *last_ptr;
> +	bool use_cluster;
> +};
>
>   /*
>    * Helper function for find_free_extent().
> @@ -3516,6 +3521,7 @@ static int find_free_extent_clustered(struct btrfs=
_block_group *bg,
>   		struct btrfs_block_group **cluster_bg_ret)
>   {
>   	struct btrfs_block_group *cluster_bg;
> +	struct clustered_alloc_info *clustered =3D ffe_ctl->alloc_info;
>   	u64 aligned_cluster;
>   	u64 offset;
>   	int ret;
> @@ -3572,7 +3578,7 @@ static int find_free_extent_clustered(struct btrfs=
_block_group *bg,
>   	}
>
>   	aligned_cluster =3D max_t(u64,
> -			ffe_ctl->empty_cluster + ffe_ctl->empty_size,
> +			clustered->empty_cluster + ffe_ctl->empty_size,
>   			bg->full_stripe_len);
>   	ret =3D btrfs_find_space_cluster(bg, last_ptr, ffe_ctl->search_start,
>   			ffe_ctl->num_bytes, aligned_cluster);
> @@ -3591,12 +3597,12 @@ static int find_free_extent_clustered(struct btr=
fs_block_group *bg,
>   			return 0;
>   		}
>   	} else if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
> -		   !ffe_ctl->retry_clustered) {
> +		   !clustered->retry_clustered) {
>   		spin_unlock(&last_ptr->refill_lock);
>
> -		ffe_ctl->retry_clustered =3D true;
> +		clustered->retry_clustered =3D true;
>   		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
> -				ffe_ctl->empty_cluster + ffe_ctl->empty_size);
> +				clustered->empty_cluster + ffe_ctl->empty_size);
>   		return -EAGAIN;
>   	}
>   	/*
> @@ -3618,6 +3624,7 @@ static int find_free_extent_unclustered(struct btr=
fs_block_group *bg,
>   		struct btrfs_free_cluster *last_ptr,
>   		struct find_free_extent_ctl *ffe_ctl)
>   {
> +	struct clustered_alloc_info *clustered =3D ffe_ctl->alloc_info;
>   	u64 offset;
>
>   	/*
> @@ -3636,7 +3643,7 @@ static int find_free_extent_unclustered(struct btr=
fs_block_group *bg,
>   		free_space_ctl =3D bg->free_space_ctl;
>   		spin_lock(&free_space_ctl->tree_lock);
>   		if (free_space_ctl->free_space <
> -		    ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
> +		    ffe_ctl->num_bytes + clustered->empty_cluster +
>   		    ffe_ctl->empty_size) {
>   			ffe_ctl->total_free_space =3D max_t(u64,
>   					ffe_ctl->total_free_space,
> @@ -3660,11 +3667,11 @@ static int find_free_extent_unclustered(struct b=
trfs_block_group *bg,
>   	 * If @retry_unclustered is true then we've already waited on this
>   	 * block group once and should move on to the next block group.
>   	 */
> -	if (!offset && !ffe_ctl->retry_unclustered && !ffe_ctl->cached &&
> +	if (!offset && !clustered->retry_unclustered && !ffe_ctl->cached &&
>   	    ffe_ctl->loop > LOOP_CACHING_NOWAIT) {
>   		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
>   						      ffe_ctl->empty_size);
> -		ffe_ctl->retry_unclustered =3D true;
> +		clustered->retry_unclustered =3D true;
>   		return -EAGAIN;
>   	} else if (!offset) {
>   		return 1;
> @@ -3685,6 +3692,7 @@ static int find_free_extent_update_loop(struct btr=
fs_fs_info *fs_info,
>   					bool full_search, bool use_cluster)
>   {
>   	struct btrfs_root *root =3D fs_info->extent_root;
> +	struct clustered_alloc_info *clustered =3D ffe_ctl->alloc_info;
>   	int ret;
>
>   	if ((ffe_ctl->loop =3D=3D LOOP_CACHING_NOWAIT) &&
> @@ -3774,10 +3782,10 @@ static int find_free_extent_update_loop(struct b=
trfs_fs_info *fs_info,
>   			 * no empty_cluster.
>   			 */
>   			if (ffe_ctl->empty_size =3D=3D 0 &&
> -			    ffe_ctl->empty_cluster =3D=3D 0)
> +			    clustered->empty_cluster =3D=3D 0)
>   				return -ENOSPC;
>   			ffe_ctl->empty_size =3D 0;
> -			ffe_ctl->empty_cluster =3D 0;
> +			clustered->empty_cluster =3D 0;
>   		}
>   		return 1;
>   	}
> @@ -3816,11 +3824,10 @@ static noinline int find_free_extent(struct btrf=
s_fs_info *fs_info,
>   {
>   	int ret =3D 0;
>   	int cache_block_group_error =3D 0;
> -	struct btrfs_free_cluster *last_ptr =3D NULL;
>   	struct btrfs_block_group *block_group =3D NULL;
>   	struct find_free_extent_ctl ffe_ctl =3D {0};
>   	struct btrfs_space_info *space_info;
> -	bool use_cluster =3D true;
> +	struct clustered_alloc_info *clustered =3D NULL;
>   	bool full_search =3D false;
>
>   	WARN_ON(num_bytes < fs_info->sectorsize);
> @@ -3829,8 +3836,6 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>   	ffe_ctl.empty_size =3D empty_size;
>   	ffe_ctl.flags =3D flags;
>   	ffe_ctl.search_start =3D 0;
> -	ffe_ctl.retry_clustered =3D false;
> -	ffe_ctl.retry_unclustered =3D false;
>   	ffe_ctl.delalloc =3D delalloc;
>   	ffe_ctl.index =3D btrfs_bg_flags_to_raid_index(flags);
>   	ffe_ctl.have_caching_bg =3D false;
> @@ -3851,6 +3856,15 @@ static noinline int find_free_extent(struct btrfs=
_fs_info *fs_info,
>   		return -ENOSPC;
>   	}
>
> +	clustered =3D kzalloc(sizeof(*clustered), GFP_NOFS);
> +	if (!clustered)
> +		return -ENOMEM;

NIT of coding style, please pick the kzalloc after the whole assignment
zone.

> +	clustered->last_ptr =3D NULL;
> +	clustered->use_cluster =3D true;
> +	clustered->retry_clustered =3D false;
> +	clustered->retry_unclustered =3D false;
> +	ffe_ctl.alloc_info =3D clustered;
> +
>   	/*
>   	 * If our free space is heavily fragmented we may not be able to make
>   	 * big contiguous allocations, so instead of doing the expensive sear=
ch
> @@ -3869,14 +3883,16 @@ static noinline int find_free_extent(struct btrf=
s_fs_info *fs_info,
>   			spin_unlock(&space_info->lock);
>   			return -ENOSPC;
>   		} else if (space_info->max_extent_size) {
> -			use_cluster =3D false;
> +			clustered->use_cluster =3D false;
>   		}
>   		spin_unlock(&space_info->lock);
>   	}
>
> -	last_ptr =3D fetch_cluster_info(fs_info, space_info,
> -				      &ffe_ctl.empty_cluster);
> -	if (last_ptr) {
> +	clustered->last_ptr =3D fetch_cluster_info(fs_info, space_info,
> +						 &clustered->empty_cluster);
> +	if (clustered->last_ptr) {
> +		struct btrfs_free_cluster *last_ptr =3D clustered->last_ptr;
> +
>   		spin_lock(&last_ptr->lock);
>   		if (last_ptr->block_group)
>   			ffe_ctl.hint_byte =3D last_ptr->window_start;
> @@ -3887,7 +3903,7 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>   			 * some time.
>   			 */
>   			ffe_ctl.hint_byte =3D last_ptr->window_start;
> -			use_cluster =3D false;
> +			clustered->use_cluster =3D false;
>   		}
>   		spin_unlock(&last_ptr->lock);
>   	}
> @@ -4000,10 +4016,11 @@ static noinline int find_free_extent(struct btrf=
s_fs_info *fs_info,
>   		 * Ok we want to try and use the cluster allocator, so
>   		 * lets look there
>   		 */
> -		if (last_ptr && use_cluster) {
> +		if (clustered->last_ptr && clustered->use_cluster) {
>   			struct btrfs_block_group *cluster_bg =3D NULL;
>
> -			ret =3D find_free_extent_clustered(block_group, last_ptr,
> +			ret =3D find_free_extent_clustered(block_group,
> +							 clustered->last_ptr,
>   							 &ffe_ctl, &cluster_bg);
>
>   			if (ret =3D=3D 0) {
> @@ -4021,7 +4038,8 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>   			/* ret =3D=3D -ENOENT case falls through */
>   		}
>
> -		ret =3D find_free_extent_unclustered(block_group, last_ptr,
> +		ret =3D find_free_extent_unclustered(block_group,
> +						   clustered->last_ptr,
>   						   &ffe_ctl);
>   		if (ret =3D=3D -EAGAIN)
>   			goto have_block_group;
> @@ -4062,8 +4080,8 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>   		btrfs_release_block_group(block_group, delalloc);
>   		break;
>   loop:
> -		ffe_ctl.retry_clustered =3D false;
> -		ffe_ctl.retry_unclustered =3D false;
> +		clustered->retry_clustered =3D false;
> +		clustered->retry_unclustered =3D false;
>   		BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=3D
>   		       ffe_ctl.index);
>   		btrfs_release_block_group(block_group, delalloc);
> @@ -4071,8 +4089,9 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>   	}
>   	up_read(&space_info->groups_sem);
>
> -	ret =3D find_free_extent_update_loop(fs_info, last_ptr, ins, &ffe_ctl,
> -					   full_search, use_cluster);
> +	ret =3D find_free_extent_update_loop(fs_info, clustered->last_ptr, ins=
,
> +					   &ffe_ctl, full_search,
> +					   clustered->use_cluster);
>   	if (ret > 0)
>   		goto search;
>
>

