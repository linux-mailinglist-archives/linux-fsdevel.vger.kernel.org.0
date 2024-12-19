Return-Path: <linux-fsdevel+bounces-37835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974D9F8198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334D016F5A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793461A42A5;
	Thu, 19 Dec 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pPptSqYd";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xWBtlMme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BC19DFA5;
	Thu, 19 Dec 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628477; cv=none; b=RooQgnxX1e7NyOf+t2Dq+0oZ4j5A+Cz+fGbLBp6cfTwtcgc58oRk3BLwa/AEaK5sD6oOVnWgoCINb7XpAbEJgCYfpFD7QfppCa5qH0OPWTrfuwyVswAEDWeD8d4reX6q5YeFIw76hrQRhg57LqsFZ5KVSmbN/LHeyaXNUwsRiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628477; c=relaxed/simple;
	bh=mvSUgxWzg4ua88OO42ymyaWrC9482DQkJDq/AzwCXik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kSaZO5b9YOzxhJZdP3KJQrAjAf86lBlSWjYVv2WPDRaaegA6VN94/FkNVK5+j/KoaFjwQkoYoMgDaLACjePK5Dnv14hlkg39DkA1CYtBlVnUNqCgaZ8+2LH3apbaE3kNaCBXRbsWrrzHUWIeuF85oG6ntTG5hkD+U2K2TwWoxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pPptSqYd; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xWBtlMme; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734628475;
	bh=mvSUgxWzg4ua88OO42ymyaWrC9482DQkJDq/AzwCXik=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pPptSqYd8t7ClnbAMKRoMhTiBFhVQQzwEiKuGWlEKJXUt3kmNVGIioOmiIY+8cUB8
	 yGuWSrnKGWroP7DTrNZqLdJNzrMvEcIs8gTZtH9yIa0S0Woslcd+DjKxuj8QFWLf3J
	 pPkWhPCL6ncIzTh6agI7iwnk7ZJYnUliH79Vwk+g=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0CB7F1280C50;
	Thu, 19 Dec 2024 12:14:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id i2GyJq7_JHCq; Thu, 19 Dec 2024 12:14:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734628474;
	bh=mvSUgxWzg4ua88OO42ymyaWrC9482DQkJDq/AzwCXik=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xWBtlMmecNqCM0ZvGlK2UAQc7UDbt0fEh56RxSA+Gu+TO4UuGYGWQSTOjFodohPvb
	 NcZUe5GWPU/1MGTsWqSkN4kNVzQRGVGBkyepBXNc6Li8d+w/RzjBWWOwP/o0kdJrt2
	 9a2TKr0b5MvaYutz4vEVbHt3fim2AlEyL1rn5atM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1565412804E8;
	Thu, 19 Dec 2024 12:14:34 -0500 (EST)
Message-ID: <6e09c8a812a85cb96a75391abcc48bee3b2824e9.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian
	Brauner <christian@brauner.io>, Lennart Poettering <mzxreary@0pointer.de>
Date: Thu, 19 Dec 2024 12:14:32 -0500
In-Reply-To: <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-12-10 at 12:02 -0500, James Bottomley wrote:
> Even though this fixes the bug that a create either not followed by a
> write or followed by a write that errored would leave a remnant file
> for the variable, the file will appear momentarily globally visible
> until the close of the fd deletes it.  This is safe because the
> normal filesystem operations will mediate any races; however, it is
> still possible for a directory listing at that instant between create
> and close contain a variable that doesn't exist in the EFI table.

Systemd doesn't like 0 length files appearing in efivarfs, even if only
momentarily, so I think this needs updating to prevent even momentary
instances of zero length files:

https://github.com/systemd/systemd/issues/34304

These occur for two reasons

   1. The system has hibernated and resumed and the dcache entries are
      now out of sync with the original variables
   2. between the create and a successful write of a variable being
      created in efivarfs

1. can only really be fixed by adding a hibernation hook to the
filesystem code, which would be a separate patch set (which I'll work
on after we get this upstream); but 2. can be fixed by ensuring that
all variables returned from .create aren't visible in the directory
listing until a successful write.

Since we need the file to be visible to lookups but not the directory,
the only two ways of doing this are either to mark the directory in a
way that libfs.c:dcache_readdir() won't see it ... I think this would
have to be marking it as a cursor (we'd remove the cursor mark on
successful write); or to implement our own .iterate_shared function and
hijack the actor to skip newly created files (this is similar to what
overlayfs does to merge directories) which would be identified as
having zero size.

Do the fs people have a preference? The cursor mark is simpler to
implement but depends on internal libfs.c magic. The actor hijack is at
least something that already exists, so would be less prone to breaking
due to internal changes.

Regards,

James




