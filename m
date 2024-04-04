Return-Path: <linux-fsdevel+bounces-16134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B3899000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786C51F25679
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A913BC3E;
	Thu,  4 Apr 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mO57yTp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834F13AA4C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265634; cv=none; b=hdu4hKST4fmd6Wb7Oc98T+ACrYKILUA7UjYByBWmjZbXs8pvlZvTwo7lVjx8ZPXQSr/tVudbEpDLsy2nvgJzK2hxTXSg4m6WQBb11GidN68Fydw2t0hD0XHAocKoWoYNLELA9hSr7sA6YU3VIo54uDaVk+b9oxEb18fwkz8yxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265634; c=relaxed/simple;
	bh=+g8FGEnBfIcvGrLKu/TZA6HVZV3dI9QDg/YewVouvCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZn0UrO73NsmE8X54NfPURKboKrNvikMAtanZhiFYTZTAgmK9RkYNdkFcfD/udKV+F38E9ZQeijxacM8Ko8urJkfN8bMjwYBlmyeV59q7IxtnCo6NeIfs58q79FcOS3uB+c/QuqGdvs7AlVjZkYD7TABgaTdCLVVOpyh7hcKqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mO57yTp9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf406551aso756328b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712265632; x=1712870432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Or6NstpRZDX+9Mk41p2/RZwAVxHZ+F1Exhs3xjDok=;
        b=mO57yTp9GjmD4EsEaEuv4lVtNm7PmUYsRtQoJzj74+TmoYx76aTWWLlJ0FUf4+SlrO
         eSKTi3gHtZNbgQd/96AG05AV8ir2jGtOPJPwCQS+GdTMcXD8TSdCo2vZAPnAnp/Nt4fi
         /uE246FcBYqwWyGriQ0qEncwvfFl4nqok9U2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265632; x=1712870432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Or6NstpRZDX+9Mk41p2/RZwAVxHZ+F1Exhs3xjDok=;
        b=UWB0wx0xrlvDcoYDe0HNzOtpqfCaiAfJO0hF56M0Mh5DfNQ+Xh4X/PBgecuD2+E8yt
         UEpNyFLD0hGpJoHZQOR3bDr1G0MkIo+FOV1GUDwwCfa18SKYPd8VKt42Tlgq7GaOqQ8l
         lkOPKPq9WBdQfDrPK+c4qnhNENQLYvcjHwUmLZuxckypxTdHvmVsBplQ6j/5kUB7nKPH
         RpXcJ/cKg/vV1ICsVqyQ0zgdtLMMVy13mkAYrCXPMiZz+tIVYlnknWzyJadS3KWUwjMc
         O5yVfIYG4/RlqdlpKdCEL4vUKPNeCbzHDnEcNAlh603aFOxoihk73QWjwbvPrs0OujWB
         09ig==
X-Forwarded-Encrypted: i=1; AJvYcCVTapOURO61yfHUt5bFG4BgXus5onx5H4yWNs7Q9waD7la6mq6SwlbQsNVKtzmmYFsfKekyBpL1hwJ8Ro3QsExlbILcHuJrK6ySR/10aQ==
X-Gm-Message-State: AOJu0Yz9o8hW/4djDxigX9ydthKZnZSRJDRzy9101ePTBA5xmBGz0JaA
	UmP6H7ObxWvSV05c0oKasCzZEFn0PuU3vQoY6o1dfRtKBmnGX+9sojffFypDkw==
X-Google-Smtp-Source: AGHT+IHM9ahEcWXLsBaMCLEHnLx24RdcbgqVAPA2u0PCEKRr8KtBpytL1lmSDOlyFf59XcyE6D7u2g==
X-Received: by 2002:a05:6a21:819b:b0:1a7:35b1:18af with SMTP id pd27-20020a056a21819b00b001a735b118afmr964578pzb.20.1712265632210;
        Thu, 04 Apr 2024 14:20:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e042dc5202sm79451plg.80.2024.04.04.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:20:31 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:20:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] vmcore: replace strncpy with strscpy_pad
Message-ID: <202404041420.E3C0933@keescook>
References: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>

On Mon, Apr 01, 2024 at 06:39:55PM +0000, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated [1].
> We should move towards safer and less ambiguous string interfaces.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we see that @name wants to be NUL-padded.
> 
> We're copying data->dump_name which is defined as:
> |	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> ... which shares the same size as vdd_hdr->dump_name. Let's make sure we
> NUL-pad this as well.
> 
> Use strscpy_pad() which NUL-terminates and NUL-pads its destination
> buffers. Specifically, use the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

