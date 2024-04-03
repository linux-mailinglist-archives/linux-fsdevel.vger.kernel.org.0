Return-Path: <linux-fsdevel+bounces-16068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C8897874
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622961C269A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AA15530E;
	Wed,  3 Apr 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1jeE9a/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85920154C1E;
	Wed,  3 Apr 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169850; cv=none; b=RbsjXgiyY78fGEdH8HqZA9VNlCwCYW/vhI13b8iaIvzFJPwshZxCSsdjK7F6p04hfpUfLwhipykMCqQ0dU7l2jvigNtXjvoGXCVT3EIQXNUAYW4xLUvbiAQkIYFaNolU5y7k7KjreJoNm7L9Y8OfX9a975mbKNgJn9Zxg9hCcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169850; c=relaxed/simple;
	bh=8PLFsRmgUMVaPV9XeFtGvgecnZWY/q4zu+j9hx9D8F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2cOYmwaqGUGrU8Us/RRShEqewUo4IDPq+ClR9IGcttaBfA/txC5Ho3do6E+ijcmNFyq/RtRGiu2E73+xZ1I3LrchuuccOP9LBCsBJPjpFgvVGu5Ru3gwZ5b6cKh2OsWCDGUAyr6nUQUP7UxCmM+NRFKCYkj+b3iSLMdv3S2Jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1jeE9a/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dff837d674so1024475ad.3;
        Wed, 03 Apr 2024 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712169848; x=1712774648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jf9eXfLXAt+IGKQuRl9EXFMRCVVu/1d108EjkeA+hs4=;
        b=T1jeE9a/FyTgzqevXwMpfn+CxtI8Lu1yPRkIbeCEgMp8qDmwNXjK35OOGJfPnZcWwM
         Tp++HSRfGg9a5zRiOpCiqbAyGv6Z69WVNV9fnZmKF9hskiY/H8aRTymCq438p3nxD6yH
         ryVGVuNemrk4NVv9sVebWqEuZE69a42kVJS89XAVzALxH//YPuZy+80afYeO4bTDw17U
         ZFgyuvcJnM98TUH4iOQuM27WmsOrVV19qzxw8q9fEb0zEkQEa1eXpZRdOcK4P8Wsx5dP
         QR9ZewBjkw0CVWoDQrjUcEtbXxMVGsashWYjzQ2euKdwmmN2JMzuSmnGJgfifcqZ4K0r
         +Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712169848; x=1712774648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jf9eXfLXAt+IGKQuRl9EXFMRCVVu/1d108EjkeA+hs4=;
        b=sNzYqhmS4B8yfNTvmnp2b0x8PD/fjrldQ/ztrq+O2zs7OFrunJPMTL5stowf8l0KJ5
         GMQaYyS60ZABeq2t9cp6iAJLdB+Q/eDMlM07ZFr6adfNzZ/nEPmv445gGxyKcyKwJTiu
         r0DlYzwbV3w9KaPiH1FgpznRft2/hy7zOJCuvpVZfqRxFbzbMuNKo1W0kYeJUYjiiGSE
         WDw3CuUSUfuDmSgRQbCWpgQ3UWcjDaTBKxd1Ec5eaVhNuu133rVagGO3huYp+m4L21zG
         BeGqhZ8RkiHkq3AqzaP3UWfF+sIzgnr1ZjWGa6LPi/T/D9Qm0qiqLakv770xam6Q9zjB
         nB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVeXyxLrQ8b9STCEj41Vu2uJjVkLNFhldwYFS3BMC4cWFEjKUdPd7k+3MeyFM+f20YkbU09HFctBas/lHIVpNX6wxXRMf0wmaHPA3KXZVLdtAixq0Q2/3XE/+iGR6QF+8RIokbYWVJ/86Nbw==
X-Gm-Message-State: AOJu0YyTMRXF+3jnDdQ3us+FN79rvXGxYOlgYjFNkWuDTZE2mPdnZSSt
	9uQZwSGCsIRsXx4UTczvmGvyaEjRLhrtrOpBR74XFxUruYOFQwd4
X-Google-Smtp-Source: AGHT+IET2MjFnRKdYi6HBgH+aaU7huSyJHP87dr3oOrql+boFbieFudaHUxELwM26iLkibAbuGU5xQ==
X-Received: by 2002:a17:903:41cc:b0:1e2:8832:1d2c with SMTP id u12-20020a17090341cc00b001e288321d2cmr137835ple.27.1712169847742;
        Wed, 03 Apr 2024 11:44:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b001e261916778sm2392068pln.188.2024.04.03.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:44:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 08:44:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <Zg2jdcochRXNdDZX@slm.duckdns.org>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
 <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
 <20240403162716.icjbicvtbleiymjy@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403162716.icjbicvtbleiymjy@quack3>

Hello,

On Wed, Apr 03, 2024 at 06:27:16PM +0200, Jan Kara wrote:
> Yeah, BPF is great and I use it but to fill in some cases from practice,
> there are sysadmins refusing to install bcc or run your BPF scripts on
> their systems due to company regulations, their personal fear, or whatever.
> So debugging with what you can achieve from a shell is still the thing
> quite often.

Yeah, I mean, this happens with anything new. Tracing itself took quite a
while to be adopted widely. BPF, bcc, bpftrace are all still pretty new and
it's likely that the adoption line will keep shifting for quite a while.
Besides, even with all the new gizmos there definitely are cases where good
ol' cat interface makes sense.

So, if the static interface makes sense, we add it but we should keep in
mind that the trade-offs for adding such static infrastructure, especially
for the ones which aren't *widely* useful, are rather quickly shfiting in
the less favorable direction.

Thanks.

-- 
tejun

