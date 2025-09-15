Return-Path: <linux-fsdevel+bounces-61292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB3B5742F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A73E4E18F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE12ED174;
	Mon, 15 Sep 2025 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyC8Qm9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20B2ED159
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927531; cv=none; b=ssgcgskNuQJXUzLOei5g6SsN4JiT9zR85thdBXoDkI2NkQiUj8Fpc2IaRuRqzhwyVOu5iaTEeiWC8JpQ+rB2ou1SPqsuGWnJXqrHK1ZxiodXQZPhYJLTQu1+pta8bstaGdYfiNpX76iYo2r68asgf3GG6oIu/KXVm5XQIwBFEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927531; c=relaxed/simple;
	bh=YMyUO4ZSxSVOsCD3A/Ao02x8ck9F7ZcDeav94TcyBQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7JkydBgPzbRCQLxAf+BPsIJFTzIRbc5wetcSyCP4hjXWGMFNO8SKNdjeBH0e2w4LHm5JDCjpYcTAwC2JJCwmFcAF0WLxJpfATLZDJFAOLNzE24SqiDevHWDeWZJD2q24XlcUg0R46d3V/i4O1dYmXxj+tqiax2ORXw73AwruCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyC8Qm9t; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so2549031a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757927530; x=1758532330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z912WmA+67ALWSaIKEWQEm3fb/lfEWHjZZbHUaxsCYg=;
        b=HyC8Qm9tNP270pXki8zd3sjk8GmeiJx5fivPGSky/i4Vj5T8ZcS3qIa6w364xsGVvb
         9KHCrRMplCGsoL+J9PtwD8FmyfICubAqNeQ2azLbWSsen/Mx7sHPZO4FebC4hk18QkCG
         vq6Kn7nnEhdrXwU9eXHrdJhiwhuLofb/tF9HZM+8Pq1OiBvXN8MsvMHRbOBNI8e0dU/7
         oBS6ZDyNTJ14gqlGTl/W2FBLQgbBDzi9UzLjoFIjb1AXxwwws6klcfeAXYBK4nsnyufs
         JNNl7wrbe3WqmoR2r706u+k6tisI5qMNNwnnovD50vvjeObplqVB0zClP7YJ5euqyVMs
         3mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927530; x=1758532330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z912WmA+67ALWSaIKEWQEm3fb/lfEWHjZZbHUaxsCYg=;
        b=U6pRq/wFOL27mWlbVbW0U72Lbns2MZSXOPKJ1M93CjvKzQp9zYfsWdhPR85wKOYUF3
         gWXWyp2+NdiEmH3Y0fHqefewZbftpGw5AIX4S0yJI4BbAqusLC8HGBWO/1DEtuyhqtFd
         1Yui3HaYDXvfzF/vdZ6ywteYzhqC4E88I3VwR2JgJ0zIZ9y/v9sPyUW6agFiZFslA+rP
         w/I2MvMUhQ4KQtHHsQDNN5Mj+bZ/Q19zH0YSCGdK2bbMJS3ygnpOgdlEPdN4IVWuUrfR
         Y7yOny8vtVprhIT/5tl627KyW4TQmhHtSrbuHzgaIVNTHTSRHA+Do9v1mPsL4omCK4TH
         EWfA==
X-Forwarded-Encrypted: i=1; AJvYcCWKK+hvuHjicf5XcfkTASDPG5im9fWOfm43m7/LDeHKRJZcXTynnPOOW7LVgNwSDJfA2Yx1OmRzVZH3Sbdk@vger.kernel.org
X-Gm-Message-State: AOJu0YzelrEMXH6tss6oyn1l2fDZSqSJn1KAPs2LcIKLO22+bl43nUmj
	K3vYzVSnngRqBXBsPXV09WtTo/CDgu/uVozfEULIglfcyWS97Q15KWyE
X-Gm-Gg: ASbGncsy5hZCKfxkq/3vXFQ0faibc8f3A727lRXxIKRgEN7mrV/CUEQb/4GiPSD0Vc9
	Ol4HmUi8D01Z75trmTIwk4P3WAcrg+ONPAXpFUwGQ1ghiArChz5gHM8hTCFo/MXvN+92jOPaMTR
	GyntWLtuMzbMibZwyHaNPoFGRmR7jC3mXnh/WLczg6UWfuTzvC5JdU4GXabnlurmWqWVPNoBvEQ
	Iw6aACjy4gbtT5m2sOy8htmReRVfwrHiL5/9lBDZmIoaXhKTCCkeg52wcDS86R8Z4uQkSt470/y
	DtzIzI6ab5oWzuU+Ch6TuOPaaMBd/6TiTxqsZsYR1My79ZOyDVST3c5LZ6iydDXY7I5Mwwx4GLb
	ZZdz17Yt2ZWOJ/OduxRN8RD32DUgMAEV+mQ==
X-Google-Smtp-Source: AGHT+IHUHoRnBUAizNQ0Y7bS8vqoAmmxVHF9oFrvfp8wcyILr5tPIdrCluwCWQp30ooP5fOFV+uolA==
X-Received: by 2002:a17:90b:5110:b0:32e:4194:52a with SMTP id 98e67ed59e1d1-32e41940830mr4235639a91.9.1757927529654;
        Mon, 15 Sep 2025 02:12:09 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e0f101943sm6901264a91.1.2025.09.15.02.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:12:09 -0700 (PDT)
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
Subject: Re: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Mon, 15 Sep 2025 17:12:07 +0800
Message-ID: <20250915091207.4094376-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <eyyshgzsxupyen6ms3izkh45ydh3ekxycpk5p4dbets6mpyhch@q4db2ayr4g3r>
References: <eyyshgzsxupyen6ms3izkh45ydh3ekxycpk5p4dbets6mpyhch@q4db2ayr4g3r>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 10:54:00 +0200, kernel@pankajraghav.com wrote:
> On Sun, Sep 14, 2025 at 08:40:06PM +0800, Jinliang Zheng wrote:
> > On Sun, 14 Sep 2025 13:45:16 +0200, kernel@pankajraghav.com wrote:
> > > On Sat, Sep 14, 2025 at 11:37:15AM +0800, alexjlzheng@gmail.com wrote:
> > > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > > 
> > > > iomap_folio_state marks the uptodate state in units of block_size, so
> > > > it is better to check that pos and length are aligned with block_size.
> > > > 
> > > > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > > > ---
> > > >  fs/iomap/buffered-io.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index fd827398afd2..0c38333933c6 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> > > >  	unsigned first = poff >> block_bits;
> > > >  	unsigned last = (poff + plen - 1) >> block_bits;
> > > >  
> > > > +	WARN_ON(*pos & (block_size - 1));
> > > > +	WARN_ON(length & (block_size - 1));
> > > Any reason you chose WARN_ON instead of WARN_ON_ONCE?
> > 
> > I just think it's a fatal error that deserves attention every time
> > it's triggered.
> > 
> 
> Is this a general change or does your later changes depend on these on
> warning to work correctly?

No, there is no functional change.

I added it only because the correctness of iomap_adjust_read_range() depends on
it, so it's better to hightlight it now.

```
	/* move forward for each leading block marked uptodate */
	for (i = first; i <= last; i++) {
		if (!ifs_block_is_uptodate(ifs, i))
			break;
		*pos += block_size; <-------------------- if not aligned, ...
		poff += block_size;
		plen -= block_size;
		first++;
	}
```

> 
> > > 
> > > I don't see WARN_ON being used in iomap/buffered-io.c.
> > 
> > I'm not sure if there are any community guidelines for using these
> > two macros. If there are, please let me know and I'll be happy to
> > follow them as a guide.
> 
> We typically use WARN_ON_ONCE to prevent spamming.

If you think it's better, I will send a new version.

thanks,
Jinliang Zheng. :)

> 
> --
> Pankaj

