Return-Path: <linux-fsdevel+bounces-10335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4E849F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F9AB20C20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF72E417;
	Mon,  5 Feb 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AihtT1nR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244733CDA
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149751; cv=none; b=TikRnyUAKxUqm8c2OYxfIfFfmVibY8gj8BASeXHH93o+SD8uNWU4jQ0dFXLQ59vC0mNuyOMhKO9uIXZNRvLvbnyJgCuphkCi/q6mYdeinOmHJimAyqG85lW87vMb/bhgWVjvHCuwViz9o+A4Bhqp5r3nmnX+jdFMoSxbTMGjbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149751; c=relaxed/simple;
	bh=QNZdJgtA0DvZ58oCoyunZk+TF/2wguhOSw1ImGIEIfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG2/g+E0S32o9Q4Y+kJ1Q+LkY+oBQX4G/Rikbou+fiW+rG5fciPTajRDOI5ZnA4qNIWEQ9iEJcTGOPBdqcHedazrAJ5MFevree2e4/eJeJlyyDJyBt4Z3Dv/ah7946I7LrQLdkU8PVybcWuzWGUX5153SpqHnFxnsOJ4z7Lqs00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AihtT1nR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93f2c3701so23328375ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707149742; x=1707754542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kosTlKckLwBkGwRZXFmlE0YMNTJwV5fsSDM4SiElA7o=;
        b=AihtT1nRzY9Q1LXp/euhQFTBVR4LdWCjLavZt+zVepRFYIwS+2BA2hNT1AhWJ0hcXf
         i473PED9Q1Wzy5idI3fTwCtIT2BRjw4XhLnxfA7BLHyBFz80vJn7iY7YadjG1ctCjevo
         olaudYz5l29utYAY8CsHaT33poQ2wsKbpsFXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149742; x=1707754542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kosTlKckLwBkGwRZXFmlE0YMNTJwV5fsSDM4SiElA7o=;
        b=iitYH2hbbZ1S+p5O4Fa519L7SjunbhrQtF9h5lSkis7Ale9y2bhDKFyQL67k6fqlmF
         un30E7/R1aKOgjKwVwxmGRxip1sXttPMTHpXICUyvDn4nhXbJi6hdsXLghLf39G0STIs
         sa7vgVGUNrOHe89xNRNoELEjTs/6aGRJmjXpCerPfKY00g/CQj6M4YJPkD4umnoGyRba
         Yl5KXKpUR9u8ZdLHem0GqtURRrSCciJDKHWVKRD1zTNEfXu+qI+SSNZ69CPxsBGEOp3p
         xn3JZnq5C4VZ9ZpfXQ5XOdNvEFayKWk/wIwsdTMd6fRyU60pk+Vm4p9y9bNK0OIvjcts
         4QpQ==
X-Gm-Message-State: AOJu0Yx9qCZQRh98Y7gMYeDrW35RgSqL8NQxsjlHiXJMWmm2E63xNTl+
	zXcJfIS1n+JtqDKevSn0dBefZJ0siP4i8j5maGBJrNlOmTrw59PqaMRN2+V15w==
X-Google-Smtp-Source: AGHT+IER10PZ8XbouP1hq6ENHyJSiMPBPm5z2fhQEfN/Iv9Hp6+8Fv6vRoA95msOqgQUpvJB/3wIzg==
X-Received: by 2002:a17:903:32d1:b0:1d9:bf07:7e64 with SMTP id i17-20020a17090332d100b001d9bf077e64mr3001403plr.59.1707149742484;
        Mon, 05 Feb 2024 08:15:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZBH5UjE+mTjIIU5//tNnFvU3qQhXdjyCTImS88gCJwr/FJwF/CKHGfSNWMH7KQmk42EpOA9ui/dhcWDd7fe5MRT/AULYUTLop/3lX6ohd6vgaKrNknnQ/HtJ2oJsNXGAdFDsqU5GV5fCO8HXBYdnNtO7mojtbXf8Y/4RMpFz9nVxkYdzzivHdJHWXhPgmWyarxT2CqOUzyg/hCEtojh+Qh2Bs4APvFk5/QaboerXG3nXT3kRpIfQuDu1DVpEEIyiuBoiFQqbTaqRezBAff+DllGLpvX/JItWwQKjC67uAi+ZVNthikw7P+lVIPpGQ9SBnahmG6rA=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001d5d736d1b2sm38326plb.261.2024.02.05.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:15:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Chris Zankel <chris@zankel.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fs: binfmt_elf_efpic: don't use missing interpreter's properties
Date: Mon,  5 Feb 2024 08:15:31 -0800
Message-Id: <170714972859.1382644.2755936263342477379.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118150637.660461-1-jcmvbkbc@gmail.com>
References: <20240118150637.660461-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 07:06:37 -0800, Max Filippov wrote:
> Static FDPIC executable may get an executable stack even when it has
> non-executable GNU_STACK segment. This happens when STACK segment has rw
> permissions, but does not specify stack size. In that case FDPIC loader
> uses permissions of the interpreter's stack, and for static executables
> with no interpreter it results in choosing the arch-default permissions
> for the stack.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs: binfmt_elf_efpic: don't use missing interpreter's properties
      https://git.kernel.org/kees/c/15fd1dc3dadb

Take care,

-- 
Kees Cook


