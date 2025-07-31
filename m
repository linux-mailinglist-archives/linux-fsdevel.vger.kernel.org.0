Return-Path: <linux-fsdevel+bounces-56424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3479B17386
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953357B5138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B4D1C07C3;
	Thu, 31 Jul 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gppgaLp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3618E25;
	Thu, 31 Jul 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973804; cv=none; b=JvjA240aBvSPAHg3l4Qw27kWItBRyByu6wtswIWqMKgmBF3bVRzKGfFBRVxQ7z6nmTv4GZ2AsYyHqA46rFM0KzWA/Af2+80TnR4WsANMEHHn8Jrs59LgQb2eeHUsgyb57yyKTJMvonDaqeUbsSGYn+WvA+rZ5AsPXJPTAbdEasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973804; c=relaxed/simple;
	bh=ZKpxZxSNRlHY35S+g3dgBrJhvzpP5avecfPXzYNqnV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP/LP1c1nTnyaEqEOtK974kSnDhGh+sN3lKY3Rv0XKKIc4UFqmjqktPYDX/esCIgyX6Asi4rXkCJkR2Nik+3TtYzutp3pbH8GlH0lFbszN7t9ScuSA7Yt3aFhEYHsaB4CTt30aQ+9hUDHPOghdCNdx5IwKHVCPrUGwbubyTsugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gppgaLp1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so2336728a91.1;
        Thu, 31 Jul 2025 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753973802; x=1754578602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT7u1JXPLE2qapPN2e8db1o8m0B7NtOsnWruvD5C3H8=;
        b=gppgaLp12Z8Pt1U5TGGvyTaU0Vt3vHzhBNFM8tKPTCVvHAfOwA9eI0ikzw1Pi9sbN9
         NTxwWq6C2/DALit3LpfT47fdin0YteAw6w5aZCVS7c4aZn6QCsY/MF52fsNh287Y4MWT
         R5ERN3V+PAgvMzKOCzCGDb9YLwEz4uo7Y0zHL5kMcQ3+OoYR4yZOrgMgg9PDh0jaVPe9
         /wlksYNkeiohJf913onLSZ+yAcZG0wJGJQcOY1tsuAlg3u00mFa+AxcerPj9JhlY3yNx
         3XJ9IDs/Ms4cvzqlrPWQAN/V5H0V+Kgk9zuC9qfjtHLZUCuXcLDaxOaPIJyP5EOYCXaK
         lNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753973802; x=1754578602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT7u1JXPLE2qapPN2e8db1o8m0B7NtOsnWruvD5C3H8=;
        b=eqDwBvBSCoirErVlQy59eNMQvg30hf+ge3uSd5paolJ91pDXZyb0DUl80O6rlRNk/L
         zyQtrILd3nJxT+pM0yUH4WP7zrZB+LzFFsljDwau+OgjzNmsMk4ystV3z/JhAR04eMCR
         VpfLRvchFCytpo4XKWCwoETTvT6EirizD6nsmAjUbi9Zb54eg63/OMahoD65enrnKu0C
         XoYR+Qh1vQwjFoqxtrQ91tFQUf3KIUHXS5dU9XE2mQMTjSTtFgeOvNshQylto6DDej0w
         uXCiNmEKHwng8mV+MiBzgGqaaq9/MmVNEqg9z/MQwRDMCAaZM2PZJQqCJ8xffSCun4Ui
         8n1g==
X-Forwarded-Encrypted: i=1; AJvYcCVVrkjnzcxi+yko+EtbnSo9TLdYVlclXsIG7jlb+K3pAIaMqIX/0Kj8Tgl/Lv9MBS+NKidioZC3w6+N@vger.kernel.org, AJvYcCVqlUlu+qOtujCfhm4M9ZfOt1nQh+hsVwYvcTlEnOwgUD4pfXvATHKTKlJP/VXohxWLV6qz8TYRRn/JO0wr@vger.kernel.org, AJvYcCXPtBGLuEWc3Pw7XXIoafhMRxdpe9D3mRh0TXSfWMzK/GE+UpdtuYTXPOTzvKTJXn4tzVe9i/Hmtvd0BC+j@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcJ6exufen5tv1Uk9tM7c1KsptkSdvQQ6AqRDvDUCaM2DZsqA
	0Ld2Y67JK/7nUyFUgOHW409mPOe8OL0QFidLTJ0ftU5+S4oatsIMgvos
X-Gm-Gg: ASbGnctPtHGNzV3Is23sbsSXPs8bCAdCwoIK+zDUU1UCxniofFo9B4kxQ1lQdObtme4
	kVt4MwHWnhFFyvZu5AlSfrP5z+M7NoavgYNqFtRvmd74CCEK4tkWRdiqEkR+GIWLWw4hL0lbPip
	YwK+AI/HOQZVKYvu9l+gTXhq6nRR0+y/jpM9J1MiHUdpzcpYHRB7kcWAE/VEiTvQn6reiz2qdcn
	cwCiR+MJHBAyMig07kuBwohA4kUMJBjDDGsQx6bC+Y/1tiuHRal4wtKQWKbyq+9UhwcpF/rIRGZ
	z5JZ2UC/mqp2hz1PyXl6xC3QNyppWLTgWLp6sRvIHMD0WAQq7ctW+5ahCQBjj7aHD39iesm+ruq
	LRLS494+MPm4q8qrD6IlWapAtgsOlkjksPlA=
X-Google-Smtp-Source: AGHT+IFUmKjDbrxLRXJ1NDdjdx4q7IERNGjCOzdAFK1JFsMNeLaKS5QQhtOFSICBsTTo4HJkHkBf3w==
X-Received: by 2002:a17:90b:1806:b0:31f:4e9b:7c6a with SMTP id 98e67ed59e1d1-320da6152d1mr3280463a91.15.1753973802299;
        Thu, 31 Jul 2025 07:56:42 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebaefb1sm2257252a91.8.2025.07.31.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:56:41 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2] iomap: move prefaulting out of hot write path
Date: Thu, 31 Jul 2025 22:56:40 +0800
Message-ID: <20250731145640.651097-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aIt8BYa6Ti6SRh8C@infradead.org>
References: <aIt8BYa6Ti6SRh8C@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 07:21:57 -0700, Christoph Hellwig wrote:
> On Thu, Jul 32, 2025 at 12:44:09AM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > Prefaulting the write source buffer incurs an extra userspace access
> > in the common fast path. Make iomap_write_iter() consistent with
> > generic_perform_write(): only touch userspace an extra time when
> > copy_folio_from_iter_atomic() has failed to make progress.
> 
> This is probably a good thing to have, but I'm curous if you did see
> it making a different for workloads?

Yes, there is some improvement. However, I tested it only a few times,
so I can't rule out jitter.

However, from a design pattern perspective, this patch is a good thing
anyway.

> 
> > +		/*
> > +		 * Faults here on mmap()s can recurse into arbitrary
> > +		 * filesystem code. Lots of locks are held that can
> > +		 * deadlock. Use an atomic copy to avoid deadlocking
> > +		 * in page fault handling.
> 
> We can and should use all 80 characters in a line for comments.

I agree. hahaha :)

thanks,
Jinliang Zheng. :) :)

> 
> > +			/*
> > +			 * 'folio' is now unlocked and faults on it can be
> > +			 * handled. Ensure forward progress by trying to
> > +			 * fault it in now.
> > +			 */
> 
> Same here.
> 
> I really wish we could find a way to share the core write loop between
> at least iomap and generic_perform_write and maybe also the other copy
> and pasters.  But that's for another time..

