Return-Path: <linux-fsdevel+bounces-26561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27795A7C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC37B1C21A33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BC17BB3E;
	Wed, 21 Aug 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eM59lYTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565017B402
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279313; cv=none; b=nk/UyCI4nel3QiEt4QeMJOeOvMEDQEqNddv3I+Uyw6WGl4qx+NN5iTKGmEtSTq0a89wNsomygfrnYRwGFJ6gXPSA/pwyN4uKoNxyRctVakFLgOsEol5z607/zUAmBAMek73E6jCk8jOL39++3ON657M9j0/VM3hUvZrdDan115w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279313; c=relaxed/simple;
	bh=RMUuMCQE111I0Rq/+B/pKBi7nyN7vqYX89nd28JyDP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgjrK3MWgle6PNTpFmeiRCMykmF1qSYP7cOAAxRKDSPdoOBPo8f1rVC+tacWE3ZDMqdWtDUYlMYFuseRM3wpxlW2z09yhnZ6YzWDh0A5Pt6AmZqJPYWRQ5s66ctW+l/O5rekwD3L7HFImXk2DO5ZJE7uy3bHBj36HdR7pNu8L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eM59lYTd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso145864a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724279310; x=1724884110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYdrqjayoOAXolgg2y+46/dZIYlFgBxiHJ4sgnPp7co=;
        b=eM59lYTdeI1UEox3f+3111G9rXsihuzfBmGMvVXWMJ7ifjwWtuAT6kKncs/lVWvFNy
         3H873EzOz+zlUe30xqHx0QaEyQVjjjcUMsxK1kOxPTpbMZw2pgyByutzxImspw+Q12kD
         T9v0oiXuR5mZDtJq/p8FPH5aedpq/OTwVEES5Od2WghIDAZ4Dbp8q3DzVg01CwhlyPYa
         EU82j1XBFj8XvDgLXfMTC+cTEDql517uCdwHD/s1ksaJF+y3UmumJA2687m+AzFhUOxC
         og0HHWsbJ8SEBhKJpCx4qrKnKgGfCfvt9L7/NqRPX5+MEHiFR6ESDC/DPSkhe9/JYTXY
         yYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724279310; x=1724884110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYdrqjayoOAXolgg2y+46/dZIYlFgBxiHJ4sgnPp7co=;
        b=NDwLvNB6VvhjEmi7JWplwHkyg70eKatf5cHOE+bTbHNTxoOnLy7aF8b6twKoKFjkTM
         nLPOyrOcSAGfWjd94SWAbue4JVTKxN/pxeOmN7SaZxCCd5R6GkFQoYWXrA3sXuklYdFx
         QBLuOi+CZMgDrOonYoEFChIYSw/7pEwHDXRMqUIFNGF2RR2W1cu6CikJ/iH3mofnn3p7
         +WFlAkNMy2v4yUcjkjnjeXm5gox6NpSF9FkXpccStd14LJd6qCv7NKusPQ8FYqic3bGH
         hL1VlkEv2hCbaHQI1afCf2tzqT7mgEV+I7ZjBMxvFP7L42XkRrOYzTIWqoqVB1xKbF1B
         gs5A==
X-Forwarded-Encrypted: i=1; AJvYcCUw41r5hJ4Ia5pyPfcA8lhV+bf7lVJzCvJu7YYgYBNKsqH/OflyPDcPif5HppP+033yayXlueMqZQNI6UXi@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCfWCMSesUeqJFKrUHAVRzRGGBXE1N0UOmnPGYiyjRDfVgV6J
	WDa8qLl3AkVEIpJ59FNGalrjyIks1nTcZxBK5fU3paIlozwCuV9UnbeyKab6gVw=
X-Google-Smtp-Source: AGHT+IHtARDEYQoMlJAPojk1MsjNSbgmFDJCsi8Bb0nc0lVJFwpClh89sJOVA5HLsA5kPZhEgYQnNA==
X-Received: by 2002:a17:90b:714:b0:2d3:c664:e253 with SMTP id 98e67ed59e1d1-2d5e9a3fbb2mr4075746a91.10.1724279310376;
        Wed, 21 Aug 2024 15:28:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613af1468sm142704a91.44.2024.08.21.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:28:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sgtoY-007wV1-2u;
	Thu, 22 Aug 2024 08:28:26 +1000
Date: Thu, 22 Aug 2024 08:28:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
Message-ID: <ZsZqCttfl/QtMJqp@dread.disaster.area>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-1-67244769f102@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821-work-i_state-v2-1-67244769f102@kernel.org>

On Wed, Aug 21, 2024 at 05:47:31PM +0200, Christian Brauner wrote:
> The i_state member is an unsigned long so that it can be used with the
> wait bit infrastructure which expects unsigned long. This wastes 4 bytes
> which we're unlikely to ever use. Switch to using the var event wait
> mechanism using the address of the bit. Thanks to Linus for the address
> idea.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/inode.c         | 10 ++++++++++
>  include/linux/fs.h | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 154f8689457f..f2a2f6351ec3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -472,6 +472,16 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  		inode->i_state |= I_REFERENCED;
>  }
>  
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> +					    struct inode *inode, u32 bit)
> +{
> +        void *bit_address;
> +
> +        bit_address = inode_state_wait_address(inode, bit);
> +        init_wait_var_entry(wqe, bit_address, 0);
> +        return __var_waitqueue(bit_address);
> +}
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
>   *
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23e7d46b818a..a5b036714d74 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -744,6 +744,22 @@ struct inode {
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> +/*
> + * Get bit address from inode->i_state to use with wait_var_event()
> + * infrastructre.
> + */
> +#define inode_state_wait_address(inode, bit) ((char *)&(inode)->i_state + (bit))
> +
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> +					    struct inode *inode, u32 bit);
> +
> +static inline void inode_wake_up_bit(struct inode *inode, u32 bit)
> +{
> +	/* Ensure @bit will be seen cleared/set when caller is woken up. */
> +	smp_mb();
> +	wake_up_var(inode_state_wait_address(inode, bit));
> +}

Why is this memory barrier necessary?

wakeup_var() takes the wait queue head spinlock, as does
prepare_to_wait() before the waiter condition check and the
subsequent finish_wait() when the wait is done.

Hence by the time the functions like inode_wait_for_writeback()
return to the caller, there's been a full unlock->lock cycle on the
wait queue head lock between the bit being set and the waiter waking
and checking it.

ie. the use of the generic waitqueue infrastructure implies a full
memory barrier between the bit being set, the wakeup being issued
and the waiter checking the condition bit.

Hence I'm not sure what race condition this memory barrier is
preventing - is this just a historical artifact that predates the
current wait/wake implementation?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

