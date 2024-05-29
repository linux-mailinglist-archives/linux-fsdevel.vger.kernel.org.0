Return-Path: <linux-fsdevel+bounces-20488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9328D400E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317A61F23C73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA321C8FBB;
	Wed, 29 May 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="F/VqQU3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7C15CD77
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016988; cv=none; b=HWOrKb7uhbOVz3GGaaE2YWmU7u7Qs8aZiT1SbvNMw1ypO15AFXe3pWVyR/mpFIgW/VliflcIZm9bQuotHRViK3Fj9ttrEq9ZjIUhESuUa0UnQxeB1ayVfxVBFLfa5foDFbrBVg666xOMTlDuM9zH/LoieNtOMTbhYxzJwteRZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016988; c=relaxed/simple;
	bh=BwFRQB1IU49nLODXCDo4FzTZgyGXGhzcn3EiwT9Yul4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMJrJpEyO8BN6hgNnvrx9W7ebexTuB/1H0vZV+8c+jrIyY6sPVuGzXkZtnC5smZiyW2nd6xf9cuU3a6wGDNdyZE0oVPbA9cudskj4vRCNM7fMEUMlG5ZkeHzyT4NP18LN700tXtm7VLGGZ3cauC7ITtyoP5sfPkXjGcM6XTbbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=F/VqQU3q; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f8d2ec8652so143332a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717016986; x=1717621786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWq8w3qc/kXXTnLkQayM+DHDwqCB3WUN1BUOcsWdHqE=;
        b=F/VqQU3q4D0BeiHMnRo1uEzNdCj5dXwtR3MGdiIMOJic9VnGtbkmrd/boGrIB4/y1z
         xkVs+y3ZsF512m5vm/YvtEzQ03W2MQf7Mxd5IkwBu0ceLesndIjU6VPAxNhpIIfbselh
         1eG1PdOSjM23uO3ND9Vl92gyZREp0Xu+EVoHwWwOudRGx+5Qv7qCSPNZsH47b98v8pPY
         GYzs8r3u9HflmT04CndBUrMpngdhOf1t0qM50kbxAZTdJAQsUp3jWIrK6AxgItywJsqD
         CHr6y00YCiVfx4n+35+PNk+0um7gQ1gV2gdHC6ZZF5NjleBtLeFYz9BtdEptdKOxlxJv
         YJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717016986; x=1717621786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWq8w3qc/kXXTnLkQayM+DHDwqCB3WUN1BUOcsWdHqE=;
        b=lbKzDbIrb+sK53HDWzvekran9oVV1WJ7xEYXx626yrQTmnjWHZnOk4R3EGGN0x8iXx
         XwVsrQdMzs2Y3Rh8Hn5oUbCV8O395SwA52PvhKUCzWQmw22sIkp+mCfalHzcJaP2VesI
         fu35ObkpTRlLOIGHbHqfXu0KmQOOYJmpuJOIppJVm7LGBnV/pNhmjLFxnO5jcpuuWzTR
         qxRFFaLlunIwz2z51+suEgsbxubPIe+Wn4+YFEO6+s4XXAAvKYcJfbhKHZVkIYIRcaFZ
         2bZLHGbtsSFv0nGMlXqk3ks7OpHSe450qMk9oZG3nw//whzTEo0jQPiIy5BVubLYVaVf
         D0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4vWEn61wtjGEutIGAWcx1hViPGbKKUuSEF8Mgxrk3KDtvjw9pJyR9Wi3mWrqG+8eKOubRzafLaFxz2bskL+MhgbQubwFd8fxqpu4HQ==
X-Gm-Message-State: AOJu0YwIFlHh3B4ZRhe2V6FBxW0IZu0pEGFJzwHjLXIIYgJ3BOE32ycq
	8NoDCHvAAkjDBb5fmrNMx1vqwt+dRBuGjmiadzJE9rk+kI4qwPOKl8Afy1i7Xe6UOBFv/q//55A
	K
X-Google-Smtp-Source: AGHT+IH+uO6X0szNur8p2/FVnrWmQniuPdtewTRJQ2shHZQ3lxuq07DbPO+w2ojMtzoDjUXPj1otvg==
X-Received: by 2002:a05:6870:c18d:b0:250:14b8:4030 with SMTP id 586e51a60fabf-25060b6f823mr514044fac.20.1717016986486;
        Wed, 29 May 2024 14:09:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18b0e3bsm57699251cf.68.2024.05.29.14.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:09:46 -0700 (PDT)
Date: Wed, 29 May 2024 17:09:45 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 02/19] fuse: Move fuse_get_dev to header file
Message-ID: <20240529210945.GB2182086@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-2-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-2-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:37PM +0200, Bernd Schubert wrote:
> Another preparation patch, as this function will be needed by
> fuse/dev.c and fuse/dev_uring.c.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

