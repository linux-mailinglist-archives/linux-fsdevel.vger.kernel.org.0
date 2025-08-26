Return-Path: <linux-fsdevel+bounces-59329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337EFB374D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6813363170
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523628C039;
	Tue, 26 Aug 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbgDHg/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6F30CDB4;
	Tue, 26 Aug 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246729; cv=none; b=eWT4KFvsZCfeOPTnURYI7pBBKUt9sqJDIdPi9HqQJDvDStLvD0KNvBwf+k2850L7AMUEq8WSf/8DZsG5Vb+qyC9ZPT+F4JeU69B7ylg9DlvjK/hB6xtQ52UwztEIJnVxe5ala1z0tmmvqM+e4ARhDjymxiJ0OAOFIFZ9IhykLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246729; c=relaxed/simple;
	bh=AetuBWMmw/6t54AG8a5ZO87tiIPQPeRZ0PeQFTc29PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOrgXApZOQ2bYU1PgOWpVsu9hlZguEV6PHPbljapJMj0e91zIlgjS2DK+OsXUhjefhMZssznT8gvTKJONPTUNargj0Ki94bVa9mXGFZqk7qxxBTXhudueBiRbuPjSHiTB8bQzClK9HycwPrEoGH+5zh4cTchktjv40IkS6038PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbgDHg/J; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b627ea5f3so11867325e9.1;
        Tue, 26 Aug 2025 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756246726; x=1756851526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsTzztZtiJ8L2utrdxff2Xitwgqo/0WZra/kFXABXtE=;
        b=mbgDHg/JJif3uchVxFvyZH9/tyawVSPR6l0k4G1OGt/39gb8JUPE1cJHGjXTs98jmf
         qT8tLzbM/GfINVn1ds5utdxs6RIg/8RrZoeQNOdiNIWUVaUXATEESY0Ot8Yo8WfmeR2x
         7qUqIxqQj4cawjLtqSdC8wVnnEgBpFQ5Px49iZkC70Hamr8BsZ4wDtjIY9DwPIdfnUZb
         bIALlYlZqUM89CNLLu2w5UU1l/jAH697UM/nJXT7SbpbeBa2OgtmrByVJMRhnPYr/Hev
         iG6UHPzKU0sw8bueEf6mtnYdq2r6uhMICBZS+DLKpr0VJXcDy9sVekPVISz2VXHzXDl3
         06UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756246726; x=1756851526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsTzztZtiJ8L2utrdxff2Xitwgqo/0WZra/kFXABXtE=;
        b=MJtFzBGG4FE8R0kQBpXbXb++j2l+4OxCNXmSRQJMnkqwV8cArNBHkNrtVSQswu5t06
         09dwzK/2Z7Vwvtq2qzDO/0fmrgsh+7YJnssJAtnW0Y8YPyPYtJ3Au9ctgouBjOIeR7uM
         1ph7sdvjWhGq/Cl17DmK0i5F7iZFKa2yhljn6eqQuOwsaWP8qdHZnAUbi+pBHulxdzXN
         hOet0IZJBmiWetTdNcxHglYdhlLQ0r9nbvajuyfopj/OcjhLuuBqAfpLxRLK73V+0SFf
         vLqvi7ZZuKhB2auEG9/ZJh/kaJyEYZI7u3r/BhXGoSZpQTB/DkuO1K7YcXvtxUNTNGw2
         PgZA==
X-Forwarded-Encrypted: i=1; AJvYcCUdM9373w2CvAwAa3fG22jmon7q1vleGjstBuHsrlzkxPNaizovufPmtj75uTAFH9d/vzg/kmjPrfV4Yw==@vger.kernel.org, AJvYcCXUKFd2lGiarZhdrs6HVRSD8ESJDWvURtsyrlA52Bz6izdiJCvPScm189CMKGRYpQdERWDu/3Zj7Ma8IA==@vger.kernel.org, AJvYcCXg8CIN8SMGPMP8pXqtIQWhsJQaw0TigYCpaZXGDO3E0C8tIlsdDCImjXBMkG2ibBbEuvbOuoIWZ2iP@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvozb6ml9v2m8ShoWClQoML31lqfgCbmd2mxl/vo57GIeCD1n
	HyC/knnO4Bj7+werLebhVpLP/KMB4mjlxJiwqQU7sQ/N61gD1HHwozGj
X-Gm-Gg: ASbGncseGidjUF778jzxSpLc5PgoFJY/UYjjC4AIAe65kTkXLC9ACDmYNbBAoCNwDxk
	GP0CeA/jj3wfnQnre+ciMyGjk6/adYspYoODQ3gOR+nEaV7uERy+052fzH5GP7m3zL6faQRPTFS
	Wq1iXkXheBJtrVeBmDoQLqOdR/4CEwP+k9yMqL6BI+L7fNUbGcqSvbUEJwQIss9wvvpjwbDmWnw
	i5rITa5RCrGZ6t1mqBzHOPLqD+4TMl7ljMWkXzX2iy8HXeZEEh24FVWHIHEUPSYHarVyRmfHMAQ
	WRehFPXUNOrhI3JtXHm/Vjddur4aaT8EZWslC/3LeSwiOOdS8Qm9VxQcg6iYBJ9edek6FjhjbuH
	21+HeErn/+9DOHZLHBAMPfFfvED4/4ChzflJmgex3Ai5vzA==
X-Google-Smtp-Source: AGHT+IENqGosWcuvpxyVpKc6QXcStLwWv0NFWtOjGkUDy/TTF3j9/YRV/+SwtDwSZAadW6RD9hyMcw==
X-Received: by 2002:a05:600c:1d07:b0:459:d9a2:e952 with SMTP id 5b1f17b1804b1-45b5179f2f9mr114473495e9.1.1756246725999;
        Tue, 26 Aug 2025 15:18:45 -0700 (PDT)
Received: from f (cst-prg-2-200.cust.vodafone.cz. [46.135.2.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cca0dd7014sm306476f8f.13.2025.08.26.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:18:45 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:18:37 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 02/54] fs: add an icount_read helper
Message-ID: <xvjqgfecmhgb4ngzmjveo7w5iib2qnh2te4x7hmpr7cjtul6mq@utgtnbfuxhco>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <9bc62a84c6b9d6337781203f60837bd98fbc4a96.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bc62a84c6b9d6337781203f60837bd98fbc4a96.1756222464.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:02AM -0400, Josef Bacik wrote:
> Instead of doing direct access to ->i_count, add a helper to handle
> this. This will make it easier to convert i_count to a refcount later.
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 079b868552c2..46bfc543f946 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -66,7 +66,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  		 * removed all zero refcount inodes, in any case.  Test to
>  		 * be sure.
>  		 */
> -		if (!atomic_read(&inode->i_count)) {
> +		if (!icount_read(inode)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
[snip]
> +static inline int icount_read(const struct inode *inode)
> +{
> +	return atomic_read(&inode->i_count);
> +}
> +
>  extern void iget_failed(struct inode *);
>  extern void clear_inode(struct inode *);
>  extern void __destroy_inode(struct inode *);

The placement issue I mentioned in another e-mail aside, I would
recommend further error-proofing this.

Above I quoted an example user which treats i_count == 0 as special.

While moving this into helpers is definitely a step in the right
direction, I think having consumer open-code this check is avoidably
error-prone.

Notably, as is there is nothing to indicate whether the consumer expects
the value to remain stable or is perhaps doing a quick check for other
reasons.

As such, specific naming aside, I would create 2 variants:
1. icount_read_unstable() -- the value can change from under you
arbitrarily. I don't there are any consumers for this sucker atm.
2. icount_read() -- the caller expects the transition 0<->1 is
guaranteed to not take place, notably if the value is found to be 0, it
stay at 0. to that end the caller is expected to hold the inode spinlock
*and* the fact that the lock is held is asserted on with lockdep.

All that aside, I think open-coding "is the inode unused" with an
explicit count check is bad form -- a dedicated helper for that would
also be nice.

My 3 CZK.

