Return-Path: <linux-fsdevel+bounces-37655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303F9F55F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 19:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FB9188EF4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16681F941C;
	Tue, 17 Dec 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcQqwgVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0C1F8932;
	Tue, 17 Dec 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459602; cv=none; b=CD2YEky+AJHwjGNKljCdm+zCshGaBhaNcuGxsf8Ih+7ZHbkXuzWpSKPs2SipMoSn/Zi+AytmGtgQAlesMZHpoTX4jD/qeXaQSd/6W8cfXxYO26Yf8sUTJGbO8NGxVmWepl75KpCumLFUY5f4eUbk6FjWeU1yA2a1nfjCt2OxI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459602; c=relaxed/simple;
	bh=RuRjYBtd37eJ6BWE+WZCqpwEWnzVbgqMtoiwz31zqzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDXCXvNUImKZzNGuTSFJzDPbdAlm/kmi103rHOTwtO8AykRKxmx0H91uAeQ6gWQ9fl4Z4/EKYAU7/2K83QlARd6TQWZ3kGwOxPPR9dcDCTdiyVlgV1odZA+DIL/hN2rkdTcMsN398La7NVGlggj9K/0tk1gIThn1aI0BH1HtnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcQqwgVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29FBC4CEE0;
	Tue, 17 Dec 2024 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459601;
	bh=RuRjYBtd37eJ6BWE+WZCqpwEWnzVbgqMtoiwz31zqzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PcQqwgVbF4eRBuC6Miw7kUsdH0T/T1OLpKoUL5hRT5+MOd07j8by2x6Dg+b3ogEn6
	 b5Vti4yyMVboNIsu9s0qGBO+DyK86WJWkFgk7rW7eklHJvy2hPU2OiS+L6CoWcfklE
	 2c3yT65FUk49T8l4n5NFfQdniSBP7qL1sHcO7T2MUTE25yCGce0j3AUz+jihMk1lHV
	 WSmYzGQlMIvLvCvuW07tqb2ohLz9vpC2raKRbR8eV1R1wRvdDxG+wnOaCIh5nwFUr/
	 lkzEsABN/BS3BdbHP3hRMD1xRqSPP83NEdwH24K2oVmUxIebIeGH5sxSBaB1olNfiM
	 bosDYNS2NCICg==
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844dae6a0caso162553639f.1;
        Tue, 17 Dec 2024 10:20:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZGKzCD+ixPyy0tEwBmcPFuIkIDIBzhelzvqmLIDp0NbH479bAL+435CTxXeB9E3oyzjZ9z2jDGjFW@vger.kernel.org, AJvYcCUdwH02xJ45lK8TbuIRj5Z+ZBp72FjLQBQvmIilEOblxpv1CDbm2fHeviUBskRfoK7mD4Tt/WCqZaQQxBSLIcuXWxoSvMTN@vger.kernel.org, AJvYcCWdAkoWTjWzvEiFCHYroV89BHH8Fdjq3RnVFgss6t69It37I4Mnn9dWRrasV2Uc4X7o6ABT9xDw7IQXD1sj@vger.kernel.org, AJvYcCWo/15qfq3Ihns+SfXT/oVRHrOBwE3iH0H/WF69wg7I/itbgUBa/Y5HL1EQjMgUjymuSvK8KzcnrFoB@vger.kernel.org, AJvYcCXdR6WtxU1+9plK2sxq6ONMqBnLvBdveU3HUxXzXhaJftzPCjMmQLGw2dvMn0vKammubwdfZWli7s/OiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ezpzXFpwRlPj6hgInCduY1iwAIiDVGHNU2aqfZkfqf5mi/rd
	eJTIVWa8Exqlgdl5gZJo/2nbfugUJip/Q8CZCpw3D+oYVxsx4WD3YrBzbDLZ73YxHL6IHwXzOeu
	A8GJUpjZvbG3ivMoaZnQaInIt3+4=
X-Google-Smtp-Source: AGHT+IGVF2/lzRonWuPyDH2ItNAehGEg982iraVqvHuFNJBoNdPieWEU/a4HYmGk0xpeWomItvBDrQWzPhD2J5GiKtc=
X-Received: by 2002:a92:ca46:0:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3aff3860488mr155848315ab.24.1734459601030; Tue, 17 Dec 2024
 10:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216234308.1326841-1-song@kernel.org> <20241217173807.GD1977892@ZenIV>
In-Reply-To: <20241217173807.GD1977892@ZenIV>
From: Song Liu <song@kernel.org>
Date: Tue, 17 Dec 2024 10:19:49 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5Jik1B9SOXr992pQPDuaXbUuAw9Ktp_OYPEkaev5NdUA@mail.gmail.com>
Message-ID: <CAPhsuW5Jik1B9SOXr992pQPDuaXbUuAw9Ktp_OYPEkaev5NdUA@mail.gmail.com>
Subject: Re: [RFC] lsm: fs: Use i_callback to free i_security in RCU callback
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	willy@infradead.org, corbet@lwn.net, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, brauner@kernel.org, jack@suse.cz, cem@kernel.org, 
	djwong@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	fdmanana@suse.com, johannes.thumshirn@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 9:38=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> >  - Let pipe free inode from a RCU callback.
>
> ... which hurts the systems with LSM crap disabled.
> NAK.

How do we measure the overhead in such cases? AFAICT,
the overhead is very small:

1. Many (most) systems have some LSM enabled anyway.
2. pipe create/release is not on any hot path. On a busy system
  with 176 CPUs, I measured ~30 pipe create/release per second.
3. The overhead of a rcu callback is small.

Given these measures, I don't think "hurts the system without LSM"
justifies 2 extra pointers per inode.

Thanks,
Song

