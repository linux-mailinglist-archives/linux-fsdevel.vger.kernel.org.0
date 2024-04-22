Return-Path: <linux-fsdevel+bounces-17408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303278AD078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6141F21AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E82152DFF;
	Mon, 22 Apr 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LlBIseLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29015250F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799219; cv=none; b=eyezGN9zFhvbjzeCkRkbYn/CV8R6O97tYb1ChjibzWxo5ZazRGKXvKRCdK91pQbFe/qtXIEgDIPr+lBflJRqQZEAohTlg6NVCiF18Nb9AXIR+FJ47RTcfZCBRCQxEpPkf+R5g6uPlQVVmzFfvOcyuO81J500EEAkNPUsQn4Axek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799219; c=relaxed/simple;
	bh=ceTlaihZkUB7r3BdzQ9PxIa5zGUfK1QACod8hUerT/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KShSIWRJGjunCw18Hu8HA1Y7H2IjgJlrA7bEAf5myRJHGfUK4lQDOuLxATMkWi5CAupfBd58Ogkl1qe3Z9T+6JRYlf7VB/sPtd6X6lOCe1hVrhI7pVS942G6pqz+/g3RRLelnv3u6vdcjA/KJt5o6vuhydR2jGjL+bpIo3kkh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LlBIseLJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51967f75729so5214250e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713799215; x=1714404015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ceTlaihZkUB7r3BdzQ9PxIa5zGUfK1QACod8hUerT/w=;
        b=LlBIseLJtsZo4mpMc08UeL1XqueRrX+t/OnsmKsswgl4hFy5tD2bLkbABpy5kcyWRo
         HalWFLofJK74/iogW7p5gXH2Ji2TrQfKxQ9rtFg9ttxuFKSCa6AkdosZYuAKN0E+hyEC
         p7z3xNGTzek0euAZNRZs1rlqQWLPQZgD4hzUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799215; x=1714404015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceTlaihZkUB7r3BdzQ9PxIa5zGUfK1QACod8hUerT/w=;
        b=WUmbW+k3IhH07WOqPTPMDDUBS/FwB3AIjI+54puyV79fX3BPAbfVHf4j1jueX3v8hM
         gUwXYym+H287vB2YjIVL5LqrW+Rvjz/QsT0cFHSfV04SSnVF3GHRerV5YTyoSuVRJ7IC
         47myg/4ZyZWGZuA/jtj5/3XCHrFiYpyVkOPM+M4BHT7XVr/cstd2RznvWdazQ5o06gDY
         o3077EwPSru5Gyk2gI0CAFrND7rmSweAAfmPA7dW5EfKM4BiZTT7x3P0k5GjUl3s6YLl
         eTxP3TV7IZT06gl8/zMzgBKJJ4XDcvE2IGBe/ffXDxPP96zAnDfjS8fhMV664OG57FL1
         4iaQ==
X-Gm-Message-State: AOJu0YxyqMg5HXvByEKD0Wxt6UdThIKtmb86Iq3U5tMYPuYjx49ZCkeh
	zDfj9G8JgEBbSDKyIwBcILahbsmQY0gGWN6TxkfN2Q/xUSLHkYM3fnr2Mc/tK1v2PI/yIVY0U42
	IN8f6n1NSbbqpA8Oks4Pdbu9IZZCER+SO0vbyng==
X-Google-Smtp-Source: AGHT+IHaZO2vak3JC4aAocWfqUIkNpwXSJhtu9quEUw0go2VnVP6IIq5HgcYyC3i6hfM9ZR/Z5p+JEoulFVliEwn46U=
X-Received: by 2002:a19:5f07:0:b0:51b:567e:7ea4 with SMTP id
 t7-20020a195f07000000b0051b567e7ea4mr1586365lfb.26.1713799215361; Mon, 22 Apr
 2024 08:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420025029.2166544-1-willy@infradead.org> <20240420025029.2166544-12-willy@infradead.org>
In-Reply-To: <20240420025029.2166544-12-willy@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 22 Apr 2024 17:20:03 +0200
Message-ID: <CAJfpeguAxKAHhDj+WxMQf5T_=2anZzodi+ripJy+ak8hD5Po8A@mail.gmail.com>
Subject: Re: [PATCH 11/30] fuse: Convert fuse_readpages_end() to use folio_end_read()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 04:50, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Nobody checks the error flag on fuse folios, so stop setting it.
> Optimise the (optional) setting of the uptodate flag and clearing
> of the lock flag by using folio_end_read().
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Applied, thanks.

Miklos

