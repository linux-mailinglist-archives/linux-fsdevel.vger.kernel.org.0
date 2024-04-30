Return-Path: <linux-fsdevel+bounces-18319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0198B760C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482AB284F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5617165D;
	Tue, 30 Apr 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDCOFFrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F39171094
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481136; cv=none; b=dZxCHpbFCOX12A5XkhanjnB5fZz+HDu/TFJEzDbab3NIXXhHVRZibVYKKgcOTybdOWss+2fCsuBhoqECm/FqgbV9/ncZmGZYGY6hZ1e+57FrAnnuURIt9ja1FP8wzXR6la84o7c6WiAdLkmqPdTBCXAVVTmWMJH92V6QvsHKRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481136; c=relaxed/simple;
	bh=sBwO4tPURPfK/Tpoqq7ijMiBEHW84wlDyIODrCdIFCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/kK0hj41euxcPGqrF6YUh2YPJTkb0VUDGssQwAoH3Fh11KDMspPTbEXPLl6QCUUGdl7ZFMWio7cdW+ts+fe/jnAKkE8GrgEil/NEhTA1gGw2Vu7kQclbes8xv/LJerX35J5O6S9ButbUsQmI6rADL83Vvsw5kzcGnxJWDKl6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDCOFFrv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4X6n0pLuVBUf+BlkM+ca3r2rZEzvEw8vYRriJB7tN4=;
	b=HDCOFFrvaj8c3/90tyF8lTssXiGQVLHf1YRgOnhF7Rb/0VKdGKomL3Vvf7GLoBb6fGZqNu
	rwsSImXjGVJEVNV+4+0Rwz9YBeKB0rMGU429XXA7J/p/uPZLENOdH3fdz4EcF2xqUXXXfJ
	pFqxbIi847JLAki7KSTAKNus6W1Dp2M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ZAMVqlbkNA6lI2LhiZoveg-1; Tue, 30 Apr 2024 08:45:32 -0400
X-MC-Unique: ZAMVqlbkNA6lI2LhiZoveg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a592c35ac06so63807666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 05:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481131; x=1715085931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4X6n0pLuVBUf+BlkM+ca3r2rZEzvEw8vYRriJB7tN4=;
        b=YJ2d0aAWFrGwy02hVO35xDcoRTA9Ms92Brgr+I7KUjc8oHmGcJ9sDiJJ3W20r8AnmQ
         CQJsg7EuI9vP6vvhujLFwMbuEIENob0vFwAM3Mq9sKsWqxsP8G8XdQLR4G8aho+mAN5n
         TnvNIecuykGsXTK+ylxFQqnyWIgx/ns5GoW5zIZIPNPMRWs4F2a2tRdP9ezkx6c9F5iD
         OM06DpypPmpDKWHOTzLsOAS+fZmSNHsIWmgDudFCvnhRn7QVJufR84HnzMLb5tykh8hl
         lxgVEAMj5zI4wFR0YAQn9MJ52yV7debeGCm1rREX8HdvaV0VJD9QGIqXZsIAo3fo4n27
         IfoA==
X-Forwarded-Encrypted: i=1; AJvYcCWueB1E0nEXg2HMg6VK3fe/eEZPd95cocECUBMU35m+qdniL/iSyF7EH8n7FSBEnnZo8sDksKAMmcK6KV6cDcV4nHYXsVXLyc5h2XgiPQ==
X-Gm-Message-State: AOJu0YwxKAfvntPdwBFWJ+hcVT9QQlAWfwtq8iyp05sBd9Iitx8RM7bX
	zQvfTd3aqxdYhhkWP12r5W3USpvzxmflpSJQBPkTl2F70usOKB973U5kaH1KgGbegoRA8u0gU1H
	b32bESx3dVqOA6q3xdmxfebgvLnBVFoKyMzhEQYtaYW2Wsi+yfBwgDtuFDRuoVA==
X-Received: by 2002:a17:906:384b:b0:a58:7172:1ab0 with SMTP id w11-20020a170906384b00b00a5871721ab0mr2477673ejc.16.1714481130917;
        Tue, 30 Apr 2024 05:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTDZWzi552+qruMRrzcUaprNH9Uh7FvvQtJYCo7WBIUu82K3ES4iheNJ+29jVddUBCcqoTNQ==
X-Received: by 2002:a17:906:384b:b0:a58:7172:1ab0 with SMTP id w11-20020a170906384b00b00a5871721ab0mr2477642ejc.16.1714481130382;
        Tue, 30 Apr 2024 05:45:30 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709062b0400b00a58bf7c8de8sm5776845ejg.201.2024.04.30.05.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:45:30 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:45:29 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/6] xfs/122: adapt to fsverity
Message-ID: <wrxpj5cduflmsthmgrlbdewpis5mkpz6rnrcsmgapybtznavxp@dryj5f364uxa>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688024.962488.13214660928692324111.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688024.962488.13214660928692324111.stgit@frogsfrogsfrogs>

On 2024-04-29 20:41:34, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add fields for fsverity ondisk structures.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/122.out |    2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 019fe7545f..22f36c0311 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -65,6 +65,7 @@ sizeof(struct xfs_agfl) = 36
>  sizeof(struct xfs_attr3_leaf_hdr) = 80
>  sizeof(struct xfs_attr3_leafblock) = 88
>  sizeof(struct xfs_attr3_rmt_hdr) = 56
> +sizeof(struct xfs_attr3_rmtverity_hdr) = 36
>  sizeof(struct xfs_attr_sf_entry) = 3
>  sizeof(struct xfs_attr_sf_hdr) = 4
>  sizeof(struct xfs_attr_shortform) = 8
> @@ -120,6 +121,7 @@ sizeof(struct xfs_log_dinode) = 176
>  sizeof(struct xfs_log_legacy_timestamp) = 8
>  sizeof(struct xfs_map_extent) = 32
>  sizeof(struct xfs_map_freesp) = 32
> +sizeof(struct xfs_merkle_key) = 8
>  sizeof(struct xfs_parent_rec) = 12
>  sizeof(struct xfs_phys_extent) = 16
>  sizeof(struct xfs_refcount_key) = 4
> 
> 

Shouldn't this patch be squashed with previous one?

-- 
- Andrey


