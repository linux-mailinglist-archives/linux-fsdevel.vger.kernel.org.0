Return-Path: <linux-fsdevel+bounces-26010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16395253C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B52282EDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD511474D7;
	Wed, 14 Aug 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XCMO27Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76260145B00
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673301; cv=none; b=h4Qi+I5MaArM3oVkxK9B0PLiO8gSK7TIvev59/AczfFPTyjsp5lBb4abzBtsel7eJLICtF5eQWrD5+p5bSrQ9RFeP8WbRh6nFtMNBklttXxkJorKtEfCpcEGE2MqsiHNHm3r57TyWO5oKHEt7v4AhBfuP4oh5nm4t3BcVQYAyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673301; c=relaxed/simple;
	bh=zOvNMr03TPUtdrxDPG0pqVSzDbnYFIVeiSXRASD3JC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQXjq4Hc2NGGn56giuZL4b59t9iueiRvIQFzvzX9SjmX9Z4PBYUju/+uOzD402XBP5DnRcPNzHbKS3r0SqhyJOcLerAt7+wjg7783Im/vJ//xyFBqW3W3GsaH5Fg/uK74Eoj9jd8hxOZBaqjGuokBHvEYmqfbE/Kqq0UBBZKCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XCMO27Ct; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710ec581999so264995b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723673298; x=1724278098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pI0RJyccq+WhdFidxwClKhYjt4O4xuPYV2DfM2hytB8=;
        b=XCMO27CtzcyjlRR0ls2rd/LsttZj+x7AMwZvIMpRW+jYc21XUiUK9LXmJ6koB760MX
         Asbvrd8Di9dsIKBSP9UrmfOwNmQ3gVuBAFLZwwF+XxTFPjvsQLwwANZx04Hvnr7uqhAk
         /P6mQeXZPP2UdpmADDLT2pilBU44o6v3GBsf+3SpoQKvQqT8KfgZx08QsSbvB4Vx/L4Q
         Gnmnmhg0C6B4boctpAq2Xr/6v5tEsDEq/BGxu0Rdy/30WW5C7YcuGMXCfvsks0DreBqF
         qK+S3PZcM11f3xi0cV43ji7hTsdeUH2j0NhmR/9Ar3gdrH+FRVw6RdiKZohtPZvPj2uM
         dpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723673298; x=1724278098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI0RJyccq+WhdFidxwClKhYjt4O4xuPYV2DfM2hytB8=;
        b=Wb6HWsQIUZhaRnw0IH8y7nPWp/aTQ7nRkVT95nj3Le9hkRu8HdkY5A2XmYfm42W1zf
         NegTWaShZO58A3O81lnVtiX+ND/SRicpOHVJG4CCVCEQTtyivAuBs/xWJrMV0l0ZTBSm
         JNDMZotL1iQra9a8kJRHYGpnoOpH9BRzhxWcs7snAgvoP2sAx7yTkfxzEecgU7oHU/zQ
         8yYbBE5VaAvUvsF5BO2E+mgMJjqkWUQlACffP+iwkdk9VNR3gbYr5uJSJtgoYpkig/p2
         HmisYfWV468JqLYImhh6iss0x96K07MiuoWGq8DLvm7/Rw8iT78uPcSQjdCuX6JTw6fm
         w4HA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJBFdXyAXjqO51AkGlPxn6qKHI+QnIBMONT7aGm4DnIjBRl0XYOtlhl/fTZPEshsga63m15uxltg99Nt/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ELXjtfF4gEVN7hVtTefKUyyZMPvJYkhFZjURluTvezoCdSwB
	Qn8kq4jlkoiu/1H7D3Z5PIGfX7Tz5EQN5ljpYRA/doFWFSXap73k74KicBk8FIXoNBnWsb7Dg8W
	U
X-Google-Smtp-Source: AGHT+IGOd7RgBslXBIAFQsy/rESi4NL81EEIvjf6i1fFPKSuyNRmjD7RqDQwa+CRdKCsC9y06xt2iw==
X-Received: by 2002:a05:6a00:b41:b0:704:2563:5079 with SMTP id d2e1a72fcca58-712673ca1f7mr4760512b3a.27.1723673297569;
        Wed, 14 Aug 2024 15:08:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef68ecsm48902b3a.116.2024.08.14.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:08:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1seMAA-00HGm2-2U;
	Thu, 15 Aug 2024 08:08:14 +1000
Date: Thu, 15 Aug 2024 08:08:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 4813305c621d
Message-ID: <Zr0qzrVKkJN9QWNo@dread.disaster.area>
References: <871q2rqdcy.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q2rqdcy.fsf@debian-BULLSEYE-live-builder-AMD64>

Hi Chandan,

On Wed, Aug 14, 2024 at 09:56:11PM +0530, Chandan Babu R wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.
> 
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> 4813305c621d xfs: fix handling of RCU freed inodes from other AGs in xrep_iunlink_mark_incore
> 
> 5 new commits:
> 
> Christoph Hellwig (2):
>       [681a1601ec07] xfs: fix handling of RCU freed inodes from other AGs in xfs_icwalk_ag
>       [4813305c621d] xfs: fix handling of RCU freed inodes from other AGs in xrep_iunlink_mark_incore

Can you please drop these two commits from the tree? They are not
correct and less than 2 days from initial patch posting to merge is
not sufficient time for people to adequately review bug fixes....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

