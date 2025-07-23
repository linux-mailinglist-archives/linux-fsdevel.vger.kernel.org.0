Return-Path: <linux-fsdevel+bounces-55820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3853B0F1A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D83AB70B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB372E1753;
	Wed, 23 Jul 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5bjfTlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14BEEDE;
	Wed, 23 Jul 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271528; cv=none; b=mt/R2Bd+/vs1YW4ZDMh2/sOsB4QeNKac767IOXfsrF3UKFratmu+l1jd/k9fuEfq7Z8LDumqYTpRN4JRbJHPG/9YQjiIcgQqOJuyVRoC94iEUnZXLB9Riil6l78tft9tyf1FKzJsFL6gdgDYKCHCnQf5celpr+FNpS+tiEFvpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271528; c=relaxed/simple;
	bh=O7/ckzQ9g2gjIzBpwJR7Jp6tkNdCV/dJsJTjbGShgiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcza78ZF9a6IDoBDPXWRZeB12sfaN21zXNMw4LAA/CC+XOhVx5Bt5n1CdXbki7Mspm+CCtp6phn9Ecid/uakpN7FwPiMfomE/ya4o0uLiG9VcVWvC92KiV7tkEXI+XxXoYJYatECvYj7EF3WJBVS6cbGZyMMH5e7HQYUItaOHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5bjfTlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30133C4CEE7;
	Wed, 23 Jul 2025 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753271525;
	bh=O7/ckzQ9g2gjIzBpwJR7Jp6tkNdCV/dJsJTjbGShgiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5bjfTlwEtBMo82Pt2dNQB/AP5xZAtqeAbaY/EL7MiRp9HosH70tJTTIeNIjBa21p
	 yImNDgSoOn24N/OWetneE6JCNHSnPTi3HdQFUPeU+mEe8pX90btZMxvH+bsgCk5ISn
	 G9VtTXpLH8N9I859yYqrLBicsbkaqA/qI3pkBiLyuAie4Z4fli9SwKWV5YdN5H3L/i
	 3xSXUjyyrZNHWyigML7Evx4QirGCbmneGdhHLMWI6twb1phUFf3WE3DkzJA/sjOcHk
	 cReFjx0655YHag2Yk1U08xO1sd1ZZOVSeujJArSHnnQkJF9UDbMM8st2xKL7Yu9Duw
	 vuM2ZeRy2vQwQ==
Date: Wed, 23 Jul 2025 13:51:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: fix delegated timestamp handling in
 setattr_copy()
Message-ID: <20250723-belegen-alteingesessen-a33f060146f4@brauner>
References: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
 <20250722-nfsd-testing-v1-2-31321c7fc97f@kernel.org>
 <e28297a2abe8253c0aa590831b3857432bef60f7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e28297a2abe8253c0aa590831b3857432bef60f7.camel@kernel.org>

> Based on Trond's comments in this thread, I think I'm going to have to
> respin this:
> 
> https://lore.kernel.org/linux-nfs/bfa20f4a81e0c2d5df8525476fb29af156f4f5f1.camel@kernel.org/
> 
> I'll post a v2 in the near future.

It's v6.8 material anyway so no rush. :)

