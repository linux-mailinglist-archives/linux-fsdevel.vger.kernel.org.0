Return-Path: <linux-fsdevel+bounces-40479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB3A23AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F294D169228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768C170826;
	Fri, 31 Jan 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0IQveLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B916E863
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312812; cv=none; b=E3ib4xPL5uzRykU3io1GjEow5j0SIQZI/vz6eSCFb3nCSu5WDuBaQmuSnkkMVVxvWYvJz8t1jCkMeApijbCIEb0gbZ2hdhlkkZJxSO9VaDm66FT6+0+NlD8In5YA/8oFeU8rAc7XbYuZYzl7QBdMYrYJE1EZwbCAFOAN9XKJy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312812; c=relaxed/simple;
	bh=l/POijdq0AKYrlhYqcnG18UNaqfR+4/MYXeh403fXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIM5DFYZSLuChTHF6wJUJjTi9YOfOQ/vQrvuLUPAW4QKuOaOoWyt8ETcAx0o1F8q4ZZV1zmcC/yICccC1ocoygBRqDVALti3Amyy++kUwZREuzcZZ8x+dJJ5lFvj0hJywOB2kHHcnqpBUVyycJ8jPpVa59jRL+EmhlCXw7/eEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0IQveLG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab34a170526so280743966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 00:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738312809; x=1738917609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fWOGICQN9my2rbxgynZ7r3mlpoPZThnbsR+WYwfiZU=;
        b=R0IQveLGwTbh/iT2UWYB8j9iL+scgY3YGcoWuKaEHXyw2R9ePka+6Vqsbi64swEWu6
         9J5T6PWKvaCHT6FteaRJTWhMeYfhq9w+FZcvMklQgWs8EUoPV9E/60z3G/va5O8wHVPq
         StQgfVPyhVKE5Bvj7X1Z0P8X7Gv2tiUbRnZEVnjdWB3xA2sIZW42S4h3tMpJ2MRUkgwK
         TDOrCLN1RQXi5MIWbUBwMRy0HlMhFBongC+kP3COItW8spisnAaLVKUtLrVzrD6AnAlX
         Z1rqbi0pUrEh/Z6Gzd16SsXaWlJx71uXyWO3piG/NQhr95HqBX+mkPWOf7mt6U7dwjE9
         7rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738312809; x=1738917609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWOGICQN9my2rbxgynZ7r3mlpoPZThnbsR+WYwfiZU=;
        b=ZMcvDgpKI8ej54gyzud45z4j9xlrFphMUaDWLg79IG+net2Mj9m/qPyEfaTAZfbEs0
         R4VwVJQzXyq0vdr4mdlxx6EZpwHRxQOkDGU2yDfp6ULvSB6Fi5f9xNo088OMjp89LnmJ
         QUEENjf/eY+ob5fCOvC3AbPSGVFUJjd0XFn/le2qaIffeyJL/7K+NJM+9uvAKSNZNiGk
         OyDdsz43q7AHY5M9GvKHE1Le1DM09kaIzGyEpkuLCX6NQ11VCklQhsZNRwjYrb3zMmYj
         3tlXnvQFjenm7/BOdR5hXYxS54QuVWWgzrh/RThC3l2ZCD3aTvwdBIQBM8ELZrQ+Ox4d
         Edow==
X-Forwarded-Encrypted: i=1; AJvYcCVM5+y1FoSRJTfgB3OMzVVr3EnWg0td/rlSdcMADxYCNySSL3KxO3g1mURkBydaNhUHzEpu7o0T40GSXJq9@vger.kernel.org
X-Gm-Message-State: AOJu0YwroHlvfPLhIW5e9AYA8MDHLnWDtheOKZkTCk8N6mmsIBY5buFO
	W/O3NVKw1R2R57I51uQqLPBatvWVIhBDygD4mwahcZGDScW9SjLllfGtI5PMRw==
X-Gm-Gg: ASbGncvEv5C2N9YcGYXa/ZKW9jlQmHFAp/y1TQkgCDdSzQVy6gDhXJgou8A58WQg+wK
	h14Wo33YuUIXk27SHu9+Pmgkc36j7/tAr0xpYcla4hw0OjUYWhTlTv8RCYlBa/+yEPsUjtkKeFq
	z9BPC/bdHpzB4MnFRqphyPrFKllsfk6ced/hfgF8vVvINDoSoKXZUBxctAzHsRIgH83m1nKxe9Y
	6XDCxWhCdvJRbwSdYG96HXeS+MoCNjBR70sC1jYgWn+R7F9x2Xk0pWCvAVn1+HZ7UZXqjAqLPRw
	KA6WLcoZUVFA0wsN4WAjPvp/a4SWRdAma+R7oZpiFxum63wMVUctVVJ81w==
X-Google-Smtp-Source: AGHT+IGc66AisMi+T21YVz5kV2+wGdqam815E3zK4evkRVJys/4pQlIeDgu1Bo2DlXU2pQKmlChh2w==
X-Received: by 2002:a17:907:1c16:b0:aab:c78c:a7ed with SMTP id a640c23a62f3a-ab6cfe12c99mr1095675166b.49.1738312809270;
        Fri, 31 Jan 2025 00:40:09 -0800 (PST)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf924sm257502566b.69.2025.01.31.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 00:40:08 -0800 (PST)
Date: Fri, 31 Jan 2025 08:40:04 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, liamwisehart@meta.com, shankaran@meta.com
Subject: Re: [PATCH v12 bpf-next 3/5] bpf: lsm: Add two more sleepable hooks
Message-ID: <Z5yMZEn-BXhJwq5e@google.com>
References: <20250130213549.3353349-1-song@kernel.org>
 <20250130213549.3353349-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130213549.3353349-4-song@kernel.org>

On Thu, Jan 30, 2025 at 01:35:47PM -0800, Song Liu wrote:
> Add bpf_lsm_inode_removexattr and bpf_lsm_inode_post_removexattr to list
> sleepable_lsm_hooks. These two hooks are always called from sleepable
> context.

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/bpf_lsm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 967492b65185..0a59df1c550a 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -316,7 +316,9 @@ BTF_ID(func, bpf_lsm_inode_getxattr)
>  BTF_ID(func, bpf_lsm_inode_mknod)
>  BTF_ID(func, bpf_lsm_inode_need_killpriv)
>  BTF_ID(func, bpf_lsm_inode_post_setxattr)
> +BTF_ID(func, bpf_lsm_inode_post_removexattr)
>  BTF_ID(func, bpf_lsm_inode_readlink)
> +BTF_ID(func, bpf_lsm_inode_removexattr)
>  BTF_ID(func, bpf_lsm_inode_rename)
>  BTF_ID(func, bpf_lsm_inode_rmdir)
>  BTF_ID(func, bpf_lsm_inode_setattr)
> -- 
> 2.43.5
> 

