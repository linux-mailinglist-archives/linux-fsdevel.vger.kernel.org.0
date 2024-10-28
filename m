Return-Path: <linux-fsdevel+bounces-33086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549379B3997
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8637A1C2215C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D331DFD8B;
	Mon, 28 Oct 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBJjWUwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D561DE4DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141474; cv=none; b=AGfYNvH9nl7HY7bKyuPkN8+Fv2CpdLr7e1JGBNxEFUGwqWKg0+ECoeAuZO1n8G98r35iPRDU05hcGMwoIBv/feEOPoHPnJGwH5KzU5udmd0Ztuh8EctWGlWbaLelHLXMuKXx+zr+JHZXJKZLHoufpmkPIitYiZjeYhkEMeZUGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141474; c=relaxed/simple;
	bh=f9kepVkx7ozexatwzky/15PVvfGex2hIQ3aQJm8Uw0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKMk/U+jp1N4ajrRGqnPADRQ8kxroO7QQSR4iH7ULL9Me+NBbseup1qIAdRuptulbibDckQr8mmN4As54SUua8wnH76Fj1iZ3J8EeGbhZcnDvWWQ/oRaXcye0UYjRjn49ETs/NsPe9MzhzlDtV/Pn1lcWDvNNz0cWwU2maKt3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBJjWUwb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9aa8895facso753750466b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730141471; x=1730746271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIxdURF54ugS0I9GsxO6vUsWqiwPODNyGYtyXOv/jbs=;
        b=YBJjWUwbwWpqCNsu9L/uBac0yt3w6jcbucqVOaFqnypeU8a22MBD4CEFWVvjsxed81
         YQ6HqlI/epm8B53BXZpwZPam633hvXX/EIci4rBebxQyrLg7I09wnZi31FPsaSoPtiam
         gUXOBWq2oj9PZz+J58wo4ofIWiFiR7hU1zVM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141471; x=1730746271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIxdURF54ugS0I9GsxO6vUsWqiwPODNyGYtyXOv/jbs=;
        b=nli1fCKSs3eV7Zxc62p/X8PTgjUpXpP82u53b5BFhX23vCcv+r5khBQp2vDzBpSSOp
         eTrq073weFv5MC2qyu7cW33bOyhlVW1CFMZOfP5GWixNxDygCkomtkjf1jNB1HJEPmWc
         S+J4TWMVQz1HLaq/FcthYTz9PVlWRapba6F2YseysitXfjCGuh4u1bdNPD/cFNMCwNXu
         Es69VRcVoCMLHK7UoKPdQzmr22/OT4nFyfA8RoAB1ehaP6FsiPaYoH14wlUwiPVf0yTs
         +s4/6beYfy0nH6p2wI/PLY848DbMweSdtpNBp5p3SG/ahoLcEIPe95Y2TQvbps/CodmL
         b3dA==
X-Forwarded-Encrypted: i=1; AJvYcCUt60s/VQS3kEyr6OccnK89g3zj9ClT6ovcNN6leFeobQUhZaLmCSJHbZ2Ka76AFDoyUu76WU+0RNEqWJD1@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBZcVeCjIEzn2bPV4oZ29cQsCrEEPhxT4y+wZGlWX2c9jSW71
	hBqziBnhS4YGTB7IGwRh1mXzR8Td2Ap/NfJ9JIsE3ACSDgGCi5jIAh4D80/KrUEuti2Ixg5WMSy
	SSvM=
X-Google-Smtp-Source: AGHT+IG30m3QExTTZMKHmO6LtPGcuep7+IBFeRadAZiK9w8EmtgEsGsd0rCTRQTvcFRoBTy/3gQvgQ==
X-Received: by 2002:a17:907:7b93:b0:a9a:b70:2a7c with SMTP id a640c23a62f3a-a9de5f3f87cmr683093066b.25.1730141470677;
        Mon, 28 Oct 2024 11:51:10 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec8100sm399660666b.6.2024.10.28.11.51.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:51:09 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso6303056a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 11:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFRPyK4TzWyf1N7Nx/IwEKkKItxT2mIllzaWIS3kK/WasGNQIdzgTNLSN9oqQmtYARH1dO77O/W7sYBggM@vger.kernel.org
X-Received: by 2002:a17:907:7e9e:b0:a99:61f7:8413 with SMTP id
 a640c23a62f3a-a9de5ed3f62mr706790166b.23.1730141469413; Mon, 28 Oct 2024
 11:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com> <874j4w4o1f.ffs@tglx>
In-Reply-To: <874j4w4o1f.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 28 Oct 2024 08:50:52 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi4+sVr6MUsybh8v-fPYoruZK9AmtasqMYi7z09UKHf6Q@mail.gmail.com>
Message-ID: <CAHk-=wi4+sVr6MUsybh8v-fPYoruZK9AmtasqMYi7z09UKHf6Q@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Darrick J. Wong" <djwong@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 22:41, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> It has caught real problems and as long as we have highmem support, it
> should stay IMO to provide test coverage.

Yeah. I'd love to get rid of highmem support entirely, and that day
*will* come. Old 32-bit architectures that do stupid things can just
deal with old kernels, we need to leave that braindamage behind some
day.

But as long as we support it, we should at least also have the debug
support for it on sane hardware.

Of course, maybe we should just make PageHighMem() always return true
for CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP, but I suspect that would cause
more pain than is worth it.

But yeah, I do think we should seriously start thinking about just
getting rid of HIGHMEM.

               Linus

