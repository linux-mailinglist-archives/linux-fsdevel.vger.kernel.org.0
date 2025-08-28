Return-Path: <linux-fsdevel+bounces-59455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBFCB38FC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1375E0B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685E18C03F;
	Thu, 28 Aug 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="UAfrB0jn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FA2EAE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340815; cv=none; b=kgKRUQFYtUr7IWv9Qdp9zN/F8U1BydeULx7mWPrxkkS6VcftuPrgBEK5vcnmSwszfYVwf7lWKsYHGP1dMI+MdxS1EejoqpWOioKGEZZTSRDEwKuKDaQMj+EC1Mn4LNx5XMOAejPv2qfxPyMa5kNB5pVB8q4NM0Dm4EIn50qFHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340815; c=relaxed/simple;
	bh=CiHY/rsMO1JgljnmcpPdzbXavktzcXH6n5jFCBNd7kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu6aHmtIo/lBBL++VPMVOaVwlDcPnGJK6fqCTzQAkneWLJNhU9xTgnVG4e4u90ek78uN2ayPV/+vBUKX/vTpzhwOxoml/pojRdDyaIlTNxlrDgo2P036oaCO59q/Q8gOAt/MRlPn269fXqsxZ0UNOK31Ykjld293pacJebrNLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=UAfrB0jn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-246fc803b90so3742045ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756340813; x=1756945613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIbrank/pOEZcuqN2pISiixQG0KXR6H+Lj8n+OUb0e8=;
        b=UAfrB0jnykPMfT5vDgDLf+UhS86I0vX7npGjSpoMLC24bKY+GPsuC785SfrJIg3zHn
         vAAnz2KlnMybJ8OfV3k5uMo3CUG5mhfAOTWpUXN4ZvaVd8MjVn0z1RHN0UyJOazODxtG
         z0sH1460cEygNXwgqS/k7qRzJiU15tnTybJuhT4drX5AojwMoTPXMFxJj429Jx/LS6Z1
         o4ualYIadwaYWFjL/pqv00zZLJtROf1KN8vndiPsv4i0sUvnoUUnOTSMRzOcF5sDXzgb
         2sVFV+r1v98KPquB2H2jiLZY1A8/bpmChBTdQcAJCN5UScVPBkfP8g2TWfAIbhL/uBj6
         D9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340813; x=1756945613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIbrank/pOEZcuqN2pISiixQG0KXR6H+Lj8n+OUb0e8=;
        b=M5//OSErWaaTT6pwjm61XQ3bHLZuAytI2L9NI2+LXPGcdr0/t0ArN1ycKy93nbg5Vp
         yCamv/4exu4hvON0BVQl7OpUpLn4LD32wTyXI/7RWm+nRE4L2G+4UyaIX11Hrs0ZmlYu
         Il5PhpzrXtvZDagph4seD5ZTzfOUI61pcv3j5s6U80TPKuR1yiMiysUOtgxo8TYtStrn
         GGnqHVlUkNsvI8R3cQ32Xws2RnZTZRoCcM4InK0xoLStcGlklVBe0yP1hQw03Jcuzqyx
         52oVe51VxF2nisy/Ue6L5jqVMxUiNedBhLU0qA5G+hRlhJ1fhs4oX+TVWHtVfN7zLDgC
         H2dw==
X-Gm-Message-State: AOJu0Yw9vDW/sjwuHjcSrJjCc5631G9o6sT2PxeZ1gORYVH7EsnVRAJT
	tNYPRrB4ci2jEwrqZAYuWYZkoKscB3bL7a8CDpOZiPgnYnoPZWI1AOrfjowLC794MCQ=
X-Gm-Gg: ASbGncspTui+Lv2fCWBc3lDZXNMokZizZKx/977jE15CPdKxkglNujytC/q3Ds2aBNG
	3Yx2hHqRR61w1pwes3dMbCXIrj9sYiPo03txKUAgTHHETQqhvH6+KWaI0o5o3NmyjYnac7g+Spo
	BKx7bvQfONe/IUB0K2ynk5laZXxt5rEwD1QbTRjFJj1FpF1xB7ebgsFRNnmSGvtUyzEZWKudETE
	Qr6Ds61uoBvOwBWpZcjnGzZXBCP35cO9+CAo/lkr0QpGqF091a5t8IvDWR0oJTlwVgv4QbJE/Gu
	rdgvREkkjPX4ZLAVckembbFI9nzdiYZEKRr/5nHEoMl0RlzqlA0mTZ57IymXArYD3q+NH/A5GHC
	pvXI/4ARiJsxzk3jaBM+tmU9mPc3iWnJbVkeNS7+HPs9KLQwvyM6CVOyyLT+pAlCxnWdp5wjiRV
	ua+mGUZHZt
X-Google-Smtp-Source: AGHT+IFK5hxc7bYLtaOFxGe9ricq7ACFEmb4qM2KiH4E4yFcbUWB7uOpNMCQ2mvzULlcuE6v1Dn+5Q==
X-Received: by 2002:a17:903:acc:b0:248:b8e0:5e1d with SMTP id d9443c01a7336-248b8e06116mr39556925ad.49.1756340813131;
        Wed, 27 Aug 2025 17:26:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24875471811sm49697605ad.37.2025.08.27.17.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:26:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1urQTa-0000000ByQW-0gL8;
	Thu, 28 Aug 2025 10:26:50 +1000
Date: Thu, 28 Aug 2025 10:26:50 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 53/54] fs: remove I_LRU_ISOLATING flag
Message-ID: <aK-iSiXtuaDj_fyW@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3b1965d56a463604b5a0a003d32fe6983bc297ba.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1965d56a463604b5a0a003d32fe6983bc297ba.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:53AM -0400, Josef Bacik wrote:
> If the inode is on the LRU it has a full reference and thus no longer
> needs to be pinned while it is being isolated.
> 
> Remove the I_LRU_ISOLATING flag and associated helper functions
> (inode_pin_lru_isolating, inode_unpin_lru_isolating, and
> inode_wait_for_lru_isolating) as they are no longer needed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

....
> @@ -745,34 +742,32 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
>   *			and thus is on the s_cached_inode_lru list.
>   *
> - * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> - * upon. There's one free address left.
> + * __I_{SYNC,NEW} are used to derive unique addresses to wait upon. There are
> + * two free address left.
>   */
>  
>  enum inode_state_bits {
>  	__I_NEW			= 0U,
> -	__I_SYNC		= 1U,
> -	__I_LRU_ISOLATING	= 2U
> +	__I_SYNC		= 1U
>  };
>  
>  enum inode_state_flags_t {
>  	I_NEW			= (1U << __I_NEW),
>  	I_SYNC			= (1U << __I_SYNC),
> -	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
> -	I_DIRTY_SYNC		= (1U << 3),
> -	I_DIRTY_DATASYNC	= (1U << 4),
> -	I_DIRTY_PAGES		= (1U << 5),
> -	I_CLEAR			= (1U << 6),
> -	I_LINKABLE		= (1U << 7),
> -	I_DIRTY_TIME		= (1U << 8),
> -	I_WB_SWITCH		= (1U << 9),
> -	I_OVL_INUSE		= (1U << 10),
> -	I_CREATING		= (1U << 11),
> -	I_DONTCACHE		= (1U << 12),
> -	I_SYNC_QUEUED		= (1U << 13),
> -	I_PINNING_NETFS_WB	= (1U << 14),
> -	I_LRU			= (1U << 15),
> -	I_CACHED_LRU		= (1U << 16)
> +	I_DIRTY_SYNC		= (1U << 2),
> +	I_DIRTY_DATASYNC	= (1U << 3),
> +	I_DIRTY_PAGES		= (1U << 4),
> +	I_CLEAR			= (1U << 5),
> +	I_LINKABLE		= (1U << 6),
> +	I_DIRTY_TIME		= (1U << 7),
> +	I_WB_SWITCH		= (1U << 8),
> +	I_OVL_INUSE		= (1U << 9),
> +	I_CREATING		= (1U << 10),
> +	I_DONTCACHE		= (1U << 11),
> +	I_SYNC_QUEUED		= (1U << 12),
> +	I_PINNING_NETFS_WB	= (1U << 13),
> +	I_LRU			= (1U << 14),
> +	I_CACHED_LRU		= (1U << 15)
>  };

This is a bit of a mess - we should reserve the first 4 bits for the
waitable inode_state_bits right from the start and not renumber the
other flag bits into that range. i.e. start the first non-waitable
bit at bit 4. That way every time we add/remove a waitable bit, we
don't have to rewrite the entire set of flags. i.e: something like:

enum inode_state_flags_t {
	I_NEW			= (1U << __I_NEW),
	I_SYNC			= (1U << __I_SYNC),
	// waitable bit 2 unused
	// waitable bit 3 unused
	I_DIRTY_SYNC		= (1U << 4),
....

This will be much more blame friendly if we do it this way from the
start of this patch set.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

