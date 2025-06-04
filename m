Return-Path: <linux-fsdevel+bounces-50570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B8BACD64D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 05:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731E3188C10C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144E3214A6E;
	Wed,  4 Jun 2025 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy/uGWz9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B417548;
	Wed,  4 Jun 2025 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006360; cv=none; b=a6AQYFtSiOrXzcxyw/M9dV71D2iSg1mDlCAC6iZtrtIeguvmSTIRAFD7G7WJTfue/UH6WztW0dh0D98ptNZIiVc/f+/XDSCzcJQSxnuiBaqaYKUvDbiAledI+g3t5W6UHVShdRkR2je/4F4Vqu1hc/6n3RTcX/Jt6WWFJm7aKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006360; c=relaxed/simple;
	bh=E8PGooQfDmxgcXtp/cM4o7ws6CJEwjXIdL9VpFSfaYg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OpfwpN/XrSiu3ECkWuFoVKyK34JTy+gdsSlsfMgCHO9bAjMfdF9uS/K3ngv2VlEL7IsPlxM99A8+YxVzDj7MiV+wJm2MEerDcAL9+7V5a4alCVlFozTGUEju1o25bwVp/NgtPBozAbi4ZJc/fNnjCWM8+8qsgA30QXAh4sLaLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy/uGWz9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55324062ea8so8079587e87.3;
        Tue, 03 Jun 2025 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006357; x=1749611157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XrRYADRBPiGm9a5915k0RbAutzjcH3WmEt2d36ObIAI=;
        b=Yy/uGWz9a6TmdDzRtKEZCH7oTH6C/UuyCpWGmnZxZ4kF4+g4D0X+SOjeMrrwQuBrly
         ZzUf3RuvqyY/HmrbxQiLpAN4Wa5RpLWWHzC3Ml3hQBn+uYvsHvbDFkARESB+TsOs3uI3
         PjU8B1ysfZCoTaU38pet67i2cwurmVhoh25tWQOCAdIS3f34U2z71sgvV7wSfzsaz3BL
         TB0yBdwwM3Z68O3HGNzn2iWQVzQ1lx7Pl2i4Zo8gKIU7tsLR7PS8eTN+DD9qt6u1dwSh
         IJr99JB3OlqBh5R/VCHrkbBWDRMYvuYOM6zkFlvwwFuOfXJh00f4BQzKvn1F7sapOjs8
         X+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006357; x=1749611157;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrRYADRBPiGm9a5915k0RbAutzjcH3WmEt2d36ObIAI=;
        b=Y0jBFdxKlP2ctoxQOQwOzbaS25cUHceo805qK07n7eIdW4yjMqOREqHVUX0JR4emZT
         H5h3y6Tyf8Cr247aagQ7umjbFkpti9sZoGQFZr9S1D6G9nif0m8P+ifI60S/wHArFP/k
         PEnQ5923nF2sNvJLeiiKB5eedPK3QetIVuTrcF8JZRcVHK5Ks3WXiofbsN/W8fOLNk0i
         RvcmPSUyWqm48aE0+26Io4zrhmel9gbxj7IJ6WQRLJG+nOd12RBMTzUeL2r0zFKymlPU
         2sswlHxJExPrgy3F5WCtlV09AyAPn0HHDxrWVKGc96LIrawKzZuSv9NmprKhYxC3LR7m
         dZYA==
X-Forwarded-Encrypted: i=1; AJvYcCVqAOH/igba/XA93pYIT9HqIhSAMH81HmTp90GoYj57FJ9lAlfRZwwNAQdgtSZOUXRckI/Kby908Q1RXP1o@vger.kernel.org, AJvYcCXvcFww2Zeznm89KYSp0HyyxwAft4FJwUS9kIYxr52VJHXH1o0rs9pslY2CR5926xUmf/yJoJaXdFmaA3oM@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQlOiUNT3Bu4zIYIPkOGwIZ3Fw544h7WCpJeflC6IxmvCso+z
	MtszSkCYmE4szEIZ8o354XkNAchMov5SZHDOjCZ3o+leAZWwHj6mP0m01AfBVzxvSlgIofihFq2
	gZxiYnWQ0PaPM6vtZVhe9HdY3D8rH6YE=
X-Gm-Gg: ASbGnct+TH53IvHqZPQ+p0D5rHAKowS6daGowqgFZHQmhLEN6Td1TgBJQjIeLduMt5Z
	UmZgm+DegLrUFf7120iwnfu9CI+z9zYmGlYuWStWVQcVUkpqHhVMc7GfEOr/VHnVaOzBUaxjeXm
	0FPX8gjnl0Lzp7PrnijxfBojZM/TTUtj5q69s=
X-Google-Smtp-Source: AGHT+IFrfuotPH2SAa7IurUQmCgV77jE8JA+qS89XFFpzYBWrutBPdYxpZm0boMJxiBXy52iyySokTu6owGB4A7wG7A=
X-Received: by 2002:a05:651c:f09:b0:32a:6b16:3a26 with SMTP id
 38308e7fff4ca-32ac7278580mr2109891fa.34.1749006356455; Tue, 03 Jun 2025
 20:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 11:05:45 +0800
X-Gm-Features: AX0GCFuLg4LwuXuD7vjPGf4vz4RhyaBTWp5jvmMTKwnKMjsZt7RAJiWsXENOmKE
Message-ID: <CALm_T+11u3jn-OPi_TPogwsUYE_iRdgZY=pjG8-OzTa4uR3dkw@mail.gmail.com>
Subject: [Bug] unable to handle kernel access to user memory in step_into in
 Linux v6.12
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.

Bug Location: step_into+0x60/0x54c fs/namei.c:1891

Bug Report: https://hastebin.com/share/yatanasoxe.css

Entire Log: https://hastebin.com/share/qaluketepi.perl

Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

