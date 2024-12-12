Return-Path: <linux-fsdevel+bounces-37135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B109EE174
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 09:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD34F283060
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6120CCEE;
	Thu, 12 Dec 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJPbpcvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B820ADFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992673; cv=none; b=tmbjley4Arx1p2XuNBXiAqlUr71bxbz7ECf1ecTE9XvP3Mgvm44+lzOQuUaIgp2EDSmO+JcwzxudcT18aLJzAZlu0A7BBF5EORM2Cb7Kdy7x07NuFzNy8of3m+0QSlJtRJfIuPVWob31qHFR3LeEKsKQb9e/N4pqjo59aibznEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992673; c=relaxed/simple;
	bh=Rbng89OmgVe8qgtyPfxV0jpcaFNkksnnhhnXCrIh8Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXmMQtHXOuvwRgJBue4PksV+scKrOoIo/fsQvl5c/y3Z5cz6q7E1q8l+VeqzSf5fBpUob97bIM9KsrbfovlDoe1wKnXJbQZ6hW29ge1gVei2wrnB+b7WuPIdJvwbxqTprSGvu0ZOhsP3g1PxX/sb09Ba52fxk0rTIZOs01nHN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HJPbpcvm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so3095175ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733992671; x=1734597471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/tC9INUw3nxk6MhIa6GMSnsttorIpfFHd1cjdeGL0g=;
        b=HJPbpcvmqkYE6Yw29E3L+q0D4UBpXjw7lV8CSaY826JctJ9aDYqS0iUtRqgjWQFX/7
         CX65Dw012RidftVjQYY/S5ApyQ6lef9LfXLpTLLK4mj2LRZ33BWLTe+L/cGjECc9dnf+
         ECrgVUL0IENNSwhn8P9knIIACOUn3Sj3eSMvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992671; x=1734597471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/tC9INUw3nxk6MhIa6GMSnsttorIpfFHd1cjdeGL0g=;
        b=uKthN3zDT2PCKWTTuT9W8buObTcAhgVBgXSV4mPzESq8NOGJQBOejbxKtwBAAXd6IN
         QcdNCw4DUjPNtgwJZJfH0k/PKRYzjcel0W3LQwzdDVFkh+WYjJkq3B7k8bFWa4hpYRR9
         CssBjj2n0yAprymYMDip9VHShtidByV9mZcRDc75+OGfJa/pHPOYIPjDINOddxgSbr4W
         KGQsH8FzZijv7VPLpU1V/aNhhtecQhjZoq4x8pBL+J514/drzl2QmOXBsoeG6sE9YpTQ
         yjbntOMIL3H5dvypgdYXiLfLH5Ud8ilhhLnYs7LbYLh94h92HdF+OFXc8T8KfLJOtSuf
         JcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvmkWDORgAfA11cZWhzTsolxfWxWUrt17L+nligAgFO/0hYXjGoxo0kd5RmzavB0lwcIrouVzcCKNTuPAR@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcRxXRg/O+sERAHFgCgRY2oZQQLqiBtcnwDLFCiKe++y28X0d
	YNa9pfnS5xfrWfkvG2R2nnTfaTLijLn0rX+17jDvr6KzhVqv+WSdXEhU6vxe7Q==
X-Gm-Gg: ASbGncuo3uJWn80Bxq90ex5M7+tW5m51qdZ6SwtRAZCqhbMndFytj3jdtDbDUCgTqtX
	RHlp9nnWd5VlplDOI3DugV28+MlrVtMHVJbGDOVCFZ3RVh0x8o3Na1s6+hg+BymG20j08uKY6fa
	o2yyHdLMI51ZDp6VF1RKTeJjkzf7B+Ciw+CP2QdCG7lcs7k/4yVkliLadfQUAU8tqjaNxioNCQN
	jcS2GSiFsoe3YOIEdrYtakuZ0dy6f+ZJNH8FQqTOrJQT4gon5d58zk9bh/z
X-Google-Smtp-Source: AGHT+IHZ5kxa8yQScj0ArR5Wlt0n0MRtkMZZuk9KObBe61yQupsS+25xkOzCrCZr2ESPTHNTXj5SAA==
X-Received: by 2002:a17:902:da8a:b0:216:4122:ab3a with SMTP id d9443c01a7336-2178c7b6821mr38784145ad.1.1733992671086;
        Thu, 12 Dec 2024 00:37:51 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2d7e:d20a:98ca:2039])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216364e45d8sm77545115ad.175.2024.12.12.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:37:50 -0800 (PST)
Date: Thu, 12 Dec 2024 17:37:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	caiqingfu <baicaiaichibaicai@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <tbvkmwzy6od6xs5lsppvifo5dvv2wgaq776acwm5yytmekdlpx@7lo4nfmd4s7z>
References: <20241212035826.GH2091455@google.com>
 <20241212053739.GC1265540@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212053739.GC1265540@mit.edu>

On (24/12/12 00:37), Theodore Ts'o wrote:
> The blocks which are getting modified while a write is in flight are
> ext4 metadata blocks, which are in the buffer cache.  Ext4 is
> modifying those blocks via bh->b_data, and ext4 isn't issuing the
> write; those are happenig via the buffer cache's writeback functions.
>
> Hmmm.... was the user using an ext4 file system with the journal
> disabled, by any chance?

I believe you are right, at least that's what caiqingfu said [1]:

echo 524288000 > /sys/devices/virtual/block/zram0/disksize
mkfs.ext4 -O ^has_journal -b 4096 -F -L TEMP -m 0 /dev/zram0
mkdir /tmp/zram
mount -t ext4 -o errors=continue,nosuid,nodev,noatime /dev/zram0 /tmp/zram

[1] https://lore.kernel.org/mm-commits/20241202100753.139305-1-baicaiaichibaicai@gmail.com/

