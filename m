Return-Path: <linux-fsdevel+bounces-2307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F07E49D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059A01F21A31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5662F37152;
	Tue,  7 Nov 2023 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLxwEucg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0CB37141
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 20:30:39 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62C10D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 12:30:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc53d0030fso640745ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699389039; x=1699993839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMKC+f3GuoNBGpjpvUIzL6NWxNO/+YBarjXdWe3vCGU=;
        b=GLxwEucgk24yIIVqxRiHq7gNCsO7wLNcBR8CwhFyGx0o0ZKVC0pCkPzRFUZ9wEP+JE
         HtU5BD8uw/g6Fd3H5ECSiZjBf/tCAit/1AFswZhJIhsudqWtU7hO1xt7r92ussc+wGSK
         vtcFo241znSfq6uomTd15OzKoXoSHowxIBJd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389039; x=1699993839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMKC+f3GuoNBGpjpvUIzL6NWxNO/+YBarjXdWe3vCGU=;
        b=F9Vg6WtxZGIq/xcNbI6s9N/JT0lzE1BXWbAkuS7P5DrsCkKds0u3P3XFePuEcqkKel
         X78o63BeGBwGa5o2cB5W8+QRIVEaFr2idWGET4hekcnyIN1PAXOavcP8VEzCph1fmJGK
         GMHqumLXaYzQzfY+4jApJJXBTcj65Hi2ag+03AU6iNv2llvu+kbqG9m8uzImxU6pLtzb
         zeBB7RoWixuhqTOtMYe4KzL1UeYJWP2f1VkE95zKjZO6yyGy1lc/JAkaiAtMvt4BM7XF
         LCwTOzYnGlRG/a3/o9GVhLH5Zbx/coeaFCmWLHVy5DlfHConAOgLWgkQaky5gL1zOwvS
         TizQ==
X-Gm-Message-State: AOJu0YzDMWkIVQQESrFsjZ+AnOghLd3U1/LYZprcyibTAAS+xttpwPq5
	rrXD4z2PE4nRvEJpSKj6/vmXiEtLazKxwjQoORKl5w==
X-Google-Smtp-Source: AGHT+IE+tNZ4JB+XVmT1foSgL0lugYRgOWvRkGk+9lpLcUqnOxA3uaZasFMQofi47dyLmcuOIes3PA==
X-Received: by 2002:a17:903:41c6:b0:1c9:9fa6:ce5b with SMTP id u6-20020a17090341c600b001c99fa6ce5bmr5127588ple.16.1699389038799;
        Tue, 07 Nov 2023 12:30:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001cc5225c220sm237006plr.15.2023.11.07.12.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:30:38 -0800 (PST)
Date: Tue, 7 Nov 2023 12:30:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311071228.27D22C00@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>

On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
> Currently, execve allocates an mm and parses argv and envp before
> checking if the path exists. However, the common case of a $PATH search
> may have several failed calls to exec before a single success. Do a
> filename lookup for the purposes of returning ENOENT before doing more
> expensive operations.
> 
> This does not create a TOCTTOU race, because this can only happen if the
> file didn't exist at some point during the exec call, and that point is
> permitted to be when we did our lookup.
> 
> To measure performance, I ran 2000 fork and execvpe calls with a
> seven-element PATH in which the file was found in the seventh directory
> (representative of the common case as /usr/bin is the seventh directory
> on my $PATH), as well as 2000 fork and execve calls with an absolute
> path to an existing binary. I recorded the minimum time for each, to
> eliminate noise from context switches and similar.
> 
> Without fast-path:
> fork/execvpe: 49876ns
> fork/execve:  32773ns
> 
> With fast-path:
> fork/execvpe: 36890ns
> fork/execve:  32069ns
> 
> The cost of the additional lookup seems to be in the noise for a
> successful exec, but it provides a 26% improvement for the path search
> case by speeding up the six failed execs.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

*thread necromancy*

I'll snag this patch after -rc1 is out. Based on the research we both
did in the rest of this thread, this original patch is a clear win.
Let's get it into linux-next and see if anything else falls out of it.

I did, however, scratch my head over the 0-day report:
https://lore.kernel.org/lkml/202209221401.90061e56-yujie.liu@intel.com/

But I can't see why this patch could trigger those problems...

Thanks!

-Kees

-- 
Kees Cook

