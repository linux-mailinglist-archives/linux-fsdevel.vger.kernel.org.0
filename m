Return-Path: <linux-fsdevel+bounces-17679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC98B169B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AF5B260D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8900216F0F0;
	Wed, 24 Apr 2024 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUxgXy7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303616F0D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999359; cv=none; b=dMIiGUGwr7CAnBma1qO+01jXCB2eZbjzOOe7PpHk89tWwtJWI++d8zlGSu8BPBfMxR7lPU0ULPgHW8PJ6FnmXb13bQhCcHskz9eD6swOSYC4aH1cnowl4mTKlTGZ158V15bnVYt/DvG1WAbBWdW5wSz6w5aeBk+0foDi+vA4Vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999359; c=relaxed/simple;
	bh=NuyleERn9RTaJ6vM0GogmLDMo9hWEnQBetMIdltGBQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da4fC63YESV4qkoDFknbJYGcO2R2KZO7rJCJbMEy+5MvtIDuDX0o0QEYNdGNb3GM7ZkQUlfekpUZM+ZZZC2jPQcvVHYNMUG9xcAobum9rDeR5ad97XxVLnye6130K6hoAdvgrAQVNnQzILsBHdLjo4gMpZo9NzKWOvenfOiK0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aUxgXy7O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8fce77bb2so2888235ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 15:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713999356; x=1714604156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmG+fEHBP8gIP1ZYSdwFfbBD/WbACGMT2ciJ+XzN0e0=;
        b=aUxgXy7OTjS07+Mpfyl+3y4VwkOmWc9BK1OLpeOsXqTgBpcFE1qblTPRRtb3Q5j08H
         uUhMrGHSYAl/Qnp9yGEj/LTFj9JImc0yjTanDZsH4FSHJ24zaTyqoeflu+ktvsZtSo0q
         KCzfeZ3s7EPqomcKS/onsO8dYTtxx8zboh1tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999356; x=1714604156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmG+fEHBP8gIP1ZYSdwFfbBD/WbACGMT2ciJ+XzN0e0=;
        b=OQi2O1cQaghi8NsFjFSMyQGWo31rqIiSg3w4M7tHnF63VeRPIXnEtylIpchE3tjSMN
         fYG9UOJui/qRWN48NxeIZkmFtoHIhAMev2bUQ+aGgKTvk0cy1vDWzzHNk4RGbPEpi+Uw
         BtBNV5EmCuXxXuoGf4GoBIGlFzqNQsaCjqOPDGfh8LJG9SQppVH6tVZsDApTTh5hitkv
         9/GaFAmvMlEzg8Q2i1TmiNM5Htay7A4NtOmP4pBh1/l+6wfL3KQ5duz0481infLLIq54
         EjsQMpJkp0uNR0QoC/Aw/a3gWRaJMF1O6SItnwgmY9UaE0yFNOxVuiNWBwRDJLlXJFi6
         x4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsVLBkdv7aTxwo2GNdXyZl3TTeBop0usJjo/YN5xftslHqYkWfJp/XVEZhZThOqHpKrg34TupgwQYLhZAf5uxexlBi7x2mfT+O8buguA==
X-Gm-Message-State: AOJu0Yw8uG6BnAr7NfvXmw7doc3i0TWDFG0pV5eMJCd/3YI9zTFbK9f2
	SMSc4UoWZKoH7vY6WE2q+LBqzQh6jE64Y2D198XN6p2CV7ui4cobMOGQGcgsSA==
X-Google-Smtp-Source: AGHT+IES3WvX2pVqJeL4yTDreo8etDtCdNWcnd0JVJ3wJluHIFmHzrhcFFQzqHe6VOya0h1XAiV08A==
X-Received: by 2002:a17:903:32c1:b0:1e5:5041:b18a with SMTP id i1-20020a17090332c100b001e55041b18amr5506877plr.40.1713999356407;
        Wed, 24 Apr 2024 15:55:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001e81c778784sm12396820plk.67.2024.04.24.15.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:55:55 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
Date: Wed, 24 Apr 2024 15:55:49 -0700
Message-Id: <171399934703.3282693.5984373700910072392.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322195418.2160164-1-jcmvbkbc@gmail.com>
References: <20240322195418.2160164-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 12:54:18 -0700, Max Filippov wrote:
> Althought FDPIC linux kernel provides /proc/<pid>/auxv files they are
> empty because there's no code that initializes mm->saved_auxv in the
> FDPIC ELF loader.
> 
> Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-entry
> aux vector copying to userspace with initialization of mm->saved_auxv
> first and then copying it to userspace as a whole.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt_elf_fdpic: fix /proc/<pid>/auxv
      https://git.kernel.org/kees/c/10e29251be0e

Take care,

-- 
Kees Cook


