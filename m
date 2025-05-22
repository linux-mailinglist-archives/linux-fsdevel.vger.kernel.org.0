Return-Path: <linux-fsdevel+bounces-49675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B07AC0C95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59FD16AD5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1828C005;
	Thu, 22 May 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASce5Xvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAB28BA90
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920159; cv=none; b=O+lyKZ41R0N2ATAHCbY7TvaY63LOHOwgkazitz/tagdZZfNVSSrNodv7+0wuEsN9Ww5Pv77AH2FT0ofokEn3Izw/fx2BZEETOqcHBPV5D0OHb4PWSTMsMKN3KXP0RdLtRDleAA1hQNXSvf1rYvmNLZnabq+x5PHvmBgVm1deZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920159; c=relaxed/simple;
	bh=9d/cL7spZ/Wpwt5q//l/yGfX4IJgepMQQJ1VLqzbCYI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IeIPnYRL6tx2b4tuFa/HSWmxeY/ImWwqCGLsFu/WiquU3rF1eRc48amsw7kbLkq8AxSqbVe7GnZxTcHe7bADuBnwtj2S2OXTKWs+iFSwTVC+mSHo2xo1270mZeiSU3ssAVJ2dxTqYF+/WK/JQPSIre2b9yBVpTMLEGtOoWbQq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ASce5Xvn; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86a55400875so244548139f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747920157; x=1748524957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZfTBhDhdrqletUuYxc3+baMCOgR/beos1y6YIz7hWx4=;
        b=ASce5XvnwQFAdORXbdMI+p+f6mofxWdUFe4+WizcBMjMmZl/fa9slW30bZy5DYzWdA
         NE9r2fWk7tmxtLwQWc/Ao0+bjop8/C9Q+KLKdx9QkH2838goiDWzHijfjXH8bFu06Lcz
         zMOGQoYEidrCYQvhtHvWYunfzNO33J/ogXGpgYmhUqI5mVo/AOySskzcdMEkh1Sctup6
         xKqRpVg22eL66c7DiwvvrQoBESKBGKI2qLnOwoOUVX55xwaspU9D1h/x6lpfhiOswB0o
         JQYca3D8FcQcfR1fOOa7zKm3qJhtdWWEcoQacP1o6mCRJftKqnR00mhrm0+Et+nra8r1
         UCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920157; x=1748524957;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfTBhDhdrqletUuYxc3+baMCOgR/beos1y6YIz7hWx4=;
        b=vrXWQmDVAZS1YEZ2DO9AHulOlmYLHO5HlZu4pif2PBNpQgoFYWeAhNoTxEWZ5IMoVG
         hR/h9Buou1wMRbll5zNeT0f6gA6eWdMmsTzvGgEiF0Wg5VU6nfHCvwO49EqXHCz+sEMr
         iqwvKFlyMkOfJEKA/b5hBmzAOqOfphp+4JvuTf4UKp0lnhHqqAfCM4whdf/PJQU+Q45Y
         n+8MVCad4AJJsj+zyFwQHfd0o71N+bNoXa0ZGBJErZFFGI+UWYfIPocZd8UfTOqsjnK1
         qInUsB5q2zSt4L0qWzWkEekYr7AV//pR6tN9if7mSzw9JFQS3OFQS8alx8jDUxInffxo
         MVHQ==
X-Gm-Message-State: AOJu0YwD6izKhEDRXthZ00+P2nnRuACeeoQVlpdEzu4FYvT54XQizl4s
	sC01Cv1EQAeAWFR/VgVoVQvNMNiBSZ7l6Hp6OfP5trCjyt0p0v/G5u+UiHaXZuU0bMBNqvPxbye
	j0xuqh7NmbU94UXQobS+KAbLqXUgeUvOq2l+YC09BsDV6KpzPbliU4Dc=
X-Gm-Gg: ASbGncsC/3y2WizwV9ef1uasG8Q6ciTj3g04z/3CeVu481jZFh7Ls0Uy0l0lEQxQtqM
	sUmKj4zr+E0Hv3E78T59jFp78tnGNtuLsjitzDB4C5LZpDMhLCGm1uV27c0PbLkGmCGDdJkf2km
	K4V8U3P0jxte9bLsRNV7YaZSD9E2rZ7mDViJL/j9XKkptu0chT7LML+Jk3QQqPKO1QsQ==
X-Google-Smtp-Source: AGHT+IH2x7M+ebP0fF6u65wtIJfC2HKWreUBC1mFxNZYez5c2LjS+RbEJT03nVtElBzCk2DLszkS0XUj8hnQ/3AfrTc=
X-Received: by 2002:a05:6902:13c6:b0:e74:b106:ec71 with SMTP id
 3f1490d57ef6-e7b6a317681mr31915653276.46.1747920145756; Thu, 22 May 2025
 06:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 May 2025 18:52:13 +0530
X-Gm-Features: AX0GCFs4fMOBdKUjtk4Ii_YEa3Zj0uO_GBWF7untQbLfXNpr8KzqJEF5L9aKhfg
Message-ID: <CA+G9fYsZPSJ55FQ9Le9rLQMVHaHyE5kU66xqiPnz6mmfhvPfbQ@mail.gmail.com>
Subject: mips gcc-12 malta_defconfig 'SOCK_COREDUMP' undeclared (first use in
 this function); did you mean 'SOCK_RDM'?
To: linux-fsdevel@vger.kernel.org, linux-mips@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions on mips malta_defconfig build failed with gcc-12 on the Linux next
tag next-20250521 and next-20250522.

First seen on the next-20250521
 Good: next-20250516
 Bad:  next-20250521

Regressions found on mips:
 - build/gcc-12-malta_defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: mips gcc-12 malta_defconfig 'SOCK_COREDUMP'
undeclared (first use in this function); did you mean 'SOCK_RDM'?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
net/unix/af_unix.c: In function 'unix_find_bsd':
net/unix/af_unix.c:1152:21: error: 'SOCK_COREDUMP' undeclared (first
use in this function); did you mean 'SOCK_RDM'?
 1152 |         if (flags & SOCK_COREDUMP) {
      |                     ^~~~~~~~~~~~~
      |                     SOCK_RDM

fs/coredump.c: In function 'do_coredump':
fs/coredump.c:899:64: error: 'SOCK_COREDUMP' undeclared (first use in
this function); did you mean 'SOCK_RDM'?
  899 |                                         addr_len, O_NONBLOCK |
SOCK_COREDUMP);
      |
^~~~~~~~~~~~~
      |                                                                SOCK_RDM
fs/coredump.c:899:64: note: each undeclared identifier is reported
only once for each function it appears in
make[4]: *** [scripts/Makefile.build:203: fs/coredump.o] Error 1


## Source
* Kernel version: 6.15.0-rc7
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 460178e842c7a1e48a06df684c66eb5fd630bcf7
* Git describe: next-20250522

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/28516701/log_file/
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250522/testrun/28516701/suite/build/test/gcc-12-malta_defconfig/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xRo9ld0H5IJGyGHQxUSopFLZrU/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xRo9ld0H5IJGyGHQxUSopFLZrU/config


--
Linaro LKFT
https://lkft.linaro.org

