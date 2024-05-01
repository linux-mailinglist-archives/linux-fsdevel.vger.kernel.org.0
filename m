Return-Path: <linux-fsdevel+bounces-18439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251D8B8E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185A31F2345A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5913FF6;
	Wed,  1 May 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GahmNHb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66406748D;
	Wed,  1 May 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582442; cv=none; b=tYOHTEI7dT9vjgweILudDnd3dJ2zOKft8A7ZYtbGwgOXO3Q3qi2P1jBMFMwRTPE5WpDBTNrAZbHDcDl6t2WrWmykYb3YkbMsbmCSLT12BW3jDtyd4+1fPwfdSJHV5c7WJzQ4uauQ2bgfMXPzu1I2kYcyNj5J/debARtgDCKl5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582442; c=relaxed/simple;
	bh=VuoW465SoIJJfJ+GMdEFM5UyDdG/8rwusnIjOb+g5i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb1MQIzUqiUe49f1pttsmaOKcrgSKsO1bbrPONUh+2MX0xzqp7Mr9Bp5gWmXExU+r5l4c/Td43QZXW80mNGZcE0SL+dIGYRRHB5rVrl28mrEIKDrDx7gCT4JxDt/RxpyQFO1NUTpMnUCE0SBvWDX6j0SXrzYn9+fDci8oXbZWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GahmNHb2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4863714a12.1;
        Wed, 01 May 2024 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582441; x=1715187241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4sSZJgMC64F14VI7zM0bkJ8ca99Dh/OWoK4qMCqBqA=;
        b=GahmNHb2cmka3PGS4n67U719Wq7/3eerznkdLK5rXpdnav5aj9dxjsKJFu5dvP1dR9
         su5OUe5KR9R3+q2Gz0q/zlMoYrvJN1DtayPuLjf5CN4bdBmyxXUi4Tf15kmOJSE7WuGE
         g5MY7guIyLzTUmrQWRySIX5rTqoJ/1X7NDKetlBBYFS0R67GTXTzpQHDh/25cxiVKnoo
         CHR0pPhItPYUfK7gvvQl19ssVAEzj2yiPFk7wznoXsUU9GiTak5+L8DPRGhFmxcZUnxg
         K1jL3hX3Ddi9clApYGZDmNXCWg0blRwUEYucU7Dk1z6V5R8uh6COKaeYAueWTebBevhc
         Tljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582441; x=1715187241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4sSZJgMC64F14VI7zM0bkJ8ca99Dh/OWoK4qMCqBqA=;
        b=siqWdnP/5bHwxiMNbbKz0vjm9ur0JqQNXD4d5YlIlQTc2wWSeWan5S2W+W3E+y2RVn
         38V8DZm2/2re5xoMbxGano2N/CshqRCq51hElgLlXUpEsnMmzhWbZUnDxPGnJdd8fAQc
         f7D1fL9apIdAWI+c/FwzEOJrL9p2aMRDEMEH9Hioa9U7vccBh2EY93BTZLRLjAIH6knW
         vBC5gsHWuKyM6FtP1aO8OUVree6TTiipczfkvBpDXXBcoh7HN7roJsb3AaWBll9QAn/B
         PpokvqHsFRHu/RgF9mDc54kgm/kJP4Uka3gZlbD7Pg6D8vSJP9nhrSvCiMn5cGi0sbTV
         SviQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1FyeknO+1J2KIrAmQLHRG9g6pOniDvwly7+QI7ILsaSniwgkPyGVDu1DurSoSL+7vyFGsSQ9CPLkfie6WU1+WRRLTqIRo09ImbbNgfFYQX1/CREVjiZ9bQpGg6rW4skhgb/Rz3hqF1aK9DA==
X-Gm-Message-State: AOJu0YyMSmKrhT8/y7HnwH1l+c7KaFJNhjECJolUE6GD8/9C+qmnyYZy
	TWHnQHcVFnRWNv7QqwlSt54VIt+d1Fj/mp9yxO93KJAy9cAiJAZ3guHpIwLu
X-Google-Smtp-Source: AGHT+IHy+JR0gpC4382LCGOMMcLcSkDtgTD0zN4tdqwLVujuJfKwLxMf2TajU2cRh913b48Ogi0B9Q==
X-Received: by 2002:a17:90a:d251:b0:2b1:6686:dd7b with SMTP id o17-20020a17090ad25100b002b16686dd7bmr2935913pjw.33.1714582440578;
        Wed, 01 May 2024 09:54:00 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id sh11-20020a17090b524b00b002b29485fb6csm1597496pjb.0.2024.05.01.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:54:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 06:53:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] writeback: factor out domain_over_bg_thresh to
 remove repeated code
Message-ID: <ZjJzp8YDYSwq4X4-@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-4-shikemeng@huaweicloud.com>

On Mon, Apr 29, 2024 at 11:47:31AM +0800, Kemeng Shi wrote:
> Factor out domain_over_bg_thresh from wb_over_bg_thresh to remove
> repeated code.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

