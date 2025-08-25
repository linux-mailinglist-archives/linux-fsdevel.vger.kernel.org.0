Return-Path: <linux-fsdevel+bounces-59061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567CBB340B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98AA168F72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8827932E;
	Mon, 25 Aug 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEkVzu6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F35277011
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128607; cv=none; b=THMJxGrkNRjBtx8R4mPXvvUrF6Lb0gyAXbWNGu8VcSC7kApGaXS7MFKQqO1U/S/vg9i7mX7OAIV/QjyFBe7iecqHFiscbHfXKCJXEu5nPOcC+dyoNv+zMeIFKh09P7kHR/Cll/3XhzhBXJjk6/TYsg2crvoKzC2vUBzuUcn4IzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128607; c=relaxed/simple;
	bh=L02IoeVfMlLhTb3MR/cZ/pTP72yda1+OCzWLmxcHQjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PccpHSGqkFkDzofNSe2JipIXmjt+rl/x6ExWgVWVWgHb/no7XUmJwIHbuY+6Lk/4jKYKmKHkIBPz4kDoFw/jHDeW/4uTjM7WWaBdm55Y+vExgwO5i3QgLWEg9Ptpb9FsM/G/1r2rzwCGYqyPfqb7GuWOL+3VpnuKZGQOkgJompM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEkVzu6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F2EC4CEED;
	Mon, 25 Aug 2025 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128607;
	bh=L02IoeVfMlLhTb3MR/cZ/pTP72yda1+OCzWLmxcHQjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEkVzu6Gx2/KT3GigRvh/s7/hvTpIWzaGFDi8noLH3pCCGXKJjZ53fy2XpWYulDG3
	 HOIVySzSpuay6Bz64puKDkdz2+3tGLKeP0Xn1c7dmQ6ODmO380VgJuVGr7PpAuQcIA
	 BnIPC3h779tPC+/Nxr3bzhm7bVB80jRQP+LLitFIshEUl4DSqHMmzWo8e/XEyBZkqR
	 y5Az+b1FYVPHdpSU9weHuXyRu5w6PQkmM97TFxi1aDqGbqGcaujlHxnHRw4UgJrXU6
	 +AEg/IsRwiK9cS8Mx8x25RMIMM8blTUsyBP0WY4rUXBAiZ6i/6JJyGaSm/+cAZAZgT
	 9S8nAi9B91KEQ==
Date: Mon, 25 Aug 2025 15:30:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 39/52] collect_paths(): constify the return value
Message-ID: <20250825-pumpen-einhundert-6866b053a936@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-39-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-39-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:42AM +0100, Al Viro wrote:
> callers have no business modifying the paths they get
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

