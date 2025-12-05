Return-Path: <linux-fsdevel+bounces-70908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D59CA912C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEEEA303AFD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDD2D6E62;
	Fri,  5 Dec 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUT6F1gJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659181C8611;
	Fri,  5 Dec 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764962958; cv=none; b=m1igupy0ypGxGKgQcjbtCJh9A3tv9CppFi0zkrhfA0rXE+TZpXHKLCzD4bfYWlosOPaqV0jKC+m1fpboCKDAzVXjuIJzA/e8/9U+Z6kHt7Ctv0+NY5U20VjlCjwdK6NTEPzMGrGqVW6O0OJnKuAASzngCMS4Bb/VTQrn4P5IeH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764962958; c=relaxed/simple;
	bh=yAKI7L9nIomT9yX9Aj9EDG2tQM9MN49Q7Ia4T/TLeBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQBLAnKgaIwWvbGbEXfBrYVLVpjWdOty24iHXcyEqpigaMTOAzod13XGUcwtgUuCzMvZaJHCuHPmWReTATckBPyLOvKaPFSeI7XlSPTnvllAvuYF4kfIH2ve9LIaNmNpbOyP6GQvtplDaIwlHhuAnGTy5DDc4pAbYhKOg5sXLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUT6F1gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03951C116D0;
	Fri,  5 Dec 2025 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764962958;
	bh=yAKI7L9nIomT9yX9Aj9EDG2tQM9MN49Q7Ia4T/TLeBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XUT6F1gJx2FS2P9f0FOaYtAfyg1NZ7ROaxVDQNwgcyIi3q7HBVZZIKuRR1g4y5j2U
	 b8kSN1bbNeCCGNaa7B2qBqVNDKV4gxlaJPZEQI/YTZUsxi3qDJKJLNke4jyUp8gDEw
	 EZ7zLO+bShyu4425MnAY+EQsz/NPgGZJXqcs+vY+3c0HXKhiGKq/QB95H2Bbs1+dYP
	 W3Q6fbPvPh+0GBcV54Qx0MHmeN5Qj1eczSSew5b9+n61FPLGf9d0RjOMPIustdlc1k
	 qmz9iVHu7Qa71tvFUCVFElhf5lgwZjuMqFnS63L27ILicLzG1i3TiyAnMSasuqjT2e
	 f82YJeAxvykfg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, hch@infradead.org, jlbec@evilplan.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
 kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
In-Reply-To: <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
Date: Fri, 05 Dec 2025 20:29:04 +0100
Message-ID: <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Breno Leitao" <leitao@debian.org> writes:

> Hello Andreas,
>
> On Fri, Dec 05, 2025 at 06:35:12PM +0100, Andreas Hindborg wrote:
>> "Breno Leitao" <leitao@debian.org> writes:
>>
>> > This series introduces a new kernel-space item registration API for configfs
>> > to enable subsystems to programmatically create configfs items whose lifecycle
>> > is controlled by the kernel rather than userspace.
>> >
>> > Currently, configfs items can only be created via userspace mkdir operations,
>> > which limits their utility for kernel-driven configuration scenarios such as
>> > boot parameters or hardware auto-detection.
>>
>> I thought sysfs would handle this kind of scenarios?
>
> sysfs has gaps as well, to manage user-create items.
>
> Netconsole has two types of "targets". Those created dynamically
> (CONFIG_NETCONSOLE_DYNAMIC), where user can create and remove as many
> targets as it needs, and netconsole would send to it. This fits very
> well in configfs.
>
>   mkdir /sys/kernel/config/netconsole/mytarget
>   .. manage the target using configfs items/files
>   rmdir /sys/kernel/config/netconsole/mytarget
>
> This is a perfect fit for configfs, and I don't see how it would work
> with sysfs.

Right, these go in configfs, we are on the same page about that.

>
> On top of that, there are netconsole targets that are coming from
> cmdline (basically to cover while userspace is not initialized). These
> are coming from cmdline and its life-cycle is managed by the kernel.
> I.e, the kernel knows about them, and wants to expose it to the user
> (which can even disable them later). This is the problem I this patch
> addresses (exposing them easily).

I wonder if these entries could be exposed via sysfs? You could create
the same directory structure as you have in configfs for the user
created devices, so the only thing user space has to do is to point at a
different directory.


Best regards,
Andreas Hindborg




