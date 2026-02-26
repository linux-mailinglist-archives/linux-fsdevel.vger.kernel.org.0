Return-Path: <linux-fsdevel+bounces-78444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJotNc7cn2nEeQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:40:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA51A1131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 06:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F390C304B598
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C538A73B;
	Thu, 26 Feb 2026 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFymoI+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46538A733
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084419; cv=none; b=C3F8GHRqbtlfAUKaCVvIMWTaAfFbUrk2j8lrpOWwhn2G9cYQoQXlgbAMSRE2kwg5TS61GnsCJm7ETTfCnX47ck6+eHNcU1wy4aYQhkEkmwKE69ojcB5DwoPdIZk3rQ77Z0cYS7xxaMl7BknB+cVPH90sDmcByVj1RPkRFi0fL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084419; c=relaxed/simple;
	bh=0e+CSqkJrh+3JxODLUgXItiizLAX8whwzjyyf34mztg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4mGDfSkJUQZ+/VFsFMFQ9NiHkrRG2rSBfXrbR9G7fSMCzzORRCAJTGpUtBXW5jIm65TWlx7RPRvNuxQTvepizOfuzLW672uptD8bYC8eOl6Yjz7GESgeKydmZFx+7+2gIYgwb9eI0zJPRMyA8pQm7HJNI3q5qVN5fzq/8bjXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFymoI+W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aae4816912so2954395ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 21:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772084418; x=1772689218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdCopaZOQhauzeHIWCcMqPcRan0hj6MnkfirmBvy3bA=;
        b=MFymoI+W8U1O8eUxTemzsql0d6tBHevPI/SPXox/UgTe72/rH5Bqqi/OBhsKwZ87JK
         4n1ykhrNBcO2WZe6pqW8lzIT/30rqgUpfX5+s+x+8BQJPUeSSMNgSEsJYcGX23CjPKeN
         olRxJDyOUAiR28CL5NRNc3H0FWGb3jMHzD/hy+2LWLEe6+r2MwFb698rOqs9m6esqjeO
         JFTJAA22iW3TxrbY84OJ4JeIN/9/nu/n4MkYxUWRBqRBMmC0cOSzzEI6YKyGjbKvtWUJ
         Jitp7vEhL5EB+8ogW5S1ADH0wIaGeKtDw9tO5sFKI/o0FjA57k0ME4m+mxw1V0fzQeTO
         s0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772084418; x=1772689218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdCopaZOQhauzeHIWCcMqPcRan0hj6MnkfirmBvy3bA=;
        b=BDTzyEgqlL+3QdXeKE4aFY6F96bM7IpxPwkHdUxYJzNuVcFdQWb3iW7QMorvFe5lSh
         VkUF3Mhu03c+lpj5eawaB3F03d+n57rKR62ejT7hzTz8IfKwOmw/m7qSVfREbznbAdRL
         Fwdd/OHbAUkILXecfTJj3/aBVmnaEeYjtE0s7ZZfFPBlxRq9EnOpsMgE7ksWgHbZWHCW
         lPwrHIaTjtjraVWwAWJGtg9ShkLYOcU150530DSBGLEdG7Zc+PybpyYrgLtZHF5d6jqZ
         vhxiBAH7tRU9070h70N6wHjZVP5X4LLAeRAN/YR8awjufXa7LVZ9mffgk8H58ZBEJIS9
         57yA==
X-Forwarded-Encrypted: i=1; AJvYcCUfj52v0FhkuCKjMPnLOxhxMrcdKv69EBZd+6WzE546zsa+xdHh981KgGkofqDSeKB3lkBDpWiKDNLYbuEW@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtGIswP5kPm79LWOq0tLkfy/Mb+qrKxRXTvOZi7m396to5TxX
	YjPUfMO30IrBqpSvwKSq9AXbF+9wdcsbOnztCy9oTxWYpZ3eQRbgMaMJ
X-Gm-Gg: ATEYQzykJWyNCueshNDSo0s8LF+AymS+U0+tidrriJlKdPhUkL0VI7bING7V59KVfyE
	hIcyveO7+RFvYj/sOjmw3eW9mE0J27yZ5z0q/EN56IziftcdWcRzHhvdRuo9wCzcEL3wFBaO6u/
	tKPkr34dIoOua8f2O6gSu0jNVv/QzYVIYBiN/dHdEccxJtQ8CWgXnHyQkHvWs1bAdeS+11YYXUA
	NRsOoGpBxmWPoekvfe4KB2xI5yvuX2ayry35onMgnrnPrkTTQUMQtB/H6YTybj93RFwVhLHeohp
	ht4Y+j7g/yZwAm3xdqIVXX4Kl1eG8RDszf/bUvkXow6NJ9m5Xzr4Xf3kLLt3usTI4XKX8sfCDfl
	l/KiGo+QBQvvILa6YMNCXW/Tca94WzjY8lAabWtzW/oySZb4PpsQrMStzOU/o+f0G+Ou8la4ftm
	bHylyQ2tJrQ1xAbQ==
X-Received: by 2002:a17:902:d549:b0:2a9:3396:738 with SMTP id d9443c01a7336-2ade9a55354mr27972395ad.44.1772084417854;
        Wed, 25 Feb 2026 21:40:17 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f3436sm16994115ad.88.2026.02.25.21.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:40:17 -0800 (PST)
Date: Thu, 26 Feb 2026 14:40:15 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ntfs: Remove impossible condition
Message-ID: <aZ_cv1eMxOr-D704@hyunchul-PC02>
References: <20260226040355.1974628-1-ethantidmore06@gmail.com>
 <20260226040355.1974628-3-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226040355.1974628-3-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78444-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51DA51A1131
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:03:55PM -0600, Ethan Tidmore wrote:
> The variable name_len is checked to see if it's larger than the macro
> NTFS_MAX_NAME_LEN however this condition is impossible because name_len
> is of type u8 and NTFS_MAX_NAME_LEN is hardcoded to be 255.
> 
> Detected by Smatch:
> fs/ntfs/namei.c:1175 __ntfs_link() warn:
> impossible condition '(name_len > 255) => (0-255 > 255)'
> 
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Looks good to me. Thanks for the patch.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/namei.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index cecfaabfbfe7..2952b377dda2 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -1172,10 +1172,7 @@ static int __ntfs_link(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
>  
>  	/* Create FILE_NAME attribute. */
>  	fn_len = sizeof(struct file_name_attr) + name_len * sizeof(__le16);
> -	if (name_len > NTFS_MAX_NAME_LEN) {
> -		err = -EIO;
> -		goto err_out;
> -	}
> +
>  	fn = kzalloc(fn_len, GFP_NOFS);
>  	if (!fn) {
>  		err = -ENOMEM;
> -- 
> 2.53.0
> 

-- 
Thanks,
Hyunchul

