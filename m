Return-Path: <linux-fsdevel+bounces-15049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F851886572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 04:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98BA285ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D914C85;
	Fri, 22 Mar 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Abqc/xqO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87129AF
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078169; cv=none; b=eqJPQZ9GRfY523BowG9MGDJLSX/VBelymhYhXro4mOfRCAkKNbK1LZnKrSnFRXD/Une1gw6zApKfSrBBTwmMmsKI1aYM/8wvN5uIP9Uv9fUbwQcVr4LhjDpY2+KWZq7CgysSW6sWyy1eK61TaTHW1rLnuaXzwADwVvzWN5r3jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078169; c=relaxed/simple;
	bh=qvJ+3YFxfDePmsCIW4PY238+EQenGMVU9ozMZJPSRfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqu9InNGkEKkRdRKhmaMF9kucwaMPN5JvncgGToZqmOBZ+I/OfUD98aAC3NgeKNZt8Q2bU83gteyGjIz/sGzpC7W+X1MmjvkwO2mAEm8WHQubY6x8INIgPaXZPxx+PQrM+TmUmBYrfvxgAicwlrHA1XO/YMf70GAfKyOvsPDCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Abqc/xqO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789dbd9a6f1so125105685a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711078167; x=1711682967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV6vFBRCysrecCdTrQzr9r0j273jT0maLCCHGnLq8AA=;
        b=Abqc/xqOa0DstVG6xlU+pf0DZkGSurm+ZlCGYGAxhxY83E9o8QGo9G23zEnxRBt4Zx
         amfUomZUpaNbWWHrHiGVdtIgFsYyzRA5A0bJhMa7j5QxCsHj4Npu09tgHcpa9R82EOjc
         mPzagCq3yEIgVzoe9Z18tZstulvsgsvYouUgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078167; x=1711682967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV6vFBRCysrecCdTrQzr9r0j273jT0maLCCHGnLq8AA=;
        b=ojWUufzIYZtRWdfEGOQcSHokySv6AFxnMQneY4fK3+KLPkEDKEmv0kKtzD1t9CgYle
         kG7+lSEcZN6l08tEuXvI/uFxRN/mlMS22d3GffHA2BUocvo8Yyz6m7JqtIUnIdYYgs5S
         khipAZ1atQETK7ijetwjdTWvRbMDOQNzv2zZQqZ6HB26hwaVrwvA4VCwRjSUzq70HUvc
         5GzNDeZv6bgJwymSZviT1dSTwIrBCvZpQ7t+2hoHM/PXX81Sql6Hal+4yGxCEjlrpAIw
         Yh/wIkaXBEKxBK0ODb9O8amfHqerZ4MY8scBSSN3+mv73zkfQqws0N+0ApW26+RfrIRe
         Mdsw==
X-Forwarded-Encrypted: i=1; AJvYcCVvoMXcvtLeb50w+KpN4ovOZLq4IRC8tLCgGOfSf8OJYdNp+9LKSx2ebaklKbc1hYVxmcdvUoIcK6FMO1FZvMi20xOdfeJmfaPsCi9SQg==
X-Gm-Message-State: AOJu0Yz3k7/99y67tX4ZIG/EfhBA0ujW5j39xhe20oqsN73HmKaQFoRv
	SmxBttmwrkhYb/EPuslvKycYTajcNNuqYbA4BE5jpSZkZQNhj8p201hOMDSBHrgp2GUxOLrQdlI
	=
X-Google-Smtp-Source: AGHT+IEys3W9wGHLskR2Zg08t6A2fKR7mvDlrO3Ptg9X+wIwXdgzLVMAbC9r2tAMxNwMcoP2Vea6dQ==
X-Received: by 2002:a05:6a21:9994:b0:1a3:3064:9931 with SMTP id ve20-20020a056a21999400b001a330649931mr1699512pzb.3.1711077791861;
        Thu, 21 Mar 2024 20:23:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb2-20020a170902bc8200b001dd876b46e0sm669300plb.20.2024.03.21.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:23:11 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt: replace deprecated strncpy
Date: Thu, 21 Mar 2024 20:23:07 -0700
Message-Id: <171107778560.467582.4496512848388862288.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 20:04:08 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> There is a _nearly_ identical implementation of fill_psinfo present in
> binfmt_elf.c -- except that one uses get_task_comm over strncpy(). Let's
> mirror that in binfmt_elf_fdpic.c
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt: replace deprecated strncpy
      https://git.kernel.org/kees/c/5248f4097308

Take care,

-- 
Kees Cook


