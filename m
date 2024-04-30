Return-Path: <linux-fsdevel+bounces-18320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304428B760E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FB61F217C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717A171094;
	Tue, 30 Apr 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApXl9xcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38427171088
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481184; cv=none; b=SZcfj5tDXVJ9+fWwGegcmX9lfsYB7HsQ7UMsUliM9iknMafQrleea1wsAIgxSv6sxLt/llFOvRN3Lw6F8bq5TDhi4F1TUosLseVhPam5wi6HtHg6m6nOfjUuIVcEX+3KusF9QXScHFuWKSb8ty0q4niQcIwapP4B4z2ylYopvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481184; c=relaxed/simple;
	bh=uEQe05sSb8XGdNTp8LDHqlunM6px035H4FVrXb575n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOu6KrYmikXQUnA/AbSJ1G+bnmPsoRD7wifBnizwiUNkXcxs7s49J9ub/n5LzzUcNQ00Ov+IJe4dvHVM+awCaWgO/TeoKA5JdpVGLRNg+QDDQvTDiXxN3FyIuO8QHor86JnHVat3iEh2WVPf83Hsgmh+oBGYHVMMyVjwkDkvq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApXl9xcS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYvETdnLejW3BqSGItxHmluLcu0UqtVku9or1/S68aU=;
	b=ApXl9xcSQwbKNwvrn6jM+ppSMYve1/CtfOrSwu9RCRNxS1kjCd4odSPZuSkGjZfhbM12tm
	tCPb/eVcfUBYgm2/CakxLoC46L5RCLwWYW0T8/ri2RsCVrlmI9Yww/LT6BsgG0hCPC+OW+
	4i1sZB26kQrM/xeB9qdAs7eUWo0mDWo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-pTplCNUaNre0PTKmo2osIA-1; Tue, 30 Apr 2024 08:46:21 -0400
X-MC-Unique: pTplCNUaNre0PTKmo2osIA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5190b1453fso359418366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481180; x=1715085980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYvETdnLejW3BqSGItxHmluLcu0UqtVku9or1/S68aU=;
        b=ejL65JojAMJoKWlRVcJpCySJIB/nxEgarXFsPuUkGxWIxIMob7euT7C3OSh1y8GXee
         +vW+Mo5XUDjONoMjuJSsPmIONFQyWL8n5iI7bjCslUZOX0dBTFWK9PTDmxFYejZ0Z6zE
         DBoQJQJcsV33/kA3Dj8QKJM3yQ0lLdsUjgNY6Q8pnP81SbXUdoilif6adj4WVYb37pg2
         Pbx5zPPkP8wk/2w+CWExRIZsVEoDDLHSyYQ167UQryFPaBmJpg1jvsort7+SCxpUVDaY
         UZ91AjDNBBbd6Yt3+IhOu2OrWe7a+d+7E+dCjp4tMdnsEifNpi+uhk/7qjOUmzBJRZE/
         OVJw==
X-Forwarded-Encrypted: i=1; AJvYcCWXOlCx1YYHCGg5N9ae9GcVkSqHwvp9Bl+DHHAVBFYJOG8VxrH8w2zRM6hnabnVzFLJaZglCJNH3WYB9KST+KR7rVwdk7WinS6woxLBIA==
X-Gm-Message-State: AOJu0YxW8GLyvVt7J3YG4IP3NR04zanbZ1xdqPsbeFcydS2DQAn3EnF7
	ytd+Q3RCLVKti1wXcXB/spQxKz0nJ7tbNpDSR+NScMjQL7keM2miQZocZaYmVAiP04BhqcUQLRy
	GnQsX1GljJ6O8VTA/GvAleiVMYhTaqb5Ru1NCmKboKG1kshs/WtoAnC53Z4f27g==
X-Received: by 2002:a17:906:3e53:b0:a58:a721:3a61 with SMTP id t19-20020a1709063e5300b00a58a7213a61mr1865460eji.3.1714481179581;
        Tue, 30 Apr 2024 05:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Fs7bD5hUcrtDyzCJsRl0FSh2zrk1KirHmqO2e+yYD35p9fWVrF01XM3RRG1Z9PT5wVA6Ww==
X-Received: by 2002:a17:906:3e53:b0:a58:a721:3a61 with SMTP id t19-20020a1709063e5300b00a58a7213a61mr1865436eji.3.1714481179068;
        Tue, 30 Apr 2024 05:46:19 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a522f867697sm15006627ejz.132.2024.04.30.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:46:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:46:18 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/6] xfs/{021,122}: adapt to fsverity xattrs
Message-ID: <52muvsk2z6c4gg7pghusidtu4ntot4l3unplgdvgcugll24syz@i5d2usji2wce>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688009.962488.1019465154475766682.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688009.962488.1019465154475766682.stgit@frogsfrogsfrogs>

On 2024-04-29 20:41:19, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Adjust these tests to accomdate the use of xattrs to store fsverity
> metadata.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/021     |    3 +++
>  tests/xfs/122.out |    1 +
>  2 files changed, 4 insertions(+)
> 
> 
> diff --git a/tests/xfs/021 b/tests/xfs/021
> index ef307fc064..dcecf41958 100755
> --- a/tests/xfs/021
> +++ b/tests/xfs/021
> @@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
>  	perl -ne '
>  /\.secure/ && next;
>  /\.parent/ && next;
> +/\.verity/ && next;
>  	print unless /^\d+:\[.*/;'
>  
>  echo "*** dump attributes (2)"
> @@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
>  	| perl -ne '
>  s/,secure//;
>  s/,parent//;
> +s/,verity//;
>  s/info.hdr/info/;
>  /hdr.info.crc/ && next;
>  /hdr.info.bno/ && next;
> @@ -135,6 +137,7 @@ s/info.hdr/info/;
>  /hdr.info.lsn/ && next;
>  /hdr.info.owner/ && next;
>  /\.parent/ && next;
> +/\.verity/ && next;
>  s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
>  s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
>  s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index abd82e7142..019fe7545f 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -142,6 +142,7 @@ sizeof(struct xfs_scrub_vec) = 16
>  sizeof(struct xfs_scrub_vec_head) = 40
>  sizeof(struct xfs_swap_extent) = 64
>  sizeof(struct xfs_unmount_log_format) = 8
> +sizeof(struct xfs_verity_merkle_key) = 8
>  sizeof(struct xfs_xmd_log_format) = 16
>  sizeof(struct xfs_xmi_log_format) = 88
>  sizeof(union xfs_rtword_raw) = 4
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


