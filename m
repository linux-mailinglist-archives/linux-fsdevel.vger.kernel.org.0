Return-Path: <linux-fsdevel+bounces-15869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAB18953DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25371F22DA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D547E796;
	Tue,  2 Apr 2024 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSyWHvmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6F335A7
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062330; cv=none; b=irNzV3oyoVUH+uKw+5G1ULhEx9NfFJY5Jh26UebpeMpFp0eZ8vCiydod4Jg1tDJrGl+uVQYjDJJ8u3SBc6jj0fBPBCAsFDLAZtvxxb9JQujBFEcP5iC5L9OGtnnTFtEQ3JBFDGhHaI22LMl/fLRisoK+kzSQfZxlpNATujsZ1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062330; c=relaxed/simple;
	bh=fPTm8EwrxCKUCKlXtMQ46fsMh23VPD/sF98j59+9tqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4I3Bsg90R9+KjPQZoL73q9gVnsZXGjPprDOQrx80Ufd6TjusvueWABGp165uaTteI+h/MZz380qup5DyLdQEQncAE5D1x09QrM4keTfHkNtpbFnAASYeeEHul5BbRXzK3G0Xr3MAwvz6zSJux/tPvj7aRWg0BdLYvMOQBGu1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSyWHvmN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712062328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udjv9FB82NBjappNOEsAL426nV2L32B7yhwcIFshiA0=;
	b=iSyWHvmNRTO0x53eYzUqWUfDOPABqROLzwSYCxoQ+qtNH2rYUOkT7O/dwRm9NRPcAnIU7H
	ZedTlhxIIG0PvtVM0Sv1D1B1N2QmWcbM7Os2KGokqovUbeqgjuKeWDZJbWCF3ESs+vUZWy
	p3ibQGc1yrtr871fO1h6zCqhFMIRLE0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-7QovArUhOr68WTQSybUJ6Q-1; Tue, 02 Apr 2024 08:52:07 -0400
X-MC-Unique: 7QovArUhOr68WTQSybUJ6Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a47416276c7so267362466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 05:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062325; x=1712667125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udjv9FB82NBjappNOEsAL426nV2L32B7yhwcIFshiA0=;
        b=JtWHMgPyUcJ5pMqopTroM+J55dh9qKGsO93Je7OwzribRmQxlEshIdIqFyVpSfmulm
         wJj9Df431tn9NPBqKKjPSRvffZXSXQbpJTsjzSXHTar7OPZrmTN85fDP6BgDAKAROd86
         Ad/FAoTdNXemt3urcaLSe6KFjpUdxFwORIwJY3nt1rJFv/3fD8cApwajJG07RqzhYs3a
         Jubn7Eo08faUm1oWmgCJxMzWGCQlmZHTkEaAwR+fo+6LTsK+sFW4vIx5PLl4XZP+K6eG
         v0sEZwpsAQB3gC3XyP4GREiWsED4hi1TmTR137T0yLIwAnzhYtjsxLtHFA9JbWDAoiQi
         7rTA==
X-Forwarded-Encrypted: i=1; AJvYcCWNfV/Pr5OFbw5y8nxtH3yxu6Sw9862ZzF0+/mDkXonkDCyLHwB/I657zhP81CNQoB6LH6GW8HcQtASF3O2BbMKf53kdjJo/MYA2sbB+g==
X-Gm-Message-State: AOJu0YwVvCZcvedmxXtVZy7/3GuFcEx9ve802Eyxg6er9xXr4a4IQ9Ri
	0yQ0E6dZPed2tJJ3q5p0a3VMiVc69GLP2Iqusbno7ISCZ3poU+1VHw+3xDrkfrcLTKAJ0Ui5rEe
	ZMDODWBhQN1bndowlBkGnbuYbSyOwz7RfXDTC/RGk0JfVwT3n7X+pt8MZc38Zdg==
X-Received: by 2002:a17:907:26ce:b0:a4e:67ca:1040 with SMTP id bp14-20020a17090726ce00b00a4e67ca1040mr5256396ejc.14.1712062324648;
        Tue, 02 Apr 2024 05:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5KO71h1979wkCqoKkC7ot0dVk+kkaLg4kpoiFC8fXUDFCkH0e2YdCuNNW7DymBtRtxiSpAQ==
X-Received: by 2002:a17:907:26ce:b0:a4e:67ca:1040 with SMTP id bp14-20020a17090726ce00b00a4e67ca1040mr5256381ejc.14.1712062324120;
        Tue, 02 Apr 2024 05:52:04 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id wr1-20020a170907700100b00a473a0f3384sm6544357ejb.16.2024.04.02.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:52:03 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:52:03 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 17/29] xfs: only allow the verity iflag for regular files
Message-ID: <rdonyolmknblerpfl37uvt5i5ica3sjoy2kpmdlcue6qb7pauv@myouxj6bfxjb>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868843.1988170.2809557712645656626.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868843.1988170.2809557712645656626.stgit@frogsfrogsfrogs>

On 2024-03-29 17:40:30, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Only regular files can have fsverity enabled on them, so check this in
> the inode verifier.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_inode_buf.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index adc457da52ef0..dae0f27d3961b 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -695,6 +695,14 @@ xfs_dinode_verify(
>  	    !xfs_has_rtreflink(mp))
>  		return __this_address;
>  
> +	/* only regular files can have fsverity */
> +	if (flags2 & XFS_DIFLAG2_VERITY) {
> +		if (!xfs_has_verity(mp))
> +			return __this_address;
> +		if ((mode & S_IFMT) != S_IFREG)
> +			return __this_address;
> +	}
> +
>  	/* COW extent size hint validation */
>  	fa = xfs_inode_validate_cowextsize(mp, be32_to_cpu(dip->di_cowextsize),
>  			mode, flags, flags2);
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


