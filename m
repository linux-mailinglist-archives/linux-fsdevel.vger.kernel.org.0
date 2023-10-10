Return-Path: <linux-fsdevel+bounces-8-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C17C4486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 00:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F771C20CC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C578031584;
	Tue, 10 Oct 2023 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnmiAPvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11C3551F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 22:48:18 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899AEB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 15:48:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5890aa0573aso3175201a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696978095; x=1697582895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=umaq0MSSZP4nebV23a71EOhR8vcMwzVfizynVgVctt0=;
        b=fnmiAPvHgD1J4KRbr7d09EwIph/9ZMIM3Tdth990ImcVjrdVOCQDf4tOrTwtDyomrx
         j8f2EDFJG9lNIgGWNdY+nSLltRK8Lhk16ZoGVYKXK/TEQRRasO3ENopHH32XsakSTHjv
         g7Xn6LhY9cCa0TlVSZUrdpwQwKLnQISv54MZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978095; x=1697582895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umaq0MSSZP4nebV23a71EOhR8vcMwzVfizynVgVctt0=;
        b=rIpmz8d8asGrxUjV6xzN0RjRTIyDjIigYBqB1/CfE6Gi0sjLNoBsjgfIpLx28KMohV
         S/0L2tBQuidPfxGS8bMac5vna6vzozgBo1g8zIJwsQ3P7ZVXXdNGrOTWHEJB6+SZnWdK
         VuXnF1UeKiI4RUgaEPfk4ILwwRh1VgHORU28aTFkP0ZZBpH/542+0pP+wOuL6LTrXtPE
         /Vwbpw3pEUhscy8gndad7OZ3EpWpbX50OynyF8TJjGSCOxW1OvpO6HG2wNSOEYLhw2ry
         UPqbFQDvQzM62W3ycIBOMyOjNypqVaXdHAJ2ONV5KBgBGbEQLeY0x+j3J/fFMjwdE5yA
         pVDg==
X-Gm-Message-State: AOJu0Yx8ih5CAfNa/hc2Y15P97xZpEjwSPC92sHP6Xbf28fLz3re3Bym
	ZlX1hioCEUfTuEA1tZdZFKG45w==
X-Google-Smtp-Source: AGHT+IENpAsAI6YM70l2/vXTEjXOUieOiaxbcuD746kJfEGMhyOn6kSyHuft6Mnk/j+JgWdkfG/7Xg==
X-Received: by 2002:a17:90b:1c0b:b0:268:3f6d:9751 with SMTP id oc11-20020a17090b1c0b00b002683f6d9751mr18076356pjb.23.1696978094874;
        Tue, 10 Oct 2023 15:48:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b00263cca08d95sm12419653pji.55.2023.10.10.15.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:48:14 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:48:11 -0700
From: Kees Cook <keescook@chromium.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: allow executing block devices
Message-ID: <202310101535.CEDA4DB84@keescook>
References: <20231010092133.4093612-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010092133.4093612-1-hi@alyssa.is>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:21:33AM +0000, Alyssa Ross wrote:
> As far as I can tell, the S_ISREG() check is there to prevent
> executing files where that would be nonsensical, like directories,
> fifos, or sockets.  But the semantics for executing a block device are
> quite obvious — the block device acts just like a regular file.
> 
> My use case is having a common VM image that takes a configurable
> payload to run.  The payload will always be a single ELF file.
> 
> I could share the file with virtio-fs, or I could create a disk image
> containing a filesystem containing the payload, but both of those add
> unnecessary layers of indirection when all I need to do is share a
> single executable blob with the VM.  Sharing it as a block device is
> the most natural thing to do, aside from the (arbitrary, as far as I
> can tell) restriction on executing block devices.  (The only slight
> complexity is that I need to ensure that my payload size is rounded up
> to a whole number of sectors, but that's trivial and fast in
> comparison to e.g. generating a filesystem image.)
> 
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Hi,

Thanks for the suggestion! I would prefer to not change this rather core
behavior in the kernel for a few reasons, but it mostly revolves around
both user and developer expectations and the resulting fragility.

For users, this hasn't been possible in the past, so if we make it
possible, what situations are suddenly exposed on systems that are trying
to very carefully control their execution environments?

For developers, this ends up exercising code areas that have never been
tested, and could lead to unexpected conditions. For example,
deny_write_access() is explicitly documented as "for regular files".
Perhaps it accidentally works with block devices, but this would need
much more careful examination, etc.

And while looking at this from a design perspective, it looks like a
layering violation: roughly speaking, the kernel execute files, from
filesystems, from block devices. Bypassing layers tends to lead to
troublesome bugs and other weird problems.

I wonder, though, if you can already get what you need through other
existing mechanisms that aren't too much more hassle? For example,
what about having a tool that creates a memfd from a block device and
executes that? The memfd code has been used in a lot of odd exec corner
cases in the past...

-Kees

-- 
Kees Cook

