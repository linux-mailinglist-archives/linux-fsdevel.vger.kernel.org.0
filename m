Return-Path: <linux-fsdevel+bounces-34899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D479CDEB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4FB2839AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC301BD4E4;
	Fri, 15 Nov 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOYCVww6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B41BBBFD
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675228; cv=none; b=t05nRuE44wkxAjkmGteosFMg7JqqRot3SuFf1amPcrMJPpaR5yQZF0VRWERC9DsC1fxJO8/om06MPhxfoFBezGT2ISPWoLGO3rXqRmMErqzSUJfEnv51dIVIvuGvJ3MLoqRQ0OltUibwZdBgqNpWrxaxX2eYapTyjOMg9Uv3hwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675228; c=relaxed/simple;
	bh=kC5b4Nc50fbhWMMi5vOolJEMARSuns1Kxgz8mfrxf0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JLLqXwtl3Io78fgchpyngmFy4vBW03eYmKGbVYhKgj5YgZsHre70PS9hmUHtmTiPvSc0dXmnNchTesMOTQ9hG73a7n4cIb2HcyeorVnWNrFUpSBQnNxgQR1eT9O2WYBV2uoUsy87HxxL0+YjNIG9bAcCKI+5QP+YQkwaOjlUPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JOYCVww6; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5101c527611so806237e0c.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731675225; x=1732280025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEbeDGIYvAwvzpGJm9/Bl8sSZPwTY7aHupGksBQNqK0=;
        b=JOYCVww6pa0/5KMRFf7IGJ1k+Bx7LGT2/DxU/Oh7MNdjqymjq/o+5p3ba9kuMh9sK/
         7l4elYOAprk69/Lmefbspw0vxYX9VhssazXRk3pCzS+r+D4GrzConORSUl9UjQy7uhPw
         lwj7ArJehnwiEWGkBKfMkVHBvZomFHfcS9WiNzkJvCT726uwflO0CSfn5JFUZhj16KDA
         IfHY7JUeOeDYbJmazpt54Eh1uN+gHcGrvm9mmKQjvuOSkjgB+ONs+XqfPRJYEiRLJL6J
         Wsk/TlEKWepuq+Usys4p/DwxKcDYNwCt0m3+ql6lrCw/7u/T29IksxV93BxQRCZElXUG
         sm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675225; x=1732280025;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEbeDGIYvAwvzpGJm9/Bl8sSZPwTY7aHupGksBQNqK0=;
        b=J2RXAwjdbeM1ZvAgo1JVcreaeL0ZU6f7Qo6bKAyQN0UCR1GqgoewjXyGVYvCPCaqny
         qgUj7KPEhDtcC+JJdS79GW+wKQlrsSuRaqKJSvbtOMMtse3Z1i2lE0PXoG5EDmOZXfCG
         f4JxI7LZ9QDDnNRgRKJpL0dmihodT7jVmi7Ud0nZM14JGZSEDSx1yf3lAmB2SVm+vD4g
         lAnGFP7eVDNGnfE/6RipQ5CNhGfamO2XSr8s7ZyMpG8vGMiZ5K6xQg56ZydsR3Lq/TS/
         goQcxV399vCXtc33ZZwB5IxmtwOww+6Pu5UIpmsv1rKHgCTAoYT+IwGcua18Fn5o4rAa
         5Yaw==
X-Forwarded-Encrypted: i=1; AJvYcCWwJ0ifdcb1kjnKV+Ml+xprjGNye9I0z3DhdwXrGLF4VpEW3iZR69XgPVq3zVSgU097DklrcdH+Futi+Qom@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbXhGP7q76xiLQptVYFxx8lLNJWwkwFLupgkkX0fRWqFKbSRw
	tSgxGe3u8rGpEX01CQF9jrdCngOLKbTVNG+ZkZFjLJ3lwG0fCjW/6Trsbo9jkr39SlEIYf5up83
	wIbkX0+aGVPMc2qoKuPbkVfEfCrgK7To3FY1B1g==
X-Google-Smtp-Source: AGHT+IEtDEtXKpcCidRqx6bebqrisPTC0Px9Xm1sUVNWuLsQVQUre+hBcxnbLyeeXGplNKk47hIC4CRTO6saY/xxXGY=
X-Received: by 2002:a05:6122:8c22:b0:50c:79a4:c25 with SMTP id
 71dfb90a1353d-51477f7c9f3mr3308737e0c.8.1731675224854; Fri, 15 Nov 2024
 04:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Nov 2024 18:23:33 +0530
Message-ID: <CA+G9fYtThFpgHJvVwmvp274QJ0QBbrsr+qnYi0b5fWJ5oJL2uw@mail.gmail.com>
Subject: next-20241114: clang: fs/netfs/read_retry.c:235:20: error: variable
 'subreq' is uninitialized when used here [-Werror,-Wuninitialized]
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, clang-built-linux <llvm@lists.linux.dev>, linux-cachefs@redhat.com, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following builds failed with clang-19 and clang-nightly on the
Linux next-20241114 and next-20241115 tags on x86 architecture.
But the build passed with gcc-13.

First seen on Linux next-20241114 tag.
  Good: next-20241113
  Bad:  next-20241114

build:
  * clang-19-lkftconfig
  * clang-nightly-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
uninitialized when used here [-Werror,-Wuninitialized]
  235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
      |                           ^~~~~~
fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to
silence this warning
   28 |         struct netfs_io_subrequest *subreq;
      |                                           ^
      |                                            = NULL
1 error generated.
make[5]: *** [scripts/Makefile.build:229: fs/netfs/read_retry.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25811023/suite/build/test/clang-19-lkftconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25811023/suite/build/test/clang-19-lkftconfig/log
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/config
LLVM=1 LLVM_IAS=1

metadata:
----
  git describe: next-20241114
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 37c5695cb37a20403947062be8cb7e00f6bed353
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2opUctayqtTsKWUeLDYKbGaUqa9/
  toolchain: clang-19
  config: lkftconfig
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org

