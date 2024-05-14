Return-Path: <linux-fsdevel+bounces-19464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211898C59FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529C61C21462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCB17F38E;
	Tue, 14 May 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjZRKD+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B41D545
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705901; cv=none; b=inFZNFqslPhiBs3IKwuSdz43z4Lrr0YgrmklPw8K+qBz9NI9MfrOs/ow8aHiX6j0qMCTMfuFdbZPsrlZnNfA2kqDzBUnNVRd8Q+BtrcmZImdmGCd+UXOVIKQ+S6mLFKNPVlsiHdcimRurKSQFQK13GMcM0vpodCwe3Q6NAz3gcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705901; c=relaxed/simple;
	bh=UXuR92VhqJBzfoNeRxmO5MOMML/qDveLP+5yOuN5TKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioC/Z7W8BCfrYubD+I+whiwqQ3Tgpqr8cgj4ZEhfzGGUVj28uoInafgjW9DJV5K0AYK3EV2EVLO+JYsrQbALvh5GQ15V1B1qLpxhFhiSavRdlORPKgS78NSVL+yiXedmqP8ZMtmZW9jJNftt15WB4T3yKSIl+a5lUvZrQZ73QmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hjZRKD+o; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1edfc57ac0cso47523025ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715705900; x=1716310700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEkF4iBhBtaf00+75FpppIRiafT1boFmdAFNfkJUL48=;
        b=hjZRKD+oOLrNxLdv7ZBO2stWMNuariV9mWueLYo0xYB5J4bpHLDFZCuDaCz0x67Q4c
         lwlJeyV8i7wNlg9yAK0Hg4PYLa58xHazUOIeEm2JrMsKkjiWZ2P2qTRcbuoZC4KeLmbq
         lQIAzNdom4U+CDmc6cPv0vMSEem1etxRqlOFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705900; x=1716310700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEkF4iBhBtaf00+75FpppIRiafT1boFmdAFNfkJUL48=;
        b=KmcLNihNMUmcdp5yywsCDMLEEAY3SnlXSW53oPbzc2GXUAQTXkkZOtmHQQAHNPAoyo
         qeXI0uGhxcPOdVmCkc8sAzKMB8Vi/fr5eQgJvG/UFhpdS81HuF4P8QVxSGOsZBJA1Qik
         qmtdK0P00Zkx4G8HVvZvJ/HuE3v9K3wJvFRbC6ELyhKuIyNKIsk2iOEyu+KMM2BZQpsn
         Z+pDKoKppArnHomf76EgHmMFQd/ubRhVy8oBM9AOcV9ThlCw9uxJ+ha2d9rcDJneJ/Wp
         RMHmFs4XSAMLAMth6ySB0dXQxYuz29dUBeQMH4rYFo+LBCgqFDBKyC+eHnLR8oVIKlV2
         kvDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/C8DmIzTNHKitUWdTGqskRJGfZRaFO5Ruv+SfENR1OyMMGhiFs1LHgqEkQJaSHh3GGnHa1yKYHgxTgNtUruRVBcRONgV75hujJndD4w==
X-Gm-Message-State: AOJu0YxapGoji6hFwb8HnTWBS8evFVsNGnk43DAIbhVL/h5qWWVTTxXB
	W04DwlooGnD1gwzkoxdhebetVzQSeisCBQQYE+ZzMylt1Ubq17Giz6FFAiYD/w==
X-Google-Smtp-Source: AGHT+IFx8txCf+f4PDg/JkVSx/NTLN/wTj1FanyAGcZfdZBY3c1JiC6zHAzNid2BkAx76LnPYKzB7A==
X-Received: by 2002:a17:902:e887:b0:1eb:7d1d:67d7 with SMTP id d9443c01a7336-1ef43c0fda8mr180003195ad.3.1715705899703;
        Tue, 14 May 2024 09:58:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d4278sm102727825ad.12.2024.05.14.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:58:19 -0700 (PDT)
Date: Tue, 14 May 2024 09:58:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev,
	pasha.tatashin@soleen.com, vbabka@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lib: add version into /proc/allocinfo output
Message-ID: <202405140957.92089A615@keescook>
References: <20240514163128.3662251-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514163128.3662251-1-surenb@google.com>

On Tue, May 14, 2024 at 09:31:28AM -0700, Suren Baghdasaryan wrote:
> Add version string and a header at the beginning of /proc/allocinfo to
> allow later format changes. Example output:
> 
> > head /proc/allocinfo
> allocinfo - version: 1.0
> #     <size>  <calls> <tag info>
>            0        0 init/main.c:1314 func:do_initcalls
>            0        0 init/do_mounts.c:353 func:mount_nodev_root
>            0        0 init/do_mounts.c:187 func:mount_root_generic
>            0        0 init/do_mounts.c:158 func:do_mount_root
>            0        0 init/initramfs.c:493 func:unpack_to_rootfs
>            0        0 init/initramfs.c:492 func:unpack_to_rootfs
>            0        0 init/initramfs.c:491 func:unpack_to_rootfs
>          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
>          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Ah yeah, good idea. (Do we have versioning like this anywhere else in
our /proc files? It seems a nice thing to add...)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

