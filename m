Return-Path: <linux-fsdevel+bounces-10917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50C84F3E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63E51F22FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED452E3E8;
	Fri,  9 Feb 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JazfIBl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173C2555F;
	Fri,  9 Feb 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476120; cv=none; b=U716MuVqk0gzaiXd5ZyV4QVi/g1WktJ45x4cBSMCgOTcEUe3Gr651Fp8MW0OAme9STCOiwxAYsVTceeLkC4QbN1ZlpbXNXqWdyN0hS3l3KSDPp13//4GtiS3vCOjVSUTwZiwAXtscqkFUMXBbZmlL/4jbU5guxkYbqUGNTRKjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476120; c=relaxed/simple;
	bh=2WOJQ2RgbU0u8rkQ+XtqSxX9y1ZGslQjMejF/3cwOaE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbZULDCNaD5hSYpA5w2Oh6e1l4KbhunXgQ5lGbFtYT9g5uZT9XgY2+m9yc1z+z+Tcvm/8s77Mszu/c6U0wCVe19NhQpOr//Ifud8Uv38jWrPDd3QpOFYj1YKhm5HYya6+MYQqn34AuMeF2lbMMlDlH8Q2U7Tf/su4fF+BRm0kf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JazfIBl5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3122b70439so93653466b.3;
        Fri, 09 Feb 2024 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707476116; x=1708080916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPDCxvBNMC7jVwM9lF/rwisiu2UQZms91Q9LKR4ZUe8=;
        b=JazfIBl5EyDW3RXD32Gpt0e6l2j3zan+NXP3o8m7yhdvAoMHdM1AOVQS7cIabd9m/n
         BcIxj1cxfn8UwEpfL/Rip1z9g+28lvpt7Ek56rn4FU+qvahny1xsaQWEbxPc6uXLlIju
         hWIVvfZztBqIKUZwZfLJSEQ6omdR4NizG/vv7HIzWhLrSF8b5CTYE8BM4p4KAT5dFLmz
         gFJCTc+8q824hfKZgIimeig5xLlySZbkcUpA42d8aJthqDjK0W5KjW1PP8VaWyCq99d0
         gw6UIhUAbMez+++NtRDTVs0Ebemg88nuQiaqPGP/uItAZpsp9LK+9VOSmPtSfXz4Apg2
         i+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476116; x=1708080916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPDCxvBNMC7jVwM9lF/rwisiu2UQZms91Q9LKR4ZUe8=;
        b=SByE3Foaexmd2Fj9qSQ3+OCWRf4xQScyArflWzCEHvf3YhJ8P6/Zg9wDYLzzYWB4GI
         5lf4jJutesV6IMHr/XKptksAe8o3ozD7y8cbfg+glDoeUF8+GbVXzBvsvPsvnyPUUSoy
         OXhYvDZQDBd/pYYLY+sKVd71KP3frMOJWImrUNCPK6XoBoYqa4P16YftK5UwYw3h3Sdq
         eJpctNeJAXr8KZ0+C/OFo8JZqtFT/xV8rFYylzkMl8BOPKf39+13gdJmbKRVb2NOSENS
         5ktBCSUaw0+2pc447JaBne/JQziUQ4fI/cDOj4dcddLdkXX72ZzmyUaFdsHaQ/sDyqrj
         muLg==
X-Forwarded-Encrypted: i=1; AJvYcCUOV+/5OgGkkg+IOlhZUGhqSbnqb+O/JonUK01nwSVkrScQxxl5HCJrGxCuuten1xwsfTRE/7cfvyzWJOlp32leAT7ISPAZDXTxObybouoKZRs0Yhr8JMTQSA4ULKO86b8tcDgdwcRsmB2T1elcE99aMTmI68jFtR22STagzFEqR+HijjQO/O7QjPJI4JsOBed+Kj29LAPU0e8iquJgNYirYtjnUDTTAtJBMANS1cBQYym2nmaGrcGGYQ6AVTB3S8vEoSkA//Lv+jX8xl/CRDROSQ6P7Z2buyusriyEcMTU
X-Gm-Message-State: AOJu0YxmAqvnPKO3N3nV+/7s0Wir1VfcEqOyIme6oFOY8bODgJJELVSP
	TZBymIuzHMTD90bOf5bFyBsKHKYi/z6dxUTEwq4y0kuXKFVJfxLg
X-Google-Smtp-Source: AGHT+IH8fQC4BYcatf4eNnFGSb58UqS4zJtebYfp5Tkvc0uum0cdKtMKpIELju2LqVMZ4Dh9GK/KUg==
X-Received: by 2002:a17:906:f9d1:b0:a35:103e:3614 with SMTP id lj17-20020a170906f9d100b00a35103e3614mr863231ejb.52.1707476115517;
        Fri, 09 Feb 2024 02:55:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0W2ig//yQ03IYUX8CzVxAEgCm8ndS3T1j4w20EZR4F7pSO46B0Ssj3CYd8S2QKwCcARm6ki3u9e+DBebFxzoEmI0oAbFUYYnNmQnIfRpW9iMLjJG04+63v/Bw70+28ySDWZpJTWzL6cI2ZNkUJZJBwsdxGXcv13Cex5FSXWQ/rA9VbY9FqqY9gqP3vr4cmM/C3FOjfKS8JqLEr7MLEXtAgcq9EhKu+atw3ez0PoqAKQG/JmJIV2N3c6/pHD4PEA5X2XFnqx8RZrsvXH+e/FBSspe0y9uDFUUpbR+LzWYkl9acy+GflcK9HZwzgdhL5XJATWhk/+YNWJSYJgI+XFcILFpe3zGY7mon1YpeqDQFNax5MEtzOpB5DFscrKJeiFJa/7oEMJeHdR8nIb74rJbhsoPHQM5vd0oKFnfn7QtJHpVf89dKVi8weQbjAgJ8g2mC1rBg2UiWropsPA72suo7mEQ2M8/tfdoGloKbAuI+XKt7MyeE0A4AUXuhmNfplAnS7k3f5b8skGR7wFI1yF/DOwTR9dk2x5l3vM5QHJJa/wXVNHmAM7ZtMSHzOAcf7sB/1Dk6rr6D6sBvSBih/Yi7A3mTIUvJfrTMeAH3bu+fBav/NdxOlr0OWM9Aut74GPCsiTwnDNmslfl6+GV9NyNqTeUeLd6jND27dWT/VhjfxwKpej42Iobb9GYk/l2DwagtHAj1C6DTy4Tyejx0ACCc3UnkebndWh0nS1SilTf6sRtD17hmcAGj6yEScljW6quvxOQyxq1rGybRxq+XfDHNKiGkrJcTfhs7AOxIFi8aJl3Fnj8/k/Q+dBj1ROIQhnjUeOw/Ex01Ynamfb6VACenMHuYjs2DjUiRQe5nrAPgYOyUOHlpV/SI9NViaJOezY/A87rwGJG3CngeT5OAMkMDIqpvq62KcNN+aLUv/t7qFkaBjYyzTSgLR+iN0DO+phbXFZ
 pZJknOwjoo5SfgsL5gCYFRu5BCGxsd7nqNZTS9Hzq/tcc4IS/I7MGp6eiH+iCXIfdGAUgh4wOUbiOFGVsT9Z4idnsbB4hg5CGFiXSz6dgATKIgfsFvnmH4aQsC8iOJY2gmUAl3aIcQoEvOGdClgxelpZRKICgoSZzGK6kDqTQ6vgChMcBthxj+Rdb0aQRz1GtwtU+RcgF48fqY/UxEv4oUdUktTlEpJvnVT+0OlR5hZMlrAkTb4orEqBQKit/397dC5qzNVOLhyViUGFZVmUj8RcXSSScjXz/1Qn6eg+H7iKlae2EqEcdkYUiIBH/c/9zREOdzHiAGPOLatjckrAsePGDqYRUI/w0KCpzynCVjY1wV3GpyCS/noMczEQKDj7rAfUyB7PzDOalH/Cd8ScBs3aHXlv9Eo6z+MLOLKzJwD/e02tmzYjM86xU4WeM23qznU1N3jw777w==
Received: from jernej-laptop.localnet (APN-123-244-98-gprs.simobil.net. [46.123.244.98])
        by smtp.gmail.com with ESMTPSA id cu7-20020a170906ba8700b00a37b795348fsm629101ejd.127.2024.02.09.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 02:55:14 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io,
 asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com,
 cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
 dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
 iommu@lists.linux.dev, jonathanh@nvidia.com, joro@8bytes.org,
 krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st,
 mhiramat@kernel.org, m.szyprowski@samsung.com, pasha.tatashin@soleen.com,
 paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
 samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
 thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
 vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com,
 rientjes@google.com, bagasdotme@gmail.com, mkoutny@suse.com,
 Pasha Tatashin <pasha.tatashin@soleen.com>
Subject:
 Re: [PATCH v4 07/10] iommu/sun50i: use page allocation function provided by
 iommu-pages.h
Date: Fri, 09 Feb 2024 11:55:09 +0100
Message-ID: <2718393.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240207174102.1486130-8-pasha.tatashin@soleen.com>
References:
 <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 07. februar 2024 ob 18:40:59 CET je Pasha Tatashin napisal(a):
> Convert iommu/sun50i-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



