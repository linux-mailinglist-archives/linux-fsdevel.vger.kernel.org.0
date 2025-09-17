Return-Path: <linux-fsdevel+bounces-61946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87986B7FFC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C2C542627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509622C08DC;
	Wed, 17 Sep 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wjJHQij1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4F222594
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118885; cv=none; b=DC7/2ANFUhCryr78+3DwGbhs8E+Id0AkVbvEwDUEjzU8DX1S63dIqOnJgCzJMki7jREpHjYhgXR+KnJi8+peqM5LrooEp3fpJTD0vs/O5k/eaf0QX/v5B0G2eB7q1ZdU6ALmdZhlZnppaLwCV1/6b9grWelM5vMhg5CmBWH9/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118885; c=relaxed/simple;
	bh=1TUVSazKQlcSc3z3Y2bsrkbYOyuQZNMq/r+GrFIaxTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hTmSC2L6xHRojVGHABZigGlcy7qd9TfeUtUqRxoKFWcopSCUcMz1AMXCZLty5An+sPuudgKjunikp1CSKJ0S2nLtRR0vwUA4+lkuQFn+T/GJvujmkCU6WcfpoQLTUmh402GjmaYnaOBCwv8qDe549v3OHNPrreWPeIn2uEEE+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wjJHQij1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88776dcac7aso238746239f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118873; x=1758723673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d68s8pWNCdPaGhVBNodG3vOwiZCJ3oHbIMlBi1U/Nnw=;
        b=wjJHQij1Djnyd+LvAKaJ4kZDOns/Xoy+QAvOS3vhpqxRB2B+xGPTELcZ2lPynzkwTK
         I3l4cTijuHItHj42TfPELiHvw2dhDtgLdYHWo5xIhbNbLEzoVQUrjCjhSh2tEqSrbo6t
         xHcXVl2d08mcWhHFf0v4CGXDC9Lgk2lfF9aQHF42dyYSRugUJ48y1NN3jiTpUt+PIH2c
         huq2O72EpWltyhKJhSubacSFu5Ba3RpyJ58Uise8DjqELET2s6wlEAKwr4IF+nEq5IV8
         cfBPcfLjgSiLIzWOpd0sHHjoOxSa+eEjLpBaEst2HvKX4LKilkAe+yRuG/vvcbpBz302
         fmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118873; x=1758723673;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d68s8pWNCdPaGhVBNodG3vOwiZCJ3oHbIMlBi1U/Nnw=;
        b=wTiEckUT0V2ZT3en7dDz+nHxKT+yQY/f3S9Wk2c6OM9wwECdfEVFfuUf7I3BgZpsmF
         HSOn7+agQpGuvAlBkOwgteV9lnrIzdskrUKuMsEUfHTSISW9mmvpQCJ8r/Qx8DB4qd91
         UEy302rmdmfBGUui7WNfXuNfkyl+8Ps5mqyP5zCr9EeeGPJFodwOiaC/9qUIV4NTvHkB
         ekV6glYUSK3Zx9cBe1+I9V9zLZgktcsr0M+f/uITixeSxIsmYitfUNeqcYnZxFlGCGjd
         o4YNponmlhgZHqKdZymVbSyItPzhjpWg5iocE7y+hlNUxNCvAetf4LTOrwL82kpjtZFt
         ONkA==
X-Gm-Message-State: AOJu0YyqonG2aCcKpfjyrPBm9OT+pYtRXXRA3WX4rBtH9zUKQU3GXNvE
	dlrirWrbEk4JVinpWUtk/76VOXm/KSf+8ecyVGZI3NfdhiJ+QVA8HR5I+bswFi49twE=
X-Gm-Gg: ASbGncumsoIr/67mwXBzHV7Dpe9yml4saLmmhT2EwKc217jIfyQ/SzDX5y9pcxXUjul
	1lSG/TlkiNJ+2W21RPd7EHf5Ztifl67y6R/5iLV1SXdIu7EarcuLO6cN2o6n2ABeSnkOubX7sFE
	q2u218IVZNIY6ge7oFoSGwXMDQRRQuPg2gs/Ch0ygHjXnQ6K2GIYceSTFbTpLOt1XIlMBZl34wC
	nFK/dFn+VZqKLGsXmxEptmgfJrUI6e0kNyzVz+1LhGdr9TR8w5lcGyze3C9B9cgiE9vDe9DJAZ2
	A+nE+8eNwl1VgoONeI9HvMOvWKvWjkSdM/jgpNPOh26Oik1jjn4GtrclZsFp2UNBX/BSuKdSg9n
	uraqJeiSDP1K3Hw==
X-Google-Smtp-Source: AGHT+IHdd2VS4yz6Fa1klXONV8I+5ZoG/vMhg8JzZxOXeIeHOgf+AemBCv8ARUuHNgaKUufvKlJZJA==
X-Received: by 2002:a05:6602:1683:b0:887:1b69:9693 with SMTP id ca18e2360f4ac-89d1bfaa016mr356375239f.5.1758118872921;
        Wed, 17 Sep 2025 07:21:12 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2f6c6339sm670751239f.21.2025.09.17.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:21:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
 drbd-dev@lists.linbit.com, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 john.g.garry@oracle.com, pmenzel@molgen.mpg.de, hch@lst.de, 
 martin.petersen@oracle.com, yi.zhang@huawei.com, yukuai3@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Subject: Re: (subset) [PATCH v2 0/2] Fix the initialization of
 max_hw_wzeroes_unmap_sectors for stacking drivers
Message-Id: <175811887192.378805.895284774096542580.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 08:21:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 10 Sep 2025 19:11:05 +0800, Zhang Yi wrote:
> Changes since v1:
>  - Improve commit messages in patch 1 by adding a simple reproduction
>    case as Paul suggested and explaining the implementation differences
>    between RAID 0 and RAID 1/10/5, no code changes.
> 
> v1: https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/
> 
> [...]

Applied, thanks!

[2/2] drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
      commit: 027a7a9c07d0d759ab496a7509990aa33a4b689c

Best regards,
-- 
Jens Axboe




