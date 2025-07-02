Return-Path: <linux-fsdevel+bounces-53600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E972AF0E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D11C25A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859E238172;
	Wed,  2 Jul 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss6ekJwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDE38F91;
	Wed,  2 Jul 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445172; cv=none; b=hv1nacZa8sgX8hqrracLQtZ447pVIQ5SAfHUnUAba8U66UF+iMFUlSN2rJN2/8Ho6V2UH7sQ1wJJDIugelooRyANIg90TR7aabAzK29kzGwZZ+KTXN3ajs2usZMU+fpDzUYQR85piYI0Yah9SsQc3Qo9HPiOQtade8o2jTUAixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445172; c=relaxed/simple;
	bh=4RTJx4587n6+0xLYAkHUooLJMs4vKlzr++2BIgNKOl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp7HhdkeLXA71v8ga2R5o5jC/hKRln30d10oPSavaJa8BjzmJKrhpVaKvfTAIDdNdZ7dyYaa9Tmev+aydqcYUfOLrwjx7Xc1u4Cc+IcraIGDhymENvvwjzVgef0E31P4g/ph/wCsDH8gB7xdyRVEUNN1QH3qkDqByXbrbVcXTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss6ekJwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8F6C4CEED;
	Wed,  2 Jul 2025 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751445171;
	bh=4RTJx4587n6+0xLYAkHUooLJMs4vKlzr++2BIgNKOl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss6ekJwH+Y4T70/Txa7py3K8953c3mAOe55N+1t6N9NGb1ql+7yxiElA7p2ZTorNN
	 ADBVFbMEYlpwzvcJ+b48CqGbxaC+5JaZQGl+pi1mcnsgFWniOOIesgKD8gpBqXJVY4
	 l8LTeh4nJignbcewIP4pWLXBHNp7hG9I8H3wUgwpXZAtf9UVErBIHUhQVlF1h1AW/T
	 OCcyw7wwjM1VtbI0T6AzySstzUn2R7lzNtAIDMOfkz4VKnPtU7ki6BGKOiNx1238mP
	 v5Sr3rY6aZepjDXoQUfoISpszeKnQtSiw4CdMF9bw1R/xBBXtKi9U6E/1JB5mMSmN1
	 dBt7sv+kog9Kg==
Date: Wed, 2 Jul 2025 10:32:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: don't call fsopen() as
 privileged user
Message-ID: <20250702-liberal-leerung-f2a973398c3e@brauner>
References: <20250701183123.31781-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701183123.31781-1-technoboy85@gmail.com>

On Tue, Jul 01, 2025 at 08:31:23PM +0200, Matteo Croce wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> In the BPF token example, the fsopen() syscall is called as privileged
> user. This is unneeded because fsopen() can be called also as
> unprivileged user from the user namespace.
> As the `fs_fd` file descriptor which was sent back and fort is still the
> same, keep it open instead of cloning and closing it twice via SCM_RIGHTS.
> 
> cfr. https://github.com/systemd/systemd/pull/36134
> 
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---

Thanks!
Acked-by: Christian Brauner <brauner@kernel.org>

