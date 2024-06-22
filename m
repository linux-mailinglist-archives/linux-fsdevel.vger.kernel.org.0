Return-Path: <linux-fsdevel+bounces-22184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37869134FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86B81F22A18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618316FF3F;
	Sat, 22 Jun 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N3QOZgcj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2A16F286
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072560; cv=none; b=ZNtjeSq8tLEqDNg8t8cVdjV0Gmz9iKQz6QNY5rgvxTmNVmkS1Y00To3cZeFAqPGNA5bgT0ASE9mTtykdGtJ9Abi2rozl/j1lc2m186MgYRPe8QV7waUXE0oXp6rEcReJYhBdRmqQGji18DJMywlgGiVUh3wyxVccpy138j9uiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072560; c=relaxed/simple;
	bh=7oD18kfo9S+9Xuvhrtu9sHiM+uAEubp9xCH8YLvvgt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHNBntcSk3iCNgcWHCBu3SEpgrAARquDQJpqXHchXzlA6eoDtMVjj+SicIpme5sfZPm0KpSmmiN80Fewt17u1hH1tUWYba/fGFuhsgpOj8LVFoN6hOWoxyoLWCj6czZUMDvUW8CXUJztwkdi2VwONm9uYXK1rV4ojqSG45qmeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N3QOZgcj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f09eaf420so342027866b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719072556; x=1719677356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhxsWEG6wVUdE7DyqH5OsqefkRs3rcLJSmwisp4Ylt8=;
        b=N3QOZgcjtoNGB1yH5FEmauwc8sssfJrHypFPxAs59piDo7BUC4zdEIUT2wjO6yUaTu
         2DEoRuuGGEGyRmg3xEwPZFz2Gqwkl8/mgqRxOmZF7rQKpUlZEAlHYg4Ra/fmPRb36LLn
         czwZrUu493jK2b5PxRDUxrPeKwT8VYHBz5noI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719072556; x=1719677356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhxsWEG6wVUdE7DyqH5OsqefkRs3rcLJSmwisp4Ylt8=;
        b=VJhsU0lk7Si8tJ9sLZW7598auqdtCI1Qz1f85WvlQUFhzOY/pd1EK6AXd2SDDaFc+V
         w20A+VvyRPJHzn+wEz+/P/TjIkwy2RPgftxCqf4KMSWypXYBHqkwN4rRcTRvIaBNTWij
         Jdmy+GCYW/qFXN+o7fWfGaJrRmOq5of9RWUJUA9B1O8+tN9FwCsJu62Ek4n4wWp9UmCq
         morFVnDjyiNaXDNNjHHyWKs+cS37/Cr/A+AMnU5kRuIahI1kL2Kukyyvlf9D48G+c2Lp
         S2dW4M9GZA0O7FJJAW3W2xFQxA4I2aLnste7jd2xYRIsLU0hHJ8NXuA3izBaFLscQpaP
         J/yg==
X-Forwarded-Encrypted: i=1; AJvYcCWonDhBsLT0qOg3edks4h+jqdmK5Asxx+ZisIwaZ/2d2M8U+XequIICQy5j0Bey1CNb4QbMYAC9tYUx8oIcjyF5BB35WbVjDEtM1kZF9A==
X-Gm-Message-State: AOJu0YwAwjXBTxb6Z4/H1TMdcNh5f4X9JKbRfSpOMmVOE1iHrNZ363eq
	I5cmYZFb6lwtHTBKkO1iZBWh57oEYWrQGXDh1g1WNJP78PGmjLX1KFiOxmHaZhOMpA9N/Akb+La
	dXMpdpQ==
X-Google-Smtp-Source: AGHT+IFOvbLvFs6g9CdNTWcePr18FoCD1oel5IUJgAGjp8204Vg6VxlyI9Si+Rj5pssB9CJMRxbCDw==
X-Received: by 2002:a17:907:61a0:b0:a6d:e0dd:f7 with SMTP id a640c23a62f3a-a715f9cba1fmr77929166b.52.1719072556598;
        Sat, 22 Jun 2024 09:09:16 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724491c8e1sm19780766b.38.2024.06.22.09.09.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 09:09:16 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f0e153eddso369386866b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 09:09:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ6VEmP/y/J2FTUge5eZShp2izxQeps3hEL8U80JNvK0iwjFHLlC6w+0DlDg8d2lLSaD6veSw0BDXs34x3ynNbD72Rc8MDMizz/7h4VQ==
X-Received: by 2002:a17:906:ba8c:b0:a6f:ad2f:ac5d with SMTP id
 a640c23a62f3a-a714d72c2b8mr81567666b.6.1719072555785; Sat, 22 Jun 2024
 09:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240622160058.GZ3058325@frogsfrogsfrogs> <20240622160502.GA3058325@frogsfrogsfrogs>
In-Reply-To: <20240622160502.GA3058325@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Jun 2024 09:08:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDjORhZtww-_584JFSC3esGAeZZ7eLWdbaaEOUfwqSkQ@mail.gmail.com>
Message-ID: <CAHk-=wiDjORhZtww-_584JFSC3esGAeZZ7eLWdbaaEOUfwqSkQ@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: bug fix for 6.10
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 09:05, Darrick J. Wong <djwong@kernel.org> wrote:
>
> EVERYONE: ignore this email please.

Too late, but I have re-done the xfs merge.

               Linus

