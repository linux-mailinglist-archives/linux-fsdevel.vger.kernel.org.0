Return-Path: <linux-fsdevel+bounces-13619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D989A8720FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96672282DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B186634;
	Tue,  5 Mar 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BZLlVgOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423885C6C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647144; cv=none; b=KSIiYmtbYhvjXcGzwUXqouGz2ZCvI/exMQjI75yHclfvhty9OMXYb/+szqDzJOxKlOmnzddpP6zen//euAa7HzG6nFWUY/uQlLyYBBKbXKZTQVdTUEDN8R1YDae6jtE1Hnus9vjR7H/U9B9r4cGt1IIiELYOcxWPqc7urSbc1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647144; c=relaxed/simple;
	bh=JRNihLQrU/+iEtpGvlfMV+4iDbB/4i030568B2Dcgm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mo2JVDdXOUJEcHpPY4tLNHSckLZVgMmlcc6kctvqRQ/8bHrGxNk1e2xz8iXaXQeRRpUC+gn0gMvQEBq1FzWOwSRTmcaAVFzVtMUPpSLSUIQJxYu4b5njXal+FXBH3NZ54i2T9Ge/DX2nHY6f9WqWBZao41GCWDCV0j+NlI0wmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BZLlVgOp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbff00beceso15245735ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709647142; x=1710251942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QU7i/GFGA3BeZcXyAk0JvlJF5wgpx4zGSLUMIo15nLE=;
        b=BZLlVgOpgg4M7yHZ/bAmieWGKzNEYJ/XR5FsYfsjqGCb4TPf1/oGKmJ/pYtSrZV9wi
         HbAxVkW5KNWUNrkFxwoRNSrHL5wOvgwBC1ubTKJfIasd6QyB/pqqEk6tCStaQ7d2gXnq
         ZvPVQd6IGvuA7u2OYLPd1PwpFjVbehh3Y364juyyfeyLtcYtWCP935s2qW/FM4xhFUnF
         tVL4IFJeT1+5Lp4v1vnWPb0aMYqnxpU/gRd6tXUX9UCAk/LvBQwG/Xp1uxOVp1nhk4Vt
         ayKYjLF6VYfnePUZsi2HrcP9cc5f1E4jSgP2tJcyl/n0K/0DLkRiNYcZy4oixwreVIiC
         ekpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647142; x=1710251942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QU7i/GFGA3BeZcXyAk0JvlJF5wgpx4zGSLUMIo15nLE=;
        b=BqqXyI/oQ6L5IOgeuRMuD00TJ9/GR4NEGg8EoOXWhAG0SVxLBulI7CRvMSDumNazzn
         OaW6hmOCz92VnEsYXfJIUSEjkdw8zahGgYP1SU0+RQCGPI6bdDUXAFsReh63/CDk5zkv
         rRtcqpRgy3FeUNNxmvlmnBLI3WB5TLD3Y+6G77z3bvrZIJFW9Yz9yUQPJzPKNhbr1Xzd
         ynueprL53HDqVJfkpVbeinNKtoySDx9cNMzUekgvqtHaIHaWHZlciqcKgJ8HG34MYIYz
         FHmrL30Fyab1xYwtdGHMQb6lN1XUgm3fU5CcN7l0eX2T3KssjI2MVgq4ZNN+WbCAEju7
         nz5w==
X-Gm-Message-State: AOJu0YzRoFoks2DtUBmFEBSuOlTrRWojq5tTMyeRNTzgWIVv5dfdHPbj
	LwT341HJmTVoHjpTFJU63P2PVWtUjvYDiR2AsomeP/lkECZn/71AXFssJEVc5/0=
X-Google-Smtp-Source: AGHT+IF+Cyeo2mWoylUN+f5sX3aHqZjl0czKC66QZp6hGbPe4oQB/7UWKaqNwH8HfMckY+LPhaXuhw==
X-Received: by 2002:a17:903:41cf:b0:1db:ce31:96b1 with SMTP id u15-20020a17090341cf00b001dbce3196b1mr478555ple.6.1709647142261;
        Tue, 05 Mar 2024 05:59:02 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170902fac400b001db5b39635dsm10625132plb.277.2024.03.05.05.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:59:01 -0800 (PST)
Message-ID: <dc4933d0-f865-4da6-90b1-320daf2e4294@kernel.dk>
Date: Tue, 5 Mar 2024 06:58:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump: get machine check errors early rather than
 during iov_iter
Content-Language: en-US
To: Tong Tiangen <tongtiangen@huawei.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Al Viro <viro@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
References: <20240305133336.3804360-1-tongtiangen@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240305133336.3804360-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 6:33 AM, Tong Tiangen wrote:
> The commit f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
> leads to deadloop in generic_perform_write()[1], due to return value of
> copy_page_from_iter_atomic() changed from non-zero value to zero.
> 
> The code logic of the I/O performance-critical path of the iov_iter is
> mixed with machine check[2], actually, there's no need to complicate it,
> a more appropriate method is to get the error as early as possible in
> the coredump process instead of during the I/O process. In addition,
> the iov_iter performance-critical path can have clean logic.

Looks good to me, and I'm a big fan of getting rid of the copy_mc bits
on the generic iov iterator side:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


