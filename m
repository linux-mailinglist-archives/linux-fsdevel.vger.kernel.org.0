Return-Path: <linux-fsdevel+bounces-55819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A2DB0F19C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED001C2590E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0B2E4273;
	Wed, 23 Jul 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCJhXvg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FE285CB8;
	Wed, 23 Jul 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271378; cv=none; b=V6iz5sD/AhqWTWv4i1C3cog6Gz/BvqNFi0klMteydPz/0Q1nWQA2YlEH3mba+dg3zrxXvxMeOZfdU/hVuzf5SpcOA0Uqpbu+QwyvNJfWP/hYenIevc9MawH7Xd+n4HjOD6uwrrIWc6jSNYYViqGNT5VCsboPbNPw+KuOdEnMJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271378; c=relaxed/simple;
	bh=119a463nedZ6mQtBQDQZywz07NccelsAKz8oLPvDBgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRJReGmXH1hggBsWFBz7LvXWnT9xODgsDysKMZh6D6u4x1TuAVszQYMk2BF1z2XhHmLManj9Y3RCTzbPC2e8pW3D0tQZBdY/AiaRuaU1PpB6XGC6TOboQVxVT7lQgoqJsF4RxumlUvZWVDmrO/zCOCrOSv1SIly04RjIRJxfNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCJhXvg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E609C4CEE7;
	Wed, 23 Jul 2025 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753271377;
	bh=119a463nedZ6mQtBQDQZywz07NccelsAKz8oLPvDBgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCJhXvg6sRkMCJYuvzQpMQOdnYGoIf2pjRJ/YtT/w/Bk6qiw4qq2xkHzNc/I5BbSd
	 hJAqhnaE2clHhSoFkSbdERh750K9oFrsEVm8gLhM959wROLXgQbvIs9k77trjrnvT9
	 NyZYiFDlXXWCggu/fIsKuws8qyRwwUwvyECrrniZYPYajgmJZEUDw7ELz7hjGFvSx2
	 NdWjBg9cuNmET+TJuPWlXdYtGn4vGBQ/o6I4kYgEz/uxN5AQW9QUt9HQdliffbOuO2
	 LmkhtFXr9Um4rKBO8l18lyg0rhLOepDpskwP/ZYE9L+mS6U7v5hmkhLQ4lDp/bjgAw
	 tq6bDk6cvF4CA==
Date: Wed, 23 Jul 2025 13:49:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250723-heuballen-episch-f2b25d1f61a6@brauner>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
 <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
 <20250722063411.GC15403@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722063411.GC15403@lst.de>

On Tue, Jul 22, 2025 at 08:34:11AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Weißschuh wrote:
> > The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
> 
> Overly long commit message here.
> 
> > remove it.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Christian Brauner <brauner@kernel.org>

