Return-Path: <linux-fsdevel+bounces-18323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936F8B76EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F81C221BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D088171669;
	Tue, 30 Apr 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id0L6v32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EF171E4F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483377; cv=none; b=V776AyfB24yRBm2Nntygio+yRAJOaaB6bR+4j4APz38bVyXTx/pkyFhClf7fW+UPoP4d3uRipKLaKcNcPgFXW4f3lgcfLtyW4Z6zqAwKuEkPtSDJHTr6NiYZZuVBJBApO7RkMdelcvnmVjlTVSgzjCtRherTrGqoMQTXvJNW1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483377; c=relaxed/simple;
	bh=YnEJ0sEcEqRvMruWiehseLaJw4OasqybHAEjGtiIl2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koa3qAL536WYlafrSXfYopUkNzdRef0zZrJYYeJvNLXaPeo+bvMr5FfaE5vzFyjqlizA4lG/CHB2HNHmd+7T0hdZY21sr7J05XFo1nkL1FLJjH7PU2bqvsP/pn/UgmQH9RzkTnEuqQVWWm25bi1/a06xZ989fIaPVqVj3JQ3P6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Id0L6v32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714483375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf4VuVjSkqqaSBuXyiy9b+enj0lsiQgUxAzYhGA5mE8=;
	b=Id0L6v32oey+N40rOj0hWK9lp0rb6ECgGCXCDpFwqAIbtqL0BVZjxS49n4xdQMhhWylc+8
	eebXv6PQGUAN3/Qwl69nd9n3o8+YgqCAfS/Zy2NYjZXxPMcNtDpGzFKK7iEJ/XJj1Xox3l
	TacriKsOAV+THXxRjqfi/nrNyfsFMJ8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-AGiZTdwpMoeVQRteOfTkXw-1; Tue, 30 Apr 2024 09:22:53 -0400
X-MC-Unique: AGiZTdwpMoeVQRteOfTkXw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so3442920a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 06:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714483372; x=1715088172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf4VuVjSkqqaSBuXyiy9b+enj0lsiQgUxAzYhGA5mE8=;
        b=sU9UiKob9sqWjvOGA1dtDDMxz3UL+6enXYdir1gzZ0drkhgQo20GE0Ogup0+evjwuk
         JO52WuDednDRJ7MENqcl4EH1D1cJjvlZdgOy8oVCgJl2dUhX3DomW8F+eKIUNUTzMHXU
         0eTu1IjnZ2rqfno5A5Muahzw6zj3ozMwCF1XhXK/PBOgww0W7BrCAEyGp9Cn9mQu5Ust
         75SVi+dHwqDlOSrwz/dljfiswBawHHN8p7VLFFxvaqW00nlcsenc8/ryRDf48HYAyFkn
         f2es0rfVPX52sd7C8Ru5ymvVTsK0yHIcJUZjXBI2UtrxUYJQU7WKsPEpy69bZOOdOFZS
         3/OA==
X-Forwarded-Encrypted: i=1; AJvYcCXEzcOjpDqGQgYibNy4jhI2EhkUHkBC0P2L3bSYlg+LeRkuzmz8SaFP0Q/LZkNqPqLcodQ2epkKP4LFyS5WN+aYXGRoDcz+Xtz+W7sCvQ==
X-Gm-Message-State: AOJu0YwROXOoqlkmpgiaHU9o6N+HGe5Db8F71ZDpOWSgg3jgv4wkONas
	B7zWauWA0gPXKAB5aPPJxqEYA3mbQVytll3iDIoW3HKsqOyUaC3JHZeOzJ831LvaCTnbdvo5EID
	0m7AlgB9Hi5Tj+S+r/VZoa3lvuThKc2pA/I3aGBVeJw1aOB2ZBD7zGnAAHrBDuvRxcuGapw==
X-Received: by 2002:a50:9993:0:b0:572:9e96:cdd0 with SMTP id m19-20020a509993000000b005729e96cdd0mr891909edb.2.1714483372144;
        Tue, 30 Apr 2024 06:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEpwaRQV/7d7WM8xQJn8O8slwrFWWcV0hlAQMVCF07J1eFJuZ01TvonvPaHMPCXLdzduGgyw==
X-Received: by 2002:a50:9993:0:b0:572:9e96:cdd0 with SMTP id m19-20020a509993000000b005729e96cdd0mr891893edb.2.1714483371609;
        Tue, 30 Apr 2024 06:22:51 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id b61-20020a509f43000000b0056e51535a2esm14826411edf.82.2024.04.30.06.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:22:51 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:22:50 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 6/6] common/populate: add verity files to populate xfs
 images
Message-ID: <jalepm6lu3nwy4bext62pj2fii6s2iknkgbsh5p3ltz65yeqcs@5z4s72utnopv>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688070.962488.15915265664424203708.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688070.962488.15915265664424203708.stgit@frogsfrogsfrogs>

On 2024-04-29 20:42:21, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If verity is enabled on a filesystem, we should create some sample
> verity files.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/populate |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> 
> diff --git a/common/populate b/common/populate
> index 35071f4210..ab9495e739 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -520,6 +520,30 @@ _scratch_xfs_populate() {
>  		done
>  	fi
>  
> +	# verity merkle trees
> +	is_verity="$(_xfs_has_feature "$SCRATCH_MNT" verity -v)"
> +	if [ $is_verity -gt 0 ]; then
> +		echo "+ fsverity"
> +
> +		# Create a biggish file with all zeroes, because metadump
> +		# won't preserve data blocks and we don't want the hashes to
> +		# stop working for our sample fs.

Hashes of the data blocks in the merkle tree? All zeros to use
.zero_digest in fs-verity? Not sure if got this comment right

> +		for ((pos = 0, i = 88; pos < 23456789; pos += 234567, i++)); do
> +			$XFS_IO_PROG -f -c "pwrite -S 0 $pos 234567" "$SCRATCH_MNT/verity"
> +		done
> +
> +		fsverity enable "$SCRATCH_MNT/verity"
> +
> +		# Create a sparse file
> +		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/sparse_verity"
> +		fsverity enable "$SCRATCH_MNT/sparse_verity"
> +
> +		# Create a salted sparse file
> +		$XFS_IO_PROG -f -c "pwrite -S 0 0 3" -c "pwrite -S 0 23456789 3" "$SCRATCH_MNT/salted_verity"
> +		local salt="5846532066696e616c6c7920686173206461746120636865636b73756d732121"	# XFS finally has data checksums!!
> +		fsverity enable --salt="$salt" "$SCRATCH_MNT/salted_verity"
> +	fi
> +
>  	# Copy some real files (xfs tests, I guess...)
>  	echo "+ real files"
>  	test $fill -ne 0 && __populate_fill_fs "${SCRATCH_MNT}" 5
> 

-- 
- Andrey


