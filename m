Return-Path: <linux-fsdevel+bounces-49007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643DAB76DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893419E1F29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B33298251;
	Wed, 14 May 2025 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLwSqk03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F329824D;
	Wed, 14 May 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253976; cv=none; b=e7o3u65q3jYCrEUmx0WH1UR72th9caGWHOvHRoeO2dx2orfsHWRgIzZ0EYtJfuafOadGc7da1gYRXHFzPJByrk0JZbufmnS6XywqLnD+KeR0X365/S7HHmvOSou4LvYWCwsUFrcndGBqQXDGP2KpeUqkD1BdYUMNGzdGKjZRzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253976; c=relaxed/simple;
	bh=bT9yarjWt4tVIFw8YTecHghmXuOoxUPOnBv6bMf16Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrD/kAT57/SxAYe/1kYYG9w5ng+KKRpMBzPwBK3vLCyyqdZmK2se3tIl3hNn9+y83JaNtwhBOt6GIbh4gkY+8l7Sg/htHGxSaNTiE/a1xd0PScVNy1I3KIZ1xkhrSMZYwxYYE7R7UfkjxJ/hbwQ/qRQtpGEuLmCHDJ8qpjuPV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLwSqk03; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-525b44ec88aso42938e0c.3;
        Wed, 14 May 2025 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747253974; x=1747858774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bT9yarjWt4tVIFw8YTecHghmXuOoxUPOnBv6bMf16Q8=;
        b=YLwSqk03L+KDBLPVN3ruMmmITg1ySr0CBC4AQU6ah01FVyJgCfTirOr0sCxHVcbQYH
         YCJ+bEBAHg6GkLT//eLlePlasY67n0PkBwP4tjxcoEdxXksfI+VwRkWotGTKYKw/pVbZ
         xw6hScquZ/t4XI/1kvMpyjvY4IDPqeNATKSCVM7e0rF4/jbQDc4/aKXWNzZV0rYE/IKu
         b6EFsz3H8cPpVyx2OfpmhZhOydnnqHA3VLLdlRBfmGdvzFA9pIBGKo2dh3TGgpTZTSIw
         PBZ/erACjTlq0yzPxmP0BcJcokBvLLLkDOc56f+uHhuYBGwyY3fQvavUmgV+54H+5HI+
         9xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747253974; x=1747858774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT9yarjWt4tVIFw8YTecHghmXuOoxUPOnBv6bMf16Q8=;
        b=aFRi6L22Cwp7BIpv/Myd8Y9JZ7yOuhQlZmeIj7E1DX2JLsnySn1HF/Ic+Dfk7UczoG
         ZzuRDZHLazS+GcZrHa/FNpWtfiR3VU5nPCNFtELGAn/8d9gT7ovWS0cWWAUrGo8kSFBa
         OoCME7JeJga9pMaupwfRIrxuudNpW5IS6JUUV29UDy2ZkQnk1zsZrdD5fPHC01lSnED6
         0vUPzNDZHnc5hSbmG3Rbup0JUlZDw2oIcLmsnbeqfS10lilD837pZk/G1Qj1741noEHO
         HCe3QIky6EoNT+MJQjk3iafPXYUUD54qLLPO2hQvscFDbmjvEPxAw40SXSTzcAy8mhYe
         A1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAG1kpvHy5q/QlE0baruH6xyHU1DmnrEQkEFraNsgJGAZZm3IgnRppi+UKHWAf/LSJal2mfQmNoOZ80nzE@vger.kernel.org, AJvYcCUozLJsQvrIWYha7WhsVm/stqkkZZZ3grcxRTOXtuVYrB16omEvlCTsVW/NTho1S09jvT2hh6oWY3UGLJGh@vger.kernel.org
X-Gm-Message-State: AOJu0YwBrg8e8eDLBEuPr7jjTvvnvKSEtfZ9YkeEGMufGP659tlAw9iT
	ejJdncm+u43VQYuyCAp5XDf2RBqTkF6UGbTIhoYPo2UbhW9vRW2h
X-Gm-Gg: ASbGncuZKVbs635TwSA0AuF+iahuyfFd2lJ95j2EBkheCoqK4VvbsDowL5+KF5NE+0e
	qQzCdnutlyLzV+FTXx2IYH3YF+MwqjIADjU1nHv63whVXdVoB5G4rtxF2u4twl/BSJjsCjr4LCe
	im9S2SaoxljJC8BsQNTwIIpidwRcFWl0GjLI9chQ4g6h/lwD8QNqLcLzDIwP0EBMPSbD7aizfhh
	Eusf7q8p4cfUA7JXv2tpNiJHxMwAmlkP9uLbuayWmi/Ea3zkbNhSidXG0GJ59BIpDe8iIl13jLH
	osf6m2CNFfV9lgupAIheJ2oACkMjeYv2FdfDKoTRqjCwF2j86YIU7xa52M7c
X-Google-Smtp-Source: AGHT+IEklNn5lxG4rs8q6Ni35Nn2GfrBBAk6umuSy0UZjtOYTCWtiNdraurxKWb0d3N/zhyCFL9RhA==
X-Received: by 2002:a05:6122:2013:b0:52a:79fd:d05e with SMTP id 71dfb90a1353d-52d9c57a600mr4775615e0c.2.1747253974118;
        Wed, 14 May 2025 13:19:34 -0700 (PDT)
Received: from eaf ([2802:8010:d51f:e600:9f56:2539:a02b:bd00])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c537264dfsm10133700e0c.13.2025.05.14.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 13:19:33 -0700 (PDT)
Date: Wed, 14 May 2025 17:19:25 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Yangtao Li <frank.li@vivo.com>, ethan@ethancedwards.com,
	asahi@lists.linux.dev, brauner@kernel.org, dan.carpenter@linaro.org,
	ernesto@corellium.com, gargaditya08@live.com,
	gregkh@linuxfoundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, sven@svenpeter.dev, tytso@mit.edu,
	viro@zeniv.linux.org.uk, willy@infradead.org, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Message-ID: <20250514201925.GA8597@eaf>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com>
 <20250512234024.GA19326@eaf>
 <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>

Hi Nick,

On Tue, May 13, 2025 at 12:13:23PM +0800, Nick Chan wrote:
> 2. When running Linux on iPhone, iPad, iPod touch, Apple TV (currently there are Apple A7-A11 SoC support in
> upstream), resizing the main APFS volume is not feasible especially on A11 due to shenanigans with the encrypted
> data volume. So the safe ish way to store a file system on the disk becomes a using linux-apfs-rw on a (possibly
> fixed size) volume that only has one file and that file is used as a loopback device.

That's very interesting. Fragmentation will be brutal after a while though.
Unless you are patching away the copy-on-write somehow?

> 3. Obviously, accessing Mac files from Linux too, not sure how big of a use case that is but apparently it is
> big enough for hfsplus to continue receive patches here and there.

True, but the hfsplus driver is already merged and people may be relying on
it. Still, there was some push to get rid of it recently. I don't expect
much support for picking up a whole new driver.

Ernesto

