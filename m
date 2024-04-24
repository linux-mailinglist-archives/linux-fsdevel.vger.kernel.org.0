Return-Path: <linux-fsdevel+bounces-17683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170D38B1780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490161C214AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA316F27B;
	Wed, 24 Apr 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeyPt2Gv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537916D9DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002943; cv=none; b=hjBCxFUvciTRvuSlKPbMyE8IKgRikFlGFKIxRcyxSbDaV2uvl1eBnS+22pUIwCir5i8NzUR3MlgeT5Ixj4S81gmninnyFcBNGyTfWaHccrUx0ahKbEnvphaMYHsOWiAh21dl9RjrUxAJjWdmzqFUF38EfVXENQ6M55NJR3jmOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002943; c=relaxed/simple;
	bh=2/Hfa/dcWjkxZew9ys7tmCgP1thDGraOO4tncLETr3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdQred5xI1R/YG7FPxngS6R3BHOzzZOzustZscGhU3B3O+dv2DdoC+YjM+N3UxOVsPudEE1M9egCA4Lo+/0YP8dRgk0L8wlGefSDCvvoIF+PGyGbqnGmAb/oZcSLWq0FEZCZdCtZ3ui7SmGGR7jj00A1y9X3QIM75QYoiDtHd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WeyPt2Gv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23935d89261so252567fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002941; x=1714607741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk1vBtrkPJtfbNkGtrMy2gilqU9fSeCuVJ9F0az9iBg=;
        b=WeyPt2Gv565dYBLzpmykhuB92ZbEINflIqMiaqPhWirBf4MQjRHShLrIKCx+9FK9Ds
         ErBWdZPVsARWyBt1ROfTrzNWEyOLCk0qQmfa3YoQYLMZONgL6AfR7CpuIm9XczaMn9P9
         EpxeSIhGdAyiGbWH5m1Z6x6CKbXjYkDKlvLZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002941; x=1714607741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk1vBtrkPJtfbNkGtrMy2gilqU9fSeCuVJ9F0az9iBg=;
        b=D+FzGEoSIRIwUDT4aB3y8xeT5EB2an+0F8c7Pz6GN8NDaeanKae1byPJXV3y+T4fvK
         J+IUFSXSvf0w+A4uUxV4koSZ1TdTj0Vu7MrtTaAbMuFzX1h857SuaVC3/tO417eHCzUQ
         9bfArHnebYeB2OSrUWK3C1r/Y/d7aaST1mojQ8JqxE+LjAwbP4iVGMKsceHVGcs7wWcQ
         FO/CWEPaI/t+ButpEHOcoHaMVnwI6J3fiQupbxi4jMz031ItOzXXPKNQhb/1Hg+xvPEQ
         U541+UHBCiW4Ys1guo0UOvTg66CbJUvngb9O02M34+f8KIx0YwMpmk9JHCN9KBFwu4Ew
         M+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVsqEXXdm2AmeD7UliiXOQt0JZibUs79Xc3syPs7UNnB8cNvuiTWXYLXidWJ1xpx+PFbfKQdkp12lFYotjFz4OQPQz5ZbzhVkDY5Czsdw==
X-Gm-Message-State: AOJu0YwBKz7woSqvsiYjdiSEcbFbZspGkjoucNQ5YNJp+r/kBQ52BZHM
	WkssrzDRWRd+SWU+lqF/kmW7Lc0GA3aIDg+jUejnb3F/VWI8IxnGa2HPrGhLcA==
X-Google-Smtp-Source: AGHT+IG98QMINTQzk0343aGIq+ANc+btBeXk8kVIqd9NLh5j28mHEFdPtL+/Va4lYd4ERDEzyibkTg==
X-Received: by 2002:a05:6870:a686:b0:23b:1dd5:3df7 with SMTP id i6-20020a056870a68600b0023b1dd53df7mr2924743oam.47.1714002941396;
        Wed, 24 Apr 2024 16:55:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fx25-20020a056a00821900b006e6c88d7690sm11952827pfb.160.2024.04.24.16.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:55:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hfsplus: refactor copy_name to not use strncpy
Date: Wed, 24 Apr 2024 16:55:38 -0700
Message-Id: <171400293647.3284001.3215911382372065308.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
References: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Apr 2024 18:10:48 +0000, Justin Stitt wrote:
> strncpy() is deprecated with NUL-terminated destination strings [1].
> 
> The copy_name() method does a lot of manual buffer manipulation to
> eventually arrive with its desired string. If we don't know the
> namespace this attr has or belongs to we want to prepend "osx." to our
> final string. Following this, we're copying xattr_name and doing a
> bizarre manual NUL-byte assignment with a memset where n=1.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] hfsplus: refactor copy_name to not use strncpy
      https://git.kernel.org/kees/c/628a89b6ef79

Take care,

-- 
Kees Cook


