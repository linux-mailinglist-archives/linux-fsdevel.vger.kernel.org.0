Return-Path: <linux-fsdevel+bounces-24950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2824946F91
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E323281025
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2E041C69;
	Sun,  4 Aug 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ENdq7sF6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360712B6C
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784716; cv=none; b=iXQRGw0hmRQi+LkpmwOBZnBHub0bUzPXtXFsNB0A+3roILxtJCU8dmZSU6QEGU3RZst6bnteYmePuVqZ4/yV0qk4YhuNxiNm5Qi71ym9er4C/RU7h1jAOKrx0CD3bgfdUZmuIgOIVzXlN2u5QIRzZFGwynkilfEHSDmpoVk4NJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784716; c=relaxed/simple;
	bh=FwG3uZ+G1lDWNQM6xX7mdtjtc2Eqnj+ONewuiSG3HLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV/r/E5hF2sfr0+9Zzrp3k4/iONE4w67hhLlTWCdRbkMvJzCf3Vnnd+EN05UpAdXubpophFJhOE6xWlyfxR8n6AMiem7ZoKQWZF4GEMlWe9zie4mOHtEhf7oZTImFAZwhcMPJrPsdc0iTRMhDOPsYFJtDfY17UiGbsXIHgR1qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ENdq7sF6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso118516531fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722784712; x=1723389512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvy+dqy9w6k+uckEt7X7nz6WN1AV8eCpzzyX3CNuEGE=;
        b=ENdq7sF63TaH7DV1vt9AaSY0Ge86/9QNLgAfGA+wpq9laoXzLJ24ICE9HiuiCGo6z4
         ae49x0CW+dOmutTS1j5u7QyYpmxlr50ZcLXddI8QS1zYhkvr4UELlUK5k9DKg2WXjR7o
         Oy32+udYasFDlx+nuAWx+66VrNNIbqC8rB3U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722784712; x=1723389512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kvy+dqy9w6k+uckEt7X7nz6WN1AV8eCpzzyX3CNuEGE=;
        b=oUzouLWHSilRKg1lHe4eGGME+oHR8vlNRE5RyW4T1ZgNxaRD6weNeS7X2bkyKMioj1
         m/7qRQdzdr/GkZL/iNfiN0vd/tdJASpnci2kx7a19UeRw0rBe12taAAISNzBjxnf5ENQ
         tF8j0hHbJIwDLnk5qlEN3xkODz+x5+zL8GQvYLt4a0V+bo2v1JDkZNNX2/TWZ/O4KDJI
         5DI3rRhJQUAVDzwrQa/rBmXyxJa3qJYM+5xpnMtKGTQXEZrrXlTHVjE4BFBQbh/i0okE
         wwQ23o/WojhJdUrhBt705Ttp3OJKDRm16JDujBRWGQXlU36TJ0aBA6gyYRP3Yt9mK6zs
         y35w==
X-Forwarded-Encrypted: i=1; AJvYcCV/o5NuPIXz87ynuS0t/s6uAzyhWNP+DAycaG/tazsOCfrNxhm/mtxthNrVC3MnVGfhYzCLDUh+t2nH8z3Jyi7JTZj1wfz/PFBs96A+7Q==
X-Gm-Message-State: AOJu0Yxbw3sSXdgL4nj4kflCvj2p/VjvK9oFbE1Oxf6C7bOF1Kt6N1zO
	Rx3lfR5D2oUsm8mNhKYO8+4xkcTAVqpuVrE7dE8obXNJqb4e84Ch2LBhYv1GnVuYoE6AikYkpFa
	qw4Brlw==
X-Google-Smtp-Source: AGHT+IH2FQtZsg3Tv5FAMVFjereoG8m2uwoYDBC6wKH/LLj1I/vvB40M2A2jX3dXr7BgtNr92fUTJA==
X-Received: by 2002:a2e:3306:0:b0:2ef:24e0:6338 with SMTP id 38308e7fff4ca-2f15aac1208mr55686751fa.27.1722784712137;
        Sun, 04 Aug 2024 08:18:32 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e26038bsm7782111fa.117.2024.08.04.08.18.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 08:18:31 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efba36802so15641062e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 08:18:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw2lxIPFYBo2f9XYHEJU9q6sKOWQ8Zpeo7fHgtrdlktng+Y8/pH86H3SmTWCj/7SAOnSAh+rZ4DZw12O6/gpbc2KS9jC+je7nlwW9E7g==
X-Received: by 2002:a05:6512:130c:b0:52e:8141:1b27 with SMTP id
 2adb3069b0e04-530bb39b079mr6531054e87.43.1722784711154; Sun, 04 Aug 2024
 08:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803225054.GY5334@ZenIV> <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV> <20240804034739.GB5334@ZenIV>
In-Reply-To: <20240804034739.GB5334@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 08:18:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
Message-ID: <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
Subject: Re: [PATCH] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Aug 2024 at 20:47, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
>                         copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);

Ok, thinking about it, I like this interface, since it looks like the
compiler would see that it's in BITS_PER_LONG chunks if we inline it
and decide it's important.

So make it so.

               Linus

