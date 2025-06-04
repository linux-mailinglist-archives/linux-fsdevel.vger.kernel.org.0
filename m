Return-Path: <linux-fsdevel+bounces-50578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76218ACD73F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167173A6EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D04261575;
	Wed,  4 Jun 2025 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFtLK7ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401B17548;
	Wed,  4 Jun 2025 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749011932; cv=none; b=IF9dBp1oBN0EcMgFuJ9hMcqtiFfEdc9t6nwsrZVcln6gvlRbl993K+YqUdVNsqiTdWQF/mmjH5y1/cgcx7ToVzx0+EFRk3URdSBxPpF7L8Np7LXFKKxHraZzWpJQ9zkRF+THpNBLWx9/nnbV6T+3UsINDqdg5Hu3iRODLANVBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749011932; c=relaxed/simple;
	bh=v9tNt8ij2w7sSqJu9RrCFKxSy6NqX61bmrvuP+9UCfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P5sMYpwC20/DtY0Z5PReJwRGtb8XbEfqIA6SWnM3kVZLYns/3GyopXY0sXxjKruNKX00fql8vMJOhtF5GlR3Wlb+gp0oC47ygvQzIJK5VvIz7qvEM+hMywmBaZJsUHTCbe6dZfhM/CTMPxLqYviNt04rB6shi9jmGP53UkHC86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFtLK7ge; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54b10594812so7641112e87.1;
        Tue, 03 Jun 2025 21:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749011929; x=1749616729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYpfOOzFinNSdkDJtOkYZ/tqAPzBbFEjtvj0zSUUXAU=;
        b=LFtLK7gepXXt+LnPp8Rnd3iv/zwblVlhXKX+vizz+3d9mqyXo9n5e5akCY2qTC3K3e
         P0BVefNRUo9eFS+Sat2NTW9oIK0mfoCohF0wWKrFv2TSvhrZBhvU4YO48ZHBEzSJLhgI
         Qrg9p63cPvPmTci83b+2RFtyUhqDEZ/JkIIV4iuaDK4guB/90gRigOoe9Qwvpwm3ZnO0
         CAyiLKK6wY9ckScoi5FsdqbEocyWb6sBXtL+OWLb8qFoSNe/NQMDVr/fX56Da4EhiX9O
         ssHoHsq6BtQ9n76IabuyM2GDXPFYhBlOBVpE1pFGk7gDyRCyV4gkeGpNJMrCVcbVU09r
         zW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749011929; x=1749616729;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYpfOOzFinNSdkDJtOkYZ/tqAPzBbFEjtvj0zSUUXAU=;
        b=FSJIGrZ4D7/vYNMII4Ssg7ewxuvy4Q7bCIy+4JwnOusUqh2gAYMh6dy0U2DYtldibb
         S5cuXpH3TZSsLuXawnsUFMHV/1tJYkI4Ge/C+P4xItIpvIivV2Ku7i/Pxy6SoIUznoii
         wZuZos17nEJw7VOre3nZpgNsYaMeEtQ9L+LpWNmuPD5wqeuY0h9XU+HP603sQ3G1O3E3
         Rpkj3wR5gwwQ/10ts++HunXq9HT9/m8RKJl/gFJzjtXjShB0k1mTLr6ze3U/tdgV4GwN
         rnADHgXXcxVkjeTIwpKqLjE9+8OLahCd0hgh1O1JH9Mf+hga16ZSNPCV4gf7TOb708Z5
         ubVA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Z3D08U0vbHyry/rDXjiefFM8nlSDdAhtrIJqhRbRUOGCVErpeXY26H/39lDsRnAZnfMlaMQFD5UU0iGQ@vger.kernel.org, AJvYcCX/yDXIOBGGM8o0m1Xl2Y0qWYgnm9jpBP9xWift8p7R2FVscka/EJcczvf1UUFJCNv7OUGWPSVEpv88N7ey@vger.kernel.org
X-Gm-Message-State: AOJu0YxlaJoaLiYB1zcZc0wPJsIXYzY9CYgZGXlxfakcHzIhNF4f1dWX
	4id7KguROv3L/az2R15n3rMECGGhDE0h/wQxSZLttRyXOEnYgfM/EUlFnjeAUO/RZ5tmhBZDzIt
	y9Dmd/uqhqSXYJCZA6tOL5QWCXyfPFJw=
X-Gm-Gg: ASbGncse8DvEo+vvIXfgRxPENPGarWGz3l+XfYOkSJqmGwuvnEILq13OEu6tuEhh8BS
	adlwbJDiSrma4adVG1b0xieuIonIKyasiDq7ttuywWrhPer/U+39N64G9rhf2vVR3FTXwp45xNK
	GVKJqYZkmDlMfXwkKOpU9SKEphpbF1WpXXsBftqh/UHcGjaw==
X-Google-Smtp-Source: AGHT+IFmyb5s6d1fvYe/ZUSr9OFpQHJ62AZP9FgQTYRXYaPphQpFPC3gUVwPGipTeeb4nY/wnrwBQIkeedjewMsQ3VM=
X-Received: by 2002:a2e:a588:0:b0:32a:8855:f1fc with SMTP id
 38308e7fff4ca-32ac7247968mr3719491fa.26.1749011928628; Tue, 03 Jun 2025
 21:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:38:36 +0800
X-Gm-Features: AX0GCFsuydeZr9stWvdQ0Yo1i2lw2RvSKn-of8aPJ6t_UtyDEj5VIUA5MZ9No_Q
Message-ID: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
Subject: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
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


Bug Location: vfs_rmdir+0x118/0x488 fs/namei.c:4329

Bug Report: https://hastebin.com/share/vobatolola.bash

Entire Log: https://hastebin.com/share/efajodumuh.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

