Return-Path: <linux-fsdevel+bounces-13572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D1287137B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 03:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F8B1F2404E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594D18040;
	Tue,  5 Mar 2024 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjZgwG0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129C10A39;
	Tue,  5 Mar 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605071; cv=none; b=SflFwTLY3t5OYm3aLRlnSWDbIC3ZH4UfKdVt7hgjmz1XRLi1waT8dmZYjBY9RK+G25mYxTYMsN/zbwFKg/z4rI6Pk8n78syQGX9kDA5iYQ4KQmyqxJSusQVJ1cKUcPelegog0pdMxQtZfyhicIKcmlvhgNRTG5WZgVt190duchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605071; c=relaxed/simple;
	bh=mZ+cF6bQtTgVKW3RQ7HEBaJGWu8tdS6ZvNSVk1b+WvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCZeXY+AdMNWAL9DHrBOROVaP03lHRS1U2jgKR2YoBMTB5ZL8/RRKC5gLppdm+eco41s6O70W3EJ+JcHAAMB/YjYD6qaqnzIjGdLopz2DsI4oNe2GwDQQSUCip/eNFyvlYhtO3RGKKd2UWej7eA3uoTlv2RvWo/V/14O5hEFMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjZgwG0h; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dbd32cff0bso43630505ad.0;
        Mon, 04 Mar 2024 18:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709605069; x=1710209869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf7ga+69rktGnQ6MLiBZYdtLAPO5MhkKVAzEKIflNBs=;
        b=QjZgwG0hjfy5EHdRKFZw3d7DfmKYYP5aopSVcwK6DamfDs9Rsb7lCLNfRJxKFPbbgx
         PI9HY9y5mBWJDTYPQUfEXWv/NPu5qqZ+9Zxr6w4q6kW6eslEDBZIpfKSivYiOqIFmcss
         m6XwzM60rdfrQag62klMcsbZPY0dUc8ozWMr/61awwOv6xDeTQ0drIz521bAmDeIDxBz
         F/fCrNI+RFBQRuNvITACVNyxw/tF9YqzIEpXUF4IWsZIr8kn0n6qBe0nninj0Yfh4Z4/
         owxK0aHzLbF48WUPXLJ6H7+lvIgyCP21+JWRIHFBK4lddANf97qjcnL271McLoagvPVm
         bJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709605069; x=1710209869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf7ga+69rktGnQ6MLiBZYdtLAPO5MhkKVAzEKIflNBs=;
        b=Ir917vNcrTKnpwtik6TvAS1AvrhyIpFgoXA+zEaQyUZGFeCwsTL9liET0YWlxJPTC8
         rNcl6em/a8vTr3qaiWJ8FnqFTuQRMAfeHo5zMXDFx1hR29Qq1NeUf9Ql4ZW6EYM5kazM
         VyN9EEf9+XeoZ0b88/8vKYh6hAX7QTh4TbsHHnk4MErNYt+ygz/EHfBsxZVfIRngg9NH
         Gy96qP2Y9lVtsg8E0DNLhQ3O1goUGl8A6lp9VTqMtC4HOyH3QZsSGS/k44pJ8AQmUbvn
         s44MxiEu8N+un8vB29KTo+HVIjvZmr1yYPhIRzuXuroepXqWm7D+OqHAhmMakldw1R2m
         PTTg==
X-Forwarded-Encrypted: i=1; AJvYcCUjUT8hDiEWfbsequythCu/yiwPm/UsUP8CVGRjImOd1AvBD5hAqnxzgCoyL2IERdsfVFJ/oyVzjPK11PJtUBtJVlM3PxYq6LzjLeenR0yjx7OfZ4wD8aOMRbetyk/ymh1lt44n58jekC9BJA==
X-Gm-Message-State: AOJu0Yy29OyiepFo129dDVrMltmxHHNDoK7BdjS7UYUTCYZfkJGjJ99E
	8JQMsJiMa6QPEqsodmJjpzrGuzUZfl4E/8JOMMWMFfveJ5oEIA8rEGx2wim9
X-Google-Smtp-Source: AGHT+IGj91Tjm/MnkW5aSDTuzFIKSk2jQBVxLcoidGuaAUEyy+/l3qywApWVvfEwjCDRFw40NxhyAQ==
X-Received: by 2002:a17:903:120e:b0:1dc:ca74:7018 with SMTP id l14-20020a170903120e00b001dcca747018mr656911plh.36.1709605069283;
        Mon, 04 Mar 2024 18:17:49 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b001db717d2dbbsm9153781pll.210.2024.03.04.18.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 18:17:49 -0800 (PST)
Date: Tue, 5 Mar 2024 10:17:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
 syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>, syzkaller-bugs@googlegroups.com, LKML
 <linux-kernel@vger.kernel.org>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
Message-ID: <20240305101742.00000a0a.zbestahu@gmail.com>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
	<20240304035339.425857-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 11:53:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
> 
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
> 
> Thus, let's mark this condition as unsupported for now.
> 
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
> 
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..2ec9b2bb628d 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>  	u8 *kin;
>  
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize)
> +		return -EOPNOTSUPP;
>  	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>  		cur = bs - (rq->pageofs_out & (bs - 1));
>  		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;

Reviewed-by: Yue Hu <huyue2@coolpad.com>

