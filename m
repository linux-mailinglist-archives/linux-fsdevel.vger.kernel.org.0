Return-Path: <linux-fsdevel+bounces-18433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA88B8C0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521C8B214AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BF4F898;
	Wed,  1 May 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRygughN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CB12E6A;
	Wed,  1 May 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574523; cv=none; b=XGQhvd9BH/xwiUQGoOHwR23XcH3tIj09thptsyUS9lSE9rQWCpBYHQ+aTwQShU+jxRyvak6TUEgz4zP+J6rBmQ4DDxT8rWnNH7GTrJInkp0X0DBB0FCwa49Xze1DXmTsEtQbd/DfcdEW2G9mCwVQWbb1PUzGiB837x0g0nVbllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574523; c=relaxed/simple;
	bh=H7nascuVRiOc1h40qWuw1zSs4lOrgFH4nRcw4Gl/srw=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=tgrQFD0rbz7t7MRw9BMroIzBNr9zPONF8qsFT9lSqv/BOML4Y4yu5VsIyN02fA49v9Bxmp1oQY/VuxcftMOynz9jGVKtUY6xha488ZsnJ0jL43djMKXHPcUeM1E5QGHu8NN8w2DWRb3saWCmvtN3SfX+lDOop3puF1H0wjaPcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRygughN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso616709b3a.1;
        Wed, 01 May 2024 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714574522; x=1715179322; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QWu0hcmQYixAs4X/1S4ZEhgKxoQgCqRdjgR7BLis12I=;
        b=aRygughNNqxGuqMOcULzIKDbh3qFg3dQRHiLwkt0FvKCZDagBDf24FYiKCVelsTPtv
         wUlijVUEPJeZIXAIxriHR1Ggh+IyPXX7L+t3D0xCrPD6WmD3DDOnFKUh+XuszKvM0qM6
         75g+Nr/Ey3k/kSa4q0XKwRL8S6xk9UGt2mMxJ/0xOEZmskiRKJeZaDBmFekfM96lX6R4
         W1h/QI6XFKteO6st7FE9DDBTLhceizR7A7f+bTYC/no40LOJmeaQN8DHN+PJaYTVT3AJ
         RuLLkjwjGkcv8phX04JDY2+mFYBc6EN/6K/DpPFGu6pUmrahYwik63fCgRkfTIitiOCU
         OsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574522; x=1715179322;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWu0hcmQYixAs4X/1S4ZEhgKxoQgCqRdjgR7BLis12I=;
        b=Wn8rBEATBnhLiMQ+wDzCb5FruWxwZBKjcyUfDhvf43n1XPXfnvzU73tXzrTCy/Zxgg
         CNbaqBj+b/0xoLvknP1/+ybpNlX6I0dMFfyJtEGxE+Ozc3O+UldDzanIFM8qA4wm56t0
         tm++F2YMG9beaV8CnfIx7gYKMm0PqdJIsT5juLpeTXdRvGoz9QYTgLv+xPPNW7DEPQMY
         U+ejBPiZD4fpHD+l6pFX3VbVWNplcQXtl8cUjWhQ6oL0btRt62QK5TszZLBslERzJeuG
         Ji8qEjeJENXTZpdQjXBDENrY0G83Eixtk0cmLd2km7S6aZfB+KAo66ksbYQeodV6xoZ2
         fV1A==
X-Forwarded-Encrypted: i=1; AJvYcCW/3PNVkDydtsyguvZQ/6Da34ybSOsemXuo5UbFIjoCuST8hbbiC3I29lop1tGSLMCZ1oltX1YCrEJC+8knlbxTmBasFFbcr3ojdIXUl0FcFdc65/LE6m7r4lm0fxwL4+L9fhw4KGLWoQ==
X-Gm-Message-State: AOJu0YyPVMzVAMyUdWTBNhy4qrkqR2uHAvfyFzZOHYWhdmiHC+drqQKT
	oo7AzRxH7R1VOT4dy7vCfFI6PbnXZz9WYrKNGyuqvMJhvRn4yZxD
X-Google-Smtp-Source: AGHT+IGU7duUTElL35l5TS5yKDvJK9y5574CYJ5VoN+Egsb1ISGasGHrZHHgLoeL4IlHddUjwiDm5A==
X-Received: by 2002:a05:6a20:914d:b0:1af:6088:10fc with SMTP id x13-20020a056a20914d00b001af608810fcmr4553269pzc.13.1714574521775;
        Wed, 01 May 2024 07:42:01 -0700 (PDT)
Received: from dw-tp ([171.76.84.250])
        by smtp.gmail.com with ESMTPSA id p52-20020a056a0026f400b006ede45680a6sm22684900pfw.59.2024.05.01.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:42:01 -0700 (PDT)
Date: Wed, 01 May 2024 20:11:54 +0530
Message-Id: <87edal4mrx.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 04/34] ext4: drop iblock parameter
In-Reply-To: <20240410142948.2817554-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> The start block of the delalloc extent to be inserted is equal to
> map->m_lblk, just drop the duplicate iblock input parameter.
>

That is indeed correct. Let's drop the unnecessary function argument.
Please feel free to add - 

Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

