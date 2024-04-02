Return-Path: <linux-fsdevel+bounces-15859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C9894F98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A5B21E73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D25A0E6;
	Tue,  2 Apr 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uj1t0NZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E05914D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052575; cv=none; b=HKEu7NAOBkyHKIWAu82YFlRgNx3Tvswa40KzE42o2CJHfbBMQ4wsEBydRXtd+npX2yobeVjiUYVWx9+rpPlFWC9KS7gs37LVD/NZHeCNZd+5MgF6KiH4xLveyZx+b5DMbJ3yaZKZ5t+bVJowEYtLhbAVJa7w+8673bH5NJ1pMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052575; c=relaxed/simple;
	bh=OU9f/oHdpSv5so4XxuOO4NXfr+ACnzAx5W/5jBZ/xW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OasAS/9saPGdNm1ewh1o0d/HtacKS4s72M5KKMDxZF0wxfh25HAiLlmzhmd1VOLy6mqJzM/3JamXYE/bdu0H283OZ5NddaN7l7dAvsxaaKlUq7EY+fKPWekR1eamKb26d1SnxVjmQV3yp5bSoh8ECAa/P5RExNwVT7BNPtojYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uj1t0NZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712052571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2bp0ENkGdxs60VdgrG/Ao+HASiC17rsYdOAl+5ioPU=;
	b=Uj1t0NZVCzyOACj12i04yK0VfEfK8bVY2DbYTWDClepOy5YaoQ0aXMN9ixxZjn1tOMVT0B
	6Sf6E/Tr5KLnM+sCI+gF5rnyPkPU+By3orv8lm70Vl8vm4VOJJhpO22YoVxZifwwKquCx6
	tTwXaJKzd5WlwWcdWByOefyQSwOgb2k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-AAE01iw2PAy0D44wsr1eEw-1; Tue, 02 Apr 2024 06:09:30 -0400
X-MC-Unique: AAE01iw2PAy0D44wsr1eEw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56beb0ad4c0so2033095a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 03:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052569; x=1712657369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2bp0ENkGdxs60VdgrG/Ao+HASiC17rsYdOAl+5ioPU=;
        b=ttDB2stWdaZVdfMURlhXSwjKJO39oEytJSHTb2NH2BwVSc1z2UqTnKv29wMl2e43WT
         4hwznBN2hCdvrkMO9kWhpvvRmkU4ndcKhgkg0V2wxlynAzYYovdmCfYAfGk5CzloOGkQ
         LEnOPeDCEA0kQk3iN66mNt1/K6LbsNh8Bnsqz37JK2mi3dUYivpxGHwt7xOTdtmV/jQp
         WQ2FAuDaQtror4SEYuuU8jDvDl1DiGs0uw3QmJFW5vGJnAJV+C8AbwCjzQrK2gFQeM3u
         2JCh0TFk7mcI2N74oU27KMDYn22ACvVm8/pkdjaSPDIrUreX5cllhKUiBRKHRTJ+r0Wc
         qAsw==
X-Forwarded-Encrypted: i=1; AJvYcCXpyd4I7MGRzmn2WBlQlfKc3778Xvr8pK2R0GXvqms2tOByjc+ru2K2fQZY98y/5XnWl56yTk89h0SixcIXviq9eEAiJcBnoeX5whVgqw==
X-Gm-Message-State: AOJu0YyMk1wp6oeVWDBeSEG1ihF8YfPnbj0Si5Sd5qf2Q3MtksMFTHDG
	INf2eKoB4NkTGxOZeX/ikNKn6Ixr7y1hKAnyWkuv5HT8+YjgbZ/lpVK3+49PHUaFPu9T0Ap2sKC
	Y/HxFoZUyoB3t6KvA13zjNTjB76aC+EF1gDtZPKJjWr4AJvpK0zprWS/tEIb0o5nACCDR8A==
X-Received: by 2002:a50:d7d9:0:b0:568:180a:284b with SMTP id m25-20020a50d7d9000000b00568180a284bmr6072560edj.37.1712052569091;
        Tue, 02 Apr 2024 03:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2u/iYin6OUN30jHEOhcY414TrEvqk+AMnddAkYTd2kcCDkV6Z9aKRNEYtCWRv/9yomjo8ZQ==
X-Received: by 2002:a50:d7d9:0:b0:568:180a:284b with SMTP id m25-20020a50d7d9000000b00568180a284bmr6072551edj.37.1712052568633;
        Tue, 02 Apr 2024 03:09:28 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id n3-20020a50cc43000000b0056bb1b017besm6549855edi.23.2024.04.02.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:09:28 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:09:27 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 02/29] xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
Message-ID: <33acelck44533qoui3avtjbehb54rvf2j2opmxhpflf4g3kr22@wkipgjny64yn>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868593.1988170.18437361749358268580.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868593.1988170.18437361749358268580.stgit@frogsfrogsfrogs>

On 2024-03-29 17:36:35, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Turn this into a properly typechecked function, and actually use the
> correct blocksize for extended attributes.  The function cannot be
> static inline because xfsprogs userspace uses it.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_attr_remote.c |   19 ++++++++++++++++---
>  fs/xfs/libxfs/xfs_da_format.h   |    4 +---
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


