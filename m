Return-Path: <linux-fsdevel+bounces-20559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B88D51D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5516F2846E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D74F88A;
	Thu, 30 May 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a38IplZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F24D5BD;
	Thu, 30 May 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094029; cv=none; b=NpYn5b7nx+E02PCyXzblSGES4+VPfunyhPrEwxnP2V2rkrmgJUpdTRChaLQ1yYkyfzVLrKjQPVEQHiac3aPf3U9Y0jbZBljejOnDxtoch1iUCIGsx6eEZkgIwkl0ETBI9+d3ElUNSLlYEMKAWmYJxI2l8yK7e2Esng5dh5ywDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094029; c=relaxed/simple;
	bh=HjjnrE5kOFOh4tEwSDoSGOqt6GOsa1kE4m+sHyQOkeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvj43oJvnrG7kfu+8V7nW95Km0CaG9LuHBUGomcBpRjyspXltUiLYiJIsx+nwpTfQBN1O0s/Ul4cgOBvyFIxnmukf2gX493zjcrU8JkgmC5mDI2SZ52lTDaT8s+zk0lpMhIHXqMaa5p9Sa1hwFA23dB8YS0yHMVEHRYVdMOrMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a38IplZI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f61f775738so7043815ad.2;
        Thu, 30 May 2024 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717094028; x=1717698828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eghPQlXH5B6siCX7AO+/cKxSt9mXEKhBpwWSkvOB0HE=;
        b=a38IplZIyzKl21nTSHSBavVEZCjxDkmcV/RUfpIwbkh6NcAqnMuiYbnynPyx3m7z7i
         4kxNnvfe3FBq4ir6NyeA27nGwLYnjoC3WcK8W0cNsgQZZNLTVaDMkeaMxMNA+UP6RJDw
         d8jPHeD3Yr7nJcjKovNtF7EwL35463T4hdcB3GbM3WNDZywB8/C1K+P0lEvEFmsnE8wv
         2EUKVfMIU54sgw3wYcxzn1hS7u6QM6pbxI3EzdcZS4ZDyRj6WaNYtAEFokXnryRcn86A
         54GK4raYuwMNh/1K80+188mhlPzmAbwz7B9SrME2zTlFSf0jpyPgB720Jc/jX3bjoNXa
         g6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717094028; x=1717698828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eghPQlXH5B6siCX7AO+/cKxSt9mXEKhBpwWSkvOB0HE=;
        b=YUqL6FzyYmZ+l0BsYsArQe80fxxjE2HDcJFo047pf9F3/zWkdZd/9AqeRDSBBEqv+0
         obrB56hkPc9Qvk5GqrrRIXEmZoShJapVNWhq7l2KKj0l2xQkhlJEjlSJJNb3cCfscFyy
         uCdPquNaHa1eq7tTb3pN9ZxeXQWHy/eazoI0iDzVjc7iUcPy5Rkj2pd1NxI8F13Ios+Q
         6Jq9abEm7cBp93WwWJnib1bc5v3ogk+SZEXFmKDfwwfmrPS2GonUco+pO+QV0TceiDGw
         jqbiWsrPcom9596VFC3dA7A9TLXa4XEZZpFE0r/vH3IpBuYuLtyFehZ+SYT2h3bK+Pqg
         Jdcg==
X-Forwarded-Encrypted: i=1; AJvYcCWngEDzPz50sWANCEfjZJR3/oL+ebtkNXlO6C3Jmata2ylBYTBG7y4eLe6OpoFGK9aXbG4M3gKOz38VAY7+27M4ROwWIzho0i3Cg2l+FfB/SUfbyWLK+VdX85zaCMJNxdvJMyIqj7RFWNH0ZA==
X-Gm-Message-State: AOJu0YwxBDQc1upoKM6QFZ8cCKuHI5jAkMrhixnUltxZF1ufGQ/pcU+b
	qnQTj4Rg1oxSRt3IShOVEKjY/kfky+u9MsExIF3lVl/8J6dBBs9e
X-Google-Smtp-Source: AGHT+IE9ZQCkNGKYoWv5GgCRExwHq9C646wxcmNRYsjqkc2Vq4/IkiHFHMxwWsIC0vxVYrQuCdkbug==
X-Received: by 2002:a17:902:f687:b0:1f6:1c72:955f with SMTP id d9443c01a7336-1f61c7295bbmr30209895ad.43.1717094027851;
        Thu, 30 May 2024 11:33:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63237d065sm1000155ad.111.2024.05.30.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 11:33:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 08:33:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] writeback: factor out balance_wb_limits to remove
 repeated code
Message-ID: <ZljGiunxmVAlW6EE@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-9-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514125254.142203-9-shikemeng@huaweicloud.com>

Hello,

On Tue, May 14, 2024 at 08:52:54PM +0800, Kemeng Shi wrote:
> +static void balance_wb_limits(struct dirty_throttle_control *dtc,
> +			      bool strictlimit)
> +{
> +	wb_dirty_freerun(dtc, strictlimit);
> +	if (dtc->freerun)
> +		return;
> +
> +	wb_dirty_exceeded(dtc, strictlimit);
> +	wb_position_ratio(dtc);
> +}
...
> @@ -1869,12 +1880,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		 * Calculate global domain's pos_ratio and select the
>  		 * global dtc by default.
>  		 */
> -		wb_dirty_freerun(gdtc, strictlimit);
> +		balance_wb_limits(gdtc, strictlimit);
>  		if (gdtc->freerun)
>  			goto free_running;
> -
> -		wb_dirty_exceeded(gdtc, strictlimit);
> -		wb_position_ratio(gdtc);
>  		sdtc = gdtc;

Isn't this a bit nasty? The helper skips updating states because it knows
the caller is not going to use them? I'm not sure the slight code reduction
justifies the added subtlety.

Thanks.

-- 
tejun

