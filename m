Return-Path: <linux-fsdevel+bounces-14915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EAE881757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A5F1C2117A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DAC85281;
	Wed, 20 Mar 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZCMe9Se"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F87E761
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959581; cv=none; b=q5IktjjmXKVzAhf0xjZTtWkQbUmgOd5oXC51oCMcT+ail+FWSvSXlPraER4IhFAEkjmJH/mizLmCIwPyruBJEY5EHKLKxb8jACK1QOeXDpghrv7Qx7z0UpS4W4T764WGJJsv70yfBmHkJx6plDQVc0KT/aqBFpkUuM+ckSuoLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959581; c=relaxed/simple;
	bh=EJT0D1v1X9S0ArAaEhYtEiH9DO2sjSfqNcHc3y+L81U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/dBpBunnmb7VM0kE58n022LZb0JMn+/WEwCNrv6QH7ArWvfmmj2rwwZZ4KHGGfFFudZ/x+ctze7EmkSM9PfzwrPM985h83tiCZgqjtkkrO8b0ghwa8I+/XTCwAJqXz1ARajSb93F1Bl7s8iVa0LrpqKiqHp9kOMG3z9da5dqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZCMe9Se; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so2993401fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710959578; x=1711564378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogqc9yIyd+winYNxhTRHIu60n7nx2qJvwGWXSoSBDRw=;
        b=bZCMe9SegtRy+QwQ9sqpThN4/q4cbYUSj8YxHzNnhsjUDe12WE5uif9DFAahd2uyDD
         Ep1dqn6MOMvlsGTJuUAaT/DJJ5GZT22m26Yj2tVD+YEeF6ITwEOGe7xy1yKi4BcaNxob
         FcRJauvCxTer9VI300+hEY8y905MTe9CEpuVfxx2OFGXv8Z/Rk6Q7He3UYolPCcZcjLg
         sooC/c2VpAL2InmDyKL62cfK8YC7tMp7ccS/ycTntmV/cx3dp/RZeN6XP6PhZW1bMY6u
         Fu+NIwxnCPd0NLtl+3VEkawzHNs7IXPdHhYfMqWAHLqsyHtrdLYyI9I30jswiImsvdRf
         nfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959578; x=1711564378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogqc9yIyd+winYNxhTRHIu60n7nx2qJvwGWXSoSBDRw=;
        b=i0NPLniSOoplbMJuhDSSdyAtToCZ6cHWlrWoiG01iJ8Oe7SQpEGPbJZXWuMQaoL1EZ
         PR9joBjsY3bOQkpTal9eClX6W8+Eokqrc5qKQJ+XTxEsaqrTvh0+j9uazd1PgyvdA/B+
         XEk6rEApZV8qs3QIvYIMYOxTsXK7LytuZUxcYmHbSXT2FVIwqQoYXi3GiqxXFaC4mI1g
         1S7g7W0YchI/a5tSHucZKIkvJd4tCtkcaozyhWjvGdcbAQXvmfxr7+phXuxlDuaW6hEU
         SQJiMBmDb8oxB4H5JJDA1B60G8D0YLrDkBHgmHL8tvuPamNSOoeosiQVh+nKjxyNuwlb
         JH1g==
X-Forwarded-Encrypted: i=1; AJvYcCXeZEp9sbmsne9/xJhNaTQIgzsosl13rC2mAhSTyFPCqe6fsn9X2IjGD4B63Ak1vnVZvHtEjftWhKn6iOvWhw5VmYFoxL3VMAYtwAKj5g==
X-Gm-Message-State: AOJu0Yx9QjeuO5iHwxKSmPZ4gUss1NaPb03DaGx0vIx2V+pcyKbBNf/R
	wZQwqkifx09CZ7DzPcNQ0OASMsmPAs4pV6vm2T/eubtCuCx7QCXXuY9CAjL7k5k=
X-Google-Smtp-Source: AGHT+IHKJ6K6y29axy/aP5DCgrp0Yz9RxQ+j9lvERuKx9mqFi9BKRR/lfn66qaKuBr5eBlZoJvqgew==
X-Received: by 2002:a2e:8645:0:b0:2d4:51f4:dbee with SMTP id i5-20020a2e8645000000b002d451f4dbeemr12641554ljj.53.1710959577444;
        Wed, 20 Mar 2024 11:32:57 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b0041401eb021asm3000762wmo.24.2024.03.20.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:32:56 -0700 (PDT)
Date: Wed, 20 Mar 2024 21:32:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: NeilBrown <neilb@suse.de>, Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>

On Tue, Mar 12, 2024 at 03:46:32PM +0100, Vlastimil Babka wrote:
> But if we change it to effectively mean GFP_NOFAIL (for non-costly
> allocations), there should be a manageable number of places to change to a
> variant that allows failure.

What does that even mean if GFP_NOFAIL can fail for "costly" allocations?
I thought GFP_NOFAIL couldn't fail at all...

Unfortunately, it's common that when we can't decide on a sane limit for
something people just say "let the user decide based on how much memory
they have".  I have added some integer overflow checks which allow the
user to allocate up to UINT_MAX bytes so I know this code is out
there.  We can't just s/GFP_KERNEL/GFP_NOFAIL/.

From a static analysis perspective it would be nice if the callers
explicitly marked which allocations can fail and which can't.

regards,
dan carpenter


