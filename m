Return-Path: <linux-fsdevel+bounces-52738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60408AE61CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83F34A75BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C0F27FD50;
	Tue, 24 Jun 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mgS7pRNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68127F754
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759648; cv=none; b=od64jVE1ZiberW74gwXcseW+YZ/QHVT94Jsao9zMLxv3iCenwWuYNffYlfi/Mh8024JQanoYvXdyq5+QZsF8TheVgHnCRbX6i74l/Xknqg/72AiFDUFCZrzaLSxhWQ1Jb/x1n3D3DkGCklE7JRe7x5he3Ms2uqUf/Qgg17IsM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759648; c=relaxed/simple;
	bh=W+CM9mO/ETwaXyRHsX7BAiiGsjxFt5RQdi+vc9rW6+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe89n5GdGFV189FHJBmhiTPcm0U9VFzxQ2uxD/lE13zDcXUngQkeowW3VWo54tqOp12xbFh2eUFRKM13ArLs8T1x5cEnTFU2CwU6ihUibu4uGiEJJgokjJzEooF55Hi+BEZItNoW7LBaRQ6HAinQI+m0xp2s3HFPZNTeGJHFpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mgS7pRNq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58e0b26c4so92689141cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1750759645; x=1751364445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPlvv9Q47LZ5cAIWrnNCm2DnqvLNTn1tPrP8Q6vlz2s=;
        b=mgS7pRNquJ2v0kLWXLgvyQ/SgfO7VdRmdDoGq8nE4hQLGZ2UOWJkuxkKEV3639qjK9
         Fcqbru+vCgr4cNWKaxvAUEVvEbwgWo3OokOCnRko0QNdy40ZtA4EjxI3px2Cu6G1mWIy
         25h6D8HX433FJUiSD88ZGbAqcL9t+Chbc4/6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750759645; x=1751364445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPlvv9Q47LZ5cAIWrnNCm2DnqvLNTn1tPrP8Q6vlz2s=;
        b=AefABljXC4BsD56pzcM5YZiT/Qn6uy3F5A8oQPvaDzs/BACfExN9Gb8EPDVRL3r7iX
         tuVd1wwayItolBMxxYWP8N6VcE5gsdPZlRfY4PJzWswqrea0yShipVuxHq1BPOEpkqcg
         5RFfeRDmgoL92+BwRq9Qlj604dJ4ruSmsuV8TUqwalW64Ae917yMgi88W/7WryqE4DN/
         4fLGVQRC1fCnPEko814ezPSSUWtSXeriWt0hacAINvQnxoVHIx3w97M/hBh0DXIIzvP+
         yG2mGjFMvwTY+yMHfpeR6bKDBi8D66nCTuHHqYQqYw/l1vY1oui0cLYyjqZvBnKmkRze
         hFVg==
X-Gm-Message-State: AOJu0Yz0akZzKaUnccZnqJHcdMpAR1+eS6EHl/yGun0pXTIqJWxKaLea
	wfb3oQDhB8KFMfzH7v0ovFWqs8Mqcf96ImYjYsEmsMsiqqNqsFQ8bjTBefJgnv2oSUXpqf5tKy1
	w/kkUBkroZl5vzBMMOLrAvgZ485VaXbBv8/do8Zi0YA==
X-Gm-Gg: ASbGncvPpNf7iZzktmawuZPu3sE4Y3aPD2wFsSGBPFIK7EnQgL7arQrlEx9EJFLwop5
	HjO22o9+2qKIpiEMmJSF69qx/ZNa3laSxYzW9BKA/kzf2oLvQaMKxjkU8lc87Ak/igdqtvNGIZv
	os453y9n72IU5RleEp0WRqSE1EkG5Y5rLRhRUnnHUhXRcGdw4LuVGwFg==
X-Google-Smtp-Source: AGHT+IH0x0+iRHOWa2KqbV5wn8xPjJLoyNs9pTpMyvvOlaqhWqr33e0pXkymA/nSZQXBfDKBFVAgqMyY/CG6d2NNlt8=
X-Received: by 2002:a05:622a:1194:b0:4a4:3be3:6d69 with SMTP id
 d75a77b69052e-4a77a2cf554mr254409501cf.41.1750759645024; Tue, 24 Jun 2025
 03:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com> <20250624022135.832899-13-joannelkoong@gmail.com>
In-Reply-To: <20250624022135.832899-13-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Jun 2025 12:07:14 +0200
X-Gm-Features: AX0GCFu5oKUxjJA2CnW9KEBLReN6IYqX2gQbksH-7WeoCgZJDO5EaGGt1ih0KtE
Message-ID: <CAJfpegt-O3fm9y4=NGWJUqgDOxtTkDBfjPnbDjjLbeuFNhUsUg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, brauner@kernel.org, 
	djwong@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 04:23, Joanne Koong <joannelkoong@gmail.com> wrote:

>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>         struct file *file = iocb->ki_filp;
> @@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         struct inode *inode = mapping->host;
>         ssize_t err, count;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> +       bool writeback = false;
>
>         if (fc->writeback_cache) {
>                 /* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                                                 file_inode(file))) {
>                         goto writethrough;
>                 }
> -
> -               return generic_file_write_iter(iocb, from);
> +               writeback = true;

Doing this in the else branch makes the writethrough label (which is
wrong now) unnecessary.

Thanks,
Miklos

