Return-Path: <linux-fsdevel+bounces-60041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CBBB41358
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E012D1BA04A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61F2D3744;
	Wed,  3 Sep 2025 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOQtONCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778925A321;
	Wed,  3 Sep 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872059; cv=none; b=golNxAZOM4W++WLGbl12gtiaL8/EAK1Ha7VAGHv1rQRukYdixZ9nhWYcCpndK1Rg/lu5scW45GmILLv6jlFL98v7XmUkS+9StXpjVQMov6EtG4caS/VZk1sRrAyHdJraSZs3gHKopGA5cV5tVyjT2cRaLYUMQkazueLEYo066o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872059; c=relaxed/simple;
	bh=6UR9ejdf4VPdId/kJKjtTmDnIcSf6XuqhLcmd7IRW2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9HnfWoXYXlDC02p093VwcT5sMVFCuY2tzL5DgioX00+RMb1GapiewgXVIOvgwGHb/8eQR05owkbRMPUTNIT0yUw5Y1r27mojyjF14UxBzrn4f9JNCP+PU5mXs9SkqcvDI3JaLR1CxFURNn6ovp20bAVPeibCGDUzbmg77QdR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOQtONCM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77247e25a69so269092b3a.2;
        Tue, 02 Sep 2025 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756872057; x=1757476857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRg1H5QKeFRVFkhJ6WwioKBMmTGdYWt+yD/4+yi4RdQ=;
        b=nOQtONCMQdTSS7hWMvZRr/2oSmmfoq2jTHR5/s4ZiBkNoR5d4+esBGJ/DZ29NL69MP
         fqukMv5vaHmOrv4EyvWvUgifiKBQ9ooAelTu8pxqj45CWVk0RwI/BqlLnzuViDCHN0on
         stcs6JG56jN2xcVT6tNRnqSuEmFSUoVb7cPTcRSOseA3XIpNaRw2bxdeluVp92NiQQNG
         ylFvQ/7muIFsmjAChIqWn3ZkJawsIOii1A7Cx75VA1o5IdD5sgI2/DtM8gEicbqHvuc4
         eCN98dqvXHMUhlkb+zUPY3R9gM4BQdMW0U8dQExNur4WvcEzjh+BOt5a/9+/U55hgZgZ
         6Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872057; x=1757476857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRg1H5QKeFRVFkhJ6WwioKBMmTGdYWt+yD/4+yi4RdQ=;
        b=fU49C4IOLaOAvegpARLvdOeRV8UA42i3Klr/JGjDhQN+uM7nRnWD+b9NhVUKGmyQ6S
         ZYWPsfJmfg2Wx6mSoyHGnLxoe4wCa2jx7Hny2C+cSmk30Wqpdm+rw6Uz2rCQMeaLYbgN
         pHf+TFPUAXfvpGAvRe/+YFrm90G9nFYdSFnRDqVnw9pRIMx0V0cx792ob+dZDvW0PLUh
         32dx8hCXmeZGMfvioI0nxvBM4hVskYYRc8iehHlMfVkV1Hip2ok7r3yKKuxZl/llBK6C
         2BiFZB4NvduWM1ofgeDfMr/m4Mru5FUIsjb+067C/6SRKC8c4eSvrKFvHSCJu/KbwT3J
         c9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq688Ak0ZbFjwGfYv80RNzuLW3DfkpVCAxfDVHOnuic02VvnXfS4z7Z3SvqoZikVRkxvK2@vger.kernel.org, AJvYcCV8v5QTm7CLJ9+AbT+PFjW0OkA94T2gDMWdr0yZ6Ay/oiPIkT8iPAKddhT/Y+CQigZRDG3CoHDWkabWIsZ0@vger.kernel.org, AJvYcCVQCXNLoO+UfgRhuTkpcQ4QMpzTqCHpeEz1fs/PCn+koi8v39SJbdm4NhSc03nLirFOUjm+craS2ZVz@vger.kernel.org, AJvYcCVfwiy893ADKB3J1WG1Ahm+dWrPV4ZSoguKpyhtcieFOLndVrxzdWK+UhWwxlQhYNwMzFz2XplWHkgs@vger.kernel.org, AJvYcCVfyYapbCj31D0gNFVw5Zqdw8wECFAwNvGy9rWY85YZ5ONq9FJEbvnra+WUbabD4YL7uLwMZqGORGeZflUykA==@vger.kernel.org, AJvYcCWWmhCaCYwhGCBdDynmmtWF9o2WbsM2ueRDm402aCugF6OTogXnNFHCy1WHhSplPvKOQ1D5a+4F0UZX@vger.kernel.org
X-Gm-Message-State: AOJu0YytaUN02DZht0lv9LhfUuMSQys1x6pb1qjmgmll6znz2STtNLZp
	TM4vm84YWI6zjtp7Txs9deWL27QAq8ifhMsV/gER+LvScHlBfP8HyMMc
X-Gm-Gg: ASbGncuem6/ENzIMx3cuIiy+71C35YQebw2b3LkNaxhUFx/543fXwhf77RnBILEa6jM
	btyyL0A37bZ9LD76/LAJ+oObWNFPSShByl+8U6V9HZRrHKmNLALQD9tiQHmb4T85aoofyBnmOPG
	6j6j8cDUTY6Y1enumLUZMHNRC/Ekk6vGSCm+fdn6/fzfobKWlf8WxB4ttTUw+vwDqr7XD4Zusmd
	UQF8whVVl6NHpUgpE1BXj1WiS5xw8pr+93vWEedMNzMMH69h+AeLFW9cTcd4uR8dpj/dwt63cVc
	ZDpTP4jxUeDmfvcZyl9qRoaX2H7jrJYVws05X3kN/kYAc/qsANQGGL+3GiAm1SuLBEmhLYV1aPQ
	mHDTD02pk8xluIOYwFSsqt+vXwJVBPwwPnLT/6z/tPiD8zY9LUA==
X-Google-Smtp-Source: AGHT+IE90pfwfxg7f/fDuh03cv7xCHKmMMJxtPjEvyUYKYaMHOvpneeXe9lal81BrPks03fBQxlqdA==
X-Received: by 2002:a05:6a00:807:b0:737:6589:81e5 with SMTP id d2e1a72fcca58-77232745936mr12138992b3a.2.1756872056706;
        Tue, 02 Sep 2025 21:00:56 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:c842:443f:2e7:2136:792b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b2f56sm14970241b3a.26.2025.09.02.21.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:00:56 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: rdunlap@infradead.org
Cc: brauner@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	djwong@kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	kvm@vger.kernel.org,
	laurent.pinchart@ideasonboard.com,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	pbonzini@redhat.com,
	robh@kernel.org,
	vnranganath.20@gmail.com
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
Date: Wed,  3 Sep 2025 09:30:43 +0530
Message-ID: <20250903040043.19398-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <A33D792E-4773-458B-ACF4-5E66B1FCB5AC@infradead.org>
References: <A33D792E-4773-458B-ACF4-5E66B1FCB5AC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On September 2, 2025 12:59:05 PM PDT, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>On 02/09/2025 21:38, Ranganath V N wrote:
>>> Corrected a few spelling mistakes to improve the readability.
>>> 
>>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
>>>  Documentation/filesystems/iomap/operations.rst           | 2 +-
>>>  Documentation/virt/kvm/review-checklist.rst              | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
>>> index 46d0b036c97e..191085b0d5e8 100644
>>> --- a/Documentation/devicetree/bindings/submitting-patches.rst
>>> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
>>> @@ -66,7 +66,7 @@ I. For patch submitters
>>>       any DTS patches, regardless whether using existing or new bindings, should
>>>       be placed at the end of patchset to indicate no dependency of drivers on
>>>       the DTS.  DTS will be anyway applied through separate tree or branch, so
>>> -     different order would indicate the serie is non-bisectable.
>>> +     different order would indicate the series is non-bisectable.
>>That's not entirely a spelling mistake
>>https://en.wiktionary.org/wiki/serie#English
>>
>>Best regards,
>>Krzysztof


>Obsolete.  Close enough for me. 

Hi,
Thanks for the response. Do you want me to resend the patch by ignoring this?
particular "serie".

Ranganath

