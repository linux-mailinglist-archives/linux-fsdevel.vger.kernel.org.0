Return-Path: <linux-fsdevel+bounces-73131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D917D0D3A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0821301EF8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D982E8DE6;
	Sat, 10 Jan 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6jsR1Z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79462946A
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768035322; cv=none; b=s/lJ+/MnkiN1thcKMYWQd8HBd9wZP/hWqiJo185heqqEClDwIr6qvuGOZV7dgJuIySeotmWX4kAk4dmg5VhbFqbkLBMH7/W0zIVlkamhwCuvH1WVkf/ukBdp9eAgRGjnLf8JO+azga79400jG11/4P+2ZNVJJWcUotx+ht2C8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768035322; c=relaxed/simple;
	bh=zq2MbpXhu55mIOoBFKAqmjdEHy04JzISXfd1cNoXow4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzTd0P22lQw0rJSS8uEd4DO7o37KhcXRkUe50eabm9f/w+oXs4qqeL+uitf0D3kVEcudWA3tgd+oBn7QyXFUqmyWzRj5H9PV2AiSuiQHgbkALlLmB5ITxte4Z7tm+M0EhbGIIm/X/dnIKXg/WJ3Bj+LyIi3X+lD+WqhF+0wym2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6jsR1Z1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b843e8a4fbfso602999266b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 00:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768035319; x=1768640119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hBvNQuND88p00U6YQws7zufPZz9ylEXL/Af+OI6mSc=;
        b=X6jsR1Z1I5CgC5lxmEJUxmS5nAZ930Ab31fEB2vYNSGdoaDTr5iEnAkxSr3Fu7enFD
         GabaW8wmwFH1l1Qjt1cfWss40SMquvDQLQQyJek8kiwDbE10InX6YRRsuUewLIFkU09k
         8+dQbnDEDXBGhljLMh+No0Uk9BCrbBRirvUV8GfFVn4Eiy0N8m+IbqDZ7YTAKBkUXonG
         SjMXfAPTdMGXIPD1sGR1YMZHJIS/xobTj7fm+VYdvcth5WabJOTg9lQhA0gxt5h8Xmos
         M6Pudqxge8kSA9jVP8ZFqyxX/w0GQGOvv7a4nIb5dbfiPB23eeK+4l25bCYWNbZXB1Fm
         MQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768035319; x=1768640119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hBvNQuND88p00U6YQws7zufPZz9ylEXL/Af+OI6mSc=;
        b=hET2KaQRykOqHQ+wa5w9kciw3a9//TYkb9DT889tZi9PJpz5Q/wQu8TEJxcn1HjQmx
         pl9mnIVZ4mV7KIWd/FzTXW8Gfaoqp0jH5CpS97SV6wKUX8wJfaxewnRSdry0u6s7S6ZA
         ldqaUj/lEh1wPsDpJrl4eXyLl3d7zypShZVK+VM4e/fAdrlGBBBeeD0lnU4wShyeohCi
         pVNmu6LI1qT59agZyEpvnvSvL0RxSaXXZItdeK82AUDymrJzlM7Gm1s+ssVTDVh6tWUn
         3sWfnS6gWqPl2v0yAIrNFwxLqYWYkojVTVuAyhdeqs7PTcB5p14H6OrsyIxMWE3atsQC
         BQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUUUsy0GJV8xEontt0XHgwUDltdoStaNRkoXbRPOofZ3wv3ORsgUuT7U0e5Et2zVyO3LsXgfBMMUdxBw+BF@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXcqiAuFXonwHHmm4BT1wkruU2Ef3oGae6VtMVZe30SN7aHQA
	ZSV6IxC11GBwUnWeyi+3ypo5ZuUEyGd3ywz4xrYoUYHghifHUPK8Hx4qMCyzVQ==
X-Gm-Gg: AY/fxX4+zL012pQksjA9bxKHXNISRmdR+9tZX2/1BV9kipvdk49lN2Z1MRqOa2cma98
	8agsTe7V3I4LP41rsiABLr7tVUomON4TOpgNIw1pinYzOHOm8wXZLcH7DQ6DhNX9Tt4GUcelOxN
	OreylJFTxgttbpWUL0YAEFrW+3/YB+flqTkkvk7mVxhHHpmd6aiUyFA1VLxiLg9+1shC/RNUQkK
	fjc3dt/PdqSk7I1iPwlG68XXBOYS5hGSmNlvQlfHbPRDb0VMm+qu3bbLM27xoQ4gozSWfNmkmrw
	efu55i1G+JjzzYwU9kuP1EE6g0RNa0iGEYtmlRANBYB9zHP44fVbYTpanZoRMfdtd4rI3nHrcz5
	DE/jtSmClJf78Vhf7Dm0N90mCO82ZFkP37V/nJqgJV3ChEWoykmP7xPUCnCaA2Md9a1GLtmxx8g
	wt9eiCURFfICjI82Zu2rjJdjAhcpDBdMwgVXwCKZo4yfcyHOxyh9/wx01b
X-Google-Smtp-Source: AGHT+IGR1qZ8sOMJJthvbak5gthpqMSGyaLQsS8H2tRTn9n6yK1gay+WbPipChJHkGze8AZUMNN1Ag==
X-Received: by 2002:a17:907:70e:b0:b73:758c:c96f with SMTP id a640c23a62f3a-b844539fc89mr1132131866b.52.1768035318404;
        Sat, 10 Jan 2026 00:55:18 -0800 (PST)
Received: from f (cst-prg-93-36.cust.vodafone.cz. [46.135.93.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a563f0esm1392681866b.60.2026.01.10.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 00:55:17 -0800 (PST)
Date: Sat, 10 Jan 2026 09:55:10 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: improve dump_inode() to safely access inode
 fields.
Message-ID: <tno2xwbsdiq674hlvcfxmzo357wia3b6b2jxddgh4u2yvygmic@ygtdea6prr33>
References: <20260109154019.74717-1-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109154019.74717-1-ytohnuki@amazon.com>

On Fri, Jan 09, 2026 at 03:40:19PM +0000, Yuto Ohnuki wrote:
> Use get_kernel_nofault() to safely access inode and related structures
> (superblock, file_system_type) to avoid crashing when the inode pointer
> is invalid. This allows the same pattern as dump_mapping().
> 
> Note: The original access method for i_state and i_count is preserved,
> as get_kernel_nofault() is unnecessary once the inode structure is
> verified accessible.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
> Changes in v2:
> - Merged NULL inode->i_sb check with invalid sb check as pointed out
>   by Jan Kara;
> - Link to v1: https://lore.kernel.org/linux-fsdevel/20260101165304.34516-1-ytohnuki@amazon.com/
> ---
>  fs/inode.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 521383223d8a..c2113e4a9a6a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2984,24 +2984,52 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  EXPORT_SYMBOL(mode_strip_sgid);
>  
>  #ifdef CONFIG_DEBUG_VFS
> -/*
> - * Dump an inode.
> - *
> - * TODO: add a proper inode dumping routine, this is a stub to get debug off the
> - * ground.
> +/**
> + * dump_inode - dump an inode.
> + * @inode: inode to dump
> + * @reason: reason for dumping
>   *
> - * TODO: handle getting to fs type with get_kernel_nofault()?
> - * See dump_mapping() above.
> + * If inode is an invalid pointer, we don't want to crash accessing it,
> + * so probe everything depending on it carefully with get_kernel_nofault().
>   */
>  void dump_inode(struct inode *inode, const char *reason)
>  {
> -	struct super_block *sb = inode->i_sb;
> +	struct super_block *sb;
> +	struct file_system_type *s_type;
> +	const char *fs_name_ptr;
> +	char fs_name[32] = {};
> +	umode_t mode;
> +	unsigned short opflags;
> +	unsigned int flags;
> +	unsigned int state;
> +	int count;
> +
> +	pr_warn("%s encountered for inode %px\n", reason, inode);
> +
> +	if (get_kernel_nofault(sb, &inode->i_sb) ||
> +	    get_kernel_nofault(mode, &inode->i_mode) ||
> +	    get_kernel_nofault(opflags, &inode->i_opflags) ||
> +	    get_kernel_nofault(flags, &inode->i_flags)) {
> +		pr_warn("invalid inode:%px\n", inode);
> +		return;
> +	}
>  
> -	pr_warn("%s encountered for inode %px\n"
> -		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
> -		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
> -		inode->i_flags, inode_state_read_once(inode), atomic_read(&inode->i_count));
> -}
> +	state = inode_state_read_once(inode);
> +	count = atomic_read(&inode->i_count);
> +
> +	if (!sb ||
> +	    get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
> +	    get_kernel_nofault(fs_name_ptr, &s_type->name) || !fs_name_ptr) {
> +		pr_warn("invalid sb:%px mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
> +			sb, mode, opflags, flags, state, count);
> +		return;
> +	}
> +
> +	if (strncpy_from_kernel_nofault(fs_name, fs_name_ptr, sizeof(fs_name) - 1) < 0)
> +		strscpy(fs_name, "<invalid>");
>  
> +	pr_warn("fs:%s mode:%ho opflags:0x%x flags:0x%x state:0x%x count:%d\n",
> +		fs_name, mode, opflags, flags, state, count);
> +}

It would be good to avoid duplication of the pr_warn stuff as the format
string is expected to change over time. I guess you could retain
"<invalid>" for the case where sb was unreadable? Or even denote it,
perhaps with "<unknown, sb unreadable>" or similar.


I don't really care as long as tere is one pr_warn dumping the state.

This bit:
+	pr_warn("invalid inode:%px\n", inode);

could still print the passed reason. "invalid inode:" is a little
misleaing, perhaps "unreadable inode" would be better?

As a side note I was told kernel printk supports %# for printing hash
values, perhaps a good opportunity to squeeze this in intead of 0x. One
will have to test it indeed gives the expected result.

