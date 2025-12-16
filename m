Return-Path: <linux-fsdevel+bounces-71375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6CCC0780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 02:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39D7D3003109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2127B353;
	Tue, 16 Dec 2025 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl7nPRlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FD155C97
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849076; cv=none; b=rJbE2E6h3vvaknEcvcz6fzdcXoL/cyKOuw7ZkvvgRJCgnFdT8B0MzJuUpXgNUngy9613csHwQglJgxmkMhN6jC2gqpSQn2rtuKD2e8JZB/9yezdTqafyEOaDYHU75nYKe6EQcSX/q/EPwntW1/kL0krdKRXk9iEVVM8iM2Xue1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849076; c=relaxed/simple;
	bh=jneufzrQq9U/X2h2rmo/2QoND+mJCZiav6Js47r/6OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6OS4j7idDD8dUBDlmCiP7rRq7DsF6D3wYB9sEsby7XpNbrIOh8Ieoekgoq19cdiPMVPthg7hfUdsRAnfBXn64FrOnRaFZxfDHGsNPcLmRrNp3yGSLxSSY/yt4AQLAGdh4GbKelpBJAoWFexaVLUoHcufdMRfel1iAtLWKyTUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl7nPRlX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso4329148b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 17:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765849075; x=1766453875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0FDBivIYW8TFHL3VKiPkgeHToq4CwEnpvCaDs7HwAE=;
        b=Gl7nPRlX5FRSyqolHTAUG6fRj3GnsUuARuEenBxn9CLzFjxiLIpqAbWFPN/KjbMTk0
         efuQlkePS9LcFV6ak/CSYmj2OMW10Fr2HxOIAxgKV2Dxpq6Bjk7fIFNksEyfkcbrpwIY
         Bma6FGXgh/BMmDwapkX0MPOL0uc3n4cDoFsZ9orJeWRBpxyg2HzaKD6EvuQ4+6u17hf5
         oHbYIxB3sClAyXML2zSE8ajHc6vBIjq8B80/A3EHE0ZuN17nWjYGFnzmLvlyWPcTIfW3
         87OzPMwkhBcZfW+/qxnOAgRazpsNenTBym9MRLpzgPKH+iERxDFlm/JvkDJb8UR/tUGr
         Sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849075; x=1766453875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0FDBivIYW8TFHL3VKiPkgeHToq4CwEnpvCaDs7HwAE=;
        b=WchJdMmAUFvqXASiTnZzvYXsK/PZGcOuk2xRIjjwy0CLRA6SqdGNoD2Hm9zcoX6clP
         hE/qrabvZXL2KME3Gc6k6MrmF+E9/1sb0Zz3bdGZRWM0ctecs7Wt8XUCk0cm1ziZNF/F
         4hDS+4kEHwzoCmekpcwy5gEbW/XlktRRvzflrD12gc1eagJMi+qjZ2fWQ29wT+FWfTLH
         usU3Hdb02Cn4cv3QvVZHMNJW9QBYIEHU9ggAZs4PJqohwPaJkdmL/qUctmoBykuWXwru
         89vugwFFaLxF2q70wm93MTa5mTILsPyPsvqdufHTJ6SPgkB0yUOonnL3htCXKnVqPnwK
         IlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv894/gvJkyPcUQ69tJdynnpp2e4dWi3/IEYzABVjJNBM0HsQ7og+7uHv68nwuVYmv+jJJ7I8IHMMRRm7K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0X1Su49QPoyAa6AN+N7KYdhkQ1hwLWUvBk/LjzyFRu8tb+oHD
	+gQheG1GD3IGUcRm6O7Q2YDw2MnDsD1ayB9hA1FeEQr+9j3Tck+4/ZtB
X-Gm-Gg: AY/fxX5Ta3zSmWCTwjDm8HgZfyEW5Rg/lPW++EA6024lO0hmIo6e4Cjs1WX2cmBlkiz
	dHMUJBcl6SuSSe3xsn5bxlf+5+zs6CPAtujsggPYDJo7cpuimqwDKS26o8MZ9Z9++ighkQJdDoG
	iQ32OPY2Np0b0bhcuG9Mugzq8hhJ9bdBhPHtubTOyRWASS2yVS9txdzYVmyTd8S5xcUwx6zfKIR
	/+u5or2w8ERwGqE27Sd+tmI/VQnjx2XFzuPH+92nqtKddt85ZQKTqXDUJGSWIGsv/S/LlUD7s9Z
	G87nzbTA3lbTI+mrEpZAvOs86AOuGJRif+iEheQWnqGWFBcV896h3aSv4YIv1YEa550WbS9WGeU
	mH7lcbkVuK57CzPYiZDA2bQI28bk58jwqPiPqMimmHWzIZ8tK4wSTweLnZ7xxIabtClXeVuraRU
	gDMno=
X-Google-Smtp-Source: AGHT+IGt3M1e5nD6KT/Tr73XIoi0zHyij2fPN6XhQLefORTEEkXDCvzAbax3QerzbjuxYRohNPHGbw==
X-Received: by 2002:a05:6a20:394b:b0:366:14ac:e200 with SMTP id adf61e73a8af0-369b708cd8dmr12251610637.62.1765849074655;
        Mon, 15 Dec 2025 17:37:54 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c26515d4bsm13325458a12.9.2025.12.15.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 17:37:54 -0800 (PST)
Date: Tue, 16 Dec 2025 09:37:51 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUC32PJZWFayGO-X@ndev>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUAZn1ituYtbCEdd@casper.infradead.org>

On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > constraints before taking the invalidate lock, allowing concurrent changes to
> > violate page cache invariants.
> > 
> > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > allocations respect the mapping constraints.
> 
> Why are the mapping folio size constraints being changed?  They're
> supposed to be set at inode instantiation and then never changed.

They can change after instantiation for block devices. In the syzbot repro:
  blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
  mapping_set_folio_min_order()

