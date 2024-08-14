Return-Path: <linux-fsdevel+bounces-25930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65675951F55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1881E1F2392D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D91B86E7;
	Wed, 14 Aug 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="S99vt2bA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F81B86D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651374; cv=none; b=XUfx7kCkhKJgLR5qm8xtY1+4SvvblZB4nyDmmc9xf5oOiOsaZH0/KQ0hYycK7WjObWq1BFZk+ajBAtnOVjr8smZfAeqvgJoVItBlJA5R1bsYp/k/82YXFhweWzb7vm3kWuZHiWNdojJVVZOoNq8wDUpzDRctZzGwM1Fpn7HlDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651374; c=relaxed/simple;
	bh=HbgQOO1pMh9zXn9zb9L6wLmMxEX4oUvgefQm6XRXhCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMr39PMn7ef6dWGk+IRSuMn17w744OGNcyMwTpZvm3j5X9Kaqf2z/92Lx/0Ad6hjkTkYB2ehP5umBqKcJXgbKIm9tw//UnuD61xl9QmVWYpFk+4Knvt5EsEGHTOxphbKHsku/JclnygV+esSHzUGlwlwhCCSYNqM9grj9LCE7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=S99vt2bA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1da7cafccso346104685a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723651371; x=1724256171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl9T1PS2AEmFiqovXXb+ctpjMbiWaIBX2G2Lgx03hk8=;
        b=S99vt2bAgGPuew0HV6gmPagiCet+s9iSJYapblJQHWedAG9u2M1JqupmR+1SJvOa5Z
         +xpfkFiAJcXqeNPGMVr4KzEzJrFvZznSFELrAcc5k4dFQQsKo2SaxQnTx/8SifuuHefb
         gXN+n97CGzJq/sDxQn6T8nQyHwL1KHeIyra9l6BsW1//0kU1vH3LoP30rHuVVIsDrmVa
         0FoTOANz8lyO0jnbrhce86O+lRHzCU5qoEnHXLRdPsy7PICDo1X2NOVU12o8dWZquY7f
         UZ5216tdREm0cvx0ndjTEtMYIHWHt3Auy7Z1KxuAtW5gOcJOjQJpluMRjJSJB43WRks4
         MWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651371; x=1724256171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl9T1PS2AEmFiqovXXb+ctpjMbiWaIBX2G2Lgx03hk8=;
        b=lfICCfuVUJnuqpU1XZNeDk2D1tKHKp99pnmoQV5BFLYpaj9eKC14CXMInsCYpGey6g
         9yGoXKye+XF69TS2dCeqbWKgovL5Z4xu/jctvjiWhWJdM54uWkZZj+DK/JI/v2vivXfy
         TO00h1+7OSICcTCYmy5FcTn/7Ob3QlSeqb3o0DCQi3vpHSBPtlW29lzfXyXLvHgiwrCF
         r/OgXw6GPMPWi01EjMI0el7+cENYlrHHOJJEH6F1tHKnyFAEw6hfwD6Bgh5Bm1MwLwNS
         bJFveM+aXDFlKPgVMUyzwQmVqW4/JjTqG+t3XwsSDxerqRff9DP/HAIgHnIUpLqxkJ2C
         J1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqauiywd+ZlnnzXgbf/lzlhgImB9OyMCelQbfIg0RG97JIl40m7Zxd6EOe8NkAbjKinMUmXWGk3F7qv0iJmYeVmexkUXyNm2+7Xum3mg==
X-Gm-Message-State: AOJu0YwqDHyfg6ZCxWRrvOvATuW8Lvl9exu9Tjpoy7zBhaDxA1DdNhgP
	Oi9loxsAtt7MmRmZPLXGLAH7tG7aY/AlUc12LJLvLt8FkvKhBAjlwJ3A5C637ow=
X-Google-Smtp-Source: AGHT+IEigntk7HKjxwRMkP5QGGQIwTVVfljj9y8TRxI8eB9OgmTcO4FQWjNrf+soernUVU/sBy42XA==
X-Received: by 2002:a05:620a:4587:b0:79f:d0f:2b1f with SMTP id af79cd13be357-7a4ee3f4995mr402715285a.61.1723651370624;
        Wed, 14 Aug 2024 09:02:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d79076sm450945385a.60.2024.08.14.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:02:50 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:02:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
Message-ID: <20240814160249.GA1053520@perftesting>
References: <20240812161839.1961311-1-bschubert@ddn.com>
 <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>

On Mon, Aug 12, 2024 at 06:37:49PM +0200, Bernd Schubert wrote:
> Sorry, I had sent out the wrong/old patch file - it doesn't have one change
> (handling of already aligned buffers). 
> Shall I sent v4? The correct version is below
> 
> ---
> 
> From: Bernd Schubert <bschubert@ddn.com>
> Date: Fri, 21 Jun 2024 11:51:23 +0200
> Subject: [PATCH v3] fuse: Allow page aligned writes
> 
> Write IOs should be page aligned as fuse server
> might need to copy data to another buffer otherwise in
> order to fulfill network or device storage requirements.
> 
> Simple reproducer is with libfuse, example/passthrough*
> and opening a file with O_DIRECT - without this change
> writing to that file failed with -EINVAL if the underlying
> file system was requiring alignment.
> 
> Required server side changes:
> Server needs to seek to the next page, without splice that is
> just page size buffer alignment, with splice another splice
> syscall is needed to seek over the unaligned area.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

This looks good,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks Bernd,

Josef

