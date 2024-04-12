Return-Path: <linux-fsdevel+bounces-16820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480228A3435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B9D1C2302A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2B14BFBC;
	Fri, 12 Apr 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7PAvxxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316E5491F;
	Fri, 12 Apr 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941164; cv=none; b=HbfZ7nm+P1zAaTtuG+O+wxljBr5NjtFp5Qz4Z6ptUn5zUistTTrkPWbu7b7nNUv10wNGGS8fNsI/r7azta3UaK3zuqNxJ+rwGRKDv5W/EnQYR6c/q2wXoAm8nbNHzoLCtaMoN1JZQapIXCgiNP889hv8DijkwmdbLqLgnJwNYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941164; c=relaxed/simple;
	bh=vjUt8Ss2air20ASfcUx9xukrTcaaeYFx19lixRDlmP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=avzY5o91SyvG515X4J/gpFKl61VdZd1ydGM25lhVIo7dFYAkq/LDqOnWFi3/zP3ZwiFF/9a+wcBchmOEaEDwv5ZtDFJLzeb8IQI7NV18yN0Cy0dtIRUgJtEBOG1xNZpVDrRhv6EvED008uJXYW509V2v2BBmKX5aQrdjVNL6+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7PAvxxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84F9C113CC;
	Fri, 12 Apr 2024 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712941163;
	bh=vjUt8Ss2air20ASfcUx9xukrTcaaeYFx19lixRDlmP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B7PAvxxFsSFHG7ZCnsELk3yzsJDSXiXUwUaoao8fjYeQgunNY5KA0SHMn7Mm2zdTp
	 sVvu012C7X5XqVa215VQ+KY3HWjwFpLMeLnp1Q3ghYPc8Bq+kZMoO6fWOEQwW3XzTk
	 heHhS7uZJYfnMqMGaZ/mJao/tGod1J5x/tbZC+2SveyvvQuBFPoNCbTtyKhckzG8OQ
	 Kud6G/ycDucl9EMm6zAKzZ9kZ94MjqVqyM5d+nS5sv2G9+xPfotvp4oZrH/KTgQe+2
	 LJZxaVycmHkafDql7cJYNvg5YmO8q5NcvPgvJM3v0N4uSsfqhGyWUZlmVPQP3Ynufd
	 esHkLQ+rsTAJw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Andreas
 Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, Conor
 Dooley <conor@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
In-Reply-To: <20240412154342.GA1310856@mit.edu>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240412154342.GA1310856@mit.edu>
Date: Fri, 12 Apr 2024 18:59:19 +0200
Message-ID: <87a5lyecuw.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, Apr 12, 2024 at 04:57:08PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Hi!
>>=20
>> I've been looking at an EXT4 splat on riscv32, that LKFT found [1]:
>
> I'm getting a "page not found" for [1]?

You are? It's working for me!

>> This was not present in 6.7. Bisection wasn't really helpful (to me at
>> least); I got it down to commit c604110e662a ("Merge tag 'vfs-6.8.misc'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs"), and when I
>> revert the commits in the vfs merge the splat went away, but I *really*
>> struggle to see how those are related...
>
> It sounds like you have a reliable repro; is it something that can be
> streamlined into a simple test program?  If so, is it something that
> can be reproduced on other architectures?  And could you make it
> available?

It's kind of streamlined: Linaro has this nice "tuxrun" tool, that can
be installed via pip, e.g.

  $ pipx install tuxrun

if you're on Debian.

Then you can get the splat by running:

  $ tuxrun  --runtime docker --device qemu-riscv32 --kernel https://storage=
.tuxsuite.com/public/linaro/lkft/builds/2esMBaAMQJpcmczj0aL94fp4QnP/Image.g=
z --parameters SKIPFILE=3Dskipfile-lkft.yaml --parameters SHARD_NUMBER=3D10=
 --parameters SHARD_INDEX=3D1 --image docker.io/linaro/tuxrun-dispatcher:v0=
.66.1 --tests ltp-controllers

(--runtime knows "podman" as well)

You can pass your own kernel to --kernel, and the config for riscv32 can
be obtained here [2].

Build with "make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-", and make
sure to have the riscv64 cross-compilation support (yes, same toolchain
for rv32!).

It's when the rootfs is mounted, and the kernel is looking an init.


I'll keep debugging -- it was more if anyone had seen it before. I'll
try to reproduce on some other 32b platform as well.


Thanks,
Bj=C3=B6rn

[2] https://storage.tuxsuite.com/public/linaro/lkft/builds/2esMBaAMQJpcmczj=
0aL94fp4QnP/config

