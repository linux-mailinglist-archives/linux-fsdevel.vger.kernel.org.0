Return-Path: <linux-fsdevel+bounces-51075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BCAD2990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 00:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598FA16FDBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF99226533;
	Mon,  9 Jun 2025 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmE3Q8Oo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C04225788;
	Mon,  9 Jun 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509198; cv=none; b=j9HASQnamQmXUT04inFu4OyKA3IgYJorgkl/y4AHzz9WbJP0J7v/0cB0D6r7/voYT46NkqoZ89dT+K+xlV7eWnnUL5s6YuSOr04aifO6e2fyhQmisd2+vC3WlCHxcjel76pniiz+EqGwPkvlvnT6bWEplm0kBbffvjddS4KtOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509198; c=relaxed/simple;
	bh=nJj12iQ8vhZRCjp76lVlJ10BcU6g8lFx42piFMF5C7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6C3i3Zk5SfCZacybBp7Cv3DzuKB/NA+DUhDHluYydMJfHL0yf4xroe9Pp7oDTU52iu+O1WPA60chAxtrHaW17pUjC1/4WUc/dc2/qHx6XDcelZ0TSRbjJuIrTIt1byYAt9iz47aMrzz//G9LoXPJ/4GgIkqbZGzx4YAPOxT/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmE3Q8Oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0ADC4CEEB;
	Mon,  9 Jun 2025 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749509198;
	bh=nJj12iQ8vhZRCjp76lVlJ10BcU6g8lFx42piFMF5C7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NmE3Q8Oo30TpdYeAMa7SpaIKWQTOtsnMDk054gK/fIuyHOZV2Q6u79WnxwFuPgFor
	 nR8ILY2F/TAyvVXGaMhuPQ2+n9/8AxWYApXmeZgC0x/5cKKWEhMGBjF6461Dz+Q+H8
	 Zxcm4dwJwFI11BXo1ENe+ImELyFsSbKTP9oXLXLTYEIrYHws0LEWFI/xxdSmRODuBj
	 gkajEQJlYimIaEJ31S/L26WA0/b/NswApRiBjKvOwtHJX6R3yez3XyqJODXRV/nESj
	 Sikasz1BavVo3vv3g4GZmzZZX91gZlAXLNoaez/osDkL7GgiNbyjcVEPbly8K3Y/g2
	 uC9KGCGx5Ho0w==
Date: Mon, 9 Jun 2025 15:46:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 2/3] netns: use stable inode number for initial mount ns
Message-ID: <20250609154637.06f27fde@kernel.org>
In-Reply-To: <20250606-work-nsfs-v1-2-b8749c9a8844@kernel.org>
References: <20250606-work-nsfs-v1-0-b8749c9a8844@kernel.org>
	<20250606-work-nsfs-v1-2-b8749c9a8844@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Jun 2025 11:45:08 +0200 Christian Brauner wrote:
> Apart from the network and mount namespace all other namespaces expose a
> stable inode number and userspace has been relying on that for a very
> long time now. It's very much heavily used API. Align the network
> namespace and use a stable inode number from the reserved procfs inode
> number space so this is consistent across all namespaces.

Nice!

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

