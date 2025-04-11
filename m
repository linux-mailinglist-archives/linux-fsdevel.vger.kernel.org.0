Return-Path: <linux-fsdevel+bounces-46290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013BA861A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910893B7E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4F20E6E3;
	Fri, 11 Apr 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxn1xg3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26420CCE8;
	Fri, 11 Apr 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384652; cv=none; b=WooiuqyRq2H1OXh99O1KX8SAx8uDX8c6qLOiGe8mkuQccVhEzVaqBO1RYBw1eiKAFnEoPhUJ4LKB1EpXeMPcjHrU32co/hk8wpacHoXfpybgkORPC1gU4qqFAJYT8fMFiHhD/puFph8uuoHYH4yfkcSKKak0PFB2tMgT+L7/0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384652; c=relaxed/simple;
	bh=g/hTWNgBj9a3bczRrF5t1P0iZHlJvcuYnnByNLLURj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPMXM08UUHI40TzaU4esMGc8d7ZZ1s9JrKBhrqH0J40hHUghiu7zi0XkxLL5ml1HCGamsuQsUlNDOd/a+BKNGID3RkMvLUw8YAOyVJPxslO0R2JO1RQbgUXh7D5rijojBCAMn6GKji/+Fvfn5U6ml0kwE9sXrHumaBgj0s0D7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxn1xg3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58419C4CEE7;
	Fri, 11 Apr 2025 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744384651;
	bh=g/hTWNgBj9a3bczRrF5t1P0iZHlJvcuYnnByNLLURj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxn1xg3Wf80mwB/2TKq4Pl25jp+7xjUdl89e9IpDVvResMI4FpyDvlznzmqoY6PsI
	 YfaX28IuWjJG57tKG14s7GpLDdm0FKDc02VsxIXc0FP8BIWOgKcjSS3optD7dEyxUl
	 1jdOQ0+6JzsK6f/QbI/fFUcENL3LC7rrQ82k9hdgTgxEJcWA/jEHue3d4on0TnocN+
	 +grKEDPd4eMP/olUIHzDUTuFc1QAQLPGz1ATL8o70//7RNE+ebwzhTY8ztub621e+m
	 zgevJCZdXDj4MUde9vAcx/Acd+4tCOkLKl/vTABfCIfAYdIF4FtKIFYkpTWwHpFKb1
	 UiLmrBTQbclDg==
Date: Fri, 11 Apr 2025 17:17:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250411-abgetan-zumachen-ada00fc3770c@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
 <43hey3rnt7ytbuu4rapcr2p7wlww7x2jtafnm45ihazkrylmij@n4p4tdy3x2de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43hey3rnt7ytbuu4rapcr2p7wlww7x2jtafnm45ihazkrylmij@n4p4tdy3x2de>

> With this, I have applied your patch for the following discussion and
> down thread. Happy to send a v5, should this patch be deemed worth
> pursuing.

I'll just switch to system_unbound_wq and there's no need to resend for
now. If the numbers somehow change significantly due to that change just
mention that. Thanks.

