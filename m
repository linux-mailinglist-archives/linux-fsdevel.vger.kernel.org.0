Return-Path: <linux-fsdevel+bounces-21071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5518FD61D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1792860C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989113A890;
	Wed,  5 Jun 2024 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZu4gvCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04D2F2B
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613881; cv=none; b=nX2i4Egd7i/8sfgoh7tSBc//jTTvgFZuBjJBjoZb7w33WuLBISIsnKg8iRBj8QoVMiTY81IWbJLJA0/mYv1aP/UajdvVTZqM9FGDGUGfA2hxGo/v/Wn8eiEzOTLwuInWGcB7//OcJ+DRfvnWBCNWn6LYyOxoIdYHu1awmljkNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613881; c=relaxed/simple;
	bh=cV4+BsXA6YuooeHVk+Iy1Vem1zsLz5qRdIcGC47SHWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ9Iqr4kG5Ju1Z35qO73qnV9/yI3PoxHCOi8JMw5GzXveEoqkqv+BJOduz0Hi4k+QE3zeU4J5uhFXdzZRwaDnjG7FripovlC9QgPlXEkmiHwTuXOd2NAw1IOA828NpW1l9Zijw2Vy8I2XeHM0M9DNyBg1qz53V66BsSGfotLOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZu4gvCP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717613878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRAp5c7orpHKOaoP/oanRKfeIAxE+CMMv+g5wwbAC1w=;
	b=bZu4gvCPo4gmV5qyoxBEP3NClyqSARtroXyP+sRoq0LP+JOY3i2zXEeRVLndnHbDFX0i/y
	5byN5rr6pNXYbmR5jU3qn3i0KdR/lhSqHTbt41Q+Psx7pk/x2M8FQnkjYSteQClVnCM2vn
	f8tpJEz35ZpeV9oKEEyd5o5n+COw3sc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-Z0aFyhEdMdSFPfmLtueNVw-1; Wed,
 05 Jun 2024 14:57:54 -0400
X-MC-Unique: Z0aFyhEdMdSFPfmLtueNVw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 106D2196DFF6;
	Wed,  5 Jun 2024 18:57:53 +0000 (UTC)
Received: from [10.22.33.216] (unknown [10.22.33.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DEC61956086;
	Wed,  5 Jun 2024 18:57:51 +0000 (UTC)
Message-ID: <6336a9ce-739e-498a-a0e3-f351757422d2@redhat.com>
Date: Wed, 5 Jun 2024 14:57:50 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improving readability of copy_tree
To: Jemmy <jemmywong512@gmail.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, jemmy512@icloud.com
References: <20240604134347.9357-1-jemmywong512@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240604134347.9357-1-jemmywong512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 6/4/24 09:43, Jemmy wrote:
> Hello everyone,
>
> I'm new to Linux kernel development
> and excited to make my first contribution.
> While working with the copy_tree function,
> I noticed some unclear variable names e.g., p, q, r.
> I've updated them to be more descriptive,
> aiming to make the code easier to understand.
>
> Changes:
>
> p       -> o_parent, old parent
> q       -> n_mnt, new mount
> r       -> o_mnt, old child
> s       -> o_child, old child
> parent  -> n_parent, new parent
>
> Thanks for the opportunity to be part of this community!
>
> BR,
> Jemmy

I don't know why I am on the to-list as I haven't worked on this file 
before. Anyway, making meaning name is helpful, but I believe a 
functional level documentation on top of copy_tree() to explain what 
this function tries to accomplish can be helpful too.

Cheers,
Longman

>
> Signed-off-by: Jemmy <jemmywong512@gmail.com>
> ---
>   fs/namespace.c | 51 +++++++++++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 26 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5a51315c6678..b1cf95ddfb87 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1969,7 +1969,7 @@ static bool mnt_ns_loop(struct dentry *dentry)
>   struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
>   					int flag)
>   {
> -	struct mount *res, *p, *q, *r, *parent;
> +	struct mount *res, *o_parent, *o_child, *o_mnt, *n_parent, *n_mnt;
>   
>   	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(mnt))
>   		return ERR_PTR(-EINVAL);
> @@ -1977,47 +1977,46 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
>   	if (!(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry))
>   		return ERR_PTR(-EINVAL);
>   
> -	res = q = clone_mnt(mnt, dentry, flag);
> -	if (IS_ERR(q))
> -		return q;
> +	res = n_mnt = clone_mnt(mnt, dentry, flag);
> +	if (IS_ERR(n_mnt))
> +		return n_mnt;
>   
> -	q->mnt_mountpoint = mnt->mnt_mountpoint;
> +	n_mnt->mnt_mountpoint = mnt->mnt_mountpoint;
>   
> -	p = mnt;
> -	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
> -		struct mount *s;
> -		if (!is_subdir(r->mnt_mountpoint, dentry))
> +	o_parent = mnt;
> +	list_for_each_entry(o_mnt, &mnt->mnt_mounts, mnt_child) {
> +		if (!is_subdir(o_mnt->mnt_mountpoint, dentry))
>   			continue;
>   
> -		for (s = r; s; s = next_mnt(s, r)) {
> +		for (o_child = o_mnt; o_child; o_child = next_mnt(o_child, o_mnt)) {
>   			if (!(flag & CL_COPY_UNBINDABLE) &&
> -			    IS_MNT_UNBINDABLE(s)) {
> -				if (s->mnt.mnt_flags & MNT_LOCKED) {
> +			    IS_MNT_UNBINDABLE(o_child)) {
> +				if (o_child->mnt.mnt_flags & MNT_LOCKED) {
>   					/* Both unbindable and locked. */
> -					q = ERR_PTR(-EPERM);
> +					n_mnt = ERR_PTR(-EPERM);
>   					goto out;
>   				} else {
> -					s = skip_mnt_tree(s);
> +					o_child = skip_mnt_tree(o_child);
>   					continue;
>   				}
>   			}
>   			if (!(flag & CL_COPY_MNT_NS_FILE) &&
> -			    is_mnt_ns_file(s->mnt.mnt_root)) {
> -				s = skip_mnt_tree(s);
> +			    is_mnt_ns_file(o_child->mnt.mnt_root)) {
> +				o_child = skip_mnt_tree(o_child);
>   				continue;
>   			}
> -			while (p != s->mnt_parent) {
> -				p = p->mnt_parent;
> -				q = q->mnt_parent;
> +			while (o_parent != o_child->mnt_parent) {
> +				o_parent = o_parent->mnt_parent;
> +				n_mnt = n_mnt->mnt_parent;
>   			}
> -			p = s;
> -			parent = q;
> -			q = clone_mnt(p, p->mnt.mnt_root, flag);
> -			if (IS_ERR(q))
> +			o_parent = o_child;
> +			n_parent = n_mnt;
> +			n_mnt = clone_mnt(o_parent, o_parent->mnt.mnt_root, flag);
> +			if (IS_ERR(n_mnt))
>   				goto out;
>   			lock_mount_hash();
> -			list_add_tail(&q->mnt_list, &res->mnt_list);
> -			attach_mnt(q, parent, p->mnt_mp, false);
> +			list_add_tail(&n_mnt->mnt_list, &res->mnt_list);
> +			attach_mnt(n_mnt, n_parent, o_parent->mnt_mp, false);
>   			unlock_mount_hash();
>   		}
>   	}
> @@ -2028,7 +2027,7 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
>   		umount_tree(res, UMOUNT_SYNC);
>   		unlock_mount_hash();
>   	}
> -	return q;
> +	return n_mnt;
>   }
>   
>   /* Caller should check returned pointer for errors */


