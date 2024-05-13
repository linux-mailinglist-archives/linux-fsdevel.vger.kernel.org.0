Return-Path: <linux-fsdevel+bounces-19394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C58C47CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98D41F22A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B37BB15;
	Mon, 13 May 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PamTSi9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B377107
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629631; cv=none; b=hym9yHEM3r0a/GSJ6Wm/w0X/QSGzDY4CUhqbbF3VM59Bd9gIqdvyd5nL+m9ny+Fp6dboNlzG0xoiD3MhcSmPrz0x1BrHEr6O3YfXcmDRn/dsx0Nonf8/Ffd0NdQBBpjBbVAQgnmfcsNndvQ8V8C0CAw5eQYdr2fjyM2pId8oxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629631; c=relaxed/simple;
	bh=16a3Epaq7g7pf8NaFIU+bskv2ICswFxu2+yqI8JIU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkFsNBIrqou8YXVba0uAWOQv0x1oBFALAK5Ulas5XYBS+7LIYPp9VIuhpe/AP4BtLEUuiMu3mD7ltDlriXBVCkprrURcVEf7VHdD+ZsADHHJAxuunR1si0hmbj4sIMh+y93ryMuXILdsG7PTeTW6ZdMGATEIZ1VyWajYK0vI1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PamTSi9I; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so3771217a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715629628; x=1716234428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfFfYpzZ9TkXj0n+fN7saznALYpPsNADwmH6bqocYac=;
        b=PamTSi9IUV3k9KyOzKbYhCQHoF3hzhyZAv9trDSgFgdBiht+S0densC7xGT4AHuJ9U
         UhubWxNZZPXKJEXOQ/LO46BAwMs/FAF8Voa2GVFfM6ZUhTJSyvlaa5qe0XNNSe42pmJS
         LcYCdEdfT7UglIT9mKVo7fDpL2wTDco/9PkBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629628; x=1716234428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfFfYpzZ9TkXj0n+fN7saznALYpPsNADwmH6bqocYac=;
        b=WuYOGeCVm5ivDfdUwv/rjd8WomaOdC0wP3mFdtXum7C0xKThqp7AW98J7uGYr/aVuM
         kfbzJeScmHxHA/5PokQwA0VUgLSPYzLlNG71WcGQhqLMhTN5mh+CC++Qbrl5rOrGpB3K
         RFt37+cph2PBoQGePL9gtIhMHcA3z+zpv/nOndZmdpOOw531aM6Mfn48CT80hOZKApFw
         D5UfGCnJIeTD0ttV289O9Lr/q98HsBgCReLbmnrWZl6epxWai1SsEY8nqF5xkMtSCdql
         X9oOFzlaGPUm7X8cPTinS7laomy9FUZarq9gHsP9R3hTKDa82XXr1i7+Rez5e5aQCX4p
         BxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+gruUZmT0rytNrXyNpDFC5y9OPyMcrYucJ3lFPqKbfP1xxViXuY/hqad3MVKg8HQEcB40luFFp4E0ZJaNnDBB2RxivJokMEsNuSVzRg==
X-Gm-Message-State: AOJu0YwKR5WIpfkNaBKdcNKY2GwAoZ5k5FXzRnosq0qMutPxuJAPhz6e
	y7lcqnjzviIpd1ar+M3fkqE8USFPoKNZE5b4Vw7jvboaB8L50u0B3L8GcWeqtw==
X-Google-Smtp-Source: AGHT+IHCYwJQrbP4JQr6MKsvJGpWLKJOfs8nmRXdxibnc6JRMVCbqPxPTY++ociMncHgytrf0PoIIw==
X-Received: by 2002:a05:6a20:7f81:b0:1a7:a3ee:5e4a with SMTP id adf61e73a8af0-1afde0e24e4mr11181425637.33.1715629628568;
        Mon, 13 May 2024 12:47:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0d77sm7765927b3a.106.2024.05.13.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:47:08 -0700 (PDT)
Date: Mon, 13 May 2024 12:47:07 -0700
From: Kees Cook <keescook@chromium.org>
To: j.granados@samsung.com
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: constify ctl_table arguments of utility function
Message-ID: <202405131246.C27D85E1@keescook>
References: <20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com>

On Mon, May 13, 2024 at 11:25:18AM +0200, Joel Granados via B4 Relay wrote:
> From: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> In a future commit the proc_handlers themselves will change to
> "const struct ctl_table". As a preparation for that adapt the internal
> helper.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Yup, looks good. At what point is this safe to apply to Linus's tree?
i.e. what prerequisite patches need to land before this?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

