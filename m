Return-Path: <linux-fsdevel+bounces-63449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E48BBBBCE8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 02:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 054F34E6361
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 00:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93219E99F;
	Mon,  6 Oct 2025 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="NQZ7FKca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408350276
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759712230; cv=none; b=eVCHc59O/XSIb3GxtAb/puPUczIuCG+MKzdrusG08xl1MpcAfwJryjsihk/Wk1m9ZHuC2vfEVnW+rzkKfUn0KsdWPuu9hfrwau0PUflZpnn/oyKaWEu7Vd3tXHQlkGJRDMQwF9h6ee1CahlNUc8TbtDZugZzcHwmtWvuuP1X088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759712230; c=relaxed/simple;
	bh=2O3NyyGaKBnWbYzsQwff4aXc+mmZBKjctBs0ekpfgts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms5ToR7vMRrtdjSf/ikO5qOFaGOS/3ImviUyVE4E1mSo1FiZFNS4iBqtMDqZrAMieMc7KZomVbKY8+AQyth3dPoebcS5MKSvhMATHbOFPLUgNu1xHieKqMgRs8Q6eGs80gZS+2qdiOzfRmNIV+h5M2xfSmAZAznpiRT5s+N4DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=NQZ7FKca; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759712220;
	bh=J00JwTsYO3YQXzNOfnF8F12Qv4P6Je1eFHbJvWxJbqg=;
	h=From:Subject:Date:Message-ID;
	b=NQZ7FKcazadVQ/xMm4XvK0bo5ucUcdfwVuwUV7B5Iyj6/nQDBG6fYS7gixu5NrJdf
	 gZmAG4dR5uZcvyP98d9kGaRzMTrxRT9RXMBx2bjvo2o92Ebd8vBIx79eEAdl8lMtIp
	 YuuA7qOTUoIJ9aNXW6Gvp7byDJ2HyZuhyEU8FFuc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68E313D100002138; Mon, 6 Oct 2025 08:56:51 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3043326291957
X-SMAIL-UIID: E4F6F21874004EDA9F93CC86EA06073A-20251006-085651-1
From: Hillf Danton <hdanton@sina.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
Date: Mon,  6 Oct 2025 08:56:41 +0800
Message-ID: <20251006005642.8194-1-hdanton@sina.com>
In-Reply-To: <20251005231526.708061-1-mjguzik@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  6 Oct 2025 01:15:26 +0200 Mateusz Guzik wrote:
> Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
> and unlock_new_inode().
> 
> In principle the latter can clear the I_NEW flag before prior stores
> into the inode were made visible.
> 
Given difficulty following up here, could you specify why the current
mem barrier [1] in unlock_new_inode() is not enough?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/inode.c#n1190

> The former can in turn observe I_NEW is cleared and proceed to use the
> inode, while possibly reading from not-yet-published areas.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> I don't think this is a serious bug in the sense I doubt anyone ever ran
> into it, but this is an issue on paper.
> 
> I'm doing some changes in the area and I figured I'll get this bit out
> of the way.
> 
>  fs/dcache.c               | 4 ++++
>  fs/inode.c                | 8 ++++++++
>  include/linux/writeback.h | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a067fa0a965a..806d6a665124 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1981,6 +1981,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	__d_instantiate(entry, inode);
>  	WARN_ON(!(inode->i_state & I_NEW));
> +	/*
> +	 * Pairs with smp_rmb in wait_on_inode().
> +	 */
> +	smp_wmb();
>  	inode->i_state &= ~I_NEW & ~I_CREATING;
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> diff --git a/fs/inode.c b/fs/inode.c
> index ec9339024ac3..842ee973c8b6 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1181,6 +1181,10 @@ void unlock_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode->i_state & I_NEW));
> +	/*
> +	 * Pairs with smp_rmb in wait_on_inode().
> +	 */
> +	smp_wmb();
>  	inode->i_state &= ~I_NEW & ~I_CREATING;
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> @@ -1198,6 +1202,10 @@ void discard_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode->i_state & I_NEW));
> +	/*
> +	 * Pairs with smp_rmb in wait_on_inode().
> +	 */
> +	smp_wmb();
>  	inode->i_state &= ~I_NEW;
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 22dd4adc5667..e1e1231a6830 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *inode)
>  {
>  	wait_var_event(inode_state_wait_address(inode, __I_NEW),
>  		       !(READ_ONCE(inode->i_state) & I_NEW));
> +	/*
> +	 * Pairs with routines clearing I_NEW.
> +	 */
> +	smp_rmb();
>  }

Why is this needed as nobody cares I_NEW after wait?

>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> -- 
> 2.34.1

