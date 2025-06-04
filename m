Return-Path: <linux-fsdevel+bounces-50583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245EACD776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA66A3A73FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 05:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBC1B414A;
	Wed,  4 Jun 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWwEizVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0F2C3251;
	Wed,  4 Jun 2025 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749014320; cv=none; b=f2zvusOUWZD1Hdsx3e+GCqK7nXvQtSoTgCWOLZzrCZbsYUzyDsiYtfjc+E9tUk4LJ53JQYaqcMXu15lHQuYph5rew+QbFMKjwGRg50fnZzDr8O7Q87zPHVYBYYeTdZ7dSXGimhM15zuJA9Xih6Bn2lgWYDTgvGNM3NFCeT7YzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749014320; c=relaxed/simple;
	bh=5L0mXU+ZIU9WV031YNClVIoKTaXI+VboViityezOfns=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cA3yDFxiqwUJ/rnlOM4X36x+bHS//ryqVJDOFBH/pS8iFy9oDjlezzWOCtSfEuY5oFoJJndat4aq0gJ7FsF/ptPwzrFlR6I+W18cymz+7K1UhQS1YQrz/LVXlbU7QckLuCuth7QZVfOaGDLYrPPS1M4ZI94vN73sQyQFMa9GGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWwEizVu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32abd926858so20052551fa.2;
        Tue, 03 Jun 2025 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749014317; x=1749619117; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dsOZYEdf+2IQJTpWqR5gWfV1hHHHdzER9cruL9o4LEs=;
        b=gWwEizVuFxyxNQ1mxRYoFjFDiz6Fa3XKIfsDMnLduzIUP68nnOrMVXTQ2CtsFKvFr8
         0M3ybOKBzeVqIRIJ5cYjjnFki/Zjei/WQ7w7wXcDtcxw3SzpAlheU8EJOkza6xofy94I
         T8If6DRzVk1gAsDOwpJBpO+amO2sdhf4Scqt4hDSL6JKqvyWyKR/WBn5k6P5UA1MYifV
         gKq7hHLKSoDaELFkUOdct11kzAl7Z8DXqjguXjyM+PAOYfSACpD4aFsM5emM0jQIocyA
         KAfU+5KwHM/M/PluijFyYUiROycSEekU9KhS89auaA31MiLtcfIE9w11nOwFZVKyC2n2
         P1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749014317; x=1749619117;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsOZYEdf+2IQJTpWqR5gWfV1hHHHdzER9cruL9o4LEs=;
        b=Hvh9ia/En3QF4kc3DO70Dc2QDkFyWPwWRGiD7qPuUxRgRWQJd+N692qIX+Usa8/RQ0
         w/vxgJDO/9QjmtM78MA817c1+Ucp4ME5tXWUX36GLv6tveYG6JnS3OzPducomU7r7w+q
         HqNe13cPecgcOpsYiSNE5wUN36A5PgDlwRzsO5bOejH4KJMr4glRyJlgf/wiFLfLQtrJ
         0SjfaZzHVw5u4UdKFuvkw50rNe3HZKbPC6fVdozCaA5RFdiKcH7FqH94cTi82q8FmwOw
         LGEZGmPpMmMzHsHN90s3esK/LDB6FXYm6ArkkduQLcqFd8QRS8GG/RouhsQjM8Xk+yk0
         j8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0rLyvuT9w9HvsOH1JPQK1W09SFXk30btoEfu3J0/s6kafkqTrKqvZ/UUkGmunEZH1Rr3WBJaYvsaKwCwI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xxlvZpWqek16VY7VRm2qdjAY5MoOsn7e2cwYAmwx954qTAB3
	HNTlAFrKNwvsKoprmcupETh+Oa2osVgh+UR4rp1delcIy11caL+EmD77wTnMe1ThK+/hMdrhj+G
	FdidwGsMWCaqnYW32D0kNSx+ErwEzefz3vcFa
X-Gm-Gg: ASbGnctdwrt6JPrDyPJku2EsM/mn4czJ1AI3UgJs+zGWd5qQiygqfOqtny/s0FzfWje
	7DIcVI8JbCqr26tk7K+MDfWJ8LUGzQbYZ8kxB+d2vfzkpnsn0FhQnOvs0rP4gxDqm4l4EzhuOcf
	uLplFgd11VnSBn8wH/Q40RzlvmMPLk0HE/VjgTeOezxp/B
X-Google-Smtp-Source: AGHT+IFIz3Z8XZ89S0jOnioHJISoBvKH+tdt56Z9NhxdRmJnMHRRd7mY2jX4Sw91trh41v/ZjzzroL5ITJ4EAQ1332Y=
X-Received: by 2002:a05:651c:1549:b0:32a:8147:59c6 with SMTP id
 38308e7fff4ca-32ac79d2840mr2615881fa.27.1749014316547; Tue, 03 Jun 2025
 22:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 13:18:23 +0800
X-Gm-Features: AX0GCFsSBwXBKlijLdYhtyRldmGBYdfBX_Pc7pN2NzpKVFp0aWHXEuM6MsFvfYo
Message-ID: <CALm_T+3funpAryWLgouRn5CNd34AvNxJUUitUXbKR3vT5DUwQA@mail.gmail.com>
Subject: [Bug] WARNING in remove_proc_entry in Linux 6.6
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.6, corresponding to the following
commit in the mainline repository:

Git Commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa (tag: v6.6)

This issue was discovered during the testing of the Android 15 AOSP
kernel, which is based on Linux kernel version 6.6, specifically from
the AOSP kernel branch:

AOSP kernel branch: android15-6.6
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android15-6.6

Although this kernel branch is used in Android 15 development, its
base is aligned with the upstream Linux v6.6 release. I observed this
issue while conducting stability and fuzzing tests on the Android 15
platform and identified that the root cause lies in the upstream
codebase.


Bug Location: remove_proc_entry+0x194/0x334 fs/proc/generic.c:711

Bug Report: https://hastebin.com/share/sinejizobu.css

Entire Log: https://pastebin.com/J0p8J9W5


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

