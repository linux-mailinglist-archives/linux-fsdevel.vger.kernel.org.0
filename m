Return-Path: <linux-fsdevel+bounces-8780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1AE83AE70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D603B2845D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB743612FA;
	Wed, 24 Jan 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1yZ07PB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A357691A
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114132; cv=none; b=ddjeRW3D94gy5oosrveS2A597XAe/n8G7AG6aJZss7mofO1HurMfOJ+J+ZcXh6YxbcqMtMtAHwLg4z88ziMqhjJrx2dgacCsejP8DLpQXguTOx8Wku1qEUUL87FlCNjqvaq6mNgfE2Tk3tqtsUZursmDqypj8s0YDvV2S0qH6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114132; c=relaxed/simple;
	bh=bR0sAu/kS7bcb+D5Msz7ceuC42KnLeHSzNW2hRBbkrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRVPibvMmjO2YTmDPE3OP2OjVwRiW7fHtbDPH2mPr6UvV2CYnYAE5sDSyVx5+U4oMtCP2ghyP3ia9Kl+YAWzfEPxYDFN8+FKotJAsVmUjoXtx+vV0CGZCc9aWErFyW7xgUZFI6iDNfFAb72qyb1t9Lzp6K//AOhQq1R+smkX/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L1yZ07PB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d780a392fdso9074085ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706114130; x=1706718930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2ne9DEtozuAA7QWnRNqqOnd5KtqxPd0sphMP9Q6c4=;
        b=L1yZ07PBuH4ahcUdNgrGoL7mLH9141b7amG1yoAPASpabpStN2qFoJ9KrcqWlmj3vq
         rhoLfrZjYS20PKpjNaQRDUI4pDRigxtBge32DVThwsBJU8PbdJAaJHuiD7GxiYc+PQLa
         aM4VW2DmXtxMmDJsWLE5eWSdpBd96kbm25CJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114130; x=1706718930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc2ne9DEtozuAA7QWnRNqqOnd5KtqxPd0sphMP9Q6c4=;
        b=uoYjJkFsO1OiMBKrFgZUI3PuqgHWvsJ/drDFYdmzOxfEnfWFbqLqsEKXuZYP6FpYA5
         mDOGcxWfFO9czTzLcTcVc0gGpNIrd2sZF1F0T1Zqm1Nn3A8Dm0BnXGQfKjAwnI3/YCku
         YC/SpJK9y2YMq8P2ukB3nNNgqoraLIh5sS61GpxMh0E/1kM3NYVvotgj6Hi4rR4xVjCf
         0+z8L/VRx+Mowyv96uCaVQqjX7WyCVi2ySLmuWfSTwkRQwL9PrYCBiTO2qkkbCExbFkT
         ELoDglJ1RA8Bc4IvytfTSBTmf/ydglm+1B4zBJCUZV6AxM/Q3q++aQfAJD2rBobic0V8
         ynLA==
X-Gm-Message-State: AOJu0Yz8er7DnLL0IOCFmTMYbbhA6s0bWDXofyuzVA8NzsxgSBz/AzcB
	rKpWx2CpwCZ24DMm4nj7uIguUPJt7Y5aZHXwfn/lUSKjXLAb9W4z0ay7D73RnQ==
X-Google-Smtp-Source: AGHT+IERyxG8hB13JvayvVAKVYQEmEi/M546PMHAK2ELkrVVnnL9t5Wu3jy7ccSeDT6NM+9XiRls/Q==
X-Received: by 2002:a17:902:c20d:b0:1d7:5eef:4ed with SMTP id 13-20020a170902c20d00b001d75eef04edmr1176992pll.38.1706114130308;
        Wed, 24 Jan 2024 08:35:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d04c00b001d73416e65bsm6909726pll.63.2024.01.24.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:35:29 -0800 (PST)
Date: Wed, 24 Jan 2024 08:35:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240832.02940B1A@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbE4qn9_h14OqADK@kevinlocke.name>

On Wed, Jan 24, 2024 at 09:19:54AM -0700, Kevin Locke wrote:
> Hello Linux developers,
> 
> Using AppArmor 3.0.12 and libvirt 10.0.0 (from Debian packages) with
> Linux 6.8-rc1 (unpatched), I'm unable to start KVM domains due to
> AppArmor errors. Everything works fine on Linux 6.7.  After attempting
> to start a domain, syslog contains:
> 
> libvirtd[38705]: internal error: Child process (LIBVIRT_LOG_OUTPUTS=3:stderr /usr/lib/libvirt/virt-aa-helper -c -u libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb) unexpected exit status 1: virt-aa-helper: error: apparmor_parser exited with error
> libvirtd[38705]: internal error: cannot load AppArmor profile 'libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb'
> 
> dmesg contains the additional message:
> 
> audit: type=1400 audit(1706112657.438:74): apparmor="DENIED" operation="open" class="file" profile="virt-aa-helper" name="/usr/sbin/apparmor_parser" pid=6333 comm="virt-aa-helper" requested_mask="r" denied_mask="r" fsuid=0 ouid=0

Oh, yikes. This means the LSM lost the knowledge that this open is an
_exec_, not a _read_.

I will starting looking at this. John might be able to point me in the
right direction more quickly, though.

Thanks for the report!

-Kees

> 
> The libvirt-$GUID file is not created in /etc/apparmor.d/libvirt and
> apparmor_parser is not executed as far as I can tell.
> 
> I've bisected the regression to 978ffcbf00d82b03b79e64b5c8249589b50e7463.
> Perhaps the change in this commit causes AppArmor to deny opening
> /usr/sbin/apparmor_parser in preparation for exec?  For reference, 
> /etc/apparmor.d/usr.lib.libvirt.virt-aa-helper contains:
> 
>   /{usr/,}sbin/apparmor_parser Ux,
> 
> I'd appreciate any help debugging the issue further.  Let me know if I
> should take it up with the AppArmor or libvirt developers to better
> understand the issue.
> 
> Thanks,
> Kevin

-- 
Kees Cook

