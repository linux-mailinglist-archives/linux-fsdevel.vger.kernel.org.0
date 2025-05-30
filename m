Return-Path: <linux-fsdevel+bounces-50207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2045AC8B51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCD1C00C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F451211A07;
	Fri, 30 May 2025 09:44:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887420E6E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598271; cv=none; b=QNO0Uh3VYTbaRI+rBTnB3SvjVGN3BykNzbQrPyqLz+RwozqG3+FRRAZ5DkCnYdliELfAlJQJtDh7OIArJ8Z3juRX5TcQ+ekkQyXifMdHIm3RROTSWM96749cbAgpGiFLq6EXUMwzRS3R0Czvz00Pvsn65F1+tb/I0a0WsFIojiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598271; c=relaxed/simple;
	bh=g4HrVtMJrCBrwDIPYnlS4eYIG27g2LNMm72pw4PMVro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dz3xILR2Fd+ISrMd9x4lHZ4a8K4HmUyNvTPUZFBN8HijZhWKklkUBaFbRqA04tp/t0xAD7njrRAgbFkW+sdMZPUlax3wAe+Yp0itjH22GeItlKfnhwzIVWS5k3iuviy0ikJ8f8coBgabIGFDfmaJfLP0U1igrVwhwW6/KuLussM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e64b430daso19009037b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748598268; x=1749203068;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4HrVtMJrCBrwDIPYnlS4eYIG27g2LNMm72pw4PMVro=;
        b=iCEjpXn7gA4Yt78GYbq7TCsNRp5g8MbjW7WkxaUngb4P4ACK/dRM6MSlyEbzK6fGAH
         tUncwoLkmXIxUsCZ8oSmePoh0VUX6rr/sVKGKoNa+es5XVBmCJL5WeAfef8bmsx3yp1V
         IM5A1bLa1rg4aOJC8I0YHxM7gbcvu+BVoAf96yceqlCk98bW7oeQ9ehbgn8Kl+KdB6Ek
         mYLPF8tMYx6ZuKLl/KuErrreydaufDKjrYmNWSE3IyZ2fkn/n5uCm5F70IO0eHkyqsRQ
         RV9n+6CK7yDr/4NCd9vQEymBGsxQPtsagCRNidmkQdf25ghrNVlTMh0QwRLZUaqouHbZ
         /N3A==
X-Forwarded-Encrypted: i=1; AJvYcCXD2B26dPAvP3OUdCqnShri5j4yQtDQmjTagLOhhgpRHN9NX+NmZi1RIHqMTNCKSqQQUOTRLy4Q0ilayJZS@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgl/34ByL50Xs6NJozxwHI3pIOulF7Atx8ni01enibOuV7cxh
	On0Sddkj14oFpJHqKen/TH8yMq0QrtvgtffV2S+T9w7OYdzSDQvzTXF1b8JYfEWy
X-Gm-Gg: ASbGncsgqU88K/txNssmNgE7uUljs8dvmIkWkR7Qzogs66cRV9odHGde8nWqBMYzrWv
	HNUQcDmK+m/jw+DENVNr3NCbKp0rq5yTHNm7R3L3o7+KcbTO/NrBggRErch8m7DJCZR4tbbWStX
	8LDxxW1yc/wholLLo/4BOHYVcUBwGM8QOTk3mjQb2yHl+x+qFWdNZtBGnx8NcE+wHdvVzGMJ38+
	CUlpMPIMDoqkwJdzPUTd8QlT07AuuxWMwr9mUxizaf2vR/D+PX+1KZK7piK1ghSoNJlhuBlsYW6
	K3rrE7p6C8492vj1f9CBPBheKyNuH/6YC54Uw4Ui3YIuDoOq5M0Z4WNkEfu0GzopJTj3d3xbVhC
	KL7+KblCGCfVr
X-Google-Smtp-Source: AGHT+IEfA/ZDXjsPvmn2jctcoqk9YToAcG37RZhq+pCLjiOrVjkxIHx0bNOzsM/PgKW4oxOE3nig7w==
X-Received: by 2002:a05:690c:d94:b0:70d:f47a:7e1a with SMTP id 00721157ae682-70f97ec6c73mr37656927b3.10.1748598268145;
        Fri, 30 May 2025 02:44:28 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8abede00sm7326287b3.26.2025.05.30.02.44.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:44:27 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7da03bb0cdso1305125276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:44:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3Yde85j95SSmRDFixhPwDPl/Mq/3Zai3DWa++J6LYSCg/qnXI5wUYc4EXZlzxYK9mQEGeglcaFXVnWLGb@vger.kernel.org
X-Received: by 2002:a05:690c:1a:b0:70e:22ed:e75b with SMTP id
 00721157ae682-70f97e9ae4cmr35056147b3.8.1748598267540; Fri, 30 May 2025
 02:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luca Boccassi <bluca@debian.org>
Date: Fri, 30 May 2025 10:44:16 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
X-Gm-Features: AX0GCFuDHGfQnIfT0k_-CcrG9PrtlbQpgGQ13Hgzmij6VhT7_ONW3KNeOEOGGfs
Message-ID: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
Subject: Please consider backporting coredump %F patch to stable kernels
To: stable@kernel.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear stable maintainer(s),

The following series was merged for 6.16:

https://lore.kernel.org/all/20250414-work-coredump-v2-0-685bf231f828@kernel.org/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c57f07b235871c9e5bffaccd458dca2d9a62b164
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95c5f43181fe9c1b5e5a4bd3281c857a5259991f
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea

This allows the userspace coredump handler to get a PIDFD referencing
the crashed process.

We have discovered that there are real world exploits that can be used
to trick coredump handling userspace software to act on foreign
processes due to PID reuse attacks:

https://security-tracker.debian.org/tracker/CVE-2025-4598

We have fixed the worst case scenario, but to really and
comprehensively fix the whole problem we need this new %F option. We
have backported the userspace side to the systemd stable branch. Would
it be possible to backport the above 3 patches to at least the 6.12
series, so that the next Debian stable can be fully covered? The first
two are small bug fixes so it would be good to have them, and the
third one is quite small and unless explicitly configured in the
core_pattern, it will be inert, so risk should be low.

Thanks!

