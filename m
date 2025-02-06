Return-Path: <linux-fsdevel+bounces-41114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B16A2B1F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E061887AD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134501A238E;
	Thu,  6 Feb 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFiACaW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725D1A08B8;
	Thu,  6 Feb 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868845; cv=none; b=AvB8FJoZaZz49BzPMpkyDAe29gqHOrOPYe2s691/E0QE4/HM3yc/FXne0JJsY2kYyZG7wE+g7PJXPqx2D37R4GUrmqjBxh9z12AcU9Ejyc8enGN9fPgNCbrQnXGAgBB9qEy4eq+lagw3zMWPf7lmTgIjWqIjyDaJYjJjyVEy+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868845; c=relaxed/simple;
	bh=3Y9lKJZTXxPn/bEFEPxof9cM95KTnLOaiPaLer/sG+U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sqgt1HoJ1dLKNzxYMoxvNF3orTGM0jpkylZFpdcTsBmB7YORHbE91Q0a26E3RW7S9tuDml4XLz2KcmAVWE9DbjobEGm/i2v/CtqbMar2mgm4Kd0Omj1BYr1u7iYBE1bPhHSNe33PD0chQUirUuMsOKx6Irh/WJukoK0ZzWhhgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFiACaW1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7814aa2adso67618166b.0;
        Thu, 06 Feb 2025 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738868842; x=1739473642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=piS44ekru2Q2hy3mmivZUbYVvyIzizTuKsNZi6ZY4iE=;
        b=TFiACaW1vrVZ779iAtJkR4eKYp4XcpSmE96MCXIcCMd+OB5v87dLzi6Ed5J0hFRo2P
         MpS2VyZhAiHT6Hxh7GJFrICLrKE5mQzwgdh/iENyiwUsBep6QnvPbbI+Prl/GHPOcJ9Q
         evwN5fRHCoAaQnrqf0e++pGfb7PZ7B+8FaSXSXdN6LQQioMuvliaaOkeka/DPPLSvWqc
         VpqBX2d0H6JdWQcrc3HWprh3V0A5AyfUUh9oT0FNaRKqXwQS+2YpZcvPNmm4FLRAlmpf
         pfSQwdwEKY+9BipCAl0ix1jFNIvVukbIlV7+i+U55Zwl3MkoQjEx9BGVi9CiyyfYvUt2
         +W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738868842; x=1739473642;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piS44ekru2Q2hy3mmivZUbYVvyIzizTuKsNZi6ZY4iE=;
        b=gBI2uChUrRnln4CK2tyagqXRzYDPj9Pwf6pLulR2GV/fp+SrK3pVJiyAamohqaYDRk
         EMPUZaMgKS3MGPDuvYaBTblTo8/2WUEnQ7UJvy9h32+G2Vnkdi40o9LcP/6rudUIc6KV
         y7vRR7XDYV61eC4yJVfVUxFEjoLJ98IrdK4y04szAlb+uGgW5a1OwVG2tc53CaI0VoFu
         bG5SSM4CvmY2y7EeMp/gzMIdiMHiv/J3w9dBk3Yeglyc8PuCrEOO/JNZJyvNd4j4/KZf
         hZOrsxiTiO6BNK+UCyaHuFqTQi/YoJ0XNDVBhuyRydR4Z3YNOsWZfvHD+3wPH1f0zyO+
         m0Og==
X-Forwarded-Encrypted: i=1; AJvYcCV3wwERHSdk+3R0APUtdNd0NSYx5QlrP0BPLakTKacPiIqNpgkgTbEQBgWUPmp0ZaWZVRX62AWBgVwZ183w@vger.kernel.org, AJvYcCVEn41DAgcFruDKxTTo19W1GbOiGVptLv6Tpv7ocalxHA44kilBPc/qEuyfHV8FToasLryVLQg1ftgtNv4U@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5pYDsDPatClhMG6XTjQRIcIvfYj3pSwP/TAxQVxFzIl+Kea6
	dtzWQ09XRh+ZdYw/AIYm9xAQB0gyDEA7Tz20yTN3upjgHNAIKh0H75Fh/Yd0OxBaLLQcDLbYIOd
	jqtKdvuKhy6OoP3gnkaNBNsYqYIQ=
X-Gm-Gg: ASbGncsj4Vv2fea1j126WR1ximY59ZzaiOmzCWqdmDyuzaLxZ6a6GmGN3/pnFfCch62
	jU844//kTUP4peTdNGa4Q/HXosCC/vPCzsq1VT02bNgdA6B45EyTiqi2EH8LrTg35ZFZlFPUn
X-Google-Smtp-Source: AGHT+IH3nxCUMU8lFe7u/yFJ06VJpdagvQubxRPShgigcGMaXy9qQT1KRxOG36kQUroJS2+DLpf/1D0xoR+VUl982lE=
X-Received: by 2002:a05:6402:5386:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5de45017b76mr1308453a12.15.1738868841642; Thu, 06 Feb 2025
 11:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Feb 2025 20:07:09 +0100
X-Gm-Features: AWEUYZkW3aoeWrfipuvTdCTz8cvkAXXkprTJUaqtWApk47UMeczz5KSjQTxbZ0g
Message-ID: <CAGudoHFLnmp3tQHOwUAFBKxrno=ejxHmJXta=sTxVMtN9L1T9w@mail.gmail.com>
Subject: audit_reusename in getname_flags
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

You added it in:
commit 7ac86265dc8f665cc49d6e60a125e608cd2fca14
Author: Jeff Layton <jlayton@kernel.org>
Date:   Wed Oct 10 15:25:28 2012 -0400

    audit: allow audit code to satisfy getname requests from its names_list

Do I read correctly this has no user-visible impact, but merely tries
to shave off some memory usage in case of duplicated user bufs?

This is partially getting in the way of whacking atomics for filename
ref management (but can be worked around).

AFAIU this change is not all *that* beneficial in its own right, so
should not be a big deal to whack it regardless of what happens with
refs? Note it would also remove some branches in the common case as
normally audit either has dummy context or there is no match anyway.

-- 
Mateusz Guzik <mjguzik gmail.com>

