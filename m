Return-Path: <linux-fsdevel+bounces-65695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7AC0D049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC38F3AB2DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9052F6910;
	Mon, 27 Oct 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awLTh9r3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF462D77EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562158; cv=none; b=j/fhe2CSHOUaEWM6nrmu9xBV+N+pjSZJHFCIyyjhRo6YcDQZpRetTQWpxQS1iayY3znh7WZp4Se8U1k1FvHJ5Ut5KgwdLzuOpdT7zUGxyn1mgOOkOEjbIHKfGlO2ULjNFA5nNZiJKjhvPMBrrB4aoEbeyC9hpaDA/KistGKoHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562158; c=relaxed/simple;
	bh=rLaUix4LZIa8gNggPZRaXriWFDRflu8nYN8iDukEP1c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jecieu+fY0FjsG6JuBXNoJ7gIpXRlReCXY2Ex06SXvZmal4sv7sBr3AUXZdTMH8mNDFbZJdOZflygYUGqCg5geFsYWCq+Ruren7+FrQuFoFNQLbszUngdAYEv2b7kDE+v9E52r5CJVd3O7M0hfRSNoGTpwYYT0px9J5GNlBpnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awLTh9r3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7829fc3b7deso33405537b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761562156; x=1762166956; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgHGUo7vKPOLMFys7tnpJgx6l5wHevbg8X8g3p58eD4=;
        b=awLTh9r3AeZoz3wOuI+yl1r1hjB4tPI3F7w2nN3O+ZM9e62r0Z42Nkt+khvLuQzkXU
         Kg/ztDNsc7DO14gDYX3vqTmJNh2LdGOHbTZkd0U8uvEYim9s4VVcwBNdKZReIrJ30sA+
         G7cZ1GNOarUR9lDjNVI/o/e4FjKqyNE0tOe4YG1jYLMAayVRSz4tiV3FiHO1qNsEaw87
         zLm285/eGIFytYAl1Nk13JOwokQV7iAwj/3uFC1XkANg1fNw9VRsKB3GsN51xRsiZJnh
         E931hal//kiVGk+ElDdVkdS3+Yurj5ers+06JKnQ++Dn65rtciRuIW6qQKke/uNR0wYc
         baNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562156; x=1762166956;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgHGUo7vKPOLMFys7tnpJgx6l5wHevbg8X8g3p58eD4=;
        b=WgZmZdEX1EUYtXBtoNCc7mBam1m2QFITAIy2ZXnumT68tL5vI2PQGK5ZoJ9rWEh1FE
         B66EtcC7SProtcDltjiwxCDhQXTb/yU4l/3U3vix8N3d0s9P+YUrnlF6iTgT6AVQgNLq
         S7hREYEKN69JkH1JazyODBbp3Nbnk7V1l1sU+UubgBp0ml6aPhC6UtrpNyaksjWoigQV
         uWMoxs3eIi5wCHy7cPgmThJhfNI8n6ntU7eWTkInJv5qW1ub975CtWE/INJ81F93Kx45
         svv+gUGsiQ6Hb4qTpmIrDPtOYi3u9wnGKJsqmtj6ej2jJD9jU/NVMULIUrTGSC8W8XqW
         vxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUNAlZvswwjft87vkfXFNVTq+8315Ej3DlbFgL+E4SrTX4HSIPrOxJ074SfpPJogb/NkLfDBBEB/wLAZop@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/66z7VG1JpkHv9b0lxqcuJFCm7+lI9SRQpNX7by5N+NHLPcpT
	nsH09h1GUSACan3AIrDqq2LSo8MoTd2FuKQYVbXbyIUQ4XfEnOR5nTFM87QDtOccyQ==
X-Gm-Gg: ASbGncvGxsSrsBY0bZOhk8Z9KhNU8df/YmMysLumTw4bS8Oz1orruRmJx0y9NOBRR2Y
	1zJXbSTrySZDjoR+dS2ph2Q+IUGXSXPwsNT+ElurDiBlfZm1WJWlzihgetpDbyXUU0vUrW2lVC+
	e/TdYCoHLWX5OftVHss/pLqJQw2YkctIDRFupl8z2iqNtcrdnNTqHlRSufP69xGj81s6wXY++wQ
	QPY6L3o4DMG2AJ7sOWAycwon55NNsoGq+vIWFsI3pXa0VIBet7E2jJvklt3ZjJWzlwml2pkAicc
	QalOT/s86WiTFoFknUwN4FMR1NJTRxSvhtMLG4wjK1GVJ4xJzNC00tlN54JhMFemO1kDZ9IOSGL
	MTgwTtHRa1XjhzYFt1ZaK4fDa9zXdrCgAPBWUa3djjMDgk3TUCAb3/GTpbymq7CThoxojLhKWBY
	DAnaqZ3k+8rmgubKmahwHlm9KamKlFxAVkUT+q60XVrfQpInektwHPIQs7LtJkIXyBdW80NWY=
X-Google-Smtp-Source: AGHT+IF4G0GWxPrawsqJUunlI8mR7Zlz3Bdu/PVS/V73SpblujEtTUttzB5AMtvsR7iP+Kk1d5taaQ==
X-Received: by 2002:a05:690c:25c4:b0:723:bf47:96f8 with SMTP id 00721157ae682-7836d343077mr323894387b3.53.1761562155421;
        Mon, 27 Oct 2025 03:49:15 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1e84ffsm18025877b3.55.2025.10.27.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:49:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 03:49:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: David Hildenbrand <david@redhat.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>, 
    Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
In-Reply-To: <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
Message-ID: <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com> <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy> <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1022125602-1761562154=:3513"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1022125602-1761562154=:3513
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Oct 2025, Yang Shi wrote:
> On Thu, Oct 23, 2025 at 3:34=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.=
name> wrote:
> >
> > On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> > > "garbage" as in pointing at something without a direct map, something=
 that's
> > > protected differently (MTE? weird CoCo protection?) or even worse MMI=
O with
> > > undesired read-effects.
> >
> > Pedro already points to the problem with missing direct mapping.
> > _nofault() copy should help with this.
> >
> > Can direct mapping ever be converted to MMIO? It can be converted to DM=
A
> > buffer (which is fine), but MMIO? I have not seen it even in virtualize=
d
> > environments.
> >
> > I cannot say for all CoCo protections, but TDX guest shared<->private
> > should be fine.
> >
> > I am not sure about MTE. Is there a way to bypass MTE check for a load?
> > And how does it deal with stray reads from load_unaligned_zeropad()?
>=20
> If I remember correctly, _nofault() copy should skip tag check too.
>=20
> Thanks,
> Yang

Not a reply to Yang, I'm just tacking on to the latest mail...

I sew no mention of page migration: __folio_migrate_mapping() does
not use page_cache_delete(), so would surely need to do its own
write_seqcount_begin() and _end(), wouldn't it?

It is using folio_ref_freeze() and _unfreeze(), thinking that
keeps everyone else safely away: but not filemap_read_fast_rcu().

And all other users of folio_ref_freeze() (probably not many but
I have not searched) need to be checked too: maybe no others need
changing, but that has to be established.

This makes a fundamental change to speculative page cache assumptions.

My own opinion was expressed very much better than I could,
by Dave Chinner on Oct 21: cognitive load of niche fastpath.

Hugh
---1463770367-1022125602-1761562154=:3513--

