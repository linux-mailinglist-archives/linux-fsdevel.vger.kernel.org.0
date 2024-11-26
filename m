Return-Path: <linux-fsdevel+bounces-35874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD39D9339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE305B21FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0DA199EA2;
	Tue, 26 Nov 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgF1XF4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E245023
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609526; cv=none; b=YogLYdfIulD6pxEfG7mMNgkucHJyJCxPk97YmBNUBIR6jLNiW7TG91VtoSTArSkGXhtzzEDZsFhou0h5SDmqW0ML6Qpl0Z6ZMcOA1/BpIgFT8xEvJ03TYia1CjhSJ6FJziz6J4BsKfRi9aLFGBMzPNkdBOorCb9PhyexDgxyZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609526; c=relaxed/simple;
	bh=sI7tNk5+zKeQtAWcs3AksLYA8Nbczy7AgLIX6hl0R9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cs0Cv5Tk/HEjxt+YBbqscJa+kFCptyZV7KqbrxOm+MRabVJyBezIiKr39G2nSNH8Trbf4LNyDCAOa2EjUyK3SzPyhUabqIr3IBgD7RNhkZDeniVfS0fCRlPCwK3/QASM0+e33vvT5EMp6EmRhtindCll/vzUO3nX9qgmMLJ0GwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgF1XF4i; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4af3719294eso223929137.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 00:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732609524; x=1733214324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6PXQfbArbgQ9QlkA0GcTxdQSqKG1+4ODD/01KNTBS8=;
        b=dgF1XF4iN/up/cq8XLwsH2CqHxROUELox6VSDdKqBRgM6z6zSwYwWYXQ90b4Qqs671
         bCzKngtMD/Ev7qBp9h1N0+zdphVdzQuNpqcnyJSh4BJGUkCS2Y//BI7bCy8SeaQdwzSo
         HlPbqifyBBAhq6BtyP0mjrjOoovops37Ts2tLzcFIxYk5+Ua/NZK0R7Ljxhck7bNgOWh
         wxMsBHbq4jP+roBgftY+az3cwDqR/jjrWuwHmPOcm44vv26acwJUxcMUepQI6k/69Fro
         +vbsLpOr2cEw6sFWUnPZejrthaDS4Q6rTgco3NXpXocEAg5sstw/YZkhJwS6LGCliqzN
         UFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732609524; x=1733214324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6PXQfbArbgQ9QlkA0GcTxdQSqKG1+4ODD/01KNTBS8=;
        b=jU8i1N9LmMj7zjOcdzrQ9+CpiAuo3Lg4Lqu4WTKTxn+oTm6hydhFuKKLqfHubG5C1T
         ZCcR/KgO4E7fOJZBTLw0q6r6M5mJeo2eKYVQrCdYAEb81hHDOJ8TklLvXGWicOZhoB+u
         Yjg6tTohyp6R//iUNNWHIGMCZLnuq8r1NY/Y1p5lf63iwnqlEPOphomlVTajyI0zKYVD
         z0nIlktRApPieeRvh3WXUToOzeFRZKFODZSW+x4g/5ljGQQU+2S5VtqsPMPk2cYOA2nd
         hPnCGJ7bW4McA9ICl3MFvDw1qaNgMSj55imqXgBHNooxUeb61NY7iAf+pZrLuRrsQQBH
         JP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEKODZNfpFmD9azB/I+rBysA7Z7SHriJjM7uVRohpFETe0dw3fBqKtaCi7lhAfNXVAeK2EaAAmCwYkGa5Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyTu75q7VCDvH296GBxb9hVEFdAa1ydpwNBmtjRkbkRHx/zPOjx
	Ovj7JmLTaDENmh3/88t3nBFSRR2Omuje0RZYwY8yVJGH2nutzQWOZiVwtQgH9pXHmB8e9nJj+Ut
	6A1akjcB3d9Aj+PqTldZfTgRUKpAutP2oWZH+AQ==
X-Gm-Gg: ASbGncsAe1MfaoeAuGOeDhNMdPOlBSOGgyQZ7JtAG/LA4YpRezXsPXxDcD6iPUykmvq
	ZgP3q3eWUy0vCqx4hf/iZpfMjHpHqQaxOhasThf77LTDe9/p2LwX7BphJqf6kZwUd
X-Google-Smtp-Source: AGHT+IHfmlOUT07xsGM81ccGUL8gokcmILu2aWCHpE5lTRyBqDIA2QVqqjf2o72oJuOxTAI/oybzlUneyIUgqtnDACo=
X-Received: by 2002:a05:6102:9d0:b0:4af:476:f3ca with SMTP id
 ada2fe7eead31-4af0476f4e3mr9401237137.12.1732609523827; Tue, 26 Nov 2024
 00:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Nov 2024 13:55:11 +0530
Message-ID: <CA+G9fYuLXDh8GDmgdhmA1NAhsma3=FoH1n93gmkHAGGFKbNGeQ@mail.gmail.com>
Subject: fs/netfs/read_retry.c:235:20: error: variable 'subreq' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The x86_64 builds failed with clang-19 and clang-nightly on the Linux
next-20241125 tag.
Same build pass with gcc-13.

First seen on Linux next-20241125 tag.
  Good: next-20241122
  Bad:  next-20241125 and next-20241126

x86_64:
  build:
    * clang-19-lkftconfig
    * clang-nightly-lkftconfig-lto-full
    * clang-nightly-lkftconfig
    * clang-19-lkftconfig-kcsan
    * korg-clang-19-lkftconfig-lto-full
    * clang-nightly-lkftconfig-lto-thing
    * clang-nightly-lkftconfig-kselftest
    * clang-19-x86_64_defconfig
    * rustclang-nightly-lkftconfig-kselftest
    * clang-19-lkftconfig-no-kselftest-frag
    * korg-clang-19-lkftconfig-hardening
    * korg-clang-19-lkftconfig-lto-thing
    * clang-19-lkftconfig-compat
    * clang-nightly-lkftconfig-hardening
    * clang-nightly-x86_64_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
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
make[5]: *** [scripts/Makefile.build:194: fs/netfs/read_retry.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26060810/suite/build/test/clang-19-lkftconfig/details/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/

Steps to reproduce:
------------
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-19
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
LLVM=1 LLVM_IAS=1

The git log shows
$ git log --oneline  next-20241122..next-20241125 -- fs/netfs/read_retry.c
1bd9011ee163e netfs: Change the read result collector to only use one work item
5c962f9982cd9 netfs: Don't use bh spinlock
3c8a83f74e0ea netfs: Drop the was_async arg from netfs_read_subreq_terminated()
2029a747a14d2 netfs: Abstract out a rolling folio buffer implementation

metadata:
----
  git describe: next-20241125 and next-20241126
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pNKzjvChfT6aOWplZaZeQzbYCX/
  toolchain: clang-19 and clang-nightly
  config: defconfig, lkftconfig etc
  arch: x86_64

--
Linaro LKFT
https://lkft.linaro.org

