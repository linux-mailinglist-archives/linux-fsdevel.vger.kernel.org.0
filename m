Return-Path: <linux-fsdevel+bounces-12916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1378686E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 03:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96702907AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440411CAF;
	Tue, 27 Feb 2024 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+93MRha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755B1B94E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000598; cv=none; b=owz0nP6S5SyH4Lf55FbRvL5Z0DE8IYGj/3IP+3OhMsrEqpV56w67/g2rYCCxTIzS5/Nbl+kCAFch8Uo2w2fmcNDCW8wsScq6WEVQtEbCjh4Jv6pnoSBDJ4sXnjSVfHQ/jF+oRbi9KtnaPXkqy3RnLpqpYkZDvcKbxw7DG/zzs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000598; c=relaxed/simple;
	bh=lj+342i91tukvDJc+7mQyuceOT3OFF987/6AJGtJA74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDWCT+VvqKZ9KTZMQYPe/5vC5BKq/sgx4skyJFTLxAV5BHDfyQSbWwOHxhLfaMtAO+LLsaVODhQm386lNcZhOQDxmwknPdoXxinXt/kBuODOg6Z4fp7wVmZTFjvzWWvmOkLMEXpEa2a7bZUET1GaHxTxCq7Lsda6Kb8ok8EiIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B+93MRha; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7232dcb3eso26879605ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709000596; x=1709605396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=memibgJZNOyBXI4CIvwtBXRp9WBttR7QAtL1A6J1jew=;
        b=B+93MRhafM3EcMzEgLJ2NrnA/NK+cO99KuZuBDVrK+lYY7WHQuw2ynskWHA9W27/yy
         jrRdW+7LoCjBP448TErolBOSSL/H1RxM7t8UbTszbeZFeB3x6vOrkZ6KBny6O2KpQRB4
         DeRUBKRg6cUUa5d1nB2tFG+31Q2FfQGs5h6Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000596; x=1709605396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=memibgJZNOyBXI4CIvwtBXRp9WBttR7QAtL1A6J1jew=;
        b=J4lJm41gR6Vnn8jb/yWb3F751QgWp2N590D7yzDjQQ2HPSsIhlK+Y+AULqSEBK8m5x
         eyvI+OHEzC6OYdKxc7Qr5/nJECwIZO0QZDJX6S1e62y57/18tuukG3UEQI5ZvdqwmYR4
         7iaZN4TiY0yIQUj2GNribgoJ0ryuINtqmMIyoCMXvEyzPWIiAbNL8frRFNa3B/JS9ObF
         0RUnY1sjjlVn9BF+usCITvHUIkOmLCgdF3naBpm1lsshUbfD7uJHQNx5mZLpgq3yorGn
         ac4B7KGcKHZnq6aOoNXBMsUHEHLBcG+clmoF0LQ8WA1t2y5CLK1eQYD8xI2fSBUomJB3
         QSKw==
X-Forwarded-Encrypted: i=1; AJvYcCWXe6yNUyghtVu3AlSdp//O70n8kIBYAZvNIjM/XMrZS79PKH3EjHNfDLehqfLOLlaejzwvIoZNve0I4h4csMJtWJQRCZmb3U6f3/gN/w==
X-Gm-Message-State: AOJu0Yz9p1lhaiYtAvh3PI3/ZWQaFvRsD58GWlk6jwVnpK+aDC8q9omZ
	MGr3H70c4Vhz4x/csLQ+R9ixdKvkC0gG9c6I/o4gfW717nLyqN5KloK9k4Othw==
X-Google-Smtp-Source: AGHT+IFplsJJIA7+1tesLzAlhF8/AJorGVOwn8v8Uyrd5ZzwmXskYJ3krHczx70GyhRbNqa7HaaPyg==
X-Received: by 2002:a17:902:f542:b0:1dc:a40c:31c6 with SMTP id h2-20020a170902f54200b001dca40c31c6mr4656751plf.25.1709000596048;
        Mon, 26 Feb 2024 18:23:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mn12-20020a1709030a4c00b001dca6d1d574sm343800plb.302.2024.02.26.18.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:23:15 -0800 (PST)
Date: Mon, 26 Feb 2024 18:23:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Bujak <j@exia.io>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, ebiederm@xmission.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202402261821.F2812C9475@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
 <f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>

On Tue, Jan 23, 2024 at 12:23:27AM +0900, Jan Bujak wrote:
> On 1/22/24 23:54, Pedro Falcato wrote:
> > Hi!
> > 
> > Where did you get that linker script?
> > 
> > FWIW, I catched this possible issue in review, and this was already
> > discussed (see my email and Eric's reply):
> > https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com/
> > 
> > This was my original testcase
> > (https://github.com/heatd/elf-bug-questionmark), which convinced the
> > loader to map .data over a cleared .bss. Your bug seems similar, but
> > does the inverse: maps .bss over .data.
> > 
> 
> I wrote the linker script myself from scratch.

Do you still need this addressed, or have you been able to adjust the
linker script? (I ask to try to assess the priority of needing to fix
this behavior change...)

-Kees

-- 
Kees Cook

