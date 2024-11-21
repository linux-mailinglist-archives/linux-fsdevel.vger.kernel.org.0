Return-Path: <linux-fsdevel+bounces-35485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124239D551F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2A2B22BDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C51D0E10;
	Thu, 21 Nov 2024 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SiBRM/kM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7B1C57AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226564; cv=none; b=ekKDG8kNYjBRcxbDgQEg398jGMHjM07C+3CKpn3E/QorOaXqDKiWIhoNNh+hGdt1l/Gi+jXgTDnqDe5YFRsjGZAhsK0GiZscv194tvYi2GjZqpaKqk5rJrlvk7TySTnsGpEqnXWZDTvpczDWQhl7sceUle2UAdsLi6+v+2iP6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226564; c=relaxed/simple;
	bh=Ou2bSsgKxk3UOtc2BsS6ApwYyHqrVQbDy+rCD3RwKL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shFZZ2XF+wGoA1Cox/eyYebX1jGn7mM8rq5/4aL4tuASpFpHZmcCDUPex0DU26qE+s2zSzXJvIuLiXlK8KtgKtN2J3jDnDrOWGYS7o00V15WnQjhTbVzopn+0WL7ob4PeUDCBDjazSALNl2HgFbEZTM4Vwg1piAdjrCwh0cRAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SiBRM/kM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eb0c2dda3cso17967627b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732226561; x=1732831361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zc9rNl+kHMHXgDoNRE5mV3rg1Potuw14ny2kvcyl0vA=;
        b=SiBRM/kM3PmRaIRnOVS0y0jDSlYRhvqN86sisP3zhNgfhaZ6BdJ7SK+bmZ96qGnkdy
         10MKzfqk+laujz1dA0qh7cubR/rY00TvcVWZKuUSzWKyoi6s2fm1XqJVRJXdzOrrQbah
         WfGLo7Djl4fAmDLXbXciIxKxuiFVi8fezNPxqcWVTdRjGTeDweQn0bFUoRllglLe7mjl
         CIX8wAJJjK79SyDwgzLTINxqq/BFltSS9WEhBgUdiRPdP8IqInDKaZbE89AJzcE2U49f
         ht2sYXzijaM9huS01cNYSNCGzlT7FDl97n4cFuDpn0RMTM7YJ7HUsd2imjuWYLvfyDOs
         NWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226561; x=1732831361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc9rNl+kHMHXgDoNRE5mV3rg1Potuw14ny2kvcyl0vA=;
        b=t+zxfGyddmRGN98UEMelsYfiEQXF1nZ/mmMCT17yUed4NiCRJUp4OO4S3KNdaW5qV3
         9EyDMc6hCh3yGYWq5L9FqqeXdGp/k2DOWZLdPC9mvL52EYw6HfvwwkOL6ZXW+qveH9Un
         Nd+4nr/86UYiOH8LNp/ufjhvCZFmazkQFJivH2g/AOh6qJUCsvsA/uHpFDT7RZACE6aD
         pi0U9jHbOUPvURyFYVb3RAz83MAmc5cc3FRRmIQFDKhJXpGNcFfxDTyciiUw23AUfszD
         hJsEEQz90WmryM1N5B5ccF/NTBZJUq3Jk1us9pIJ+rv1WeyB9hvGLotnEmK4Dz4h059n
         FRJg==
X-Forwarded-Encrypted: i=1; AJvYcCVL/wIW58Vt6A5XiZTtJ1Qm2d/9sCyAXun1VSRQqBmNhJFAV5li3Di0d9vUKjiG3fF7ChIlTrAvBxbZ9fEH@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCxFJ8Dd5L/P3FxAQF4ddTTmiGU3Z2Kcm6RcNrGzPLRq7xpmR
	ALlmDE92rKsuuXucsQGtZZGhbnEykdjk5cyEJUESYf5CWjWMIL84eMOT4qCFdHY=
X-Gm-Gg: ASbGncv7sSEmPqlNtd71fm2f17QcXNpOTt74gPNiine70Svah8BfhWLtcBFXaf5QgjK
	29UKMZv1FdemhuqLN0mG9XFwdNbYspb0q68IGT0r6IHKq0E1Zu/NsnrWnB7qBLSbduSUNmaJpNY
	xFt71zVNC5Egrpw1lJ+8PAzGkz8Knqm6fF/oy06mVPJSBvu3K+Ow0+T0HRA4R1AKh3NUySeaSEB
	LoQIQP8u425Q0dciHWwppSe4sbAD1EJlS3EBluPetceAhTeTe7FZupGmSmFuhpdO2Oi3wJ2lGGx
	uK7JqTA9IIY=
X-Google-Smtp-Source: AGHT+IFR+F92+V358rbHDlhJmHtztkY9rf0mMaSihml5p76Zlcvlx335TrRPFMNk6r3qPjujTLmpqA==
X-Received: by 2002:a05:690c:9c0f:b0:6ec:b10a:22a4 with SMTP id 00721157ae682-6eee09e8324mr10163967b3.25.1732226561060;
        Thu, 21 Nov 2024 14:02:41 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe153cdsm1570787b3.4.2024.11.21.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:02:40 -0800 (PST)
Date: Thu, 21 Nov 2024 17:02:38 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH RESEND v9 0/3] fuse: add kernel-enforced request timeout
 option
Message-ID: <20241121220238.GA1974911@perftesting>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114191332.669127-1-joannelkoong@gmail.com>

On Thu, Nov 14, 2024 at 11:13:29AM -0800, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
> 
> This patchset adds a timeout option where if the server does not reply to a
> request by the time the timeout elapses, the connection will be aborted.
> This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enforcing
> timeout behavior system-wide.
> 
> Existing systems running fuse servers will not be affected unless they
> explicitly opt into the timeout.
> 
> v8:
> https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong@gmail.com/
> Changes from v8 -> v9:
> * Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
>   spacing (Bernd)
> 
> v7:
> https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoong@gmail.com/
> Changes from v7 -> v8:
> * Use existing lists for checking expirations (Miklos)
> 
> v6:
> https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoong@gmail.com/
> Changes from v6 -> v7:
> - Make timer per-connection instead of per-request (Miklos)
> - Make default granularity of time minutes instead of seconds
> - Removed the reviewed-bys since the interface of this has changed (now
>   minutes, instead of seconds)
> 
> v5:
> https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoong@gmail.com/
> Changes from v5 -> v6:
> - Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
> - Reword/clarify last sentence in cover letter (Miklos)
> 
> v4:
> https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoong@gmail.com/
> Changes from v4 -> v5:
> - Change timeout behavior from aborting request to aborting connection
>   (Miklos)
> - Clarify wording for sysctl documentation (Jingbo)
> 
> v3:
> https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer API)
>   (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)
> 
> v2:
> https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests 
> - Fix kernel test robot errors for #define no-op functions
> 
> v1:
> https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
> 
> Joanne Koong (3):
>   fs_parser: add fsparam_u16 helper
>   fuse: add optional kernel-enforced timeout for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
> 

These look great Joanne, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef

