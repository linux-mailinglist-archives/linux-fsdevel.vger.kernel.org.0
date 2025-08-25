Return-Path: <linux-fsdevel+bounces-59052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07432B34048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7BC178736
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E21F4179;
	Mon, 25 Aug 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isxDwpO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26031E9B1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126955; cv=none; b=gBn2A4Zghg7vrlOO5f7YeZ1ilkNt2ziCSo4JsXc8WjE3KDXH7QMovVCCPz8HTP3Q73eklXByQ0k9ZdKQuVZxiFmHlL1lH99odKhYVuzwsJLDmMZLYEk71It1YVCCLFKZJ7IsiKxst9ECOv5CPgT40LKvnbYO0DdsnaBXuZEVrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126955; c=relaxed/simple;
	bh=RMRbQYOyVLEGaZgC9YdgMa5efeNcXbTLEBts3PnKtQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+bnz8Sk2KPwi/6eNnGd+8BsmapuMhH1MejfTlUg/PEmFC0SYHGYwYMBtlaQbQYZ+PDor1hamAmZFo08FcE1k9JqSrqpB6nu+otSB7gvDHg0dLAUm8Uin7SMjaX8SP5nIGbYAJpxxuoRZdlDs6B3YupZfLZyQua1lS5pFrCm1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isxDwpO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEAEC4CEF4;
	Mon, 25 Aug 2025 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126953;
	bh=RMRbQYOyVLEGaZgC9YdgMa5efeNcXbTLEBts3PnKtQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isxDwpO1aPVyO3zWPiPYjHRKOyrkxX5Ln4BbRQvKSj0uQsPafbb1aH5YYThFnOXuH
	 E/eLFXhxXjIiQlGb9kk551/gfx0dNJhcVpy+nTJn/42x+EttCYbByF9ibHufVvReDH
	 1LMlVVVlc8n7J8SFE63R8ppO6bsjJ73bUDQkaq9EO9ozYcmlNYOQ7n2TfkeLET4j76
	 64ZIGXgJQ9c5ZzacjeNLkET9P8kbj/0WUxEpkEyAqbLFAMHmLdGxdhFec+egxJ9Rne
	 1/ow6m4fGhuePHkLL9gX9bJ2j9B/JNsWs/7up0ZqtfjcwvWai5E0AffWi0Pia7IMtc
	 tsrFE4U90UsyQ==
Date: Mon, 25 Aug 2025 15:02:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 21/52] finish_automount(): simplify the ELOOP check
Message-ID: <20250825-erbeuten-heilpflanzen-eb20de596180@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-21-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:24AM +0100, Al Viro wrote:
> It's enough to check that dentries match; if path->dentry is equal to
> m->mnt_root, superblocks will match as well.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

