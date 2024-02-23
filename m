Return-Path: <linux-fsdevel+bounces-12588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B7861626
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CB11C24030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E5839FE;
	Fri, 23 Feb 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz80AxU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EB82C8D;
	Fri, 23 Feb 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703067; cv=none; b=pIiAEhA9oS9NPRC4DIOk1MHB84NfhKrY7mqcSvtcEgkJxiTfjgt7dMaJ96p/Il4HB8hVtffRStX5sVOWXoUX9WRQr3SaYxV+d0gYSA0F1htsaGaEfbSp5J8Rf9Ik1zgWBlMbe+wkWIXCYofUl02+Vm556vCOugrKXjx9/rlyIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703067; c=relaxed/simple;
	bh=R6iH4ESTC3Kq6YCVIhRC6TmpqBJtDbDbnX0oGo22lW4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L9S9cQoIhexXQrikOVerdmYtfJZWux0k3Bjm84PrSrll3Sn8TMDNwuKUIyz4Nx1rWhbfacvI08EdOEE22eXS/pPjNSkq6agHdZdwJPBR/9VWHlwdFIei54VS6USfRIOU3LFTQl2lTU5JbrgTm5sV5n5lJW2Rz67IL8hcASk2dV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz80AxU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF91C433C7;
	Fri, 23 Feb 2024 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703066;
	bh=R6iH4ESTC3Kq6YCVIhRC6TmpqBJtDbDbnX0oGo22lW4=;
	h=From:Date:Subject:To:Cc:From;
	b=Fz80AxU0PIbRBe6Oi0+AgajU+alOCo/lnsxfIosuXr6AhyZIO+R7SSWdrgymDCodo
	 oU2/45HJv1O3Vs7z0Ao4e7pVVSyGmij29lnsP5ichRm4/Yw7QWPnzW4LBI+4IMniGX
	 LMx8zZPUhDmhoapwoxDfHvybUaEG187wbagfRSsV/UBvmYIF6LTSbmG5+PX6EpI0Hd
	 I+IRQZ4ONQLBbNLTdz4eiR4FegJIYHkcr35r3wRFzhBpIPpeEZTLsc/+zdJtnaPJum
	 EmV0OC03mo2fw/JtyQ2i3WJWBJXmBwWTB2iW3+wrATDzw3C+gHqhlmvaLRsVClC51z
	 9XaVxtIjV5FOA==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412895f726dso3516895e9.3;
        Fri, 23 Feb 2024 07:44:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaAYUCog10uVfihte42vUEjtq4d2qg9JCbZIirxZMZpD2rgxUA3oNOVV0Py2aRzfBezY/+XCK5Owx6Hil5dD+9Oeg/SerkrqezQwyf9J/ktlkE69Yfp0ckY6G9BS5O9fm4DSzRvSwUbU6GdeY=
X-Gm-Message-State: AOJu0YxNjvgDBrrEnVWKnyppb+ehSQ09Y+bY/HXuRRNu8Ct487zJfcxb
	mctTC/wT0c0z+9mEtAQZjsyAoXYIrSZXaVGc3n7HX4JgC3AfHnUphrM9068YrjTkZeKTnBpDZ/U
	SVTerMp4zuUQ4A8WRoI2Be3QZD/o=
X-Google-Smtp-Source: AGHT+IFAHU2DYSVpLtUN+AuuXLIgrjxuGtjU3lFiTDM+GvGPfNBe13UhGy4lkxk7QbANNafrthVxif/lQp+LyNB+Ewg=
X-Received: by 2002:a05:600c:1d1a:b0:412:6c30:59ff with SMTP id
 l26-20020a05600c1d1a00b004126c3059ffmr177767wms.0.1708703065283; Fri, 23 Feb
 2024 07:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 23 Feb 2024 07:44:12 -0800
X-Gmail-Original-Message-ID: <CAB=NE6VRZFn+jxmxADGb3j7fLzBG9rAJ-9RCddEwz0HtwvtHxg@mail.gmail.com>
Message-ID: <CAB=NE6VRZFn+jxmxADGb3j7fLzBG9rAJ-9RCddEwz0HtwvtHxg@mail.gmail.com>
Subject: Automation with 0-day & kdevops
To: 0day robot <lkp@intel.com>, kdevops@lists.linux.dev
Cc: Joel Granados <j.granados@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Gustavo Padovan <gustavo.padovan@collabora.com>, linux-modules@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear 0-day developers,

kdevops [0] has evolved over the years now to a full automation suite
for kernel development and testing. As for the later aspects of it, we
use it to enable complicated subsystem tests such as filesystems
testing. Our automated filesystem coverage has been rather reduced
given the complexity, and so one of its goals was to tackle this. It
also has support to automate testing complex subsystems involving
custom non-upstream yet for things like qemu as well.

While long term we'd like to aim towards automating most of the things
tested under kdevops, it makes sense to start slow with a few simpler
targets. Since kdevops supports kselftests as well, my recommendation
is we start with a few selftests for components we have kernel
maintainers willing to help with either review or help tune up. The
same applies to filesystems. While we have support to test most
popular filesystems it makes sense to start with something simple.

To this end I'd like to see if we can collaborate with 0-day so enable
automation of testing for the following components, the first 3 of
which I help maintain:

With kdevops using its kernel selftests support:

  * Linux kernel modules: using kernel selftests and userspace kmod tests
  * Linux firmware loader: firmware selftests
  * Linux sysctl

As for filesystems I'd like to start with tmpfs as we have a developer
who already has a good baseline for it, and is helping to fix some
fstests bugs found, Daniel Gomez. We also have created different
target profiles to test tmpfs for the different mount options it
supports.

What would this collaboration consist of? Using 0-day's automated to
git clone kdevops, spawn some resouces and run a series of make
commands. If git diff returns non-empty we have a new failure.

[0] https://github.com/linux-kdevops/kdevops

 Luis

