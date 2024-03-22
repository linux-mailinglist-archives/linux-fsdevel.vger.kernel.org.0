Return-Path: <linux-fsdevel+bounces-15102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80987886F92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FFA2859A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB864F897;
	Fri, 22 Mar 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2jc6i1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896634644E;
	Fri, 22 Mar 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120394; cv=none; b=CHvFy7hlx7QJgJArJVvScXpWQELZdf0hYqVJsm2iYhR09bQsMCGpcsPyKjjrOjxkfd56+0Eb4yPxNu9ciCvCFaKv+R3k538650yUpRaAjDfb/25EkCpkGP4nGH5VY+ldnbasaGf5BuQ63RXJ7nmutY7vZ9xAMuQToio5Rmg845M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120394; c=relaxed/simple;
	bh=Dw4ByjZkVEzsc9Sp+TM4v9hJZ71PCSuq7eO3NUfsKAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awOZx7uyrTfoR1bSv8CpTtouug+uc4n6llZ9VKHFYIxqAy63rpEr50kZb5ZL0KIBORTHYlyg145J4+jdc+B08slWFuFvdQ5HYmp+pDgtJ5ykUID6UETDKhdbNgt4fngWVDuVtkQk8e1wZq181be+SuNrVnqTKp3LI3DzMUf43iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2jc6i1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87098C433C7;
	Fri, 22 Mar 2024 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711120394;
	bh=Dw4ByjZkVEzsc9Sp+TM4v9hJZ71PCSuq7eO3NUfsKAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I2jc6i1bQ/VajU1sWOLiT0eFC2kaIA4tkdniovHcHkCqFBL5vMWNDVpw93VXj9mNh
	 52uhqqog+uOD5WMT/FEQ/8oGDu1dImC7Tx/EM1gWbE33a9oEdPfC+p2Wwf1wwG+fzl
	 cJ9LB75vZiTF9uL7m8zMob9vSzaPWeu/4ntQzF7NBnch0DSkRumV+W/9+sAc1FHb68
	 rWaXn3/4rDQVguPMIcQySdmxw3QW5TmX/TMbfjUPc1gNlJ/hSjcxnI70yrXsftknM6
	 LQVcLvLlkJ75xKHwdyCXQvOzNDvDbUAdHQE7IqbAS5YcPyP0P/lw8LfYyXDBLGDrmC
	 4zyzl0fwZa6Mw==
Date: Fri, 22 Mar 2024 08:13:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Cc: asmadeus@codewreck.org, "Lizhi Xu" <lizhi.xu@windriver.com>,
 syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
 v9fs@lists.linux.dev, regressions@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
Message-ID: <20240322081312.2a8a4908@kernel.org>
In-Reply-To: <ada13e85bf2ceed91052fa20adb02c4815953e26@linux.dev>
References: <00000000000055ecb906105ed669@google.com>
	<20240202121531.2550018-1-lizhi.xu@windriver.com>
	<ZeXGZS1-X8_CYCUz@codewreck.org>
	<20240321182824.6f303e38@kernel.org>
	<ada13e85bf2ceed91052fa20adb02c4815953e26@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 14:26:07 +0000 Eric Van Hensbergen wrote:
> Patch is in the unapplied portion of my for-next tree along with
> another one.  I was hoping to hear some feedback on the other one
> before i did a pull request and was torn on whether or not I wait on
> -rc1 to send since we are so close.

My guess would be that quite a few folks use 9p for in-VM kernel
testing. Real question is how many actually update their work tree
before -rc1 or even -rc2, given the anticipated merge window code
instability.. so maybe there's no extreme urgency?

=46rom netdev's perspective, FWIW, it'd be great if the fix reached
Linux before Thursday, which is when we will forward our tree again.

