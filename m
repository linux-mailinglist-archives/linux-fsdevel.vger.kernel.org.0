Return-Path: <linux-fsdevel+bounces-15912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CBE895B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32690B2A06B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77515ADA0;
	Tue,  2 Apr 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVHfvd/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704B15AACC
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081103; cv=none; b=jdxkZkY/7uLcWY2+cD2Dqc7iNUC8F5ocYX4YkTvYAZ5572GTfs6BOiT/Hcyr9FWVaR6gXzJKvym+6UyzTNuOc+I4LJQj5Pgj3fyvw2rKgIozHQRdqEUHIADMu1nN7r9IXR2KEjSCNo8Eac5GtfeXZ/HRTtabJg9OWZ2igt6aDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081103; c=relaxed/simple;
	bh=BmvQ+0xao1n5voXSxUVflO7jZ9eSYVUGYxtndPxgVXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FateL3KyvTb2QAoZ1fVf3scgvRAO03LDabo66BoJyODOSy4nW6ymCHMUpJP+vpgp68SQP712EBWdGE8+eQBy9Xwu9t8VKINBl/oDEZrTDOc8APqzaNZItCMPK5zsKSbbwCD05q7aCmW2Kg3mBSJk2G3nXU52EWvgvJxAPR0CTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVHfvd/V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712081101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QxsmDw4gKSaDCVTh8/y79dF5qk4AA3NIv/V1UZhqWH0=;
	b=cVHfvd/ViI78j9Zycxe8WdtnRxymkB7r/gxYJqYdM2wncZo6q4DmJRIgIcPGHBs128NPwt
	hxex67fBnSD2F2Zqd8EArEX2Nx/YjU6Mj3itsrIyofniPnjHAg1GdZavtF1SsFfAaAqMhJ
	hJk93n2zkQZZIlc+4uTcLkGY5xynOtU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ojCiSRL1PDCogFZNGsKxAg-1; Tue, 02 Apr 2024 14:04:59 -0400
X-MC-Unique: ojCiSRL1PDCogFZNGsKxAg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516a50d2d1cso1799255e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 11:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081098; x=1712685898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxsmDw4gKSaDCVTh8/y79dF5qk4AA3NIv/V1UZhqWH0=;
        b=TFpaV4xOr/v9qFYycz/q7jW6v5x7ETP1/g94mCQlo96ppGWpS2bL8QYra4cX4S7zPM
         4OwLlKnu3uVdCM45Fu1S0H/JTdUlGsql0bxUQFFzl52wX7jrdUJn9hDU2KBjn4ZYlxry
         Htey8dVvQcRLpSyN17LzKi9C8Arg/Wshvy5kB2RBgAxyCMrsGyuXf+LqJKyV06vbMhXA
         pcK1U4M4XCCbD9Mrksiv1LCBHPc869r0t511tihc6wPWtueAf3kwjAxc0hx0IvqNgV6h
         iNxrU3K/0UiQv2ObcIADqSQqTdbehd1HIkm4F0AxMhYjoM5xREfMY7dB15uu9p1Dh+4k
         ohHA==
X-Forwarded-Encrypted: i=1; AJvYcCVymX17r1SNMY+Pzd0ubuucwXgZZWQvcb6ZZj/A4To3Q/N8DNhRPl7JrFxpd6cGQ5IeLOCPwMBj9JW5kGGnT1lT+tXa+eG3VlRJjZVzrw==
X-Gm-Message-State: AOJu0YxdIBJoemtrQPKMU+y2S+VZMI/A39CUfaVv+AaA/wdtg4Io4PXV
	808wsARIHsD7aZXBbbwe39rnkli1VFJqtsR8+oNK57zyrjisk07IhUtRci+dmbGSaZepudeXteW
	4iKNivlBjd00bATlfvMzM1LB57/xHo+SR86mSlG6z8cOMxmM9DXlw5s3ye+U+oemz5p6ulw==
X-Received: by 2002:a19:2d4c:0:b0:513:ed0f:36c9 with SMTP id t12-20020a192d4c000000b00513ed0f36c9mr9132286lft.45.1712081097766;
        Tue, 02 Apr 2024 11:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzWp30/35ol9RiIOdC+Dvt7bTyK8WadGPxAm9ZdLb9mGQnaUhhgWBUQWoANMM+1yaQOUy+yQ==
X-Received: by 2002:a19:2d4c:0:b0:513:ed0f:36c9 with SMTP id t12-20020a192d4c000000b00513ed0f36c9mr9132275lft.45.1712081097240;
        Tue, 02 Apr 2024 11:04:57 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a17-20020a05640233d100b0056ded9bc62esm886769edc.43.2024.04.02.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 11:04:56 -0700 (PDT)
Date: Tue, 2 Apr 2024 20:04:56 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
Message-ID: <deqh2ho6ra7tahcuczessc336kmsj3ltgsk6jhu34jrbwwkjqg@uvgkpd5kz542>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>

On 2024-03-29 17:43:22, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> There are more things that one can do with an open file descriptor on
> XFS -- query extended attributes, scan for metadata damage, repair
> metadata, etc.  None of this is possible if the fsverity metadata are
> damaged, because that prevents the file from being opened.
> 
> Ignore a selective set of error codes that we know fsverity_file_open to
> return if the verity descriptor is nonsense.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    8 ++++++++
>  fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


