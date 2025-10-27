Return-Path: <linux-fsdevel+bounces-65725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC64CC0F1B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49D8F34788A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DA3126B3;
	Mon, 27 Oct 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hHnjVK4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9030DECC
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580445; cv=none; b=Xlo57eCAdIj0clfdUp2BQ1ij6Pof3y2k+2D4A5X+nP5WmRR/ckAjdt73vR4CHCqz0u8xKOzykEYBTYk6JBCRsV8IFib0xJARaA0hYDFRSuSR8vrz6kNOU3fUDpMaYcfVKrH0ypnn4xK8ehYYyPtu0x8Yyiav76ZHcVf3GRgNAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580445; c=relaxed/simple;
	bh=3vakKTarVQ1LmVyja0G1VxJygmwKNqNAyvUgHSG/kHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReyutVz0XWz7eSb72rTBr5mEWG8LUcDV6rvZDSP5XU3m0p9d6VXIIGtyXl3JmN1bw20n2PLuO5uIwVEK5cGidLKI2qtpgrBYoAkThKXPb1k495GG2I6T5KicopfKgkuCa7J/1MFx5gEeEKKVRVJQJCeZXfhavwKmjYni79kDzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hHnjVK4/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d53684cfdso1083347266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761580440; x=1762185240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyo3P6jUrO11oV/07r7VEk3+sHuM/zfcTZIIBqJLkxg=;
        b=hHnjVK4/PWBn3uJqhXEg0eWymnNQxg1/J89O3WyZtYXQy2URv35gz/tX/1Bt1hjPUL
         vHFF+9sup0RXq7n9csAH41YV8vnvgY9bbgIULvbWIzcNFC+KvaE1KroyASsW0qewUjWi
         +JQedoiLY1mzNuYw5hTaCtqRGRV1UAU5GwUAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580440; x=1762185240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lyo3P6jUrO11oV/07r7VEk3+sHuM/zfcTZIIBqJLkxg=;
        b=ZIJLpCO+atDy83TupJE7l8W1DsmouZ80RfGr5AwXoRJwAJbIO0tk3toKuTxI2IMWrv
         Y8Nsu09Wqg9hmccZh1jYRKNNZiSZnRqup3XZJID7xEt/UKhgyL9pVGIb0GoxfOELDCpp
         4ZsDyxbfpSW5L7SJ4jpC/L8DFVXwj+6cGjo9p4m717KO4T7DB+zFlyZ3iWiKqHqIG80b
         gwFxQgi15/zXTRNhwWKeJPY6a0SGx8U6horf0evvwt8CFtDpHSorav+IvHize40wskh7
         tHjNEeRSqxBidNAGH1zSzBmzCehE8u7ObdAZDTpXYwrN387RI2C2Kgu4g+Pzx8CIrTS2
         1IaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoAOlpqMdgSOeIt6zPt3lN46CFDWvNhOQ4YXXHIfojNJoVene8aW6LpdskvomMjhJtAv534NkMxWHjtczS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz762sEodHcpmQxbvTsybe9ZruwUg0EM00AN6aKnWu4AuICwIdC
	xW9fG0larcyofR8GFDSFc2nOcPcq8jG44a2qXJWfTzGAtzfJh6i0Rx/bqq2L+80WzBJ6YvVpkft
	Eg4tww0U=
X-Gm-Gg: ASbGncvEfDiriqwRgCR/uhwdXFp8NajHnV6azNYypgJ78zc3BqiShZY8TGGpQiKDHs8
	ZQvd+kWKTQWW5yYzo3KnIlN/6q/zWhEYd/faovCe5xtA1PiW7LJ5ySRhAuOUeh7SIulHL6lQnOj
	8O/E1sexQGBBfBEFMCSpbNdNfKFzfZNGg2bPFUSkSTgs90J9eHQfAz7pBxwRpu0CniwFDByMbjF
	HlgNlPE6dUqm+y8TepKibW5jQpTr1xfisi6Jc5JqWV3gaTJZCWbnbomwpDUWYXiyvOp6A2N/V00
	ATCphleff+7l1VxJytMWOFGnAkUc3aPN/IZ3yE4eMJG8H32fsHQ2Eq5ZAkW32AOXObdqaiqhc94
	6vEgmKpUz7pDM0RoiyZ3WDT6WoqsO4bSiT66rJb+RWQj6vauE9GoD/8UAlBfyVvCyg+JAMoZoEc
	y9/R4ZMuHq0eKH8oDmcTKsVevG7hwyvADHsfHh6gwLk/UCvP7TXA==
X-Google-Smtp-Source: AGHT+IEfuDDYK+ntfpHR5pvru3ImvqizzFRDPsCIR7DXPzRG9z9zS0hmxa1of9YSUfCzCw9Ay324zA==
X-Received: by 2002:a17:907:7b8b:b0:b53:e871:f0ea with SMTP id a640c23a62f3a-b6dba5c0f81mr44209766b.56.1761580440260;
        Mon, 27 Oct 2025 08:54:00 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm799326466b.6.2025.10.27.08.53.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:53:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so7611041a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAjYit0y5qtEYqJjcW0wpYEXRABwR/5tl4EELDjJ17r1V4xfFd0lVi9qlKYigk6sW8PcJqo2qrXf+EkBJ0@vger.kernel.org
X-Received: by 2002:a05:6402:4412:b0:628:b619:49bd with SMTP id
 4fb4d7f45d1cf-63ed84db9e2mr369134a12.25.1761580437926; Mon, 27 Oct 2025
 08:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de>
In-Reply-To: <20251027083700.573016505@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 08:53:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ0RdDzpafUUduCn3gOVX3a=ZmGOw7wu1s-jqe8KypDA@mail.gmail.com>
X-Gm-Features: AWmQ_blZNXFTqWGx07mPO-qNDyYJc9sRx0MxijvPg_spVplnaBKcigb1OKRcACM
Message-ID: <CAHk-=wiZ0RdDzpafUUduCn3gOVX3a=ZmGOw7wu1s-jqe8KypDA@mail.gmail.com>
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 01:43, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This is a follow up on the V4 feedback:

This series looks all sane to me, and I think the naming etc now all
makes perfect sense.

                  Linus

