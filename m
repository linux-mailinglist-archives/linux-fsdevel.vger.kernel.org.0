Return-Path: <linux-fsdevel+bounces-10729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0F84D8F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2C71C246C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA63F9D2;
	Thu,  8 Feb 2024 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z7vS4RTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E72D629
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362340; cv=none; b=qOUcBspRnfsiIhmWSvAaVmNIGt90HOk0Oqm1A91TOvzSAovqWhr5gKNwrzBjy4OMa7cnunyoAWrOsI2HcpcylRfKlRp3/4eQPgJAz0f2CsOTjiFHD0MKZlnUFXMhlG9o61RHu4o6OcwrwBS6vKHLayeCtJ6jAbACxkheIgtp2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362340; c=relaxed/simple;
	bh=KnkOJYA+ZF6Kmru0kx63nfEJhN73el2zwXpVdx/vkaI=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ShF/jzSW/EVeggqTFKRasb/o3/kOUJN3RcKMppDHRJhQBMcKAIV19SGfz2q2W2sDVfpFuDAinWVakyKDNcXehmG+FpeeGNnC0aLuZcB/geRvWI1aE2pseKNTuRwfwh14ZIfUAlRgPGDeyoEhbGLyi5mW/n78bqCdZuXD0TqwDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z7vS4RTV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42aa4a9d984so10416041cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 19:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362333; x=1707967133; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oNNChvp7enOHaGv67iirqEATQRVn6s2IBOKWY479Ikc=;
        b=Z7vS4RTV1ce08w4cwCVtDzIGU4FeXT5p1y9uI9jS5wZOA7e0z/TMjreynydFroSFk6
         e6SHQYCi010WedMqCS0roWlNds6qKlrItkkTrdRQQtk7UEqtu8KrRl0HP5NTdSNxV+Mc
         zT+Q41UO2jAKxo3nH+/Dy0tYOqQrxe6BGvjs3DEviw/M8Y4Rypuz7qmL5yjPDNPMjwG+
         BFgQe5oz/vyRONgUqKIMoVcZlryiW+zdE9LUboCxf1c/jRDKFXVT3RkbW3th4WffJpRE
         wRd/DuroXE7cZflZbQUPsgO+b01l21V4Tfl+cg7NUai43FYqKguI7EKuhK3tQ1xOv6iT
         VfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362333; x=1707967133;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNNChvp7enOHaGv67iirqEATQRVn6s2IBOKWY479Ikc=;
        b=XK0xMCUlMQGBZkghra7TVPYicGQkBwe6dPutBxLS8QwfrVwewyHKJ4QLSkYsBpU8Er
         8KRhYBT+I/8i6McCoMfM3Yqq37OsqDKjztPuz6fkwQm2YuBNu1xOiNyeJk7eT5KAinZc
         bNaDNk/zWa1+GtZWP8sOVMAcT6LrXRYJaW27WUdEQGntxgwD/mF+b1H+rwu//mA90usQ
         beKUKVHiE0WdnfNzcFXC/z4eOYF+EIFH9pGy1YW0c1cxR59W9JM62UUR4NWBEOd0sCgo
         xtP8NkjM3YV9Zgoq8U6KuUQLmo4xY+U4ktM4p0cb1zv0joTkB4Qp5E3RfyzvEzfm8tim
         d2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsoDNqinPTiTLb3ILcYDzmmxW2Wueb0UOZe2WWzrxMjncwzgrfBj1pLImI6YkdvVC2wdhMnZvl4LqADClLwJ14WX5IPpcU2G2hAUbKeg==
X-Gm-Message-State: AOJu0YxjfWB8cuTi1KOtNAfyrMn1LPDSjASokwaqq7lIx4W4/Qsqj8FW
	mEHE5u/c2zN/kWDcqHHDh8HNP2S8SUcz8PDfAWc1Dib3bJV1vRin/AwYU8ewyQ==
X-Google-Smtp-Source: AGHT+IHKo6eVNG3Lrb+TDrtEaIoKPGMvwW5MO9vd3s2dXKXoBInyKIDGRzELkkkehv63exQOcsZctw==
X-Received: by 2002:ac8:598f:0:b0:42c:3a06:8b86 with SMTP id e15-20020ac8598f000000b0042c3a068b86mr7365879qte.28.1707362333523;
        Wed, 07 Feb 2024 19:18:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+MlBOyTBXqYsiBUBCbCTQYgv9WrzN1WRMZFtdN7DaHfzyvziQLgUKZwi5r49UoaIul3keNp3G6d5WVnePnjnZq54XB877kwKSpQg2RtUZs4elW9Da/UBkitCLGyILr8adts/F0Ms67geTKWcnl8VyalaKstNF/xnV9zpTWCCmJAGzHH6UUuIrejbZAi+oZY5kGJxIxQF2msrb5rmhWBboiM4ABTNVYVLGx5tw5Jh6OKb3mJJRUmOGwWEoGZSd93GYk5hFv6deuwPUUt1bCwK4cBTLsGd4VPkfln4aX2R/YC4dLHw2PJBkfCI3lt/JriG5PtDTx1xwEpt34uNXDIM43pzdBP1IWlrs5CotTEqgfx9BHYCXJv5JaTjV5zI5Sjy5b3hxUXKdlqEJknjJ3usF6g3C4d91FxU5RSY8d4mZVZv+V3RXK4IOr2LQqmzOrktf+UTnsMjVaLt+9ZC3TK5XFVsXyfYFQfueCGxxkrGUqMeLxXFICO1y1et26DJRgepQOlG+7m8OcxHOuYWd4wAln/OA6k+hMEb0IB4iQbCvZy+YfC2eF8bmGeGSLDUZvlfSg8d6VnwmfXy0WjQTeJKuXR7mWs32UoIBFAhGK+VYiXZ4SKluiK327/qSzo2NkH+tChnJj20FTG5QqgSAs9RBwsEeUmJuFwle0hRLadYXvcjXGfUBwMrwxsv/v3DvWULzRmte7ly/R6a8VTZlFhSiZyQMUi40bkZ7LEIBh6PwjaTZJGkTDmb9dg4VLqVFIhWqescVHhQnEu+9qk3F6lMubdHcQ1RbCpQQDq7e71QomHLmKUssrSTGooO6irxrT+XcAhe5+mtrU/XJR7l3wkT24MCfSJTuGqN800PqsahxbuT/HQW3NnYrwpMMjdckerq5ypm/rsizhlcIC6h5sII6Zs8YqfoDZaJVrppd5+TDUpZm4ejzjCwyIk0+JdV9h8bDaa
 Rl1yci/c5GEho=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f8-20020a05622a104800b0042c46268a33sm606763qte.12.2024.02.07.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:53 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:52 -0500
Message-ID: <9c2caad915fc512b6d37173008a2e189@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 21/25] ima: Move IMA-Appraisal to LSM infrastructure
References: <20240115181809.885385-22-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-22-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> A few additional IMA hooks are needed to reset the cached appraisal
> status, causing the file's integrity to be re-evaluated on next access.
> Register these IMA-appraisal only functions separately from the rest of IMA
> functions, as appraisal is a separate feature not necessarily enabled in
> the kernel configuration.
> 
> Reuse the same approach as for other IMA functions, move hardcoded calls
> from various places in the kernel to the LSM infrastructure. Declare the
> functions as static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm().
> 
> Also move the inline function ima_inode_remove_acl() from the public ima.h
> header to ima_appraise.c.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                             |  2 -
>  include/linux/ima.h                   | 55 ---------------------------
>  security/integrity/ima/ima.h          |  5 +++
>  security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
>  security/integrity/ima/ima_main.c     |  1 +
>  security/security.c                   | 13 -------
>  6 files changed, 35 insertions(+), 79 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

