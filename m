Return-Path: <linux-fsdevel+bounces-13662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B736E872968
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93F11C2165D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52412D1E4;
	Tue,  5 Mar 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyjM2kV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4B1272B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674044; cv=none; b=RUt+bLtY86eC2fxFMegiw5e3V1T2Bkko0OjnVk4ZhDgE9z50p6oD8LVJU0sUSPHmc271/HMx43wY8acoFpLtcn2sCvOr2E/TNoCnV7fO+XS8BXodTw00yPA8lfLgz//CVKiSS9BQiMEj7PAr6cnc5RR12+jZKGQ7oWzXCP/Gm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674044; c=relaxed/simple;
	bh=h4dHCWxtdtz0md/IPbklLjgW7I+43OHEcTBoLVme8u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esTqNVYdE6Omqwyg0eGxwZMFZhRHUjHII9xoHSAgREqGbi5mH396FwSePX/ZEx2cjuEa2jrFt2CwpuyqYxYVBhDFZDA27p0B1MwR22e2PFYkNQrhBhHMLsKYzUU4dc0+7Fi4QY6owGZacgEWWC+vB+KyvXDw43PD9QJIBwrcHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyjM2kV/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709674041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMq36ftcCkj5t1ewHvgBCGl6sdATBI1NThNrOcdNt1w=;
	b=WyjM2kV/5BN/h9NpSU4C5JUduCnJBq1xzgKGoP8TXdLVd2HROOhep3GawDhBDK+X7dKEnp
	OP1ZA4gjoe5CIbIBW00ibmVoy7BnOkuzwIZfw2OWQL07NsL2QHt0y8GzKpOKHVfj/z8jiR
	tRIpABQezyo7mdVuFSc8uQWOTclmhSY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-_nXuGNXfOgOjmLhqa-zhMg-1; Tue, 05 Mar 2024 16:27:20 -0500
X-MC-Unique: _nXuGNXfOgOjmLhqa-zhMg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c86ecb5b37so77054839f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 13:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709674039; x=1710278839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMq36ftcCkj5t1ewHvgBCGl6sdATBI1NThNrOcdNt1w=;
        b=EXVvwg9J66VAeNq8FhhxMNaD9AxeVUd/kCI0y2cyj+6gz7Fzvs43bTfkWG7tcTWfsx
         UIEWQSO2c+qR/bnMfdsNsZQXWgIZGSshcWkFfWHur0pyB6nY5I/7l1WVqbM41kku2CGm
         csC8N50m0aPKi4VOr3V+QVSY8fm5DB6H8jXx1sBPMcBdX8oWR5Tk4mOns9jsRyzivvXc
         LeIlsLMkUg+bfHR4np1ZZeZTjK0my5XA29SUZZQURVAg/Ef0O6EZ1m7NhpJW0hBaSifm
         GRrZXC+XIr/BHnsS0SpvDcHDMzYfEcN8s1Pj9l5FZ9tG1sx7XoE0/aEEtUck6AUyCWoV
         zIEg==
X-Forwarded-Encrypted: i=1; AJvYcCUW2qeNuScLAZRWakVkldKgiEzCnoytc8A9Ml5Ln59sTWNz96tCUZSCXJa6QWqITo94ogl5kNc+FRtwhxNMkLZoB/GTB+onosl5tAX76g==
X-Gm-Message-State: AOJu0YwDPAHotPRbKAyz6Y4ZbvSW0ahqVEo2hCPdKUUZXwJgkrRTqhWl
	KAcY/OADHt+LXjxv1OiQWF3nX+Tc46RrpTCXMmVznEbwnS4R8fVM8pWJoVGeA8AEs9pxiwKcNrf
	2+Q2x2wzZ1eZxttfkMLK+D8270mIC450mtdL+qdoULnyIJ1EFotwagRar7uca7+o=
X-Received: by 2002:a6b:7606:0:b0:7c7:98e2:393 with SMTP id g6-20020a6b7606000000b007c798e20393mr13595003iom.2.1709674039350;
        Tue, 05 Mar 2024 13:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+w49uX1olmldZwzTfjnww0a4FiAMVPsSa9HELOzFfJHkJC6G//1WDZfaMCgQx/BSFfX6ipA==
X-Received: by 2002:a6b:7606:0:b0:7c7:98e2:393 with SMTP id g6-20020a6b7606000000b007c798e20393mr13594991iom.2.1709674039045;
        Tue, 05 Mar 2024 13:27:19 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id t22-20020a02b196000000b004752d5fcf14sm249783jah.115.2024.03.05.13.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:27:18 -0800 (PST)
Message-ID: <c4a2e820-70e5-453c-b022-a3207fb9119d@redhat.com>
Date: Tue, 5 Mar 2024 15:27:17 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] minix: convert minix to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org
References: <20240305210829.943737-1-bodonnel@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240305210829.943737-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 3:08 PM, Bill O'Donnell wrote:
> Convert the minix filesystem to use the new mount API.
> 
> Tested using mount and remount on minix device.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
>  fs/minix/inode.c | 64 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index 73f37f298087..248e78a118e7 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -20,11 +20,11 @@
>  #include <linux/mpage.h>
>  #include <linux/vfs.h>
>  #include <linux/writeback.h>
> +#include <linux/fs_context.h>
>  
>  static int minix_write_inode(struct inode *inode,
>  		struct writeback_control *wbc);
>  static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
> -static int minix_remount (struct super_block * sb, int * flags, char * data);
>  
>  static void minix_evict_inode(struct inode *inode)
>  {
> @@ -111,19 +111,19 @@ static const struct super_operations minix_sops = {
>  	.evict_inode	= minix_evict_inode,
>  	.put_super	= minix_put_super,
>  	.statfs		= minix_statfs,
> -	.remount_fs	= minix_remount,
>  };
>  
> -static int minix_remount (struct super_block * sb, int * flags, char * data)
> +static int minix_reconfigure(struct fs_context *fc)
>  {
> -	struct minix_sb_info * sbi = minix_sb(sb);
>  	struct minix_super_block * ms;
> +	struct super_block *sb = fc->root->d_sb;
> +	struct minix_sb_info * sbi = sb->s_fs_info;
>  
>  	sync_filesystem(sb);
>  	ms = sbi->s_ms;
> -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
>  		return 0;
> -	if (*flags & SB_RDONLY) {
> +	if (fc->sb_flags & SB_RDONLY) {
>  		if (ms->s_state & MINIX_VALID_FS ||
>  		    !(sbi->s_mount_state & MINIX_VALID_FS))
>  			return 0;
> @@ -170,7 +170,7 @@ static bool minix_check_superblock(struct super_block *sb)
>  	return true;
>  }
>  
> -static int minix_fill_super(struct super_block *s, void *data, int silent)
> +static int minix_fill_super(struct super_block *s, struct fs_context *fc)
>  {
>  	struct buffer_head *bh;
>  	struct buffer_head **map;
> @@ -180,6 +180,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
>  	struct inode *root_inode;
>  	struct minix_sb_info *sbi;
>  	int ret = -EINVAL;
> +	int silent = fc->sb_flags & SB_SILENT;
>  
>  	sbi = kzalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
>  	if (!sbi)
> @@ -371,6 +372,39 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
>  	return ret;
>  }
>  
> +static int minix_get_tree(struct fs_context *fc)
> +{
> +	 return get_tree_bdev(fc, minix_fill_super);
> +}
> +
> +static void minix_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->fs_private);
> +}
> +
> +struct minix_context {
> +	unsigned long s_mount_opts;

This is never used. The context is typically used for storing mount
options during parsing, but minix has none, so this isn't needed.

> +};
> +
> +static const struct fs_context_operations minix_context_ops = {
> +	.get_tree	= minix_get_tree,
> +	.reconfigure	= minix_reconfigure,
> +	.free		= minix_free_fc,
> +};
> +
> +static int minix_init_fs_context(struct fs_context *fc)
> +{
> +	struct minix_context *ctx;
> +
> +	ctx = kzalloc(sizeof(struct minix_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	fc->ops = &minix_context_ops;
> +	fc->fs_private = ctx;

and so it doesn't need to be allocated & stored, or freed.

-Eric




