Return-Path: <linux-fsdevel+bounces-36856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287169E9E46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDA31663A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5469167DAC;
	Mon,  9 Dec 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFmrVi7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39F13B59A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769966; cv=none; b=EONlZjTqn+pOcdyM6lRN+gSNj6BxcN+LCrQgFdofkB02p7Ij2tPGvXJmLKHa3H8C7b4mk13riRs2PfWqiulBz5IcGdOW7Brw69lXdVzQhvExPQA+W0tvP3tgsBxu6OynpdvZKlcPfTsCXVepHSWolaGTsROZMexfWQNvR6gww4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769966; c=relaxed/simple;
	bh=b6sAOgVc6XhUH8O1WeVukfF3AjvChlH4xGokjSvJlxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLiiOMZ1pUPUowFweCm/W/f46owuU7GvxfxMQ5knfEf9r65B0wx+djD8OsJVAPt2IMYUR3/XYoOIEJI0XPy/nGtdql/tz9zyMv16/sFV5ZsJmM40Zcj8nWhecjroCUk14q3keXtu+A4ZpVQgrEb3l3t4K7+sQUK64UQ1vM02f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFmrVi7U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733769963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XN1if8VUaEaZtxWglqVX1D2ri22+xURqhhedvWXwDlk=;
	b=RFmrVi7UYiMIbQBI6cPp+FcBUKFR/YOdM/UsEjxlhhgt7jSwKz7By2w6ip7hcl2LV1fzan
	OjvXoZQbVVb1lC/I/9uCPHh7zKx10a2lyLFStVILF0iI86P5VFZ209I9R4lIryq37k9kJ5
	9OnL8MQ+s0D2qUbF70lScj3qdAkWfdw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-gxKu4W91OVmjCJWI1LmUCg-1; Mon, 09 Dec 2024 13:46:02 -0500
X-MC-Unique: gxKu4W91OVmjCJWI1LmUCg-1
X-Mimecast-MFC-AGG-ID: gxKu4W91OVmjCJWI1LmUCg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-215ce620278so40253195ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 10:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769961; x=1734374761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN1if8VUaEaZtxWglqVX1D2ri22+xURqhhedvWXwDlk=;
        b=hwB8HnPE3QFMVqCKvlPW6KkpS3uhDo/cid5A1uEoLRrI3E90FM0jzw5mOwEeWnFr5T
         dq0NzXk/yYZQAb66nG6cZCqGKlUbYUsSg8hfDnwSsgZExjNofagpTf05isajOnlTJ5kM
         TKt+LaeePUBSI0XhsQu8i/y6qprJFym65OQVcSV1QMxS1fK8FtciSdR0rOtbGECr7qLV
         rY2083NW5NxfIRmLCZAFeNAx5KP10PXGKM2MUBDrZhPAvAPs0cFNlJtAUrudraHV6TkN
         dODbjWV71VlcGpWE35DfYl4Wxf1MhlkaAqbrfPlNc+xTYFhd0JYq1t2GTh31wEGK5wkY
         h5bQ==
X-Gm-Message-State: AOJu0YwwgRZmVnABhkoF3G+rbQB8a4PJBDwOdL2LrU6hVz/TqbOUrfjw
	ON1esI8mp72UpmdaxfHT1U74wKGYWSO9A5PViod92KCHvas4+eJ/CCpY2Qw1tTCgGXdhSPO56lC
	KiF14BRnKAjX/uwrcnEQ6PuGKYvE31o4fjxCs69RoLrugKN5xEWeaZktnJvDy4OA=
X-Gm-Gg: ASbGncu3bl2inM6S+WX89DMCsocdBAHQSYPQPJJfELrH3ntRcxHTVPWFOCwY4o+957+
	SRnu0ignAzOsbGolqT31AE0VZdiF5zV4xfBuujOyhJfCli6bMdVdUpngxvHpMLUZFGZcwMl2pIf
	75Zcn3kOJo9qq/oYuLz22H0Rz3cpZ09VemO1qMSywHfXyOHzVX6PPrPUf/hMgRkcLaS7UfIrzpH
	ZEV8keTOmvcoKujkJ+MjpdzDa8fw59xoxJaIQe6PV7TmQdGQz2/hC6dv28JMlx4bhXJ5UqWgVjw
	GEQf94g+K/I2cJo=
X-Received: by 2002:a17:902:c945:b0:216:5561:70d7 with SMTP id d9443c01a7336-2165561726emr59392785ad.52.1733769961360;
        Mon, 09 Dec 2024 10:46:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtPZrL+jf31r7lS+IMCReCs9bklyHsgEUUHk+/LWbmoRbHdorkli5v11l74XVyxd8Z+x/Aiw==
X-Received: by 2002:a17:902:c945:b0:216:5561:70d7 with SMTP id d9443c01a7336-2165561726emr59392525ad.52.1733769961086;
        Mon, 09 Dec 2024 10:46:01 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa162sm73949865ad.125.2024.12.09.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:46:00 -0800 (PST)
Date: Tue, 10 Dec 2024 02:45:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: cel@kernel.org, fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
Message-ID: <20241209184557.i7nck5myrw3qtzkd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241208180718.930987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208180718.930987-1-cel@kernel.org>

On Sun, Dec 08, 2024 at 01:07:18PM -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On NFS mounts, at least, generic/559, 560, and 561 run for a very
> long time, and usually fail.
> 
> The above tests already gate on whether duperemove is installed on
> the test system, but when fstests is installed as part of an
> automated workflow designed to handle many filesystem types,
> duperemove is installed by default.
> 
> duperemove(8) states:
> 
>   Deduplication is currently only supported by the btrfs and xfs
>   filesystem.

If so, I'm good to limit this test on btrfs and xfs. It might be better to
add this comment to "_supported_fs btrfs xfs". Anyway,

Reviewed-by: Zorro Lang <zlang@redhat.com>

(This's a fstests patch, send to fstests@vger.kernel.org.)

Thanks,
Zorro

> 
> Ensure that the generic dedupe tests are run on only filesystems
> where duperemove is known to work.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  tests/generic/559 | 1 +
>  tests/generic/560 | 1 +
>  tests/generic/561 | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/generic/559 b/tests/generic/559
> index 28cf2e1a32c2..cf80be92142d 100755
> --- a/tests/generic/559
> +++ b/tests/generic/559
> @@ -13,6 +13,7 @@ _begin_fstest auto stress dedupe
>  . ./common/filter
>  . ./common/reflink
>  
> +_supported_fs btrfs xfs
>  _require_scratch_duperemove
>  
>  fssize=$((2 * 1024 * 1024 * 1024))
> diff --git a/tests/generic/560 b/tests/generic/560
> index 067d3ec0049e..a94b512efda1 100755
> --- a/tests/generic/560
> +++ b/tests/generic/560
> @@ -15,6 +15,7 @@ _begin_fstest auto stress dedupe
>  . ./common/filter
>  . ./common/reflink
>  
> +_supported_fs btrfs xfs
>  _require_scratch_duperemove
>  
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/generic/561 b/tests/generic/561
> index afe727ac56cb..da5f111c5b23 100755
> --- a/tests/generic/561
> +++ b/tests/generic/561
> @@ -28,6 +28,7 @@ _cleanup()
>  . ./common/filter
>  . ./common/reflink
>  
> +_supported_fs btrfs xfs
>  _require_scratch_duperemove
>  
>  _scratch_mkfs > $seqres.full 2>&1
> -- 
> 2.47.0
> 
> 


