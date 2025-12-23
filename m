Return-Path: <linux-fsdevel+bounces-71977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1DBCD92E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B074230184E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FC32E72D;
	Tue, 23 Dec 2025 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCrlzvu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCB1F75A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492009; cv=none; b=P5WJnDRPP7sTqC3x2l51zycnJYjqMnnpUuEXmscIFbxUv++XrQTT0ArDSRx+aI+xb0NVbdYg1JmHoanQ9ttaKJfZ1NfLye9/JLDA1sYxOry0Uxe0MCyqjqM9MuCnSpUO9KLS081YmWL7wyIxM1X2itMyje7fWKCggFmFyYe8F0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492009; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uOTZtw+HCCsWJE0qc+Az7K/twcxN86MrWgkmAA5CDrlgfHRHzYoKkHdDBOBicfCtA0bKmrs5ixMHojSCIBlcUYWiOuDLycWNsZSE8mzIGzNm8JQrnVNhLCedrHL1TpJ39oSIkrMIkt1ROEu7crM3iaK6pru9GlFFvtcz/t7wuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCrlzvu8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b7b737eddso5752802a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766492006; x=1767096806; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nCrlzvu84fyGWI6tA9qgL00hK78NUvG2r9/eu4tINZXyZG2ZjTNl14Bi0zCMJUWUvj
         SlAyFPs9gO3+veimAtXbRfth9ROPX2atJ4Zc+5fObq4gKE0AeL9c3zWS4JzBROq8DZop
         TLs5ZtgqXG107R4vZKBO2GfzQvCskbMI+5D2Sk/NU+ufpeN00IAOlr14LlcDWfe9bYo4
         NimGGs8NhnnsiG8x44ogoGDE0qzaF6YHw15dYo+CxEcYOKUeztm/HHl5gN4SOnJlg0xB
         P+3IswvM8EkgRAjT/9p+zkrYY8ZaDSPiLHt9TDj9+DQkH7Roego9x74Mxe3mollMhI5M
         ZD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766492006; x=1767096806;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=mq+hAgxinc45e+rTA2veTD+mB2uZhxiz1Lgyec1TsCypF0sqXWG3+grkafVwljEz2k
         m83BvtkY60ea0h+nFN9dwPNAGlDI3Bx65kfySrwuwvKl5W0qIa7NMr7BXzgWtchbuP2P
         qn0uTAQCq2sMPwG/GdfCbAhgs293hlgL+hOUpRueCPeow/CyI96/zuN9LmmoibHXuslU
         f/mZ/2vZinAHfkbP0UZUgUZ+VYG7q+ume3kJU6kiuV50OgzDMbKeQkp5XaJRVtPHdiIq
         CbWqHOwrWm6yn8Kw9/G14jLkzCD9t3sAEA2gvzC1xDAQSNoxh3ynkUE0YXNphEOpAMHB
         7k9g==
X-Gm-Message-State: AOJu0YygoSJ2goScUKphyYIfpBmqVLhEESMKwttB6BN+wxZRBlwibimZ
	WFk1zlUJcI/KRdXyzXNIfOPCZnRHkL3OzsCYe046rT5TVbqmLoqD899C2mXvD6vPrf93oPB9ao4
	iMxOcSaCWcAYVwGPGumQiK+hdXKtKY0Jp7s8C
X-Gm-Gg: AY/fxX54gXDxZdjVSw+hzGkPgYTmIEMiPmB9/jC6ptDRt2iVHJqTGld4vwcVEFwrA2r
	O59VQJKPhaywO4K3JX8LEJyfMPckzC1KmVKbi9jZpENb0l9h4zoQgfoZLs18MtBGZvCTqiziMEh
	dZ5jPUasTCEyKaKMmf3oZ6xbNvkfMEpESYW9ZGl5oCGWcmP55PLeTWRVKNklFIyIlrD/9jkqpqR
	+lxm/rs7UKTzu5VedItJyQ1hMPuxXuGsruUHTT+e6vXkn9Pl/ce/SwSQN0LV9KvvY0/lWJXpG/Y
	Pm7wgZvH
X-Google-Smtp-Source: AGHT+IFOFBf4I2Dr/SPcFOFXEuNRaF8GPfjRWtfFDmRqh4tVoz5yQLVezm6eRBjwNEwhUjDswFBgCL+XH56Tp5vOCjQ=
X-Received: by 2002:a05:6402:1461:b0:64c:9e19:9831 with SMTP id
 4fb4d7f45d1cf-64c9e199bd0mr11580914a12.12.1766492006276; Tue, 23 Dec 2025
 04:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gang He <dchg2000@gmail.com>
Date: Tue, 23 Dec 2025 20:13:13 +0800
X-Gm-Features: AQt7F2pjv6Fr4gagYH8jSk4FAHqjHNOVIYmTMYRNcIEZncMk4VLmAiDMbjOzERw
Message-ID: <CAGmFzScbRixHLi6+eMAvbkcu0=OEbB5pFKVjsr4foPf5DkB+TQ@mail.gmail.com>
Subject: subscribe
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"



