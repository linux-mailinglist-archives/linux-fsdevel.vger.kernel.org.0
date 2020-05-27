Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641371E3429
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 02:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgE0AtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgE0AtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 20:49:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF5C061A0F;
        Tue, 26 May 2020 17:49:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a13so9421456pls.8;
        Tue, 26 May 2020 17:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/JlVkIYtOH22Thby0LCK8W0UIVx5wzKW2ljCTmFrvY=;
        b=OVgewBZMqLqx04vVNrWds7PmRoUIVOv+xHXyvWSIiIbGC+YwfZC7X6NVCuT5K1Asb1
         HE929zmNDgh0Qkmgz/Jzx2oq0uP6lKIY1yBNTaS0Ztph/StvXi++sToegBHxx+Mh/qfS
         pUsjuKHdfpOSJn28kuOr+a5ygYhL0xGrAfVLHNz+xw9ZYwfohwpHA2zwmhYdySIdzDDC
         IrhOi6M3hIeSlY7UOxwTr5gRotCVmgrSyOsSCHMPu2336P6Ylk1Fnts++wQY+vwSVGtc
         ok+P9eVxw4+6WHW6O0LYdbP40rNyxJyc04FlqaMxKX8ahQiE8yUPxASNRcsiBLUhZQAq
         xtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/JlVkIYtOH22Thby0LCK8W0UIVx5wzKW2ljCTmFrvY=;
        b=YW3DBPbFy2WzTKNDbHcFgWplFhNp0kdaZWIKk2FFTBarrYZ5a1Az5Iyie4Z/f2lU8O
         IUy2m6CCIZrO++/g6QaA08YS/9G5lYjgoq3CzVnh4uUoMfk0xWgbyjGXnGlP05EDYRtI
         /BIN855ZvLw7ugdf9us3FRsjSHN6YKjwiJ554DhB4rgrxeiKZMufrgxlaWTIHuhhNTqJ
         jRwVrrxmpKBUDD0c8KmZvfWnuG3xc0r4h/dA4YnUOrVbKOymdd2+lswkIuYb02q/lRWq
         J0qU6lNoGKi2On2ikOSCR37T0JkRkw+LHk+NkJ5rZGLbuhyM79tq5HZ68w1bVcebxn/j
         pbbg==
X-Gm-Message-State: AOAM533Ms6gUramo+1advAMI8I+cq8PPfLpq0QB4JXvL66DK9R6q6Xsg
        Vd9IwPF10D2V7o2t1pPCdbM=
X-Google-Smtp-Source: ABdhPJzbIAE1tc8zindTkUItJkLL8VLCvoWaN1PuG6Cmc9mLiASRCnu8+8azTqHTQ9J1JgY60oTIUw==
X-Received: by 2002:a17:90a:c584:: with SMTP id l4mr1939961pjt.195.1590540546018;
        Tue, 26 May 2020 17:49:06 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:726d])
        by smtp.gmail.com with ESMTPSA id gt10sm583281pjb.30.2020.05.26.17.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 17:49:05 -0700 (PDT)
Date:   Tue, 26 May 2020 17:49:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
Message-ID: <20200527004902.lo6c2efv5vix5nqq@ast-mbp.dhcp.thefacebook.com>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-3-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526163336.63653-3-kpsingh@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 06:33:34PM +0200, KP Singh wrote:
>  
> +static struct bpf_local_storage_data *inode_storage_update(
> +	struct inode *inode, struct bpf_map *map, void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *old_sdata = NULL;
> +	struct bpf_local_storage_elem *selem;
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map *smap;
> +	int err;
> +
> +	err = check_update_flags(map, map_flags);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	local_storage = rcu_dereference(inode->inode_bpf_storage);
> +
> +	if (!local_storage || hlist_empty(&local_storage->list)) {
> +		/* Very first elem for this inode */
> +		err = check_flags(NULL, map_flags);
> +		if (err)
> +			return ERR_PTR(err);
> +
> +		selem = selem_alloc(smap, value);
> +		if (!selem)
> +			return ERR_PTR(-ENOMEM);
> +
> +		err = inode_storage_alloc(inode, smap, selem);

inode_storage_update looks like big copy-paste except above one line.
pls consolidate.

> +BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> +	   void *, value, u64, flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +
> +	if (flags > BPF_LOCAL_STORAGE_GET_F_CREATE)
> +		return (unsigned long)NULL;
> +
> +	sdata = inode_storage_lookup(inode, map, true);
> +	if (sdata)
> +		return (unsigned long)sdata->data;
> +
> +	if (flags == BPF_LOCAL_STORAGE_GET_F_CREATE &&
> +	    atomic_inc_not_zero(&inode->i_count)) {
> +		sdata = inode_storage_update(inode, map, value, BPF_NOEXIST);
> +		iput(inode);
> +		return IS_ERR(sdata) ?
> +			(unsigned long)NULL : (unsigned long)sdata->data;
> +	}

This is wrong. You cannot just copy paste the refcounting logic
from bpf_sk_storage_get(). sk->sk_refcnt is very different from inode->i_count.
To start, the inode->i_count cannot be incremented without lock.
If you really need to do it you need igrab().
Secondly, the iput() is not possible to call from bpf prog yet, since
progs are not sleepable and iput() may call iput_final() which may sleep.
But considering that only lsm progs from lsm hooks will call bpf_inode_storage_get()
the inode is not going to disappear while this function is running.
So why touch i_count ?

> +
> +	return (unsigned long)NULL;
> +}
> +
>  BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
>  {
>  	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
> @@ -957,6 +1229,20 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
>  	return -ENOENT;
>  }
>  
> +BPF_CALL_2(bpf_inode_storage_delete,
> +	   struct bpf_map *, map, struct inode *, inode)
> +{
> +	int err;
> +
> +	if (atomic_inc_not_zero(&inode->i_count)) {
> +		err = inode_storage_delete(inode, map);
> +		iput(inode);
> +		return err;
> +	}

ditto.

> +
> +	return inode_storage_delete(inode, map);

bad copy-paste from bpf_sk_storage_delete?
or what is this logic suppose to do?
