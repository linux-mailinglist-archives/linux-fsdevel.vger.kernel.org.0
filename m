Return-Path: <linux-fsdevel+bounces-70848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FBCA8A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8013130271AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97F2EFD91;
	Fri,  5 Dec 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf4sVbQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A427A12B;
	Fri,  5 Dec 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956123; cv=none; b=VzpGU9mmYIxU7uY0XdNi/OlIF0n9OjaqbLXB5hvrxn98oEF7qUQM/2FxP7uSTHUqqjfCEqas71LFA4sL5AtckGrIw5ae2jxGaN/53pnMItqspjLrAFA79JFWj3Ff+kkFOE10XekJpzVpQT7nk7QQVuOSqulwpxq2uGPQb/fEVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956123; c=relaxed/simple;
	bh=KBwv35ZiZzmA/TBC+DiHjsYyM9bT9Qc4AUweZJdoxyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMG4VJZ1YXs0d9yIW/koDfyEpzB4vTXsMdTHFojXYa49bXIW7oxDJZDnN2Z7oAYzRdvLod4v8fH/OJnh5GKjbDsTgNk0XeThotZGmumY70z9WZNVqjR/T2LPjmcFhikwr0wseDqgg5pIbjxAAtYnF0D+Twddv8KdxKf2c6ftvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf4sVbQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF73C4CEF1;
	Fri,  5 Dec 2025 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764956122;
	bh=KBwv35ZiZzmA/TBC+DiHjsYyM9bT9Qc4AUweZJdoxyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xf4sVbQ0+OusAWDbm5bONIY5FlQL0aVKbDavqNsKVTUeZhKEPgCyF6w6amEJsTELu
	 UOX/inp3ye/FfP0cHSKDcCCtlTsJGt9wRekF8LMP7ABZCK+jNlNkDncBOnpRr5p5Jg
	 Ysin8P8JBEJhfp8gzgjCQEKasdTTOzxkQuWACy0pyUIlTyPrrPqaHJT3FU+PVjQEaq
	 695iD2KWoQQFWiwUTTdCCyGEuNrWji/C6L2xYomfwsQx21pJacv6YleYTZCg7RFxtL
	 Td/uTBdxINj0wt9bvn8abKyRAOmMzelbO0yt1o+BbMSxSxTnSToxj6Po8BRMwWeo2D
	 rqphrHpHBLbZQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com,
 calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
In-Reply-To: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
Date: Fri, 05 Dec 2025 18:35:12 +0100
Message-ID: <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Breno Leitao" <leitao@debian.org> writes:

> This series introduces a new kernel-space item registration API for configfs
> to enable subsystems to programmatically create configfs items whose lifecycle
> is controlled by the kernel rather than userspace.
>
> Currently, configfs items can only be created via userspace mkdir operations,
> which limits their utility for kernel-driven configuration scenarios such as
> boot parameters or hardware auto-detection.

I thought sysfs would handle this kind of scenarios?


Best regards,
Andreas Hindborg




