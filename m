Return-Path: <linux-fsdevel+bounces-18939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D208BEB97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492FF1F215D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD216D4FA;
	Tue,  7 May 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjaon+TZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E64C8A;
	Tue,  7 May 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107146; cv=none; b=CmFGY2GzAmtMX2Pjzdu6u+algxzaLUmrA70ZcjkJpg+ZVmKk85IrKpa/idsNmtHye2q/tQywM2dcaY9QMMaJ6SotnNDsHxTFsKHn0woDphgpO2ACPmdM17UsSeIErF+YMtUboNUz3O4NCr1pHM8sEWip4o7hXfWbV4L7nrlVA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107146; c=relaxed/simple;
	bh=+e7JwIYntPd6JoynacX1iCTVqyD9G8I62Q6xeEPQjd8=;
	h=Date:Message-Id:From:To:Cc:Subject; b=IPVeP1Vx7Bl//uRQfyThzwrLz59YD0dbrgCiuwVkBuOxItoptk8Hs8WMe46eAIHGT7F+EyCXU89mN2XB14fEiwI2CL2tEAWDX2o3BlGAh916uaWZ2IGQO8BBaPwjSa1Gkc6afW8YeKAYVNnm6RDhp6EsblMQmwi8bzL8j1TKVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjaon+TZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4521ad6c0so2588336b3a.0;
        Tue, 07 May 2024 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715107144; x=1715711944; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbTvMCqSzr4haV2ycU7qwM3HYG3Vs4AHqnsFnA064zI=;
        b=bjaon+TZDAvWe3bzhROCKarec18mVKG0P1sCx1v0eOZYvMieiamQ5zE8x9IUJvvTiE
         SOOrED/bTavznID3+GLY1VTnpvfhoYQaKiGfJlYCUad93ckhE96Hcv6LJEKghJPShLjr
         cWk/TJraRrmbWF/5ZOzB9l4JdWcziXKXpd9lpcrSyJ+osHCqab0FxZjzGUF7CAe3rKhs
         x3dJoLG4+vO5uBknwcR9otrLEcmIOmV7FJsuDph1/qUx45vyB2qLmUthvXDZ+1d9I126
         yaq5gaW05Uf6eIJwNEgrhLtOLw/grIu3u1ay2ZhTRCblAIMn6F1RH+6qkTysqKZ+qtCJ
         Hcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715107144; x=1715711944;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbTvMCqSzr4haV2ycU7qwM3HYG3Vs4AHqnsFnA064zI=;
        b=CHEdMs1UIkni/NKOBl/TUD0Bsgi/n7Oc1nGrnyAN1WALqDGOey7MzUiU41gjWCqdv/
         Az6ubqQxxkXWBP0am7m8/d+f1KIOqm4D4BlJwcnFD748npawcG5Dmhm1cwxUd9GeDOTC
         80nM20mu5XyoFGnRoLB0XE8o8sNWymifvPtCWuEpm+rThv0cNFZZUEsXgvdtqEUkRYIw
         S5AJhT9EL1mmIBC1f4QMFonkkuy09OsfvLsmOpVEQp+BKfJn17Zrwx2sqai0DNXjkPH7
         ovd5hBxSnA2mjuTIuSzyQuBNe6uSpADhM1Nw8QmxZf8a0JQpLMBymfVUyV4dYE2Jo5Sc
         fv/A==
X-Forwarded-Encrypted: i=1; AJvYcCXa/02PYY6K96IwcRdhHSUY6Kd2MlJAgfgf7/T/tlUOWem/t6F91tz2nJ4HniEztvW7aRspITZpQQpByLUpe2YuQJ+0OmrG5WycfiAjSG80SPk2oUSCnSs/XERpkec59CQyB0eF2KrkjVbhu08ssHr9KqZIPTRD/6NigBYT613lzET0Y1Xr
X-Gm-Message-State: AOJu0Yz7/hYHK32ltmmYgMUoj9m8+K0CTxt2cam+/EzRPdzTpGqT9YZx
	ViCY9bOxu/5S0Ahn1MJpeA7qxGXcCf0XPT1GRUtROzVEP1uimkd8
X-Google-Smtp-Source: AGHT+IG1CoIsZ33D9jBTrdDLGpbQF8WORjgZG8GNes4e13UPyDA8z1xFk6dphfOtkjP9qKAC1oMGtQ==
X-Received: by 2002:a05:6a00:2f16:b0:6ea:e2fd:6100 with SMTP id d2e1a72fcca58-6f49c2b1cb4mr437440b3a.30.1715107144144;
        Tue, 07 May 2024 11:39:04 -0700 (PDT)
Received: from dw-tp ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id p38-20020a056a000a2600b006f0da46c019sm9687357pfh.219.2024.05.07.11.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:39:03 -0700 (PDT)
Date: Wed, 08 May 2024 00:08:56 +0530
Message-Id: <87edado4an.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: hch@lst.de, willy@infradead.org, mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org, gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
>> +	if (len > PAGE_SIZE) {
>> +		folio = mm_get_huge_zero_folio(current->mm);
>
> I don't think the mm_struct based interfaces work well here, as I/O
> completions don't come in through the same mm.  You'll want to use

But right now iomap_dio_zero() is only called from the submission
context right i.e. iomap_dio_bio_iter(). Could you please explain the
dependency with the completion context to have same mm_struct here?

> lower level interfaces like get_huge_zero_page and use them at
> mount time.
>

Even so, should we not check whether allocation of hugepage is of any
value or not depending upon how large the length or (blocksize in case of
mount time) really is.
i.e. say if the len for zeroing is just 2 times the PAGE_SIZE, then it
doesn't really make sense to allocate a 2MB hugepage and sometimes 16MB
hugepage on some archs (like Power with hash mmu).

maybe something like if len > 16 * pagesize?

>> +		if (!folio)
>> +			folio = zero_page_folio;
>
> And then don't bother with a fallback.

The hugepage allocation can still fail during mount time (if we mount
late when the system memory is already fragmented). So we might still
need a fallback to ZERO_PAGE(0), right?

-ritesh

