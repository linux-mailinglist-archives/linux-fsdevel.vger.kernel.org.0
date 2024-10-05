Return-Path: <linux-fsdevel+bounces-31094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635E991B50
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 01:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B7B1C20FB0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C6166F1B;
	Sat,  5 Oct 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HCB74KiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1013635B
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728170151; cv=none; b=IpfqZUcWYteIlZSPlGhOM2lewLCRH4EimggPpezAVOU5UC3YE6AKQHDSD8u/FdQewYUjjR93i+hUjqScW3LRToLwgiJ3gEanVK6aXc8Na/yUHPMqB0sePTuS2vHMwuz8ku9DaUODK13tjsKszyj75r3OdeiP0CqgLf1tfXn7QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728170151; c=relaxed/simple;
	bh=cW9voHQW5KDncJFUKsCyNd2iDsh+IZlwySB2TQy6Ai0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5OHbabCa5LmS6NQGsPtYNK5P7J+lufSirdcmByngmyvJJXKOzDlD11tW7/juhB5pPhsrr/WztQqzGhCfiY0fmqRxgP/ShMe32xyWVuo7zgtPoUegTZ90zmmKjDKCbxYO6BzmroWV6XTP4+VyBXYK/MCjGnH2f8EGEkVM5YIR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HCB74KiO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99388e3009so113695166b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728170143; x=1728774943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NhjXXWdst9jlpC/rp/tuj7IYcehyrssGedcgZn1fDGA=;
        b=HCB74KiOlOXbwVgbfHW3HiM97rDyqY4uyQo12cHrbZKl+yVYI72HBgbohAjA4whTgF
         hOpppC47NQmwyDkzEKSViECyXvgs4c9eWE/lmilPh4u1AnBmq0rD3rm6kV6d0JzYyFJW
         SAjKIMSCH7ca0wSmsRPqOW1+E8iu1Mxy8Tmd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728170143; x=1728774943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhjXXWdst9jlpC/rp/tuj7IYcehyrssGedcgZn1fDGA=;
        b=AU37+PsU/ItY9fDSF+KgnNHqGs6fMuWybuIGYcWLxnL9dcwuSQRdlprCkhlgUeH4Va
         tUPWA2JLCNxr6iuEo5TNcArBViFxa2w7P0Jfngsp91MWELBfGhOn15I8G0E1xoMAiBps
         9c4x/NmesRTPxFzZEubKhTcGceoNayYU2ARamdPo2GZIu/Y7bk6MjQU0/P+NLym3ATPV
         ytJUV0xwx2CuvExvLOSsNea3qsUkRXEBFI5JjUaQmPbSwCmwhKgkj76RtIUpPkcjp7hW
         h97YSemkXoTeYim8Dp6LFF8hi0CXEL26OX3Pgi22QBB3ufRx5Wfh0egZw8gScsQPk+gV
         kW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyVEhMZVPC/ftE2Anq/zE3RbNpucsJltqDFwz9h9J89iN7cac2LFcy93r+h+MvUhwq03Qn82O41EGSlRpI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaij8r7vt6A/J/2XN6K2Rbu0AIGTFNix4tGchPeJFmQCjDoO36
	0/zGj5olSwpUt4AvCznxzdI3kYrHLl3bHdzt4LqjwjcAakCqIkheniN0w6snLTWn8dHFdmkSbsS
	SJ9mxJA==
X-Google-Smtp-Source: AGHT+IGUCWpvRuYliSSa4N+lKhnLrtvSjwh568rNI7bvBeDziPtLTl0vkwidumZKOGxUWpWwWkNawA==
X-Received: by 2002:a17:907:8004:b0:a99:3729:f6e0 with SMTP id a640c23a62f3a-a993729f93dmr228241166b.14.1728170143475;
        Sat, 05 Oct 2024 16:15:43 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99305901b2sm179633566b.71.2024.10.05.16.15.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 16:15:42 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99388e3009so113693266b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 16:15:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPyJ+RFKkft5IJXHnBoJPZZ/YnmRcpsc2tpM8niVWEz2lGMujORonQw5quqqFBdukV085g8qbYokIxEjR7@vger.kernel.org
X-Received: by 2002:a17:907:3e22:b0:a8c:d6a3:d025 with SMTP id
 a640c23a62f3a-a991bd6ae43mr732521166b.32.1728170142480; Sat, 05 Oct 2024
 16:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com> <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
In-Reply-To: <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 16:15:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
Message-ID: <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 15:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> The vast majority of those fixes are all ~2 weeks old.

With the patches not appearing on the list, that seems entirely irrelevant.

Apparently they are 2 weeks on IN YOUR TREE.

And absolutely nowhere else.

> Let that sink in.

Seriously.

You completely dodged my actual argument, except for pointing at how
we didn't have process two decades ago.

If you can't actually even face this, what's the point any more?

               Linus

