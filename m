Return-Path: <linux-fsdevel+bounces-59326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F0B374C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103751BA363D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9D28D850;
	Tue, 26 Aug 2025 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baBlc2bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9823817F;
	Tue, 26 Aug 2025 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245984; cv=none; b=UGOZKcRVOtPpm2fyM3OppYxvn4rNgeExVi90/smMpifhxj9WJwX2ieAgnMFRw91inhAhkv7uwTzWMob8dKrniNh8GpV+KV/Y2Rwdhnuv/i1GRvdxim3SCrkShZUa/5TSNh87Syu1L/NK+cZIatZ6tMXI3Q9dIHz/SJZBwezxO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245984; c=relaxed/simple;
	bh=vDJBzU4m3Hm39oLtWDLszwqWtakfsHY8YYCWLG4yfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXyI9r8hnfSrRyfYeTiLiVs64T8ZdsfQi/kxAGcSqcVx07aio5p19ULNtlFohy0AFtX5zlqfP8+/VlIttGSJtiAV2tylLO+88XxS/y+BYoYrknHymzMY50U3L40RIkuQ6FIq6iqblF/lgyfSBWXYebUYB+cXbVEheEWLiaUrPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baBlc2bH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b4d892175so31046165e9.2;
        Tue, 26 Aug 2025 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756245981; x=1756850781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6vC6Fn5eeYPqcr3v1ybJoz5+MyT3oZfJ4fM8WDUIJk=;
        b=baBlc2bHE3gIt00TBhDyQbd85fpeqvEAo/xVto4BFRummJ2EDeHCb4LpIJ5k+tWask
         AFsUGncS510UoPEbiNiaXp4S8dVkE8+AEtGQet4IdcppYFdBtSKljQuQtkHGvMfrAoCb
         +Id8FJZp38sDOOGtcXC3BJlKdVNA2D7e63sdq8jE0/7/rb3tgo6YcRk85bRAWJpEDUPS
         H6n6dyHrtDK5azzSbxZZv6XPkcdIDOvcDPv160D9iniUo7Bj2Sd7vw98Kfm0jWqNRWYU
         UyXj0O4kT3Nc+x9FJgh3B0cmSkoNuXvOM/Rlc38ewoSlrFj2pGnRKvFG2LSeoBUKCVKM
         QvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756245981; x=1756850781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6vC6Fn5eeYPqcr3v1ybJoz5+MyT3oZfJ4fM8WDUIJk=;
        b=Yu4o8gPhJ1pIiR+J369Nfrx1QrmS2ffk47ENMr07mk/nL4tTETxM6OmArQfTcvOSJr
         7D+EsQa6RC5K9W4wTzL6BtHncqjnAkuEdgr+dFz8BbW4opaTYfwByk3DZWqXaFH3/8eZ
         PexyWm/NC7su7KrEx+wE1CVNW9VPXE9wfedhcGM85AWWPZL0twczg1JuMmqZ0UtHdkKq
         vi7nJYPkHp2tVGzFvSPegAg7pgXwyq5jBWBuS1nQvr536FAXARcPvWWha55ZlZTuiaj9
         ajQRa3SmxWsuAUFbC+7yiAX/03+mDFg+wfM1MGsuWEMtAMA3wnMWO/VsgOeMjtz4NmYR
         S9uA==
X-Forwarded-Encrypted: i=1; AJvYcCUet0xmFquRnYYaUagBuOlhytcfRu20MbzZJmN6cbB+wyrlTJSk8q9enmf6a3KEmdbNaJF7mbAFl+rB@vger.kernel.org, AJvYcCWggjDScQPdSjz0eLVx1kesRLWk1DaSer4H4c3Ec2I4bs30FS48+ES1VVDWRLbSSjPgqG923ZolWyvMMQ==@vger.kernel.org, AJvYcCXnWyZI60TNmQ5JWS261knwpiQfMrhMPqbkBKFjUqQcKmSdB9uO2fMusqsLSeOrcJNstsg8pYLhCDQ+Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdbdEeYrxdHLwGsR7i5yaZxkCAlko6N2Dvn8Wg7TKv7VsLZlF
	no55aOv21tYQ7RHBld0ycINhS583e2OF8j1nxclQ7UfiXE+x1rSEXDnK
X-Gm-Gg: ASbGncu+CKwnUGcDKhZ9ze60y2S+3Uurid/pyKGjBc06U+ujzMXz01d/K3340E9YzSp
	5vscsWguB62yn5Bh/bMxoeOsxdQ0z8l/adwHYT64GHefmCtDLNn5mxmMBt9guYkRyjW5FzkIIR3
	NpBTJE9VKjq/oomVPSbzdOmlBJr223s94kP/Y/Iiwwm24iWjd2tIMem7rH+Eeysuw2pn73gIfh4
	dFpn5+EaXNKdPQ8LZBsmTe3J+z84DBQeVqExXRbCOAsX/u5a3KvwVWCgeMmAnXbO+/q6iXFeT0m
	lUAm5WXuPJ8b9GAoR9KGGoEoBL/g7lFRzYoKfwhShbFwXV5QIgctzuDAZv8M0IAz135XVbSjQYx
	4rrYk/KfCQSoqdpxcT/xeOyIZ7yv/mWGUThmbMUOSuzQWAg==
X-Google-Smtp-Source: AGHT+IE71Hq9WAIJBAYy95k7pKZG8QwPjDe/BOhy/0ZPk0haCOJOVXxgmdQ4MQNoHE1C7IILw4kgWA==
X-Received: by 2002:a05:600c:1d25:b0:45b:6f48:9deb with SMTP id 5b1f17b1804b1-45b6f489ee1mr1492315e9.28.1756245981114;
        Tue, 26 Aug 2025 15:06:21 -0700 (PDT)
Received: from f (cst-prg-2-200.cust.vodafone.cz. [46.135.2.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm17956621f8f.30.2025.08.26.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:06:20 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:06:12 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 43/54] fs: change inode_is_dirtytime_only to use
 refcount
Message-ID: <3aoxujvj27dpehe2xjswtf73wqffahusomomjqaqcmhufz2pzp@kndlcuu7anam>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <caa80372b21562257d938b200bb720dcb53336cd.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caa80372b21562257d938b200bb720dcb53336cd.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:43AM -0400, Josef Bacik wrote:
> We don't need the I_WILL_FREE|I_FREEING check, we can use the refcount
> to see if the inode is valid.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/fs.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b13d057ad0d7..531a6d0afa75 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2628,6 +2628,11 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
>  	__mark_inode_dirty(inode, I_DIRTY_SYNC);
>  }
>  
> +static inline int icount_read(const struct inode *inode)
> +{
> +	return refcount_read(&inode->i_count);
> +}
> +
>  /*
>   * Returns true if the given inode itself only has dirty timestamps (its pages
>   * may still be dirty) and isn't currently being allocated or freed.
> @@ -2639,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
>   */
>  static inline bool inode_is_dirtytime_only(struct inode *inode)
>  {
> -	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
> -				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
> +	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
> +	       icount_read(inode);
>  }
>  
>  extern void inc_nlink(struct inode *inode);
> @@ -3432,11 +3437,6 @@ static inline void __iget(struct inode *inode)
>  	refcount_inc(&inode->i_count);
>  }
>  
> -static inline int icount_read(const struct inode *inode)
> -{
> -	return refcount_read(&inode->i_count);
> -}
> -
>  extern void iget_failed(struct inode *);
>  extern void clear_inode(struct inode *);
>  extern void __destroy_inode(struct inode *);
> -- 
> 2.49.0
> 

nit: I would change the diff introducing icount_read() to already place
it in the right spot. As is this is going to mess with blame for no good
reason.

