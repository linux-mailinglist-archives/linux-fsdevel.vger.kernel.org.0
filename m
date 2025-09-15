Return-Path: <linux-fsdevel+bounces-61311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F5B577BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A5E3AF170
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40E2FDC51;
	Mon, 15 Sep 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP7plFNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B32FAC1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934752; cv=none; b=Xe2z6Zm8+3pXrT475WyltJjicbjGl0+gvm1w2V8ZTyt1lnaenC+vg58ktJVkrXmfT570ejo8wrBhoNpGNjVh6Hkcc27I0fon+NcqYkLKRJT4OWqI/FT90M5vOVGirPr1isXWFAu2PElVcoopeLqFkoq0p9fAlRs6oisWnjwlA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934752; c=relaxed/simple;
	bh=VY3zkdhTGgC126uMIeS5gV6qogT1HLoj1i2dxU+5eik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvxt880JK8kPWliR0+6mhG3jErYNszW6qaFYAAAmmEFEYKT6OpapJiHOudYYlrrK7rzxk/sBVP0dyW0ELuCS3afmF8XVXNc2LJut5Z6IyQUG2PCqt0cV/G0eg7XwvEdDP+hFF20YSFJckYyBH3UIuQmNhvjaDrnJ6v04O6iWqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP7plFNw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445826fd9dso47609985ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757934750; x=1758539550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p12IzWrRO+GuzSOQKOoYoCmZLULC1GsuqYzZhikEms=;
        b=JP7plFNwh89sv86Cw8BHKTbfdRv709peLp0C+HGfWw1C2dzLaKCdUtqGhpBwHl071U
         0Kj3hH81bMd77qHnpLyC9pjnHFeEqivHqmU/CkdNLHSobUk7wTzPe/DbP2r/lumuxo9F
         3GzQcZz9xAnb8wL8E/RzUCoGGTb97dqWX8k61itKUMPIctsIFT53Xi6kkXruqA7tcXAN
         SXhEeVbX72Yw700IdW+2feK0Net0oN6LBOgFabC747IRusGp5O542r0GzgGOp1d7O/7L
         /wYy/HWGu81w9vCkaz/Z01PvBmixkjtWhaDTDqp4IDIJ1ded4CWth9GmKT1BpIVB8IoG
         b2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934750; x=1758539550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p12IzWrRO+GuzSOQKOoYoCmZLULC1GsuqYzZhikEms=;
        b=wS76yFr25HcXBhXEtY4IMElsvIKFBvK8D+ZDOO+0SDYPNW7uTZ6sl1cNXA/TNYisqd
         xaiO6LGTjaYFP12OK5/lyZmffQ0xBGx2ROwbIWJzWxR+pfwTjFSicD59n+svw7LE7XS7
         cnRscaeKpQeRxWxLql8KzOApd6urorGRqRSJyKyYBePXUBFAQGqih2gzrx+Ec346J6BM
         aj/ho9KuJ41TTrkFCDjYRwDHBw9XqhbBFrBUitCCXT9MvqXLetfZxVAn5wI6awMLYS7d
         nwv0gMklIW0mTiQ4cUPr+W4Yxdvr1ba8HDDfaeCcF8MT8MzMuVxAxsfEuMVaRk3j6fyK
         35/g==
X-Forwarded-Encrypted: i=1; AJvYcCX0RZVXKPsUDT1qZT4iIKmPET7FYFvHdp1xfNaaCukUy3/p4ivoGD1ahC+GHU4tKfpzJ/e3mc1hCZsdwQfR@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKySJYVOC8YdPH535eHN/fZFV04kHdpbOF9zqGzxBrmN8+Blm
	dS4N3okUm3DJfYkXGJPuZ5nghL6LCz4vmvHM+pHTc3ntJHNq0vXog2tU
X-Gm-Gg: ASbGncuPakWzqyiII3vEbJ9eWUJoJuM0+IAmbcR0wEEiYhs/NVO4YmORs9ptUogBxw9
	oCD22fHijzXw3mMXlzOiYHAkul9sF1yG6M2tpt7EcT9EfNl7J1mcnAyrcKjqCYzyL7ddqSJrnnP
	zlakTQbZKsK9d2ti2yRD3h6GRoAU+2k7U+MMkIqwC4SDnJdYvbhe6SbWoEYR4/wKpUFeLJs/uEf
	pHOVu6zBpz1P0ZwSnikRyzRckfi9kDHHcTOcrHckWUjCMLBCAZ/hhptwRoPvzxJ2rGkRGQWSudz
	Ef9nYYeukLY4essSWYrm+eXsfADmNaZ2BdPJviCnIKxBn5pDQI9KtiBYYOg6txWf8JWI8Tuqk2y
	l6LtTWJzs3J2wlklQVqFeTwF38JNk6zGHfg==
X-Google-Smtp-Source: AGHT+IExDJoPLFyVEh3wqMlZXAiX0+tZkyl11B1SwSybUi3y+vj4NaoaTvhTCkhJAG90Odm2ARIFaQ==
X-Received: by 2002:a17:903:1746:b0:264:70da:7a3b with SMTP id d9443c01a7336-26470da7d17mr63606755ad.49.1757934749994;
        Mon, 15 Sep 2025 04:12:29 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264ab88689fsm41411705ad.27.2025.09.15.04.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:12:29 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: kernel@pankajraghav.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 4/4] iomap: don't abandon the whole copy when we have iomap_folio_state
Date: Mon, 15 Sep 2025 19:12:28 +0800
Message-ID: <20250915111228.4142222-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <dhjvmhfpmyf5ncbutlev6mmtgxatnuorfiv7i4q55wpzl7jrvn@asxbr2hv3xfv>
References: <dhjvmhfpmyf5ncbutlev6mmtgxatnuorfiv7i4q55wpzl7jrvn@asxbr2hv3xfv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 12:50:54 +0200, kernel@pankajraghav.com wrote:
> > +static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
> > +		size_t copied, struct folio *folio)
> > +{
> > +	struct iomap_folio_state *ifs = folio->private;
> > +	unsigned block_size, last_blk, last_blk_bytes;
> > +
> > +	if (!ifs || !copied)
> > +		return 0;
> > +
> > +	block_size = 1 << inode->i_blkbits;
> > +	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
> > +	last_blk_bytes = (pos + copied) & (block_size - 1);
> > +
> > +	if (!ifs_block_is_uptodate(ifs, last_blk))
> > +		copied -= min(copied, last_blk_bytes);
> 
> If pos is aligned to block_size, is there a scenario where 
> copied < last_blk_bytes?

I believe there is no other scenario. The min() here is specifically to handle cases where
pos is not aligned to block_size. But please note that the pos here is unrelated to the pos
in iomap_adjust_read_range().

thanks,
Jinliang Zheng. :)

> 
> Trying to understand why you are using a min() here.
> --
> Pankaj

