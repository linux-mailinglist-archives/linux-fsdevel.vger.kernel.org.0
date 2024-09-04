Return-Path: <linux-fsdevel+bounces-28615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9596C653
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E3FB20A90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18001E1A37;
	Wed,  4 Sep 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEUDkT3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480012BEBB;
	Wed,  4 Sep 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474393; cv=none; b=pNMu+AOC0avI3AFpRq2WyUFAOQV5rUzGEV1t9NKMqjgrwRneuesK7lGA9Ko0NjTQZCQUuIjJjzyel5A6/O18pb8+q6+b5/WGgdc7be/eSprvMxTtj4+RndbD5jCoiE18O7Llz+0zHM29qJuW2SfwYYGLgNWelttmNAuh4j/8dJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474393; c=relaxed/simple;
	bh=tWO0wEGpUS/7MzqeG2otdCtiNvnkNqeg6JHRBSN51UM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=aTwu7qEDe8YAv9xtFlBqmJEB2bgzOeZNwx++635CoG7stNZFMaBohjeKwbUBwliSCKU+LLFcZ61BZkv9gB3BIifne3Z7KbWiLCQ5KLrgH1vIy9XPVTYIBIqMjiujKVM3EszkMrqTSDVkjQCEP/8zWrHV2Lh4FIVB4F24h5DHjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEUDkT3a; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c1324be8easo790820a12.1;
        Wed, 04 Sep 2024 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725474390; x=1726079190; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ciIY1oc6o7N91wyFURsBsFlambVxY2VkVsuF4KKa76U=;
        b=WEUDkT3akGB/93FKsG6kyKL2ohIKe4ArEdFWuFAnX1jqWcbrPTlCKb3EcOm8X8qd/F
         +dOGbCMbiEThS4an1ZVtxk/eUPut2IF9wtdhPj9W82R1t1F0AOP1QutPUUShoKesQ9+s
         cx3SMYlmqA80OIRcdXunaswxJuivXBKgmlHjausGH9McF1Il2Gl3AyCvl5I2lrzfzNgp
         4ncKhptr5bo5PmG/FnXFaxlV/qpc1snGhlQ8mfFvsxnnHm5ZSfF9zvnzCRpQC5t3tQau
         3oFNzhGTX50jqLpoUfrGz0PQiVt4pJlYWcwRZ8uZ/B5HjZXXTNF/34DeRxvZM3XzgM0z
         GVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474390; x=1726079190;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciIY1oc6o7N91wyFURsBsFlambVxY2VkVsuF4KKa76U=;
        b=TKUTOYrDY1Go+BdHS340srptVIq9ZNjl6ppB+FFC6Jx5C3ryVrfettQd2jNVxgX0sU
         IMp/o+rvBrLyxmi8Y9igHCn5iXOaEksPtbcoOLu+z5i+NuYbJNEmi2eakGXpXlEgADaC
         VC50HnKpgkKen3j67ViqfN51YtJfiDJc6fWpG3T/c9Y778x/duePxySwDIzNNEQcAVeZ
         VTJ6Jj0VowWVGzhO1UfTjjO65nIXrTe2t8T2JtCJaF0MhKLZZUuUSS6YhVJSBAe3WWl6
         gYP4xhQ0CpfWjk0pWgH9RcBR+6c45D7YZvODydtwpWCIIN2+Qqu7UE60lF9MKjdj8/Re
         cP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1OwiffRI8TE150KhFRVX6/ou4CN7rDAb6uRY7y4/R0ZBQcoW685PZNl6WwXowVLjkB+TBhD+KqdeO@vger.kernel.org, AJvYcCUPpewgndbE5bJOfEv/Qo5NIHw02Egjrcgs+IJDXEgF6Ck9RWOazEcAN+tKDHpimNswBdpCf0yndklxPm7U@vger.kernel.org, AJvYcCX9CynaJPWoQIzBzIYsXtyhGDW77QW4qu0h5WwO9ua8MXGnf7joLJoT7wpN7aiL1+TLVqdhAQpg0kVxC4lF@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbWtq0jWbzc+1MAkSYEzV6dKLLl6bZZ559+svuz3fFIgrDUHD
	ioUZ4YlNJ3K1JKeNz6zSsKM2cNqi/tK3OjK2FeDcHUnXL9NTWMaM
X-Google-Smtp-Source: AGHT+IF/JZ9++ANi1ZisC4hye8nq1DbRVMgUkn6rO4K3wMGTIB+ycbiYLZmu8zcia5qqq+4ttO+5mg==
X-Received: by 2002:a17:903:283:b0:205:656d:5f46 with SMTP id d9443c01a7336-206b8461b10mr51217835ad.28.1725474389898;
        Wed, 04 Sep 2024 11:26:29 -0700 (PDT)
Received: from dw-tp ([171.76.86.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea53efasm16424885ad.195.2024.09.04.11.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:26:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com, martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 04/14] xfs: make EOF allocation simpler
In-Reply-To: <20240813163638.3751939-5-john.g.garry@oracle.com>
Date: Wed, 04 Sep 2024 23:55:05 +0530
Message-ID: <87ed5z2s5a.fsf@gmail.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com> <20240813163638.3751939-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> From: Dave Chinner <dchinner@redhat.com>
>
> Currently the allocation at EOF is broken into two cases - when the
> offset is zero and when the offset is non-zero. When the offset is
> non-zero, we try to do exact block allocation for contiguous
> extent allocation. When the offset is zero, the allocation is simply
> an aligned allocation.
>
> We want aligned allocation as the fallback when exact block
> allocation fails, but that complicates the EOF allocation in that it
> now has to handle two different allocation cases. The
> caller also has to handle allocation when not at EOF, and for the
> upcoming forced alignment changes we need that to also be aligned
> allocation.
>
> To simplify all this, pull the aligned allocation cases back into
> the callers and leave the EOF allocation path for exact block
> allocation only. This means that the EOF exact block allocation
> fallback path is the normal aligned allocation path and that ends up
> making things a lot simpler when forced alignment is introduced.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
>  fs/xfs/libxfs/xfs_ialloc.c |   2 +-
>  2 files changed, 54 insertions(+), 77 deletions(-)
>
<..>

> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 2fa29d2f004e..c5d220d51757 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
>  		 * the exact agbno requirement and increase the alignment
>  		 * instead. It is critical that the total size of the request
>  		 * (len + alignment + slop) does not increase from this point
> -		 * on, so reset minalignslop to ensure it is not included in
> +		 * on, so reset alignslop to ensure it is not included in
>  		 * subsequent requests.
>  		 */
>  		args.alignslop = 0;

minor comment: Looks like this diff got leftover from previous patch
where we cleanup minalignslop/alignslop.

-ritesh

