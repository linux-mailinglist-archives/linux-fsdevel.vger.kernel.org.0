Return-Path: <linux-fsdevel+bounces-2332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D27E4C08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9191C20C9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09930653;
	Tue,  7 Nov 2023 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cn0xkmTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302730645
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 22:50:04 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E311D
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 14:50:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so6469769b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699397403; x=1700002203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+vhIz7LwiojaeUjPwh9VacelWUXCMWwhB6gmZPNvcI=;
        b=cn0xkmTVJVoK0y2t8vNBoRqFLFEjjpAFhRExyuLliqkqN6G13Jy0Ds3Fd1tBLfY0k2
         kqaw6nCua9OaQYMAcF5/ve6DwEzr3Iv5SOrWQCl/5lnfwoPJVaJzu4BaOY/+LB+NjX4J
         e8zOO627E4BLk45ihcbi6KiUktJQsDgYcNLMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699397403; x=1700002203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+vhIz7LwiojaeUjPwh9VacelWUXCMWwhB6gmZPNvcI=;
        b=Gh60yzcrvy+aRcSaHLxx+jWZqliejhG0Qs7CgloZ+s7IQ+AV1sjpQYqA0KYwV/4sUv
         u1i7W00SW6ydDnGCTJG25az3E1m2MB2Kxr1VOT+v6WDlp6b4xWuRiAqWxjqHLxqC932d
         c6O27aF7brde1u3Lffqya5amJ4NnpBvhuVWlRZ7dZ1MHNtAX2fBjbcWxRgpjjf+1gZRI
         5zjvONvoMYOAwUj2OlKXOVJsImvHJIu66YAjT1itM5DohtsofrTj+cPV29B/QHP5cZiF
         kgyyzlhG/CM22w345eyforbynTUcZoIGW4SBpkqTlkNYVD2E+lgo2uNlqFCUESaPsFUe
         JjlQ==
X-Gm-Message-State: AOJu0YyAdQqsYQWamMvFP730f7gdkTIGbshuY9d+Yy23QAtLeRHXRGo6
	Voba/Q7eDANEPGR1auS/0vuuDA==
X-Google-Smtp-Source: AGHT+IH1d5SgbcL7itiPSWGAZKEFAhSQqcwo0xaVEpMRSh8OO+9Cff/xp9eUmO+GeaQGXC48IEgL7g==
X-Received: by 2002:a05:6a20:3ca4:b0:140:f6c4:aa71 with SMTP id b36-20020a056a203ca400b00140f6c4aa71mr434754pzj.8.1699397403202;
        Tue, 07 Nov 2023 14:50:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001cc52b58df6sm322717plb.215.2023.11.07.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 14:50:02 -0800 (PST)
Date: Tue, 7 Nov 2023 14:50:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311071445.53E5D72C@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook>
 <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>

On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
> If the patch which dodges second lookup still somehow appears slower a
> flamegraph or other profile would be nice. I can volunteer to take a
> look at what's going on provided above measurements will be done and
> show funkyness.

When I looked at this last, it seemed like all the work done in
do_filp_open() (my patch, which moved the lookup earlier) was heavier
than the duplicate filename_lookup().

What I didn't test was moving the sched_exec() before the mm creation,
which Peter confirmed shouldn't be a problem, but I think that might be
only a tiny benefit, if at all.

If you can do some comparisons, that would be great; it always takes me
a fair bit of time to get set up for flame graph generation, etc. :)

-Kees

-- 
Kees Cook

