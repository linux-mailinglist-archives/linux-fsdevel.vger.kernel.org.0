Return-Path: <linux-fsdevel+bounces-15468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C688EE9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE5F1F36AF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB41514C5;
	Wed, 27 Mar 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hspFMTyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105C1DDC5;
	Wed, 27 Mar 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565610; cv=none; b=NAONeEpZIBgh6V2UK+HdHrUrHCB6JIlKT2BHAst09GiU7MEwhMavo4Lr6ljiec8mnMQI8E/3Muar5Iwd+9q3RhmmQxh/R5w3m/nZjy/b7DNILmIVdzvLG8dKwbuPDxnHUpaP5OyNUpcDbOMbQ76zG7JWkX7NEbk9st4HonUOrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565610; c=relaxed/simple;
	bh=+O32pSKiKxZOrZ1z6j0vD3Kyh3AW1ZjH2V9CfSPZsUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn296hZUAJeMEJozO9p3I4FRhB9KDG+hQ0BKCo/UKTfUs8KmgnlHFVvHFX9vTK+luBKE8/8PbWIcJ4NhTZ61guVV7zRAk//mkXg4J4mN7xrI3PyzSX/0L2gb9JE20IURKzJsgt/VpNiv4XdiHEorj/oMZAlJAUkz7v2PcjefQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hspFMTyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3484CC433F1;
	Wed, 27 Mar 2024 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711565609;
	bh=+O32pSKiKxZOrZ1z6j0vD3Kyh3AW1ZjH2V9CfSPZsUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hspFMTyK2qH06drosYNkCR8bPwEwK6OeRHek3DQFlGPDm+QyFobZ0Gxn0kJX7KKBw
	 4K7bFQUrvTH4tV4hPok/fHV9LbLkiEWJbdBRb1oXpMNwLSZpOPuoZtLsHbYPslgrUq
	 kcEdkzMvpvOD3MXgKCX1mAw9JXfSzDc95kiFv9WkEuk8Sl5Hi1Ow+UBqcCuURDOehE
	 3gi6iBdGjBpUQl47w+A78Ec3YgmJKW709PqFvTO8wx8Dgf9wYurl2hVW0GWSDS6jxi
	 w5IBH+uRMqIUn5YhRocoddfTsbs5eIDFHPm4D7VNouXCgCy7hcaTw9J9qa6JibSsX8
	 YDERBj6zgvjhg==
Date: Wed, 27 Mar 2024 11:53:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Cc: asmadeus@codewreck.org, "Lizhi Xu" <lizhi.xu@windriver.com>,
 syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
 v9fs@lists.linux.dev, regressions@lists.linux.dev, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
Message-ID: <20240327115328.22c5b5a3@kernel.org>
In-Reply-To: <20240322081312.2a8a4908@kernel.org>
References: <00000000000055ecb906105ed669@google.com>
	<20240202121531.2550018-1-lizhi.xu@windriver.com>
	<ZeXGZS1-X8_CYCUz@codewreck.org>
	<20240321182824.6f303e38@kernel.org>
	<ada13e85bf2ceed91052fa20adb02c4815953e26@linux.dev>
	<20240322081312.2a8a4908@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 08:13:12 -0700 Jakub Kicinski wrote:
> On Fri, 22 Mar 2024 14:26:07 +0000 Eric Van Hensbergen wrote:
> > Patch is in the unapplied portion of my for-next tree along with
> > another one.  I was hoping to hear some feedback on the other one
> > before i did a pull request and was torn on whether or not I wait on
> > -rc1 to send since we are so close.  
> 
> My guess would be that quite a few folks use 9p for in-VM kernel
> testing. Real question is how many actually update their work tree
> before -rc1 or even -rc2, given the anticipated merge window code
> instability.. so maybe there's no extreme urgency?
> 
> From netdev's perspective, FWIW, it'd be great if the fix reached
> Linux before Thursday, which is when we will forward our tree again.

Any progress on getting the fix to Linus? I didn't spot it getting
merged.

I'm a bit surprised there aren't more people complaining TBH
I'd have thought any CI setup with KASAN enabled has a good 
chance of hitting this..

