Return-Path: <linux-fsdevel+bounces-68446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E1C5C6F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639C44F5B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA9301711;
	Fri, 14 Nov 2025 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOY4qmsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1872F6567
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112513; cv=none; b=HDx9wiEZilkk9EzO7y9gKv35mskIfJj0EYUSBx05Ur8LyTak+eYDEecLFnyLfVUfvu9HQ/pBceaW7ku0U5I3koT1ZyzFJef78tYQYr5U1XcNTGS/dHIs8B0Z5ggKSb6bBnjGGa1p76wGLcATGSbvOPBpgLcDoDwEwZTv1FT9Dds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112513; c=relaxed/simple;
	bh=N2HsaVvo0KSEbbEZeR56wpGL3gW/GUIlv6yaZlxQ++Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhpPhLVLd6uIxPYPtLxE2qEoG2hCw0k6rWGtGlGzHGenufYWTmWoKQ1GnyjN7hl8xMlY5+ezzAguuQE3XDJyH/K8SVQsavp3DC7UZDVUz0DxViUKub23/w9xHMW8YtZwMylFBOcRybHGvMi2S/mLQw7BVZGkYnOYW+mWhQqzdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOY4qmsy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3123253a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 01:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112510; x=1763717310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdMtsLR/yBE7DI/ay1aYqX9mhRKvn8Ih43ILpIKpzlQ=;
        b=aOY4qmsyrAn331tkkY5sSZSlo379tqHRGwG2A5xcfT9l70PiBxI9dANnMKUPzRuElt
         pX7dcfJcV2cBbB92BoyK9H+EucsC6wSYribHEJ0VavesYBpqW8IR+4g1LN45kBUzKsnt
         9bszre3+CdceeAqKXFbwmg6w0uynebZ9xT92a0cLjGJZp7Nx3uRjbkAdrbSQ0pUIHllX
         kLRmcR8DT4RRJq99MhCmYqL20R3GDDY2Wa4dxnF7fogeE+Mn5athPbBdK+QmZta7uaIj
         H8+4A2N7AxH2XsKUtAoRiYNFqS35/7SnABy0kYhp9f6cJAZj8iJZZx7nY8Mlw7CRt3Rt
         6YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112510; x=1763717310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdMtsLR/yBE7DI/ay1aYqX9mhRKvn8Ih43ILpIKpzlQ=;
        b=GcgQF33xffBKuVQDX5inRSWQpu1IOPDyP+z0bu6Gv9z84pENFv/6EtULcXFasqtRym
         CymlfrcGWWCR68NUbhgcVX3UejgBT/hdp0QFLmDIL3QblE2BjibrKQHq0RM0ajsPejxN
         nXJxyIIqCfI0p8WBJgrn4ci9tIhxkskw9/dtFfvPEMJkJZ7RlSm1RNrFi/hdu8vZ/KjV
         sTxSMdjV46Nie2W7p0REagDnQCwhfJW3PqPOtfaEBnb5SMJrS7cpJ0PRZ0pbGavDPrwJ
         FAe9DEAEByrkN3qyg69UGtDaUk2k2JydeHFDCLNjtqw7mEpWBAKy0plOVDn9hROXCL/s
         vraA==
X-Forwarded-Encrypted: i=1; AJvYcCW9HelLS+LVvgyi47kdDjfMReHjjpZin9oYwjiKPzyJ3Q/2h7V5NSnPJEXU4lkDK9sIZnBXKXZ04Toh5LVa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcww1u+pVWBDGtIV0Vd3tlxhs9WQh3UYl6tcNwWz5SEWEspDQI
	bvKTm9PRcu3M47K7saipT1cyD3r4HwSbWqF4rckJKy6MS0Ag7h5zVbol0Vbubcxu1wLnQwX4KUU
	2h6dsQzB28f2HAi3sCEqKeAF3lziFeMk=
X-Gm-Gg: ASbGncvbA/oD18qFBOGTEUOF6ilzhBMW1XO/nmmg3CoyOFgaMd0ZGPMIqU1ePDyDXyk
	8fVf60XQuKDKHhq/qpbGRIEXsc4Po5Kcp1X5TCiSgsbf/DX3hw0VYoDnvc4Se0yZryVZenuEF8x
	sosGd6T+zili6Fatzw5KpDtHrby7TgaJERcUvvh87vBqNzKwbIMpOl6mL6sQrZGfzy7jeEkxU6A
	Vo0uXMi2lrkot79rDMTQreUXMhxA44sEhKCSbX5cGUEE9lAshprq4bgVBGb06Vk4vypcJnYPZIG
	6XBut/NAV8bexEanOXuRkhEjIcjtCg==
X-Google-Smtp-Source: AGHT+IEQn9wcqUkGIDv9+SWfVNmW1suJw4n4ETUx4HO3uhrfcZ4SvLzlbujzxBpT/QeYEKI2BB8t32Aqd5/pM7fQaTo=
X-Received: by 2002:a17:907:874a:b0:b73:6f8c:612a with SMTP id
 a640c23a62f3a-b736f8c6f46mr99527466b.11.1763112509488; Fri, 14 Nov 2025
 01:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org> <CAJfpegsdtHgiGFi5EEjaN9but0A7VTZA4M2hSg=Q7ynAozhqAQ@mail.gmail.com>
In-Reply-To: <CAJfpegsdtHgiGFi5EEjaN9but0A7VTZA4M2hSg=Q7ynAozhqAQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 10:28:18 +0100
X-Gm-Features: AWmQ_bmGihuGYGvIZV5ONblHyPajU4eus5nTPeVXJfYteHaXhQN19O77H7b7y5s
Message-ID: <CAOQ4uxhjwt7oKEmoumcf+BidgKNCp7yX57T4CrYi-OWx=+0EnA@mail.gmail.com>
Subject: Re: [PATCH v3 34/42] ovl: extract do_ovl_rename() helper function
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:17=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 13 Nov 2025 at 22:33, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > Extract the code that runs under overridden credentials into a separate
> > do_ovl_rename() helper function. Error handling is simplified. The
>
> Hmm, it's getting confusing between ovl_do_rename() and
> do_ovl_rename().   Also I'd prefer not to lose ovl_ as /the/ prefix
> unless absolutely necessary.

I was just thinking the same thing as I was trying to refactor
ovl_rename() to ovl_rename_start(); (something); ovl_rename_end()
I will try to think of a better convention.

BTW, we also have do_ovl_get_acl() which has managed to escape
the ovl_ namespace and has the same confusion with the ovl_do_ bunch.

Thanks,
Amir.

