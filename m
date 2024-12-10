Return-Path: <linux-fsdevel+bounces-36948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4529EB3B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AAE283E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B521BBBE5;
	Tue, 10 Dec 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo6W8Qkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABB1B0F28;
	Tue, 10 Dec 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841805; cv=none; b=bebnCcq9vlL3tXWiQT1is6/S8S2OUojIiyjduQF+WxA/HnZdJEeZGuIu3CMQbhXXUITSwT1lUjN1jgCHcqkz4rsd+jO2I/qv2ps9HsZqR86lG0KkwzppyS++++NMUFOkaRQoBSI93hY7VSaiYRZF7BR4RqiQJF/HHYElJekpYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841805; c=relaxed/simple;
	bh=i9PwaB1e0OxA2VR2a5DU8LBFHPgT/tlvTs5vS+XPURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQNTshEAd9RHu5kewGiS/1G9fE8PJc5u8T6L1/6vfSOineirVcwqKnovjqSo0tOTril0I/AcBJso/A8TlKXR0xKJevBUoS7gaAabkxVI7VdKdIzj7Fn4wOkTdEetPU3295wixAubZJ4z1SFxauyL2DghAObuk0iiLAX5yW6ixNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo6W8Qkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD5EC4CEE3;
	Tue, 10 Dec 2024 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841804;
	bh=i9PwaB1e0OxA2VR2a5DU8LBFHPgT/tlvTs5vS+XPURE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo6W8QkqlfCIj6Av37a6KAOmNjAIY1e6MjGbMtMbaFb4gzFwT8UhR78q3kIm5/gvG
	 +PX+zrDlcwpgloE3CUekOVKav4MIe7hMkDlLk7aKlLCaamaePBuP0/E+2sL1YRoX+n
	 HC4LBzpRDQe46wGhj84B14xL0YhO1aHjSomw9woozX9w+ckEn7Xzvc4sTm0LQkmq+p
	 nA3WhXk8RsGRUMyj9CVn0g4Qzh0UXMqma7nU0KUI6miUyhptMpkKrYF0eHnOsLRYZ3
	 rjroU6jsvsRoBM4W2husdBWMogVUw/0m/HNf5cdFNH5P/XCefycF4yQ+ahCQ7ItGjW
	 QqAFSkqmB/eyQ==
Date: Tue, 10 Dec 2024 15:43:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for
 SYSCALL and TRACING program types
Message-ID: <20241210-eckig-april-9ffc098f193b@brauner>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
> Currently fs kfuncs are only available for LSM program type, but fs
> kfuncs are generic and useful for scenarios other than LSM.
> 
> This patch makes fs kfuncs available for SYSCALL and TRACING
> program types.

I would like a detailed explanation from the maintainers what it means
to make this available to SYSCALL program types, please.

