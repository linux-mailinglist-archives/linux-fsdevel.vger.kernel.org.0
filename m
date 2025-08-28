Return-Path: <linux-fsdevel+bounces-59517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5BDB3A9C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8543AB4C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AAE27057C;
	Thu, 28 Aug 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Fphc74rK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F926F2AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405207; cv=none; b=fPCKFQ9C8LVS7tZmHGZn/1P40PAmnfacO22oTSGIIOPCco/RVgJKHiPLEgZl1llZgy1Ryia96LgJrKwIxVcohhhDwSFN02x4KZ53mTWAvzMHbFVdJ5g8Utd68m4lYHWFpuLDw0ATzFHABQ9rqm+KCsSwO5xftjq/NrGaXhZWPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405207; c=relaxed/simple;
	bh=4AK6is4nBJ4xlFletQWEvPRtDtC7sLAk86TBvPR0LNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ni6DTkKn61ikiL0MF/pScD5GJ3z1FdcdlzJ3vZ4empixHW2t5EDmMRqNxa73665diD2ic9X6z6E1n7swrOHC9alhoLQvI0DsJ9WICNZh+jCrXmaoLSiOPAYskwvMLNOXG8oe6v1QMQ9X0pMwms4N/2T5hiSgJfLD3+RzKaXVCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Fphc74rK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603cebd9so11638147b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756405204; x=1757010004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AK6is4nBJ4xlFletQWEvPRtDtC7sLAk86TBvPR0LNA=;
        b=Fphc74rKgUTzlTy2gxr6Pa/uVU/Ejb+mOhk+d9RpNNpHS1etEEeKmrgckavAmFqkOi
         qAUza1f7+UsuKDTsf9uguiIlW384bWRMlbCCm+PriUAqXsGv9jLfw/FcPwoda0OeCASW
         DL4i0Jjhy97eikcDtU4bgjHlMbnUuJnFvlsZksm2WXbrnxgjap3nNmiLCWAAi0y3aldw
         7gM2ncEg9u5VuZNa673JFnDiHMKrJnVqSQh31tQkdDVPbeHu5zGyvRgf8tpNPhFpMKAy
         /LezjCnQkuLYp/zLPWLmyC81Uam9OpWJ/wOhD1GkkLMmztPFWuGVigKvLmOU7HiY4CBx
         Ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756405204; x=1757010004;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AK6is4nBJ4xlFletQWEvPRtDtC7sLAk86TBvPR0LNA=;
        b=H15klmiUlPBiCrGMkldrnniEqoBYVfdMCsHksm+BP3efhTsUNuUcEZT7jnYnJXK1EW
         3mvBMQi9+kGDdRP1ZFv++CBlW2GfpciQLei7QhUvEMJ8zVrDg0XsyXxkc9zcokCHVtLp
         0v3tDaYd4AwsBVQOw/jEtsfRnhy4Vymd5IbhWqEEdFBYqX4QZWOh52jj+hFz3cBo87E8
         4oTmGmXnULf65ebJd4Gsd7aj+Tai//m1DUFYqnx44KsVdfh5Yr+lTOhTfoIMb2FdW6wL
         DcD673ubMjP4hfRVopGszMNdNN2jhSlGuHUwbFF7tFjC+ovuD3KhP6pJXHjRzYc7vUTo
         ULEA==
X-Forwarded-Encrypted: i=1; AJvYcCWf4FPSKDcbqKgBUjpKWKcFwgjZYidvCvogk74uOUpPt94P8VOR934zvU7jq9C36maf1ZVlfTvceaIREeZN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yEbrY3ICzHgD8K7qTyxfJsdGElmLsNne8P8U41lSQA3TY53O
	11zqEYT1umizZCQ9RNMkXBIj5Tg+lCoOZulgfsV3hf0cvH005tMyG7m3sp5G6BxrSXY=
X-Gm-Gg: ASbGnctmi4WcKAv0XIuhzDo88rwrPukhOiyRA4+KatZUgp7E8mgd0cgJLTMkW9naLHf
	ukg0N7evTpaT1dHm7iH2HKJof2nXgD2Ony34NZoyNKXeIx5tvtU2QF8ASnnM/33W3LaA+Q2UUFJ
	26nrqzFwSzxUmdTmxFNeTWgszS7m06ie4et0h5nAtUGRUtfpT3HeStNVBsqupb6N3T/h7svrlUo
	/02FcoIgKzw4+89A/C02FCOqjKoFbKwIryhmVBZt+qLBUaWYwBSvxcXe85MZgxJ4EAvOxUPxi0o
	R5su/kV6OQDmSQf5yOdVYvbyjTakrUi6jHtJNyXqUUH+iZvmaVyBXE0ldOOfQfDq+chQozVoHiI
	726QSF/jvRKzUOtUQmPvPWcvjrZQnaHI=
X-Google-Smtp-Source: AGHT+IEOAOhSE1G9xGVbfOyFmVr+k1ZRdTfzwWiTTet43dmEyPN9wlUJd3nRPz4Bn4Ls4/qoF5gVeA==
X-Received: by 2002:a05:690c:3707:b0:721:694f:f3dd with SMTP id 00721157ae682-72169503106mr24413367b3.1.1756405202859;
        Thu, 28 Aug 2025 11:20:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:697:39a:28c3:6906])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721ce5b72adsm1120107b3.51.2025.08.28.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:20:02 -0700 (PDT)
Message-ID: <45351c2e913498c2f7a535bd06ce6badeb74dff0.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: fix potential NULL dereferenced issue in
 ceph_fill_trace()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Date: Thu, 28 Aug 2025 11:20:00 -0700
In-Reply-To: <CAO8a2Sj1QUPbhqCYftMXC1E8+Dd=Ob+BrdTULPO7477yhkk39w@mail.gmail.com>
References: <20250827190122.74614-2-slava@dubeyko.com>
	 <CAO8a2Sj1QUPbhqCYftMXC1E8+Dd=Ob+BrdTULPO7477yhkk39w@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 12:28 +0300, Alex Markuze wrote:
> Considering we hadn't seen any related issues, I would add an
> unlikely
> macro for that if.
>=20

Makes sense to me. Let me rework the patch.

Thanks,
Slava.


