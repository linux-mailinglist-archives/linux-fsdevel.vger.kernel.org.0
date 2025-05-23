Return-Path: <linux-fsdevel+bounces-49794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3A4AC29F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D8545892
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B8929A33B;
	Fri, 23 May 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/dt6VsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6729A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026305; cv=none; b=m5l3z7ERX/F9/QIPXg+3DlRwloeF9feKFyvxiU7UEqbLsekZsLzzOIM8qo1LveOUs7JXvlbhpNGxRwVIvBtW2FFpnqLPgJMGP9rp6FNixh66W1mPVxt9qwimLazg+whbvNxE00HwteYcYZnliEO47YrbKLq0Xl8i3hn+b6jrxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026305; c=relaxed/simple;
	bh=ifs6tn/30V2Pfs1zfaq7dWkxluG4y8VkaziGb86+86E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU/hiflCR4CU4kvLZjzI/sz6+9U+XErmfo3WrwG61KOe9FBcD1IzB5bX5OQ2OjUmfRd/e1R7YzcCSjyx+jPW6A5j0FDMu2fc+zWrlJ8OiFFMAKxxSUZ9Qa6AOUcOXI4BxxSGtbbgN7dBSTfpqyJetvR2a2364vUGIxXgPPvmEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/dt6VsN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a3683d8314so165271f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748026301; x=1748631101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Ce0K8lonTa25wr1sYykDmqdHG1jYf+mgl4cgI9fAho=;
        b=b/dt6VsNhBs+tB48S3xErsVSSFqz5G9kdTOpdGz/nQBsIGJv0KIqL7GVbh/v1phuMD
         79tUYHa3oHOSMlHXqUHmldT9YnempaIL+OGojCDmydnUntysVlIWiH/6Ym8vpUh9UTtc
         Gz51xxo0ulyEnbi6SN7juffNvWlnccMRF/GaC6FD1plXpWrTOgWtg5Nf2TcNE5Bm1OCS
         aeG5tu/Gm0JTIMPhDIKaqcbhMyFQ9+FzAU+iJRLfLk7LXoE8ao1iVLxC3dZvhm0L4Oew
         57H/UopW380/zWjQ1O+NBNNKcCECzBqqxcagACmIJAgNLVRqE6mPCJDK4BpQfb4rc3oy
         808g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748026301; x=1748631101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ce0K8lonTa25wr1sYykDmqdHG1jYf+mgl4cgI9fAho=;
        b=Yt+lUnqVyO3UbSrAZThHeYTdDv1PUs+QwnM4Rp9EQGWsIu/v/f8U1/eHE/NaVCXr2r
         IkhM4XYX2WajdGeS7g9ElPYSKw8qmtDHmQ44GB5LUKPsIb5vMoQEs1yhRQ43Iq59Bkco
         0IdzCTQWbGUzlv6It2PLKYDO66oQKkxrwh9zNR92SbyBqVj1jLNIORLDYgR+pL5ty7Zv
         /x++ksGa5XLfXBYFeCUs9vj2+pksI0TY+L7UguPLxNJRC/RDNfbudbTneB+UuFpvtijz
         Hh60V0eoa/DMfVhafGswpv8rFjj79y5EcQH7utSGSVPWHx+USw/Tkm9YPbHh0s4tVwWZ
         J64w==
X-Gm-Message-State: AOJu0YyIfj9F4HL+WP8fbExUO8TRBLwdCo8gxx64NuGvoiIpqTE5un3I
	Xf1YjNcd5xHIrWpnpxzqrjuJvRHgwdEdJyvMQ/eQcQJydf6ZKbhjaQzfgwN47nU0Y5k=
X-Gm-Gg: ASbGnctab6sO+Np3TU+kZrfOQwwGlC2A/lMs7LaYoujftdcJ7mwzs1DaJ8TVd9VAiqF
	8r8ozUezdahzhbyOFuOmPmo4nFxs26F6FHYjaywPqjisDyjU5bEFE+TVkX+DkapwepD9xonNMns
	EImiGx13KXHqJMu04hkT0KRpLSIRFL/9ehehypElQ0+vBJxQQec29CZn/SNk5MrUd9t/Ce2ewHT
	opuX0zmqgL2ip6LBoYb72hncy2UgETyLwtou2GXscTSihSqjGbiu99c5b2x0d6d1oebJXg/T9yg
	61dq8V9Xa5PPx1XGsVnVkcxvULPId5VQjCvqnVwNFp//iR3QVYkSNV1V
X-Google-Smtp-Source: AGHT+IHeg5lATAZ6DYfMLg0wEeHxkiGqm6iwKLQzFFfGsHEfr634CN40TrP2Nsq/U7LnNB/WpC+xCQ==
X-Received: by 2002:a5d:5f8b:0:b0:3a3:7077:aba1 with SMTP id ffacd0b85a97d-3a4cb4c5472mr287070f8f.48.1748026301306;
        Fri, 23 May 2025 11:51:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-447f78b0acasm146711125e9.31.2025.05.23.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:51:40 -0700 (PDT)
Date: Fri, 23 May 2025 21:51:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fuse: support copying large folios
Message-ID: <aDDDuMjF55MV-EZo@stanley.mountain>
References: <aDCbR9VpB3ojnM7q@stanley.mountain>
 <CAJnrk1ZBOw4RwrGRZk8Qd+vDXUEF=O9NC-TSpS3Cs9rhNDAf=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZBOw4RwrGRZk8Qd+vDXUEF=O9NC-TSpS3Cs9rhNDAf=w@mail.gmail.com>

On Fri, May 23, 2025 at 10:32:29AM -0700, Joanne Koong wrote:
> On Fri, May 23, 2025 at 8:59 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Joanne Koong,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > Commit f008a4390bde ("fuse: support copying large folios") from May
> > 12, 2025, leads to the following Smatch complaint:
> >
> >     fs/fuse/dev.c:1103 fuse_copy_folio()
> >     warn: variable dereferenced before check 'folio' (see line 1101)
> >
> > fs/fuse/dev.c
> >   1100          struct folio *folio = *foliop;
> >   1101          size_t size = folio_size(folio);
> >                                          ^^^^^
> > The patch adds an unchecked dereference
> >
> >   1102
> >   1103          if (folio && zeroing && count < size)
> >                     ^^^^^
> > and it also adds this check for NULL which is too late.
> >
> >   1104                  folio_zero_range(folio, 0, size);
> >   1105
> 
> Thanks for flagging. I looked through where we call fuse_copy_folio()
> and we'll never run into the case where folio is null, so all the "if
> folio" branches inside there can probably be cleaned up with a WARN_ON
> check.
> 
> I'll submit a patch that fixes this commit and a separate patch that
> cleans up the if folio check.

Another idea is to just crash when people pass a NULL pointer.  The stack
traces from NULL dereference bugs are normally easy to debug unless
they're caused by a race condition or memory corruption.

regards,
dan carpenter

