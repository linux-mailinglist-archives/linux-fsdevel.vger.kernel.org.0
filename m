Return-Path: <linux-fsdevel+bounces-18699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6138BB865
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 01:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE29B1F224A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76B84DF7;
	Fri,  3 May 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SdYacVJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30884A57
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779820; cv=none; b=IRK8Jvv8pf1O5/4YrY8lWHaTnP8/Bs0uoCI2l0OZeKEor9MnPgZnA1OTfFPLTrT8Hlrm9ArmN0CJi7SQ5L8gbVbOU1IWWnMNKb2jagYY48zRSvvgOB8v1QIMPVbkUjFgcO90FGlBgKFWs+wvHbRLBs0DNjrBpQS9oV5+cGcHRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779820; c=relaxed/simple;
	bh=ktX1OkI7+PiUxrOJuKaZuk+OtoCLIWD+flahzW9oG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWJP3wEOtcS33V9o5TCmB8Ai/GELiTQYuohYUcpr2LabElhIcArcIo+o74/m/otKqtVOFobw9j1AlzuSX3j9ktNkJXoXdgnXtz6opHlmSDpWPiXBdXBg81GFhoeCI0OQjKeSQiQw+37gnq9S8i2PiAQIptU4fz4zvJMYXfB5WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SdYacVJU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecff927a45so1786265ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714779819; x=1715384619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+dUWCvJXqFCm1BZPWTzdhC4tLQMbPhbpvfeYsuGgg=;
        b=SdYacVJU97ZnydpaoaSXhhoQH906Qx0WAlrqeufIeFODF2C3vGDGF8AbUBgCSZuZX8
         hOnPuMILEFjuxORODyvoDfoTTCCt19fQ6rZxtKnHI3oWsLQid7nufa8sZgwkItz9FQaj
         hA7X11pCf602lHDNIWE+8I4+6V+/aQTce/LlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779819; x=1715384619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP+dUWCvJXqFCm1BZPWTzdhC4tLQMbPhbpvfeYsuGgg=;
        b=m7j+pL/ullddha5GVJqyf0Hj/qZMOXI+Mn1TietXIOzAb6cH/caSEGRpuWjcpYMZbt
         ROYNQ8ZQ+Hvav1aCn+NRHESH55kP0zok2YLsVGIsywlrEU4eAMyVX5IlNi3yzrkHJpXS
         TVQUBanqejKtfvIar4SH+M5yuyV1YMJXUGLqxifvtpszZtzkgtrKcnY0o5tkQcGPu+wd
         wao7VQVGJfUZluLPW1sETJnqsGKyeEawRTwL0eAF4v36CuZccvVp2uzc5HFgHNoaY8dp
         Sj8W+hJnGcWkgld65TJZ5LqbV1iQjKuxA4F8oZukvKUtpKzPg8WaXYn+aR4cHgkbReK1
         GAgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4O+7X1LGbbWNsvSe3qMMBbiT2K+SEL5ggOksH4LVriEl5FwDc3wnR+L2Mw6BKL/l3rp/g6qL+EgCgo/H+RtMkb7I6f/z/jgO09/YLwQ==
X-Gm-Message-State: AOJu0YwXPInqPIyV+cXTk2CATsFTAkztnHHOlhcFU7vrL37qvz1//tBH
	271eiUblSTPz68Y6kcGu8RY0U8IM/+5/XH9/rO8AEDG34RUW9gBjhFmiEI0Lwg==
X-Google-Smtp-Source: AGHT+IEygCbwCpI7xjb71AoumHXdf2ry+30qYYFJd6deEDKA0dH5g8yyZFHZPXGPeG6dZEA2I8WycA==
X-Received: by 2002:a17:902:c948:b0:1eb:61a4:a2bc with SMTP id i8-20020a170902c94800b001eb61a4a2bcmr5466122pla.43.1714779818868;
        Fri, 03 May 2024 16:43:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001e2b4f513e1sm3819248plh.106.2024.05.03.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:43:38 -0700 (PDT)
Date: Fri, 3 May 2024 16:43:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405031634.77B223D8@keescook>
References: <20240502235603.19290-1-apais@linux.microsoft.com>
 <ZjVAJOsC-EtlIXd6@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjVAJOsC-EtlIXd6@bombadil.infradead.org>

On Fri, May 03, 2024 at 12:51:00PM -0700, Luis Chamberlain wrote:
> Thanks for the cleanups, this is certainly now in the right direction.
> Generic long term growth questions below.
> 
> On Thu, May 02, 2024 at 11:56:03PM +0000, Allen Pais wrote:
> > Why is this being done?
> > We have observed that during a crash when there are more than 65k mmaps
> > in memory, the existing fixed limit on the size of the ELF notes section
> > becomes a bottleneck. The notes section quickly reaches its capacity,
> 
> I'm not well versed here on how core dumps associate mmaps to ELF notes
> section, can you elaborate? Does each new mmap potentially peg
> information on ELF notes section? Where do we standardize on this? Does
> it also change depending on any criteria of the mmap?

This is all in fs/binfmt_elf.c, fill_note_info(). There's a dump for
each thread's info, and then fill_files_note() (which is what this code
is adjusting) which writes out every filename for any file-map VMAs. The
format of NT_FILE record is documented above fill_files_note(). So, it
all depends on the count of VMAs and length of filenames.

> Depending on the above, we might want to be proactive to get a sense of
> when we want to go beyond the new 16 MiB max cap on new mmaps for instance.
> How many mmaps can we have anyway too?

INT_MAX :)

I'm fine with the new 16MiB max for the coredump. If we really need to
go beyond this, we might need to avoid building the entire thing in
memory, and instead move it all into write_note_info() directly, but I'm
not interested in that refactor unless we have an overwhelmingly good
reason to do so.

-- 
Kees Cook

