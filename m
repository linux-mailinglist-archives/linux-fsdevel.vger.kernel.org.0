Return-Path: <linux-fsdevel+bounces-38888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165EA097AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D06188EF44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85734212FB9;
	Fri, 10 Jan 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlS7VVcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1620E714;
	Fri, 10 Jan 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527178; cv=none; b=juOlL1zahkQAOC3LeznU4b+v+7/27ae2uxQmgvTJ++32zc3bFjLU4RqrDlx+L328apV4UO2Ura/z/e2bLouUBY9OubKoP5nNiuXrRNSLGt6ilXjRYMcTM5uwO6AIUNxpibSrgC1k4wVJm/0SvzO34g9UwI0b/sHuGhkBATz/15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527178; c=relaxed/simple;
	bh=wevkyyRE4XzWzc4iD5tWIkhakh/t6XUAOCgDphhxbkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO+a8d8c16sB6WiO3PVhorbRtgpPlnxCTBYCUicxEpar4cADoyUHx3yETOWmd25usiOtEzXiiYuwdRm2aFxLeV9yArNo0CSs36ILZWZRxfyHlTt8HCKdiR3I6QFm9cRzADjeXJZiknjR/ltoAX9XKMlyMVFsNM+9iCgo2UR+NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlS7VVcB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so2032439f8f.0;
        Fri, 10 Jan 2025 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736527174; x=1737131974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cAajNuheEIUxYToiDTKpUORJhZAX6ChA6pZVRkkTCDM=;
        b=AlS7VVcBDeaayAZKCX1MfvI3PQ0wW+9aTZH5VfUWfmxmG4QUWMICli5/uiyHbH2jkS
         VFLFEjwDBCprhzKd628DMrlGV0NEWjw6aBSY7gkhsFQS+lmx5X4yVIPJ9RyvD6Fjv1jQ
         cn8r3IPubteIbyjUL/6gUWBaXSPRp7QYoDcrc2RbjJNhmApHd3uI5+RwL+8kEhc3vDf9
         48z894HQQn5TN2UX6i3nYitPt7kdYfgzfpUWh0DbBLsML/VOczJe7x4uPkhbmSJM+6EA
         mTedNd/WguL2vskUMymx5noNNcqJMjVnIOSVoL2ZpP1gx9WauNc0m19d49vwGKXU6VYP
         Yv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736527174; x=1737131974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAajNuheEIUxYToiDTKpUORJhZAX6ChA6pZVRkkTCDM=;
        b=LuVuqhZlvIEhpFZ9k520CM6j+JTO7azGg+TiMqr/ZJGCTlIuzuH/F2B9qeaRUruc0w
         07sbUFkbWPzi5sky5MT8y7dUctkRd4bi8a1767/CK3/P4LEIlZolxNqTdoYu5io37Md1
         ZFBO5PIQ62LPzk6WE30G4+T+YGxNKForIjRQxFgiuLgVSr8MllINU30QKE8aLLaNiEHz
         GW2ChNns6jZNYZYe/O9c+ACAfbu0WB4gH0FeEqgN2V6v4MyL9EGgCEQiqgasxqFQobze
         sC3YXMRlLGhTW0uU4RNwyFaWJfE3g8Mg+0kTzsPdCmndB8Xk+PA+ORZ8U5DyRXbF0Ke2
         KcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5tYPE5t8TYbMWmZoajpRr4riNnfdN1wCvKiIMbb+XiLX9+UA8nFbwpYTHvGs1hHwRsUdxdFVWnn2Jbbcs@vger.kernel.org, AJvYcCUkbiU1JQ+8xH9/EWD1Y8FZjtnNWym/hYZLKaLm4H+rZmF11r9EWWdxNo/K2dxSYWGHEIShGYbWJltmZ29f@vger.kernel.org, AJvYcCWoXhW9UFYBvuRDVuMgyEjyXm5x2B6Ch2ss3ncaNj/6G6AVb9TQ0FgEnNvMTEMOd506ryW7CA4Sz2AawuBN8d9aOFNFDVaz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48gA8b/JEbU4cXF3ws1Pd42VunWEfbDxzQiflPv7IQAjGXO1D
	xTmd3jKK+Z6DQ1NM9KDEq8O0GtYeVAEQegs4q2UoQowtCnxX7Lsl
X-Gm-Gg: ASbGncvLZcTai7OAxLUEV5sNrVpy3w/0FiUIAN16mNTVO8st8eoJFo/Qlc9l2LhdnTs
	z7vsBza1G/DxxuU2kmrVd8u3Nz7GoZXqYQxSiOzNNRAbkYVfzo09kUg+JCnGDCvYN2OUpzrE3rl
	SL8JnrrQSI/Kl4HoqFvvK9nx5zFcJqMI1k/4XJ+Iuq7JuDF7+aEGW+p1n4/kzkoN4jW7gO0tNjy
	SwVVzuFqjB/bOsEY9V3hOfP3b/bgvQxDnFXxSOM2dmeKp9GuJtd8rvfCA==
X-Google-Smtp-Source: AGHT+IE+UIl5Z+Zv3YdukIMMEPj3XSnEdNDR30DgmIjSlt0D1Mxs/Sp/Et5ttrNPX7c675bRuwUX1A==
X-Received: by 2002:a05:6000:470b:b0:386:37f5:99e7 with SMTP id ffacd0b85a97d-38a872f51a3mr10210276f8f.33.1736527174296;
        Fri, 10 Jan 2025 08:39:34 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81b1sm5029255f8f.66.2025.01.10.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:39:34 -0800 (PST)
Date: Fri, 10 Jan 2025 17:39:32 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v1 2/2] landlock: Constify get_mode_access()
Message-ID: <20250110.672e9e7a7417@gnoack.org>
References: <20250110153918.241810-1-mic@digikod.net>
 <20250110153918.241810-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110153918.241810-2-mic@digikod.net>

On Fri, Jan 10, 2025 at 04:39:14PM +0100, Mickaël Salaün wrote:
> Use __attribute_const__ for get_mode_access().
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 7adb25150488..f81d0335b825 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -932,7 +932,7 @@ static int current_check_access_path(const struct path *const path,
>  	return check_access_path(dom, path, access_request);
>  }
>  
> -static access_mask_t get_mode_access(const umode_t mode)
> +static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
>  {
>  	switch (mode & S_IFMT) {
>  	case S_IFLNK:
> -- 
> 2.47.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

