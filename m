Return-Path: <linux-fsdevel+bounces-35585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C09D60B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72932816B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97399146A69;
	Fri, 22 Nov 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GLwjg5sx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559114A4C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286720; cv=none; b=hcRk+kat1XdpReMhlQzaBWGt8vaHla+gbBW88wwXmZzFA4GFldvmv24V7EZODmz4zh/zOTz4vXcE7/+6tNQsITkcxO3hu4tzZyi8Cv/BPByfvFBBGqeJWxGlfupoRBt5rS0CzH5JkgZYUw4jtoj7YDVZnS0+J3ZGkkSEqn/ZxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286720; c=relaxed/simple;
	bh=3pl2ymZn+Sbk7oav7jsDM/MVhI2VmtFL/ceDJdBSi44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kixQhVdp+1jy4Le+vnRPiBSl6AtLS4kcFX1eDVzldLRs3nmNA5TB5NvlN7/6mQhM/AN/5qtU7V8t3xi8vFLXtRnS1T3ZSnUp05UXOYOcdBslARJuoS7PNm84SDTrCHWj4ohCJf9+i1KKD+sCJTMpd9gsTdemRbhxa6VBkPLpvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GLwjg5sx; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d3e9e854b8so29234506d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732286716; x=1732891516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICFtDGh2+tlgA7t1KCCdCgn8adZrTygd2lTX86CZiqs=;
        b=GLwjg5sxZxDbIC2YKs5FEuXDcaMS/z5LMh/ZHQ63/BJHh3S2xIuwtOJY1YvHI0Fi19
         hvg4ZQSqXky3+J7JRlJR+VrUvnps7l3lP5yKzN1g0vqRNlLTKh9qCkRAmwNXwVocydW+
         lsR8nIFdOwaJr9GOcEJ9si9/wXniZCEq5re7Hpt5M0dK9qMhQNBy2p16yPlP43PBkqlu
         tl62Pg8sH56fhDe+8ozcP8ryiBs0Kj4QcNS/YpWuURfhFE8CuBRcI31nLPTU1M6cje0L
         E1PyOG6qn/NGWkBZOIA55Z/Pv/wslMB9Iv9xYfFjP5+x+BCg2cm/lZzA7q86t+A3ML1F
         L+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286716; x=1732891516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICFtDGh2+tlgA7t1KCCdCgn8adZrTygd2lTX86CZiqs=;
        b=RXI6XZdR/Ljgg0NTggTceMiBp1wrIyYIWv1ox/hzGguihPqjUeDRqrBBRe/BRZNCQ/
         o6AThdv9CDL/zANqGK9p8SpbEVfhynQ7e7F471kX+JhmqZJCMG9VSel6/RYti27+avGR
         QqaTZr1b9uLhhr/iaY61upT7S5ekAUUtCmOg317Ga7MyOVZCcfTwzt+Xyq6VO+KQKo5q
         w9eSfVREhaK24+AKL5ycKULZi8+nh4ngW5mzNz5yOg6ZeR+2bKwryCmH5gT668c9QQE1
         jg4xuYIYzdnCPhXvbAAPJT+UtZn9ZCOgyyNaT2oSDIUte9uAlWRdg2mtekRHsx+giRrU
         mUKw==
X-Forwarded-Encrypted: i=1; AJvYcCWpCT4IhIYefLxSTTJbKVhTLHoRpCb6PGfaLsSERclz2dr5ZLUeKHrxxGg/1PO1otTiy5+QljcHCANY/8bz@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSRku6ABNiE72aEQaRUI3khNoYKFhXk2k3KbIukv32r3PaI6U
	Rs3SvbRv0cRdY6eAoTGOiBioq4zYXfo+cCiwsswz3SohO0mTrxgqvFqA7zZPZz0=
X-Gm-Gg: ASbGncv5n4foqsCmGjvd5FJpCGaC0zJ6K/X2q8HrTB+AkxVIG1SdexdmBQT9Z2/AP9+
	EUD6JrMkw8J+a9iG+X2NgLKtH6ShuBnscpKpinF7sSpQ5DlXPWdK7U+5PJmlWrhzoN+L1wwo0dK
	Pk9/BqojnG2UFFyDxmhmFh7+nMylGcLHzmgIX7QsWU4svSdQKAQV27fUX36QR03lIQ9XCyVZ1XG
	mEEmKfK/NvfPVBsTgFBEReMXH/3avqv8K89RqaB4jo77sGl4l0SkGSHxeKUA64tkwTCR4+WGQBQ
	FYCg9LmsrJE=
X-Google-Smtp-Source: AGHT+IHAx+lc8FI8qlW/BpuWHIsCDbiVbMLz+I8xuXNYJO3hZ8AT5YbgedM8Xk2XqcQrqYN8ECj/zg==
X-Received: by 2002:ad4:574d:0:b0:6d4:23c5:6adc with SMTP id 6a1803df08f44-6d4422480b8mr130932316d6.0.1732286715586;
        Fri, 22 Nov 2024 06:45:15 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23e83sm10450466d6.87.2024.11.22.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:45:14 -0800 (PST)
Date: Fri, 22 Nov 2024 09:45:13 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 07/12] fuse: support large folios for stores
Message-ID: <20241122144513.GC2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-8-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:53PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for stores.
> Also change variable naming from "this_num" to "nr_bytes".
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

