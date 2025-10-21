Return-Path: <linux-fsdevel+bounces-64846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3DBF5AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897843A672D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7B2F6933;
	Tue, 21 Oct 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="T9U0jcXm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130F2EFDB7
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041147; cv=none; b=TjDZU1fXMguaCDh7YGmTiSf5cUkSVR5YbjRpPvtsVLZSJ61SNCFRwObP2FrxC41ref4m27vpoYREw51Is67P0iChRBchG+R1MMc17NtJ4e/dpCDLj/OL2r/bJT4KMHREwaXgLQEXqf3meABTXEETzWCt2/RCFFFDGBO+VeP8VlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041147; c=relaxed/simple;
	bh=jaVkAirR0FmCZS77OVai7LTti/ykTW+yoJdrf9XuuDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIyoFL+GrIt6jhTk4C0Y4YseBs0OD4boGA9osXLD7XFHRrnk7X2YHPlvYU94tBYPF1UN8IaVwCaa4Dgkd6HoOEaCyonI5rtbV1UCd2q7o+PQ3ZJ63AvWclu4RN5tILiJsqwpakEmFiyTfhxr04NLQh02CcnywhbWE8G7YopR+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=T9U0jcXm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55D663F67A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761041136;
	bh=c1ts8PXtS2olZu/L6mVobSQRZT/IAL3tt43QXl+qe7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=T9U0jcXm2RjrkFn2OXQCsV8JiXXFjlr7SBacEiyO3UD7jPfy4BphwmyWp+Lxobi15
	 SpwaZYhjtJQSPhTCy0H7n2ci6N6pwZMRKnPVi7O4T1Xv7w2WF3zEEQ7mwTRBPNZulz
	 9lKhq2isUT6ZtMwwaO/dYCPN8+7rNll4t1unr+uhDJ3DPxATag4GcadNSQUqqijtv0
	 rkpZkmzLSFqzh8ur93rlGY+GbpRdCVI30FTaqi/md9x3U6RbIvBPrnDzt5EMv9EaeE
	 19wYbWH+zv2tLpAM0t+yWR/4vs+aIH+qs0tZj0AQXzTeTPtD+BiaKfN46hXNn3io27
	 5FEKFbE0QhqgIXcAYn/4klp0AlVfAXzJIciBjvoH9sspqqZeh863LkX30KUObmZZ9V
	 lEym+AsIlBGjkKDhbJ2OgKSSgTT0o+j+BUQlmzj1lW0oNWVducBICWxm008vQzKjig
	 YjBHX0iVGWR2pRwJi4fj0yP0U6pIokeLpiEUS7ZPmtaD1ytbwALkP0CaBxU9Npxq21
	 SdWCVWDl4EZMbRcFLx4Bc8uxM2RfMxOLXW+N1fAL96ty1YTNU2cN+EGRE2b/smXggr
	 1KQoC4ch1QI1B9C0WemLT12kG4jqAOR+7Du/eMb3nL+CLBhOoEPEUhUxMuP7Ywk2hc
	 mQUmxaTyuGA+zleJrf/gokU0=
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b5a8154aa38so620334266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 03:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041135; x=1761645935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1ts8PXtS2olZu/L6mVobSQRZT/IAL3tt43QXl+qe7c=;
        b=FnFvBYTZHn+RUksSPyR6cDNZ4I2kR5menALXU1V2YpnUuYbu3WLHK5QLKb+kEJXSnt
         8snLFH/Y2Wj9KVfUO+kTDwfcyaP6hkXbUQBIZ2Vv3/09iKc3WIDJE5dQivbpHryvVt4E
         TQy2CANQI2MRiH8XnVWjdQ646yNphn6xp0gapNqnmmTfzUU65UAGVN6fTmQX5vusoy15
         73hzI9u2cbx4VtlzUQWhqKih+VfZ+5JdTi3trK7n8xbUy+p1maN7hWdkHnkrXelXC1b9
         O1ZYL6u9x/Q1l2V2lCWG96pIk6PxmXbc4twzgiK72uYTQjXIHrDhLmZgOgaWUnxlXOk9
         111w==
X-Forwarded-Encrypted: i=1; AJvYcCXBhtT+3HLNdZW+oQbl3LZEf7Wo5I4uCPGMrJy8QFBx6nUdtrP8uy/tBf/B/sGZcSktYey4Ggqzyj16KH46@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Vd0OtQJFFx8A7JD8Ws6nPWyZMq6ThZD/5WVPhtLEvZyBOTe5
	TE5jeNOIyhE3M7lKQ3CM2ivOg4w69OTeXA9bQ6winigws4Z3cJSN7m/1bKE0MV16mxAcxf7YA3O
	haz3te18Z5EzcNKjBoE+5pqxAuF8xEJUAZCyZ5q5UbgRPHvMxLou3ISHmCYZ5dObN9ruDFhXMow
	ysx9uA9IopeQdCMZ0=
X-Gm-Gg: ASbGncuS6XUDeW3BgNbYBuABt5b0g27F1SgpDTfZ2IQpXn6ylMfCnhFomJg5YPklDv1
	R/EvFaHUu4erP8erqkvkr4GdOfFeeHvQWa+jrZUJwBtUpe3NFpmwZ2dXeWNl3qsXv5gWmSpXVAJ
	XydSgeOq/jKCzf/+VdURrJ9prN61zsM+r6YteJeqdXqMVTVLeJMbyvZFl4KreDp3SAHhnQfIKRD
	NTGg2aJqEvkc/eTsTetMvo73lEzaLBPnOPkDhecze97Q1kzOZ2TFi0wmpBAsK/WkOvUg0MuYjCF
	ptmPX2wcaazmf1CgF6Jx4q04axzdfNz503OjrJ9xBM2yegsYBSJsP/HLxPSfNk3sJTG5NiKUdIJ
	0+ja1Knjj2syWKOgk7HeqNXLamSvqdVQiaGXIjthp6LyrtVGVMAoUGPiR4CGlSZSYC+1okw==
X-Received: by 2002:a17:906:d542:b0:b3f:8210:d058 with SMTP id a640c23a62f3a-b6475ff51d9mr1855455666b.37.1761041135411;
        Tue, 21 Oct 2025 03:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjc2a51p2Z2MnX9SlwQilpObLG6dt2t1PcdcG/dMOD/6t96UuaKVV+Y0RPg+CdCoZvAZFJkA==
X-Received: by 2002:a17:906:d542:b0:b3f:8210:d058 with SMTP id a640c23a62f3a-b6475ff51d9mr1855453266b.37.1761041135021;
        Tue, 21 Oct 2025 03:05:35 -0700 (PDT)
Received: from localhost (net-2-34-30-56.cust.vodafonedsl.it. [2.34.30.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc42963sm1039664466b.77.2025.10.21.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:05:34 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:05:33 +0200
From: Alessio Faina <alessio.faina@canonical.com>
To: David Howells <dhowells@redhat.com>
Cc: kernel-esm-reviews@groups.canonical.com,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [SRU][B][PATCH 1/1] afs: Fix lock recursion
Message-ID: <aPda7Q5EvcabyS8c@cicciput>
References: <20251020081733.18036-2-alessio.faina@canonical.com>
 <20251020081733.18036-1-alessio.faina@canonical.com>
 <1475047.1761040626@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475047.1761040626@warthog.procyon.org.uk>

On Tue, Oct 21, 2025 at 10:57:06AM +0100, David Howells wrote:
> Alessio Faina <alessio.faina@canonical.com> wrote:
> 
> > To: kernel-esm-reviews@groups.canonical.com
> 
> Did you mean to cc everyone on this?
> 
> David
>

No I forgot --no-cc --no-bcc while running git send-mail, I'm really
sorry for the spam.

    - Alessio

