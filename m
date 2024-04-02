Return-Path: <linux-fsdevel+bounces-15910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D3895A82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 19:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32523B2175D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1015A48A;
	Tue,  2 Apr 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvN3eUUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219F159918
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078114; cv=none; b=NU9ciWAkGVf+e3cxWLUc1csXG0ehq9BCwHq6x/EC4yhIek3GRsLuveapAh5miLEDz/1D7RxzS6hH5ya0GeC/b52EVmF+mQsQqq1mvCjJFoTg6cCRWWKhDYuKV4c1cEtFksXmOvY3pbGO78S/vTkR/YdiPjJVMYNvuZl8/KcZnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078114; c=relaxed/simple;
	bh=gONxLiG/KtKALcV3UaKI4cYHp0a8d+JcZLnRPZyZ83I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJlLR6n1PclguVYtAu74oEgaLtQDNMqn3yTqqnd+RceFVIiZYJh0Fh9IuavVm0cguVc9rpOXI6A6V46x5UtGP7Ce7nCLocwx1CfBvOWzh8uKJuA2Sw49d9W7pbnsFqTt4tAPitSnFcgXOFqcdgADPb4c5zfvQz6p/S/7G4bxakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvN3eUUT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712078111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JH2SMOejoMJVVtHeJkNgAl35h2UZLOewvGHfqdN+G3A=;
	b=bvN3eUUT0j1ZU0cXHtJtvugFFlacexwIR7NkIzb635p32z+nAAnIhDHYAhVCH5yCPAk0Vo
	3IvybcoPyx0XdztbCMPQIObXVLQytgucF8JwjAay+gZKZmy1kCZyxTvmSmpUN4HkNgIlZZ
	xgwPFeZnY0WGMWbPXIM+lEAqsJTctOk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-hMZ8hswLNYeAqB7FePCuxQ-1; Tue, 02 Apr 2024 13:15:09 -0400
X-MC-Unique: hMZ8hswLNYeAqB7FePCuxQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4148b739698so24269065e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 10:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078107; x=1712682907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH2SMOejoMJVVtHeJkNgAl35h2UZLOewvGHfqdN+G3A=;
        b=JVGf4xwnw2WeVoSEqjZ9f0A7oRq/L36rnIrSpvTrm0tATRCdChlO+mTaAhnbBN/3mm
         T+VAeyxOgJVKGnNVd652J4oo+mRnCaJ+7xWv46HB0QM2pVxSGj0RAj51g2lRnPFDJX+n
         QpV479H0j89hPivqcKdew4w2JYDKacLvxkcHkZYskeBmN6EVQH6XyCDSeap6FCAakGgm
         sVoTuB1RwK2E8rq4sgge8R1WDPsUCNIsG00GIplxojzsLQ3fH8Sysjsksup37BnClCYI
         56yi0CB7kKDS64y4B5p/Y9l5VyN2a214ObrrFtSb+P2RWAkO3YCUb+Ce1tBmWS6rgcqr
         kkww==
X-Forwarded-Encrypted: i=1; AJvYcCXyOW+lM2/fEmv1J0Or2LE2XaS/IMfuJWABtBh7dtjBjgNNQidXGgU3hcDhf9oMIjJ9oU3J69X3GLkY8cIYbUeEkF0gaYXPZYp6wa06ZA==
X-Gm-Message-State: AOJu0YwRdUJ9cmH8HYk+ci2M+Gs/2u8tgr9/vO1mxdWNwScCtS3auHd5
	7OKsxG5qEPNPEuW5XfqA87R8anHiOYUIjvR0qaSCmyAo156VqaCZl+BVnncPwGXugG45ZOtkzMa
	Ia+7a7qZ7tfklqeUmHlLfO6G9FD/Vkq/LLRd0q31vlHo5UspM6pFl6VJBbRscoA==
X-Received: by 2002:a05:600c:4583:b0:414:7198:88a7 with SMTP id r3-20020a05600c458300b00414719888a7mr10227233wmo.34.1712078107262;
        Tue, 02 Apr 2024 10:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBkh/H8jx4WNfScg0QetIRqTHa3bAsRuQbjjcs0nbQsFEOKtPqhLK97VSqKnvJb3sIfaqaSQ==
X-Received: by 2002:a05:600c:4583:b0:414:7198:88a7 with SMTP id r3-20020a05600c458300b00414719888a7mr10227213wmo.34.1712078106668;
        Tue, 02 Apr 2024 10:15:06 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0041408e16e6bsm18656884wmb.25.2024.04.02.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:15:06 -0700 (PDT)
Date: Tue, 2 Apr 2024 19:15:04 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 27/29] xfs: make it possible to disable fsverity
Message-ID: <lq4w62nepbmkxaktcpukts4v3jz6wbjfc7odv76iujttzrvyze@yglhbnoiwptc>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869006.1988170.17755870506078239341.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175869006.1988170.17755870506078239341.stgit@frogsfrogsfrogs>

On 2024-03-29 17:43:06, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create an experimental ioctl so that we can turn off fsverity.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_fs_staging.h |    3 ++
>  fs/xfs/xfs_fsverity.c          |   73 ++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_fsverity.h          |    3 ++
>  fs/xfs/xfs_ioctl.c             |    6 +++
>  4 files changed, 85 insertions(+)
> 
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


