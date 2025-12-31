Return-Path: <linux-fsdevel+bounces-72297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C179CECA72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 23:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C8730477D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4D3128B2;
	Wed, 31 Dec 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+M/CYp5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mwPmqrcQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE815B998
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221391; cv=none; b=Nm43PK9ftMzJc4MOVIGprH6ISV+WHGGOep1vMp/WkAN8Hu39bMy6RCAY2qg8cOSCuZdpr6NDTCFpDenKSxQfUtwN68Uxr2sxOozE7OnoETvu5XRILjvRi36wBC7vMzdmHz+0/nWylwmgmjvLbBceHZSd0GlElT1dN+pEwvrLgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221391; c=relaxed/simple;
	bh=TPaLaE/VATs7DF+xFjPkCAcNnt/jKPcnLWXvoxdeEoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuT96cxXXnmCisD0ArBwA75yGnoDslJdre3ZCEjldJ+ifuYgiHDwvjl7Jcgv0UU2cZC0+NCQymYsjrE6ACt6KTLsDnU50X131kaM3uNImneCwtC786P2hQXL1vS/qBwVSTpNc/KZqw3Ohav9f/xHzYsDPFdmfZt31IhME3oBJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+M/CYp5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mwPmqrcQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767221387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6GKpgzl+uEYOc1cCsJPOvSPKEZjCVA9sg/IZVkE1Hw=;
	b=Y+M/CYp5KmEFsnz0ZGZlW9QIKdEHFlDOA0K4u9Mdw8UvlNl2YQlLhvUAcroD8zCZyyy88t
	K8kEMjVmM0RA0ixXosu3RGmb6I1jszmFHvFrh+VOMmNUnpGglN+F/mUiqjWtkQ5CvZMNGK
	yawbS/RUzAyfUXKpAraOdgdA0C/sTvI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-12H0nFZQOeCvr-c7HgNmvQ-1; Wed, 31 Dec 2025 17:49:45 -0500
X-MC-Unique: 12H0nFZQOeCvr-c7HgNmvQ-1
X-Mimecast-MFC-AGG-ID: 12H0nFZQOeCvr-c7HgNmvQ_1767221385
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34eff656256so9052468a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767221385; x=1767826185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6GKpgzl+uEYOc1cCsJPOvSPKEZjCVA9sg/IZVkE1Hw=;
        b=mwPmqrcQGj5CSCXlOm6y9pqr5qMTAdYedpI5F+A3IMDwSBlARHRXFZXwHWduzWODHJ
         71Hau0kt24bJmDllYk7+p9UzgVU4QoEIoGjYHOaofW4SrLhgyZAkhsYtbLF3jobk5+IE
         k8z2toqEBSFW8DS81JQz1GK1DGEKd94QLZB4XGPTLmbJpIphJkO/BBuBWfMAvm8fY0TL
         zK1ex/9QVz523yHLhHOTcMi3voLtEvWd+AphTfQyqfBhE3MU9Dip+Xapb7V4wruGGhhJ
         7e0EXHXWRBNwII+Z5noNdN5SOAS1XYiFcZZui8mTJJyImfgiZNDjm1R8bRNw8gQ9yOar
         OABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767221385; x=1767826185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6GKpgzl+uEYOc1cCsJPOvSPKEZjCVA9sg/IZVkE1Hw=;
        b=cir3SqsAU9uiOBDyU/k87/gTpwMNtIaWbJqizoFyG9G3TA4aez0jbAyfZfLze1MyNY
         I7f69UkCGj6VHWxCWErERceTjDd28ikdbLNddwwnz4UPLqV+G2I0toDnuMJ9IvwCWr8Q
         I56q1B6TWQZHeuKlybYPipgz9vf+0brgd/+ZcQK7iI7HJIp/OfeAYM02VYsm/Jf4OmUC
         BZ1N7tNe07lj2PulPDmgt01srRBqz2HwBhcOBkAgQWilqcISvqTzSt7dhk/ok5RK2Nrv
         kuGr/9LaKuUOwPZVinkVa8IhAPr+AyTIZ+aCFBzXUcwgMFTNsjgZx71RU5oBVu6a0hJP
         GpnA==
X-Forwarded-Encrypted: i=1; AJvYcCWbjxqcbD1nmAbWb+7UdAHxQg1AeiNZojTwaHLKdNDWXdIQqAJ5cdwxmfOSVaFPOAhOCQ0izkRAVN1t1kGq@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeg81djojKN/MFs4+Y3enMzfI26pqdpx7yykBwWGibhXgY2v0
	PfwVtSUR5SEMrK+bIc46vm9zu1JSBzW0kfsmknNSsiE3Q/oPIq7rhv8PQ1CWpxrCGkXK5tzLM/V
	eP4V+efl1tXk0avUWkLSR8kq0C1vIkIMo3NeIGb7Huiw0fs4LA8xEV0aNZiUFsVmr9PE=
X-Gm-Gg: AY/fxX68TVy02SkK9IVWNAdaArYxIJTAibD2fSsSSAipITbmLrylU/QkETdc2RUxSI6
	+anr2c3DRiUj2el7OUkL7iMqAtAJLZBkCJ8UqDTSpxUNnZ0noyHSCXiTFuXQvFuWDmDVAr77YBg
	FNL5ooqbmJ+Cst1Rq5XYmEcysnEGHFtUnES54UxU8ShYPIiAvhTLnfbICUoBj5/4BC2FK8zoYMO
	PrFRAOuvP/SL6B5KGUS73KC64oQQB3Xb1S6/FpGfWpM17wogR6QWJGvxBddt0hp0bBJ4LOpy2tO
	ZJRv/hdhpHLGiwX6a1g1j+EwDZRRDP3CBEfgWavrmH14s+GVHYgoY7ACQM5lCxu3Hl4SJSv5/rx
	RD3cziHZEjmriZV9bunLc+HmXMoRLlRXH1WO3RCD7ft9Sd1wfRw==
X-Received: by 2002:a17:90b:56cb:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-34e9220008fmr34597032a91.37.1767221384753;
        Wed, 31 Dec 2025 14:49:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIYaURwXAcaI0COgfWMrpbKyUkKD+aSVskVgccKJOH+tWiGzepanBLjAa7XKP4FJlWWfuZwg==
X-Received: by 2002:a17:90b:56cb:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-34e9220008fmr34597021a91.37.1767221384284;
        Wed, 31 Dec 2025 14:49:44 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9219f165sm33493132a91.3.2025.12.31.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:49:42 -0800 (PST)
Date: Thu, 1 Jan 2026 06:49:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com, fstests@vger.kernel.org, zlang@kernel.org,
	Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] generic/020: limit xattr value by 3802 bytes
Message-ID: <20251231224937.uu67l76cytcd36ns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251224002957.1137211-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224002957.1137211-1-slava@dubeyko.com>

On Tue, Dec 23, 2025 at 04:29:58PM -0800, Viacheslav Dubeyko wrote:
> HFS+ implementation supports only inline extended attributes.
> The size of value for inline xattr is limited by 3802 bytes [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.19-rc2/source/include/linux/hfs_common.h#L626
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
>  tests/generic/020 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/generic/020 b/tests/generic/020
> index 8b77d5ca..540f539b 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -168,6 +168,11 @@ _attr_get_maxval_size()
>  		fi
>  		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
>  		;;
> +	hfsplus)
> +		# HFS+ implementation supports only inline extended attributes.
> +		# The size of value for inline xattr is limited by 3802 bytes.
> +		max_attrval_size=3802
> +		;;

Glad to get supportes from HFS list, this patch looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	*)
>  		# Assume max ~1 block of attrs
>  		BLOCK_SIZE=`_get_block_size $TEST_DIR`
> -- 
> 2.43.0
> 


