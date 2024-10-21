Return-Path: <linux-fsdevel+bounces-32539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7449A935A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AFF284014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5F1FEFBE;
	Mon, 21 Oct 2024 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mgaibbP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F841C9ECE
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549862; cv=none; b=iHpCXqPqQEaj0khokin9mbgryTgzdbq/3N+5d6ibtlJdTVMZGbrERGgOhGw8PdfjI5DnWf3klHPzUSdMiMM3Lo8dLNac9J1iTk6PKNymfJNQ5phgLtXxvM4g8vp1PsDnzIKC9+poAhdlvgBKCOcEcv5ElkPbCT1ClafCpWgipow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549862; c=relaxed/simple;
	bh=02WBLYn5hm46RGjKT09iky3RgWRBw1dRwnKC0MwXA8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izWxOtq04r27ef7pWb4QUop0Emx8yqaBgHzQlwPGRDisgd/bNXuIWpKTY02hKrdByZv49ZHcIPtktdkR2y+NCQ+4fx04xZJHfqGFwE1QUZ1ZDVlW9BjbAz+YtmCG2C4om8ZU/JVDoszybmX4NoGqlAtU6LbctVeGFUIRWUqwj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mgaibbP0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b5affde14so34343355ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729549860; x=1730154660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpov8qknWLMdPqHJDFq36iRXP4pxjN7UjssnKFRCVMo=;
        b=mgaibbP0ao5eSiG3E8f/qHnKdePZqWKL0c8oPigvqb6qatxlTlO0UWJUQD5OQ2bmh8
         37IDy2A09CIDOZfogr47ftMGJQ51w5k0d59J6e6rl53+gjITrMYRvIIqiQxCRbnq+6UH
         HjDUt0K6Uw15ge/DV3mI5pEMlseghjxTO1Mlc2SCJyZplClsWdTWixIGvDI/Cm//Rck3
         FzN+wDuIbwEfiF6S3c+xZuN+WFJU0sWY7g6un/pR+M/Jc5IzDTdNwEoWE4DAhl+wjJs/
         j7pAc+DcAyTzmSNmCT50SCvDoe2vHaodunVkBSvyyxjAKt+1aS3nBpyc/8nvT9X4Lvj9
         GKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549860; x=1730154660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpov8qknWLMdPqHJDFq36iRXP4pxjN7UjssnKFRCVMo=;
        b=Xua1JRhNmGm6jCqi/O4OlgA1mZtPecLUfPaHtovLI+oDVgJ+6gHuVeV5691VybS8Ls
         w1xnfnzDHNrs2g9m5yTTsD4Ifm3ytZlo4+e/SWvTcrmeiWJn/cpjTzDtr+IkGzVHAZqp
         RKbq5b62/mwRjP9y4csDp8JEsIO9m/eBWFTqGI5G5EcuFE9xTZsrDyEE5Ie2HdCo/5sM
         DLhSMDFbuJNcL5NYM6RyBpe8HdVKI+tTrl3ipQ1cLgZY0R+QBsKgoMUy5cC2XYflQ7tA
         0HnMFlZYNeMpd/6LKtQzy03XD/JgmVsHepjs6KtiKuSta9RBVoQSVA6zjeyptfOTqScm
         XgiA==
X-Gm-Message-State: AOJu0YzLbg5qnCLgJkc9ILBF0a+UAY5+nU0Px4iR+umHxBWtzyApl7Be
	cYR85UYahmLanClTyLY8r3zrQcNqSxF0GnbjV6tgt5TnyGJ6PksO/YcW0AQ8aVg=
X-Google-Smtp-Source: AGHT+IGnZvSN/JgkvgxC51U5ZIowUxltQuOXg6wu1T2t8vfivVOuEl4426pU73OYYuA8tQqUXZlpGA==
X-Received: by 2002:a17:902:ce85:b0:20c:c1bc:2253 with SMTP id d9443c01a7336-20e5a8a101dmr167189345ad.32.1729549860470;
        Mon, 21 Oct 2024 15:31:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3ca3sm31011095ad.274.2024.10.21.15.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:30:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t30vQ-003zWR-2L;
	Tue, 22 Oct 2024 09:30:56 +1100
Date: Tue, 22 Oct 2024 09:30:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: writeback_control pointer part of
 iomap_writepage_ctx
Message-ID: <ZxbWINZwAEJEdX7S@dread.disaster.area>
References: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>

On Fri, Oct 18, 2024 at 11:55:50AM -0400, Goldwyn Rodrigues wrote:
> Reduces the number of arguments to functions iomap_writepages() and
> all functions in the writeback path which require both wpc and wbc.
> The filesystems need to initialize wpc with wbc before calling
> iomap_writepages().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks reasonable to me - there's only one path this comes in since
we got rid of iomap_writepage()...

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

