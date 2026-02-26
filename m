Return-Path: <linux-fsdevel+bounces-78441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EMCOrPVn2n2eAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:10:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5821A0FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54EC2303980D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87F81DF74F;
	Thu, 26 Feb 2026 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbaKCl7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8C21146C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082599; cv=none; b=j0gryuh8ejOiIWrUGIWvoXgq4syZANUTJ7c+JmWl72MwX64s1FUCIEbMt2ovfg7d8Rc/+MFUrp8XIWUPfSAq8Roms3+Ihe2ZK7lr9Swu153dV3q3FxmVT8KjqHGydX0IsPFhwafH1AsQ56yesI7UgmzY9lVbutyc+Z+i1Sbhyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082599; c=relaxed/simple;
	bh=DMz225zEl3/E2V9JDP8J3BZhaLxmJK2btHCMC6dIVME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMIGDVuPQxA0xjpmbOuWqknel2yoNEAG+sJjRb9S73hFh96hVLlhqLbxzyGyqbXeZFhqrxUvtlLN0Pu7RqB9NTGJBjt93+qzonHqIPDLb/ediRo6Zo6EsfVd7EjMWwkfuWsLfgaHmWM0CWjSjS/rMGIHGiy5arFLl3WEDiPdWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbaKCl7n; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35658757f68so140220a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 21:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772082597; x=1772687397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs/TZhjcH33A0yzTeK4qfu8wJs1ydIh8o7nZre8IzyY=;
        b=gbaKCl7nB5OX/a3SuvBk9l56/c9GProc5Nv+6RvVpVDJbSgqz940lNtxvXcX8A4AoO
         iBCIM94kJAie0dHKYHcsdUE7mZCM9qR5fiQhHyQBR0GTvfZLSWBx4gJOqw+8XT7do3nC
         0lHdz2IO6r1sHVQnW0OfCe/2AWsQ4LywFFdJXdblKveXZZQCBtZDPgEZ7HNDP2anUCYx
         4YNB0GkuB/FBRA9fCGJWlG9ppnF9JgGRqFg3KN8R6TIiSXQQR4Dmjh6kWMyDmy1DDKSU
         wLzF+pHEQInAbx1rw77BleC3a+vaHZX3t1vXC2vCmy7gMURseGsHoN5HZRm/wMxgo2G6
         mOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772082597; x=1772687397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs/TZhjcH33A0yzTeK4qfu8wJs1ydIh8o7nZre8IzyY=;
        b=TZ4KxLSOpiBMO//315QvOJmCEs5MdFaV9B9zr3UYMEf2TiD/gjo//5OdtkFFSLXUNO
         5ds7i4019caTqE6M7bcm8givpU4eKVlvBJfwsJEOu++sfWOUN6XD5pLyYuESUXkfI5dv
         OkhRw0a7tpXQ4bZfBA9FYuOXWIIDlnJSVYD4UyB2vUDKpUZtCBDgBbcXItLmsg+SIz4L
         snMwVHIxT65+04pBvcYDUSYYCalxjYLiX4Fzq4ZEeS2X7geCyt6JFH2q3hiAXya5X9My
         GpQOEtVc7gQZm7QkJ+pHmQF1psYFgWg+u22WgvxPNlBGoz6pE1MHbOHRBHXS1dvXik8G
         jEJg==
X-Forwarded-Encrypted: i=1; AJvYcCX4cGpfUW6ZRcM7Zd2i7glEiRi9/aEAyCmmnSf0e8nsmBRDeqNWzZ/W/lTzGkwzIkf0XaRJ9PKw+LQuxI0T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzc5l23fSYrP7YvRvJwHr0dAwhtvdtn1MWghm8StYFnClKSGqd
	l6ZXrlsH7Sw0cxI0YnLJ5yaBwt4BlkE1xBhfROyQsL7A/NskxhIoT0QX
X-Gm-Gg: ATEYQzxnXAaBt9FFAK97BvRtGHgjZHdzxHQPmDA6gAQOplmzol/ReEidosGZysCtQhh
	TAoq76NAQaVcyKf1fblO80VA57dTrhYcN1Lhn4I/8g7RZvMegZ7EN+6jhGSe26TNvBbFv3qufsP
	8jGzvi3JP3TCIWKH90AWQf5ds4pumJyEKs4mN1NBV3+O7hf2lj4gnJahyf1tl0O5xDAjZNOzm3S
	hXdNF6ZxnQPcZzKYtHBAa5+zRjxzNwmH+TC8bibg3TRXKzGhO19silZKtO4T2LNwB9cuFdr+Uuh
	676gJCtYSJkDu8EIWVXrtoPr5xqYnUrnbdqczWv+R11nPSWHU+i4zy13JOxGzAB4j96SVp5Takj
	FEntgN6WaeYVz4+/tkGE4OYEOa2F+CG3uTK2O/ZlWYXgXAl0dtl4H1Xx9AwtpZEnziKfjoC4i/2
	4/huDzhGBIuktReg==
X-Received: by 2002:a17:90a:f94e:b0:34c:fe57:278c with SMTP id 98e67ed59e1d1-35928c501d1mr2600881a91.34.1772082597502;
        Wed, 25 Feb 2026 21:09:57 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc95a7sm708550a91.6.2026.02.25.21.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:09:56 -0800 (PST)
Date: Thu, 26 Feb 2026 14:09:54 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Remove unneeded semicolon
Message-ID: <aZ_VotoBN9lyitwN@hyunchul-PC02>
References: <20260226014528.3499348-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226014528.3499348-1-nichen@iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78441-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F5821A0FC4
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:45:28AM +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Looks good to me. Thanks for the patch, Chen.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 3f559df4856b..830dfc5aed2d 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1337,7 +1337,7 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
>  				addr, size);
>  		kunmap_local(addr);
>  		folio_put(folio);
> -	};
> +	}
>  	if (size == PAGE_SIZE) {
>  		size = i_size & ~PAGE_MASK;
>  		if (size)
> -- 
> 2.25.1
> 

-- 
Thanks,
Hyunchul

