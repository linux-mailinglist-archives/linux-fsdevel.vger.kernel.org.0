Return-Path: <linux-fsdevel+bounces-38131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B869FC778
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 02:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710571629D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9EC12B71;
	Thu, 26 Dec 2024 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QeDvDDDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F860360
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735177927; cv=none; b=XsM4hGV3YKZfFN8TTXkRre9OgNfOKeGtolv8SSdbMsuqr7aVPv9ntGZhX9iYCQVfut+06iKK7l0XJWy1L3Q9QMpoJNaWAHPk64Tp54S3bQ2BPPjCfH3Dp4KRRIko3XfXW1WfcL0VvSJpPN/5ePTT7GmJWwV9kfe/SFumoOnJfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735177927; c=relaxed/simple;
	bh=umNMczzwZV52oBQviKiaqNsvrepMY6ivd823r4zUMus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS2NaPavvDbOpzLaDOXFnLLJ3UtiOeG/tx5kwDUeD90QK2EHJJKS/RpYzMZiJSUpe+p+juDBNpVzMOS53E+tvCsn/xNRHD4di8ftUdd7ewNhmpmrPWwYH7XEbwyEu97yv4IgMPpi+1xA8obtOXJ1T5JgnPVqGqUNDhyfFvEfLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QeDvDDDe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21649a7bcdcso67973735ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 17:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735177926; x=1735782726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jf+PeOeTkzT/OfW1jqyfqfOpXWuWv4q8+IMy17DKA2Q=;
        b=QeDvDDDe9XgVueuYdRcRkwERMp5fdRVE/2KamtJKV/ucjAxPxmuvyFI4YU4RT4HBVS
         g8t8wzo/iOfsi41BmdrJUCfWGA3UZHwwxeD4dmHOlzecgtac91xk8LLqo2DU7cwP7s64
         TTdiL+FnRc8op4bMS3otaTTHXvqBR6/g2ZtEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735177926; x=1735782726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf+PeOeTkzT/OfW1jqyfqfOpXWuWv4q8+IMy17DKA2Q=;
        b=oqjm6RPOfXzkmFr9PrPdZoH3CXx4yFm3V5+8yuDuW1Wnxwvzb6Dul3Dpk483LJYr45
         RfRhNxzTBMl87RMyHadwOMcP8EldqZNqxe9AQGNlpXBFbMW9Q5NAu5KvXisXdPjkyv63
         X5pSVgAQofAB1d/ivXsFiwsmfd0g4kXvePhTmznwK1UQic8cNa6/RrZoj6z6f+niTxjD
         Bh0QJ5sBvfkUXfka4Tt9CJXKcvM/UnfSOGo+68T8jQrzxgqY3BOfokomYyLjbPRlClEh
         grDW511XuTWifT94OObsloy38uGYqzjfiwoKQnd27LlKUV7MAYaQN1kE8/L5HtEx6+Kn
         UI7g==
X-Forwarded-Encrypted: i=1; AJvYcCU6M6MFsE8/AKVs6cKnM/ziesaP1x0BOAB8YxSiuwLfx4LM+z0T2siwld52RxiQudbqi1jt25+9l/Wfq6mE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwq6ZJj1ThNikps+i8OpYIpnnHdQkrMdIZ0PNsbe8fu1D57dyY
	cACOBJFPRO7Ww7LY0ISFIVzy1TfdeEOAg0Wi1BXruJjSBz3GO55LYXfbxoWplQ==
X-Gm-Gg: ASbGncuKfDrldtZABumV9wUl1RvR+jyw8vtpCSLyJa++xn7gd4V3W3GO036xGFtcnYC
	JzHrrx2lpVfDzOVJzC6pkWoYjxX7JBzgdICQYEXDkTMSe+lTzZf/ZiwxgsyxWPZim16YVuFQw8c
	GDWGfzisyboJO8fiMEIOBrLAN1365lBmkvTLP8svmWXzHvat7ol6FRkuaUhXVzD9P4Yn9pLKEKs
	tI2v/pNeFjpM8ZNXcHOZOGkyenDX38odC+1in6G9oFlx8NjwNXYcVX54ms=
X-Google-Smtp-Source: AGHT+IGfpuDHAgY5GoLIKIpCEUcLfXn8AXt16TX/21nZrtlaEklLAmenbgnnYakQCmK2ZJveloapNg==
X-Received: by 2002:a17:902:ccc3:b0:216:325f:6f2b with SMTP id d9443c01a7336-219e6ea1a58mr296265935ad.21.1735177925638;
        Wed, 25 Dec 2024 17:52:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e8a3:a0d:e1e8:eb51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde50sm109518365ad.154.2024.12.25.17.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 17:52:05 -0800 (PST)
Date: Thu, 26 Dec 2024 10:52:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v11 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
Message-ID: <34myowizzazpp37cu6i46gp2bjs7pzcss4d7pgzukn4rmktfxr@zrx6auj3v6sl>
References: <20241218222630.99920-1-joannelkoong@gmail.com>
 <20241218222630.99920-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218222630.99920-3-joannelkoong@gmail.com>

On (24/12/18 14:26), Joanne Koong wrote:
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control how long (in seconds) a server can
> take to reply to a request. If the server does not reply by the timeout,
> then the connection will be aborted. The upper bound on these sysctl
> values is U32_MAX.
> 
> "default_request_timeout" sets the default timeout if no timeout is
> specified by the fuse server on mount. 0 (default) indicates no default
> timeout should be enforced. If the server did specify a timeout, then
> default_request_timeout will be ignored.
> 
> "max_request_timeout" sets the max amount of time the server may take to
> reply to a request. 0 (default) indicates no maximum timeout. If
> max_request_timeout is set and the fuse server attempts to set a
> timeout greater than max_request_timeout, the system will use
> max_request_timeout as the timeout. Similarly, if default_request_timeout
> is greater than max_request_timeout, the system will use
> max_request_timeout as the timeout. If the server does not request a
> timeout and default_request_timeout is set to 0 but max_request_timeout
> is set, then the timeout will be max_request_timeout.
> 
> Please note that these timeouts are not 100% precise. The request may
> take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max
> timeout due to how it's internally implemented.
> 
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout = 0
> 
> $ echo 4294967296 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> 
> $ echo 4294967295 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 4294967295
> 
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout = 4294967295
> 
> $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0
> 
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout = 0
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

