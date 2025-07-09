Return-Path: <linux-fsdevel+bounces-54332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB74AFE1A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AC1BC82D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865E27281B;
	Wed,  9 Jul 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs39won/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C625383
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047618; cv=none; b=Ps/RviKttC1peqUe7e29sZMH2dz2ft48E3OF/R2uVEfhfEirMVxy1JmU2Xsl3F3+UIWq5i2zs8q3MyUv8PfAOr8lBckdtVxfUeASUC9VDGuzqi0lWTkz/VzyVH+7gDFEOg6lIbHubvOlwtS7jBXWcuTJ7ZXUCVOnURSQcyHrazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047618; c=relaxed/simple;
	bh=YiRTViN6sFugfcWHy68JCjyr4GwLcTomgBIK3NlTZ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tq1YMDH/TaX3HoIO9+zd59pRuTSQ2JrXETUdBZBxXWyKnY0rBMJLspQv7T/K/xirl96QhCfeKF0PFdj7BlN/fljjmHGXSE7q15jCiKDKaGsxo9LZfg78+pkeqjL+VkqW8zuseOxlgtJD+aJhaIuKOTYk6uCgYQ23LXO8pC0o3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hs39won/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167b30so53112875ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752047616; x=1752652416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSRb/f3D+1mlx48D0CzDoRw0M54T1sMdT08EpdKIp/M=;
        b=Hs39won/zvmbzw7jPrJ/Ko+gAug58ewzgcc0XKbhSxmHW9jY9cd3uFIG/8I3bIxf+5
         3IAx76Y9QtLDuxp1ARX62YqK34JYaWH38QSz366OuPnTqLBR+284IARV3z+3WZIT1TW7
         iVZeIXavhpuM9XfKyp7jInwXRkPhhF8NoyXFRazp+45JOlQTkUioNK2Udv0ooUvviyZO
         Hx5Pj+dhRQ32JtK2zBk8oeRwH1T+tNcjt5jgtDlQygIU6NXzHEOpIh2PcbUNMQneo3Ms
         7pYsTppgfVScqikkmBw4+mm6/C59P6lWnt+njrobEaSUpwjKmuk5amLpTy63rLoC0kw+
         /JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752047616; x=1752652416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSRb/f3D+1mlx48D0CzDoRw0M54T1sMdT08EpdKIp/M=;
        b=JDD+Ed05R7G+c42DHnwgoopWPf79MmyBYYkbcu2VCyGAj7XDtiuoSIdZ5Clnoa9otl
         r8CyZad0XnT9QjiD0aPGl+dkMnB/SwzZ1GqZ6OZ2xIm8iWLMrNJclgvvCRqj+CYM9I00
         GeybnAL4c0f8IfS0Z3e0jq+6fEgTy/zVAkXB5udsIPh8Rxs23yIHsYQi1AyqdL5xgPJa
         cJH9fjIaj4alEVi2n1V8TjogdIFU3ENU7ZwwIcsCcDrPL/xQ0Fd0CVg0ttsy5dxowzU8
         5R2tPLug6cc30TFm4qcda32caQubyLLQd8jVx/9j65jhl5NH24Yr5f8e0O4QPEPRdlNG
         Dnvw==
X-Forwarded-Encrypted: i=1; AJvYcCWCnRFB5u4i/jIUyriOK/j9+9A1Gpf1+Kh1zzjTMuNV89LsLj8LTrmqCLDY3v9Rr5mBtSEYrr9Vb/yhDanc@vger.kernel.org
X-Gm-Message-State: AOJu0YwClhrAlhqSDn/l+r57ZIR+vn51XANcujkwb4e7AlSPOv1UOfqw
	E175n0H4Lx3I6P+gd6ijI9ckz85ATiWKt5Ehe9yHLKtnl9IB1TiFR/OG5WPaaF2tqRQKrMSiseI
	8VvGMvsS8hMbXHK52bGUR+rlmsn5D2gAv9XYJepxlJA==
X-Gm-Gg: ASbGncuM7O7EwNnHoUtwNBQdHlhctOSt6X0g4Eyys2Dn1ZKesjKuk+556Hs0jfQqwF4
	vKv7SUgg6xfPFudYdBIT7XmmTCyRvB2cCSysoqiiERRHu6lcDPgbLK5lAfftdIQXM72BV29/rKY
	BRAlirDVX/D2M5+4ttF1KcQ7UG+7hhHr0s0mUGECOzg0k0shR1gFIUeDcThmoj4acao8BZltVc3
	xVks6lCnZ2ZqaY=
X-Google-Smtp-Source: AGHT+IFTpw9IyFVln9jcj7sOWtr3g6epVrGGfan92wq+FaJIONZdCE8t1/jqdXFlbGoqLQcJM938+Gi2RQnDj4EcuQQ=
X-Received: by 2002:a17:902:f205:b0:23d:ddf0:c908 with SMTP id
 d9443c01a7336-23dddf0ca78mr6375655ad.6.1752047616451; Wed, 09 Jul 2025
 00:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 13:23:25 +0530
X-Gm-Features: Ac12FXxDkre9nFgz-yfBFb9RvXNEyb5lmt12udtMlCfaF0Z0wAperRuxm5yhZlY
Message-ID: <CA+G9fYvXTCK5PHSazWkE6yww1QJA=wwb+1xV0udMSXgc63P_6A@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] ext4: fix insufficient credits when writing back
 large folios
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, ojaswin@linux.ibm.com, sashal@kernel.org, jiangqi903@gmail.com, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 19:53, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Changes since v3:
>  - Fix the end_pos assignment in patch 01.
>  - Rename mpage_submit_buffers() to mpage_submit_partial_folio(), and
>    fix a left shift out-of-bounds problem in patch 03.
>  - Fix the spelling errors in patch 04.
>  - Add a comment for NULL 'handle' test in
>    ext4_journal_ensure_extent_credits().
>  - Add patch 11 to limit the maximum order of the folio to 2048 fs
>    blocks, prevent the overestimation of reserve journal credits during
>    folios write-back.
> Changes since v2:
>  - Convert the processing of folios writeback in bytes instead of pages.
>  - Refactor ext4_page_mkwrite() and ensure journal credits in
>    ext4_block_write_begin() instead of in _ext4_get_block().
>  - Enhance tracepoints in ext4_do_writepages().
>  - Replace the outdated ext4_da_writepages_trans_blocks() and
>    ext4_writepage_trans_blocks() with the new helper used to reserve
>    credits for a single extent.
> Changes since v1:
>  - Make the write-back process supports writing a partial folio if it
>    exits the mapping loop prematurely due to insufficient sapce or
>    journal credits, it also fix the potential stale data and
>    inconsistency issues.
>  - Fix the same issue regarding the allocation of blocks in
>    ext4_write_begin() and ext4_page_mkwrite() when delalloc is not
>    enabled.
>
> v3: https://lore.kernel.org/linux-ext4/20250701130635.4079595-1-yi.zhang@huaweicloud.com/
> v2: https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
> v1: https://lore.kernel.org/linux-ext4/20250530062858.458039-1-yi.zhang@huaweicloud.com/
>
> Original Description
>
> This series addresses the issue that Jan pointed out regarding large
> folios support for ext4[1]. The problem is that the credits calculation
> may insufficient in ext4_meta_trans_blocks() when allocating blocks
> during write back a sufficiently large and discontinuous folio, it
> doesn't involve the credits for updating bitmap and group descriptor
> block. However, if we fix this issue, it may lead to significant
> overestimation on the some filesystems with a lot of block groups.
>
> The solution involves first ensure that the current journal transaction
> has enough credits when we mapping an extent during allocating blocks.
> Then if the credits reach the upper limit, exit the current mapping
> loop, submit the partial folio and restart a new transaction. Finally,
> fix the wrong credits calculation in ext4_meta_trans_blocks(). Please
> see the following patches for details.

I have applied this patch set on top of the Linux next tree and performed
testing. The previously reported regressions [a] are no longer observed.
Thank you for providing the fix.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Reference link:
[a] https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

>
> [1] https://lore.kernel.org/linux-ext4/ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen/
>
> Thanks,
> Yi.
>
> Zhang Yi (11):
>   ext4: process folios writeback in bytes
>   ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
>   ext4: fix stale data if it bail out of the extents mapping loop
>   ext4: refactor the block allocation process of ext4_page_mkwrite()
>   ext4: restart handle if credits are insufficient during allocating
>     blocks
>   ext4: enhance tracepoints during the folios writeback
>   ext4: correct the reserved credits for extent conversion
>   ext4: reserved credits for one extent during the folio writeback
>   ext4: replace ext4_writepage_trans_blocks()
>   ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
>   ext4: limit the maximum folio order
>
>  fs/ext4/ext4.h              |   4 +-
>  fs/ext4/extents.c           |   6 +-
>  fs/ext4/ialloc.c            |   3 +-
>  fs/ext4/inline.c            |   6 +-
>  fs/ext4/inode.c             | 349 +++++++++++++++++++++++-------------
>  fs/ext4/move_extent.c       |   3 +-
>  fs/ext4/xattr.c             |   2 +-
>  include/trace/events/ext4.h |  47 ++++-
>  8 files changed, 272 insertions(+), 148 deletions(-)
>
> --
> 2.46.1

--
Linaro LKFT
https://lkft.linaro.org

